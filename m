Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764A4D2E008
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 01:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3QWe-0006wB-QY; Tue, 22 Oct 2024 21:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3QWa-0006vX-KW; Tue, 22 Oct 2024 21:51:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3QWX-0005rT-BR; Tue, 22 Oct 2024 21:51:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XYBlz59NSz6K6Dq;
 Wed, 23 Oct 2024 09:48:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5ED451400F4;
 Wed, 23 Oct 2024 09:50:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 03:50:49 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 23 Oct 2024 03:50:48 +0200
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
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
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Subject: RE: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
Thread-Topic: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU
 Hotplug (on Archs like ARM)
Thread-Index: AQHbHm50WDNFu/JS0kS8LAX2f7HLB7KMeqOAgAcbKiA=
Date: Wed, 23 Oct 2024 01:50:48 +0000
Message-ID: <7e43ef6626654c99a0ab2d07a90c0609@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241018164629.2939b711@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241018164629.2939b711@imammedo.users.ipa.redhat.com>
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

SGkgSWdvciwNCg0KVGhhbmtzIGZvciB0YWtpbmcgdGltZSB0byByZXZpZXcgdGhlIHNlcmllcy4g
UGxlYXNlIGZpbmQgbXkgcmVwbGllcyBpbmxpbmUuDQoNCj4gIEZyb206IHFlbXUtZGV2ZWwtYm91
bmNlcytzYWxpbC5tZWh0YT1odWF3ZWkuY29tQG5vbmdudS5vcmcgPHFlbXUtDQo+ICBkZXZlbC1i
b3VuY2VzK3NhbGlsLm1laHRhPWh1YXdlaS5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mIEln
b3INCj4gIE1hbW1lZG92DQo+ICBTZW50OiBGcmlkYXksIE9jdG9iZXIgMTgsIDIwMjQgMzo0NiBQ
TQ0KPiAgVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgDQo+ICBP
biBNb24sIDE0IE9jdCAyMDI0IDIwOjIyOjAxICswMTAwDQo+ICBTYWxpbCBNZWh0YSA8c2FsaWwu
bWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ICANCj4gID4gQ2VydGFpbiBDUFUgYXJjaGl0ZWN0
dXJlIHNwZWNpZmljYXRpb25zIFsxXVsyXVszXSBwcm9oaWJpdCBjaGFuZ2VzIHRvDQo+ICA+IHRo
ZSBDUFVzDQo+ICA+ICpwcmVzZW5jZSogYWZ0ZXIgdGhlIGtlcm5lbCBoYXMgYm9vdGVkLiBUaGlz
IGlzIGJlY2F1c2UgbWFueSBzeXN0ZW0NCj4gID4gaW5pdGlhbGl6YXRpb25zIGRlcGVuZCBvbiB0
aGUgZXhhY3QgQ1BVIGNvdW50IGF0IGJvb3QgdGltZSBhbmQgZG8gbm90DQo+ICA+IGV4cGVjdCBp
dCB0byBjaGFuZ2UgYWZ0ZXJ3YXJkLiBGb3IgZXhhbXBsZSwgY29tcG9uZW50cyBsaWtlIGludGVy
cnVwdA0KPiAgPiBjb250cm9sbGVycyB0aGF0IGFyZSBjbG9zZWx5IGNvdXBsZWQgd2l0aCBDUFVz
LCBvciB2YXJpb3VzIHBlci1DUFUNCj4gID4gZmVhdHVyZXMsIG1heSBub3Qgc3VwcG9ydCBjb25m
aWd1cmF0aW9uIGNoYW5nZXMgb25jZSB0aGUga2VybmVsIGhhcw0KPiAgYmVlbiBpbml0aWFsaXpl
ZC4NCj4gID4NCj4gID4gVGhpcyByZXF1aXJlbWVudCBwb3NlcyBhIGNoYWxsZW5nZSBmb3Igdmly
dHVhbGl6YXRpb24gZmVhdHVyZXMgbGlrZQ0KPiAgPiB2Q1BVIGhvdHBsdWcuIFRvIGFkZHJlc3Mg
dGhpcywgY2hhbmdlcyB0byB0aGUgQUNQSSBBTUwgYXJlIG5lY2Vzc2FyeQ0KPiAgPiB0byB1cGRh
dGUgdGhlIGBfU1RBLlBSRVNgIChwcmVzZW5jZSkgYW5kIGBfU1RBLkVOQWAgKGVuYWJsZWQpIGJp
dHMNCj4gID4gYWNjb3JkaW5nbHkgZHVyaW5nIGd1ZXN0IGluaXRpYWxpemF0aW9uLCBhcyB3ZWxs
IGFzIHdoZW4gdkNQVXMgYXJlDQo+ICA+IGhvdC1wbHVnZ2VkIG9yIGhvdC11bnBsdWdnZWQuIFRo
ZSBwcmVzZW5jZSBvZiB1bnBsdWdnZWQgdkNQVXMgbWF5DQo+ICBuZWVkDQo+ICA+IHRvIGJlIGRl
bGliZXJhdGVseSAqc2ltdWxhdGVkKiBhdCB0aGUgQUNQSSBsZXZlbCB0byBtYWludGFpbiBhICpw
ZXJzaXN0ZW50Kg0KPiAgdmlldyBvZiB2Q1BVcyBmb3IgdGhlIGd1ZXN0IGtlcm5lbC4NCj4gIA0K
PiAgdGhlIHNlcmllcyBpcyBwZXBwZXJlZCB3aXRoICpzaW11bGF0ZWQqIGlkZWEsIHdoaWNoIGFm
dGVyIGxvb2tpbmcgYXQgY29kZSBJDQo+ICByZWFkIGFzICdmYWtlJy4NCg0KDQpHb3QgaXQhIElm
ICJzaW11bGF0ZSIgZG9lc24ndCBjb252ZXkgdGhlIG1lYW5pbmcgd2VsbCwgd2UgY2FuIGRlZmlu
aXRlbHkgc3dpdGNoDQpiYWNrIHRvICJmYWtlLiIgb3Igc29tZXRoaW5nIGVsc2UuIE5vIGlzc3Vl
cyBhdCBhbGwuDQoNCg0KPiBXaGlsZSBpdCdzIG9idmlvdXMgdG8gYXV0aG9yIHdoeSB0aGluZ3Mg
bmVlZCB0byBiZSBmYWtlZCBhdA0KPiAgdGhpcyB0aW1lLCBpdCB3aWxsIGJlIGZvcmdvdHRlbiBs
YXRlciBvbi4gQW5kIGNhdXNlIGEgbG90IHN3ZWFyaW5nIGZyb20NCj4gIHdob2V2ZXIgd2lsbCBo
YXZlIHRvIGRlYWwgd2l0aCB0aGlzIGNvZGUgZG93biB0aGUgcm9hZC4NCg0KDQpMZXQncyBpbXBy
b3ZlIHRoZSBkZXNpZ24gdGhlbi4gSG93ZXZlciwgdGhlIGJvb3QgdGltZSBjYW5ub3QgYmUgbmVn
b3RpYXRlZC4NCldlIGNhbm5vdCBoYXZlIDUwMCB2Q1BVcyBzcGF3bmVkIGF0IGJvb3QgdGltZSB3
aGVuIHdlIG9ubHkgbmVlZCAxMCB2Q1BVcw0KdG8gcnVuLiBUaGF04oCZcyBhIG5vbi1zdGFydGVy
IQ0KDQoocGxlYXNlIGhhdmUgYSBsb29rIGF0IEtWTUZvcnVtIDIwMjMgc2xpZGVzIGZvciB0aGUg
bWVhc3VyZW1lbnRzIHdlIGRpZCBmb3INCiAxMjggdkNQVXMgKQ0KDQpUaGlzIGFsc28gY3JlYXRl
cyBvdmVyaGVhZCBkdXJpbmcgbWlncmF0aW9uIGFuZCB3aWxsIHByb2xvbmcgdGhlIG1pZ3JhdGlv
biB0aW1lLg0KVGhlIGFsdGVybmF0aXZlIHlvdSBzdWdnZXN0ZWQgd2FzIHRoZSBmaXJzdCBhcHBy
b2FjaCB3ZSBleHBlcmltZW50ZWQgd2F5IGJhY2sNCmluIHRoZSB5ZWFyIDIwMjAuIFdlIHRoZW4g
Z3JhZHVhbGx5IG1vdmVkIHRvIHJlbW92aW5nIHRoZSB0aHJlYWRzIGJ1dCBrZWVwaW5nDQp0aGUg
UU9NIHZDUFUgb2JqZWN0cywgYW5kIGxhdGVyIGV2ZW4gZGlzY2FyZGVkIHRoZSB2Q1BVIG9iamVj
dHMgY29ycmVzcG9uZGluZw0KdG8gdGhlIGBkaXNhYmxlZGAgcG9zc2libGUgdkNQVXMuIFRoaXMg
Y2hhbmdlIHdhcyBtYWRlIHByZWNpc2VseSBhdCB5b3VyIHJlcXVlc3QNCmxhc3QgeWVhciBpbiBK
dW5lLg0KDQoNCj4gIA0KPiAgU2FsaWwsIEknbSBzb3JyeSB0aGF0IHJldmlldyBjb21lcyBvdXQg
YXMgbW9zdGx5IG5lZ2F0aXZlIGJ1dCBmb3IgbWUgaGF2aW5nDQo+ICB0byByZXBlYXQgJ3NpbXVs
YXRlZCcgc29tZSBtYW55IHRpbWVzLCBoaW50cyB0aGF0IHRoZSB0aGVyZSBpcyBzb21ldGhpbmcN
Cj4gIHdyb25nIHdpdGggZGVzaWduIGFuZCB0aGF0IHdlIHNob3VsZCByZS1ldmFsdWF0ZSB0aGUg
YXBwcm9hY2guDQoNCg0KQSBsb3Qgb2YgZWZmb3J0IGFuZCB0aW1lIGhhcyBnb25lIGludG8gdGhp
cyBwcm9qZWN0LCBpbnZvbHZpbmcgbWFueSBjb21wYW5pZXMuDQoNClRoZXJlZm9yZSwgbGV04oCZ
cyBwcm9jZWVkLCBidXQgaXTigJlzIG5vdCBmYWlyIHRvIHRoZSBtYW55IHN0YWtlaG9sZGVycyB3
aG8gaGF2ZQ0Kc3BlbnQgc28gbXVjaCBvZiB0aGVpciB0aW1lIG92ZXIgdGhlIHBhc3QgZm91ciB5
ZWFycyB0byBzaW1wbHkgaGVhciB0aGF0DQrigJx0aGVyZSBpcyBzb21ldGhpbmcgd3Jvbmcgd2l0
aCB0aGUgZGVzaWduLuKAnSBJdCB3b3VsZCBiZSB2ZXJ5IGhlbHBmdWwgaWYgeW91DQpjb3VsZCBw
cm92aWRlIG1vcmUgZGV0YWlscyBhYm91dCB5b3VyIGNvbmNlcm5zIHNvIHRoYXQgd2UgY2FuIHdv
cmsgb24NCmltcHJvdmluZyB0aGUgYGV4aXN0aW5nYCBkZXNpZ24gYW5kIGhlbHAgeW91IHVuZGVy
c3RhbmQgb3VyIHBlcnNwZWN0aXZlLg0KRGlzY3Vzc2lvbiBhcm91bmQgc3BlY2lmaWNzIGFyZSBy
ZXF1aXJlZCwgcGxlYXNlIQ0KDQoNCj4gIA0KPiAgcHM6DQo+ICBzZWUgY29tbWVudHMgb24gMS80
IGZvciBzdWdnZXN0aW9ucw0KDQoNClRoYW5rcyBmb3IgdGhhdC4gSSd2ZSBhbHJlYWR5IHJlcGxp
ZWQgd2l0aCBteSBwZXJzcGVjdGl2ZSBpbiBjb250ZXh0IHRvIHRoYXQuDQpQbGVhc2UgaGF2ZSBh
IGxvb2suDQoNCk1hbnkgdGhhbmtzIQ0KDQpCZXN0IHJlZ2FyZHMNClNhbGlsLg0K

