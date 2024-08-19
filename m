Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB3FC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1Oc-0005hB-Mo; Mon, 19 Aug 2024 08:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1OD-0005Zm-Tm; Mon, 19 Aug 2024 08:21:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1O8-0007YI-Gv; Mon, 19 Aug 2024 08:21:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnWns1H5Gz6K6yv;
 Mon, 19 Aug 2024 20:17:53 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
 by mail.maildlp.com (Postfix) with ESMTPS id 620661400D7;
 Mon, 19 Aug 2024 20:21:25 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 13:21:25 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 19 Aug 2024 13:21:24 +0100
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
Subject: RE: [PATCH RFC V3 17/29] arm/virt: Release objects for *disabled*
 possible vCPUs after init
Thread-Topic: [PATCH RFC V3 17/29] arm/virt: Release objects for *disabled*
 possible vCPUs after init
Thread-Index: AQHaveuckEaR/Tp4NUKcalC/yUyS9LIksGYAgAo1aXA=
Date: Mon, 19 Aug 2024 12:21:24 +0000
Message-ID: <6b435c1f2b934867b8d82850d6d866c6@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-18-salil.mehta@huawei.com>
 <51dc0813-7dc9-4927-a24b-bd718be54e46@redhat.com>
In-Reply-To: <51dc0813-7dc9-4927-a24b-bd718be54e46@redhat.com>
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
ZW50OiBUdWVzZGF5LCBBdWd1c3QgMTMsIDIwMjQgMjoxNyBBTQ0KPiAgVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gIA0KPiAgT24gNi8xNC8yNCA5OjM2
IEFNLCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gID4gRHVyaW5nIGBtYWNodmlydF9pbml0KClgLCBR
T00gQVJNQ1BVIG9iamVjdHMgYXJlIHByZS1jcmVhdGVkIGFsb25nDQo+ICA+IHdpdGggdGhlIGNv
cnJlc3BvbmRpbmcgS1ZNIHZDUFVzIGluIHRoZSBob3N0IGZvciBhbGwgcG9zc2libGUgdkNQVXMu
DQo+ICA+IFRoaXMgaXMgbmVjZXNzYXJ5IGR1ZSB0byB0aGUgYXJjaGl0ZWN0dXJhbCBjb25zdHJh
aW50IHRoYXQgS1ZNDQo+ICA+IHJlc3RyaWN0cyB0aGUgZGVmZXJyZWQgY3JlYXRpb24gb2YgS1ZN
IHZDUFVzIGFuZCBWR0lDDQo+ICA+IGluaXRpYWxpemF0aW9uL3NpemluZyBhZnRlciBWTSBpbml0
aWFsaXphdGlvbi4gSGVuY2UsIFZHSUMgaXMgcHJlLXNpemVkIHdpdGgNCj4gIHBvc3NpYmxlIHZD
UFVzLg0KPiAgPg0KPiAgPiBBZnRlciB0aGUgaW5pdGlhbGl6YXRpb24gb2YgdGhlIG1hY2hpbmUg
aXMgY29tcGxldGUsIHRoZSBkaXNhYmxlZA0KPiAgPiBwb3NzaWJsZSBLVk0gdkNQVXMgYXJlIHBh
cmtlZCBpbiB0aGUgcGVyLXZpcnQtbWFjaGluZSBsaXN0DQo+ICA+ICJrdm1fcGFya2VkX3ZjcHVz
LCIgYW5kIHdlIHJlbGVhc2UgdGhlIFFPTSBBUk1DUFUgb2JqZWN0cyBmb3IgdGhlDQo+ICA+IGRp
c2FibGVkIHZDUFVzLiBUaGVzZSB3aWxsIGJlIHJlLWNyZWF0ZWQgd2hlbiB0aGUgdkNQVSBpcyBo
b3RwbHVnZ2VkDQo+ICA+IGFnYWluLiBUaGUgUU9NIEFSTUNQVSBvYmplY3QgaXMgdGhlbiByZS1h
dHRhY2hlZCB0byB0aGUgY29ycmVzcG9uZGluZw0KPiAgcGFya2VkIEtWTSB2Q1BVLg0KPiAgPg0K
PiAgPiBBbHRlcm5hdGl2ZWx5LCB3ZSBjb3VsZCBoYXZlIGNob3NlbiBub3QgdG8gcmVsZWFzZSB0
aGUgUU9NIENQVSBvYmplY3RzDQo+ICA+IGFuZCBrZXB0IHJldXNpbmcgdGhlbS4gVGhpcyBhcHBy
b2FjaCBtaWdodCByZXF1aXJlIHNvbWUgbW9kaWZpY2F0aW9ucw0KPiAgPiB0byB0aGUgYHFkZXZp
Y2VfYWRkKClgIGludGVyZmFjZSB0byByZXRyaWV2ZSB0aGUgb2xkIEFSTUNQVSBvYmplY3QNCj4g
ID4gaW5zdGVhZCBvZiBjcmVhdGluZyBhIG5ldyBvbmUgZm9yIHRoZSBob3RwbHVnIHJlcXVlc3Qu
DQo+ICA+DQo+ICA+IEVhY2ggb2YgdGhlc2UgYXBwcm9hY2hlcyBoYXMgaXRzIG93biBwcm9zIGFu
ZCBjb25zLiBUaGlzIHByb3RvdHlwZQ0KPiAgPiB1c2VzIHRoZSBmaXJzdCBhcHByb2FjaCAoc3Vn
Z2VzdGlvbnMgYXJlIHdlbGNvbWUhKS4NCj4gID4NCj4gID4gQ28tZGV2ZWxvcGVkLWJ5OiBLZXFp
YW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IEtlcWlh
biBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gID4gU2lnbmVkLW9mZi1ieTogU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+IC0tLQ0KPiAgPiAgIGh3L2FybS92
aXJ0LmMgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+ICA+DQo+ICA+IGRpZmYgLS1naXQgYS9ody9h
cm0vdmlydC5jIGIvaHcvYXJtL3ZpcnQuYyBpbmRleA0KPiAgPiA5ZDMzZjMwYTZhLi5hNzJjZDNi
MjBkIDEwMDY0NA0KPiAgPiAtLS0gYS9ody9hcm0vdmlydC5jDQo+ICA+ICsrKyBiL2h3L2FybS92
aXJ0LmMNCj4gID4gQEAgLTIwNTAsNiArMjA1MCw3IEBAIHN0YXRpYyB2b2lkIHZpcnRfY3B1X3Bv
c3RfaW5pdChWaXJ0TWFjaGluZVN0YXRlDQo+ICAqdm1zLCBNZW1vcnlSZWdpb24gKnN5c21lbSkN
Cj4gID4gICB7DQo+ICA+ICAgICAgIENQVUFyY2hJZExpc3QgKnBvc3NpYmxlX2NwdXMgPSB2bXMt
PnBhcmVudC5wb3NzaWJsZV9jcHVzOw0KPiAgPiAgICAgICBpbnQgbWF4X2NwdXMgPSBNQUNISU5F
KHZtcyktPnNtcC5tYXhfY3B1czsNCj4gID4gKyAgICBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElO
RSh2bXMpOw0KPiAgPiAgICAgICBib29sIGFhcmNoNjQsIHN0ZWFsX3RpbWU7DQo+ICA+ICAgICAg
IENQVVN0YXRlICpjcHU7DQo+ICA+ICAgICAgIGludCBuOw0KPiAgPiBAQCAtMjExMSw2ICsyMTEy
LDM3IEBAIHN0YXRpYyB2b2lkIHZpcnRfY3B1X3Bvc3RfaW5pdChWaXJ0TWFjaGluZVN0YXRlDQo+
ICAqdm1zLCBNZW1vcnlSZWdpb24gKnN5c21lbSkNCj4gID4gICAgICAgICAgICAgICB9DQo+ICA+
ICAgICAgICAgICB9DQo+ICA+ICAgICAgIH0NCj4gID4gKw0KPiAgPiArICAgIGlmIChrdm1fZW5h
YmxlZCgpIHx8IHRjZ19lbmFibGVkKCkpIHsNCj4gID4gKyAgICAgICAgZm9yIChuID0gMDsgbiA8
IHBvc3NpYmxlX2NwdXMtPmxlbjsgbisrKSB7DQo+ICA+ICsgICAgICAgICAgICBjcHUgPSBxZW11
X2dldF9wb3NzaWJsZV9jcHUobik7DQo+ICA+ICsNCj4gID4gKyAgICAgICAgICAgIC8qDQo+ICA+
ICsgICAgICAgICAgICAgKiBOb3csIEdJQyBoYXMgYmVlbiBzaXplZCB3aXRoIHBvc3NpYmxlIENQ
VXMgYW5kIHdlIGRvbnQNCj4gIHJlcXVpcmUNCj4gID4gKyAgICAgICAgICAgICAqIGRpc2FibGVk
IHZDUFUgb2JqZWN0cyB0byBiZSByZXByZXNlbnRlZCBpbiB0aGUgUU9NLiBSZWxlYXNlDQo+ICB0
aGUNCj4gID4gKyAgICAgICAgICAgICAqIGRpc2FibGVkIEFSTUNQVSBvYmplY3RzIGVhcmxpZXIg
dXNlZCBkdXJpbmcgaW5pdCBmb3IgcHJlLXNpemluZy4NCj4gID4gKyAgICAgICAgICAgICAqDQo+
ICA+ICsgICAgICAgICAgICAgKiBXZSBmYWtlIHRvIHRoZSBndWVzdCB0aHJvdWdoIEFDUEkgYWJv
dXQgdGhlDQo+ICBwcmVzZW5jZShfU1RBLlBSRVM9MSkNCj4gID4gKyAgICAgICAgICAgICAqIG9m
IHRoZXNlIG5vbi1leGlzdGVudCB2Q1BVcyBhdCBWTU0vcWVtdSBhbmQgcHJlc2VudCB0aGVzZQ0K
PiAgYXMNCj4gID4gKyAgICAgICAgICAgICAqIGRpc2FibGVkIHZDUFVzKF9TVEEuRU5BPTApIHNv
IHRoYXQgdGhleSBjYW50IGJlIHVzZWQuIFRoZXNlDQo+ICB2Q1BVcw0KPiAgPiArICAgICAgICAg
ICAgICogY2FuIGJlIGxhdGVyIGFkZGVkIHRvIHRoZSBndWVzdCB0aHJvdWdoIGhvdHBsdWcgZXhj
aGFuZ2VzDQo+ICB3aGVuDQo+ICA+ICsgICAgICAgICAgICAgKiBBUk1DUFUgb2JqZWN0cyBhcmUg
Y3JlYXRlZCBiYWNrIGFnYWluIHVzaW5nICdkZXZpY2VfYWRkJyBRTVANCj4gID4gKyAgICAgICAg
ICAgICAqIGNvbW1hbmQuDQo+ICA+ICsgICAgICAgICAgICAgKi8NCj4gID4gKyAgICAgICAgICAg
IC8qDQo+ICA+ICsgICAgICAgICAgICAgKiBSRkM6IFF1ZXN0aW9uOiBPdGhlciBhcHByb2FjaCBj
b3VsZCd2ZSBiZWVuIHRvIGtlZXAgdGhlbQ0KPiAgZm9yZXZlcg0KPiAgPiArICAgICAgICAgICAg
ICogYW5kIHJlbGVhc2UgaXQgb25seSBvbmNlIHdoZW4gcWVtdSBleGl0cyBhcyBwYXJ0IG9mIGZp
bmFsaXplIG9yDQo+ICA+ICsgICAgICAgICAgICAgKiB3aGVuIG5ldyB2Q1BVIGlzIGhvdHBsdWdn
ZWQuIEluIHRoZSBsYXRlciBvbGQgY291bGQgYmUgcmVsZWFzZWQNCj4gID4gKyAgICAgICAgICAg
ICAqIGZvciB0aGUgbmV3bHkgY3JlYXRlZCBvYmplY3QgZm9yIHRoZSBzYW1lIHZDUFU/DQo+ICA+
ICsgICAgICAgICAgICAgKi8NCj4gID4gKyAgICAgICAgICAgIGlmICghcWVtdV9lbmFibGVkX2Nw
dShjcHUpKSB7DQo+ICA+ICsgICAgICAgICAgICAgICAgQ1BVQXJjaElkICpjcHVfc2xvdDsNCj4g
ID4gKyAgICAgICAgICAgICAgICBjcHVfc2xvdCA9IHZpcnRfZmluZF9jcHVfc2xvdChtcywgY3B1
LT5jcHVfaW5kZXgpOw0KPiAgPiArICAgICAgICAgICAgICAgIGNwdV9zbG90LT5jcHUgPSBOVUxM
Ow0KPiAgPiArICAgICAgICAgICAgICAgIG9iamVjdF91bnJlZihPQkpFQ1QoY3B1KSk7DQo+ICA+
ICsgICAgICAgICAgICB9DQo+ICA+ICsgICAgICAgIH0NCj4gID4gKyAgICB9DQo+ICA+ICAgfQ0K
PiAgDQo+ICBJdCdzIHByb2JhYmx5IGhhcmQgdG8ga2VlcCB0aG9zZSBBUk1DUFUgb2JqZWN0cyBm
b3JldmVyLiBGaXJzdCBvZiBhbGwsIG9uZQ0KPiAgdkNQVSBjYW4gYmUgaG90LWFkZGVkIGZpcnN0
IGFuZCB0aGVuIGhvdC1yZW1vdmVkIGFmdGVyd2FyZHMuIFdpdGggdGhvc2UNCj4gIEFSTUNQVSBv
YmplY3RzIGtlcHQgZm9yZXZlciwgdGhlIHN5bnRheCBvZiAnZGV2aWNlX2FkZCcgYW5kICdkZXZp
Y2VfZGVsJw0KPiAgYmVjb21lIGJyb2tlbiBhdCBsZWFzdC4NCg0KSSBoYWQgcHJvdG90eXBlZCBi
b3RoIGFwcHJvYWNoZXMgNCB5ZWFycyBiYWNrLiBZZXMsIGludGVyZmFjZSBwcm9ibGVtIHdpdGgN
CmRldmljZV9hZGQgd2FzIHNvbHZlZCBieSBhIHRyaWNrIG9mIGtlZXBpbmcgdGhlIG9sZCB2Q1BV
IG9iamVjdCBhbmQgb24NCmRldmljZV9hZGQgaW5zdGVhZCBvZiBjcmVhdGluZyBhIG5ldyB2Q1BV
IG9iamVjdCB3ZSBjb3VsZCB1c2UgdGhlIG9sZCB2Q1BVDQpvYmplY3QgYW5kIHRoZW4gY2FsbCBx
ZGV2X3JlYWxpemUoKSBvbiBpdC4NCg0KQnV0IGJpZ2dlciBwcm9ibGVtIHdpdGggdGhpcyBhcHBy
b2FjaCBpcyB0aGF0IG9mIG1pZ3JhdGlvbi4gT25seSByZWFsaXplZCBvYmplY3RzDQpoYXZlIHN0
YXRlIHRvIGJlIG1pZ3JhdGVkLiBTbyBpdCBtaWdodCBsb29rIGNsZWFuZXIgb24gb25lIGFzcGVj
dCBidXQgaGFkIGl0cw0Kb3duIGlzc3Vlcy4NCg0KSSB0aGluayBJIGRpZCBzaGFyZSBhIHByb3Rv
dHlwZSBvZiB0aGlzIHdpdGggSWdvciB3aGljaCBoZSB3YXMgbm90IGluIGFncmVlbWVudCB3aXRo
DQphbmQgd2FudGVkIHZDUFUgb2JqZWN0cyB0byBiZSBkZXN0cm95ZWQgbGlrZSBpbiB4ODYuIEhl
bmNlLCB3ZSBzdHVjayB3aXRoDQp0aGUgY3VycmVudCBhcHByb2FjaC4NCg0KDQo+ICBUaGUgaWRl
YWwgbWVjaGFuaXNtIHdvdWxkIGJlIHRvIGF2b2lkIGluc3RhbmNpYXRpbmcgdGhvc2UgQVJNQ1BV
IG9iamVjdHMNCj4gIGFuZCBkZXN0cm95aW5nIHRoZW0gc29vbi4gSSBkb24ndCBrbm93IGlmIG1z
LT5wb3NzaWJsZV9jcHVzLT5jcHVzW10gY2FuDQo+ICBmaXQgYW5kIGhvdyBtdWNoIGVmZm9ydHMg
bmVlZGVkLg0KDQpUaGlzIGlzIHdoYXQgd2UgYXJlIGRvaW5nIG5vdyBpbiB0aGUgY3VycmVudCBh
cHByb2FjaC4gUGxlYXNlIHJlYWQgdGhlIEtWTUZvcnVtDQpzbGlkZXMgb2YgMjAyMyBmb3IgbW9y
ZSBkZXRhaWxzIGFuZCB0aGUgY292ZXIgbGV0dGVyIG9mIFJGQyBWMyBmb3IgbW9yZSBkZXRhaWxz
Lg0KDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0KPiAgDQo+ICBUaGFua3MsDQo+ICBHYXZpbg0KDQo=

