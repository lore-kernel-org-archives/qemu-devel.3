Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29AAC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0xf-0000no-PP; Mon, 19 Aug 2024 07:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg0xd-0000mo-VD; Mon, 19 Aug 2024 07:54:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg0xb-0003No-7D; Mon, 19 Aug 2024 07:54:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnWB50GQtz6K6ps;
 Mon, 19 Aug 2024 19:50:21 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 32AA0140A78;
 Mon, 19 Aug 2024 19:53:53 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 12:53:52 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 19 Aug 2024 12:53:52 +0100
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
Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Thread-Topic: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Thread-Index: AQHaverDPpQr1lKFK0SrrcqBF6W41rIjVaUAgAuCoZA=
Date: Mon, 19 Aug 2024 11:53:52 +0000
Message-ID: <c889781d3eb048d19bae4ceff8646a4e@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
In-Reply-To: <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
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

SEkgR2F2aW4sDQoNClNvcnJ5LCBJIHdhcyBhd2F5IGZvciBhbG1vc3QgZW50aXJlIGxhc3Qgd2Vl
ay4gSm9pbmVkIGJhY2sgdG9kYXkuDQpUaGFua3MgZm9yIHRha2luZyBvdXQgdGltZSB0byByZXZp
ZXcuIA0KDQo+ICBGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiAgU2VudDog
TW9uZGF5LCBBdWd1c3QgMTIsIDIwMjQgNTozNiBBTQ0KPiAgVG86IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAgcWVtdS1hcm1A
bm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gIA0KPiAgT24gNi8xNC8yNCA5OjM2IEFNLCBT
YWxpbCBNZWh0YSB3cm90ZToNCj4gID4gVGhpcyBzaGFsbCBiZSB1c2VkIHRvIHN0b3JlIHVzZXIg
c3BlY2lmaWVkDQo+ICA+IHRvcG9sb2d5e3NvY2tldCxjbHVzdGVyLGNvcmUsdGhyZWFkfQ0KPiAg
PiBhbmQgc2hhbGwgYmUgY29udmVydGVkIHRvIGEgdW5pcXVlICd2Y3B1LWlkJyB3aGljaCBpcyB1
c2VkIGFzDQo+ICA+IHNsb3QtaW5kZXggZHVyaW5nIGhvdCh1bilwbHVnIG9mIHZDUFUuDQo+ICA+
DQo+ICA+IENvLWRldmVsb3BlZC1ieTogS2VxaWFuIFpodSA8emh1a2VxaWFuMUBodWF3ZWkuY29t
Pg0KPiAgPiBTaWduZWQtb2ZmLWJ5OiBLZXFpYW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+
DQo+ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29t
Pg0KPiAgPiAtLS0NCj4gID4gICBody9hcm0vdmlydC5jICAgICAgICAgfCAxMCArKysrKysrKysr
DQo+ICA+ICAgaW5jbHVkZS9ody9hcm0vdmlydC5oIHwgMjggKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgPiAgIHRhcmdldC9hcm0vY3B1LmMgICAgICB8ICA0ICsrKysNCj4gID4gICB0
YXJnZXQvYXJtL2NwdS5oICAgICAgfCAgNCArKysrDQo+ICA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA0
NiBpbnNlcnRpb25zKCspDQo+ICA+DQo+ICANCj4gIFRob3NlIDQgcHJvcGVydGllcyBhcmUgaW50
cm9kdWNlZCB0byBkZXRlcm1pbmUgdGhlIHZDUFUncyBzbG90LCB3aGljaCBpcyB0aGUNCj4gIGlu
ZGV4IHRvIE1hY2hpbmVTdGF0ZTo6cG9zc2libGVfY3B1czo6Y3B1c1tdLiANCg0KQ29ycmVjdC4N
Cg0KRnJvbSB0aGVyZSwgdGhlIENQVSBvYmplY3QNCj4gIG9yIGluc3RhbmNlIGlzIHJlZmVyZW5j
ZWQgYW5kIHRoZW4gdGhlIENQVSdzIHN0YXRlIGNhbiBiZSBmdXJ0aGVyDQo+ICBkZXRlcm1pbmVk
LiBJdCBzb3VuZHMgcmVhc29uYWJsZSB0byB1c2UgdGhlIENQVSdzIHRvcG9sb2d5IHRvIGRldGVy
bWluZQ0KPiAgdGhlIGluZGV4LiBIb3dldmVyLCBJJ20gd2FuZGVyaW5nIGlmIHRoaXMgY2FuIGJl
IHNpbXBsaWZpZWQgdG8gdXNlICdjcHUtDQo+ICBpbmRleCcgb3IgJ2luZGV4JyANCg0KQXJlIHlv
dSBzdWdnZXN0aW5nIHRvIHVzZSBDUFUgaW5kZXggd2hpbGUgc3BlY2lmeWluZyB2Q1BVcyB0aHJv
dWdoDQpjb21tYW5kIGxpbmUgYW5kIEknbSBub3QgZXZlbiBzdXJlIGhvdyB3aWxsIGl0IHNpbXBs
eSBDUFUgbmFtaW5nPw0KDQpDUFUgaW5kZXggaXMgaW50ZXJuYWwgaW5kZXggdG8gUU9NLiBUaGUg
Y2xvc2VzdCB0aGluZyB3aGljaCB5b3UgY2FuDQpoYXZlIGlzIHRoZSAnc2xvdC1pZCcgIGFuZCBs
YXRlciBjYW4gaGF2ZSBtYXBwaW5nIHRvIHRoZSBDUFUgaW5kZXgNCmludGVybmFsbHkgYnV0IEkn
bSBub3Qgc3VyZSBob3cgbXVjaCB1c2VmdWwgaXQgaXMgdG8gaW50cm9kdWNlIHRoaXMgDQpzbG90
IGFic3RyYWN0aW9uLiBJIGRpZCByYWlzZSB0aGlzIGluIHRoZSBvcmlnaW5hbCBSRkMgSSBwb3N0
ZWQgaW4gMjAyMC4NCg0KDQpmb3IgYSBjb3VwbGUgb2YgZmFjdHM6ICgxKSAnY3B1LWluZGV4Jw0K
PiAgb3IgJ2luZGV4JyBpcyBzaW1wbGlmaWVkLiBVc2VycyBoYXZlIHRvIHByb3ZpZGUgNCBwYXJh
bWV0ZXJzIGluIG9yZGVyIHRvDQo+ICBkZXRlcm1pbmUgaXRzIGluZGV4IGluIHRoZSBleHRyZW1l
IGNhc2UsIGZvciBleGFtcGxlICJkZXZpY2VfYWRkIGhvc3QtDQo+ICBhcm0tY3B1LCBpZD1jcHU3
LHNvY2tldC1pZD0xLCBjbHVzdGVyLWlkPTEsY29yZS1pZD0xLHRocmVhZC1pZD0xIi4gV2l0aA0K
PiAgJ2NwdS1pbmRleCcgb3IgJ2luZGV4JywgaXQgY2FuIGJlIHNpbXBsaWZpZWQgdG8gJ2luZGV4
PTcnLiAoMikgVGhlIGNvbGQtYm9vdGVkDQo+ICBhbmQgaG90cGx1Z2dhYmxlIENQVXMgYXJlIGRl
dGVybWluZWQgYnkgdGhlaXIgaW5kZXggaW5zdGVhZCBvZiB0aGVpcg0KPiAgdG9wb2xvZ3kuIEZv
ciBleGFtcGxlLCBDUFUwLzEvMi8zIGFyZSBjb2xkLWJvb3RlZCBDUFVzIHdoaWxlIENQVTQvNS82
LzcNCj4gIGFyZSBob3RwbHVnZ2FibGUgQ1BVcyB3aXRoIGNvbW1hbmQgbGluZXMgJy1zbXAgbWF4
Y3B1cz04LGNwdXM9NCcuIFNvDQo+ICAnaW5kZXgnIG1ha2VzIG1vcmUgc2Vuc2UgdG8gaWRlbnRp
ZnkgYSB2Q1BVJ3Mgc2xvdC4NCg0KDQpJJ20gbm90IHN1cmUgaWYgYW55Ym9keSB3YW50cyB0byB1
c2UgaXQgdGhpcyB3YXkuIFBlb3BsZSB3YW50IHRvIHNwZWNpZnkgdG9wb2xvZ3kNCmkuZS4gd2hl
cmUgdGhlIHZDUFUgZml0cy4gSW50ZXJuYWxseSBpdCdzIHVwIHRvIFFPTSB0byB0cmFuc2xhdGUg
dGhhdCB0b3BvbG9neSB0bw0Kc29tZSBpbmRleC4NCg0KDQo+ICANCj4gID4gZGlmZiAtLWdpdCBh
L2h3L2FybS92aXJ0LmMgYi9ody9hcm0vdmlydC5jIGluZGV4DQo+ICA+IDNjOTNjMGMwYTYuLjEx
ZmM3ZmMzMTggMTAwNjQ0DQo+ICA+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4gID4gKysrIGIvaHcv
YXJtL3ZpcnQuYw0KPiAgPiBAQCAtMjIxNSw2ICsyMjE1LDE0IEBAIHN0YXRpYyB2b2lkIG1hY2h2
aXJ0X2luaXQoTWFjaGluZVN0YXRlDQo+ICAqbWFjaGluZSkNCj4gID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZlcnJvcl9mYXRhbCk7DQo+ICA+DQo+ICA+ICAgICAgICAgICBhYXJjaDY0
ICY9IG9iamVjdF9wcm9wZXJ0eV9nZXRfYm9vbChjcHVvYmosICJhYXJjaDY0IiwNCj4gID4gTlVM
TCk7DQo+ICA+ICsgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfaW50KGNwdW9iaiwgInNvY2tl
dC1pZCIsDQo+ICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRfZ2V0X3Nv
Y2tldF9pZChtYWNoaW5lLCBuKSwgTlVMTCk7DQo+ICA+ICsgICAgICAgIG9iamVjdF9wcm9wZXJ0
eV9zZXRfaW50KGNwdW9iaiwgImNsdXN0ZXItaWQiLA0KPiAgPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2aXJ0X2dldF9jbHVzdGVyX2lkKG1hY2hpbmUsIG4pLCBOVUxMKTsNCj4g
ID4gKyAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoY3B1b2JqLCAiY29yZS1pZCIsDQo+
ICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRfZ2V0X2NvcmVfaWQobWFj
aGluZSwgbiksIE5VTEwpOw0KPiAgPiArICAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChj
cHVvYmosICJ0aHJlYWQtaWQiLA0KPiAgPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2aXJ0X2dldF90aHJlYWRfaWQobWFjaGluZSwgbiksDQo+ICA+ICsgTlVMTCk7DQo+ICA+DQo+
ICA+ICAgICAgICAgICBpZiAoIXZtcy0+c2VjdXJlKSB7DQo+ICA+ICAgICAgICAgICAgICAgb2Jq
ZWN0X3Byb3BlcnR5X3NldF9ib29sKGNwdW9iaiwgImhhc19lbDMiLCBmYWxzZSwNCj4gID4gTlVM
TCk7IEBAIC0yNzA4LDYgKzI3MTYsNyBAQCBzdGF0aWMgY29uc3QgQ1BVQXJjaElkTGlzdA0KPiAg
KnZpcnRfcG9zc2libGVfY3B1X2FyY2hfaWRzKE1hY2hpbmVTdGF0ZSAqbXMpDQo+ICA+ICAgew0K
PiAgPiAgICAgICBpbnQgbjsNCj4gID4gICAgICAgdW5zaWduZWQgaW50IG1heF9jcHVzID0gbXMt
PnNtcC5tYXhfY3B1czsNCj4gID4gKyAgICB1bnNpZ25lZCBpbnQgc21wX3RocmVhZHMgPSBtcy0+
c21wLnRocmVhZHM7DQo+ICA+ICAgICAgIFZpcnRNYWNoaW5lU3RhdGUgKnZtcyA9IFZJUlRfTUFD
SElORShtcyk7DQo+ICA+ICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0dFVF9DTEFT
Uyh2bXMpOw0KPiAgPg0KPiAgPiBAQCAtMjcyMSw2ICsyNzMwLDcgQEAgc3RhdGljIGNvbnN0IENQ
VUFyY2hJZExpc3QNCj4gICp2aXJ0X3Bvc3NpYmxlX2NwdV9hcmNoX2lkcyhNYWNoaW5lU3RhdGUg
Km1zKQ0KPiAgPiAgICAgICBtcy0+cG9zc2libGVfY3B1cy0+bGVuID0gbWF4X2NwdXM7DQo+ICA+
ICAgICAgIGZvciAobiA9IDA7IG4gPCBtcy0+cG9zc2libGVfY3B1cy0+bGVuOyBuKyspIHsNCj4g
ID4gICAgICAgICAgIG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW25dLnR5cGUgPSBtcy0+Y3B1X3R5
cGU7DQo+ICA+ICsgICAgICAgIG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW25dLnZjcHVzX2NvdW50
ID0gc21wX3RocmVhZHM7DQo+ICA+ICAgICAgICAgICBtcy0+cG9zc2libGVfY3B1cy0+Y3B1c1tu
XS5hcmNoX2lkID0NCj4gID4gICAgICAgICAgICAgICB2aXJ0X2NwdV9tcF9hZmZpbml0eSh2bXMs
IG4pOw0KPiAgPg0KPiAgDQo+ICBXaHkgQHZjcHVzX2NvdW50IGlzIGluaXRpYWxpemVkIHRvIEBz
bXBfdGhyZWFkcz8gaXQgbmVlZHMgdG8gYmUNCj4gIGRvY3VtZW50ZWQgaW4gdGhlIGNvbW1pdCBs
b2cuDQoNCg0KQmVjYXVzZSBldmVyeSB0aHJlYWQgaW50ZXJuYWxseSBhbW91bnRzIHRvIGEgdkNQ
VSBpbiBRT00gYW5kIHdoaWNoDQppcyBpbiAxOjEgcmVsYXRpb25zaGlwIHdpdGggS1ZNIHZDUFUu
IEFGQUlLLCBRT00gZG9lcyBub3Qgc3RyaWN0bHkgZm9sbG93cw0KYW55IGFyY2hpdGVjdHVyZS4g
T25jZSB5b3Ugc3RhcnQgdG8gZ2V0IGludG8gZGV0YWlscyBvZiB0aHJlYWRzIHRoZXJlDQphcmUg
bWFueSBhc3BlY3RzIG9mIHNoYXJlZCByZXNvdXJjZXMgb25lIHdpbGwgaGF2ZSB0byBjb25zaWRl
ciBhbmQNCnRoZXNlIGNhbiB2YXJ5IGFjcm9zcyBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb25zIG9m
IGFyY2hpdGVjdHVyZS4NCg0KSXQgaXMgYSBiaWdnZXIgcHJvYmxlbSB0aGFuIHlvdSB0aGluaywg
d2hpY2ggSSd2ZSB0b3VjaGVkIGF0IHZlcnkgbmFzY2VudA0Kc3RhZ2VzIHdoaWxlIGRvaW5nIFBP
QyBvZiB2Q1BVIGhvdHBsdWcgYnV0IHRyaWVkIHRvIGF2b2lkIHRpbGwgbm93LiANCg0KDQpCdXQg
SSB3b3VsZCBsaWtlIHRvIGhlYXIgb3RoZXIgY29tbXVuaXR5IG1lbWJlcnMgdmlld3Mgb24gdGhp
cy4NCg0KSGkgSWdvci9QZXRlciwNCg0KV2hhdCBpcyB5b3VyIHRha2Ugb24gdGhpcz8NCg0KVGhh
bmtzDQpTYWxpbC4NCg0KDQoNCj4gID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL3ZpcnQu
aCBiL2luY2x1ZGUvaHcvYXJtL3ZpcnQuaCBpbmRleA0KPiAgPiBiYjQ4NmQzNmIxLi42ZjlhN2Ji
NjBiIDEwMDY0NA0KPiAgPiAtLS0gYS9pbmNsdWRlL2h3L2FybS92aXJ0LmgNCj4gID4gKysrIGIv
aW5jbHVkZS9ody9hcm0vdmlydC5oDQo+ICA+IEBAIC0yMDksNCArMjA5LDMyIEBAIHN0YXRpYyBp
bmxpbmUgaW50DQo+ICB2aXJ0X2dpY3YzX3JlZGlzdF9yZWdpb25fY291bnQoVmlydE1hY2hpbmVT
dGF0ZSAqdm1zKQ0KPiAgPiAgICAgICAgICAgICAgIHZtcy0+aGlnaG1lbV9yZWRpc3RzKSA/IDIg
OiAxOw0KPiAgPiAgIH0NCj4gID4NCj4gID4gK3N0YXRpYyBpbmxpbmUgaW50IHZpcnRfZ2V0X3Nv
Y2tldF9pZChjb25zdCBNYWNoaW5lU3RhdGUgKm1zLCBpbnQNCj4gID4gK2NwdV9pbmRleCkgew0K
PiAgPiArICAgIGFzc2VydChjcHVfaW5kZXggPj0gMCAmJiBjcHVfaW5kZXggPCBtcy0+cG9zc2li
bGVfY3B1cy0+bGVuKTsNCj4gID4gKw0KPiAgPiArICAgIHJldHVybiBtcy0+cG9zc2libGVfY3B1
cy0+Y3B1c1tjcHVfaW5kZXhdLnByb3BzLnNvY2tldF9pZDsNCj4gID4gK30NCj4gID4gKw0KPiAg
PiArc3RhdGljIGlubGluZSBpbnQgdmlydF9nZXRfY2x1c3Rlcl9pZChjb25zdCBNYWNoaW5lU3Rh
dGUgKm1zLCBpbnQNCj4gID4gK2NwdV9pbmRleCkgew0KPiAgPiArICAgIGFzc2VydChjcHVfaW5k
ZXggPj0gMCAmJiBjcHVfaW5kZXggPCBtcy0+cG9zc2libGVfY3B1cy0+bGVuKTsNCj4gID4gKw0K
PiAgPiArICAgIHJldHVybiBtcy0+cG9zc2libGVfY3B1cy0+Y3B1c1tjcHVfaW5kZXhdLnByb3Bz
LmNsdXN0ZXJfaWQ7DQo+ICA+ICt9DQo+ICA+ICsNCj4gID4gK3N0YXRpYyBpbmxpbmUgaW50IHZp
cnRfZ2V0X2NvcmVfaWQoY29uc3QgTWFjaGluZVN0YXRlICptcywgaW50DQo+ICA+ICtjcHVfaW5k
ZXgpIHsNCj4gID4gKyAgICBhc3NlcnQoY3B1X2luZGV4ID49IDAgJiYgY3B1X2luZGV4IDwgbXMt
PnBvc3NpYmxlX2NwdXMtPmxlbik7DQo+ICA+ICsNCj4gID4gKyAgICByZXR1cm4gbXMtPnBvc3Np
YmxlX2NwdXMtPmNwdXNbY3B1X2luZGV4XS5wcm9wcy5jb3JlX2lkOw0KPiAgPiArfQ0KPiAgPiAr
DQo+ICA+ICtzdGF0aWMgaW5saW5lIGludCB2aXJ0X2dldF90aHJlYWRfaWQoY29uc3QgTWFjaGlu
ZVN0YXRlICptcywgaW50DQo+ICA+ICtjcHVfaW5kZXgpIHsNCj4gID4gKyAgICBhc3NlcnQoY3B1
X2luZGV4ID49IDAgJiYgY3B1X2luZGV4IDwgbXMtPnBvc3NpYmxlX2NwdXMtPmxlbik7DQo+ICA+
ICsNCj4gID4gKyAgICByZXR1cm4gbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbY3B1X2luZGV4XS5w
cm9wcy50aHJlYWRfaWQ7DQo+ICA+ICt9DQo+ICA+ICsNCj4gID4gICAjZW5kaWYgLyogUUVNVV9B
Uk1fVklSVF9IICovDQo+ICA+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2NwdS5jIGIvdGFyZ2V0
L2FybS9jcHUuYyBpbmRleA0KPiAgPiA3N2Y4YzljNzQ4Li5hYmM0ZWQwODQyIDEwMDY0NA0KPiAg
PiAtLS0gYS90YXJnZXQvYXJtL2NwdS5jDQo+ICA+ICsrKyBiL3RhcmdldC9hcm0vY3B1LmMNCj4g
ID4gQEAgLTI1ODIsNiArMjU4MiwxMCBAQCBzdGF0aWMgUHJvcGVydHkgYXJtX2NwdV9wcm9wZXJ0
aWVzW10gPSB7DQo+ICA+ICAgICAgIERFRklORV9QUk9QX1VJTlQ2NCgibXAtYWZmaW5pdHkiLCBB
Uk1DUFUsDQo+ICA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgbXBfYWZmaW5pdHksIEFSTTY0
X0FGRklOSVRZX0lOVkFMSUQpLA0KPiAgPiAgICAgICBERUZJTkVfUFJPUF9JTlQzMigibm9kZS1p
ZCIsIEFSTUNQVSwgbm9kZV9pZCwNCj4gID4gQ1BVX1VOU0VUX05VTUFfTk9ERV9JRCksDQo+ICA+
ICsgICAgREVGSU5FX1BST1BfSU5UMzIoInNvY2tldC1pZCIsIEFSTUNQVSwgc29ja2V0X2lkLCAw
KSwNCj4gID4gKyAgICBERUZJTkVfUFJPUF9JTlQzMigiY2x1c3Rlci1pZCIsIEFSTUNQVSwgY2x1
c3Rlcl9pZCwgMCksDQo+ICA+ICsgICAgREVGSU5FX1BST1BfSU5UMzIoImNvcmUtaWQiLCBBUk1D
UFUsIGNvcmVfaWQsIDApLA0KPiAgPiArICAgIERFRklORV9QUk9QX0lOVDMyKCJ0aHJlYWQtaWQi
LCBBUk1DUFUsIHRocmVhZF9pZCwgMCksDQo+ICA+ICAgICAgIERFRklORV9QUk9QX0lOVDMyKCJj
b3JlLWNvdW50IiwgQVJNQ1BVLCBjb3JlX2NvdW50LCAtMSksDQo+ICA+ICAgICAgIC8qIFRydWUg
dG8gZGVmYXVsdCB0byB0aGUgYmFja3dhcmQtY29tcGF0IG9sZCBDTlRGUlEgcmF0aGVyIHRoYW4N
Cj4gIDFHaHogKi8NCj4gID4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiYmFja2NvbXBhdC1jbnRm
cnEiLCBBUk1DUFUsDQo+ICBiYWNrY29tcGF0X2NudGZycSwNCj4gID4gZmFsc2UpLCBkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2FybS9jcHUuaCBiL3RhcmdldC9hcm0vY3B1LmggaW5kZXgNCj4gID4gYzE3
MjY0YzIzOS4uMjA4YzcxOWRiMyAxMDA2NDQNCj4gID4gLS0tIGEvdGFyZ2V0L2FybS9jcHUuaA0K
PiAgPiArKysgYi90YXJnZXQvYXJtL2NwdS5oDQo+ICA+IEBAIC0xMDc2LDYgKzEwNzYsMTAgQEAg
c3RydWN0IEFyY2hDUFUgew0KPiAgPiAgICAgICBRTElTVF9IRUFEKCwgQVJNRUxDaGFuZ2VIb29r
KSBlbF9jaGFuZ2VfaG9va3M7DQo+ICA+DQo+ICA+ICAgICAgIGludDMyX3Qgbm9kZV9pZDsgLyog
TlVNQSBub2RlIHRoaXMgQ1BVIGJlbG9uZ3MgdG8gKi8NCj4gID4gKyAgICBpbnQzMl90IHNvY2tl
dF9pZDsNCj4gID4gKyAgICBpbnQzMl90IGNsdXN0ZXJfaWQ7DQo+ICA+ICsgICAgaW50MzJfdCBj
b3JlX2lkOw0KPiAgPiArICAgIGludDMyX3QgdGhyZWFkX2lkOw0KPiAgPg0KPiAgPiAgICAgICAv
KiBVc2VkIHRvIHN5bmNocm9uaXplIEtWTSBhbmQgUUVNVSBpbi1rZXJuZWwgZGV2aWNlIGxldmVs
cyAqLw0KPiAgPiAgICAgICB1aW50OF90IGRldmljZV9pcnFfbGV2ZWw7DQo+ICANCj4gIFRoYW5r
cywNCj4gIEdhdmluDQo+ICANCg0K

