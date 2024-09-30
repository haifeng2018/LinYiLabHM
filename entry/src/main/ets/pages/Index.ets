import App from '../app/App';
import { NavItem, NavList } from '../model/HomeTabModel';
import { Constants } from '../util/Constants';
import { lpx2fp } from '../util/DesignShow';
import PermissionHelper from '../util/PermissionHelper';
import { ToolBar } from '../widget/ToolBar';
import { common } from '@kit.AbilityKit';
import PictureSelectUtil from '../util/PictureSelectUtil';
import RouterPath from '../util/RouterPath';
import ToastUtils from '../util/ToastUtils';
import picker from '@ohos.file.picker';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      ToolBar({
        titleBackIcon: null,
        title: 'LINYI LAB' ,
        titleFontColor:$r('app.color.white'),
        titleBackgroundColor: $r('app.color.color_primary')
      })

      this.content()

    }
    .width(Constants.FULL_PARENT)
    .height(Constants.FULL_PARENT)
    .backgroundColor($r('app.color.white'))
    .padding({ bottom: $r('app.string.lpx_60') })
  }

  @Builder content() {
    Text("欢迎来到林亦 Lab\n请完成测试")
      .width(Constants.FULL_PARENT)
      .fontColor($r('app.color.black'))
      .fontSize(lpx2fp(56))
      .textAlign(TextAlign.Start)
      .margin({
        top: $r('app.string.lpx_30'),
        left: $r('app.string.lpx_30')
      })

    List({ space: 10 }) {
      ForEach(NavList,(item: NavItem,index: number) => {
        ListItem() {
          this.itemLayout(item,index)
        }
      })
    }
    .width(Constants.FULL_PARENT)
    .layoutWeight(1)
    .lanes(2)
    .margin({
      top: $r('app.string.lpx_50')
    })
    .padding($r('app.string.lpx_10'))

    Text("返回")
      .height($r('app.string.lpx_80'))
      .margin({
        top: $r('app.string.lpx_20'),
        bottom: $r('app.string.lpx_20')
      })
      .padding({
        left: $r('app.string.lpx_60'),
        right: $r('app.string.lpx_60')
      })
      .fontColor($r('app.color.white'))
      .fontSize(lpx2fp(32))
      .backgroundColor($r('app.color.color_EB4F3A'))
      .borderRadius($r('app.string.lpx_40'))
      .onClick(() => {
        App.get().back()
      })
  }

  @Builder itemLayout(item: NavItem,index: number) {
    Column(){
      Image(item.icon)
        .width($r('app.string.lpx_50'))
        .height($r('app.string.lpx_50'))

      Text(item.text)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(32))
        .margin({top: $r('app.string.lpx_20')})
    }
    .width("95%")
    .height($r('app.string.lpx_300'))
    .backgroundColor($r('app.color.color_33EB4F3A'))
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      const context = getContext(this) as common.UIAbilityContext;
      if (index === 0) {//相册
        PermissionHelper.checkPermissions(context, 'ohos.permission.READ_MEDIA').then((grant: boolean) => {
          if (grant) {
            //在添加上传按钮之前上传图片避免重新处理数据
            PictureSelectUtil.fileSelect(10).then((value) => {
              if (value.length > 0) {
                App.get().pushUrl({
                  url: RouterPath.ALBUM_RESULT_PAGE,
                  params: {
                    data: value
                  }
                })
              }
            })
          } else {
            PermissionHelper.openPermissionsInSystemSettings(context)
          }
        })
      } else if (index === 1) {//联系人(模拟器跑不起来需要真机验证)
       /* PermissionHelper.checkPermissions(context, 'ohos.permission.READ_CONTACTS').then((grant: boolean) => {
          if (grant) {
            App.get().pushUrl({
              url: RouterPath.CONTACT_RESULT_PAGE
            })
          } else {
            PermissionHelper.openPermissionsInSystemSettings(context)
          }
        })*/
        App.get().pushUrl({
          url: RouterPath.CONTACT_RESULT_PAGE
        })
      } else if (index === 2) {//文件权限
        const documentSelectOptions = new picker.DocumentSelectOptions()
        documentSelectOptions.maxSelectNumber = 5; // 选择文档的最大数目（可选）
        documentSelectOptions.defaultFilePathUri = "file://docs/storage/Users/currentUser/test"; // 指定选择的文件或者目录路径（可选）
        documentSelectOptions.fileSuffixFilters = ['.png','.jpeg','.jpg', '.txt', '.mp4']; // 选择文件的后缀类型，若选择项存在多个后缀名，则每一个后缀名之间用英文逗号进行分隔（可选）

        let uris: Array<string> = [];
        const documentViewPicker = new picker.DocumentViewPicker(); // 创建文件选择器实例
        documentViewPicker.select(documentSelectOptions).then((documentSelectResult: Array<string>) => {
          uris = documentSelectResult;
          console.info('documentViewPicker.select to file succeed and uris are:' + uris);
          App.get().pushUrl({
            url: RouterPath.FILE_RESULT_PAGE,
            params: {
              data: documentSelectResult
            }
          })
        }).catch((err: BusinessError) => {
          console.error(`Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
        })
      } else if (index === 3) {//相机权限
         PermissionHelper.checkPermissions(context, 'ohos.permission.CAMERA').then((grant: boolean) => {
              if (grant) {
                App.get().pushUrl({
                  url: RouterPath.CAPTURE_PAGE
                })
              } else {
                PermissionHelper.openPermissionsInSystemSettings(context)
              }
            })
      } else if (index === 4) {//手机信息
        App.get().pushUrl({
          url: RouterPath.DEVICE_RESULT_PAGE
        })
      } else if (index === 5) {//通话记录
        ToastUtils.show('不允许查询通话记录，相关权限无法申请。')
      } else if (index === 6) {//短信
        ToastUtils.show('不允许查询短信数据，相关权限无法申请。')
      } else if (index === 7) {//应用列表
        ToastUtils.show('不允许查询设备应用列表数据，相关权限无法申请。')
      }
    })

  }
}