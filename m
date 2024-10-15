Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED4DD216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iaN-0002xx-4c; Tue, 15 Oct 2024 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0iaG-0002s4-P5; Tue, 15 Oct 2024 10:31:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0iaE-00055v-8y; Tue, 15 Oct 2024 10:31:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSc332DzSz6D8hT;
 Tue, 15 Oct 2024 22:30:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E78481404F5;
 Tue, 15 Oct 2024 22:31:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 16:31:29 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 15 Oct 2024 16:31:29 +0200
To: maobibo <maobibo@loongson.cn>, "qemu-devel@nongnu.org"
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
 <alex.bennee@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Subject: RE: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
Thread-Topic: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU
 Hotplug (on Archs like ARM)
Thread-Index: AQHbHm50WDNFu/JS0kS8LAX2f7HLB7KHBssAgADYzqA=
Date: Tue, 15 Oct 2024 14:31:29 +0000
Message-ID: <a00e18f4324b40a0b54de4bfbc6d67c2@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <3b0b1033-36eb-6180-1363-f76083a32ce0@loongson.cn>
In-Reply-To: <3b0b1033-36eb-6180-1363-f76083a32ce0@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SEkgQmlibywNCg0KPiAgRnJvbTogbWFvYmlibyA8bWFvYmlib0Bsb29uZ3Nvbi5jbj4NCj4gIFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTUsIDIwMjQgNDozMSBBTQ0KPiAgVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gIA0KPiAgV2l0aCBjcHUtYWRkL2Nw
dS1kZWwgY29tbWFuZCB0ZXN0ZWQgb24gTG9vbmdBcmNoIHN5c3RlbSwgbm8gbWlncmF0aW9uDQo+
ICB0ZXN0ZWQuIFRoZXJlIGlzIG5vIG5lZ2F0aXZlIGluZmx1ZW5jZSB3aXRoIExvb25nQXJjaCBj
cHUgaG90cGx1Zy4NCg0KVGhhbmtzIGZvciB0aGUgY29uZmlybWF0aW9uLiANCg0KSnVzdCBjdXJp
b3VzIGFyZSBndXlzIHN0aWxsIHVzaW5nIGNwdS17YWRkLGRlbH0gaW50ZXJmYWNlIGZvciB2Q1BV
IGhvdHBsdWc/DQpJIHRob3VnaHQgaXQgd2FzIGRlcHJlY2F0ZWQgZm9yIGRldmljZV97YWRkLGRl
bH0/DQoNCmh0dHBzOi8vd2lraS5xZW11Lm9yZy9GZWF0dXJlcy9DUFVIb3RwbHVnDQpodHRwczov
L3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9zeXN0ZW0vY3B1LWhvdHBsdWcuaHRtbA0KDQoNClRo
YW5rcw0KU2FsaWwuDQoNCj4gIA0KPiAgUmVnYXJkcw0KPiAgQmlibyBNYW8NCj4gIA0KPiAgT24g
MjAyNC8xMC8xNSDkuIrljYgzOjIyLCBTYWxpbCBNZWh0YSB2aWEgd3JvdGU6DQo+ICA+IENlcnRh
aW4gQ1BVIGFyY2hpdGVjdHVyZSBzcGVjaWZpY2F0aW9ucyBbMV1bMl1bM10gcHJvaGliaXQgY2hh
bmdlcyB0bw0KPiAgPiB0aGUgQ1BVcw0KPiAgPiAqcHJlc2VuY2UqIGFmdGVyIHRoZSBrZXJuZWwg
aGFzIGJvb3RlZC4gVGhpcyBpcyBiZWNhdXNlIG1hbnkgc3lzdGVtDQo+ICA+IGluaXRpYWxpemF0
aW9ucyBkZXBlbmQgb24gdGhlIGV4YWN0IENQVSBjb3VudCBhdCBib290IHRpbWUgYW5kIGRvIG5v
dA0KPiAgPiBleHBlY3QgaXQgdG8gY2hhbmdlIGFmdGVyd2FyZC4gRm9yIGV4YW1wbGUsIGNvbXBv
bmVudHMgbGlrZSBpbnRlcnJ1cHQNCj4gID4gY29udHJvbGxlcnMgdGhhdCBhcmUgY2xvc2VseSBj
b3VwbGVkIHdpdGggQ1BVcywgb3IgdmFyaW91cyBwZXItQ1BVDQo+ICA+IGZlYXR1cmVzLCBtYXkg
bm90IHN1cHBvcnQgY29uZmlndXJhdGlvbiBjaGFuZ2VzIG9uY2UgdGhlIGtlcm5lbCBoYXMNCj4g
IGJlZW4gaW5pdGlhbGl6ZWQuDQo+ICA+DQo+ICA+IFRoaXMgcmVxdWlyZW1lbnQgcG9zZXMgYSBj
aGFsbGVuZ2UgZm9yIHZpcnR1YWxpemF0aW9uIGZlYXR1cmVzIGxpa2UNCj4gID4gdkNQVSBob3Rw
bHVnLiBUbyBhZGRyZXNzIHRoaXMsIGNoYW5nZXMgdG8gdGhlIEFDUEkgQU1MIGFyZSBuZWNlc3Nh
cnkNCj4gID4gdG8gdXBkYXRlIHRoZSBgX1NUQS5QUkVTYCAocHJlc2VuY2UpIGFuZCBgX1NUQS5F
TkFgIChlbmFibGVkKSBiaXRzDQo+ICA+IGFjY29yZGluZ2x5IGR1cmluZyBndWVzdCBpbml0aWFs
aXphdGlvbiwgYXMgd2VsbCBhcyB3aGVuIHZDUFVzIGFyZQ0KPiAgPiBob3QtcGx1Z2dlZCBvciBo
b3QtdW5wbHVnZ2VkLiBUaGUgcHJlc2VuY2Ugb2YgdW5wbHVnZ2VkIHZDUFVzIG1heQ0KPiAgbmVl
ZA0KPiAgPiB0byBiZSBkZWxpYmVyYXRlbHkgKnNpbXVsYXRlZCogYXQgdGhlIEFDUEkgbGV2ZWwg
dG8gbWFpbnRhaW4gYSAqcGVyc2lzdGVudCoNCj4gIHZpZXcgb2YgdkNQVXMgZm9yIHRoZSBndWVz
dCBrZXJuZWwuDQo+ICA+DQo+ICA+IFRoaXMgcGF0Y2ggc2V0IGludHJvZHVjZXMgdGhlIGZvbGxv
d2luZyBmZWF0dXJlczoNCj4gID4NCj4gID4gMS4gQUNQSSBJbnRlcmZhY2Ugd2l0aCBFeHBsaWNp
dCBQUkVTRU5UIGFuZCBFTkFCTEVEIENQVSBTdGF0ZXM6IEl0IGFsbG93cw0KPiAgdGhlDQo+ICA+
ICAgICBndWVzdCBrZXJuZWwgdG8gZXZhbHVhdGUgdGhlc2Ugc3RhdGVzIHVzaW5nIHRoZSBgX1NU
QWAgQUNQSSBtZXRob2QuDQo+ICA+DQo+ICA+IDIuIEluaXRpYWxpemF0aW9uIG9mIEFDUEkgQ1BV
IFN0YXRlczogVGhlc2Ugc3RhdGVzIGFyZSBpbml0aWFsaXplZCBkdXJpbmcNCj4gID4gICAgIGBt
YWNodmlydF9pbml0YCBhbmQgd2hlbiB2Q1BVcyBhcmUgaG90LSh1bilwbHVnZ2VkLiBUaGlzIGVu
YWJsZXMNCj4gIGhvdHBsdWdnYWJsZQ0KPiAgPiAgICAgdkNQVXMgdG8gYmUgZXhwb3NlZCB0byB0
aGUgZ3Vlc3Qga2VybmVsIHZpYSBBQ1BJLg0KPiAgPg0KPiAgPiAzLiBTdXBwb3J0IGZvciBNaWdy
YXRpbmcgQUNQSSBDUFUgU3RhdGVzOiBUaGUgcGF0Y2ggc2V0IGVuc3VyZXMgdGhlDQo+ICBtaWdy
YXRpb24gb2YNCj4gID4gICAgIHRoZSBuZXdseSBpbnRyb2R1Y2VkIGBpc197cHJlc2VudCxlbmFi
bGVkfWAgQUNQSSBDUFUgc3RhdGVzIHRvIHRoZQ0KPiAgPiAgICAgZGVzdGluYXRpb24gVk0uDQo+
ICA+DQo+ICA+IFRoZSBhcHByb2FjaCBpcyBmbGV4aWJsZSBlbm91Z2ggdG8gYWNjb21tb2RhdGUg
QVJNLWxpa2UgYXJjaGl0ZWN0dXJlcw0KPiAgPiB0aGF0IGludGVuZCB0byBpbXBsZW1lbnQgdkNQ
VSBob3RwbHVnIGZ1bmN0aW9uYWxpdHkuIEl0IGlzIHN1aXRhYmxlDQo+ICA+IGZvciBhcmNoaXRl
Y3R1cmVzIGZhY2luZyBzaW1pbGFyIGNvbnN0cmFpbnRzIHRvIEFSTSBvciB0aG9zZSB0aGF0IHBs
YW4NCj4gID4gdG8gaW1wbGVtZW50IHZDUFUgaG90cGx1Z2dpbmcgaW5kZXBlbmRlbnRseSBvZiBo
YXJkd2FyZSBzdXBwb3J0IChpZg0KPiAgYXZhaWxhYmxlKS4NCj4gID4NCj4gID4gVGhpcyBwYXRj
aCBzZXQgaXMgZGVyaXZlZCBmcm9tIHRoZSBBUk0tc3BlY2lmaWMgdkNQVSBob3RwbHVnDQo+ICA+
IGltcGxlbWVudGF0aW9uIFs0XSBhbmQgaW5jbHVkZXMgbWlncmF0aW9uIGNvbXBvbmVudHMgYWRh
cHRhYmxlIHRvDQo+ICA+IG90aGVyIGFyY2hpdGVjdHVyZXMsIGZvbGxvd2luZyBzdWdnZXN0aW9u
cyBbNV0gbWFkZSBieSBJZ29yIE1hbW1lZG92DQo+ICA8aW1hbW1lZG9AcmVkaGF0LmNvbT4uDQo+
ICA+DQo+ICA+IEl0IGNhbiBiZSBhcHBsaWVkIGluZGVwZW5kZW50bHksIGVuc3VyaW5nIGNvbXBh
dGliaWxpdHkgd2l0aCBleGlzdGluZw0KPiAgPiBob3RwbHVnIHN1cHBvcnQgaW4gb3RoZXIgYXJj
aGl0ZWN0dXJlcy4gSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoIHNldA0KPiAgPiBpbiBjb25qdW5j
dGlvbiB3aXRoIHRoZSBBUk0tc3BlY2lmaWMgdkNQVSBob3RwbHVnIGNoYW5nZXMgKGluY2x1ZGVk
IGluDQo+ICA+IHRoZSB1cGNvbWluZyBSRkMgVjUgWzZdKSwgYW5kIGV2ZXJ5dGhpbmcgd29ya2Vk
IGFzIGV4cGVjdGVkLiBJIGtpbmRseQ0KPiAgPiByZXF1ZXN0IG1haW50YWluZXJzIG9mIG90aGVy
IGFyY2hpdGVjdHVyZXMgdG8gcHJvdmlkZSBhICJUZXN0ZWQtYnkiDQo+ICA+IGFmdGVyIHJ1bm5p
bmcgdGhlaXIgcmVzcGVjdGl2ZSByZWdyZXNzaW9uIHRlc3RzLg0KPiAgPg0KPiAgPiBNYW55IHRo
YW5rcyENCj4gID4NCj4gID4NCj4gID4gUmVmZXJlbmNlczoNCj4gID4gWzFdIEtWTUZvcnVtIDIw
MjMgUHJlc2VudGF0aW9uOiBDaGFsbGVuZ2VzIFJldmlzaXRlZCBpbiBTdXBwb3J0aW5nIFZpcnQN
Cj4gIENQVSBIb3RwbHVnIG9uDQo+ICA+ICAgICAgYXJjaGl0ZWN0dXJlcyB0aGF0IGRvbuKAmXQg
U3VwcG9ydCBDUFUgSG90cGx1ZyAobGlrZSBBUk02NCkNCj4gID4gICAgICBhLiBLZXJuZWwgTGlu
azogaHR0cHM6Ly9rdm0tZm9ydW0ucWVtdS5vcmcvMjAyMy9LVk0tZm9ydW0tY3B1LQ0KPiAgaG90
cGx1Z183T0oxWXlKLnBkZg0KPiAgPiAgICAgIGIuIFFlbXUgTGluazoNCj4gID4gaHR0cHM6Ly9r
dm0tDQo+ICBmb3J1bS5xZW11Lm9yZy8yMDIzL0NoYWxsZW5nZXNfUmV2aXNpdGVkX2luX1N1cHBv
cnRpbmdfVmlyDQo+ICA+IHRfQ1BVX0hvdHBsdWdfLV9faWkwaU5iMy5wZGYgWzJdIEtWTUZvcnVt
IDIwMjAgUHJlc2VudGF0aW9uOg0KPiAgPiBDaGFsbGVuZ2VzIGluIFN1cHBvcnRpbmcgVmlydHVh
bCBDUFUgSG90cGx1ZyBvbg0KPiAgPiAgICAgIFNvQyBCYXNlZCBTeXN0ZW1zIChsaWtlIEFSTTY0
KQ0KPiAgPiAgICAgIExpbms6IGh0dHBzOi8va3ZtZm9ydW0yMDIwLnNjaGVkLmNvbS9ldmVudC9l
RTRtDQo+ICA+IFszXSBDaGVjayBjb21tZW50IDUgaW4gdGhlIGJ1Z3ppbGxhIGVudHJ5DQo+ICA+
ICAgICAgTGluazogaHR0cHM6Ly9idWd6aWxsYS50aWFub2NvcmUub3JnL3Nob3dfYnVnLmNnaT9p
ZD00NDgxI2M1DQo+ICA+IFs0XSBbUEFUQ0ggUkZDIFY0IDAwLzMzXSBTdXBwb3J0IG9mIFZpcnR1
YWwgQ1BVIEhvdHBsdWcgZm9yIEFSTXY4IEFyY2gNCj4gID4gICAgICBMaW5rOg0KPiAgPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMDA5MDMxODE1LjI1MDA5Ni0xLXNh
bGlsLm1laHRhDQo+ICA+IEBodWF3ZWkuY29tL1QvI21mMzJiZTIwM2JhYTU2OGE4NzFkYzYyNWI3
MzJmNjY2YTRjNGYxZTY4DQo+ICA+IFs1XSBBcmNoaXRlY3R1cmUgYWdub3N0aWMgQUNQSSBWTVNE
IHN0YXRlIG1pZ3JhdGlvbiAoRGlzY3Vzc2lvbikNCj4gID4gICAgICBMaW5rOg0KPiAgPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LQ0KPiAgZGV2ZWwvMjAyNDA3MTUxNTU0MzYuNTc3ZDM0
YzVAaW1hbW1lZG8udXMNCj4gID4gZXJzLmlwYS5yZWRoYXQuY29tLyBbNl0gVXBjb21pbmcgUkZD
IFY1LCBTdXBwb3J0IG9mIFZpcnR1YWwgQ1BVDQo+ICA+IEhvdHBsdWcgZm9yIEFSTXY4IEFyY2gN
Cj4gID4gICAgICBMaW5rOg0KPiAgPiBodHRwczovL2dpdGh1Yi5jb20vc2FsaWwtbWVodGEvcWVt
dS9jb21taXRzL3ZpcnQtY3B1aHAtYXJtdjgvcmZjLXY1DQo+ICA+DQo+ICA+IFNhbGlsIE1laHRh
ICg0KToNCj4gID4gICAgaHcvYWNwaTogSW5pdGlhbGl6ZSBBQ1BJIEhvdHBsdWcgQ1BVIFN0YXR1
cyB3aXRoIFN1cHBvcnQgZm9yIHZDUFUNCj4gID4gICAgICBgUGVyc2lzdGVuY2VgDQo+ICA+ICAg
IGh3L2FjcGk6IFVwZGF0ZSBBQ1BJIENQVSBTdGF0dXMgYGlzX3twcmVzZW50LCBlbmFibGVkfWAg
ZHVyaW5nIHZDUFUNCj4gID4gICAgICBob3QodW4pcGx1Zw0KPiAgPiAgICBody9hY3BpOiBSZWZs
ZWN0IEFDUEkgdkNQVSB7cHJlc2VudCxlbmFibGVkfSBzdGF0ZXMgaW4gQUNQSQ0KPiAgPiAgICAg
IF9TVEEue1BSRVMsRU5BfSBCaXRzDQo+ICA+ICAgIGh3L2FjcGk6IFBvcHVsYXRlIHZDUFUgSG90
cGx1ZyBWTVNEIHRvIG1pZ3JhdGUNCj4gIGBpc197cHJlc2VudCxlbmFibGVkfWANCj4gID4gICAg
ICBzdGF0ZXMNCj4gID4NCj4gID4gICBjcHUtdGFyZ2V0LmMgICAgICAgICBwYXRjaGVzLnZjcHVo
cC5yZmMtdjUuYXJjaC5hZ25vc3RpYy5hY3BpICAgICAgICAgIHwgIDEgKw0KPiAgPiAgIGh3L2Fj
cGkvY3B1LmMgICAgICAgICAgICAgICAgICB8IDcwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4gID4gICBody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMgfCAxMSArKysr
KysNCj4gID4gICBpbmNsdWRlL2h3L2FjcGkvY3B1LmggICAgICAgICAgfCAyMSArKysrKysrKysr
DQo+ICA+ICAgaW5jbHVkZS9ody9jb3JlL2NwdS5oICAgICAgICAgIHwgMjEgKysrKysrKysrKw0K
PiAgPiAgIDUgZmlsZXMgY2hhbmdlZCwgMTE5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+ICA+DQoNCg==

