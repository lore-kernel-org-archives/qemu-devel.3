Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B36C25B10
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 00:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s48QY-0003Fk-SU; Mon, 06 May 2024 20:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s48QU-0003FT-Jy; Mon, 06 May 2024 20:11:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s48QR-0005yi-Pd; Mon, 06 May 2024 20:11:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VYJX31Y29z67ydF;
 Tue,  7 May 2024 08:08:19 +0800 (CST)
Received: from lhrpeml100006.china.huawei.com (unknown [7.191.160.224])
 by mail.maildlp.com (Postfix) with ESMTPS id 67FA81400CB;
 Tue,  7 May 2024 08:11:14 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 May 2024 01:11:14 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 7 May 2024 01:11:13 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
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
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Topic: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Index: AQHadCFXcU6yTs2isEyCNhmIUrtCDrGHWFKAgALjoLD///qlAIAAEQrg
Date: Tue, 7 May 2024 00:11:13 +0000
Message-ID: <55f942d2a3644bdaaff759014e3a4c20@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
 <CAFEAcA93EotG4-LXRJF034_9dWAWgZJA1VF6dB-xCsXn0T059g@mail.gmail.com>
 <10f35804a55e460a8ce6ecdb3f0c79b6@huawei.com>
 <CAFEAcA-w7wf9F4VVAnZR3b34ydEWq=QNw=CxhTMobsr+AP_LCg@mail.gmail.com>
In-Reply-To: <CAFEAcA-w7wf9F4VVAnZR3b34ydEWq=QNw=CxhTMobsr+AP_LCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.236]
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

PiAgRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiAgU2Vu
dDogTW9uZGF5LCBNYXkgNiwgMjAyNCAxMDoyOSBBTQ0KPiAgVG86IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgDQo+ICBPbiBNb24sIDYgTWF5IDIwMjQgYXQgMTA6MDYs
IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgd3JvdGU6DQo+ICA+DQo+
ICA+IEhpIFBldGVyLA0KPiAgPg0KPiAgPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQo+ICA+DQo+
ICA+ID4gIEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gIFdo
ZW4gZG8gd2UgbmVlZCB0bw0KPiAgPiA+IGRlc3Ryb3kgYSBzaW5nbGUgYWRkcmVzcyBzcGFjZSBp
biB0aGlzIHdheSB0aGF0IG1lYW5zICB3ZSBuZWVkIHRvDQo+ICA+ID4ga2VlcCBhIGNvdW50IG9m
IGhvdyBtYW55IEFTZXMgdGhlIENQVSBjdXJyZW50bHkgaGFzPyBUaGUgIGNvbW1pdA0KPiAgPiA+
IG1lc3NhZ2UgdGFsa3MgYWJvdXQgdGhlIGNhc2Ugd2hlbiB3ZSB1bnJlYWxpemUgdGhlIHdob2xl
IENQVQ0KPiAgPiA+IG9iamVjdCwgYnV0IGluIHRoYXQgc2l0dWF0aW9uIHlvdSBjYW4ganVzdCB0
aHJvdyBhd2F5IGFsbCB0aGUgQVNlcw0KPiAgPiA+IGF0IG9uY2UgKGVnICBieSBjYWxsaW5nIHNv
bWUNCj4gID4gPiAgY3B1X2Rlc3Ryb3lfYWRkcmVzc19zcGFjZXMoKSBmdW5jdGlvbiBmcm9tDQo+
ICBjcHVfY29tbW9uX3VucmVhbGl6ZWZuKCkpLg0KPiAgPg0KPiAgPg0KPiAgPiBZZXMsIG1heWJl
LCB3ZSBjYW4gZGVzdHJveSBhbGwgYXQgb25jZSBmcm9tIGNvbW1vbiBsZWcgYXMgd2VsbC4gSSdk
DQo+ICA+IHByZWZlciB0aGlzIHRvIGJlIGRvbmUgZnJvbSB0aGUgYXJjaCBzcGVjaWZpYyBmdW5j
dGlvbiBmb3IgQVJNIHRvDQo+ICA+IG1haW50YWluIHRoZSBjbGFyaXR5ICYgc3ltbWV0cnkgb2Yg
aW5pdGlhbGl6YXRpb24gYW5kDQo+ICA+IHVuLWluaXRpYWxpemF0aW9uIGxlZ3MuICBGb3Igbm93
LCBhbGwgb2YgdGhlc2UgYWRkcmVzcyBzcGFjZSBkZXN0cnVjdGlvbiBpcw0KPiAgaGFwcGVuaW5n
IGluIGNvbnRleHQgdG8gdGhlIGFybV9jcHVfdW5yZWFsaXplZm4oKS4NCj4gID4NCj4gID4gSXTi
gJlzIGEga2luZCBvZiB0cmFkZS1vZmYgYmV0d2VlbiBsaXR0bGUgbW9yZSBjb2RlIGFuZCBjbGFy
aXR5IGJ1dCBJJ20NCj4gID4gb3BlbiB0byBmdXJ0aGVyIHN1Z2dlc3Rpb25zLg0KPiAgPg0KPiAg
Pg0KPiAgPiA+DQo+ICA+ID4gIEFsc28sIGlmIHdlJ3JlIGxlYWtpbmcgc3R1ZmYgaGVyZSBieSBm
YWlsaW5nIHRvIGRlc3Ryb3kgaXQsIGlzIHRoYXQNCj4gID4gPiBhIHByb2JsZW0gZm9yICBleGlz
dGluZyBDUFUgdHlwZXMgbGlrZSB4ODYgdGhhdCB3ZSBjYW4gYWxyZWFkeSBob3RwbHVnPw0KPiAg
Pg0KPiAgPiBObyB3ZSBhcmUgbm90LiBXZSBhcmUgdGFraW5nIGNhcmUgb2YgdGhlc2UgaW4gdGhl
IEFSTSBhcmNoIHNwZWNpZmljDQo+ICA+IGxlZ3Mgd2l0aGluIGZ1bmN0aW9ucyBhcm1fY3B1Xyh1
bilyZWFsaXplZm4oKS4NCj4gIA0KPiAgSG93IGNhbiB5b3UgYmUgdGFraW5nIGNhcmUgb2YgKng4
NiogQ1BVIHR5cGVzIGluIHRoZSBBcm0gdW5yZWFsaXplPw0KDQoNClNvcnJ5LCB5ZXMsIEkgbWlz
c2VkIHRvIHJlcGx5IHRoYXQgY2xlYXJseS4gVGhlcmUgd2FzIGluZGVlZCBhIGxlYWsgd2l0aCB4
ODYgcmVwb3J0ZWQNCmJ5IFBoaWxsaXBlL0RhdmlkIGxhc3QgeWVhci4gSW4gZmFjdCwgUGhpbGxp
cGUgZmxvYXRlZCBhIHBhdGNoIGxhc3QgeWVhciBmb3IgdGhpcy4NCkkgdGhvdWdodCBpdCB3YXMg
Zml4ZWQgYWxyZWFkeSBhcyBwYXJ0IG9mIGNwdV9jb21tb25fdW5yZWFsaXplKCkgYnV0IEkganVz
dA0KY2hlY2tlZCBhbmQgcmVhbGl6ZWQgdGhhdCB0aGUgYmVsb3cgcHJvcG9zZWQgY2hhbmdlZCBz
dGlsbCBpc27igJl0IHBhcnQgb2YgdGhlDQptYWlubGluZQ0KDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzIwMjMwOTE4MTYwMjU3LjMwMTI3LTktcGhpbG1kQGxpbmFyby5vcmcv
DQoNCkkgY2FuIGRlZmluaXRlbHkgYWRkIGEgY29tbW9uIENQVSBBZGRyZXNzU3BhY2UgZGVzdHJ1
Y3Rpb24gbGVnIGFzIHBhcnQgb2YgdGhpcw0KcGF0Y2ggaWYgaW4gY2FzZSBhcmNoIHNwZWNpZmlj
IENQVSB1bnJlYWxpemUgZG9lcyBub3QgY2xlYW5zIHVwIGl0cyBDUFUNCkFkZHJlc3NTcGFjZT8N
Cg0KDQpUaGFua3MNClNhbGlsLg0KDQo+ICANCj4gIHRoYW5rcw0KPiAgLS0gUE1NDQo=

