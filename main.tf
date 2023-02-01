terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "***" # OAuth-токен яндекса
	# не обязательный параметр (берется облако по умолчанию),
	# хотя в документации написано иначе
  cloud_id  = "***"
  folder_id = "***"
  zone      = "ru-central1-a"
}
