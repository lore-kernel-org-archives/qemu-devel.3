Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8868CCD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slqw2-0001rv-R2; Wed, 04 Sep 2024 10:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slqw1-0001r2-Cv; Wed, 04 Sep 2024 10:24:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slqvy-0008Mp-Vn; Wed, 04 Sep 2024 10:24:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WzPlP4kGqz6K5vF;
 Wed,  4 Sep 2024 22:20:01 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 7CBB2140B55;
 Wed,  4 Sep 2024 22:24:26 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 15:24:26 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 4 Sep 2024 15:24:26 +0100
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Gustavo Romero
 <gustavo.romero@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
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
Thread-Index: AQHaveq2F6TAeAWelEWGVYAetyN5RLI9hyQAgADxfM+ACbIgYA==
Date: Wed, 4 Sep 2024 14:24:26 +0000
Message-ID: <a874e995c188480fb08deac3ccf0cc2d@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
 <87bk1b3azm.fsf@draig.linaro.org>
In-Reply-To: <87bk1b3azm.fsf@draig.linaro.org>
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

SGkgQWxleCwNCg0KPiAgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gIEZyb206IEFsZXgg
QmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gIFNlbnQ6IFRodXJzZGF5LCBBdWd1
c3QgMjksIDIwMjQgMTE6MDAgQU0NCj4gIFRvOiBHdXN0YXZvIFJvbWVybyA8Z3VzdGF2by5yb21l
cm9AbGluYXJvLm9yZz4NCj4gIA0KPiAgR3VzdGF2byBSb21lcm8gPGd1c3Rhdm8ucm9tZXJvQGxp
bmFyby5vcmc+IHdyaXRlczoNCj4gIA0KPiAgPiBIaSBTYWxpbCwNCj4gID4NCj4gID4gT24gNi8x
My8yNCA4OjM2IFBNLCBTYWxpbCBNZWh0YSB2aWEgd3JvdGU6DQo+ICA8c25pcD4NCj4gID4+IChW
SSkgQ29tbWFuZHMgVXNlZA0KPiAgPj4gPT09PT09PT09PT09PT09PT09DQo+ICA+PiBBLiBRZW11
IGxhdW5jaCBjb21tYW5kcyB0byBpbml0IHRoZSBtYWNoaW5lOg0KPiAgPj4gICAgICAkIHFlbXUt
c3lzdGVtLWFhcmNoNjQgLS1lbmFibGUta3ZtIC1tYWNoaW5lIHZpcnQsZ2ljLXZlcnNpb249MyBc
DQo+ICA+PiAgICAgICAgLWNwdSBob3N0IC1zbXAgY3B1cz00LG1heGNwdXM9NiBcDQo+ICA+PiAg
ICAgICAgLW0gMzAwTSBcDQo+ICA+PiAgICAgICAgLWtlcm5lbCBJbWFnZSBcDQo+ICA+PiAgICAg
ICAgLWluaXRyZCByb290ZnMuY3Bpby5neiBcDQo+ICA+PiAgICAgICAgLWFwcGVuZCAiY29uc29s
ZT10dHlBTUEwIHJvb3Q9L2Rldi9yYW0gcmRpbml0PS9pbml0IG1heGNwdXM9Mg0KPiAgYWNwaT1m
b3JjZSIgXA0KPiAgPj4gICAgICAgIC1ub2dyYXBoaWMgXA0KPiAgPj4gICAgICAgIC1iaW9zIFFF
TVVfRUZJLmZkIFwNCj4gID4+IEIuIEhvdC0odW4pcGx1ZyByZWxhdGVkIGNvbW1hbmRzOg0KPiAg
Pj4gICAgIyBIb3RwbHVnIGEgaG9zdCB2Q1BVIChhY2NlbD1rdm0pOg0KPiAgPj4gICAgICAkIGRl
dmljZV9hZGQgaG9zdC1hcm0tY3B1LGlkPWNvcmU0LGNvcmUtaWQ9NA0KPiAgPj4gICAgIyBIb3Rw
bHVnIGEgdkNQVSAoYWNjZWw9dGNnKToNCj4gID4+ICAgICAgJCBkZXZpY2VfYWRkIGNvcnRleC1h
NTctYXJtLWNwdSxpZD1jb3JlNCxjb3JlLWlkPTQNCj4gID4NCj4gID4gU2luY2Ugc3VwcG9ydCBm
b3IgaG90cGx1ZyBpcyBkaXNhYmxlZCBvbiBUQ0csIHJlbW92ZSB0aGVzZSB0d28gbGluZXMNCj4g
ID4gaW4gdjQgY292ZXIgbGV0dGVyPw0KPiAgDQo+ICBXaHkgaXMgaXQgZGlzYWJsZWQgZm9yIFRD
Rz8gV2Ugc2hvdWxkIGFpbSBmb3IgVENHIGJlaW5nIGFzIGNsb3NlIHRvIEtWTSBhcw0KPiAgcG9z
c2libGUgZm9yIGRldmVsb3BlcnMgZXZlbiBpZiBpdCBpcyBub3QgYSBwcm9kdWN0aW9uIHNvbHV0
aW9uLg0KDQpBZ3JlZWQgSW4gcHJpbmNpcGxlLiBZZXMsIHRoYXQgd291bGQgYmUgb2YgaGVscC4N
Cg0KDQpDb250ZXh0IHdoeSBpdCB3YXMgZGlzYWJsZWQgYWx0aG91Z2ggbW9zdCBjb2RlIHRvIHN1
cHBvcnQgVENHIGV4aXN0Og0KDQpJIGhhZCByZXBvcnRlZCBhIGNyYXNoIGluIHRoZSBSRkMgVjEg
KEp1bmUgMjAyMCkgYWJvdXQgVENHQ29udGV4dCBjb3VudGVyDQpvdmVyZmxvdyBhc3NlcnRpb24g
ZHVyaW5nIHJlcGVhdGVkIGhvdCh1bilwbHVnIG9wZXJhdGlvbi4gTWlndWVsIGZyb20gT3JhY2xl
DQp3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBwcm9ibGVtIGxhc3QgeWVhciBpbiBGZWIgYW5k
IGFsc28gc3VnZ2VzdGVkIGEgZml4IGJ1dCBoZQ0KbGF0ZXIgZm91bmQgb3V0IGluIGhpcyB0ZXN0
aW5nIHRoYXQgdGhlcmUgd2FzIGEgcHJvYmxlbSBkdXJpbmcgbWlncmF0aW9uLg0KDQpSRkMgVjEg
SnVuZSAyMDIwOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIwMDYxMzIx
MzYyOS4yMTk4NC0xLXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQpTY3JvbGwgdG8gYmVsb3c6DQpb
Li4uXQ0KVEhJTkdTIFRPIERPOg0KICgqKSBNaWdyYXRpb24gc3VwcG9ydCANCiAoKikgVENHL0Vt
dWxhdGlvbiBzdXBwb3J0IGlzIG5vdCBwcm9wZXIgcmlnaHQgbm93LiBXb3JrcyB0byBhIGNlcnRh
aW4gZXh0ZW50DQogICAgIGJ1dCBpcyBub3QgY29tcGxldGUuIGVzcGVjaWFsbHkgdGhlIHVucmVh
bGl6ZSBwYXJ0IGluIHdoaWNoIHRoZXJlIGlzIGENCiAgICAgb3ZlcmZsb3cgb2YgdGNnIGNvbnRl
eHRzLiBUaGUgbGFzdCBpcyBkdWUgdG8gdGhlIGZhY3QgdGNnIG1haW50YWlucyBhIA0KICAgICBj
b3VudCBvbiBudW1iZXIgb2YgY29udGV4dChwZXIgdGhyZWFkIGluc3RhbmNlKSBzbyBhcyB3ZSBo
b3RwbHVnIHRoZSB2Y3B1cw0KICAgICB0aGlzIGNvdW50ZXIga2VlcHMgb24gaW5jcmVtZW50aW5n
LiBCdXQgZHVyaW5nIGhvdC11bnBsdWcgdGhlIGNvdW50ZXIgaXMNCiAgICAgbm90IGRlY3JlbWVu
dGVkLg0KDQpAIEZlYiAyMDIzLCBbTGluYXJvLW9wZW4tZGlzY3Vzc2lvbnNdIFJlOiBRZW11IFRD
RyBzdXBwb3J0IGZvciB2aXJ0dWFsLWNwdWhvdHBsdWcvb25saW5lLXBvbGljeSANCg0KaHR0cHM6
Ly9vcC1saXN0cy5saW5hcm8ub3JnL2FyY2hpdmVzL2xpc3QvbGluYXJvLW9wZW4tZGlzY3Vzc2lv
bnNAb3AtbGlzdHMubGluYXJvLm9yZy9tZXNzYWdlL0dNREZURVpFNldVVUk3TFpBWU9XTFhGSEFQ
WExDTkQ1Lw0KDQpMYXN0IHN0YXR1cyByZXBvcnRlZCBieSBNaWd1ZWwgd2FzIHRoYXQgdGhlcmUg
d2FzIHByb2JsZW0gd2l0aCB0aGUgVENHIGFuZCBoZSBpbnRlbmRlZA0KdG8gZml4IHRoaXMuIEhl
IHdhcyBvbiBwYXRlcm5pdHkgbGVhdmUgc28gSSB3aWxsIHRyeSB0byBnYXRoZXIgdGhlIGV4YWN0
IHN0YXR1cyBvZiB0aGUgVENHIHRvZGF5Lg0KDQpUaGFua3MNClNhbGlsDQoNCg0KPiAgDQo+ICAt
LQ0KPiAgQWxleCBCZW5uw6llDQo+ICBWaXJ0dWFsaXNhdGlvbiBUZWNoIExlYWQgQCBMaW5hcm8N
Cg==

