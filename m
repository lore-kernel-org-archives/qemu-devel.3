Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7855CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slqc4-00049b-DP; Wed, 04 Sep 2024 10:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slqc3-00048O-4N; Wed, 04 Sep 2024 10:03:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slqc0-0000w2-L9; Wed, 04 Sep 2024 10:03:58 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WzPHc0Yt9z6K6Xv;
 Wed,  4 Sep 2024 21:59:24 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
 by mail.maildlp.com (Postfix) with ESMTPS id 907B5140682;
 Wed,  4 Sep 2024 22:03:48 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 15:03:48 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 4 Sep 2024 15:03:48 +0100
To: Gustavo Romero <gustavo.romero@linaro.org>, "qemu-devel@nongnu.org"
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
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHaveq2F6TAeAWelEWGVYAetyN5RLI9hyQAgAqizhA=
Date: Wed, 4 Sep 2024 14:03:48 +0000
Message-ID: <f2ee74b843a34c848d555b479cbaa986@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
In-Reply-To: <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
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

SGkgR3VzdGF2bywNCg0KPiAgRnJvbTogR3VzdGF2byBSb21lcm8gPGd1c3Rhdm8ucm9tZXJvQGxp
bmFyby5vcmc+DQo+ICBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyOCwgMjAyNCA5OjM2IFBNDQo+
ICBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5v
bmdudS5vcmc7DQo+ICBxZW11LWFybUBub25nbnUub3JnOyBtc3RAcmVkaGF0LmNvbQ0KPiAgDQo+
ICBIaSBTYWxpbCwNCj4gIA0KPiAgT24gNi8xMy8yNCA4OjM2IFBNLCBTYWxpbCBNZWh0YSB2aWEg
d3JvdGU6DQo+ICA+IFBST0xPR1VFDQo+ICA+ID09PT09PT09DQo+ICA+DQo+ICA+IFRvIGFzc2lz
dCBpbiByZXZpZXcgYW5kIHNldCB0aGUgcmlnaHQgZXhwZWN0YXRpb25zIGZyb20gdGhpcyBSRkMs
DQo+ICA+IHBsZWFzZSBmaXJzdCByZWFkIHRoZSBzZWN0aW9ucyAqQVBQRU5ERUQgQVQgVEhFIEVO
RCogb2YgdGhpcyBjb3Zlcg0KPiAgbGV0dGVyOg0KPiAgPg0KPiAgPiAxLiBJbXBvcnRhbnQgKkRJ
U0NMQUlNRVIqIFtTZWN0aW9uIChYKV0gMi4gV29yayBwcmVzZW50ZWQgYXQNCj4gIEtWTUZvcnVt
DQo+ICA+IENvbmZlcmVuY2UgKHNsaWRlcyBhdmFpbGFibGUpIFtTZWN0aW9uIChWKUZdIDMuIE9y
Z2FuaXphdGlvbiBvZg0KPiAgPiBwYXRjaGVzIFtTZWN0aW9uIChYSSldIDQuIFJlZmVyZW5jZXMg
W1NlY3Rpb24gKFhJSSldIDUuIERldGFpbGVkIFRPRE8NCj4gID4gbGlzdCBvZiBsZWZ0b3ZlciB3
b3JrIG9yIHdvcmstaW4tcHJvZ3Jlc3MgW1NlY3Rpb24gKElYKV0NCj4gID4NCj4gID4gVGhlcmUg
aGFzIGJlZW4gaW50ZXJlc3Qgc2hvd24gYnkgb3RoZXIgb3JnYW5pemF0aW9ucyBpbiBhZGFwdGlu
ZyB0aGlzDQo+ICA+IHNlcmllcyBmb3IgdGhlaXIgYXJjaGl0ZWN0dXJlLiBIZW5jZSwgUkZDIFYy
IFsyMV0gaGFzIGJlZW4gc3BsaXQgaW50bw0KPiAgPiBhcmNoaXRlY3R1cmUNCj4gID4gKmFnbm9z
dGljKiBbMjJdIGFuZCAqc3BlY2lmaWMqIHBhdGNoIHNldHMuDQo+ICA+DQo+ICA+IFRoaXMgaXMg
YW4gQVJNIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBwYXRjaCBzZXQgY2FydmVkIG91dCBvZiBSRkMg
VjIuDQo+ICA+IFBsZWFzZSBjaGVjayBzZWN0aW9uIChYSSlCIGZvciBkZXRhaWxzIG9mIGFyY2hp
dGVjdHVyZSBhZ25vc3RpYyBwYXRjaGVzLg0KPiAgPg0KPiAgPiBTRUNUSU9OUyBbSSAtIFhJSUld
IGFyZSBhcyBmb2xsb3dzOg0KPiAgPg0KPiAgPiAoSSkgS2V5IENoYW5nZXMgW2RldGFpbHMgaW4g
bGFzdCBzZWN0aW9uIChYSVYpXQ0KPiAgPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+ICA+DQo+ICA+IFJGQyBWMiAtPiBSRkMgVjMNCj4gID4NCg0KWy4u
Ll0NCg0KPiAgPg0KPiAgPiAoVkkpIENvbW1hbmRzIFVzZWQNCj4gID4gPT09PT09PT09PT09PT09
PT09DQo+ICA+DQo+ICA+IEEuIFFlbXUgbGF1bmNoIGNvbW1hbmRzIHRvIGluaXQgdGhlIG1hY2hp
bmU6DQo+ICA+DQo+ICA+ICAgICAgJCBxZW11LXN5c3RlbS1hYXJjaDY0IC0tZW5hYmxlLWt2bSAt
bWFjaGluZSB2aXJ0LGdpYy12ZXJzaW9uPTMgXA0KPiAgPiAgICAgICAgLWNwdSBob3N0IC1zbXAg
Y3B1cz00LG1heGNwdXM9NiBcDQo+ICA+ICAgICAgICAtbSAzMDBNIFwNCj4gID4gICAgICAgIC1r
ZXJuZWwgSW1hZ2UgXA0KPiAgPiAgICAgICAgLWluaXRyZCByb290ZnMuY3Bpby5neiBcDQo+ICA+
ICAgICAgICAtYXBwZW5kICJjb25zb2xlPXR0eUFNQTAgcm9vdD0vZGV2L3JhbSByZGluaXQ9L2lu
aXQgbWF4Y3B1cz0yDQo+ICBhY3BpPWZvcmNlIiBcDQo+ICA+ICAgICAgICAtbm9ncmFwaGljIFwN
Cj4gID4gICAgICAgIC1iaW9zIFFFTVVfRUZJLmZkIFwNCj4gID4NCj4gID4gQi4gSG90LSh1bilw
bHVnIHJlbGF0ZWQgY29tbWFuZHM6DQo+ICA+DQo+ICA+ICAgICMgSG90cGx1ZyBhIGhvc3QgdkNQ
VSAoYWNjZWw9a3ZtKToNCj4gID4gICAgICAkIGRldmljZV9hZGQgaG9zdC1hcm0tY3B1LGlkPWNv
cmU0LGNvcmUtaWQ9NA0KPiAgPg0KPiAgPiAgICAjIEhvdHBsdWcgYSB2Q1BVIChhY2NlbD10Y2cp
Og0KPiAgPiAgICAgICQgZGV2aWNlX2FkZCBjb3J0ZXgtYTU3LWFybS1jcHUsaWQ9Y29yZTQsY29y
ZS1pZD00DQo+ICANCj4gIFNpbmNlIHN1cHBvcnQgZm9yIGhvdHBsdWcgaXMgZGlzYWJsZWQgb24g
VENHLCByZW1vdmUgdGhlc2UgdHdvIGxpbmVzIGluIHY0DQo+ICBjb3ZlciBsZXR0ZXI/DQoNCg0K
V2UgYXJlIGZpeGluZyB0aGF0IGFuZCBpdCBzaG91bGQgYmUgcGFydCBvZiBSRkMgVjQuDQoNCg0K
VGhhbmtzDQpTYWxpbC4NCg0KDQo+ICANCj4gIA0KPiAgQ2hlZXJzLA0KPiAgR3VzdGF2bw0KPiAg
DQo+ICA+ICAgICMgRGVsZXRlIHRoZSB2Q1BVOg0KPiAgPiAgICAgICQgZGV2aWNlX2RlbCBjb3Jl
NA0KPiAgPg0KDQpbLi4uXQ0K

