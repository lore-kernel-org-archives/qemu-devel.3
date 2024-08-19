Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE02C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1XG-0003Qk-KO; Mon, 19 Aug 2024 08:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1XE-0003Nr-N8; Mon, 19 Aug 2024 08:30:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1XB-0000h0-Vy; Mon, 19 Aug 2024 08:30:56 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnX1S0GWPz6K9Lf;
 Mon, 19 Aug 2024 20:27:56 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 2536B140A77;
 Mon, 19 Aug 2024 20:30:49 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 13:30:48 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 19 Aug 2024 13:30:48 +0100
To: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 18/29] arm/virt: Add/update basic hot-(un)plug
 framework
Thread-Topic: [PATCH RFC V3 18/29] arm/virt: Add/update basic hot-(un)plug
 framework
Thread-Index: AQHaveuqxh+q2gwuhkKUTNTP6uc9UbIksZsAgAo3akA=
Date: Mon, 19 Aug 2024 12:30:48 +0000
Message-ID: <0665909307da4262976050ba97bbbc49@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-19-salil.mehta@huawei.com>
 <64e9feaa-8df2-4108-9e73-c72517fb074a@redhat.com>
In-Reply-To: <64e9feaa-8df2-4108-9e73-c72517fb074a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgR2F2aW4sDQoNCj4gIEZyb206IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+ICBT
ZW50OiBUdWVzZGF5LCBBdWd1c3QgMTMsIDIwMjQgMjoyMSBBTQ0KPiAgVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gIA0KPiAgT24gNi8xNC8yNCA5OjM2
IEFNLCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gID4gQWRkIENQVSBob3QtdW5wbHVnIGhvb2tzIGFu
ZCB1cGRhdGUgaG90cGx1ZyBob29rcyB3aXRoIGFkZGl0aW9uYWwNCj4gID4gc2FuaXR5IGNoZWNr
cyBmb3IgdXNlIGluIGhvdHBsdWcgcGF0aHMuDQo+ICA+DQo+ICA+IE5vdGU6IFRoZSBmdW5jdGlv
bmFsIGNvbnRlbnRzIG9mIHRoZSBob29rcyAoY3VycmVudGx5IGxlZnQgd2l0aCBUT0RPDQo+ICA+
IGNvbW1lbnRzKSB3aWxsIGJlIGdyYWR1YWxseSBmaWxsZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVz
IGluIGFuDQo+ICA+IGluY3JlbWVudGFsIGFwcHJvYWNoIHRvIHBhdGNoIGFuZCBsb2dpYyBidWls
ZGluZywgd2hpY2ggd291bGQgcm91Z2hseQ0KPiAgaW5jbHVkZSB0aGUgZm9sbG93aW5nOg0KPiAg
Pg0KPiAgPiAxLiAoVW4pd2lyaW5nIG9mIGludGVycnVwdHMgYmV0d2VlbiB2Q1BVPC0+R0lDLg0K
PiAgPiAyLiBTZW5kaW5nIGV2ZW50cyB0byB0aGUgZ3Vlc3QgZm9yIGhvdC0odW4pcGx1ZyBzbyB0
aGF0IHRoZSBndWVzdCBjYW4gdGFrZQ0KPiAgPiAgICAgYXBwcm9wcmlhdGUgYWN0aW9ucy4NCj4g
ID4gMy4gTm90aWZ5aW5nIHRoZSBHSUMgYWJvdXQgdGhlIGhvdC0odW4pcGx1ZyBhY3Rpb24gc28g
dGhhdCB0aGUgdkNQVSBjYW4gYmUNCj4gID4gICAgICh1bilzdGl0Y2hlZCB0byB0aGUgR0lDIENQ
VSBpbnRlcmZhY2UuDQo+ICA+IDQuIFVwZGF0aW5nIHRoZSBndWVzdCB3aXRoIG5leHQgYm9vdCBp
bmZvcm1hdGlvbiBmb3IgdGhpcyB2Q1BVIGluIHRoZQ0KPiAgZmlybXdhcmUuDQo+ICA+DQo+ICA+
IENvLWRldmVsb3BlZC1ieTogS2VxaWFuIFpodSA8emh1a2VxaWFuMUBodWF3ZWkuY29tPg0KPiAg
PiBTaWduZWQtb2ZmLWJ5OiBLZXFpYW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ICA+
IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAg
PiAtLS0NCj4gID4gICBody9hcm0vdmlydC5jIHwgMTA1DQo+ICArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
MDUgaW5zZXJ0aW9ucygrKQ0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3ZpcnQuYyBi
L2h3L2FybS92aXJ0LmMgaW5kZXgNCj4gID4gYTcyY2QzYjIwZC4uZjZiOGMyMWYyNiAxMDA2NDQN
Cj4gID4gLS0tIGEvaHcvYXJtL3ZpcnQuYw0KPiAgPiArKysgYi9ody9hcm0vdmlydC5jDQo+ICA+
IEBAIC04NSw2ICs4NSw3IEBADQo+ICA+ICAgI2luY2x1ZGUgImh3L3ZpcnRpby92aXJ0aW8taW9t
bXUuaCINCj4gID4gICAjaW5jbHVkZSAiaHcvY2hhci9wbDAxMS5oIg0KPiAgPiAgICNpbmNsdWRl
ICJxZW11L2d1ZXN0LXJhbmRvbS5oIg0KPiAgPiArI2luY2x1ZGUgInFhcGkvcW1wL3FkaWN0Lmgi
DQo+ICA+DQo+ICA+ICAgc3RhdGljIEdsb2JhbFByb3BlcnR5IGFybV92aXJ0X2NvbXBhdFtdID0g
ew0KPiAgPiAgICAgICB7IFRZUEVfVklSVElPX0lPTU1VX1BDSSwgImF3LWJpdHMiLCAiNDgiIH0s
IEBAIC0zMDAyLDExICszMDAzLDIzDQo+ICA+IEBAIHN0YXRpYyB2b2lkIHZpcnRfbWVtb3J5X3Bs
dWcoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPiAgPiAgIHN0YXRpYyB2b2lkIHZpcnRf
Y3B1X3ByZV9wbHVnKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwgRGV2aWNlU3RhdGUNCj4g
ICpkZXYsDQo+ICA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KQ0KPiAgPiAgIHsNCj4gID4gKyAgICBWaXJ0TWFjaGluZVN0YXRlICp2bXMgPSBWSVJUX01BQ0hJ
TkUoaG90cGx1Z19kZXYpOw0KPiAgPiAgICAgICBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElORSho
b3RwbHVnX2Rldik7DQo+ICA+ICsgICAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVfR0VUX0NM
QVNTKG1zKTsNCj4gID4gICAgICAgQVJNQ1BVICpjcHUgPSBBUk1fQ1BVKGRldik7DQo+ICA+ICAg
ICAgIENQVVN0YXRlICpjcyA9IENQVShkZXYpOw0KPiAgPiAgICAgICBDUFVBcmNoSWQgKmNwdV9z
bG90Ow0KPiAgPg0KPiAgPiArICAgIGlmIChkZXYtPmhvdHBsdWdnZWQgJiYgIXZtcy0+YWNwaV9k
ZXYpIHsNCj4gID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiR0VEIGFjcGkgZGV2aWNlIGRv
ZXMgbm90IGV4aXN0cyIpOw0KPiAgPiArICAgICAgICByZXR1cm47DQo+ICA+ICsgICAgfQ0KPiAg
PiArDQo+ICA+ICsgICAgaWYgKGRldi0+aG90cGx1Z2dlZCAmJiAhbWMtPmhhc19ob3RwbHVnZ2Fi
bGVfY3B1cykgew0KPiAgPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJDUFUgaG90cGx1ZyBu
b3Qgc3VwcG9ydGVkIG9uIHRoaXMgbWFjaGluZSIpOw0KPiAgPiArICAgICAgICByZXR1cm47DQo+
ICA+ICsgICAgfQ0KPiAgPiArDQo+ICA+ICAgICAgIC8qIHNhbml0eSBjaGVjayB0aGUgY3B1ICov
DQo+ICA+ICAgICAgIGlmICghb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoY3B1KSwgbXMtPmNw
dV90eXBlKSkgew0KPiAgPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSW52YWxpZCBDUFUg
dHlwZSwgZXhwZWN0ZWQgY3B1IHR5cGU6DQo+ICA+ICclcyciLCBAQCAtMzA0OSw2ICszMDYyLDIy
IEBAIHN0YXRpYyB2b2lkDQo+ICB2aXJ0X2NwdV9wcmVfcGx1ZyhIb3RwbHVnSGFuZGxlciAqaG90
cGx1Z19kZXYsIERldmljZVN0YXRlICpkZXYsDQo+ICA+ICAgICAgIH0NCj4gID4gICAgICAgdmly
dF9jcHVfc2V0X3Byb3BlcnRpZXMoT0JKRUNUKGNzKSwgY3B1X3Nsb3QsIGVycnApOw0KPiAgPg0K
PiAgPiArICAgIC8qDQo+ICA+ICsgICAgICogRml4IHRoZSBHSUMgZm9yIHRoaXMgbmV3IHZDUFUg
YmVpbmcgcGx1Z2dlZC4gVGhlIFFPTSBDUFUgb2JqZWN0IGZvciB0aGUNCj4gID4gKyAgICAgKiBu
ZXcgdkNQVSBuZWVkIHRvIGJlIHVwZGF0ZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgUU9NIEdJQ3Yz
Q1BVU3RhdGUgb2JqZWN0DQo+ICA+ICsgICAgICogV2UgYWxzbyBuZWVkIHRvIHJlLXdpcmUgdGhl
IElSUXMgZm9yIHRoaXMgbmV3IENQVSBvYmplY3QuIFRoaXMgdXBkYXRlDQo+ICA+ICsgICAgICog
aXMgbGltaXRlZCB0byB0aGUgUU9NIG9ubHkgYW5kIGRvZXMgbm90IGFmZmVjdHMgdGhlIEtWTS4g
TGF0ZXIgaGFzDQo+ICA+ICsgICAgICogYWxyZWFkeSBiZWVuIHByZS1zaXplZCB3aXRoIHBvc3Np
YmxlIENQVSBhdCBWTSBpbml0IHRpbWUuIFRoaXMgaXMgYQ0KPiAgPiArICAgICAqIHdvcmthcm91
bmQgdG8gdGhlIGNvbnN0cmFpbnRzIHBvc2VkIGJ5IEFSTSBhcmNoaXRlY3R1cmUgdy5yLnQgc3Vw
cG9ydGluZw0KPiAgPiArICAgICAqIENQVSBIb3RwbHVnLiBTcGVjaWZpY2F0aW9uIGRvZXMgbm90
IGV4aXN0IGZvciB0aGUgbGF0ZXIuDQo+ICA+ICsgICAgICogVGhpcyBwYXRjaC11cCBpcyByZXF1
aXJlZCBib3RoIGZvciB7Y29sZCxob3R9LXBsdWdnZWQgdkNQVXMuIENvbGQtaW5pdGVkDQo+ICA+
ICsgICAgICogdkNQVXMgaGF2ZSB0aGVpciBHSUMgc3RhdGUgaW5pdGlhbGl6ZWQgZHVyaW5nIG1h
Y2h2aXRfaW5pdCgpLg0KPiAgPiArICAgICAqLw0KPiAgPiArICAgIGlmICh2bXMtPmFjcGlfZGV2
KSB7DQo+ICA+ICsgICAgICAgIC8qIFRPRE86IHVwZGF0ZSBHSUMgYWJvdXQgdGhpcyBob3RwbHVn
IGNoYW5nZSBoZXJlICovDQo+ICA+ICsgICAgICAgIC8qIFRPRE86IHdpcmUgdGhlIEdJQzwtPkNQ
VSBpcnFzICovDQo+ICA+ICsgICAgfQ0KPiAgPiArDQo+ICA+ICAgICAgIC8qDQo+ICA+ICAgICAg
ICAqIFRvIGdpdmUgcGVyc2lzdGVudCBwcmVzZW5jZSB2aWV3IG9mIHZDUFVzIHRvIHRoZSBndWVz
dCwgQUNQSSBtaWdodCBuZWVkDQo+ICA+ICAgICAgICAqIHRvIGZha2UgdGhlIHByZXNlbmNlIG9m
IHRoZSB2Q1BVcyB0byB0aGUgZ3Vlc3QgYnV0IGtlZXAgdGhlbSBkaXNhYmxlZC4NCj4gID4gQEAg
LTMwNjAsNiArMzA4OSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRfY3B1X3ByZV9wbHVnKEhvdHBsdWdI
YW5kbGVyDQo+ICAqaG90cGx1Z19kZXYsIERldmljZVN0YXRlICpkZXYsDQo+ICA+ICAgc3RhdGlj
IHZvaWQgdmlydF9jcHVfcGx1ZyhIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsIERldmljZVN0
YXRlDQo+ICAqZGV2LA0KPiAgPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKipl
cnJwKQ0KPiAgPiAgIHsNCj4gID4gKyAgICBWaXJ0TWFjaGluZVN0YXRlICp2bXMgPSBWSVJUX01B
Q0hJTkUoaG90cGx1Z19kZXYpOw0KPiAgPiAgICAgICBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElO
RShob3RwbHVnX2Rldik7DQo+ICA+ICAgICAgIENQVVN0YXRlICpjcyA9IENQVShkZXYpOw0KPiAg
PiAgICAgICBDUFVBcmNoSWQgKmNwdV9zbG90Ow0KPiAgPiBAQCAtMzA2OCwxMCArMzA5OCw4MSBA
QCBzdGF0aWMgdm9pZCB2aXJ0X2NwdV9wbHVnKEhvdHBsdWdIYW5kbGVyDQo+ICAqaG90cGx1Z19k
ZXYsIERldmljZVN0YXRlICpkZXYsDQo+ICA+ICAgICAgIGNwdV9zbG90ID0gdmlydF9maW5kX2Nw
dV9zbG90KG1zLCBjcy0+Y3B1X2luZGV4KTsNCj4gID4gICAgICAgY3B1X3Nsb3QtPmNwdSA9IENQ
VShkZXYpOw0KPiAgPg0KPiAgPiArICAgIC8qDQo+ICA+ICsgICAgICogVXBkYXRlIHRoZSBBQ1BJ
IEhvdHBsdWcgc3RhdGUgYm90aCBmb3IgdkNQVXMgYmVpbmcge2hvdCxjb2xkfS0NCj4gIHBsdWdn
ZWQuDQo+ICA+ICsgICAgICogdkNQVXMgY2FuIGJlIGNvbGQtcGx1Z2dlZCB1c2luZyAnLWRldmlj
ZScgb3B0aW9uLiBGb3IgdkNQVXMgYmVpbmcNCj4gIGhvdA0KPiAgPiArICAgICAqIHBsdWdnZWQs
IGd1ZXN0IGlzIGFsc28gbm90aWZpZWQuDQo+ICA+ICsgICAgICovDQo+ICA+ICsgICAgaWYgKHZt
cy0+YWNwaV9kZXYpIHsNCj4gID4gKyAgICAgICAgLyogVE9ETzogdXBkYXRlIGFjcGkgaG90cGx1
ZyBzdGF0ZS4gU2VuZCBjcHUgaG90cGx1ZyBldmVudCB0byBndWVzdA0KPiAgKi8NCj4gID4gKyAg
ICAgICAgLyogVE9ETzogcmVnaXN0ZXIgY3B1IGZvciByZXNldCAmIHVwZGF0ZSBGL1cgaW5mbyBm
b3IgdGhlIG5leHQgYm9vdA0KPiAgKi8NCj4gID4gKyAgICB9DQo+ICA+ICsNCj4gID4gICAgICAg
Y3MtPmRpc2FibGVkID0gZmFsc2U7DQo+ICA+ICAgICAgIHJldHVybjsNCj4gID4gICB9DQo+ICA+
DQo+ICA+ICtzdGF0aWMgdm9pZCB2aXJ0X2NwdV91bnBsdWdfcmVxdWVzdChIb3RwbHVnSGFuZGxl
ciAqaG90cGx1Z19kZXYsDQo+ICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApIHsNCj4gID4gKyAgICBNYWNoaW5lQ2xh
c3MgKm1jID0gTUFDSElORV9HRVRfQ0xBU1MocWRldl9nZXRfbWFjaGluZSgpKTsNCj4gID4gKyAg
ICBWaXJ0TWFjaGluZVN0YXRlICp2bXMgPSBWSVJUX01BQ0hJTkUoaG90cGx1Z19kZXYpOw0KPiAg
PiArICAgIEFSTUNQVSAqY3B1ID0gQVJNX0NQVShkZXYpOw0KPiAgPiArICAgIENQVVN0YXRlICpj
cyA9IENQVShkZXYpOw0KPiAgPiArDQo+ICA+ICsgICAgaWYgKCF2bXMtPmFjcGlfZGV2IHx8ICFk
ZXYtPnJlYWxpemVkKSB7DQo+ICA+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkdFRCBkb2Vz
IG5vdCBleGlzdHMgb3IgZGV2aWNlIGlzIG5vdCByZWFsaXplZCEiKTsNCj4gID4gKyAgICAgICAg
cmV0dXJuOw0KPiAgPiArICAgIH0NCj4gID4gKw0KPiAgDQo+ICBIb3cgY2FuIGEgdkNQVSBiZSB1
bnBsdWdnZWQgZXZlbiB3aGVuIGl0IGhhc24ndCBiZWVuIHJlYWxpemVkPyA6KQ0KDQrwn5iKDQoN
ClRoaXMgaXMgYSByZWxpYyAtIGEgZm9zc2lsIGZyb20gdGhlIHBhc3Qgd2hpY2ggZXhpc3RzIGJl
Y2F1c2Ugb2YgdGhlIDIgYXBwcm9hY2hlcw0KSSBwcm90b3R5cGVkIGVhcmxpZXIuICBJbiB0aGUg
b3RoZXIgYXBwcm9hY2ggdkNQVSBvYmplY3RzIGNvdWxkIGV4aXN0Lg0KVGhhbmtzIGZvciBwb2lu
dGluZy4NCg0KDQo+ICANCj4gID4gKyAgICBpZiAoIW1jLT5oYXNfaG90cGx1Z2dhYmxlX2NwdXMp
IHsNCj4gID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQ1BVIGhvdCh1bilwbHVnIG5vdCBz
dXBwb3J0ZWQgb24gdGhpcyBtYWNoaW5lIik7DQo+ICA+ICsgICAgICAgIHJldHVybjsNCj4gID4g
KyAgICB9DQo+ICA+ICsNCj4gID4gKyAgICBpZiAoY3MtPmNwdV9pbmRleCA9PSBmaXJzdF9jcHUt
PmNwdV9pbmRleCkgew0KPiAgPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJCb290IENQVShp
ZCVkPSVkOiVkOiVkOiVkKSBob3QtdW5wbHVnIG5vdCBzdXBwb3J0ZWQiLA0KPiAgPiArICAgICAg
ICAgICAgICAgICAgIGZpcnN0X2NwdS0+Y3B1X2luZGV4LCBjcHUtPnNvY2tldF9pZCwgY3B1LT5j
bHVzdGVyX2lkLA0KPiAgPiArICAgICAgICAgICAgICAgICAgIGNwdS0+Y29yZV9pZCwgY3B1LT50
aHJlYWRfaWQpOw0KPiAgPiArICAgICAgICByZXR1cm47DQo+ICA+ICsgICAgfQ0KPiAgPiArDQo+
ICA+ICsgICAgLyogVE9ETzogcmVxdWVzdCBjcHUgaG90cGx1ZyBmcm9tIGd1ZXN0ICovDQo+ICA+
ICsNCj4gID4gKyAgICByZXR1cm47DQo+ICA+ICt9DQo+ICA+ICsNCj4gID4gK3N0YXRpYyB2b2lk
IHZpcnRfY3B1X3VucGx1ZyhIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsIERldmljZVN0YXRl
DQo+ICAqZGV2LA0KPiAgPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJy
cCkgew0KPiAgPiArICAgIFZpcnRNYWNoaW5lU3RhdGUgKnZtcyA9IFZJUlRfTUFDSElORShob3Rw
bHVnX2Rldik7DQo+ICA+ICsgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUoaG90cGx1Z19k
ZXYpOw0KPiAgPiArICAgIENQVVN0YXRlICpjcyA9IENQVShkZXYpOw0KPiAgPiArICAgIENQVUFy
Y2hJZCAqY3B1X3Nsb3Q7DQo+ICA+ICsNCj4gID4gKyAgICBpZiAoIXZtcy0+YWNwaV9kZXYgfHwg
IWRldi0+cmVhbGl6ZWQpIHsNCj4gID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiR0VEIGRv
ZXMgbm90IGV4aXN0cyBvciBkZXZpY2UgaXMgbm90IHJlYWxpemVkISIpOw0KPiAgPiArICAgICAg
ICByZXR1cm47DQo+ICA+ICsgICAgfQ0KPiAgPiArDQo+ICANCj4gIFNhbWUgcXVlc3Rpb24gYXMg
YWJvdmUuDQoNCg0KU2FtZSBhbnN3ZXIuIPCfmIoNCg0KDQo+ICANCj4gID4gKyAgICBjcHVfc2xv
dCA9IHZpcnRfZmluZF9jcHVfc2xvdChtcywgY3MtPmNwdV9pbmRleCk7DQo+ICA+ICsNCj4gID4g
KyAgICAvKiBUT0RPOiB1cGRhdGUgdGhlIGFjcGkgY3B1IGhvdHBsdWcgc3RhdGUgZm9yIGNwdSBo
b3QtdW5wbHVnICovDQo+ICA+ICsNCj4gID4gKyAgICAvKiBUT0RPOiB1bndpcmUgdGhlIGdpYy1j
cHUgaXJxcyBoZXJlICovDQo+ICA+ICsgICAgLyogVE9ETzogdXBkYXRlIHRoZSBHSUMgYWJvdXQg
dGhpcyBob3QgdW5wbHVnIGNoYW5nZSAqLw0KPiAgPiArDQo+ICA+ICsgICAgLyogVE9ETzogdW5y
ZWdpc3RlciBjcHUgZm9yIHJlc2V0ICYgdXBkYXRlIEYvVyBpbmZvIGZvciB0aGUgbmV4dA0KPiAg
PiArIGJvb3QgKi8NCj4gID4gKw0KPiAgPiArICAgIHFvYmplY3RfdW5yZWYoZGV2LT5vcHRzKTsN
Cj4gID4gKyAgICBkZXYtPm9wdHMgPSBOVUxMOw0KPiAgPiArDQo+ICA+ICsgICAgY3B1X3Nsb3Qt
PmNwdSA9IE5VTEw7DQo+ICA+ICsgICAgY3MtPmRpc2FibGVkID0gdHJ1ZTsNCj4gID4gKw0KPiAg
PiArICAgIHJldHVybjsNCj4gID4gK30NCj4gID4gKw0KPiAgDQo+ICBUaGUgJ3JldHVybicgaXNu
J3QgbmVlZGVkLg0KDQoNClllcC4gd2VsbCBpZGVudGlmaWVkLiBJdCBhY3R1YWxseSBkb2VzIG5v
dCBleGlzdCBpbiB0aGUgY29kZSBpZiB5b3UgYXBwbHkgYWxsIHRoZSBwYXRjaGVzLg0KTG9va3Mg
bGlrZSBpdCBoYXMgYmVlbiByZW1vdmVkIGluIHRoZSBzdWJzZXF1ZW50IHBhdGNoZXMgYWZ0ZXIg
YWRkaW5nIGl0IGhlcmUuIFdpbGwgZml4IHRoaXMNCmluc3RhbmNlIGFuZCB0aGUgb3RoZXIgaW4g
c3Vic2VxdWVudCBwYXRjaCB3aGVyZSBpdCBpcyBiZWluZyByZW1vdmVkLg0KDQpUaGFua3MgZm9y
IHBvaW50aW5nLg0KDQpTYWxpbC4NCg0K

