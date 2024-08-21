Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1807AC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 10:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgiVP-0003iw-KR; Wed, 21 Aug 2024 06:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sgiVH-0003hF-H7; Wed, 21 Aug 2024 06:23:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sgiVA-0004vx-Tw; Wed, 21 Aug 2024 06:23:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wpj4s3WLlz6FH2w;
 Wed, 21 Aug 2024 18:19:57 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
 by mail.maildlp.com (Postfix) with ESMTPS id D58F51400DB;
 Wed, 21 Aug 2024 18:23:35 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 11:23:35 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 21 Aug 2024 11:23:35 +0100
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
Thread-Index: AQHaveuckEaR/Tp4NUKcalC/yUyS9LIksGYAgAo1aXCAALcOgIABH0kAgADc+ICAAEc9cA==
Date: Wed, 21 Aug 2024 10:23:35 +0000
Message-ID: <1c31ab30bae6437fac7799227ca4bfd1@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-18-salil.mehta@huawei.com>
 <51dc0813-7dc9-4927-a24b-bd718be54e46@redhat.com>
 <6b435c1f2b934867b8d82850d6d866c6@huawei.com>
 <9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com>
 <1252c2d35b3e40ed84d5d5ae454878a7@huawei.com>
 <d2371011-e7a3-42fe-b1a3-a185fbf4a612@redhat.com>
