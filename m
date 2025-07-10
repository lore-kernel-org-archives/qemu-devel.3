Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D516C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoF9-0004hL-T4; Thu, 10 Jul 2025 06:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZoF7-0004bJ-Uu; Thu, 10 Jul 2025 06:11:05 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZoEv-0002v8-H9; Thu, 10 Jul 2025 06:11:05 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bd9WJ3M8xz6L50J;
 Thu, 10 Jul 2025 18:07:24 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 64B0D140427;
 Thu, 10 Jul 2025 18:10:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Jul 2025 12:10:39 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 10 Jul 2025 12:10:39 +0200
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v7 00/12] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Topic: [PATCH v7 00/12] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Index: AQHb8IJTAbxuyEQcDESTnA/ODfg2XLQrAziA
Date: Thu, 10 Jul 2025 10:10:39 +0000
Message-ID: <1291e658f6284fc3b041b599ad375ea1@huawei.com>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

DQpIaSBQZXRlciwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGFt
ZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IFNl
bnQ6IFR1ZXNkYXksIEp1bHkgOCwgMjAyNSA0OjQxIFBNDQo+IFRvOiBxZW11LWFybUBub25nbnUu
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsg
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4gbmljb2xpbmNAbnZp
ZGlhLmNvbTsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOw0KPiBpbWFt
bWVkb0ByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207IG1vY2hzQG52aWRpYS5jb207DQo+
IHNtb3N0YWZhQGdvb2dsZS5jb207IGd1c3Rhdm8ucm9tZXJvQGxpbmFyby5vcmc7IG1zdEByZWRo
YXQuY29tOw0KPiBtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbTsgbGludXhhcm1AaHVhd2VpLmNv
bTsNCj4gd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207IGppYW5na3Vua3VuQGh1YXdlaS5jb207DQo+
IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4g
U3ViamVjdDogW1BBVENIIHY3IDAwLzEyXSBody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVz
ZXIgY3JlYXRhYmxlDQo+IFNNTVV2MyBkZXZpY2UNCj4gDQo+IEhpIEFsbCwNCj4gDQo+IENoYW5n
ZXMgZnJvbSB2NjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDcw
MzA4NDY0My44NTc0MC0xLQ0KPiBzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20v
DQo+IA0KPiAxLiBGaXhlZCB0aGUgd2FybmluZyBjYXNlIGZvciBEVCBzdXBwb3J0LCByZXBvcnRl
ZCBieSBFcmljKHBhdGNoICM4KS4NCj4gMi4gUGlja2VkIHVwIFItYnkncyBhbmQgVC1ieSdzLiBU
aGFua3MhDQo+IA0KPiBQbGVhc2UgdGFrZSBhIGxvb2sgYW5kIGxldCBtZSBrbm93LiBJIHRoaW5r
IHRoaXMgaXMgaW4gYSBnb29kIHNoYXBlIG5vdw0KPiBmb3IgMTAuMS4NCg0KSSB1bmRlcnN0YW5k
IHRoZSBzb2Z0LWZyZWV6ZSBmb3IgMTAuMSBpcyBuZXh0IHdlZWsuIEFueSBjaGFuY2UgdGhpcyBz
ZXJpZXMNCmNhbiBiZSBwaWNrZWQgZm9yIDEwLjE/IFBsZWFzZSBsZXQgbWUga25vdy4NCg0KVGhh
bmtzLA0KU2hhbWVlcg0KIA0K

