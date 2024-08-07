Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FC3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjCl-0003YR-R6; Wed, 07 Aug 2024 12:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sbjCf-0003WQ-QQ; Wed, 07 Aug 2024 12:07:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sbjCc-0001P5-7f; Wed, 07 Aug 2024 12:07:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WfFPH1NDPz6K9V2;
 Thu,  8 Aug 2024 00:04:51 +0800 (CST)
Received: from lhrpeml100005.china.huawei.com (unknown [7.191.160.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 260431400D9;
 Thu,  8 Aug 2024 00:07:36 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 17:07:35 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 7 Aug 2024 17:07:35 +0100
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
Subject: RE: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHaveq2F6TAeAWelEWGVYAetyN5RLIb0soAgABLdWCAACvQAA==
Date: Wed, 7 Aug 2024 16:07:35 +0000
Message-ID: <96d3ed46602b44519c578582b7e2ab16@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <41fbfa5a-a10f-4ca0-8a52-e447043ff306@redhat.com>
 <ed0a5631e0674c2aa4679f2388f40127@huawei.com>
In-Reply-To: <ed0a5631e0674c2aa4679f2388f40127@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.88]
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

SGkgR2F2aW4sDQoNCkkgdGVzdGVkIEFSTSBhcmNoIHNwZWNpZmljIHBhdGNoZXMgd2l0aCB0aGUg
bGF0ZXN0IFFlbXUgd2hpY2ggY29udGFpbnMgYmVsb3cgbWVudGlvbmVkDQpmaXggYW5kIEkgY2Fu
bm90IHJlcHJvZHVjZSB0aGUgY3Jhc2guIEkgdXNlZCBrZXJuZWwgbGludXgtNi4xMS1yYzIgYW5k
IGl0IGJvb3RlZCBzdWNjZXNzZnVsbHkuDQpUaG91Z2ggSSBkaWQgc2VlIGEga2VybmVsIGNyYXNo
IG9uIGF0dGVtcHRpbmcgdG8gaG90cGx1ZyBmaXJzdCB2Q1BVLiANCg0KKHFlbXUpIGRldmljZV9h
ZGQgaG9zdC1hcm0tY3B1LGlkPWNvcmU0LGNvcmUtaWQ9NA0KKHFlbXUpIFsgIDM2NS4xMjU0Nzdd
IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHdyaXRlIHRvIHJlYWQtb25seSBtZW1vcnkgYXQgdmly
dHVhbCBhZGRyZXNzIGZmZmY4MDAwODFiYTQxOTANClsgIDM2NS4xMjYzNjZdIE1lbSBhYm9ydCBp
bmZvOg0KWyAgMzY1LjEyNjY0MF0gICBFU1IgPSAweDAwMDAwMDAwOTYwMDAwNGUNClsgIDM2NS4x
MjcwMTBdICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQpbICAz
NjUuMTI3NTI0XSAgIFNFVCA9IDAsIEZuViA9IDANClsgIDM2NS4xMjc4MjJdICAgRUEgPSAwLCBT
MVBUVyA9IDANClsgIDM2NS4xMjgxMzBdICAgRlNDID0gMHgwZTogbGV2ZWwgMiBwZXJtaXNzaW9u
IGZhdWx0DQpbICAzNjUuMTI4NTk4XSBEYXRhIGFib3J0IGluZm86DQpbICAzNjUuMTI4ODgxXSAg
IElTViA9IDAsIElTUyA9IDB4MDAwMDAwNGUsIElTUzIgPSAweDAwMDAwMDAwDQpbICAzNjUuMTI5
NDQ3XSAgIENNID0gMCwgV25SID0gMSwgVG5EID0gMCwgVGFnQWNjZXNzID0gMA0KWyAgMzY1LjEy
OTk0M10gICBHQ1MgPSAwLCBPdmVybGF5ID0gMCwgRGlydHlCaXQgPSAwLCBYcyA9IDANClsgIDM2
NS4xMzA0NDJdIHN3YXBwZXIgcGd0YWJsZTogNGsgcGFnZXMsIDQ4LWJpdCBWQXMsIHBnZHA9MDAw
MDAwMDA0NTgzMDAwMA0KWyAgMzY1LjEzMTA2OF0gW2ZmZmY4MDAwODFiYTQxOTBdIHBnZD0wMDAw
MDAwMDAwMDAwMDAwLCBwNGQ9MTAwMDAwMDA0NjdkZjAwMywgcHVkPTEwMDAwMDAwNDY3ZTAwMDMs
IHBtZD0wMDYwMDAwMDQ1NjAwNzgxDQpbICAzNjUuMTMyMDY5XSBJbnRlcm5hbCBlcnJvcjogT29w
czogMDAwMDAwMDA5NjAwMDA0ZSBbIzFdIFBSRUVNUFQgU01QDQpbICAzNjUuMTMyNjYxXSBNb2R1
bGVzIGxpbmtlZCBpbjoNClsgIDM2NS4xMzI5NTJdIENQVTogMCBVSUQ6IDAgUElEOiAxMSBDb21t
OiBrd29ya2VyL3UyNDowIE5vdCB0YWludGVkIDYuMTEuMC1yYzIgIzIyOA0KWyAgMzY1LjEzMzY5
OV0gSGFyZHdhcmUgbmFtZTogUUVNVSBLVk0gVmlydHVhbCBNYWNoaW5lLCBCSU9TIDAuMC4wIDAy
LzA2LzIwMTUNClsgIDM2NS4xMzQ0MTVdIFdvcmtxdWV1ZToga2FjcGlfaG90cGx1ZyBhY3BpX2hv
dHBsdWdfd29ya19mbg0KWyAgMzY1LjEzNDk2OV0gcHN0YXRlOiA2MDQwMDAwNSAoblpDdiBkYWlm
ICtQQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMgQlRZUEU9LS0pDQpbICAzNjUuMTM1Njc5XSBwYyA6
IHJlZ2lzdGVyX2NwdSsweDEzOC8weDI1MA0KWyAgMzY1LjEzNjA5M10gbHIgOiByZWdpc3Rlcl9j
cHUrMHgxMjAvMHgyNTANClsgIDM2NS4xMzY1MDZdIHNwIDogZmZmZjgwMDA4MmNiYmExMA0KWyAg
MzY1LjEzNjg0N10geDI5OiBmZmZmODAwMDgyY2JiYTEwIHgyODogZmZmZjgwMDA4MjY0NzljMCB4
Mjc6IGZmZmYwMDAwMDBhN2UwOTgNClsgIDM2NS4xMzc1NzVdIHgyNjogZmZmZjgwMDA4MjdjMjgz
OCB4MjU6IDAwMDAwMDAwMDAwMDAwMDQgeDI0OiBmZmZmODAwMDgyNjRkOWIwDQpbICAzNjUuMTM4
MzExXSB4MjM6IDAwMDAwMDAwMDAwMDAwMDQgeDIyOiBmZmZmMDAwMDEyYTQ4MmQwIHgyMTogZmZm
ZjgwMDA4MWUzMGEwMA0KWyAgMzY1LjEzOTAzN10geDIwOiAwMDAwMDAwMDAwMDAwMDAwIHgxOTog
ZmZmZjgwMDA4MWJhNDE5MCB4MTg6IGZmZmZmZmZmZmZmZmZmZmYNClsgIDM2NS4xMzk3NjRdIHgx
NzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMDAgeDE1OiBmZmZmMDAwMDAx
YWRhYTFjDQpbICAzNjUuMTQwNDkwXSB4MTQ6IGZmZmZmZmZmZmZmZmZmZmYgeDEzOiBmZmZmMDAw
MDAxYWRhMmUwIHgxMjogMDAwMDAwMDAwMDAwMDAwMA0KWyAgMzY1LjE0MTIxNl0geDExOiBmZmZm
ODAwMDgxZTMyNzgwIHgxMDogMDAwMDAwMDAwMDAwMDAwMCB4OSA6IDAwMDAwMDAwMDAwMDAwMDEN
ClsgIDM2NS4xNDE5NDVdIHg4IDogMDEwMTAxMDEwMTAxMDEwMSB4NyA6IDdmN2Y3ZjdmN2Y3Zjdm
N2YgeDYgOiA2ZjcyNzQ3MjZlNzM3NDYwDQpbICAzNjUuMTQyNjY4XSB4NSA6IGZmZmYwMDAwMDI3
YjE5MjAgeDQgOiBmZmZmMDAwMDAyN2IxYjQwIHgzIDogZmZmZjAwMDAwMjdiMTg4MA0KWyAgMzY1
LjE0MzQwMF0geDIgOiBmZmZmMDAwMDAwMTkzM2MwIHgxIDogZmZmZjgwMDA4MWJhNDE5MCB4MCA6
IDAwMDAwMDAwMDAwMDAwMTANClsgIDM2NS4xNDQxMjldIENhbGwgdHJhY2U6DQpbICAzNjUuMTQ0
MzgyXSAgcmVnaXN0ZXJfY3B1KzB4MTM4LzB4MjUwDQpbICAzNjUuMTQ0NzU5XSAgYXJjaF9yZWdp
c3Rlcl9jcHUrMHg3Yy8weGM0DQpbICAzNjUuMTQ1MTY2XSAgYWNwaV9wcm9jZXNzb3JfYWRkKzB4
NDY4LzB4NTkwDQpbICAzNjUuMTQ1NTk0XSAgYWNwaV9idXNfYXR0YWNoKzB4MWFjLzB4MmRjDQpb
ICAzNjUuMTQ2MDAyXSAgYWNwaV9kZXZfZm9yX29uZV9jaGVjaysweDM0LzB4NDANClsgIDM2NS4x
NDY0NDldICBkZXZpY2VfZm9yX2VhY2hfY2hpbGQrMHg1Yy8weGIwDQpbICAzNjUuMTQ2ODg3XSAg
YWNwaV9kZXZfZm9yX2VhY2hfY2hpbGQrMHgzYy8weDY0DQpbICAzNjUuMTQ3MzQxXSAgYWNwaV9i
dXNfYXR0YWNoKzB4NzgvMHgyZGMNClsgIDM2NS4xNDc3MzRdICBhY3BpX2J1c19zY2FuKzB4Njgv
MHgyMDgNClsgIDM2NS4xNDgxMTBdICBhY3BpX3NjYW5fcmVzY2FuX2J1cysweDRjLzB4NzgNClsg
IDM2NS4xNDg1MzddICBhY3BpX2RldmljZV9ob3RwbHVnKzB4MWY4LzB4NDYwDQpbICAzNjUuMTQ4
OTc1XSAgYWNwaV9ob3RwbHVnX3dvcmtfZm4rMHgyNC8weDNjDQpbICAzNjUuMTQ5NDAyXSAgcHJv
Y2Vzc19vbmVfd29yaysweDE1MC8weDI5NA0KWyAgMzY1LjE0OTgxN10gIHdvcmtlcl90aHJlYWQr
MHgyZTQvMHgzZWMNClsgIDM2NS4xNTAxOTldICBrdGhyZWFkKzB4MTE4LzB4MTFjDQpbICAzNjUu
MTUwNTM2XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANClsgIDM2NS4xNTA5MDNdIENvZGU6IDkx
MDY0MDIxIDlhZDcyMDAwIDhiMTMwYzMzIGQ1MDMyMDFmIChmODIwMzI3ZikNClsgIDM2NS4xNTE1
MjddIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KDQoNCkRvIGxldCBtZSBr
bm93IGhvdyB0aGUgUWVtdSB3aXRoIEFyY2ggc3BlY2lmaWMgcGF0Y2hlcyBnb2VzLg0KDQpUaGFu
a3MNClNhbGlsLg0KDQo+ICBGcm9tOiBTYWxpbCBNZWh0YQ0KPiAgU2VudDogV2VkbmVzZGF5LCBB
dWd1c3QgNywgMjAyNCAyOjI3IFBNDQo+ICBUbzogJ0dhdmluIFNoYW4nIDxnc2hhbkByZWRoYXQu
Y29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LQ0KPiAgYXJtQG5vbmdudS5vcmc7IG1z
dEByZWRoYXQuY29tDQo+ICANCj4gIEhpIEdhdmluLA0KPiAgDQo+ICBMZXQgbWUgZmlndXJlIG91
dCB0aGlzLiBIYXZlIHlvdSBhbHNvIGluY2x1ZGVkIHRoZSBiZWxvdyBwYXRjaCBhbG9uZyB3aXRo
DQo+ICB0aGUgYXJjaGl0ZWN0dXJlIGFnbm9zdGljIHBhdGNoLXNldCBhY2NlcHRlZCBpbiB0aGlz
IFFlbXUgY3ljbGU/DQo+ICANCj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgw
MTE0MjMyMi4zOTQ4ODY2LTMtDQo+ICBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcvDQo+ICANCj4g
IA0KPiAgVGhhbmtzDQo+ICBTYWxpbC4NCj4gIA0KPiAgPiAgRnJvbTogR2F2aW4gU2hhbiA8Z3No
YW5AcmVkaGF0LmNvbT4NCj4gID4gIFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDcsIDIwMjQgMTA6
NTQgQU0NCj4gID4gIFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gID4gcWVtdS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhh
dC5jb20NCj4gID4NCj4gID4gIEhpIFNhbGlsLA0KPiAgPg0KPiAgPiAgV2l0aCB0aGlzIHNlcmll
cyBhbmQgbGF0ZXN0IHVwc3RyZWFtIExpbnV4IGtlcm5lbCAoaG9zdCksIEkgcmFuIGludG8NCj4g
ID4gY29yZSAgZHVtcCBhcyBiZWxvdy4NCj4gID4gIEknbSBub3Qgc3VyZSBpZiBpdCdzIGEga25v
d24gaXNzdWUgb3Igbm90Lg0KPiAgPg0KPiAgPiAgIyB1bmFtZSAtcg0KPiAgPiAgNi4xMS4wLXJj
Mi1nYXZpbisNCj4gID4gICMgL2hvbWUvZ2F2aW4vc2FuZGJveC9xZW11Lm1haW4vYnVpbGQvcWVt
dS1zeXN0ZW0tYWFyY2g2NCAtYWNjZWwNCj4gIGt2bQ0KPiAgPiBcDQo+ICA+ICAgICAtbWFjaGlu
ZSB2aXJ0LGdpYy12ZXJzaW9uPWhvc3QsbnZkaW1tPW9uIC1jcHUgaG9zdCAgICAgICAgICAgICAg
ICAgXA0KPiAgPiAgICAgLXNtcCBtYXhjcHVzPTIsY3B1cz0xLHNvY2tldHM9MixjbHVzdGVycz0x
LGNvcmVzPTEsdGhyZWFkcz0xICAgICAgIFwNCj4gID4gICAgIC1tIDQwOTZNLHNsb3RzPTE2LG1h
eG1lbT0xMjhHICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICA+ICAg
ICAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxpZD1tZW0wLHNpemU9MjA0OE0gICAgICAgICAg
ICAgICAgICAgICAgXA0KPiAgPiAgICAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0saWQ9bWVt
MSxzaXplPTIwNDhNICAgICAgICAgICAgICAgICAgICAgIFwNCj4gID4gICAgIC1udW1hIG5vZGUs
bm9kZWlkPTAsbWVtZGV2PW1lbTAsY3B1cz0wLTAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ICA+ICAgICAtbnVtYSBub2RlLG5vZGVpZD0xLG1lbWRldj1tZW0xLGNwdXM9MS0xICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KPiAgPiAgICAgICA6DQo+ICA+ICBxZW11LXN5c3RlbS1h
YXJjaDY0OiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBob3N0IHZjcHUgMSBBYm9ydGVkIChjb3JlDQo+
ICA+ICBkdW1wZWQpDQo+ICA+DQo+ICA+ICAjIGdkYiAvdmFyL2xpYi9zeXN0ZW1kL2NvcmVkdW1w
L2NvcmUuMA0KPiAgPiAgL2hvbWUvZ2F2aW4vc2FuZGJveC9xZW11Lm1haW4vYnVpbGQvcWVtdS1z
eXN0ZW0tYWFyY2g2NA0KPiAgPiAgKGdkYikgYnQNCj4gID4gICMwICAweDAwMDBmZmZmOWVlYzQy
ZTggaW4gX19wdGhyZWFkX2tpbGxfaW1wbGVtZW50YXRpb24gKCkgYXQNCj4gID4gIC9saWI2NC9s
aWJjLnNvLjYNCj4gID4gICMxICAweDAwMDBmZmZmOWVlN2M3M2MgaW4gcmFpc2UgKCkgYXQgL2xp
YjY0L2xpYmMuc28uNg0KPiAgPiAgIzIgIDB4MDAwMGZmZmY5ZWU2OTAzNCBpbiBhYm9ydCAoKSBh
dCAvbGliNjQvbGliYy5zby42DQo+ICA+ICAjMyAgMHgwMDAwYWFhYWM3MTE1MmMwIGluIGt2bV9h
cm1fY3JlYXRlX2hvc3RfdmNwdQ0KPiAgPiAgKGNwdT0weGFhYWFlNGMwY2I4MCkNCj4gID4gICAg
ICAgYXQgLi4vdGFyZ2V0L2FybS9rdm0uYzoxMDkzDQo+ICA+ICAjNCAgMHgwMDAwYWFhYWM3MDU3
NTIwIGluIG1hY2h2aXJ0X2luaXQgKG1hY2hpbmU9MHhhYWFhZTQ4MTk4YzApIGF0DQo+ICA+ICAu
Li9ody9hcm0vdmlydC5jOjI1MzQNCj4gID4gICM1ICAweDAwMDBhYWFhYzZiMGQzMWMgaW4gbWFj
aGluZV9ydW5fYm9hcmRfaW5pdA0KPiAgPiAgICAgICAobWFjaGluZT0weGFhYWFlNDgxOThjMCwg
bWVtX3BhdGg9MHgwLCBlcnJwPTB4ZmZmZmY3NTRlZTM4KSBhdA0KPiAgPiAgLi4vaHcvY29yZS9t
YWNoaW5lLmM6MTU3Ng0KPiAgPiAgIzYgIDB4MDAwMGFhYWFjNmY1OGQ3MCBpbiBxZW11X2luaXRf
Ym9hcmQgKCkgYXQgLi4vc3lzdGVtL3ZsLmM6MjYyMA0KPiAgPiAgIzcgIDB4MDAwMGFhYWFjNmY1
OTBkYyBpbiBxbXBfeF9leGl0X3ByZWNvbmZpZyAoZXJycD0weGFhYWFjODkxMTEyMA0KPiAgPiAg
PGVycm9yX2ZhdGFsPikNCj4gID4gICAgICAgYXQgLi4vc3lzdGVtL3ZsLmM6MjcxMg0KPiAgPiAg
IzggIDB4MDAwMGFhYWFjNmY1YjcyOCBpbiBxZW11X2luaXQgKGFyZ2M9ODIsIGFyZ3Y9MHhmZmZm
Zjc1NGYxZDgpIGF0DQo+ICA+ICAuLi9zeXN0ZW0vdmwuYzozNzU4DQo+ICA+ICAjOSAgMHgwMDAw
YWFhYWM2YTUzMTVjIGluIG1haW4gKGFyZ2M9ODIsIGFyZ3Y9MHhmZmZmZjc1NGYxZDgpIGF0DQo+
ICA+ICAuLi9zeXN0ZW0vbWFpbi5jOjQ3DQo+ICA+DQo+ICA+ICBUaGFua3MsDQo+ICA+ICBHYXZp
bg0KPiAgPg0KDQo=