In-Reply-To: <d2371011-e7a3-42fe-b1a3-a185fbf4a612@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.245]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
ZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyMSwgMjAyNCA3OjI1IEFNDQo+ICBUbzogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ICBx
ZW11LWFybUBub25nbnUub3JnOyBtc3RAcmVkaGF0LmNvbQ0KPiAgDQo+ICBIaSBTYWxpbCwNCj4g
IA0KPiAgT24gOC8yMS8yNCAyOjQwIEFNLCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gID4NCj4gID4g
SSBkb27igJl0IHVuZGVyc3RhbmQgdGhpcyBjbGVhcmx5LiBBcmUgIHlvdSBzdWdnZXN0aW5nIHRv
IHJldXNlIG9ubHkNCj4gID4gc2luZ2xlIHZDUFUgb2JqZWN0IHRvIGluaXRpYWxpemUgYWxsIEtW
TSB2Q1BVcyBub3QgeWV0IHBsdWdnZWQ/IElmDQo+ICA+IHllcywgdGhlbiBJJ20gbm90IHN1cmUg
d2hhdCBkbyB3ZSBnYWluIGhlcmUgYnkgYWRkaW5nIHRoaXMgY29tcGxleGl0eT8NCj4gID4gSXQg
ZG9lcyBub3QgY29uc3VtZSB0aW1lIG9yIHJlc291cmNlcyBiZWNhdXNlIHdlIGFyZSBub3QgcmVh
bGl6aW5nIGFueQ0KPiAgPiBvZiB0aGVzZSB2Q1BVIG9iamVjdCBpbiBhbnkgY2FzZS4NCj4gID4N
Cj4gIA0KPiAgRmlyc3Qgb2YgYWxsLCBpdCBzZWVtcyB3ZSBoYXZlIGRpZmZlcmVudCBuYW1lcyBh
bmQgdGVybXMgZm9yIHRob3NlIGNvbGQtDQo+ICBib290ZWQgdkNQVXMgYW5kIGhvdHBsdWdnYWJs
ZSB2Q1BVcy4gRm9yIGV4YW1wbGUsIHZDUFUtMCBhbmQgdkNQVS0xDQo+ICBhcmUgY29sZC1ib290
ZWQgdkNQVXMgd2hpbGUNCj4gIHZDUFUtMiBhbmQgdkNQVS0zIGFyZSBob3RwbHVnZ2FibGUgdkNQ
VXMgd2hlbiB3ZSBoYXZlICctc21wDQo+ICBtYXhjcHVzPTQsY3B1cz0yJy4gTGV0cyBzdGljayB0
byBjb252ZW50aW9uIGFuZCB0ZXJtcyBmb3IgZWFzaWVyIGRpc2N1c3Npb24uDQo+ICANCj4gIFRo
ZSBpZGVhIGlzIGF2b2lkIGluc3RhbnRpYXRpbmcgaG90cGx1Z2dhYmxlIHZDUFVzIGluIHZpcnRt
YWNoX2luaXQoKSBhbmQNCj4gIHJlbGVhc2VkIGluIHRoZSBzYW1lIGZ1bmN0aW9uIGZvciB0aG9z
ZSBob3RwbHVnZ2FibGUgdkNQVXMuIEFzIEkgY2FuDQo+ICB1bmRlcnN0YW5kLCB0aG9zZSBob3Rw
bHVnZ2FibGUgdkNQVSBpbnN0YW5jZXMgYXJlIHNlcnZpbmcgZm9yIHR3bw0KPiAgcHVycG9zZXM6
ICgxKSBSZWxheCB0aGUgY29uc3RyYWludCB0aGF0IGFsbCB2Q1BVJ3MgKGt2bSkgZmlsZSBkZXNj
cmlwdG9yIGhhdmUNCj4gIHRvIGJlIGNyZWF0ZWQgYW5kIHBvcHVsYXRlZDsgDQoNCg0KV2UgYXJl
IGRldmlzaW5nICp3b3JrYXJvdW5kcyogaW4gUWVtdSBmb3IgdGhlIEFSTSBDUFUgYXJjaGl0ZWN0
dXJhbCBjb25zdHJhaW50cw0KaW4gS1ZNIGFuZCBpbiBHdWVzdCBLZXJuZWwsICAqbm90IHJlbGF4
aW5nKiB0aGVtLiBXZSBhcmUgbm90IGFsbG93ZWQgdG8gbWVkZGxlIHdpdGgNCnRoZSBjb25zdHJh
aW50cy4gVGhhdCBpcyB0aGUgd2hvbGUgcG9pbnQuDQoNCk5vdCBoYXZpbmcgdG8gcmVzcGVjdCB0
aG9zZSBjb25zdHJhaW50cyBsZWQgdG8gcmVqZWN0aW9uIG9mIHRoZSBlYXJsaWVyIGF0dGVtcHRz
IHRvDQp1cHN0cmVhbSBWaXJ0dWFsIENQVSBIb3RwbHVnIGZvciBBUk0uDQoNCg0KKDIpIEhlbHAg
dG8gaW5zdGFudGlhdGUgYW5kIHJlYWxpemUNCj4gIEdJQ3YzIG9iamVjdC4NCj4gIA0KPiAgRm9y
ICgxKSwgSSBkb24ndCB0aGluayB3ZSBoYXZlIHRvIGluc3RhbnRpYXRlIHRob3NlIGhvdHBsdWdn
YWJsZSB2Q1BVcyBhdCBhbGwuDQo+ICBJbiB0aGUgYWJvdmUgZXhhbXBsZSB3aGVyZSB3ZSBoYXZl
IGNvbW1hbmQgbGluZSAnLXNtcA0KPiAgbWF4Y3B1cz00LGNwdXM9MicsIGl0J3MgdW5uZWNlc3Nh
cnkgdG8gaW5zdGFudGlhdGUNCj4gIHZDUFUtMyBhbmQgdkNQVS00IHRvIGNyZWF0ZSBhbmQgcG9w
dWxhdGUgdGhlaXIgS1ZNIGZpbGUgZGVzY3JpcHRvcnMuDQoNCg0KV2UgY2Fubm90IGRlZmVyIGNy
ZWF0ZSB2Q1BVIGluIEtWTSBhZnRlciBHSUMgaGFzIGJlZW4gaW5pdGlhbGl6ZWQgaW4gS1ZNLg0K
SXQgbmVlZHMgdG8ga25vdyBldmVyeSB2Q1BVIHRoYXQgd2lsbCBldmVyIGV4aXN0cyByaWdodCBh
dCB0aGUgdGltZSBpdCBpcyBnZXR0aW5nDQpJbml0aWFsaXplZC4gVGhpcyBpcyBhbiBBUk0gQ1BV
IEFyY2hpdGVjdHVyYWwgY29uc3RyYWludC4gDQoNCg0KIEENCj4gIHZDUFUncyBLVk0gZmlsZSBk
ZXNjcmlwdG9yIGlzIGNyZWF0ZSBhbmQgcG9wdWxhdGVkIGJ5IHRoZSBmb2xsb3dpbmcgaW9jdGxz
DQo+ICBhbmQgZnVuY3Rpb24gY2FsbHMuIFdoZW4gdGhlIGZpcnN0IHZDUFUgKHZDUFUtMCkgaXMg
cmVhbGl6ZWQsIHRoZSBwcm9wZXJ0eQ0KPiAgY29ycmVzcG9uZGluZyB0byAiJmluaXQiIGlzIGZp
eGVkIGZvciBhbGwgdkNQVXMuIEl0IG1lYW5zIGFsbCB2Q1BVcyBoYXZlIHNhbWUNCj4gIHByb3Bl
cnRpZXMgZXhjZXB0IHRoZSAidmNwdV9pbmRleCIuDQo+ICANCj4gICAgIGlvY3RsKHZtLWZkLCAg
IEtWTV9DUkVBVEVfVkNQVSwgICB2Y3B1X2luZGV4KTsNCj4gICAgIGlvY3RsKHZjcHUtZmQsIEtW
TV9BUk1fVkNQVV9JTklULCAmaW5pdCk7DQo+ICAgICBrdm1fcGFya192Y3B1KGNzKTsNCj4gIA0K
PiAgQSB2Q1BVJ3MgcHJvcGVydGllcyBhcmUgZGV0ZXJtaW5lZCBieSB0d28gc291cmNlcyBhbmQg
Ym90aCBhcmUgZ2xvYmFsLiBJdA0KPiAgbWVhbnMgYWxsIHZDUFVzIHNob3VsZCBoYXZlIHNhbWUg
cHJvcGVydGllczogKGEpIEZlYXR1cmUgcmVnaXN0ZXJzDQo+ICByZXR1cm5lZCBmcm9tIHRoZSBo
b3N0LiBUaGUgZnVuY3Rpb24NCj4gIGt2bV9hcm1fZ2V0X2hvc3RfY3B1X2ZlYXR1cmVzKCkgaXMg
Y2FsbGVkIGZvciBvbmNlLCBtZWFuaW5nIHRoaXMgc291cmNlDQo+ICBpcyBzYW1lIHRvIGFsbCB2
Q1BVczsNCg0KDQpTdXJlLCBidXQgd2hhdCBhcmUgeW91IHRyeWluZyB0byBzYXZlIGhlcmU/DQoN
Cg0KPiAgKGIpIFRoZSBwYXJhbWV0ZXJzIHByb3ZpZGVkIGJ5IHVzZXIgdGhyb3VnaCAnLWNwdSBo
b3N0LHN2ZT1vZmYnIGFyZQ0KPiAgdHJhbnNsYXRlZCB0byBnbG9iYWwgcHJvcGVydGllcyBhbmQg
YXBwbGllZCB0byBhbGwgdkNQVXMgd2hlbiB0aGV5J3JlDQo+ICBpbnN0YW50aWF0ZWQuDQoNCg0K
U3VyZS4gU2FtZSBpcyB0aGUgY2FzZSB3aXRoIFBNVSBhbmQgb3RoZXIgcGVyLXZDUFUgcGFyYW1l
dGVycy4NCldlIGRvIG5vdCBzdXBwb3J0IGhldGVyb2dlbm91cyBjb21wdXRpbmcgYW5kIHRoZXJl
Zm9yZSB3ZSBkbyBub3QNCmhhdmUgcGVyLXZDUFUgY29udHJvbCBvZiB0aGVzZSBmZWF0dXJlcyBh
cyBvZiBub3cuDQoNCg0KPiAgDQo+ICAgICAgICAgKGEpICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAoYikNCj4gIA0KPiAgICAgYWFyY2g2NF9ob3N0X2luaXRmbiAg
ICAgICAgICAgICAgICAgICAgICAgICAgcWVtdV9pbml0DQo+ICAgICBrdm1fYXJtX3NldF9jcHVf
ZmVhdHVyZXNfZnJvbV9ob3N0ICAgICAgICAgICBwYXJzZV9jcHVfb3B0aW9uDQo+ICAgICAgIGt2
bV9hcm1fZ2V0X2hvc3RfY3B1X2ZlYXR1cmVzICAgICAgICAgICAgICBjcHVfY29tbW9uX3BhcnNl
X2ZlYXR1cmVzDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBxZGV2X3Byb3BfcmVnaXN0ZXJfZ2xvYmFsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV9wb3N0X2luaXQNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfcHJvcF9zZXRfZ2xvYmFs
cw0KDQoNClN1cmUsIEkgdW5kZXJzdGFuZCB0aGUgY29kZSBmbG93IGJ1dCB3aGF0IGFyZSB5b3Ug
dHJ5aW5nIHRvIHN1Z2dlc3QgaGVyZT8NCg0KDQo+ICBGb3IgKDIpLCBJJ20gc3RpbGwgbG9va2lu
ZyBpbnRvIHRoZSBHSUN2MyBjb2RlIGZvciBiZXR0ZXIgdW5kZXJzdGFuZGluZy4gDQoNCg0KT2gs
IEkgdGhvdWdodCB5b3Ugc2FpZCB5b3UndmUgZmluaXNoZWQgeW91ciByZXZpZXdzIPCfmIoNCg0K
UGxlYXNlIHRha2UgeW91ciB0aW1lLiBGb3IgeW91ciByZWZlcmVuY2UsIHlvdSBtaWdodCB3YW50
IHRvIGNoZWNrOg0KDQpLVk1Gb3J1bSAyMDIzOg0KaHR0cHM6Ly9rdm0tZm9ydW0ucWVtdS5vcmcv
MjAyMy9DaGFsbGVuZ2VzX1JldmlzaXRlZF9pbl9TdXBwb3J0aW5nX1ZpcnRfQ1BVX0hvdHBsdWdf
LV9faWkwaU5iMy5wZGYNCmh0dHBzOi8va3ZtLWZvcnVtLnFlbXUub3JnLzIwMjMvS1ZNLWZvcnVt
LWNwdS1ob3RwbHVnXzdPSjFZeUoucGRmDQoNCktWTUZvcnVtIDIwMjA6DQpodHRwczovL2t2bS1m
b3J1bS5xZW11Lm9yZy8yMDIwL09jdCUyMDI5X0NoYWxsZW5nZXMlMjBpbiUyMFN1cHBvcnRpbmcl
MjBWaXJ0dWFsJTIwQ1BVJTIwSG90cGx1ZyUyMGluJTIwU29DJTIwQmFzZWQlMjBTeXN0ZW1zJTIw
bGlrZSUyMEFSTTY0X1NhbGlsJTIwTWVodGEucGRmDQoNCg0KVW50aWwNCj4gIG5vdywgSSBkb24n
dCBzZWUgd2UgbmVlZCB0aGUgaW5zdGFudGlhdGVkIGhvdHBsdWdnYWJsZSB2Q1BVcyBlaXRoZXIu
DQoNCg0KSSB0aGluaywgSSd2ZSBhbHJlYWR5IGFuc3dlcmVkIHRoaXMgYWJvdmUgaXQgaXMgYmVj
YXVzZSBvZiBBUk0gQXJjaGl0ZWN0dXJhbCBjb25zdHJhaW50Lg0KDQoNCiBGb3INCj4gIGV4YW1w
bGUsIHRoZSByZWRpc3RyaWJ1dG9yIHJlZ2lvbnMgY2FuIGJlIGV4cG9zZWQgYmFzZWQgb24gJ21h
eGNwdXMnDQo+ICBpbnN0ZWFkIG9mICdjcHVzJy4gDQoNCllvdSBtZWFuIGR1cmluZyB0aGUgcmV2
aWV3IG9mIHRoZSBjb2RlIHlvdSBmb3VuZCB0aGF0IHdlIGFyZSBub3QgZG9pbmcgaXQ/DQoNCg0K
VGhlIElSUSBjb25uZWN0aW9uIGFuZCB0ZWFyZG93biBjYW4gYmUgZHluYW1pY2FsbHkNCj4gIGRv
bmUgYnkgY29ubmVjdGluZyB0aGUgYm9hcmQgd2l0aCBHSUN2MyB0aHJvdWdoIGNhbGxiYWNrcyBp
bg0KPiAgQVJNR0lDdjNDb21tb25DbGFzcy4NCj4gIFRoZSBjb25uZWN0aW9uIGJldHdlZW4gR0lD
djNDUFVTdGF0ZSBhbmQgQ1BVQVJNU3RhdGUgYWxzbyBjYW4gYmUNCj4gIGRvbmUgZHluYW1pY2Fs
bHkuDQoNCkFyZSB5b3Ugc3VnZ2VzdGluZyB0aGlzIGFmdGVyIHJldmlld2luZyB0aGUgY29kZSBv
ciB5b3UgaGF2ZSB0byByZXZpZXcgaXQgeWV0PyDwn5iJDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0K
DQo+ICANCj4gIFRoYW5rcywNCj4gIEdhdmluDQo+ICANCg0K

