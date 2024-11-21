Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822EAD6E2A7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3mh-0007Mv-13; Thu, 21 Nov 2024 04:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tE3mf-0007ML-K5; Thu, 21 Nov 2024 04:47:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tE3md-00044n-VH; Thu, 21 Nov 2024 04:47:33 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvCwr18qDz6K6lP;
 Thu, 21 Nov 2024 17:43:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 42FEF140A79;
 Thu, 21 Nov 2024 17:47:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 10:47:30 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 21 Nov 2024 10:47:30 +0100
To: Andrea Bolognani <abologna@redhat.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Mostafa Saleh <smostafa@google.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peter Maydell" <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer
 <mdf@kernel.org>, Michael Shavit <mshavit@google.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "arighi@nvidia.com" <arighi@nvidia.com>, "ianm@nvidia.com" <ianm@nvidia.com>, 
 "jan@nvidia.com" <jan@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>
Subject: RE: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Topic: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Index: AQHbLBPkDYWW/RlwrUqSJByfpx0jw7KisNtQgB4IZoCAAOMVUA==
Date: Thu, 21 Nov 2024 09:47:29 +0000
Message-ID: <9af947a939e24de894e8bdf6e7de5c22@huawei.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <cf4359b18f0d44f09b8901141b678a09@huawei.com>
 <CABJz62M9-mtwd4dvCc=8LEJHGMnUn4zQDS8-ocTfxZ=Y3i1q-g@mail.gmail.com>
In-Reply-To: <CABJz62M9-mtwd4dvCc=8LEJHGMnUn4zQDS8-ocTfxZ=Y3i1q-g@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmVhIEJvbG9nbmFu
aSA8YWJvbG9nbmFAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyMCwg
MjAyNCA5OjE0IFBNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxp
LmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IENjOiBOaWNvbGluIENoZW4gPG5pY29saW5j
QG52aWRpYS5jb20+OyBFcmljIEF1Z2VyDQo+IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+OyBNb3N0
YWZhIFNhbGVoIDxzbW9zdGFmYUBnb29nbGUuY29tPjsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IEplYW4tDQo+IFBo
aWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz47IE1vcml0eiBGaXNjaGVy
DQo+IDxtZGZAa2VybmVsLm9yZz47IE1pY2hhZWwgU2hhdml0IDxtc2hhdml0QGdvb2dsZS5jb20+
OyBNaWNoYWVsIFMuDQo+IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgUGV0ZXIgWHUgPHBldGVy
eEByZWRoYXQuY29tPjsgWmhhbmdmZWkgR2FvDQo+IDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz47
IG5hdGhhbmNAbnZpZGlhLmNvbTsgYXJpZ2hpQG52aWRpYS5jb207DQo+IGlhbm1AbnZpZGlhLmNv
bTsgamFuQG52aWRpYS5jb207IG1vY2hzQG52aWRpYS5jb20NCj4gU3ViamVjdDogUmU6IG5lc3Rl
ZC1zbW11djMgdG9waWMgZm9yIFFFTVUvbGlidmlydCwgTm92IDIwMjQNCj4gDQo+IE9uIEZyaSwg
Tm92IDAxLCAyMDI0IGF0IDA2OjM1OjIzUE0gKzAwMDAsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhv
ZGkNCj4gd3JvdGU6DQo+ID4gSSBoYXZlIGEgYmFyZSBtaW5pbXVtIHByb3RvdHlwZSBjb2RlIHRo
YXQgd29ya3Mgd2l0aCBhIHBsdWdnYWJsZQ0KPiBzbW11djMuDQo+ID4NCj4gPiAuLi4NCj4gPiAt
ZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMSxidXNfbnI9MixidXM9cGNpZS4wIFwNCj4gPiAtZGV2
aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXBjaWUucG9ydDEsYnVzPXBjaWUuMSBcDQo+ID4gLWRldmlj
ZSBhcm0tc21tdXYzLW5lc3RlZCxpZD1zbW11djEscGNpLWJ1cz1wY2llLjEgXA0KPiA+IC1kZXZp
Y2UgdmZpby1wY2ktDQo+IG5vaG90cGx1Zyxob3N0PTAwMDA6NzU6MDAuMSxidXM9cGNpZS5wb3J0
MSxpb21tdWZkPWlvbW11ZmQwIFwNCj4gPiAtZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMixidXNf
bnI9OCxidXM9cGNpZS4wIFwNCj4gPiAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXBjaWUucG9y
dDIsYnVzPXBjaWUuMixjaGFzc2lzPTggXA0KPiA+IC1kZXZpY2UgYXJtLXNtbXV2My1uZXN0ZWQs
aWQ9c21tdXYyLHBjaS1idXM9cGNpZS4yIFwNCj4gPiAtZGV2aWNlIHZmaW8tcGNpLQ0KPiBub2hv
dHBsdWcsaG9zdD0wMDAwOjdkOjAyLjEsYnVzPXBjaWUucG9ydDIsaW9tbXVmZD1pb21tdWZkMCBc
DQo+IA0KPiBTaWxseSBiaXQgb2YgZmVlZGJhY2sgb24gdGhlIGludGVyZmFjZSwgYnV0IHdoeSBp
cyB0aGUNCj4gYXJtLXNtbXV2My1uZXN0ZWQgcHJvcGVydHkgY2FsbGVkICJwY2ktYnVzIiBpbnN0
ZWFkIG9mIGp1c3QgImJ1cyI/DQo+IA0KPiBBbGwgb3RoZXIgZGV2aWNlcyB0aGF0IG5lZWQgdG8g
cmVmZXIgdG8gYW4gZXhpc3RpbmcgUENJIGJ1cyB1c2UgdGhlDQo+IGxhdHRlci4gSXMgdGhlcmUg
YSByZWFzb24gZm9yIHRoaXMgc3BlY2lmaWMgb25lIHRvIGRpdmVyZ2U/DQoNCk5vcGUuIFRoaXMg
d2lsbCBiZSBjaGFuZ2VkIHRvICJidXMiIGluIG5leHQgcmVzcGluLg0KDQpUaGFua3MsDQpTaGFt
ZWVyDQo=

