
Pod::Spec.new do |s|

  s.name         = "CBPolygonView.podpec"
  s.version      = "0.0.1"
  s.summary      = "能力分布图 蜘蛛网图"
  s.description  = <<-DESC
                            CBPolygonView 用于绘制能力分布图 蜘蛛网图
                    DESC
  s.homepage     = "https://github.com/ChenBiaoHub/CBPolygonView"
  s.license      = "MIT"
  s.author             = { "ChenBiaoHub" => "chenbiao9494@163.com" }
  s.platform = :ios, "8.0"
  s.source       = { :git => "https://github.com/ChenBiaoHub/CBPolygonView.git", :tag => "0.0.1"}
  s.source_files  = "CBPolygonView/CBPolygonView.swift"
  s.framework = 'UIKit'  #依赖的framework
  s.requires_arc = true
end
