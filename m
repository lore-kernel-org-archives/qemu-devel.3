Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768D5C3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKZR-00068C-49; Thu, 04 Jul 2024 07:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sPKZH-00064X-Tk; Thu, 04 Jul 2024 07:24:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sPKZE-0008Jc-3e; Thu, 04 Jul 2024 07:24:02 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFDlN3pNQz67Q7R;
 Thu,  4 Jul 2024 19:22:40 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
 by mail.maildlp.com (Postfix) with ESMTPS id 3CAFD1404F4;
 Thu,  4 Jul 2024 19:23:47 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 12:23:46 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Thu, 4 Jul 2024 12:23:46 +0100
To: Nicholas Piggin <npiggin@gmail.com>, "qemu-devel@nongnu.org"
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
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
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
Subject: RE: [PATCH RFC V3 13/29] arm/virt: Make ARM vCPU *present* status
 ACPI *persistent*
Thread-Topic: [PATCH RFC V3 13/29] arm/virt: Make ARM vCPU *present* status
 ACPI *persistent*
Thread-Index: AQHavetm6QV9Gwn/C06AbMr+Gg1h1LHl7PmAgACWrRA=
Date: Thu, 4 Jul 2024 11:23:46 +0000
Message-ID: <fd0478a51e4e445da33dadafc00b33f6@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-14-salil.mehta@huawei.com>
 <D2GEV8KD5L3F.FRD8UH16X3GU@gmail.com>
