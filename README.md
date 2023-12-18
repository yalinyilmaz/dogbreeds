# dogbreeds
Dog Breeds Mobile App

Uygulamayı lokalinize klonladıktan sonra sadece lib, asset ve pubspec.yaml dosyalarını alıp yeni bir Flutter projesi başlatırken o dosyaları da yeni projenizin içine dahil ederek açabilirsiniz. Flutter güncel versiyonunu kullandığınızdan emin olun -- 3.13.8 ve üstü 

Android ve IOS cihazlarında sorunsuz ve istenilen bir şekilde çalışmaktadır.

# kodlar

lib dosyasının içinde bulunan dart kodları bölümü 4 e ayrılmıştır. State management olarak Bloc yapısı kullanıldığından dosyalar bloc, repository, widgets ve ui olucak şekilde main.dart dosyası ile beraber sunulmuştur. Yalnızca dog_api_client.dart dosyasının içinde API dan alınan köpek türü resimlerinin bazıları API dan kaynaklı bir nedenden erişilemediği için getirilememiş olup o görseller yerine farklı görseller kullanılmıştır. Geri kalan görseller Dog API dan alınmıştır.


