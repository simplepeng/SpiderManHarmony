@Entry
@Component
struct Index {
  @State message: string = 'Crash';

  build() {
    RelativeContainer() {
      Button(this.message)
        .fontSize(25)
        .fontWeight(FontWeight.Medium)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          JSON.parse('')
        })
    }
    .height('100%')
    .width('100%')
  }
}