In-Reply-To: <D2GEV8KD5L3F.FRD8UH16X3GU@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.88]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SEkgTmljaywNCg0KVGhhbmtzIGZvciB0YWtpbmcgdGltZSB0byByZXZpZXcuIFBsZWFzZSBmaW5k
IG15IHJlcGxpZXMgaW5saW5lLg0KDQo+ICBGcm9tOiBOaWNob2xhcyBQaWdnaW4gPG5waWdnaW5A
Z21haWwuY29tPg0KPiAgU2VudDogVGh1cnNkYXksIEp1bHkgNCwgMjAyNCAzOjQ5IEFNDQo+ICBU
bzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdu
dS5vcmc7DQo+ICBxZW11LWFybUBub25nbnUub3JnOyBtc3RAcmVkaGF0LmNvbQ0KPiAgDQo+ICBP
biBGcmkgSnVuIDE0LCAyMDI0IGF0IDk6MzYgQU0gQUVTVCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+
ICA+IEFSTSBhcmNoIGRvZXMgbm90IGFsbG93IENQVXMgcHJlc2VuY2UgdG8gYmUgY2hhbmdlZCBb
MV0gYWZ0ZXIga2VybmVsDQo+ICBoYXMgYm9vdGVkLg0KPiAgPiBIZW5jZSwgZmlybXdhcmUvQUNQ
SS9RZW11IG11c3QgZW5zdXJlIHBlcnNpc3RlbnQgdmlldyBvZiB0aGUgdkNQVXMgIHRvDQo+ICA+
IHRoZSBHdWVzdCBrZXJuZWwgZXZlbiB3aGVuIHRoZXkgYXJlIG5vdCBwcmVzZW50IGluIHRoZSBR
b00gaS5lLiBhcmUNCj4gID4gdW5wbHVnZ2VkIG9yIGFyZSB5ZXQtdG8tYmUtcGx1Z2dlZA0KPiAg
DQo+ICBEbyB5b3UgbmVlZCBhcmNoLWluZGVwZW5kZW50IHN0YXRlIGZvciB0aGlzPyBJZiBBUk0g
YWx3YXlzIHJlcXVpcmVzIGl0DQo+ICB0aGVuIGNhbiBpdCBiZSBpbXBsZW1lbnRlZCBiZXR3ZWVu
IGFybSBhbmQgYWNwaSBpbnRlcmZhY2U/DQoNCg0KWWVzLCB3ZSBkbyBuZWVkIGFzIHdlIGNhbm5v
dCBzYXkgaWYgdGhlIHNhbWUgY29uc3RyYWludCBhcHBsaWVzIHRvIG90aGVyDQphcmNoaXRlY3R1
cmVzIGFzIHdlbGwuIEFib3ZlIHN0YXRlZCBjb25zdHJhaW50IGFmZmVjdHMgaG93IHRoZSBhcmNo
aXRlY3R1cmUNCmNvbW1vbiBBQ1BJIENQVSBjb2RlIGlzIGluaXRpYWxpemVkLg0KDQoNCj4gIA0K
PiAgSWYgbm90LCB0aGVuIHBlcmhhcHMgY291bGQgaXQgYmUgZG9uZSBpbiB0aGUgcGF0Y2ggdGhh
dCBpbnRyb2R1Y2VzIGFsbCB0aGUNCj4gIG90aGVyIHN0YXRlPw0KPiAgDQo+ICA+IFJlZmVyZW5j
ZXM6DQo+ICA+IFsxXSBDaGVjayBjb21tZW50IDUgaW4gdGhlIGJ1Z3ppbGxhIGVudHJ5DQo+ICA+
ICAgIExpbms6IGh0dHBzOi8vYnVnemlsbGEudGlhbm9jb3JlLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
NDQ4MSNjNQ0KPiAgDQo+ICBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IChhbmQgSSBkb24ndCBr
bm93IEFDUEksIHNvIGl0J3MgbGlrZWx5IEkgZG9uJ3QpLCB0aGF0IGlzDQo+ICBhbmQgdXBkYXRl
IHRvIEFDUEkgc3BlYyB0byBzYXkgc29tZSBiaXQgaW4gQUNQSSB0YWJsZSBtdXN0IHJlbWFpbiBz
ZXQNCj4gIHJlZ2FyZGxlc3Mgb2YgQ1BVIGhvdHBsdWcgc3RhdGUuDQoNCg0KQVJNIGRvZXMgbm90
IGNsYWltcyBhbnl0aGluZyByZWxhdGVkIHRvIENQVSBob3RwbHVnIHJpZ2h0IG5vdy4gSXQgc2lt
cGx5DQpkb2VzIG5vdCBleGlzdHMuIFRoZSBBQ1BJIHVwZGF0ZSBpcyBzaW1wbHkgcmVpbmZvcmNp
bmcgdGhlIGV4aXN0aW5nIGZhY3QgdGhhdA0KX1NUQS5QcmVzZW50IGJpdCBpbiB0aGUgQUNQSSBz
cGVjIGNhbm5vdCBiZSBjaGFuZ2VkIGFmdGVyIHN5c3RlbSBoYXMgYm9vdGVkLiANCg0KVGhpcyBp
cyAgYmVjYXVzZSBmb3IgQVJNIGFyY2ggdGhlcmUgYXJlIG1hbnkgb3RoZXIgaW5pdGlhbGl6YXRp
b25zIHdoaWNoIGRlcGVuZA0KdXBvbiB0aGUgZXhhY3QgYXZhaWxhYmlsaXR5IG9mIENQVSBjb3Vu
dCBkdXJpbmcgYm9vdCBhbmQgdGhleSBkbyBub3QgZXhwZWN0DQp0aGF0IHRvIGNoYW5nZSBhZnRl
ciBib290LiBGb3IgZXhhbXBsZSwgdGhlcmUgYXJlIHNvIG1hbnkgcGVyLUNQVSBmZWF0dXJlcw0K
YW5kIHRoZSBHSUMgQ1BVIGludGVyZmFjZSBldGMuIHdoaWNoIGFsbCBleHBlY3QgdGhpcyB0byBi
ZSBmaXhlZCBhdCBib290IHRpbWUuDQpUaGlzIGlzIGltbXV0YWJsZSByZXF1aXJlbWVudCBmcm9t
IEFSTS4NCg0KDQo+ICANCj4gIFJlZmVyZW5jZSBsaW5rcyBhcmUgZ29vZCwgSSB0aGluayBpdCB3
b3VsZCBiZSBuaWNlIHRvIGFkZCBhIHNtYWxsIHN1bW1hcnkgaW4NCj4gIHRoZSBjaGFuZ2Vsb2cg
dG9vLg0KDQpzdXJlLiBJIHdpbGwgZG8uDQoNClRoYW5rcw0KU2FsaWwuDQoNCj4gIA0KPiAgVGhh
bmtzLA0KPiAgTmljaw0KPiAgDQo+ICA+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgPiAtLS0NCj4gID4gIGNwdS1jb21tb24uYyAg
ICAgICAgICB8ICA2ICsrKysrKw0KPiAgPiAgaHcvYXJtL3ZpcnQuYyAgICAgICAgIHwgIDcgKysr
KysrKw0KPiAgPiAgaW5jbHVkZS9ody9jb3JlL2NwdS5oIHwgMjEgKysrKysrKysrKysrKysrKysr
KysrDQo+ICA+ICAzIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4gID4NCj4gID4g
ZGlmZiAtLWdpdCBhL2NwdS1jb21tb24uYyBiL2NwdS1jb21tb24uYyBpbmRleA0KPiAgNDlkMmE1
MDgzNS4uZTRiNGRlZTk5YQ0KPiAgPiAxMDA2NDQNCj4gID4gLS0tIGEvY3B1LWNvbW1vbi5jDQo+
ICA+ICsrKyBiL2NwdS1jb21tb24uYw0KPiAgPiBAQCAtMTI4LDYgKzEyOCwxMiBAQCBib29sIHFl
bXVfZW5hYmxlZF9jcHUoQ1BVU3RhdGUgKmNwdSkNCj4gID4gICAgICByZXR1cm4gY3B1ICYmICFj
cHUtPmRpc2FibGVkOw0KPiAgPiAgfQ0KPiAgPg0KPiAgPiArYm9vbCBxZW11X3BlcnNpc3RlbnRf
Y3B1KENQVVN0YXRlICpjcHUpIHsNCj4gID4gKyAgICAvKiBjcHUgc3RhdGUgY2FuIGJlIGZha2Vk
IHRvIHRoZSBndWVzdCB2aWEgYWNwaSAqLw0KPiAgPiArICAgIHJldHVybiBjcHUgJiYgY3B1LT5h
Y3BpX3BlcnNpc3RlbnQ7IH0NCj4gID4gKw0KPiAgPiAgdWludDY0X3QgcWVtdV9nZXRfY3B1X2Fy
Y2hpZChpbnQgY3B1X2luZGV4KSAgew0KPiAgPiAgICAgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNI
SU5FKHFkZXZfZ2V0X21hY2hpbmUoKSk7IGRpZmYgLS1naXQNCj4gID4gYS9ody9hcm0vdmlydC5j
IGIvaHcvYXJtL3ZpcnQuYyBpbmRleCA1Zjk4MTYyNTg3Li45ZDMzZjMwYTZhIDEwMDY0NA0KPiAg
PiAtLS0gYS9ody9hcm0vdmlydC5jDQo+ICA+ICsrKyBiL2h3L2FybS92aXJ0LmMNCj4gID4gQEAg
LTMwMTYsNiArMzAxNiwxMyBAQCBzdGF0aWMgdm9pZCB2aXJ0X2NwdV9wcmVfcGx1ZyhIb3RwbHVn
SGFuZGxlcg0KPiAgKmhvdHBsdWdfZGV2LCBEZXZpY2VTdGF0ZSAqZGV2LA0KPiAgPiAgICAgICAg
ICByZXR1cm47DQo+ICA+ICAgICAgfQ0KPiAgPiAgICAgIHZpcnRfY3B1X3NldF9wcm9wZXJ0aWVz
KE9CSkVDVChjcyksIGNwdV9zbG90LCBlcnJwKTsNCj4gID4gKw0KPiAgPiArICAgIC8qDQo+ICA+
ICsgICAgICogVG8gZ2l2ZSBwZXJzaXN0ZW50IHByZXNlbmNlIHZpZXcgb2YgdkNQVXMgdG8gdGhl
IGd1ZXN0LCBBQ1BJIG1pZ2h0DQo+ICBuZWVkDQo+ICA+ICsgICAgICogdG8gZmFrZSB0aGUgcHJl
c2VuY2Ugb2YgdGhlIHZDUFVzIHRvIHRoZSBndWVzdCBidXQga2VlcCB0aGVtDQo+ICBkaXNhYmxl
ZC4NCj4gID4gKyAgICAgKiBUaGlzIHNoYWxsIGJlIHVzZWQgZHVyaW5nIHRoZSBpbml0IG9mIEFD
UEkgSG90cGx1ZyBzdGF0ZSBhbmQgaG90LQ0KPiAgdW5wbHVnDQo+ICA+ICsgICAgICovDQo+ICA+
ICsgICAgIGNzLT5hY3BpX3BlcnNpc3RlbnQgPSB0cnVlOw0KPiAgPiAgfQ0KPiAgPg0KPiAgPiAg
c3RhdGljIHZvaWQgdmlydF9jcHVfcGx1ZyhIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsIERl
dmljZVN0YXRlDQo+ICA+ICpkZXYsIGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2NvcmUvY3B1Lmgg
Yi9pbmNsdWRlL2h3L2NvcmUvY3B1LmggaW5kZXgNCj4gID4gNjJlNjg2MTFjMC4uZTEzZTU0MjE3
NyAxMDA2NDQNCj4gID4gLS0tIGEvaW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+ICA+ICsrKyBiL2lu
Y2x1ZGUvaHcvY29yZS9jcHUuaA0KPiAgPiBAQCAtNTQwLDYgKzU0MCwxNCBAQCBzdHJ1Y3QgQ1BV
U3RhdGUgew0KPiAgPiAgICAgICAqIGV2ZXJ5IENQVVN0YXRlIGlzIGVuYWJsZWQgYWNyb3NzIGFs
bCBhcmNoaXRlY3R1cmVzLg0KPiAgPiAgICAgICAqLw0KPiAgPiAgICAgIGJvb2wgZGlzYWJsZWQ7
DQo+ICA+ICsgICAgLyoNCj4gID4gKyAgICAgKiBPbiBjZXJ0YWluIGFyY2hpdGVjdHVyZXMsIHRv
IHByb3ZpZGUgYSBwZXJzaXN0ZW50IHZpZXcgb2YgdGhlDQo+ICAncHJlc2VuY2UnDQo+ICA+ICsg
ICAgICogb2YgdkNQVXMgdG8gdGhlIGd1ZXN0LCBBQ1BJIG1pZ2h0IG5lZWQgdG8gZmFrZSB0aGUg
J3ByZXNlbmNlJyBvZiB0aGUNCj4gID4gKyAgICAgKiB2Q1BVcyBidXQga2VlcCB0aGVtIEFDUEkt
ZGlzYWJsZWQgZm9yIHRoZSBndWVzdC4gVGhpcyBpcyBhY2hpZXZlZA0KPiAgYnkNCj4gID4gKyAg
ICAgKiByZXR1cm5pbmcgYF9TVEEuUFJFUz1UcnVlYCBhbmQgYF9TVEEuRW5hPUZhbHNlYCBmb3Ig
dGhlIHVucGx1Z2dlZA0KPiAgdkNQVXMNCj4gID4gKyAgICAgKiBpbiBRRU1VIFFvTS4NCj4gID4g
KyAgICAgKi8NCj4gID4gKyAgICBib29sIGFjcGlfcGVyc2lzdGVudDsNCj4gID4NCj4gID4gICAg
ICAvKiBUT0RPIE1vdmUgY29tbW9uIGZpZWxkcyBmcm9tIENQVUFyY2hTdGF0ZSBoZXJlLiAqLw0K
PiAgPiAgICAgIGludCBjcHVfaW5kZXg7DQo+ICA+IEBAIC05NTksNiArOTY3LDE5IEBAIGJvb2wg
cWVtdV9wcmVzZW50X2NwdShDUFVTdGF0ZSAqY3B1KTsNCj4gID4gICAqLw0KPiAgPiAgYm9vbCBx
ZW11X2VuYWJsZWRfY3B1KENQVVN0YXRlICpjcHUpOw0KPiAgPg0KPiAgPiArLyoqDQo+ICA+ICsg
KiBxZW11X3BlcnNpc3RlbnRfY3B1Og0KPiAgPiArICogQGNwdTogVGhlIHZDUFUgdG8gY2hlY2sN
Cj4gID4gKyAqDQo+ICA+ICsgKiBDaGVja3MgaWYgdGhlIHZDUFUgc3RhdGUgc2hvdWxkIGFsd2F5
cyBiZSByZWZsZWN0ZWQgYXMgKnByZXNlbnQqDQo+ICA+ICt2aWEgQUNQSQ0KPiAgPiArICogdG8g
dGhlIEd1ZXN0LiBCeSBkZWZhdWx0LCB0aGlzIGlzIEZhbHNlIG9uIGFsbCBhcmNoaXRlY3R1cmVz
IGFuZA0KPiAgPiAraGFzIHRvIGJlDQo+ICA+ICsgKiBleHBsaWNpdHkgc2V0IGR1cmluZyBpbml0
aWFsaXphdGlvbi4NCj4gID4gKyAqDQo+ICA+ICsgKiBSZXR1cm5zOiBUcnVlIGlmIGl0IGlzIEFD
UEkgJ3BlcnNpc3RlbnQnIENQVQ0KPiAgPiArICoNCj4gID4gKyAqLw0KPiAgPiArYm9vbCBxZW11
X3BlcnNpc3RlbnRfY3B1KENQVVN0YXRlICpjcHUpOw0KPiAgPiArDQo+ICA+ICAvKioNCj4gID4g
ICAqIHFlbXVfZ2V0X2NwdV9hcmNoaWQ6DQo+ICA+ICAgKiBAY3B1X2luZGV4OiBwb3NzaWJsZSB2
Q1BVIGZvciB3aGljaCBhcmNoLWlkIG5lZWRzIHRvIGJlIHJldHJlaXZlZA0KDQo=

