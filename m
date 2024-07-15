Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9771C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMXw-0005mv-I7; Mon, 15 Jul 2024 10:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTMXu-0005mR-TW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:19:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTMXs-0000Tr-9Z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:19:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WN4635TZfz6K73h;
 Mon, 15 Jul 2024 22:17:31 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 421691400CB;
 Mon, 15 Jul 2024 22:19:13 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 15:19:12 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 15 Jul 2024 15:19:12 +0100
To: Salil Mehta <salil.mehta@huawei.com>, Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHa1VIYzbBqk8ub30G0ZXbYzNwFGLH3waYAgAASi1CAAAR3IA==
Date: Mon, 15 Jul 2024 14:19:12 +0000
Message-ID: <3848723ea2584b9b813c3d76e1e6dd59@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715155436.577d34c5@imammedo.users.ipa.redhat.com>
 <b93b570158794e28bf8c00a949afa8b4@huawei.com>
In-Reply-To: <b93b570158794e28bf8c00a949afa8b4@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.92]
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

PiAgRnJvbTogcWVtdS1hcm0tYm91bmNlcytzYWxpbC5tZWh0YT1odWF3ZWkuY29tQG5vbmdudS5v
cmcgPHFlbXUtDQo+ICBhcm0tYm91bmNlcytzYWxpbC5tZWh0YT1odWF3ZWkuY29tQG5vbmdudS5v
cmc+IE9uIEJlaGFsZiBPZiBTYWxpbA0KPiAgTWVodGEgdmlhDQo+ICBTZW50OiBNb25kYXksIEp1
bHkgMTUsIDIwMjQgMzoxNCBQTQ0KPiAgVG86IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhh
dC5jb20+DQo+ICANCj4gIEhpIElnb3IsDQo+ICANCj4gID4gIEZyb206IElnb3IgTWFtbWVkb3Yg
PGltYW1tZWRvQHJlZGhhdC5jb20+DQo+ICA+ICBTZW50OiBNb25kYXksIEp1bHkgMTUsIDIwMjQg
Mjo1NSBQTQ0KPiAgPiAgVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiAgPg0KPiAgPiAgT24gU2F0LCAxMyBKdWwgMjAyNCAxOToyNTowOSArMDEwMA0KPiAgPiAgU2Fs
aWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdyb3RlOg0KPiAgPg0KPiAgPiAgPiBb
Tm90ZTogUmVmZXJlbmNlcyBhcmUgcHJlc2VudCBhdCB0aGUgbGFzdCBhZnRlciB0aGUgcmV2aXNp
b24NCj4gID4gaGlzdG9yeV0gID4gID4gVmlydHVhbCBDUFUgaG90cGx1ZyBzdXBwb3J0IGlzIGJl
aW5nIGFkZGVkIGFjcm9zcw0KPiAgPiB2YXJpb3VzIGFyY2hpdGVjdHVyZXMgIFsxXVszXS4NCj4g
ID4gID4gVGhpcyBzZXJpZXMgYWRkcyB2YXJpb3VzIGNvZGUgYml0cyBjb21tb24gYWNyb3NzIGFs
bCBhcmNoaXRlY3R1cmVzOg0KPiAgPiAgPg0KPiAgPiAgPiAxLiB2Q1BVIGNyZWF0aW9uIGFuZCBQ
YXJraW5nIGNvZGUgcmVmYWN0b3IgW1BhdGNoIDFdIDIuIFVwZGF0ZSBBQ1BJDQo+ICA+ID4gR0VE
IGZyYW1ld29yayB0byBzdXBwb3J0IHZDUFUgSG90cGx1ZyBbUGF0Y2ggMiwzXSAzLiBBQ1BJIENQ
VXMgQU1MDQo+ICA+ID4gY29kZSBjaGFuZ2UgW1BhdGNoIDQsNV0gNC4gSGVscGVyIGZ1bmN0aW9u
cyB0byBzdXBwb3J0IHVucmVhbGl6YXRpb24NCj4gID4gPiBvZiBDUFUgb2JqZWN0cyBbUGF0Y2gg
Niw3XQ0KPiAgPg0KPiAgPiAgd2l0aCBwYXRjaCAxIGFuZCAzIGZpeGVkIHNob3VsZCBiZSBnb29k
IHRvIGdvLg0KPiAgPg0KPiAgPiAgU2FsaWwsDQo+ICA+ICBDYW4geW91IHJlbWluZCBtZSB3aGF0
IGhhcHBlbmVkIHRvIG1pZ3JhdGlvbiBwYXJ0IG9mIHRoaXM/DQo+ICA+ICBJZGVhbGx5IGl0IHNo
b3VsZCBiZSBhIHBhcnQgb2Ygb2YgdGhpcyBzZXJpZXMgYXMgaXQgc2hvdWxkIGJlIGNvbW1vbg0K
PiAgPiBmb3IgIGV2ZXJ5dGhpbmcgdGhhdCB1c2VzIEdFRCBhbmQgc2hvdWxkIGJlIGEgY29uZGl0
aW9uYWwgcGFydCBvZg0KPiAgPiBHRUQncyAgVk1TVEFURS4NCj4gID4NCj4gID4gIElmIHRoaXMg
c2VyaWVzIGlzIGp1c3QgYSBjb21tb24gYmFzZSBhbmQgbm8gYWN0dWFsIGhvdHBsdWcgb24gdG9w
IG9mDQo+ICA+IGl0IGlzICBtZXJnZWQgaW4gdGhpcyByZWxlYXNlIChwcm92aWRlZCBwYXRjaCAx
MyBpcyBmaXhlZCksIEknbSBmaW5lDQo+ICA+IHdpdGggbWlncmF0aW9uICBiaXRzIGJlaW5nIGEg
c2VwYXJhdGUgc2VyaWVzIG9uIHRvcC4NCj4gID4NCj4gID4gIEhvd2V2ZXIgaWYgc29tZSBtYWNo
aW5lIHdvdWxkIGJlIGludHJvZHVjaW5nIGNwdSBob3RwbHVnIGluIHRoZSBzYW1lDQo+ICA+IHJl
bGVhc2UsIHRoZW4gdGhlIG1pZ3JhdGlvbiBwYXJ0IHNob3VsZCBiZSBtZXJnZWQgYmVmb3JlIGl0
IG9yIGJlIGENCj4gID4gcGFydCAgdGhhdCBjcHUgaG90cGx1ZyBzZXJpZXMuDQo+ICANCj4gIFdl
IGhhdmUgdGVzdGVkIExpdmUvUHNldWRvIE1pZ3JhdGlvbiBhbmQgaXQgc2VlbSB0byB3b3JrIHdp
dGggdGhlDQo+ICBjaGFuZ2VzIHBhcnQgb2YgdGhlIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBwYXRj
aC1zZXQuDQo+ICANCj4gIEFtcGVyZTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2UxN2Uy
OGFjLTI4YzctNDk2Zi1iMjEyLQ0KPiAgMmM5YjU1MmRiZjYzQGFtcGVyZW1haWwub25taWNyb3Nv
ZnQuY29tLw0KPiAgT3JhY2xlOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNDZENzREMzAt
RUU1NC00QUQyLThGMEUtDQo+ICBCQTU2MjdGQUE2M0VAb3JhY2xlLmNvbS8NCj4gIA0KPiAgDQo+
ICBGb3IgQVJNLCBwbGVhc2UgY2hlY2sgYmVsb3cgcGF0Y2ggcGFydCBvZiBSRkMgVjMgZm9yIGNo
YW5nZXMgcmVsYXRlZCB0bw0KPiAgbWlncmF0aW9uOg0KPiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI0MDYxMzIzMzYzOS4yMDI4OTYtMTUtDQo+ICBzYWxpbC5tZWh0YUBo
dWF3ZWkuY29tLw0KDQoNCkRvIHlvdSB3aXNoIHRvIG1vdmUgYmVsb3cgY2hhbmdlIGludG8gdGhp
cyBwYXRoLXNldCBhbmQgbWFrZSBpdCBjb21tb24NCnRvIGFsbCBpbnN0ZWFkPw0KDQoNCmRpZmYg
LS1naXQgYS9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMgYi9ody9hY3BpL2dlbmVyaWNf
ZXZlbnRfZGV2aWNlLmMNCmluZGV4IDYzMjI2YjAwNDAuLmU5MmNlMDc5NTUgMTAwNjQ0DQotLS0g
YS9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMNCisrKyBiL2h3L2FjcGkvZ2VuZXJpY19l
dmVudF9kZXZpY2UuYw0KQEAgLTMzMyw2ICszMzMsMTYgQEAgc3RhdGljIGNvbnN0IFZNU3RhdGVE
ZXNjcmlwdGlvbiB2bXN0YXRlX21lbWhwX3N0YXRlID0gew0KICAgICB9DQogfTsNCiANCitzdGF0
aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfY3B1aHBfc3RhdGUgPSB7DQorICAg
IC5uYW1lID0gImFjcGktZ2VkL2NwdWhwIiwNCisgICAgLnZlcnNpb25faWQgPSAxLA0KKyAgICAu
bWluaW11bV92ZXJzaW9uX2lkID0gMSwNCisgICAgLmZpZWxkcyAgICAgID0gKFZNU3RhdGVGaWVs
ZFtdKSB7DQorICAgICAgICBWTVNUQVRFX0NQVV9IT1RQTFVHKGNwdWhwX3N0YXRlLCBBY3BpR2Vk
U3RhdGUpLA0KKyAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElTVCgpDQorICAgIH0NCit9Ow0KKw0K
IHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9nZWRfc3RhdGUgPSB7DQog
ICAgIC5uYW1lID0gImFjcGktZ2VkLXN0YXRlIiwNCiAgICAgLnZlcnNpb25faWQgPSAxLA0KQEAg
LTM4MSw2ICszOTEsNyBAQCBzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVf
YWNwaV9nZWQgPSB7DQogICAgIH0sDQogICAgIC5zdWJzZWN0aW9ucyA9IChjb25zdCBWTVN0YXRl
RGVzY3JpcHRpb24gKiBjb25zdCBbXSkgew0KICAgICAgICAgJnZtc3RhdGVfbWVtaHBfc3RhdGUs
DQorICAgICAgICAmdm1zdGF0ZV9jcHVocF9zdGF0ZSwNCiAgICAgICAgICZ2bXN0YXRlX2doZXNf
c3RhdGUsDQogICAgICAgICBOVUxMDQogICAgIH0NCg0KTWF5YmUgSSBjYW4gYWRkIGEgc2VwYXJh
dGUgcGF0Y2ggZm9yIHRoaXMgaW4gdGhlIGVuZD8gUGxlYXNlIGNvbmZpcm0uDQoNClRoYW5rcw0K
U2FsaWwuDQo=

