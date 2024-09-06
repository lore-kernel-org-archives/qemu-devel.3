Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E0BCE7B1D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaYB-0002Ir-Bj; Fri, 06 Sep 2024 11:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1smaY8-0002Fz-K7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:07:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1smaY6-0003O4-1v
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:07:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X0fcF0b8Yz6J7p4;
 Fri,  6 Sep 2024 23:03:09 +0800 (CST)
Received: from lhrpeml100005.china.huawei.com (unknown [7.191.160.25])
 by mail.maildlp.com (Postfix) with ESMTPS id B112F1400C9;
 Fri,  6 Sep 2024 23:06:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 16:06:38 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Fri, 6 Sep 2024 16:06:38 +0100
To: Salil Mehta <salil.mehta@huawei.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
CC: Gustavo Romero <gustavo.romero@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
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
Thread-Index: AQHaveq2F6TAeAWelEWGVYAetyN5RLI9hyQAgADxfM+ACbIgYIAAHI5lgAAAMjCAAW4t8A==
Date: Fri, 6 Sep 2024 15:06:38 +0000
Message-ID: <389fd6c14eb744f79e6f5d34fa30c9c7@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
 <87bk1b3azm.fsf@draig.linaro.org>
 <a874e995c188480fb08deac3ccf0cc2d@huawei.com>
 <87o753tob3.fsf@draig.linaro.org>
 <923008d9b65d45eba4e4ae19fe62f79c@huawei.com>
In-Reply-To: <923008d9b65d45eba4e4ae19fe62f79c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.152.57]
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

