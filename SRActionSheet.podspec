
Pod::Spec.new do |s|
  s.name         = "SRActionSheet"
  s.version      = "2.0.0"
  s.summary      = "A brief style ActionSheet which is very similar to WeChat's ActionSheet."
  s.description  = "There are two styles for other action items: only title, default alignment is left; title and image, default alignment is center. You can custom alignment through otherActionItemAlignment property."
  s.homepage     = "https://github.com/guowilling/SRActionSheet"
  s.license      = "MIT"
  s.author       = { "guowilling" => "guowilling90@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/guowilling/SRActionSheet.git", :tag => "#{s.version}" }
  s.source_files = "SRActionSheet/*.{h,m}"
  s.requires_arc = true
end
