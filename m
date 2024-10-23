Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B77D2E006
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 01:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Pkn-0007Ik-Ly; Tue, 22 Oct 2024 21:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3Pkj-0007IO-Sh; Tue, 22 Oct 2024 21:01:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3Pkh-0001aA-BO; Tue, 22 Oct 2024 21:01:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XY9fz6M15z6K6ND;
 Wed, 23 Oct 2024 08:59:23 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 6CADE1401F3;
 Wed, 23 Oct 2024 09:01:25 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 03:01:25 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 23 Oct 2024 03:01:24 +0200
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
Subject: RE: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Topic: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Index: AQHbHm6XRQnHA1hqSkuTlA12W4mCybKQXiWAgAMhhdA=
Date: Wed, 23 Oct 2024 01:01:24 +0000
Message-ID: <f3b24abb74604f07aa76bead91277d6d@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com>
 <700f6b4b-e609-42fe-afaf-e9ea62a049e1@linaro.org>
In-Reply-To: <700f6b4b-e609-42fe-afaf-e9ea62a049e1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.112]
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGkgR3VzdGF2bywNCg0KPiAgRnJvbTogR3VzdGF2byBSb21lcm8gPGd1c3Rhdm8ucm9tZXJvQGxp
bmFyby5vcmc+DQo+ICBTZW50OiBNb25kYXksIE9jdG9iZXIgMjEsIDIwMjQgMzoxMCBBTQ0KPiAg
VG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnOw0KPiAgcWVtdS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gIA0KPiAg
SGkgU2FsaWwsDQo+ICANCj4gIE9uIDEwLzE0LzI0IDE2OjIyLCBTYWxpbCBNZWh0YSB3cm90ZToN
Cj4gID4gUmVmbGVjdCB0aGUgQUNQSSBDUFUgaG90cGx1ZyBgaXNfe3ByZXNlbnQsIGVuYWJsZWR9
YCBzdGF0ZXMgaW4gdGhlDQo+ICA+IGBfU1RBLlBSRVNgDQo+ICA+IChwcmVzZW5jZSkgYW5kIGBf
U1RBLkVOQWAgKGVuYWJsZWQpIGJpdHMgd2hlbiB0aGUgZ3Vlc3Qga2VybmVsDQo+ICA+IGV2YWx1
YXRlcyB0aGUgQUNQSSBgX1NUQWAgbWV0aG9kIGR1cmluZyBpbml0aWFsaXphdGlvbiwgYXMgd2Vs
bCBhcw0KPiAgPiB3aGVuIHZDUFVzIGFyZSBob3QtcGx1Z2dlZCBvciBob3QtdW5wbHVnZ2VkLiBU
aGUgcHJlc2VuY2Ugb2YNCj4gIHVucGx1Z2dlZA0KPiAgPiB2Q1BVcyBtYXkgbmVlZCB0byBiZSBk
ZWxpYmVyYXRlbHkNCj4gID4gKnNpbXVsYXRlZCogYXQgdGhlIEFDUEkgbGV2ZWwgdG8gbWFpbnRh
aW4gYSAqcGVyc2lzdGVudCogdmlldyBvZiB2Q1BVcw0KPiAgPiBmb3IgdGhlIGd1ZXN0IGtlcm5l
bC4NCj4gID4NCj4gID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1
YXdlaS5jb20+DQo+ICA+IC0tLQ0KPiAgPiAgIGh3L2FjcGkvY3B1LmMgfCAyNiArKysrKysrKysr
KysrKysrKysrKysrLS0tLQ0KPiAgPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0IGEvaHcvYWNwaS9jcHUuYyBi
L2h3L2FjcGkvY3B1LmMgaW5kZXgNCj4gID4gNzAwYWE4NTVlOS4uMjNlYTJiOWM3MCAxMDA2NDQN
Cj4gID4gLS0tIGEvaHcvYWNwaS9jcHUuYw0KPiAgPiArKysgYi9ody9hY3BpL2NwdS5jDQo+ICA+
IEBAIC02MywxMCArNjMsMTEgQEAgc3RhdGljIHVpbnQ2NF90IGNwdV9ob3RwbHVnX3JkKHZvaWQg
Km9wYXF1ZSwNCj4gIGh3YWRkciBhZGRyLCB1bnNpZ25lZCBzaXplKQ0KPiAgPiAgICAgICBjZGV2
ID0gJmNwdV9zdC0+ZGV2c1tjcHVfc3QtPnNlbGVjdG9yXTsNCj4gID4gICAgICAgc3dpdGNoIChh
ZGRyKSB7DQo+ICA+ICAgICAgIGNhc2UgQUNQSV9DUFVfRkxBR1NfT0ZGU0VUX1JXOiAvKiBwYWNr
IGFuZCByZXR1cm4gaXNfKiBmaWVsZHMgKi8NCj4gID4gLSAgICAgICAgdmFsIHw9IGNkZXYtPmNw
dSA/IDEgOiAwOw0KPiAgPiArICAgICAgICB2YWwgfD0gY2Rldi0+aXNfZW5hYmxlZCA/IDEgOiAw
Ow0KPiAgPiAgICAgICAgICAgdmFsIHw9IGNkZXYtPmlzX2luc2VydGluZyA/IDIgOiAwOw0KPiAg
PiAgICAgICAgICAgdmFsIHw9IGNkZXYtPmlzX3JlbW92aW5nICA/IDQgOiAwOw0KPiAgPiAgICAg
ICAgICAgdmFsIHw9IGNkZXYtPmZ3X3JlbW92ZSAgPyAxNiA6IDA7DQo+ICA+ICsgICAgICAgIHZh
bCB8PSBjZGV2LT5pc19wcmVzZW50ID8gMzIgOiAwOw0KPiAgPiAgICAgICAgICAgdHJhY2VfY3B1
aHBfYWNwaV9yZWFkX2ZsYWdzKGNwdV9zdC0+c2VsZWN0b3IsIHZhbCk7DQo+ICA+ICAgICAgICAg
ICBicmVhazsNCj4gID4gICAgICAgY2FzZSBBQ1BJX0NQVV9DTURfREFUQV9PRkZTRVRfUlc6DQo+
ICA+IEBAIC0zNzYsNiArMzc3LDcgQEAgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVf
Y3B1X2hvdHBsdWcgPQ0KPiAgew0KPiAgPiAgICNkZWZpbmUgQ1BVX1JFTU9WRV9FVkVOVCAgIkNS
TVYiDQo+ICA+ICAgI2RlZmluZSBDUFVfRUpFQ1RfRVZFTlQgICAiQ0VKMCINCj4gID4gICAjZGVm
aW5lIENQVV9GV19FSkVDVF9FVkVOVCAiQ0VKRiINCj4gID4gKyNkZWZpbmUgQ1BVX1BSRVNFTlQg
ICAgICAgIkNQUlMiDQo+ICA+DQo+ICA+ICAgdm9pZCBidWlsZF9jcHVzX2FtbChBbWwgKnRhYmxl
LCBNYWNoaW5lU3RhdGUgKm1hY2hpbmUsDQo+ICBDUFVIb3RwbHVnRmVhdHVyZXMgb3B0cywNCj4g
ID4gICAgICAgICAgICAgICAgICAgICAgIGJ1aWxkX21hZHRfY3B1X2ZuIGJ1aWxkX21hZHRfY3B1
LCBod2FkZHINCj4gID4gYmFzZV9hZGRyLCBAQCAtNDM2LDcgKzQzOCw5IEBAIHZvaWQgYnVpbGRf
Y3B1c19hbWwoQW1sICp0YWJsZSwNCj4gIE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgQ1BVSG90cGx1
Z0ZlYXR1cmVzIG9wdHMsDQo+ICA+ICAgICAgICAgICBhbWxfYXBwZW5kKGZpZWxkLCBhbWxfbmFt
ZWRfZmllbGQoQ1BVX0VKRUNUX0VWRU5ULCAxKSk7DQo+ICA+ICAgICAgICAgICAvKiB0ZWxsIGZp
cm13YXJlIHRvIGRvIGRldmljZSBlamVjdCwgd3JpdGUgb25seSAqLw0KPiAgPiAgICAgICAgICAg
YW1sX2FwcGVuZChmaWVsZCwgYW1sX25hbWVkX2ZpZWxkKENQVV9GV19FSkVDVF9FVkVOVCwgMSkp
Ow0KPiAgPiAtICAgICAgICBhbWxfYXBwZW5kKGZpZWxkLCBhbWxfcmVzZXJ2ZWRfZmllbGQoMykp
Ow0KPiAgPiArICAgICAgICAvKiAxIGlmIHByZXNlbnQsIHJlYWQgb25seSAqLw0KPiAgPiArICAg
ICAgICBhbWxfYXBwZW5kKGZpZWxkLCBhbWxfbmFtZWRfZmllbGQoQ1BVX1BSRVNFTlQsIDEpKTsN
Cj4gID4gKyAgICAgICAgYW1sX2FwcGVuZChmaWVsZCwgYW1sX3Jlc2VydmVkX2ZpZWxkKDIpKTsN
Cj4gID4gICAgICAgICAgIGFtbF9hcHBlbmQoZmllbGQsIGFtbF9uYW1lZF9maWVsZChDUFVfQ09N
TUFORCwgOCkpOw0KPiAgPiAgICAgICAgICAgYW1sX2FwcGVuZChjcHVfY3RybF9kZXYsIGZpZWxk
KTsNCj4gID4NCj4gID4gQEAgLTQ2Niw2ICs0NzAsNyBAQCB2b2lkIGJ1aWxkX2NwdXNfYW1sKEFt
bCAqdGFibGUsIE1hY2hpbmVTdGF0ZQ0KPiAgKm1hY2hpbmUsIENQVUhvdHBsdWdGZWF0dXJlcyBv
cHRzLA0KPiAgPiAgICAgICAgICAgQW1sICpjdHJsX2xvY2sgPSBhbWxfbmFtZSgiJXMuJXMiLCBj
cGhwX3Jlc19wYXRoLCBDUFVfTE9DSyk7DQo+ICA+ICAgICAgICAgICBBbWwgKmNwdV9zZWxlY3Rv
ciA9IGFtbF9uYW1lKCIlcy4lcyIsIGNwaHBfcmVzX3BhdGgsDQo+ICBDUFVfU0VMRUNUT1IpOw0K
PiAgPiAgICAgICAgICAgQW1sICppc19lbmFibGVkID0gYW1sX25hbWUoIiVzLiVzIiwgY3BocF9y
ZXNfcGF0aCwNCj4gID4gQ1BVX0VOQUJMRUQpOw0KPiAgPiArICAgICAgICBBbWwgKmlzX3ByZXNl
bnQgPSBhbWxfbmFtZSgiJXMuJXMiLCBjcGhwX3Jlc19wYXRoLA0KPiAgPiArIENQVV9QUkVTRU5U
KTsNCj4gID4gICAgICAgICAgIEFtbCAqY3B1X2NtZCA9IGFtbF9uYW1lKCIlcy4lcyIsIGNwaHBf
cmVzX3BhdGgsDQo+ICBDUFVfQ09NTUFORCk7DQo+ICA+ICAgICAgICAgICBBbWwgKmNwdV9kYXRh
ID0gYW1sX25hbWUoIiVzLiVzIiwgY3BocF9yZXNfcGF0aCwgQ1BVX0RBVEEpOw0KPiAgPiAgICAg
ICAgICAgQW1sICppbnNfZXZ0ID0gYW1sX25hbWUoIiVzLiVzIiwgY3BocF9yZXNfcGF0aCwNCj4g
ID4gQ1BVX0lOU0VSVF9FVkVOVCk7IEBAIC00OTQsMTMgKzQ5OSwyNiBAQCB2b2lkIGJ1aWxkX2Nw
dXNfYW1sKEFtbA0KPiAgKnRhYmxlLCBNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIENQVUhvdHBsdWdG
ZWF0dXJlcyBvcHRzLA0KPiAgPiAgICAgICAgICAgew0KPiAgPiAgICAgICAgICAgICAgIEFtbCAq
aWR4ID0gYW1sX2FyZygwKTsNCj4gID4gICAgICAgICAgICAgICBBbWwgKnN0YSA9IGFtbF9sb2Nh
bCgwKTsNCj4gID4gKyAgICAgICAgICAgIEFtbCAqaWZjdHgyOw0KPiAgPiArICAgICAgICAgICAg
QW1sICplbHNlX2N0eDsNCj4gID4NCj4gID4gICAgICAgICAgICAgICBhbWxfYXBwZW5kKG1ldGhv
ZCwgYW1sX2FjcXVpcmUoY3RybF9sb2NrLCAweEZGRkYpKTsNCj4gID4gICAgICAgICAgICAgICBh
bWxfYXBwZW5kKG1ldGhvZCwgYW1sX3N0b3JlKGlkeCwgY3B1X3NlbGVjdG9yKSk7DQo+ICA+ICAg
ICAgICAgICAgICAgYW1sX2FwcGVuZChtZXRob2QsIGFtbF9zdG9yZSh6ZXJvLCBzdGEpKTsNCj4g
ID4gLSAgICAgICAgICAgIGlmY3R4ID0gYW1sX2lmKGFtbF9lcXVhbChpc19lbmFibGVkLCBvbmUp
KTsNCj4gID4gKyAgICAgICAgICAgIGlmY3R4ID0gYW1sX2lmKGFtbF9lcXVhbChpc19wcmVzZW50
LCBvbmUpKTsNCj4gID4gICAgICAgICAgICAgICB7DQo+ICA+IC0gICAgICAgICAgICAgICAgYW1s
X2FwcGVuZChpZmN0eCwgYW1sX3N0b3JlKGFtbF9pbnQoMHhGKSwgc3RhKSk7DQo+ICA+ICsgICAg
ICAgICAgICAgICAgaWZjdHgyID0gYW1sX2lmKGFtbF9lcXVhbChpc19lbmFibGVkLCBvbmUpKTsN
Cj4gID4gKyAgICAgICAgICAgICAgICB7DQo+ICA+ICsgICAgICAgICAgICAgICAgICAgIC8qIGNw
dSBpcyBwcmVzZW50IGFuZCBlbmFibGVkICovDQo+ICA+ICsgICAgICAgICAgICAgICAgICAgIGFt
bF9hcHBlbmQoaWZjdHgyLCBhbWxfc3RvcmUoYW1sX2ludCgweEYpLCBzdGEpKTsNCj4gID4gKyAg
ICAgICAgICAgICAgICB9DQo+ICA+ICsgICAgICAgICAgICAgICAgYW1sX2FwcGVuZChpZmN0eCwg
aWZjdHgyKTsNCj4gID4gKyAgICAgICAgICAgICAgICBlbHNlX2N0eCA9IGFtbF9lbHNlKCk7DQo+
ICA+ICsgICAgICAgICAgICAgICAgew0KPiAgPiArICAgICAgICAgICAgICAgICAgICAvKiBjcHUg
aXMgcHJlc2VudCBidXQgZGlzYWJsZWQgKi8NCj4gID4gKyAgICAgICAgICAgICAgICAgICAgYW1s
X2FwcGVuZChlbHNlX2N0eCwgYW1sX3N0b3JlKGFtbF9pbnQoMHhEKSwNCj4gID4gKyBzdGEpKTsN
Cj4gIA0KPiAgSGVyZSwgdGhlIHJldHVybiB2YWx1ZSBmb3IgX1NUQSBtZXRob2QgaXMgc2V0IHRv
IHJlZmxlY3QgdGhlIHN0YXRlIG9mDQo+ICBDUFVfUFJFU0VOVCBhbmQgQ1BVX0VOQUJMRUQgZmll
bGRzLiBJIGNhbid0IHNlZSB0aGVzZSB0d28gZmllbGRzIGJlaW5nDQo+ICBtYXBwZWQgdG8gQWNw
aUNwdVN0YXR1cy57aXNfcHJlc2VudCxpc19lbmFibGVkfS4gVGhleSBsb29rIHRvIGJlIG1hcHBl
ZA0KPiAgdG8gdGhlIE1NSU8gcmVnaW9uIChiYXNlX2FkZHIpLCB3aGljaCBkb2Vzbid0IG1hcHBl
ZCB0byBBY3BpQ3B1U3RhdHVzDQo+ICBhZmFpY3MuIFNvIHdoZXJlIENQVV9QUkVTRU5UIGFuZCBD
UFVfRU5BQkxFRCBhcmUgc2V0IGFuZCB3aGVyZQ0KPiAgZXhhY3RseSB0aGV5IHJlc2lkZT8NCg0K
DQpZb3UgZG9u4oCZdCBzZXQgX1NUQSBmaWVsZCBmcm9tIGd1ZXN0IGZvciBDUFVzLiBXZSBvbmx5
IGZldGNoIHZhbHVlcyBiZWluZw0KcmVmbGVjdGVkIGJ5IHRoZSBWTU0uIEluIGdlbmVyYWwsIEFD
UEkgX1NUQSBtZXRob2QgaXMgZm9yIGZldGNoaW5nIHN0YXR1cw0Kb2YgYSBkZXZpY2UuIFBsZWFz
ZSBjaGVjayBiZWxvdzoNCg0KaHR0cHM6Ly91ZWZpLm9yZy9zcGVjcy9BQ1BJLzYuNS8wNl9EZXZp
Y2VfQ29uZmlndXJhdGlvbi5odG1sP2hpZ2hsaWdodD1fc3RhI3N0YS1kZXZpY2Utc3RhdHVzDQoN
Cg0KV2UgYXJlIGJhbmtpbmcgb24gYmVsb3cgc3RhdHVzIGJpdHM6DQoNCkJpdCBbMF0gLSBTZXQg
aWYgdGhlIGRldmljZSBpcyBwcmVzZW50Lg0KQml0IFsxXSAtIFNldCBpZiB0aGUgZGV2aWNlIGlz
IGVuYWJsZWQgYW5kIGRlY29kaW5nIGl0cyByZXNvdXJjZXMuDQoNCkhlbmNlLCBBY3BpQ3B1U3Rh
dHVzOjooaXNfcHJlc2VudCwgaXNfZW5hYmxlZH0gYXJlIHNldCBpbiB0aGUgVk1NDQphbmQgdGhl
aXIgc3RhdHVzIGlzIHNoYXJlZCB0byB0aGUgZ3Vlc3Qga2VybmVsIHdoZW4gdGhlIEFDUEkgX1NU
QQ0KbWV0aG9kIGlzIGV2YWx1YXRlZCBieSB0aGUgT1NQTS4NCg0KDQpQYXRjaCAzLzQ6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDEwMTQxOTIyMDUuMjUzNDc5LTQtc2Fs
aWwubWVodGFAaHVhd2VpLmNvbS8NCiNIVU5LDQoNCmRpZmYgLS1naXQgYS9ody9hY3BpL2NwdS5j
IGIvaHcvYWNwaS9jcHUuYw0KaW5kZXggNzAwYWE4NTVlOS4uMjNlYTJiOWM3MCAxMDA2NDQNCi0t
LSBhL2h3L2FjcGkvY3B1LmMNCisrKyBiL2h3L2FjcGkvY3B1LmMNCkBAIC02MywxMCArNjMsMTEg
QEAgc3RhdGljIHVpbnQ2NF90IGNwdV9ob3RwbHVnX3JkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFk
ZHIsIHVuc2lnbmVkIHNpemUpDQogICAgIGNkZXYgPSAmY3B1X3N0LT5kZXZzW2NwdV9zdC0+c2Vs
ZWN0b3JdOy0tLS0tLS0tLT4gY2hlY2sgdGhpcyBjb2RlIGV4Y2VycHQNCiAgICAgc3dpdGNoIChh
ZGRyKSB7DQogICAgIGNhc2UgQUNQSV9DUFVfRkxBR1NfT0ZGU0VUX1JXOiAvKiBwYWNrIGFuZCBy
ZXR1cm4gaXNfKiBmaWVsZHMgKi8NCi0gICAgICAgIHZhbCB8PSBjZGV2LT5jcHUgPyAxIDogMDsN
CisgICAgICAgIHZhbCB8PSBjZGV2LT5pc19lbmFibGVkID8gMSA6IDA7LS0tLS0tLS0tLS0tLS0t
PiB0aGlzIGNoYW5nZQ0KICAgICAgICAgdmFsIHw9IGNkZXYtPmlzX2luc2VydGluZyA/IDIgOiAw
Ow0KICAgICAgICAgdmFsIHw9IGNkZXYtPmlzX3JlbW92aW5nICA/IDQgOiAwOw0KICAgICAgICAg
dmFsIHw9IGNkZXYtPmZ3X3JlbW92ZSAgPyAxNiA6IDA7DQorICAgICAgICB2YWwgfD0gY2Rldi0+
aXNfcHJlc2VudCA/IDMyIDogMDstLS0tLS0tLS0tLS0tPiBhbmQgdGhpcyBjaGFuZ2UNCiAgICAg
ICAgIHRyYWNlX2NwdWhwX2FjcGlfcmVhZF9mbGFncyhjcHVfc3QtPnNlbGVjdG9yLCB2YWwpOw0K
ICAgICAgICAgYnJlYWs7DQogICAgIGNhc2UgQUNQSV9DUFVfQ01EX0RBVEFfT0ZGU0VUX1JXOg0K
DQoNClRoYW5rcw0KDQo+ICANCj4gIA0KPiAgQ2hlZXJzLA0KPiAgR3VzdGF2bw0KPiAgDQo+ICA+
ICsgICAgICAgICAgICAgICAgfQ0KPiAgPiArICAgICAgICAgICAgICAgIGFtbF9hcHBlbmQoaWZj
dHgsIGVsc2VfY3R4KTsNCj4gID4gICAgICAgICAgICAgICB9DQo+ICA+ICAgICAgICAgICAgICAg
YW1sX2FwcGVuZChtZXRob2QsIGlmY3R4KTsNCj4gID4gICAgICAgICAgICAgICBhbWxfYXBwZW5k
KG1ldGhvZCwgYW1sX3JlbGVhc2UoY3RybF9sb2NrKSk7DQoNCg==

