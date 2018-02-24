class CreateDebtors < ActiveRecord::Migration[5.1]
  def change
    create_table :debtors do |t|
      t.string :system_id
      t.string :customer_number
      t.string :gender
      t.string :first_name
      t.string :last_name
      #t.integer :academic_title
      #t.integer :academic_title_2
      t.string :iso_code_language
      t.string :iso_code_communication_language
      t.string :iso_code_address_country
      t.string :zip
      t.string :city
      t.string :street
      t.string :house_number
      #t.string :second_adress_line
      t.string :phone_number
      t.string :mobile_phone_number
      t.string :email_address

      t.timestamps
    end
  end
end
