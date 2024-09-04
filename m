Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EEDCD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsQV-0007dn-QF; Wed, 04 Sep 2024 12:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slsQO-0007Zy-Ko; Wed, 04 Sep 2024 12:00:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slsQL-00063U-Tj; Wed, 04 Sep 2024 12:00:04 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WzRsc2cHvz6K6TB;
 Wed,  4 Sep 2024 23:55:32 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (unknown [7.191.162.67])
 by mail.maildlp.com (Postfix) with ESMTPS id 5FD6E1400CD;
 Wed,  4 Sep 2024 23:59:57 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 16:59:57 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 4 Sep 2024 16:59:57 +0100
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: Gustavo Romero <gustavo.romero@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHaveq2F6TAeAWelEWGVYAetyN5RLI9hyQAgADxfM+ACbIgYIAAHI5lgAAAMjA=
Date: Wed, 4 Sep 2024 15:59:56 +0000
Message-ID: <923008d9b65d45eba4e4ae19fe62f79c@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
 <87bk1b3azm.fsf@draig.linaro.org>
 <a874e995c188480fb08deac3ccf0cc2d@huawei.com>
 <87o753tob3.fsf@draig.linaro.org>
In-Reply-To: <87o753tob3.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.6]
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

SGkgQWxleCwNCg0KPiAgRnJvbTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
Pg0KPiAgU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNCwgMjAyNCA0OjQ2IFBNDQo+ICBUbzog
U2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICANCj4gIFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cml0ZXM6DQo+ICANCj4gID4gSGkgQWxleCwNCj4g
ID4NCj4gID4+ICAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiAgPj4gIEZyb206IEFsZXgg
QmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gID4+ICBTZW50OiBUaHVyc2RheSwg
QXVndXN0IDI5LCAyMDI0IDExOjAwIEFNDQo+ICA+PiAgVG86IEd1c3Rhdm8gUm9tZXJvIDxndXN0
YXZvLnJvbWVyb0BsaW5hcm8ub3JnPg0KPiAgPj4NCj4gID4+ICBHdXN0YXZvIFJvbWVybyA8Z3Vz
dGF2by5yb21lcm9AbGluYXJvLm9yZz4gd3JpdGVzOg0KPiAgPj4NCj4gID4+ICA+IEhpIFNhbGls
LA0KPiAgPj4gID4NCj4gID4+ICA+IE9uIDYvMTMvMjQgODozNiBQTSwgU2FsaWwgTWVodGEgdmlh
IHdyb3RlOg0KPiAgPj4gIDxzbmlwPg0KPiAgPj4gID4+IChWSSkgQ29tbWFuZHMgVXNlZA0KPiAg
Pj4gID4+ID09PT09PT09PT09PT09PT09PQ0KPiAgPj4gID4+IEEuIFFlbXUgbGF1bmNoIGNvbW1h
bmRzIHRvIGluaXQgdGhlIG1hY2hpbmU6DQo+ICA+PiAgPj4gICAgICAkIHFlbXUtc3lzdGVtLWFh
cmNoNjQgLS1lbmFibGUta3ZtIC1tYWNoaW5lIHZpcnQsZ2ljLXZlcnNpb249Mw0KPiAgXA0KPiAg
Pj4gID4+ICAgICAgICAtY3B1IGhvc3QgLXNtcCBjcHVzPTQsbWF4Y3B1cz02IFwNCj4gID4+ICA+
PiAgICAgICAgLW0gMzAwTSBcDQo+ICA+PiAgPj4gICAgICAgIC1rZXJuZWwgSW1hZ2UgXA0KPiAg
Pj4gID4+ICAgICAgICAtaW5pdHJkIHJvb3Rmcy5jcGlvLmd6IFwNCj4gID4+ICA+PiAgICAgICAg
LWFwcGVuZCAiY29uc29sZT10dHlBTUEwIHJvb3Q9L2Rldi9yYW0gcmRpbml0PS9pbml0DQo+ICBt
YXhjcHVzPTINCj4gID4+ICBhY3BpPWZvcmNlIiBcDQo+ICA+PiAgPj4gICAgICAgIC1ub2dyYXBo
aWMgXA0KPiAgPj4gID4+ICAgICAgICAtYmlvcyBRRU1VX0VGSS5mZCBcDQo+ICA+PiAgPj4gQi4g
SG90LSh1bilwbHVnIHJlbGF0ZWQgY29tbWFuZHM6DQo+ICA+PiAgPj4gICAgIyBIb3RwbHVnIGEg
aG9zdCB2Q1BVIChhY2NlbD1rdm0pOg0KPiAgPj4gID4+ICAgICAgJCBkZXZpY2VfYWRkIGhvc3Qt
YXJtLWNwdSxpZD1jb3JlNCxjb3JlLWlkPTQNCj4gID4+ICA+PiAgICAjIEhvdHBsdWcgYSB2Q1BV
IChhY2NlbD10Y2cpOg0KPiAgPj4gID4+ICAgICAgJCBkZXZpY2VfYWRkIGNvcnRleC1hNTctYXJt
LWNwdSxpZD1jb3JlNCxjb3JlLWlkPTQNCj4gID4+ICA+DQo+ICA+PiAgPiBTaW5jZSBzdXBwb3J0
IGZvciBob3RwbHVnIGlzIGRpc2FibGVkIG9uIFRDRywgcmVtb3ZlIHRoZXNlIHR3bw0KPiAgPj4g
bGluZXMgID4gaW4gdjQgY292ZXIgbGV0dGVyPw0KPiAgPj4NCj4gID4+ICBXaHkgaXMgaXQgZGlz
YWJsZWQgZm9yIFRDRz8gV2Ugc2hvdWxkIGFpbSBmb3IgVENHIGJlaW5nIGFzIGNsb3NlIHRvDQo+
ICA+PiBLVk0gYXMgIHBvc3NpYmxlIGZvciBkZXZlbG9wZXJzIGV2ZW4gaWYgaXQgaXMgbm90IGEg
cHJvZHVjdGlvbiBzb2x1dGlvbi4NCj4gID4NCj4gID4gQWdyZWVkIEluIHByaW5jaXBsZS4gWWVz
LCB0aGF0IHdvdWxkIGJlIG9mIGhlbHAuDQo+ICA+DQo+ICA+DQo+ICA+IENvbnRleHQgd2h5IGl0
IHdhcyBkaXNhYmxlZCBhbHRob3VnaCBtb3N0IGNvZGUgdG8gc3VwcG9ydCBUQ0cgZXhpc3Q6DQo+
ICA+DQo+ICA+IEkgaGFkIHJlcG9ydGVkIGEgY3Jhc2ggaW4gdGhlIFJGQyBWMSAoSnVuZSAyMDIw
KSBhYm91dCBUQ0dDb250ZXh0DQo+ICA+IGNvdW50ZXIgb3ZlcmZsb3cgYXNzZXJ0aW9uIGR1cmlu
ZyByZXBlYXRlZCBob3QodW4pcGx1ZyBvcGVyYXRpb24uDQo+ICA+IE1pZ3VlbCBmcm9tIE9yYWNs
ZSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBwcm9ibGVtIGxhc3QgeWVhciBpbiBGZWINCj4g
ID4gYW5kIGFsc28gc3VnZ2VzdGVkIGEgZml4IGJ1dCBoZSBsYXRlciBmb3VuZCBvdXQgaW4gaGlz
IHRlc3RpbmcgdGhhdCB0aGVyZSB3YXMNCj4gIGEgcHJvYmxlbSBkdXJpbmcgbWlncmF0aW9uLg0K
PiAgPg0KPiAgPiBSRkMgVjEgSnVuZSAyMDIwOg0KPiAgPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjAwNjEzMjEzNjI5LjIxOTg0LTEtDQo+ICBzYWxpbC5tZWh0YUANCj4g
ID4gaHVhd2VpLmNvbS8NCj4gID4gU2Nyb2xsIHRvIGJlbG93Og0KPiAgPiBbLi4uXQ0KPiAgPiBU
SElOR1MgVE8gRE86DQo+ICA+ICAoKikgTWlncmF0aW9uIHN1cHBvcnQNCj4gID4gICgqKSBUQ0cv
RW11bGF0aW9uIHN1cHBvcnQgaXMgbm90IHByb3BlciByaWdodCBub3cuIFdvcmtzIHRvIGEgY2Vy
dGFpbg0KPiAgZXh0ZW50DQo+ICA+ICAgICAgYnV0IGlzIG5vdCBjb21wbGV0ZS4gZXNwZWNpYWxs
eSB0aGUgdW5yZWFsaXplIHBhcnQgaW4gd2hpY2ggdGhlcmUgaXMgYQ0KPiAgPiAgICAgIG92ZXJm
bG93IG9mIHRjZyBjb250ZXh0cy4gVGhlIGxhc3QgaXMgZHVlIHRvIHRoZSBmYWN0IHRjZyBtYWlu
dGFpbnMgYQ0KPiAgPiAgICAgIGNvdW50IG9uIG51bWJlciBvZiBjb250ZXh0KHBlciB0aHJlYWQg
aW5zdGFuY2UpIHNvIGFzIHdlIGhvdHBsdWcgdGhlDQo+ICB2Y3B1cw0KPiAgPiAgICAgIHRoaXMg
Y291bnRlciBrZWVwcyBvbiBpbmNyZW1lbnRpbmcuIEJ1dCBkdXJpbmcgaG90LXVucGx1ZyB0aGUg
Y291bnRlcg0KPiAgaXMNCj4gID4gICAgICBub3QgZGVjcmVtZW50ZWQuDQo+ICANCj4gIFJpZ2h0
IHNvIHRoZSB0cmFuc2xhdGlvbiBjYWNoZSBpcyBzZWdtZW50ZWQgYnkgdkNQVSB0byBzdXBwb3J0
IHBhcmFsbGVsIEpJVA0KPiAgb3BlcmF0aW9ucy4gVGhlIGVhc2llc3Qgc29sdXRpb24gd291bGQg
YmUgdG8gZW5zdXJlIHdlIGRpbWVuc2lvbiBmb3IgdGhlDQo+ICBtYXhpbXVtIG51bWJlciBvZiB2
Q1BVcywgd2hpY2ggaXQgc2hvdWxkIGFscmVhZHksIHNlZQ0KPiAgdGNnX2luaXRfbWFjaGluZSgp
Og0KPiAgDQo+ICAgIHVuc2lnbmVkIG1heF9jcHVzID0gbXMtPnNtcC5tYXhfY3B1czsNCj4gICAg
Li4uDQo+ICAgIHRjZ19pbml0KHMtPnRiX3NpemUgKiBNaUIsIHMtPnNwbGl0d3hfZW5hYmxlZCwg
bWF4X2NwdXMpOw0KDQoNCkFncmVlZC4gV2UgaGF2ZSBkb25lIHRoYXQgYW5kIGhhdmUgYSBwYXRj
aCBmb3IgdGhhdCBhcyB3ZWxsLiBCdXQgaXQgaXMgc3RpbGwNCmEgd29yay1pbi1wcm9ncmVzcyBh
bmQgSSd2ZSBsb3N0IGNvbnRleHQgYSBiaXQuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1t
ZWh0YS9xZW11L2NvbW1pdC8xMDdjZjVjYTdjZjM3MTZiYzBmOGM2OGU5OGUxZGEzOTM5ZjQ0OWNl
DQoNCkZvciBub3csIEkndmUgdmVyeSBxdWlja2x5IHRyaWVkIHRvIGVuYWJsZSBhbmQgcnVuIHRo
ZSBUQ0cgdG8gZ2FpbiBiYWNrIHRoZSBjb250ZXh0Lg0KSSd2ZSBub3cgaGl0IGEgZGlmZmVyZW50
IHByb2JsZW0gZHVyaW5nIFRDRyB2Q1BVIHVucmVhbGl6YXRpb24gcGhhc2UsIHdoaWxlDQpwdGhy
ZWFkX2pvaW4oKSB3YWl0cyBvbiBoYWx0IGNvbmRpdGlvbiB2YXJpYWJsZSBmb3IgTVRUQ0cgdkNQ
VSB0aHJlYWQgdG8gZXhpdCwNCnRoZXJlIGlzIGEgY3Jhc2ggc29tZXdoZXJlLiBMb29rIGxpa2Ug
c29tZSByYWNlIGNvbmRpdGlvbi4gV2lsbCBkaWcgdGhpcyBmdXJ0aGVyLg0KIA0KDQpCZXN0IHJl
Z2FyZHMNClNhbGlsLg0KDQo+ICA+IEAgRmViIDIwMjMsIFtMaW5hcm8tb3Blbi1kaXNjdXNzaW9u
c10gUmU6IFFlbXUgVENHIHN1cHBvcnQgZm9yDQo+ICA+IHZpcnR1YWwtY3B1aG90cGx1Zy9vbmxp
bmUtcG9saWN5DQo+ICA+DQo+ICA+IGh0dHBzOi8vb3AtbGlzdHMubGluYXJvLm9yZy9hcmNoaXZl
cy9saXN0L2xpbmFyby1vcGVuLWRpc2N1c3Npb25zQG9wLWwNCj4gID4gaXN0cy5saW5hcm8ub3Jn
L21lc3NhZ2UvR01ERlRFWkU2V1VVSTdMWkFZT1dMWEZIQVBYTENORDUvDQo+ICA+DQo+ICA+IExh
c3Qgc3RhdHVzIHJlcG9ydGVkIGJ5IE1pZ3VlbCB3YXMgdGhhdCB0aGVyZSB3YXMgcHJvYmxlbSB3
aXRoIHRoZSBUQ0cNCj4gID4gYW5kIGhlIGludGVuZGVkIHRvIGZpeCB0aGlzLiBIZSB3YXMgb24g
cGF0ZXJuaXR5IGxlYXZlIHNvIEkgd2lsbCB0cnkgdG8gZ2F0aGVyDQo+ICB0aGUgZXhhY3Qgc3Rh
dHVzIG9mIHRoZSBUQ0cgdG9kYXkuDQo+ICA+DQo+ICA+IFRoYW5rcw0KPiAgPiBTYWxpbA0KPiAg
Pg0KPiAgPg0KPiAgPj4NCj4gID4+ICAtLQ0KPiAgPj4gIEFsZXggQmVubsOpZQ0KPiAgPj4gIFZp
cnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0KPiAgDQo+ICAtLQ0KPiAgQWxleCBCZW5u
w6llDQo+ICBWaXJ0dWFsaXNhdGlvbiBUZWNoIExlYWQgQCBMaW5hcm8NCg==

