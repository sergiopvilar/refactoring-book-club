require 'minitest/autorun'
require "pry"

# Average revenue per Rep per Region

class SalesReport
  SALES = [
    { rep: "Jamie", region: "North East", revenue: "80_000" },
    { rep: "Jamie", region: "Midwest", revenue: "80_000" },
    { rep: "Sam", region: "North East", revenue: "50_000" },
    { rep: "Charlie", region: "Midwest", revenue: "90_000" },
    { rep: "Sam", region: "North East", revenue: "10_000" },
  ]

  def run
    regional_revenue = Hash.new(0)
    for rep in SALES
      regional_revenue[rep.fetch(:region)] += rep.fetch(:revenue).to_i
    end

    regional_revenue
  end

  def average
    rep_revenue = {}

    for rep in SALES
      rep_revenue[rep.fetch(:rep)] ||= {}
      rep_revenue[rep.fetch(:rep)][rep.fetch(:region)] ||= []
      rep_revenue[rep.fetch(:rep)][rep.fetch(:region)].push(rep.fetch(:revenue).to_i)
    end

    rep_revenue.each do |rep, region|
      region.each do |region, revenue|
        rep_revenue[rep][region] = revenue.sum / revenue.size
      end
    end

    rep_revenue
  end
end

class SalesReportTest < Minitest::Test
  def test_run
    expected = {"North East"=>140000, "Midwest"=>170000}
    actual = SalesReport.new.run

    assert_equal expected, actual
  end

  def test_something
    expected = {
      "Jamie" => { "North East" => 80000, "Midwest" => 80000 },
      "Sam" => { "North East" =>30000 },
      "Charlie" => { "Midwest" => 90000 },
    }
    actual = SalesReport.new.average

    assert_equal expected, actual
  end
end
