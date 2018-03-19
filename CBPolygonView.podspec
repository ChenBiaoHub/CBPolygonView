Pod::Spec.new do |s|
  s.name     = 'CBPolygonView'
  s.version  = '0.0.1'
  s.license  = 'MIT'  #开源协议
  s.summary  = '能力分布图 蜘蛛网图' #简单的描述
  s.description = <<-DESC

                    能力分布图，可以切换布局，线条颜色，虚实线等

                  DESC
  s.homepage = 'https://github.com/ChenBiaoHub/CBPolygonView' #主页

  s.author   = { 'ChenBiaoHub' => 'chenbiao9494@163.com' } #作者
  s.source   = { :git => 'https://github.com/ChenBiaoHub/CBPolygonView.git', :tag => "0.0.1" } #git路径、指定tag号
  s.platform = :ios, '8.0'
  s.source_files = 'CBPolygonView/CBPolygonView.swift'  #库的源代码文件
  s.framework = 'UIKit'  #依赖的framework
  s.requires_arc = true
end
