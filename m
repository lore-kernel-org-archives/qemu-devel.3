Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3611CC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 13:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1zG-0000hF-NE; Mon, 19 Aug 2024 08:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1zA-0000QA-R7; Mon, 19 Aug 2024 08:59:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1z7-0005R2-OZ; Mon, 19 Aug 2024 08:59:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnXfc1NJkz6LDKS;
 Mon, 19 Aug 2024 20:56:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C552140CB1;
 Mon, 19 Aug 2024 20:59:43 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 13:59:42 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 19 Aug 2024 13:59:42 +0100
To: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "richard.henderson@linaro.org"
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
Subject: RE: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
Thread-Topic: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
Thread-Index: AQHavev6H7OxF7zZK02qabf2MUOdZrIqaJGS///y5oCAABNygIAEhE9Q
Date: Mon, 19 Aug 2024 12:59:42 +0000
Message-ID: <8cfd576d650c43128e9f1015827ab66a@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
 <CAFEAcA9A9Oq0nURkiLNWZNC=P7KQGyr8TjjfOmEq+squwF+xog@mail.gmail.com>
 <CAFEAcA99RF2tY-9DfhdkCxrR=ayEjJYKEQ4xZSn3BBrXdOjU_Q@mail.gmail.com>
In-Reply-To: <CAFEAcA99RF2tY-9DfhdkCxrR=ayEjJYKEQ4xZSn3BBrXdOjU_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.47]
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

PiAgRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiAgU2Vu
dDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgNjowMCBQTQ0KPiAgVG86IEFsZXggQmVubsOpZSA8
YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gIA0KPiAgT24gRnJpLCAxNiBBdWcgMjAyNCBhdCAx
Njo1MCwgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiAgd3JvdGU6
DQo+ICA+IFdlIHNob3VsZG4ndCBuZWVkIHRvIGV4cGxpY2l0bHkgY2FsbCBjcHVfYWRkcmVzc19z
cGFjZV9kZXN0cm95KCkgZnJvbQ0KPiAgPiBhIHRhcmdldC1zcGVjaWZpYyB1bnJlYWxpemUgYW55
d2F5OiB3ZSBjYW4gZG8gaXQgYWxsIGZyb20gdGhlIGJhc2UNCj4gID4gY2xhc3MgKGFuZCBJIHRo
aW5rIHRoaXMgd291bGQgZml4IHNvbWUgbGVha3MgaW4gY3VycmVudCBjb2RlIGZvcg0KPiAgPiB0
YXJnZXRzIHRoYXQgaG90LXVucGx1ZywgdGhvdWdoIEkgc2hvdWxkIGNoZWNrIHRoYXQpLiBPdGhl
cndpc2UgeW91DQo+ICA+IG5lZWQgdG8gZHVwbGljYXRlIGFsbCB0aGUgbG9naWMgZm9yIGZpZ3Vy
aW5nIG91dCB3aGljaCBhZGRyZXNzIHNwYWNlcw0KPiAgPiB3ZSBjcmVhdGVkIGluIHJlYWxpemUs
IHdoaWNoIGlzIGZyYWdpbGUgYW5kIG5vdCBuZWNlc3Nhcnkgd2hlbiBhbGwgd2UNCj4gID4gd2Fu
dCB0byBkbyBpcyAiZGVsZXRlIGV2ZXJ5IGFkZHJlc3Mgc3BhY2UgdGhlIENQVSBvYmplY3QgaGFz
Ig0KPiAgPiBhbmQgd2Ugd2FudCB0byBkbyB0aGF0IGZvciBldmVyeSB0YXJnZXQgYXJjaGl0ZWN0
dXJlIGFsd2F5cy4NCj4gIA0KPiAgSSBoYXZlIGEgcGF0Y2ggdG8gZG8gdGhpcyBub3csIGJ1dCBJ
IG5lZWQgdG8gdGVzdCBpdCBhIGJpdCBtb3JlIGFuZCBjb25maXJtIChvcg0KPiAgZGlzcHJvdmUp
IG15IGh5cG90aGVzaXMgdGhhdCB3ZSdyZSBjdXJyZW50bHkgbGVha2luZyBtZW1vcnkgb24gZXhp
c3RpbmcNCj4gIGFyY2hpdGVjdHVyZXMgd2l0aCB2Q1BVIGhvdC11bnBsdWcgYmVmb3JlIEkgc2Vu
ZCBpdCBvdXQuDQoNCkkgdGhpbmsgeW91IGFyZSByZWZlcnJpbmcgdG8gdGhpcyBwYXRjaD8NCg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDkxODE2MDI1Ny4zMDEyNy05
LXBoaWxtZEBsaW5hcm8ub3JnLw0KDQoNCj4gIA0KPiAgLS0gUE1NDQo=

