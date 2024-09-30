import deviceinfo from '@ohos.deviceInfo';
import { Constants } from '../util/Constants';
import { lpx2fp } from '../util/DesignShow';
import { ToolBar } from '../widget/ToolBar';

@Entry
@Component
struct DeviceResultPage {
  build() {
    Column() {
      ToolBar({
        title: 'LB|手机信息',
        titleFontColor:$r('app.color.white'),
        titleBackgroundColor: $r('app.color.color_primary')
      })
      this.content()
    }
    .width(Constants.FULL_PARENT)
    .height(Constants.FULL_PARENT)
    .backgroundColor($r('app.color.white'))
  }

  @Builder content() {
    Column() {
      Text('获取手机信息权限\n完成')
        .textAlign(TextAlign.Start)
        .width(Constants.FULL_PARENT)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(56))
        .margin({
          top: $r('app.string.lpx_30'),
          left: $r('app.string.lpx_30')
        })

      Text(`IMEI:${deviceinfo.serial} ? unknown`)
        .width(Constants.FULL_PARENT)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(32))
        .margin({
          top: $r('app.string.lpx_50')
        })

      Text(`S/N:${deviceinfo.serial} ? unknown`)
        .width(Constants.FULL_PARENT)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(32))
      Text(`OsVersion:${deviceinfo.osFullName}`)
        .width(Constants.FULL_PARENT)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(32))
      Text(`BuildVersion:${deviceinfo.buildVersion}`)
        .width(Constants.FULL_PARENT)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(32))
      Text(`Model:${deviceinfo.productModel}`)
        .width(Constants.FULL_PARENT)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(32))
    }
    .width(Constants.FULL_PARENT)
    .layoutWeight(1)
    .alignSelf(ItemAlign.Center)
    .margin({
      top: $r('app.string.lpx_50')
    })
    .padding($r('app.string.lpx_10'))
  }
}