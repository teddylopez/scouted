defmodule Scouted.Details do
  use Ecto.Schema

  import Ecto.Changeset

  @required [:summary, :position]
  @attributes @required
  @primary_key false

  embedded_schema do
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
    |> validate_required([])
  end
end
