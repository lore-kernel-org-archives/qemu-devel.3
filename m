Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD6C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90fy-0003Bc-7g; Mon, 20 May 2024 06:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s90fp-00039G-Gy; Mon, 20 May 2024 06:55:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s90fm-0003lp-HG; Mon, 20 May 2024 06:55:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VjZB91nPzz6J67Z;
 Mon, 20 May 2024 18:51:29 +0800 (CST)
Received: from lhrpeml100005.china.huawei.com (unknown [7.191.160.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 26D871400D4;
 Mon, 20 May 2024 18:55:14 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 11:55:13 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 20 May 2024 11:55:13 +0100
To: Nicholas Piggin <npiggin@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
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
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, Linuxarm
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>
Subject: RE: [PATCH V9 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Topic: [PATCH V9 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Index: AQHaqjDkHC86gPbskES/QKJueu2z1rGft5QAgAA7LuA=
Date: Mon, 20 May 2024 10:55:13 +0000
Message-ID: <46d1577dc27a4012bb90d9871d03fabe@huawei.com>
References: <20240519210620.228342-1-salil.mehta@huawei.com>
 <20240519210620.228342-7-salil.mehta@huawei.com>
 <D1EBOZTRN8SZ.Q9F4CFDZ8VYW@gmail.com>
In-Reply-To: <D1EBOZTRN8SZ.Q9F4CFDZ8VYW@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

PiAgRnJvbTogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4NCj4gIFNlbnQ6IE1v
bmRheSwgTWF5IDIwLCAyMDI0IDk6MTkgQU0NCj4gIA0KPiAgT24gTW9uIE1heSAyMCwgMjAyNCBh
dCA3OjA2IEFNIEFFU1QsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiBWaXJ0dWFsIENQVSBIb3Qt
dW5wbHVnIGxlYWRzIHRvIHVucmVhbGl6YXRpb24gb2YgYSBDUFUgb2JqZWN0LiBUaGlzDQo+ICA+
IGFsc28gaW52b2x2ZXMgZGVzdHJ1Y3Rpb24gb2YgdGhlIENQVSBBZGRyZXNzU3BhY2UuIEFkZCBj
b21tb24gZnVuY3Rpb24NCj4gID4gdG8gaGVscCBkZXN0cm95IHRoZSBDUFUgQWRkcmVzc1NwYWNl
Lg0KPiAgDQo+ICBQYXRjaGVzIDYsNyBzZWVtIG9rYXkgdG8gbWUuIEkgd291bGQgbGlrZSB0byBz
ZWUgYSBzZXJpZXMgd2hlcmUgdGhleSBnZXQNCj4gIHVzZWQuIFdvdWxkIGl0IGJlIHBvc3NpYmxl
IHRvIGluY2x1ZGUgYXQgbGVhc3QgYSBUQ0cgdXNlciBpbiB5b3VyIHNlcmllcz8gVGhhdA0KPiAg
d291bGQgbWFrZSBpdCBlYXNpZXIgdG8gcmV2aWV3IGFuZCB0ZXN0Lg0KDQoNCklmIHlvdSB3aXNo
IHRvIHBsYXkgdGhlbiB5b3UgY2FuIHVzZSBiZWxvdyByZXBvc2l0b3J5IHdoaWNoIGlzIFY4IHZl
cnNpb24gb2YNCmFyY2hpdGVjdHVyZSBhZ25vc3RpYyBwYXRjaC1zZXQgcGx1cyBhcmNoaXRlY3R1
cmUgZGVwZW5kZW50IHBhdGNoLXNldA0Kc3RhY2tlZCB1cCB0b2dldGhlci4gVGhpcyBlZmZlY3Rp
dmVseSBSRkMgVjIgcmVhcnJhbmdlZCB3aXRoIGNsZWFyIHNlcGFyYXRpb24NCm9mIGFyY2ggYWdu
b3N0aWMgYW5kIHNwZWNpZmljIHBhcnRzIGFuZCBzb21lIHJldmlldyBjb21tZW50cyBpbmNvcnBv
cmF0ZWQuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11L2NvbW1pdHMvdmly
dC1jcHVocC1hcm12OC9yZmMtdjMtcmMxLw0KDQoNCkl0IGhhcyBUQ0cgYnV0IGl0IGhhcyBzb21l
IGlzc3VlcyBhbmQgaGVuY2Ugd2UgaGF2ZSBkaXNhYmxlZCBpdCBmb3Igbm93LiBXZSBhcmUNCndv
cmtpbmcgdG8gZml4IGl0Lg0KDQoNClRoYW5rcw0KU2FsaWwuDQoNCj4gIA0KPiAgVGhhbmtzLA0K
PiAgTmljaw0K

