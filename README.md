# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* Ruby version
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin18]

## userテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|integer|null: false ,unique:true|
|encrypted_password|integer|null: false ,unique:true|
|first_name|string|null: false|
|first_name_reading|string|null: false|
|last_name|string|null: false|
|last_name_reading|string|null: false|
|birth_day|date|null: false|

### Association
- has_one :address

## Addressテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|null: false|
|prefecture|string|null: false|
|phone_number|integer|null: false|

### Association
- belongs_to :user

## credit_cardテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|integer|null: false, foreign_key: true|
|card_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user



## itemテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null:false|
|body|string|null:false|
|user_id|reference|foreign_key: true|
|brand_id|reference|foreign_key: true|
|sizer_id|reference|foreign_key: true|
|category_id|reference|foreign_key: true|
|production_option_id|reference|foreign_key: true|
|status|integer|null:false|

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- has_one :product_option
- has_many :images

## imageテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|product_id|reference|foreign_key: true|

## Association

- belogns_to :item

## sizeテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|
|category_id|reference|foreign_key: true|

### Association
- has_many:items


## Categorｙテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|

### Association
- has_many:items
- has_ancestry

## brand_categoryテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|

## Association
- has_many:brand

## brandテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|
##Association
- has_many:items
- belongs_to:brand_group


## production_option
|Column|Type|Options|
|------|----|-------|
|product_id|reference|foreign_key:true|
|condition_id|reference|foreign_key:true|
|delivery_day_id|reference|foreign_key:true|
|delivery_method_id|reference|foreign_key:true|
|delivery_fee_id|reference|foreign_key:true|

## Association

- belongs_to :item
- belongs_to :condition
- belongs_to :delivery_day
- belongs_to :delivery_method
- belongs_to :delivery_fee

## conditionテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|

## Association
- has_many :product_options

## delivery_dayテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|

## Association
- has_many :product_options



## delivery_feeテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|

## Association
- has_many :product_options


## delivery_methodsテーブル
|Column|Type|Options|
|------|----|-------|
|body|string|null: false|

## Assocition
- has_many:product_option


## transactionsテーブル
|Column|Type|Options|
|------|----|-------|
|buyer_id|reference|foreign_key: { to_table: :users }, null: false|
|seller_id|reference|foreign_key: { to_table: :users }, null: false|
|item_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
- belongs_to :seller, class_name: "User", foreign_key: "seller_id"
- belongs_to :items
