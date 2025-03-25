Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283EBC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6RO-0000ds-8d; Tue, 25 Mar 2025 11:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tx6RL-0000d5-Ui; Tue, 25 Mar 2025 11:43:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tx6RI-0004HY-Os; Tue, 25 Mar 2025 11:43:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZMYyV6KYPz6D99x;
 Tue, 25 Mar 2025 23:40:02 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 1FC8F14050C;
 Tue, 25 Mar 2025 23:43:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Mar 2025 16:43:29 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 25 Mar 2025 16:43:29 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 00/20] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [RFC PATCH v2 00/20] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHbku9qSXcuhW1ML0aJ2/ms8Fev1bOD8a2AgAAdwlA=
Date: Tue, 25 Mar 2025 15:43:29 +0000
Message-ID: <ffff33965d2a4ed4a5bf22c1bda6d774@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <dbc0ee83-cb24-4fa5-9060-54a34a324f2c@redhat.com>
In-Reply-To: <dbc0ee83-cb24-4fa5-9060-54a34a324f2c@redhat.com>
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI1LCAy
MDI1IDI6NDMgUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJh
bGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dA
bnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBi
ZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hzQG52aWRpYS5j
b207IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29t
PjsgV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5na3Vua3Vu
IDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDog
UmU6IFtSRkMgUEFUQ0ggdjIgMDAvMjBdIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNl
ci0NCj4gY3JlYXRhYmxlIGFjY2VsZXJhdGVkIFNNTVV2Mw0KPiANCg0KDQo+IEZvciB0aGUgcmVj
b3JkIEkgdGVzdGVkIHRoZSBzZXJpZXMgd2l0aCBob3N0IFZGSU8gZGV2aWNlIGFuZCBhDQo+IHZp
cnRpby1ibGstcGNpIGRldmljZSBwdXQgYmVoaW5kIHRoZSBzYW1lIHB4Yi1wY2llL3NtbXUgcHJv
dGVjdGlvbiBhbmQNCj4gaXQgd29ya3MganVzdCBmaW5lDQo+IA0KPiAtKy1bMDAwMDowYV0tKy0w
MS4wLVswYl0tLS0tMDAuMMKgIE1lbGxhbm94IFRlY2hub2xvZ2llcyBDb25uZWN0WCBGYW1pbHkN
Cj4gbWx4NUdlbiBWaXJ0dWFsIEZ1bmN0aW9uDQo+IMKgfMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwt
MDEuMS1bMGNdLS0tLTAwLjDCoCBSZWQgSGF0LCBJbmMuIFZpcnRpbyAxLjAgYmxvY2sgZGV2aWNl
DQo+IMKgXC1bMDAwMDowMF0tKy0wMC4wwqAgUmVkIEhhdCwgSW5jLiBRRU1VIFBDSWUgSG9zdCBi
cmlkZ2UNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICstMDEuMC1bMDFdLS0NCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICstMDEuMS1bMDJdLS0NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwtMDIuMMKgIFJlZCBIYXQsIEluYy4gUUVNVSBQQ0llIEV4cGFuZGVyIGJyaWRnZQ0KPiAN
Cj4gVGhpcyBzaG93cyB0aGF0IHdpdGhvdXQgdmNtZHEgZmVhdHVyZSB0aGVyZSBpcyBubyBibG9j
a2VyIGhhdmluZyB0aGUNCj4gc2FtZSBzbW11IGRldmljZSBwcm90ZWN0aW5nIGJvdGggYWNjZWxl
cmF0ZWQgYW5kIGVtdWxhdGVkIGRldmljZXMuDQoNClRoYW5rcyBmb3IgZ2l2aW5nIGl0IGEgc3Bp
bi4gWWVzLCBpdCBjdXJyZW50bHkgc3VwcG9ydHMgdGhlIGFib3ZlLiANCg0KQXQgdGhlIG1vbWVu
dCB3ZSBhcmUgbm90IHVzaW5nIHRoZSBJT1RMQiBmb3IgdGhlIGVtdWxhdGVkIGRldiBmb3IgYQ0K
Y29uZmlnIGxpa2UgYWJvdmUuICBIYXZlIHlvdSBjaGVja2VkIHBlcmZvcm1hbmNlIGZvciBlaXRo
ZXIgZW11bGF0ZWQgb3INCnZmaW8gZGV2IHdpdGggdGhlIGFib3ZlIGNvbmZpZz8gV2hhdGV2ZXIg
bGlnaHQgdGVzdHMgSSBoYXZlIGRvbmUgaXQgc2hvd3MNCnBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9u
IGZvciBlbXVsYXRlZCBkZXYgY29tcGFyZWQgdG8gdGhlIGRlZmF1bHQNClNNTVV2Myhpb21tdT1z
bW11djMpLiANCg0KQW5kIGlmIHRoZSBlbXVsYXRlZCBkZXYgaXNzdWVzIF9UTEJJX05IX0FTSUQs
IHRoZSBjb2RlIGN1cnJlbnRseSB3aWxsIHByb3BhZ2F0ZQ0KdGhhdCBkb3duIHRvIGhvc3QgU01N
VXYzLiBUaGlzIHdpbGwgYWZmZWN0IHRoZSB2ZmlvIGRldiBhcyB3ZWxsLg0KDQpTbyB0aGUgcXVl
c3Rpb24gaXMgd2hldGhlciB3ZSB3YW50IHRvIGFsbG93IHRoaXMoYXNzdW1pbmcgdXNlciBpcyBl
ZHVjYXRlZCkgb3INCmJsb2NrIHN1Y2ggYSBjb25maWcgYXMgdXNlciBoYXMgYW4gb3B0aW9uIG9m
IHVzaW5nIGEgbm9uLWFjY2VsIHNtbXV2MyBmb3INCmVtdWxhdGVkIGRldmljZXMuDQoNClRoYW5r
cywNClNoYW1lZXINCg0KDQo=

