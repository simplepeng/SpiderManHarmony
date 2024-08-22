import { Const } from './Const';
import { hiAppEvent } from '@kit.PerformanceAnalysisKit';
import { ComposeTitleBar, router } from '@kit.ArkUI';
import { bundleManager } from '@kit.AbilityKit';
import { BusinessError, deviceInfo } from '@kit.BasicServicesKit';

@Entry({ routeName: Const.CRASH_PAGE })
@Component
export struct CrashPage {
  eventGroup?: hiAppEvent.AppEventGroup = router.getParams() as hiAppEvent.AppEventGroup
  eventInfoList: Array<hiAppEvent.AppEventInfo> = this.eventGroup?.appEventInfos ?? []

  build() {
    Column() {
      ComposeTitleBar({ title: 'Crash Info' })
        .width(Const.FULL_PAGE)
      Swiper() {
        ForEach(this.eventGroup?.appEventInfos, (eventInfo: hiAppEvent.AppEventInfo) => {
          SwiperPage({
            eventInfo: eventInfo
          })
        })
      }
      .width(Const.FULL_PAGE)
      .layoutWeight(1)
      .indicator(this.eventInfoList.length > 1)
      .effectMode(EdgeEffect.None)
      .loop(false)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
export struct SwiperPage {
  @Prop eventInfo: hiAppEvent.AppEventInfo
  //
  @State deviceType: string = ''
  @State marketName: string = ''
  @State displayVersion: string = ''
  @State osFullName: string = ''
  @State abiList: string = ''
  @State ODID: string = ''
  @State sdkApiVersion: string = ''
  //
  @State version: string = ''
  @State versionCode: string = ''
  @State releaseType: string = ''
  @State appProvisionType: string = ''

  build() {
    Scroll() {
      Column({ space: 10 }) {
        Item({ type: 'deviceType', message: this.deviceType })
        Item({ type: 'marketName', message: this.marketName })
        Item2({ type: 'displayVersion', message: this.displayVersion })
        Item({ type: 'osFullName', message: this.osFullName })
        Item({ type: 'abiList', message: this.abiList })
        Item({ type: 'sdkApiVersion', message: this.sdkApiVersion })
        Item2({ type: 'ODID', message: this.ODID })
        Divider()
        //
        Item({ type: 'version', message: this.version })
        Item({ type: 'versionCode', message: this.versionCode })
        Item({ type: 'releaseType', message: this.releaseType })
        Item({ type: 'appProvisionType', message: this.appProvisionType })
        Divider()
        //
        Item({ type: 'domain', message: this.eventInfo.domain })
        Item({ type: 'name', message: this.eventInfo.name })
        Item({ type: 'event_type', message: this.eventInfo.eventType.toString() })
        Item({ type: 'time', message: this.eventInfo.params['time'] })
        Item({ type: 'crash_type', message: this.eventInfo.params['crash_type'] })
        Item({ type: 'foreground', message: this.eventInfo.params['foreground'] })
        Item({ type: 'bundle_version', message: this.eventInfo.params['bundle_version'] })
        Item({ type: 'bundle_name', message: this.eventInfo.params['bundle_name'] })
        // Item({ type: 'pid', message: this.eventInfo.params['pid'] })
        // Item({ type: 'uid', message: this.eventInfo.params['uid'] })
        // Item({ type: 'uuid', message: this.eventInfo.params['uuid'] })
        // Item2({ type: 'exception', message: JSON.stringify(this.eventInfo.params['exception']) })
        // Item({ type: 'external_log', message: this.eventInfo.params['external_log'] })
        Item({ type: 'Error name', message: this.eventInfo.params['exception'].name })
        Item({ type: 'Error message', message: this.eventInfo.params['exception'].message })
        Item2({ type: 'Stacktrace', message: this.eventInfo.params['exception'].stack })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .scrollable(ScrollDirection.Vertical)
    .padding({ left: 10, right: 10 })
  }

  getDeviceInfo() {
    this.deviceType = deviceInfo.deviceType
    this.marketName = deviceInfo.marketName
    this.displayVersion = deviceInfo.displayVersion
    this.osFullName = deviceInfo.osFullName
    this.abiList = deviceInfo.abiList
    this.sdkApiVersion = deviceInfo.sdkApiVersion.toString()
    this.ODID = deviceInfo.ODID
  }

  logDeviceInfo() {
    console.error('deviceType is ' + deviceInfo.deviceType) //phone
    console.error('manufacture is ' + deviceInfo.manufacture)
    console.error('brand is ' + deviceInfo.brand)
    console.error('marketName is ' + deviceInfo.marketName) //HUAWEI Mate 60 Pro
    console.error('productSeries is ' + deviceInfo.productSeries)
    console.error('productModel is ' + deviceInfo.productModel)
    console.error('softwareModel is ' + deviceInfo.softwareModel)
    console.error('hardwareModel is ' + deviceInfo.hardwareModel)
    console.error('hardwareProfile is ' + deviceInfo.hardwareProfile)
    console.error('serial is ' + deviceInfo.serial)
    console.error('bootloaderVersion is ' + deviceInfo.bootloaderVersion)
    console.error('abiList is ' + deviceInfo.abiList) //arm64-v8a
    console.error('securityPatchTag is ' + deviceInfo.securityPatchTag)
    console.error('displayVersion is ' + deviceInfo.displayVersion) //ALN-AL80 5.0.0.60(SP12DEVC00E61R4P9log)
    console.error('incrementalVersion is ' + deviceInfo.incrementalVersion)
    console.error('osReleaseType is ' + deviceInfo.osReleaseType) //Beta5
    console.error('osFullName is ' + deviceInfo.osFullName) //OpenHarmony-5.0.0.60(Beta5)
    console.error('versionId is ' + deviceInfo.versionId)
    console.error('buildType is ' + deviceInfo.buildType)
    console.error('buildUser is ' + deviceInfo.buildUser)
    console.error('buildHost is ' + deviceInfo.buildHost)
    console.error('buildTime is ' + deviceInfo.buildTime)
    console.error('buildRootHash is ' + deviceInfo.buildRootHash)
    console.error('udid is ' + deviceInfo.udid)
    console.error('distributionOSName is ' + deviceInfo.distributionOSName)
    console.error('distributionOSVersion is ' + deviceInfo.distributionOSVersion) //5.0.0
    console.error('distributionOSReleaseType is ' + deviceInfo.distributionOSReleaseType) //Beta5
    console.error('ODID is ' + deviceInfo.ODID) //e363fbb5-ab56-01ab-bee1-1b8c6f6a054c
    console.error('majorVersion is ' + deviceInfo.majorVersion)
    console.error('seniorVersion is ' + deviceInfo.seniorVersion)
    console.error('featureVersion is ' + deviceInfo.featureVersion)
    console.error('buildVersion is ' + deviceInfo.buildVersion)
    console.error('sdkApiVersion is ' + deviceInfo.sdkApiVersion) //12
    console.error('firstApiVersion is ' + deviceInfo.firstApiVersion)
    console.error('distributionOSApiVersion is ' + deviceInfo.distributionOSApiVersion)
  }

  getBundleInfo() {
    bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION).then((bundleInfo) => {
      this.version = bundleInfo.versionName
      this.versionCode = bundleInfo.versionCode.toString()
      bundleInfo.minCompatibleVersionCode
      bundleInfo.targetVersion
      this.releaseType = bundleInfo.appInfo.releaseType
      this.appProvisionType = bundleInfo.appInfo.appProvisionType // debug
    }).catch((error: BusinessError) => {
      console.error("get bundleInfo failed,error is " + error)
    })
  }

  aboutToAppear(): void {
    this.getDeviceInfo()
    this.getBundleInfo()
  }
}

@Component
export struct Item {
  @Prop type: string
  @Prop message: string

  build() {
    Row() {
      Text(`${this.type}: `)
      Text(this.message)
    }
  }
}

@Component
export struct Item2 {
  @Prop type: string
  @Prop message: string

  build() {
    Column({ space: 5 }) {
      Text(`${this.type}: `)
      Text(this.message)
    }
    .alignItems(HorizontalAlign.Start)
  }
}
