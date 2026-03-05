ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: "Dashboard" do
    panel "Welcome" do
      para "Welcome to the Simple CRM Admin Dashboard."
    end

    panel "Customer Statistics" do
      para "Total Customers: #{Customer.count}"
    end
  end
end