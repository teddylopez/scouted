defmodule Scouted.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false
  alias Scouted.Repo

  alias Scouted.Reports.ScoutingReport
  alias Scouted.Accounts.User

  @doc """
  Returns the list of scouting_reports.

  ## Examples

      iex> list_scouting_reports()
      [%ScoutingReport{}, ...]

  """
  def list_scouting_reports do
    Repo.all(from(scouting_report in ScoutingReport))
  end

  def list_scouting_reports(criteria) when is_list(criteria) do
    query =
      from(scouting_report in ScoutingReport,
        join: u in assoc(scouting_report, :user),
        preload: [:player, :user]
      )

    Enum.reduce(criteria, query, fn
      {:paginate, %{page: page, per_page: per_page}}, query ->
        from q in query,
          offset: ^((page - 1) * per_page),
          limit: ^per_page

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]

      {:grade, %{min_grade: min_grade, max_grade: max_grade}}, query ->
        from q in query,
          where: q.grade >= ^min_grade and q.grade <= ^max_grade

      {:position, %{position: position}}, query ->
        case position do
          "all" -> query
          position -> from q in query, where: q.position == ^position
        end

      {:author_id, %{author_id: author_id}}, query ->
        case author_id do
          "all" ->
            query

          author_id ->
            from q in query, where: q.user_id == ^author_id
        end

      {:date, %{earliest: earliest, latest: latest}}, query ->
        %{earliest_naive: earliest_naive, latest_naive: latest_naive} =
          convert_time_string_to_naive(earliest, latest)

        from q in query, where: q.updated_at >= ^earliest_naive and q.updated_at <= ^latest_naive
    end)
    |> Repo.all()
  end

  def count_reports do
    Repo.aggregate(ScoutingReport, :count, :id)
  end

  def count_reports(
        %{position: "all", author_id: "all", earliest: earliest, latest: latest} = options
      ) do
    %{earliest_naive: earliest_naive, latest_naive: latest_naive} =
      convert_time_string_to_naive(earliest, latest)

    query =
      from scouting_report in ScoutingReport,
        where:
          scouting_report.grade <= ^options.max_grade and
            scouting_report.grade >= ^options.min_grade and
            (scouting_report.updated_at >= ^earliest_naive and
               scouting_report.updated_at <= ^latest_naive)

    Repo.aggregate(query, :count, :id)
  end

  def count_reports(
        %{position: position, author_id: "all", earliest: earliest, latest: latest} = options
      ) do
    %{earliest_naive: earliest_naive, latest_naive: latest_naive} =
      convert_time_string_to_naive(earliest, latest)

    query =
      from scouting_report in ScoutingReport,
        where:
          scouting_report.grade <= ^options.max_grade and
            scouting_report.grade >= ^options.min_grade and
            (scouting_report.updated_at >= ^earliest_naive and
               scouting_report.updated_at <= ^latest_naive) and
            scouting_report.position == ^position

    Repo.aggregate(query, :count, :id)
  end

  def count_reports(
        %{position: position, author_id: author_id, earliest: earliest, latest: latest} = options
      ) do
    %{earliest_naive: earliest_naive, latest_naive: latest_naive} =
      convert_time_string_to_naive(earliest, latest)

    get_position_reports_from_author(
      author_id,
      position,
      options.min_grade,
      options.max_grade,
      earliest_naive,
      latest_naive
    )
  end

  def convert_time_string_to_naive(earliest, latest) do
    {:ok, earliest_naive} = NaiveDateTime.from_iso8601(earliest <> " 00:00:00")
    {:ok, latest_naive} = NaiveDateTime.from_iso8601(latest <> " 23:59:59")
    %{earliest_naive: earliest_naive, latest_naive: latest_naive}
  end

  def get_position_reports_from_author(author_id, "all", min_grade, max_grade, earliest, latest) do
    query =
      from scouting_report in ScoutingReport,
        join: u in User,
        on: scouting_report.user_id == u.id,
        where:
          scouting_report.user_id == ^author_id and
            scouting_report.grade >= ^min_grade and
            scouting_report.grade <= ^max_grade and
            (scouting_report.updated_at >= ^earliest and
               scouting_report.updated_at <= ^latest)

    Repo.aggregate(query, :count, :id)
  end

  def get_position_reports_from_author(
        author_id,
        position,
        min_grade,
        max_grade,
        earliest,
        latest
      ) do
    query =
      from scouting_report in ScoutingReport,
        join: u in User,
        on: scouting_report.user_id == u.id,
        where:
          scouting_report.position == ^position and
            scouting_report.user_id == ^author_id and
            scouting_report.grade >= ^min_grade and
            scouting_report.grade <= ^max_grade and
            (scouting_report.updated_at >= ^earliest and
               scouting_report.updated_at <= ^latest)

    Repo.aggregate(query, :count, :id)
  end

  @doc """
  Gets a single scouting_report.

  Raises `Ecto.NoResultsError` if the Scouting report does not exist.

  ## Examples

      iex> get_scouting_report!(123)
      %ScoutingReport{}

      iex> get_scouting_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scouting_report!(id), do: Repo.get!(ScoutingReport, id)

  @doc """
  Creates a scouting_report.

  ## Examples

      iex> create_scouting_report(%{field: value})
      {:ok, %ScoutingReport{}}

      iex> create_scouting_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scouting_report(attrs \\ %{}) do
    %ScoutingReport{}
    |> ScoutingReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scouting_report.

  ## Examples

      iex> update_scouting_report(scouting_report, %{field: new_value})
      {:ok, %ScoutingReport{}}

      iex> update_scouting_report(scouting_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scouting_report(%ScoutingReport{} = scouting_report, attrs) do
    scouting_report
    |> ScoutingReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scouting_report.

  ## Examples

      iex> delete_scouting_report(scouting_report)
      {:ok, %ScoutingReport{}}

      iex> delete_scouting_report(scouting_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scouting_report(%ScoutingReport{} = scouting_report) do
    Repo.delete(scouting_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scouting_report changes.

  ## Examples

      iex> change_scouting_report(scouting_report)
      %Ecto.Changeset{data: %ScoutingReport{}}

  """
  def change_scouting_report(%ScoutingReport{} = scouting_report, attrs \\ %{}) do
    ScoutingReport.changeset(scouting_report, attrs)
  end
end
