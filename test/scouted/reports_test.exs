defmodule Scouted.ReportsTest do
  use Scouted.DataCase

  alias Scouted.Reports

  describe "scouting_reports" do
    alias Scouted.Reports.ScoutingReport

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def scouting_report_fixture(attrs \\ %{}) do
      {:ok, scouting_report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_scouting_report()

      scouting_report
    end

    test "list_scouting_reports/0 returns all scouting_reports" do
      scouting_report = scouting_report_fixture()
      assert Reports.list_scouting_reports() == [scouting_report]
    end

    test "get_scouting_report!/1 returns the scouting_report with given id" do
      scouting_report = scouting_report_fixture()
      assert Reports.get_scouting_report!(scouting_report.id) == scouting_report
    end

    test "create_scouting_report/1 with valid data creates a scouting_report" do
      assert {:ok, %ScoutingReport{} = scouting_report} = Reports.create_scouting_report(@valid_attrs)
    end

    test "create_scouting_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_scouting_report(@invalid_attrs)
    end

    test "update_scouting_report/2 with valid data updates the scouting_report" do
      scouting_report = scouting_report_fixture()
      assert {:ok, %ScoutingReport{} = scouting_report} = Reports.update_scouting_report(scouting_report, @update_attrs)
    end

    test "update_scouting_report/2 with invalid data returns error changeset" do
      scouting_report = scouting_report_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_scouting_report(scouting_report, @invalid_attrs)
      assert scouting_report == Reports.get_scouting_report!(scouting_report.id)
    end

    test "delete_scouting_report/1 deletes the scouting_report" do
      scouting_report = scouting_report_fixture()
      assert {:ok, %ScoutingReport{}} = Reports.delete_scouting_report(scouting_report)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_scouting_report!(scouting_report.id) end
    end

    test "change_scouting_report/1 returns a scouting_report changeset" do
      scouting_report = scouting_report_fixture()
      assert %Ecto.Changeset{} = Reports.change_scouting_report(scouting_report)
    end
  end
end
