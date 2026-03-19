ActiveAdmin.register Customer do
  permit_params :full_name, :email_address, :phone_number, :notes, :image

  remove_filter :image_attachment, :image_blob
  filter :full_name
  filter :email_address
  filter :phone_number
  filter :notes
  filter :created_at

  index do
    selectable_column
    id_column
    column :image do |customer|
      if customer.image.attached?
        image_tag url_for(customer.image), alt: customer.full_name, style: "max-width: 80px; max-height: 80px;"
      else
        status_tag "No image"
      end
    end
    column :full_name
    column :email_address
    column :phone_number
    column :notes
    actions
  end

  form html: { multipart: true } do |f|
    f.semantic_errors(*f.object.errors.attribute_names)

    f.inputs do
      f.input :full_name
      f.input :email_address
      f.input :phone_number
      f.input :notes
      f.input :image,
              as: :file,
              hint: (
                if f.object.image.attached?
                  image_tag(url_for(f.object.image), alt: f.object.full_name, style: "max-width: 180px; max-height: 180px;")
                else
                  content_tag(:span, "No image uploaded")
                end
              )
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :image do |customer|
        if customer.image.attached?
          image_tag url_for(customer.image), alt: customer.full_name, style: "max-width: 240px; max-height: 240px;"
        else
          "No image uploaded"
        end
      end
      row :full_name
      row :email_address
      row :phone_number
      row :notes
      row :created_at
      row :updated_at
    end
  end
end
