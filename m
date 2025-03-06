Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1688EC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFwZ-0007Yv-VO; Thu, 06 Mar 2025 13:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tqFwT-0007Wp-Sm; Thu, 06 Mar 2025 13:27:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tqFwI-0004Vi-JY; Thu, 06 Mar 2025 13:27:32 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7yVW4msDz6M4PT;
 Fri,  7 Mar 2025 02:24:03 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id ACC4D140A08;
 Fri,  7 Mar 2025 02:27:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 19:27:02 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 6 Mar 2025 19:27:02 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Donald Dutile
 <ddutile@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAAxlYAIAS3VEAgABWAvCAACxmsIAnKXxwgAFsm4CAGdE9AIAAF58A
Date: Thu, 6 Mar 2025 18:27:02 +0000
Message-ID: <e049b9f0e97d40b39e20ef3f330bbc94@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
 <Z5HBJOgO4tUJApY+@nvidia.com> <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
 <SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744B3D96A98584525B0401292FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c975f6dfaa9243c5a2db9e37d592ea51@huawei.com>
 <2191c0b3-f3a4-4d90-9448-23c3bc876372@redhat.com>
In-Reply-To: <2191c0b3-f3a4-4d90-9448-23c3bc876372@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.149.177]
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggNiwgMjAyNSA2OjAw
IFBNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+OyBEdWFuLCBaaGVuemhvbmcNCj4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT47IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47DQo+IERvbmFs
ZCBEdXRpbGUgPGRkdXRpbGVAcmVkaGF0LmNvbT4NCj4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZz47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+
OyBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgTGludXhhcm0NCj4gPGxpbnV4YXJt
QGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4g
amlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+
IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsg
UGVuZywgQ2hhbyBQDQo+IDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UkZDIFBBVENIIDAvNV0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1c2VyLWNyZWF0YWJs
ZQ0KPiBuZXN0ZWQgU01NVXYzDQo+IA0KPiBIaSBTaGFtbWVlciwNCj4gDQoNCkhpIEVyaWMsDQoN
Cj4gPg0KPiA+IEkgYW0gY3VycmVudGx5IHdvcmtpbmcgb24gcmVmYWN0b3JpbmcgdGhlIFNNTVV2
MyBhY2NlbCBzZXJpZXMgYW5kIHRoZQ0KPiA+ICJBZGQgSFcgYWNjZWxlcmF0ZWQgbmVzdGluZyBz
dXBwb3J0IGZvciBhcm0gU01NVXYzIiBzZXJpZXMNCj4gc28gd2lsbCB5b3Ugc2VuZCAiQWRkIEhX
IGFjY2VsZXJhdGVkIG5lc3Rpbmcgc3VwcG9ydCBmb3IgYXJtIFNNTVV2MyIgb3INCj4gZG8geW91
IHdhbnQgbWUgdG8gZG8gaXQ/IFRoYW5rcyBFcmljDQoNClllcy4gSSBhbSBvbiBpdC4gSG9wZWZ1
bGx5IEkgd2lsbCBiZSBhYmxlIHRvIHNlbmQgb3V0IGV2ZXJ5dGhpbmcgbmV4dCB3ZWVrLg0KDQpU
aGFua3MsDQpTaGFtZWVyDQo=