SGkgQWxleCwNCg0KPiAgRnJvbTogcWVtdS1hcm0tYm91bmNlcytzYWxpbC5tZWh0YT1odWF3ZWku
Y29tQG5vbmdudS5vcmcgPHFlbXUtDQo+ICBhcm0tYm91bmNlcytzYWxpbC5tZWh0YT1odWF3ZWku
Y29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBTYWxpbA0KPiAgTWVodGEgdmlhDQo+ICBTZW50
OiBXZWRuZXNkYXksIFNlcHRlbWJlciA0LCAyMDI0IDU6MDAgUE0NCj4gIFRvOiBBbGV4IEJlbm7D
qWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+ICANCj4gIEhpIEFsZXgsDQo+ICANCj4gID4g
IEZyb206IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gID4gIFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDQsIDIwMjQgNDo0NiBQTQ0KPiAgPiAgVG86IFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgPg0KPiAgPiAgU2FsaWwgTWVodGEgPHNh
bGlsLm1laHRhQGh1YXdlaS5jb20+IHdyaXRlczoNCj4gID4NCj4gID4gID4gSGkgQWxleCwNCj4g
ID4gID4NCj4gID4gID4+ICAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiAgPiAgPj4gIEZy
b206IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4gID4+ICBTZW50OiBUaHVy
c2RheSwNCj4gID4gQXVndXN0IDI5LCAyMDI0IDExOjAwIEFNICA+PiAgVG86IEd1c3Rhdm8gUm9t
ZXJvDQo+ICA+IDxndXN0YXZvLnJvbWVyb0BsaW5hcm8ub3JnPiAgPj4gID4+ICBHdXN0YXZvIFJv
bWVybw0KPiAgPiA8Z3VzdGF2by5yb21lcm9AbGluYXJvLm9yZz4gd3JpdGVzOg0KPiAgPiAgPj4N
Cj4gID4gID4+ICA+IEhpIFNhbGlsLA0KPiAgPiAgPj4gID4NCj4gID4gID4+ICA+IE9uIDYvMTMv
MjQgODozNiBQTSwgU2FsaWwgTWVodGEgdmlhIHdyb3RlOg0KPiAgPiAgPj4gIDxzbmlwPg0KPiAg
PiAgPj4gID4+IChWSSkgQ29tbWFuZHMgVXNlZA0KPiAgPiAgPj4gID4+ID09PT09PT09PT09PT09
PT09PQ0KPiAgPiAgPj4gID4+IEEuIFFlbXUgbGF1bmNoIGNvbW1hbmRzIHRvIGluaXQgdGhlIG1h
Y2hpbmU6DQo+ICA+ICA+PiAgPj4gICAgICAkIHFlbXUtc3lzdGVtLWFhcmNoNjQgLS1lbmFibGUt
a3ZtIC1tYWNoaW5lIHZpcnQsZ2ljLXZlcnNpb249MyAgIFwNCj4gID4gID4+ICA+PiAgICAgICAg
LWNwdSBob3N0IC1zbXAgY3B1cz00LG1heGNwdXM9NiBcDQo+ICA+ICA+PiAgPj4gICAgICAgIC1t
IDMwME0gXA0KPiAgPiAgPj4gID4+ICAgICAgICAta2VybmVsIEltYWdlIFwNCj4gID4gID4+ICA+
PiAgICAgICAgLWluaXRyZCByb290ZnMuY3Bpby5neiBcDQo+ICA+ICA+PiAgPj4gICAgICAgIC1h
cHBlbmQgImNvbnNvbGU9dHR5QU1BMCByb290PS9kZXYvcmFtIHJkaW5pdD0vaW5pdCBtYXhjcHVz
PTINCj4gID4gID4+ICBhY3BpPWZvcmNlIiBcDQo+ICA+ICA+PiAgPj4gICAgICAgIC1ub2dyYXBo
aWMgXA0KPiAgPiAgPj4gID4+ICAgICAgICAtYmlvcyBRRU1VX0VGSS5mZCBcDQo+ICA+ICA+PiAg
Pj4gQi4gSG90LSh1bilwbHVnIHJlbGF0ZWQgY29tbWFuZHM6DQo+ICA+ICA+PiAgPj4gICAgIyBI
b3RwbHVnIGEgaG9zdCB2Q1BVIChhY2NlbD1rdm0pOg0KPiAgPiAgPj4gID4+ICAgICAgJCBkZXZp
Y2VfYWRkIGhvc3QtYXJtLWNwdSxpZD1jb3JlNCxjb3JlLWlkPTQNCj4gID4gID4+ICA+PiAgICAj
IEhvdHBsdWcgYSB2Q1BVIChhY2NlbD10Y2cpOg0KPiAgPiAgPj4gID4+ICAgICAgJCBkZXZpY2Vf
YWRkIGNvcnRleC1hNTctYXJtLWNwdSxpZD1jb3JlNCxjb3JlLWlkPTQNCj4gID4gID4+ICA+DQo+
ICA+ICA+PiAgPiBTaW5jZSBzdXBwb3J0IGZvciBob3RwbHVnIGlzIGRpc2FibGVkIG9uIFRDRywg
cmVtb3ZlIHRoZXNlIHR3bw0KPiAgPiA+PiBsaW5lcyAgPiBpbiB2NCBjb3ZlciBsZXR0ZXI/DQo+
ICA+ICA+Pg0KPiAgPiAgPj4gIFdoeSBpcyBpdCBkaXNhYmxlZCBmb3IgVENHPyBXZSBzaG91bGQg
YWltIGZvciBUQ0cgYmVpbmcgYXMgY2xvc2UNCj4gID4gdG8gID4+IEtWTSBhcyAgcG9zc2libGUg
Zm9yIGRldmVsb3BlcnMgZXZlbiBpZiBpdCBpcyBub3QgYSBwcm9kdWN0aW9uIHNvbHV0aW9uLg0K
PiAgPiAgPg0KPiAgPiAgPiBBZ3JlZWQgSW4gcHJpbmNpcGxlLiBZZXMsIHRoYXQgd291bGQgYmUg
b2YgaGVscC4NCj4gID4gID4NCj4gID4gID4NCj4gID4gID4gQ29udGV4dCB3aHkgaXQgd2FzIGRp
c2FibGVkIGFsdGhvdWdoIG1vc3QgY29kZSB0byBzdXBwb3J0IFRDRyBleGlzdDoNCj4gID4gID4N
Cj4gID4gID4gSSBoYWQgcmVwb3J0ZWQgYSBjcmFzaCBpbiB0aGUgUkZDIFYxIChKdW5lIDIwMjAp
IGFib3V0IFRDR0NvbnRleHQNCj4gID4gPiBjb3VudGVyIG92ZXJmbG93IGFzc2VydGlvbiBkdXJp
bmcgcmVwZWF0ZWQgaG90KHVuKXBsdWcgb3BlcmF0aW9uLg0KPiAgPiAgPiBNaWd1ZWwgZnJvbSBP
cmFjbGUgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgcHJvYmxlbSBsYXN0IHllYXIgaW4NCj4g
ID4gRmViICA+IGFuZCBhbHNvIHN1Z2dlc3RlZCBhIGZpeCBidXQgaGUgbGF0ZXIgZm91bmQgb3V0
IGluIGhpcyB0ZXN0aW5nDQo+ICA+IHRoYXQgdGhlcmUgd2FzICBhIHByb2JsZW0gZHVyaW5nIG1p
Z3JhdGlvbi4NCj4gID4gID4NCj4gID4gID4gUkZDIFYxIEp1bmUgMjAyMDoNCj4gID4gID4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIwMDYxMzIxMzYyOS4yMTk4NC0xLQ0K
PiAgPiAgc2FsaWwubWVodGFADQo+ICA+ICA+IGh1YXdlaS5jb20vDQo+ICA+ICA+IFNjcm9sbCB0
byBiZWxvdzoNCj4gID4gID4gWy4uLl0NCj4gID4gID4gVEhJTkdTIFRPIERPOg0KPiAgPiAgPiAg
KCopIE1pZ3JhdGlvbiBzdXBwb3J0DQo+ICA+ICA+ICAoKikgVENHL0VtdWxhdGlvbiBzdXBwb3J0
IGlzIG5vdCBwcm9wZXIgcmlnaHQgbm93LiBXb3JrcyB0byBhIGNlcnRhaW4gIGV4dGVudA0KPiAg
PiAgPiAgICAgIGJ1dCBpcyBub3QgY29tcGxldGUuIGVzcGVjaWFsbHkgdGhlIHVucmVhbGl6ZSBw
YXJ0IGluIHdoaWNoIHRoZXJlIGlzIGENCj4gID4gID4gICAgICBvdmVyZmxvdyBvZiB0Y2cgY29u
dGV4dHMuIFRoZSBsYXN0IGlzIGR1ZSB0byB0aGUgZmFjdCB0Y2cgbWFpbnRhaW5zIGENCj4gID4g
ID4gICAgICBjb3VudCBvbiBudW1iZXIgb2YgY29udGV4dChwZXIgdGhyZWFkIGluc3RhbmNlKSBz
byBhcyB3ZSBob3RwbHVnIHRoZSB2Y3B1cw0KPiAgPiAgPiAgICAgIHRoaXMgY291bnRlciBrZWVw
cyBvbiBpbmNyZW1lbnRpbmcuIEJ1dCBkdXJpbmcgaG90LXVucGx1ZyB0aGUgY291bnRlciBpcw0K
PiAgPiAgPiAgICAgIG5vdCBkZWNyZW1lbnRlZC4NCj4gID4NCj4gID4gIFJpZ2h0IHNvIHRoZSB0
cmFuc2xhdGlvbiBjYWNoZSBpcyBzZWdtZW50ZWQgYnkgdkNQVSB0byBzdXBwb3J0DQo+ICA+IHBh
cmFsbGVsIEpJVCAgb3BlcmF0aW9ucy4gVGhlIGVhc2llc3Qgc29sdXRpb24gd291bGQgYmUgdG8g
ZW5zdXJlIHdlDQo+ICA+IGRpbWVuc2lvbiBmb3IgdGhlICBtYXhpbXVtIG51bWJlciBvZiB2Q1BV
cywgd2hpY2ggaXQgc2hvdWxkIGFscmVhZHksIHNlZQ0KPiAgPiAgdGNnX2luaXRfbWFjaGluZSgp
Og0KPiAgPg0KPiAgPiAgICB1bnNpZ25lZCBtYXhfY3B1cyA9IG1zLT5zbXAubWF4X2NwdXM7DQo+
ICA+ICAgIC4uLg0KPiAgPiAgICB0Y2dfaW5pdChzLT50Yl9zaXplICogTWlCLCBzLT5zcGxpdHd4
X2VuYWJsZWQsIG1heF9jcHVzKTsNCj4gIA0KPiAgDQo+ICBBZ3JlZWQuIFdlIGhhdmUgZG9uZSB0
aGF0IGFuZCBoYXZlIGEgcGF0Y2ggZm9yIHRoYXQgYXMgd2VsbC4gQnV0IGl0IGlzIHN0aWxsIGEN
Cj4gIHdvcmstaW4tcHJvZ3Jlc3MgYW5kIEkndmUgbG9zdCBjb250ZXh0IGEgYml0Lg0KPiAgDQo+
ICBodHRwczovL2dpdGh1Yi5jb20vc2FsaWwtDQo+ICBtZWh0YS9xZW11L2NvbW1pdC8xMDdjZjVj
YTdjZjM3MTZiYzBmOGM2OGU5OGUxZGEzOTM5ZjQ0OWNlDQo+ICANCj4gIEZvciBub3csIEkndmUg
dmVyeSBxdWlja2x5IHRyaWVkIHRvIGVuYWJsZSBhbmQgcnVuIHRoZSBUQ0cgdG8gZ2FpbiBiYWNr
IHRoZQ0KPiAgY29udGV4dC4NCj4gIEkndmUgbm93IGhpdCBhIGRpZmZlcmVudCBwcm9ibGVtIGR1
cmluZyBUQ0cgdkNQVSB1bnJlYWxpemF0aW9uIHBoYXNlLCB3aGlsZQ0KPiAgcHRocmVhZF9qb2lu
KCkgd2FpdHMgb24gaGFsdCBjb25kaXRpb24gdmFyaWFibGUgZm9yIE1UVENHIHZDUFUgdGhyZWFk
IHRvDQo+ICBleGl0LCB0aGVyZSBpcyBhIGNyYXNoIHNvbWV3aGVyZS4gTG9vayBsaWtlIHNvbWUg
cmFjZSBjb25kaXRpb24uIFdpbGwgZGlnIHRoaXMNCj4gIGZ1cnRoZXIuDQoNCg0KSXQgYXBwZWFy
cyB0aGF0IHRoZXJlIHdhcyBhIHJhY2UgY29uZGl0aW9uIG9jY3VycmluZyBiZXR3ZWVuIGRlc3Ry
dWN0aW9uIG9mIHRoZQ0KQ1BVIEFkZHJlc3MgU3BhY2UgYW5kIHRoZSBkZWxheWVkIHByb2Nlc3Np
bmcgb2YgdGhlIHRjZ19jb21taXRfY3B1KCkgZnVuY3Rpb24uDQpUaGUgbGF0dGVyIGlzIHByaW1h
cmlseSByZXNwb25zaWJsZSBmb3I6DQoNCjEuIFVwZGF0aW5nIG9mIG1lbW9yeSBkaXNwYXRjaCBw
b2ludGVyIA0KMi4gUGVyZm9ybWluZyB0aGUgdGxiX2ZsdXNoKCkgb3BlcmF0aW9uLg0KDQpUaGlz
IHByb2Nlc3MgaW52b2x2ZXMgY2FsbGluZyB0aGUgQ1BVIEFkZHJlc3MgU3BhY2UgTWVtb3J5IGxp
c3RlbmVyJ3MNCnRjZ19jb21taXQoKSwgIHdoaWNoIHF1ZXVlcyB0aGlzIHdvcmsgaXRlbSBmb3Ig
dGhlIENQVSB0byBiZSBleGVjdXRlZCBieQ0KdGhlIHZDUFUgYXQgdGhlIGVhcmxpZXN0IG9wcG9y
dHVuaXR5LiBEdXJpbmcgQVJNIHZDUFUgdW5yZWFsaXphdGlvbiwgd2UNCndlcmUgZGVzdHJveWlu
ZyBBZGRyZXNzIFNwYWNlIGZpcnN0LCBmb2xsb3dlZCBieSBjYWxsaW5nIGNwdV9yZW1vdmVfc3lu
YygpLg0KVGhpcyByZXN1bHRlZCB2Q1BVIHRocmVhZCBiZWluZyBsaWNrZWQgb3V0IG9mIElPIHdh
aXQgc3RhdGUsIGxlYWRpbmcgdG8NCnByb2Nlc3Npbmcgb2YgdGhlIHZDUFUgd29yayBxdWV1ZSBp
dGVtcy4gU2luY2UgdGhlIENQVSBBZGRyZXNzIFNwYWNlDQpoYWQgYWxyZWFkeSBiZWVuIGRlc3Ry
b3llZCwgdGhpcyBjYXVzZWQgdGhlIFNlZ21lbnRhdGlvbiBmYXVsdC4NCg0KSSd2ZSByZXNvbHZl
ZCB0aGlzIGlzc3VlIGJ5IGRlbGF5aW5nIHRoZSBkZXN0cnVjdGlvbiBvZiBDUFUgQWRkcmVzcyBT
cGFjZQ0KdW50aWwgdGhlIGNwdV9yZW1vdmVfc3luYygpIG9wZXJhdGlvbiBoYXMgYmVlbiBjb21w
bGV0ZWQsIGJ1dCBiZWZvcmUNCnRoZSAgcGFyZW50IGlzIHVucmVhbGl6ZWQuIFRoaXMgaGFzIHJl
c29sdmVkIHRoZSBjcmFzaC4gVGhlIHZDUFUgSG90cGx1Zw0Kb3BlcmF0aW9uIHNlZW1zIHRvIGJl
IHdvcmtpbmcgb24gVENHIG5vdy4gSSBzdGlsbCBuZWVkIHRvIHRlc3QgdGhlIG1pZ3JhdGlvbg0K
cHJvY2Vzcywgd2hpY2ggSSBwbGFuIHRvIGRvIGluIHRoZSBuZXh0IGNvdXBsZSBvZiBkYXlzLiBQ
bGVhc2UgaGF2ZSBhIGxvb2sNCmF0IGJlbG93IHBhdGNoIGFuZCB0aGUgcmVwb3NpdG9yeS4NCg0K
aHR0cHM6Ly9naXRodWIuY29tL3NhbGlsLW1laHRhL3FlbXUvY29tbWl0LzlmYmI4ZWNiYzYxYzY0
MDVkYjM0MmNjMjQzYjJiZTE3YjFjOTdlMDMNCmh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0
YS9xZW11L2NvbW1pdC8xOTAwODkzNDQ5YzFiNmExMGUxNTM0NjM1ZjI5YmZiNTQ1YjgyNWQwDQoN
Cg0KUGxlYXNlIGNoZWNrIHRoZSBiZWxvdyBicmFuY2g6DQpodHRwczovL2dpdGh1Yi5jb20vc2Fs
aWwtbWVodGEvcWVtdS9jb21taXRzL3ZpcnQtY3B1aHAtYXJtdjgvcmZjLXY0LXJjNQ0KDQoNCkJl
c3QgcmVnYXJkcw0KU2FsaWwuDQoNCg0KPiAgPiAgPiBAIEZlYiAyMDIzLCBbTGluYXJvLW9wZW4t
ZGlzY3Vzc2lvbnNdIFJlOiBRZW11IFRDRyBzdXBwb3J0IGZvciAgPg0KPiAgPiB2aXJ0dWFsLWNw
dWhvdHBsdWcvb25saW5lLXBvbGljeSAgPiAgPg0KPiAgPiBodHRwczovL29wLWxpc3RzLmxpbmFy
by5vcmcvYXJjaGl2ZXMvbGlzdC9saW5hcm8tb3Blbi1kaXNjdXNzaW9uc0BvcC1sDQo+ICA+ICA+
IGlzdHMubGluYXJvLm9yZy9tZXNzYWdlL0dNREZURVpFNldVVUk3TFpBWU9XTFhGSEFQWExDTkQ1
Lw0KPiAgPiAgPg0KPiAgPiAgPiBMYXN0IHN0YXR1cyByZXBvcnRlZCBieSBNaWd1ZWwgd2FzIHRo
YXQgdGhlcmUgd2FzIHByb2JsZW0gd2l0aCB0aGUNCj4gID4gVENHICA+IGFuZCBoZSBpbnRlbmRl
ZCB0byBmaXggdGhpcy4gSGUgd2FzIG9uIHBhdGVybml0eSBsZWF2ZSBzbyBJDQo+ICA+IHdpbGwg
dHJ5IHRvIGdhdGhlciAgdGhlIGV4YWN0IHN0YXR1cyBvZiB0aGUgVENHIHRvZGF5Lg0KPiAgPiAg
Pg0KPiAgPiAgPiBUaGFua3MNCj4gID4gID4gU2FsaWwNCj4gID4gID4NCj4gID4gID4NCj4gID4g
ID4+DQo+ICA+ICA+PiAgLS0NCj4gID4gID4+ICBBbGV4IEJlbm7DqWUNCj4gID4gID4+ICBWaXJ0
dWFsaXNhdGlvbiBUZWNoIExlYWQgQCBMaW5hcm8NCj4gID4NCj4gID4gIC0tDQo+ICA+ICBBbGV4
IEJlbm7DqWUNCj4gID4gIFZpcnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0K

