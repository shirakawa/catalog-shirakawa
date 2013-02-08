# encoding: utf-8

前提 /^商品管理ページを開いている$/ do
  visit '/products'
end

前提 /^"(.*?)"リンクをクリックする$/ do |link_text|
  click_link link_text
end

もし /^以下の内容で商品名を登録する:$/ do |table|
  product_info = table.hashes[0]
  fill_in 'product_name', with: product_info['商品名']
  fill_in 'product_description', with: product_info['説明']
  fill_in 'product_price', with: product_info['価格']
  click_on 'Save'
end

ならば /^"(.*?)"の商品詳細ページが作成されていること$/ do |product_name|
p Product.where(name: product_name).first
  visit url_for(Product.where(name: product_name).first)
  within 'p.name' do
    page.should have_content(product_name)
  end
end

ならば /^説明が"(.*?)"となっていること$/ do |product_description|
  within 'div.description' do
    page.should have_content(product_description)
  end
end

ならば /^価格が"(.*?)"となっていること$/ do |product_price|
  within 'p.price' do
    page.should have_content(product_price)
  end
end
