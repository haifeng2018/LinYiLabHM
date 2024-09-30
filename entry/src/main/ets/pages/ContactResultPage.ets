import { contact } from '@kit.ContactsKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ToolBar } from '../widget/ToolBar';
import { Constants } from '../util/Constants';
import { lpx2fp } from '../util/DesignShow';

@Entry
@Component
struct ContactResultPage {
  @State contactList: Array<string> = ['1','2','3','4','6','7','8']

  aboutToAppear(): void {
    // 获取context
    let context = getContext(this) as Context;
    contact.queryContacts(context, (err: BusinessError, data) => {
      if (err) {
        console.error(`Failed to query Contacts. Code: ${err.code}, message: ${err.message}`);
        return;
      }
      console.info(`Succeeded in querying Contacts. data->${JSON.stringify(data)}`);
    });
  }

  build() {
    Column() {
      ToolBar({
        title: 'LB|联系人权限',
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
    Text(){
      Span(`获取联系人\n${this.contactList.length}`)
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(56))
      Span('张')
        .fontColor($r('app.color.black'))
        .fontSize(lpx2fp(28))
    }
    .textAlign(TextAlign.Start)
    .width(Constants.FULL_PARENT)
    .margin({
      top: $r('app.string.lpx_30'),
      left: $r('app.string.lpx_30')
    })

    List({ space: 10 }) {
      ForEach(this.contactList,(item: string,index: number) => {
        ListItem() {
          this.itemLayout(item,index)
        }
      })
    }
    .width(Constants.FULL_PARENT)
    .layoutWeight(1)
    .alignSelf(ItemAlign.Center)
    .margin({
      top: $r('app.string.lpx_50')
    })
    .padding($r('app.string.lpx_10'))
  }

  @Builder itemLayout(item: string,index: number) {
    Column(){
      Text(`测试-${index}`)
        .width(Constants.FULL_PARENT)
        .fontSize(lpx2fp(28))
        .fontColor($r('app.color.black'))
        .maxLines(1)
        .textOverflow({overflow: TextOverflow.Ellipsis})
      Text(`1881393892${index}`)
        .width(Constants.FULL_PARENT)
        .fontSize(lpx2fp(28))
        .fontColor($r('app.color.black'))
        .maxLines(1)
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .margin({
          top: $r('app.string.lpx_20')
        })
    }
    .width("95%")
    .backgroundColor($r('app.color.white'))
    .justifyContent(FlexAlign.Center)
    .padding({
      top: $r('app.string.lpx_20'),
      left: $r('app.string.lpx_20'),
      right: $r('app.string.lpx_20')
    })
  }
}