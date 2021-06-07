defmodule Scouted.Details do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :report_type
    field :summary
    field :position
    field :pitcher_role
    field :time_to_first
    field :fastball_min_velo
    field :fastball_max_velo
    field :sinker_min_velo
    field :sinker_max_velo
    field :slider_min_velo
    field :slider_max_velo
    field :curveball_min_velo
    field :curveball_max_velo
    field :changeup_min_velo
    field :changeup_max_velo
    field :other_name
    field :other_min_velo
    field :other_max_velo
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :report_type,
      :summary,
      :position,
      :pitcher_role,
      :time_to_first,
      :fastball_min_velo,
      :fastball_max_velo,
      :sinker_min_velo,
      :sinker_max_velo,
      :sinker_max_velo,
      :slider_min_velo,
      :slider_max_velo,
      :curveball_min_velo,
      :curveball_max_velo,
      :changeup_min_velo,
      :changeup_max_velo,
      :other_name,
      :other_min_velo,
      :other_max_velo
    ])
    |> validate_required([:summary])
    |> validate_length(:summary, min: 50)
    |> validate_position()
    |> validate_pitcher_role()
    |> validate_time_to_first()
    |> validate_pitches()
  end

  defp validate_position(changeset) do
    report_type = get_field(changeset, :report_type)

    case report_type do
      "1" ->
        case get_field(changeset, :position) == nil do
          true -> add_error(changeset, :position, "can't be blank")
          false -> changeset
        end

      _ ->
        changeset
    end
  end

  defp validate_pitcher_role(changeset) do
    report_type = get_field(changeset, :report_type)

    case report_type do
      "0" ->
        case get_field(changeset, :pitcher_role) == nil do
          true -> add_error(changeset, :pitcher_role, "can't be blank")
          false -> changeset
        end

      _ ->
        changeset
    end
  end

  defp validate_time_to_first(changeset) do
    report_type = get_field(changeset, :report_type)

    case report_type do
      "1" ->
        case get_field(changeset, :time_to_first) == nil do
          true -> add_error(changeset, :time_to_first, "can't be blank")
          false -> validate_time_to_first_range(:time_to_first, changeset)
        end

      _ ->
        changeset
    end
  end

  defp validate_time_to_first_range(time, changeset) do
    {float, _} = Float.parse(get_field(changeset, time))

    case float < 10.0 and float > 0.0 do
      true -> changeset
      false -> add_error(changeset, time, "must be between 0 and 10")
    end
  end

  defp validate_pitches(changeset) do
    changeset
    |> validate_min("fastball")
    |> validate_max("fastball")
    |> validate_min("sinker")
    |> validate_max("sinker")
    |> validate_min("changeup")
    |> validate_max("changeup")
    |> validate_min("slider")
    |> validate_max("slider")
    |> validate_min("curveball")
    |> validate_max("curveball")
    |> validate_other
  end

  defp validate_min(changeset, pitch) do
    min = "#{pitch}_min_velo" |> String.to_atom()
    max = "#{pitch}_max_velo" |> String.to_atom()

    case get_field(changeset, min) != nil do
      true ->
        case get_field(changeset, max) == nil do
          true ->
            add_error(changeset, max, "can't be blank")

          false ->
            changeset
        end

      false ->
        changeset
    end
  end

  defp validate_max(changeset, pitch) do
    min = "#{pitch}_min_velo" |> String.to_atom()
    max = "#{pitch}_max_velo" |> String.to_atom()

    case get_field(changeset, max) != nil do
      true ->
        case get_field(changeset, min) == nil do
          true ->
            add_error(changeset, min, "can't be blank")

          false ->
            changeset
        end

      false ->
        changeset
    end
  end

  defp validate_other(changeset) do
    min = get_field(changeset, :other_min_velo)
    max = get_field(changeset, :other_max_velo)
    name = get_field(changeset, :other_name)

    case name == nil and (min != nil or max != nil) do
      true ->
        add_error(changeset, :other_name, "can't be blank")
        |> validate_min("other")
        |> validate_max("other")

      false ->
        changeset
        |> validate_min("other")
        |> validate_max("other")
    end

    case name != nil and (min == nil or max == nil) do
      true ->
        add_error(changeset, :other_min_velo, "can't be blank")
        add_error(changeset, :other_max_velo, "can't be blank")

      false ->
        changeset
        |> validate_min("other")
        |> validate_max("other")
    end

    case name != nil and (min == nil and max == nil) do
      true ->
        add_error(changeset, :other_min_velo, "can't be blank")
        add_error(changeset, :other_max_velo, "can't be blank")

      false ->
        changeset
        |> validate_min("other")
        |> validate_max("other")
    end

    case name == nil and (min != nil or max != nil) do
      true ->
        add_error(changeset, :other_name, "can't be blank")

      false ->
        changeset
        |> validate_min("other")
        |> validate_max("other")
    end
  end
end
