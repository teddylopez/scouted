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

      {:report_type, %{report_type: report_type}}, query ->
        case report_type do
          "all" -> query
          %{} -> query
          0 -> from q in query, where: q.report_type == 0
          1 -> from q in query, where: q.report_type == 1
          nil -> query
        end

      {:author_id, %{author_id: author_id}}, query ->
        case author_id do
          "all" ->
            query

          author_id ->
            from q in query, where: q.user_id == ^author_id
        end
    end)
    |> Repo.all()
  end

  def count_reports do
    Repo.aggregate(ScoutingReport, :count, :id)
  end

  def count_reports(options) do
    author_id = Map.get(options, :author_id)
    report_type = Map.get(options, :report_type)

    case report_type do
      0 ->
        case author_id do
          "all" ->
            query =
              from scouting_report in ScoutingReport,
                where: scouting_report.report_type == 0

            Repo.aggregate(query, :count, :id)

          author_id ->
            get_report_types_from_author(author_id, 0)
        end

      1 ->
        case author_id do
          "all" ->
            query =
              from scouting_report in ScoutingReport,
                where: scouting_report.report_type == 1

            Repo.aggregate(query, :count, :id)

          author_id ->
            get_report_types_from_author(author_id, 0)
        end

      _ ->
        case author_id do
          "all" ->
            Repo.aggregate(ScoutingReport, :count, :id)

          author_id ->
            query =
              from scouting_report in ScoutingReport,
                join: u in User,
                on: scouting_report.user_id == u.id,
                where: scouting_report.user_id == ^author_id

            Repo.aggregate(query, :count, :id)
        end
    end
  end

  def get_report_types_from_author(author_id, report_type) do
    author_id = String.to_integer(author_id)

    query =
      from scouting_report in ScoutingReport,
        join: u in User,
        on: scouting_report.user_id == u.id,
        where:
          scouting_report.report_type == ^report_type and scouting_report.user_id == ^author_id

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
