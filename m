Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E202C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uIm-0008VC-OC; Mon, 06 May 2024 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s3uIk-0008Ur-3C; Mon, 06 May 2024 05:06:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s3uIf-0005jy-LQ; Mon, 06 May 2024 05:06:25 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VXwRY1jGKz6K5x4;
 Mon,  6 May 2024 17:03:05 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 08E80140447;
 Mon,  6 May 2024 17:06:04 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 May 2024 10:06:03 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 6 May 2024 10:06:03 +0100
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
Thread-Index: AQHadCFXcU6yTs2isEyCNhmIUrtCDrGHWFKAgALjoLA=
Date: Mon, 6 May 2024 09:06:03 +0000
Message-ID: <10f35804a55e460a8ce6ecdb3f0c79b6@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
 <CAFEAcA93EotG4-LXRJF034_9dWAWgZJA1VF6dB-xCsXn0T059g@mail.gmail.com>
In-Reply-To: <CAFEAcA93EotG4-LXRJF034_9dWAWgZJA1VF6dB-xCsXn0T059g@mail.gmail.com>
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
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

SGkgUGV0ZXIsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAgRnJvbTogUGV0ZXIgTWF5
ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiAgU2VudDogU2F0dXJkYXksIE1heSA0
LCAyMDI0IDI6NDEgUE0NCj4gIA0KPiAgT24gVHVlLCAxMiBNYXIgMjAyNCBhdCAwMjowMiwgU2Fs
aWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICB3cm90ZToNCj4gID4NCj4gID4g
VmlydHVhbCBDUFUgSG90LXVucGx1ZyBsZWFkcyB0byB1bnJlYWxpemF0aW9uIG9mIGEgQ1BVIG9i
amVjdC4gVGhpcw0KPiAgPiBhbHNvIGludm9sdmVzIGRlc3RydWN0aW9uIG9mIHRoZSBDUFUgQWRk
cmVzc1NwYWNlLiBBZGQgY29tbW9uIGZ1bmN0aW9uDQo+ICA+IHRvIGhlbHAgZGVzdHJveSB0aGUg
Q1BVIEFkZHJlc3NTcGFjZS4NCj4gID4NCj4gID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+IFRlc3RlZC1ieTogVmlzaG51IFBhamp1cmkg
PHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiAgPiBSZXZpZXdlZC1ieTogR2F2aW4g
U2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gID4gVGVzdGVkLWJ5OiBYaWFuZ2xhaSBMaSA8bGl4
aWFuZ2xhaUBsb29uZ3Nvbi5jbj4NCj4gID4gVGVzdGVkLWJ5OiBNaWd1ZWwgTHVpcyA8bWlndWVs
Lmx1aXNAb3JhY2xlLmNvbT4NCj4gID4gUmV2aWV3ZWQtYnk6IFNoYW9xaW4gSHVhbmcgPHNoYWh1
YW5nQHJlZGhhdC5jb20+DQo+ICANCj4gID4gZGlmZiAtLWdpdCBhL3N5c3RlbS9waHlzbWVtLmMg
Yi9zeXN0ZW0vcGh5c21lbS5jIGluZGV4DQo+ICA+IDZlOWVkOTc1OTcuLjYxYjMyYWM0ZjIgMTAw
NjQ0DQo+ICA+IC0tLSBhL3N5c3RlbS9waHlzbWVtLmMNCj4gID4gKysrIGIvc3lzdGVtL3BoeXNt
ZW0uYw0KPiAgPiBAQCAtNzYxLDYgKzc2MSw3IEBAIHZvaWQgY3B1X2FkZHJlc3Nfc3BhY2VfaW5p
dChDUFVTdGF0ZSAqY3B1LCBpbnQNCj4gID4gYXNpZHgsDQo+ICA+DQo+ICA+ICAgICAgaWYgKCFj
cHUtPmNwdV9hc2VzKSB7DQo+ICA+ICAgICAgICAgIGNwdS0+Y3B1X2FzZXMgPSBnX25ldzAoQ1BV
QWRkcmVzc1NwYWNlLCBjcHUtPm51bV9hc2VzKTsNCj4gID4gKyAgICAgICAgY3B1LT5jcHVfYXNl
c19jb3VudCA9IGNwdS0+bnVtX2FzZXM7DQo+ICA+ICAgICAgfQ0KPiAgPg0KPiAgPiAgICAgIG5l
d2FzID0gJmNwdS0+Y3B1X2FzZXNbYXNpZHhdOw0KPiAgPiBAQCAtNzc0LDYgKzc3NSwzNCBAQCB2
b2lkIGNwdV9hZGRyZXNzX3NwYWNlX2luaXQoQ1BVU3RhdGUgKmNwdSwgaW50DQo+ICBhc2lkeCwN
Cj4gID4gICAgICB9DQo+ICA+ICB9DQo+ICA+DQo+ICA+ICt2b2lkIGNwdV9hZGRyZXNzX3NwYWNl
X2Rlc3Ryb3koQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4KSB7DQo+ICA+ICsgICAgQ1BVQWRkcmVz
c1NwYWNlICpjcHVhczsNCj4gID4gKw0KPiAgPiArICAgIGFzc2VydChjcHUtPmNwdV9hc2VzKTsN
Cj4gID4gKyAgICBhc3NlcnQoYXNpZHggPj0gMCAmJiBhc2lkeCA8IGNwdS0+bnVtX2FzZXMpOw0K
PiAgPiArICAgIC8qIEtWTSBjYW5ub3QgY3VycmVudGx5IHN1cHBvcnQgbXVsdGlwbGUgYWRkcmVz
cyBzcGFjZXMuICovDQo+ICA+ICsgICAgYXNzZXJ0KGFzaWR4ID09IDAgfHwgIWt2bV9lbmFibGVk
KCkpOw0KPiAgPiArDQo+ICA+ICsgICAgY3B1YXMgPSAmY3B1LT5jcHVfYXNlc1thc2lkeF07DQo+
ICA+ICsgICAgaWYgKHRjZ19lbmFibGVkKCkpIHsNCj4gID4gKyAgICAgICAgbWVtb3J5X2xpc3Rl
bmVyX3VucmVnaXN0ZXIoJmNwdWFzLT50Y2dfYXNfbGlzdGVuZXIpOw0KPiAgPiArICAgIH0NCj4g
ID4gKw0KPiAgPiArICAgIGFkZHJlc3Nfc3BhY2VfZGVzdHJveShjcHVhcy0+YXMpOw0KPiAgPiAr
ICAgIGdfZnJlZV9yY3UoY3B1YXMtPmFzLCByY3UpOw0KPiAgPiArDQo+ICA+ICsgICAgaWYgKGFz
aWR4ID09IDApIHsNCj4gID4gKyAgICAgICAgLyogcmVzZXQgdGhlIGNvbnZlbmllbmNlIGFsaWFz
IGZvciBhZGRyZXNzIHNwYWNlIDAgKi8NCj4gID4gKyAgICAgICAgY3B1LT5hcyA9IE5VTEw7DQo+
ICA+ICsgICAgfQ0KPiAgPiArDQo+ICA+ICsgICAgaWYgKC0tY3B1LT5jcHVfYXNlc19jb3VudCA9
PSAwKSB7DQo+ICA+ICsgICAgICAgIGdfZnJlZShjcHUtPmNwdV9hc2VzKTsNCj4gID4gKyAgICAg
ICAgY3B1LT5jcHVfYXNlcyA9IE5VTEw7DQo+ICA+ICsgICAgfQ0KPiAgPiArfQ0KPiAgDQo+ICBX
aGVuIGRvIHdlIG5lZWQgdG8gZGVzdHJveSBhIHNpbmdsZSBhZGRyZXNzIHNwYWNlIGluIHRoaXMg
d2F5IHRoYXQgbWVhbnMNCj4gIHdlIG5lZWQgdG8ga2VlcCBhIGNvdW50IG9mIGhvdyBtYW55IEFT
ZXMgdGhlIENQVSBjdXJyZW50bHkgaGFzPyBUaGUNCj4gIGNvbW1pdCBtZXNzYWdlIHRhbGtzIGFi
b3V0IHRoZSBjYXNlIHdoZW4gd2UgdW5yZWFsaXplIHRoZSB3aG9sZSBDUFUNCj4gIG9iamVjdCwg
YnV0IGluIHRoYXQgc2l0dWF0aW9uIHlvdSBjYW4ganVzdCB0aHJvdyBhd2F5IGFsbCB0aGUgQVNl
cyBhdCBvbmNlIChlZw0KPiAgYnkgY2FsbGluZyBzb21lDQo+ICBjcHVfZGVzdHJveV9hZGRyZXNz
X3NwYWNlcygpIGZ1bmN0aW9uIGZyb20gY3B1X2NvbW1vbl91bnJlYWxpemVmbigpKS4NCg0KDQpZ
ZXMsIG1heWJlLCB3ZSBjYW4gZGVzdHJveSBhbGwgYXQgb25jZSBmcm9tIGNvbW1vbiBsZWcgYXMg
d2VsbC4gSSdkIHByZWZlciB0aGlzDQp0byBiZSBkb25lIGZyb20gdGhlIGFyY2ggc3BlY2lmaWMg
ZnVuY3Rpb24gZm9yIEFSTSB0byBtYWludGFpbiB0aGUgY2xhcml0eSAmDQpzeW1tZXRyeSBvZiBp
bml0aWFsaXphdGlvbiBhbmQgdW4taW5pdGlhbGl6YXRpb24gbGVncy4gIEZvciBub3csIGFsbCBv
ZiB0aGVzZSBhZGRyZXNzDQpzcGFjZSBkZXN0cnVjdGlvbiBpcyBoYXBwZW5pbmcgaW4gY29udGV4
dCB0byB0aGUgYXJtX2NwdV91bnJlYWxpemVmbigpLg0KDQpJdOKAmXMgYSBraW5kIG9mIHRyYWRl
LW9mZiBiZXR3ZWVuIGxpdHRsZSBtb3JlIGNvZGUgYW5kIGNsYXJpdHkgYnV0IEknbSBvcGVuIHRv
DQpmdXJ0aGVyIHN1Z2dlc3Rpb25zLg0KDQoNCj4gIA0KPiAgQWxzbywgaWYgd2UncmUgbGVha2lu
ZyBzdHVmZiBoZXJlIGJ5IGZhaWxpbmcgdG8gZGVzdHJveSBpdCwgaXMgdGhhdCBhIHByb2JsZW0g
Zm9yDQo+ICBleGlzdGluZyBDUFUgdHlwZXMgbGlrZSB4ODYgdGhhdCB3ZSBjYW4gYWxyZWFkeSBo
b3RwbHVnPw0KDQpObyB3ZSBhcmUgbm90LiBXZSBhcmUgdGFraW5nIGNhcmUgb2YgdGhlc2UgaW4g
dGhlIEFSTSBhcmNoIHNwZWNpZmljIGxlZ3MNCndpdGhpbiBmdW5jdGlvbnMgYXJtX2NwdV8odW4p
cmVhbGl6ZWZuKCkuIA0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA5MjYxMDM2
NTQuMzQ0MjQtMS1zYWxpbC5tZWh0YUBodWF3ZWkuY29tLw0KDQpBYm92ZSBjaGFuZ2Ugbm93IHdv
dWxkIGJlIHBhcnQgb2YgQXJjaCBzcGVjaWZpYyBwYXRjaC1zZXQgUkZDIFYzIGJlaW5nIHByZXBh
cmVkLg0KDQoNClRoYW5rcw0KU2FsaWwuDQoNCg==

