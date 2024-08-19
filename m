Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A047C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1Dq-0007Uw-Bd; Mon, 19 Aug 2024 08:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1DZ-0007J0-NH; Mon, 19 Aug 2024 08:10:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1DV-000614-Bw; Mon, 19 Aug 2024 08:10:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnWYn0gSKz6L7CP;
 Mon, 19 Aug 2024 20:07:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (unknown [7.191.162.67])
 by mail.maildlp.com (Postfix) with ESMTPS id 07178140680;
 Mon, 19 Aug 2024 20:10:28 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 13:10:27 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 19 Aug 2024 13:10:27 +0100
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
Subject: RE: [PATCH RFC V3 11/29] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
Thread-Topic: [PATCH RFC V3 11/29] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
Thread-Index: AQHavetL6ZWS3kCPn0Wbiq50SP2k0LIkrOeAgAo4YQA=
Date: Mon, 19 Aug 2024 12:10:27 +0000
Message-ID: <b6bdee28101741169048819c0d562bfc@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-12-salil.mehta@huawei.com>
 <143ad7d2-8f45-4428-bed3-891203a49029@redhat.com>
In-Reply-To: <143ad7d2-8f45-4428-bed3-891203a49029@redhat.com>
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

PiAgRnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gIFNlbnQ6IFR1ZXNkYXks
IEF1Z3VzdCAxMywgMjAyNCAyOjA1IEFNDQo+ICBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRh
QGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ICBxZW11LWFybUBub25nbnUu
b3JnOyBtc3RAcmVkaGF0LmNvbQ0KPiAgDQo+ICBPbiA2LzE0LzI0IDk6MzYgQU0sIFNhbGlsIE1l
aHRhIHdyb3RlOg0KPiAgPiBBQ1BJIENQVSBob3RwbHVnIHN0YXRlIChpc19wcmVzZW50PV9TVEEu
UFJFU0VOVCwNCj4gID4gaXNfZW5hYmxlZD1fU1RBLkVOQUJMRUQpIGZvciBhbGwgdGhlIHBvc3Np
YmxlIHZDUFVzIE1VU1QgYmUNCj4gID4gaW5pdGlhbGl6ZWQgZHVyaW5nIG1hY2hpbmUgaW5pdC4g
VGhpcyBpcyBkb25lIGR1cmluZyB0aGUgY3JlYXRpb24gb2YNCj4gID4gdGhlIEdFRCBkZXZpY2Uu
IFZNTS9RZW11IE1VU1QgZXhwb3NlL2Zha2UgdGhlIEFDUEkgc3RhdGUgb2YgdGhlDQo+ICA+IGRp
c2FibGVkIHZDUFVzIHRvIHRoZSBHdWVzdCBrZXJuZWwgYXMgJ3ByZXNlbnQnIChfU1RBLlBSRVNF
TlQpIGFsd2F5cw0KPiAgPiBpLmUuIEFDUEkgcGVyc2lzdGVudC4gaWYgdGhlICdkaXNhYmxlZCcg
dkNQVSBvYmplY3RlcyBhcmUgZGVzdHJveWVkDQo+ICA+IGJlZm9yZSB0aGUgR0VEIGRldmljZSBo
YXMgYmVlbiBjcmVhdGVkIHRoZW4gdGhlaXIgQUNQSSBob3RwbHVnIHN0YXRlDQo+ICA+IG1pZ2h0
IG5vdCBnZXQgaW5pdGlhbGl6ZWQgY29ycmVjdGx5IGFzIGFjcGlfcGVyc2lzdGVudCBmbGFnIGlz
IHBhcnQgb2YgdGhlDQo+ICBDUFVTdGF0ZS4gVGhpcyB3aWxsIGV4cG9zZSB3cm9uZyBzdGF0dXMg
b2YgdGhlIHVucGx1Z2dlZCB2Q1BVcyB0byB0aGUNCj4gIEd1ZXN0IGtlcm5lbC4NCj4gID4NCj4g
ID4gSGVuY2UsIG1vdmluZyB0aGUgR0VEIGRldmljZSBjcmVhdGlvbiBiZWZvcmUgZGlzYWJsZWQg
dkNQVSBvYmplY3RzIGdldA0KPiAgPiBkZXN0cm95ZWQgYXMgcGFydCBvZiB0aGUgcG9zdCBDUFUg
aW5pdCByb3V0aW5lLg0KPiAgPg0KPiAgPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2Fs
aWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4gLS0tDQo+ICA+ICAgaHcvYXJtL3ZpcnQuYyB8IDEw
ICsrKysrKystLS0NCj4gID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3ZpcnQuYyBiL2h3L2Fy
bS92aXJ0LmMgaW5kZXgNCj4gID4gOTE4YmNiOWExYi4uNWY5ODE2MjU4NyAxMDA2NDQNCj4gID4g
LS0tIGEvaHcvYXJtL3ZpcnQuYw0KPiAgPiArKysgYi9ody9hcm0vdmlydC5jDQo+ICA+IEBAIC0y
NDY3LDYgKzI0NjcsMTIgQEAgc3RhdGljIHZvaWQgbWFjaHZpcnRfaW5pdChNYWNoaW5lU3RhdGUN
Cj4gID4gKm1hY2hpbmUpDQo+ICA+DQo+ICA+ICAgICAgIGNyZWF0ZV9naWModm1zLCBzeXNtZW0p
Ow0KPiAgPg0KPiAgPiArICAgIGhhc19nZWQgPSBoYXNfZ2VkICYmIGFhcmNoNjQgJiYgZmlybXdh
cmVfbG9hZGVkICYmDQo+ICA+ICsgICAgICAgICAgICAgIHZpcnRfaXNfYWNwaV9lbmFibGVkKHZt
cyk7DQo+ICA+ICsgICAgaWYgKGhhc19nZWQpIHsNCj4gID4gKyAgICAgICAgdm1zLT5hY3BpX2Rl
diA9IGNyZWF0ZV9hY3BpX2dlZCh2bXMpOw0KPiAgPiArICAgIH0NCj4gID4gKw0KPiAgPiAgICAg
ICB2aXJ0X2NwdV9wb3N0X2luaXQodm1zLCBzeXNtZW0pOw0KPiAgPg0KPiAgPiAgICAgICBmZHRf
YWRkX3BtdV9ub2Rlcyh2bXMpOw0KPiAgPiBAQCAtMjQ4OSw5ICsyNDk1LDcgQEAgc3RhdGljIHZv
aWQgbWFjaHZpcnRfaW5pdChNYWNoaW5lU3RhdGUNCj4gICptYWNoaW5lKQ0KPiAgPg0KPiAgPiAg
ICAgICBjcmVhdGVfcGNpZSh2bXMpOw0KPiAgPg0KPiAgPiAtICAgIGlmIChoYXNfZ2VkICYmIGFh
cmNoNjQgJiYgZmlybXdhcmVfbG9hZGVkICYmDQo+ICB2aXJ0X2lzX2FjcGlfZW5hYmxlZCh2bXMp
KSB7DQo+ICA+IC0gICAgICAgIHZtcy0+YWNwaV9kZXYgPSBjcmVhdGVfYWNwaV9nZWQodm1zKTsN
Cj4gID4gLSAgICB9IGVsc2Ugew0KPiAgPiArICAgIGlmICghaGFzX2dlZCkgew0KPiAgPiAgICAg
ICAgICAgY3JlYXRlX2dwaW9fZGV2aWNlcyh2bXMsIFZJUlRfR1BJTywgc3lzbWVtKTsNCj4gID4g
ICAgICAgfQ0KPiAgPg0KPiAgDQo+ICBJdCdzIGxpa2VseSB0aGUgR1BJTyBkZXZpY2UgY2FuIGJl
IGNyZWF0ZWQgYmVmb3JlIHRob3NlIGRpc2FibGVkIENQVSBvYmplY3RzDQo+ICBhcmUgZGVzdHJv
eWVkLiBJdCBtZWFucyB0aGUgd2hvbGUgY2h1bmsgb2YgY29kZSBjYW4gYmUgbW92ZWQgdG9nZXRo
ZXIsIEkNCj4gIHRoaW5rLg0KDQpJIHdhcyBub3QgdG90YWxseSBzdXJlIG9mIHRoaXMuIEhlbmNl
LCBrZXB0IHRoZSBvcmRlciBvZiB0aGUgcmVzdCBsaWtlIHRoYXQuIEkgY2FuDQpkZWZpbml0ZWx5
IGNoZWNrIGFnYWluIGlmIHdlIGNhbiBkbyB0aGF0IHRvIHJlZHVjZSB0aGUgY2hhbmdlLg0KDQpU
aGFua3MNClNhbGlsLg0KDQoNCg0KPiAgDQo+ICBUaGFua3MsDQo+ICBHYXZpbg0KPiAgDQoNCg==

