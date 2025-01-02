#!/bin/bas
sed -i '$a src-git gxnas https://github.com/gxnas/OpenWrt_Build_x64_Packages' feeds.conf.default
# 移除要替换的包
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-docker
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf package/feeds/gxnas/natflow
rm -rf package/feeds/gxnas/luci-app-dogcom

git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang




 
# 1-添加 PowerOff 插件
# git clone https://github.com/nhyoungboy/luci-app-poweroff.git package/luci-app-poweroff

# 2-添加 Mosdns 插件
# rm -rf feeds/packages/lang/golang
# rm -rf feeds/packages/net/mosdns
# rm -rf feeds/luci/applications/luci-app-mosdns
# git clone https://github.com/sbwml/luci-app-mosdns.git package/lean/luci-app-mosdns

# 3-添加 Openclash 插件
# wget -O package/openclash.zip https://codeload.github.com/vernesong/OpenClash/zip/refs/heads/master
# unzip -d package/openclash package/openclash.zip
# cp -r package/openclash/OpenClash-master/luci-app-openclash package/lean/luci-app-openclash
# rm -rf package/openclash package/openclash.zip

# 4-添加 onliner 插件
# sed -i '$a src-git onliner https://github.com/nhyoungboy/luci-app-onliner' feeds.conf.default

# 5-添加  主题
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone https://github.com/sbwml/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone --depth=1 https://github.com/nhyoungboy/luci-theme-opentomcat.git package/luci-theme-opentomcat


# 修改网络设置
sed -i 's/192.168.1.1/192.168.81.1/g' package/base-files/files/bin/config_generate

# Change default theme
sed -i 's#luci-theme-bootstrap#luci-theme-opentomcat#g' feeds/luci/collections/luci/Makefile
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by LERAN/g" package/lean/default-settings/files/zzz-default-settings
