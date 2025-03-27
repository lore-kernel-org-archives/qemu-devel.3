Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CABC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 07:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txi53-0002c0-LD; Thu, 27 Mar 2025 03:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1txi4u-0002VR-Fh; Thu, 27 Mar 2025 03:55:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1txi4s-0003s0-Cs; Thu, 27 Mar 2025 03:55:04 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZNbTB1GQ7z6JBQx;
 Thu, 27 Mar 2025 15:51:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id F3E7A14025A;
 Thu, 27 Mar 2025 15:54:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Mar 2025 08:54:58 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 27 Mar 2025 08:54:58 +0100
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 17/20] hw/arm/smmuv3: Check idr registers for
 STE_S1CDMAX and STE_S1STALLD
Thread-Topic: [RFC PATCH v2 17/20] hw/arm/smmuv3: Check idr registers for
 STE_S1CDMAX and STE_S1STALLD
Thread-Index: AQHbkttm9G+NpcjonkCXH1rH866om7OFr8yAgAApYgCAANoSoA==
Date: Thu, 27 Mar 2025 07:54:58 +0000
Message-ID: <cd1393939aaa43bebce8bd926b4b00de@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-18-shameerali.kolothum.thodi@huawei.com>
 <477323cb-12d3-484c-8ad9-61229ede3efe@redhat.com>
 <Z+RZsES0+Ywxi7Xx@nvidia.com>
In-Reply-To: <Z+RZsES0+Ywxi7Xx@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.48]
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI2LCAyMDI1IDc6
NDcgUE0NCj4gVG86IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gQ2M6IFNo
YW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVh
d2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRo
YXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hz
QG52aWRpYS5jb207IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBo
dWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGpp
YW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4g
U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMTcvMjBdIGh3L2FybS9zbW11djM6IENoZWNrIGlk
ciByZWdpc3RlcnMgZm9yDQo+IFNURV9TMUNETUFYIGFuZCBTVEVfUzFTVEFMTEQNCj4gDQoNCj4g
PiBBZ2FpbiBJIHRoaW5rIHdlIG5lZWQgdG8gdW5kZXJzdGFuZCB0aGUgY29uc2VxdWVuY2Ugb2Yg
aGF2aW5nIGEgbW9yZQ0KPiA+IGNvbXByZWhlbnNpdmUgc3VwcG9ydCBvZiBTU0lELiBUaGlzIGFs
c28gaG9sZHMgd2l0aCBvbGQgdGhlIElEUiBmaWVsZHMNCj4gPiB0aGF0IG1heSBiZSBpbmhlcml0
ZWQgZnJvbSB0aGUgSFcgYW5kIHdlIGRvbid0IHN1cHBvcnQgeWV0IGluIHRoZQ0KPiA+IGVtdWxh
dGlvbiBjb2RlDQo+IA0KPiBUbyBzdXBwb3J0IGd1ZXN0LWxldmVsIFNWQSwgaXQgbXVzdCBzdXBw
b3J0IFNTSUQuIFdlIGNhbiBrZWVwIHRoZQ0KPiBTU0lEU0laRT0wIGluIGFuIGVtdWxhdGVkIFNN
TVUuIFdvdWxkIHlvdSBlbGFib3JhdGUgdGhlIGNvbmNlcm4gb2YNCj4gZG9pbmcgc28/DQo+IA0K
UmVnYXJkaW5nIGFkZGluZyBzdXBwb3J0IGZvciBTU0lEL1NWQSBpbiBlbXVsYXRpb24gY29kZSwg
dGhlIHN1cHBvcnQgYWxzbyBkZXBlbmRzIG9uDQpkZXZpY2UgUFJJL0lPUEYgZmVhdHVyZSBhcyB3
ZWxsLiBEbyB3ZSBoYXZlIGFueSBlbXVsYXRlZCBkZXZpY2VzIHRoYXQgY2FuIG1ha2UgdXNlDQp0
aGlzPyBJIHdvdWxkIHNheSB3ZSBjYW4gYWRkIHRoYXQgc3VwcG9ydCBsYXRlciBpZiB0aGVyZSBp
cyBhbnkgcmVhbCB1c2UgY2FzZXMgZm9yIHRoYXQuDQoNClRoYW5rcywNClNoYW1lZXIgDQo=

