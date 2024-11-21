Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DCCD6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE4BR-0002Rl-Ed; Thu, 21 Nov 2024 05:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tE4BP-0002RT-4e; Thu, 21 Nov 2024 05:13:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tE4BM-0008Mn-Jn; Thu, 21 Nov 2024 05:13:06 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvDYx05Nsz6L6yV;
 Thu, 21 Nov 2024 18:12:37 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id D180E140157;
 Thu, 21 Nov 2024 18:13:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 11:13:00 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 21 Nov 2024 11:13:00 +0100
To: Nathan Chen <nathanc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rK0OI0AgAyjUACAALVrYA==
Date: Thu, 21 Nov 2024 10:12:59 +0000
Message-ID: <04024d09ebad4d83ab0679f6bb3b3774@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
In-Reply-To: <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgTmF0aGFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5hdGhh
biBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIg
MjAsIDIwMjQgMTE6NTkgUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1l
ZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5v
cmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5j
b207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpDQo+IDx3YW5n
emhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29t
PjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4g
emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMC81XSBody9hcm0vdmlydDogQWRkIHN1cHBv
cnQgZm9yIHVzZXItY3JlYXRhYmxlDQo+IG5lc3RlZCBTTU1VdjMNCj4gDQo+IEhpIFNoYW1lZXIs
DQo+IA0KPiAgPiAgQXR0ZW1wdCB0byBhZGQgdGhlIEhOUyBWRiB0byBhIGRpZmZlcmVudCBTTU1V
djMgd2lsbCByZXN1bHQgaW4sDQo+ICA+DQo+ICA+IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAw
OjdkOjAyLjIsYnVzPXBjaWUucG9ydDMsaW9tbXVmZD1pb21tdWZkMDoNCj4gVW5hYmxlIHRvIGF0
dGFjaCB2aW9tbXUNCj4gID4gLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwMDA6N2Q6MDIuMixidXM9
cGNpZS5wb3J0Myxpb21tdWZkPWlvbW11ZmQwOg0KPiB2ZmlvIDAwMDA6N2Q6MDIuMjoNCj4gID4g
ICAgRmFpbGVkIHRvIHNldCBpb21tdV9kZXZpY2U6IFtpb21tdWZkPTI5XSBlcnJvciBhdHRhY2gg
MDAwMDo3ZDowMi4yDQo+ICgzOCkgdG8gaWQ9MTE6IEludmFsaWQgYXJndW1lbnQNCj4gID4NCj4g
ID4gQXQgcHJlc2VudCBRZW11IGlzIG5vdCBkb2luZyBhbnkgZXh0cmEgdmFsaWRhdGlvbiBvdGhl
ciB0aGFuIHRoZSBhYm92ZQ0KPiAgPiBmYWlsdXJlIHRvIG1ha2Ugc3VyZSB0aGUgdXNlciBjb25m
aWd1cmF0aW9uIGlzIGNvcnJlY3Qgb3Igbm90LiBUaGUNCj4gID4gYXNzdW1wdGlvbiBpcyBsaWJ2
aXJ0IHdpbGwgdGFrZSBjYXJlIG9mIHRoaXMuDQo+IFdvdWxkIHlvdSBiZSBhYmxlIHRvIGVsYWJv
cmF0ZSB3aGF0IFFlbXUgaXMgdmFsaWRhdGluZyB3aXRoIHRoaXMgZXJyb3INCj4gbWVzc2FnZT8g
SSdtIG5vdCBzZWVpbmcgdGhlc2UgZXJyb3JzIHdoZW4gYXNzaWduaW5nIGEgR1BVJ3MNCj4gcGNp
ZS1yb290LXBvcnQgdG8gZGlmZmVyZW50IFBYQnMgKHdpdGggZGlmZmVyZW50IGFzc29jaWF0ZWQg
U01NVSBub2RlcykuDQoNCllvdSBzaG91bGQgc2VlIHRoYXQgZXJyb3Igd2hlbiB5b3UgaGF2ZSB0
d28gZGV2aWNlcyB0aGF0IGJlbG9uZ3MgdG8gdHdvDQpkaWZmZXJlbnQgcGh5c2ljYWwgU01NVXYz
cyBpbiB0aGUgaG9zdCBrZXJuZWwsIGlzIGFzc2lnbmVkIHRvIGEgc2luZ2xlDQpQWEIvU01NVXYz
IGZvciBHdWVzdC4NCg0KU29tZXRoaW5nIGxpa2UsDQoNCi1kZXZpY2UgcHhiLXBjaWUsaWQ9cGNp
ZS4xLGJ1c19ucj04LGJ1cz1wY2llLjAgXA0KLWRldmljZSBhcm0tc21tdXYzLW5lc3RlZCxpZD1z
bW11djEscGNpLWJ1cz1wY2llLjEgXA0KLWRldmljZSBwY2llLXJvb3QtcG9ydCxpZD1wY2llLnBv
cnQxLGJ1cz1wY2llLjEsY2hhc3Npcz0xIFwNCi1kZXZpY2UgcGNpZS1yb290LXBvcnQsaWQ9cGNp
ZS5wb3J0MixidXM9cGNpZS4xLGNoYXNzaXM9MSBcDQotZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAw
MDo3ZDowMi4xLGJ1cz1wY2llLnBvcnQxLGlvbW11ZmQ9aW9tbXVmZDAgXCAgLS0+IFRoaXMgZGV2
aWNlIGJlbG9uZ3MgdG8gcGh5cyBTTU1VdjNfMA0KLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwMDA6
NzU6MDIuMSxidXM9cGNpZS5wb3J0Mixpb21tdWZkPWlvbW11ZmQwIFwgIC0tPiBUaGlzIGRldmlj
ZSBiZWxvbmdzIHRvIHBoeXMgU01NVXYzXzENCg0KU28gdGhlIGFzc3VtcHRpb24gYWJvdmUgaXMg
dGhhdCBsaWJ2aXJ0IHdpbGwgYmUgYWJsZSB0byBkZXRlY3Qgd2hpY2ggZGV2aWNlcyBiZWxvbmdz
DQp0byB0aGUgc2FtZSBwaHlzaWNhbCBTTU1VdjMgYW5kIGRvIHRoZSBhc3NpZ25tZW50IGZvciBH
dWVzdHMgY29ycmVjdGx5Lg0KDQo+IEkgbGF1bmNoZWQgYSBWTSB1c2luZyBteSBsaWJ2aXJ0IHBy
b3RvdHlwZSBjb2RlICsgeW91ciBxZW11IGJyYW5jaCBhbmQNCj4gbm90ZWQgYSBmZXcgc21hbGwg
dGhpbmdzOg0KDQpUaGFua3MgZm9yIGdpdmluZyB0aGlzIGEgc3BpbiB3aXRoIGxpYnZpcnQuDQoN
Cj4gMS4gQXJlIHRoZXJlIHBsYW5zIHRvIHN1cHBvcnQgIi1kZXZpY2UgYWRkciIgZm9yIGFybS1z
bW11djMtbmVzdGVkJ3MNCj4gUENJZSBzbG90IGFuZCBmdW5jdGlvbiBsaWtlIGFueSBvdGhlciBk
ZXZpY2U/IElmIG5vdCBJJ2xsIGV4Y2x1ZGUgaXQNCj4gZnJvbSBteSBsaWJ2aXJ0IHByb3RvdHlw
ZS4NCg0KTm90IGF0IHRoZSBtb21lbnQuIGFybS1zbW11djMtbmVzdGVkIGF0IHRoZSBtb21lbnQg
aXMgbm90IG1ha2luZyBhbnkgdXNlDQpvZiBQQ0kgc2xvdCBhbmQgIGZ1bmMgaW5mbyBzcGVjaWZp
Y2FsbHkuIEkgYW0gbm90IHN1cmUgaG93IHRoYXQgd2lsbCBiZSB1c2VmdWwNCmZvciB0aGlzIHRo
b3VnaC4NCg0KPiAyLiBJcyAiaWQiIGZvciAgIi1kZXZpY2UgYXJtLXNtbXV2My1uZXN0ZWQiIG5l
Y2Vzc2FyeSBmb3IgYW55IHNvcnQgb2YNCj4gZnVuY3Rpb25hbGl0eT8gSWYgc28sIEknbGwgbWFr
ZSBhIGNoYW5nZSB0byBteSBsaWJ2aXJ0IHByb3RvdHlwZSB0bw0KPiBzdXBwb3J0IHRoaXMuIEkg
d2FzIGFibGUgdG8gYm9vdCBhIFZNIGFuZCBzZWUgYSBzaW1pbGFyIFZNIFBDSSB0b3BvbG9neQ0K
PiBhcyB5b3VyIGV4YW1wbGUgd2l0aG91dCBzcGVjaWZ5aW5nICJpZCIuDQoNClllcywgImlkIiBu
b3QgdXNlZCBhbmQgd2l0aG91dCBpdCwgaXQgd2lsbCB3b3JrLg0KDQo+IE90aGVyd2lzZSwgdGhl
IFZNIHRvcG9sb2d5IGxvb2tzIE9LIHdpdGggeW91ciBxZW11IGJyYW5jaCArIG15IGxpYnZpcnQN
Cj4gcHJvdG90eXBlLg0KDQpUaGF0IGlzIGdvb2QgdG8ga25vdy4NCiANCj4gQWxzbyBhcyBhIGhl
YWRzIHVwLCBJJ3ZlIGFkZGVkIHN1cHBvcnQgZm9yIGF1dG8taW5zZXJ0aW5nIFBDSWUgc3dpdGNo
DQo+IGJldHdlZW4gdGhlIFBYQiBhbmQgR1BVcyBpbiBsaWJ2aXJ0IHRvIGF0dGFjaCBtdWx0aXBs
ZSBkZXZpY2VzIHRvIGEgU01NVQ0KPiBub2RlIHBlciBsaWJ2aXJ0J3MgZG9jdW1lbnRhdGlvbiAt
ICJJZiB5b3UgaW50ZW5kIHRvIHBsdWcgbXVsdGlwbGUNCj4gZGV2aWNlcyBpbnRvIGEgcGNpZS1l
eHBhbmRlci1idXMsIHlvdSBtdXN0IGNvbm5lY3QgYQ0KPiBwY2llLXN3aXRjaC11cHN0cmVhbS1w
b3J0IHRvIHRoZSBwY2llLXJvb3QtcG9ydCB0aGF0IGlzIHBsdWdnZWQgaW50byB0aGUNCj4gcGNp
ZS1leHBhbmRlci1idXMsIGFuZCBtdWx0aXBsZSBwY2llLXN3aXRjaC1kb3duc3RyZWFtLXBvcnRz
IHRvIHRoZQ0KPiBwY2llLXN3aXRjaC11cHN0cmVhbS1wb3J0Ii4gRnV0dXJlIHVuaXQtdGVzdHMg
c2hvdWxkIGZvbGxvdyB0aGlzDQo+IHRvcG9sb2d5IGNvbmZpZ3VyYXRpb24uDQoNCk9rLiBDb3Vs
ZCB5b3UgcGxlYXNlIGdpdmUgbWUgYW4gZXhhbXBsZSBRZW11IGVxdWl2YWxlbnQgY29tbWFuZCBv
cHRpb24sDQppZiBwb3NzaWJsZSwgZm9yIHRoZSBhYm92ZSBjYXNlLiBJIGFtIG5vdCB0aGF0IGZh
bWlsaWFyIHdpdGggbGlidmlydCBhbmQgSSB3b3VsZA0KYWxzbyBsaWtlIHRvIHRlc3QgdGhlIGFi
b3ZlIHNjZW5hcmlvLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

