Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09836E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7Rw-00060a-Bs; Mon, 16 Dec 2024 04:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tN7Rf-0005yi-8Y; Mon, 16 Dec 2024 04:31:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tN7Rd-0002qZ-5B; Mon, 16 Dec 2024 04:31:19 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBZLp4tyWz6K5pv;
 Mon, 16 Dec 2024 17:26:10 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 84C0F140445;
 Mon, 16 Dec 2024 17:31:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Dec 2024 10:31:03 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 16 Dec 2024 10:31:03 +0100
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
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rK0OI0AgAyjUACAIpIKgIAAEq8AgAVS2bA=
Date: Mon, 16 Dec 2024 09:31:03 +0000
Message-ID: <31db1f75110e46ccaffffb801e894605@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
 <1d4cf9bb-ae4b-4c4e-9b33-23c4eda96d92@nvidia.com>
 <7e1a61c1-10cf-4bf3-b87a-a61b8b3b1548@nvidia.com>
In-Reply-To: <7e1a61c1-10cf-4bf3-b87a-a61b8b3b1548@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.221]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.168, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
biBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTMs
IDIwMjQgMTowMiBBTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFs
aS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsg
cWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBlcmljLmF1Z2VyQHJlZGhhdC5jb207IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsg
TGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikNCj4gPHdhbmd6aG91
MUBoaXNpbGljb24uY29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0K
PiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiB6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZzsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzVdIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBm
b3IgdXNlci1jcmVhdGFibGUNCj4gbmVzdGVkIFNNTVV2Mw0KPiANCj4gDQo+ICA+d2l0aCBhbiBl
cnJvciBtZXNzYWdlIGluZGljYXRpbmcgRE1BIG1hcHBpbmcgZmFpbGVkIGZvciB0aGUNCj4gcGFz
c3Rocm91Z2ggPmRldmljZXMuDQo+IA0KPiBBIGNvcnJlY3Rpb24gLSB0aGUgbWVzc2FnZSBpbmRp
Y2F0ZXMgVUVGSSBmYWlsZWQgdG8gZmluZCBhIG1hcHBpbmcgZm9yDQo+IHRoZSBib290IHBhcnRp
dGlvbiAoIm1hcDogbm8gbWFwcGluZyBmb3VuZCIpLCBub3QgdGhhdCBETUEgbWFwcGluZw0KPiBm
YWlsZWQuIEJ1dCBlYXJsaWVyIEVESyBkZWJ1ZyBsb2dzIHN0aWxsIHNob3cgUENJIGhvc3QgYnJp
ZGdlIHJlc291cmNlDQo+IGNvbmZsaWN0cyBmb3IgdGhlIHBhc3N0aHJvdWdoIGRldmljZXMgdGhh
dCBzZWVtIHJlbGF0ZWQgdG8gdGhlIFZNIGJvb3QNCj4gZmFpbHVyZS4NCg0KSSBoYXZlIHRyaWVk
IGEgMjAyMyB2ZXJzaW9uIEVGSSB3aGljaCB3b3Jrcy4gQW5kIGZvciBtb3JlIHJlY2VudCB0ZXN0
cyBJIGFtDQp1c2luZyBhIG9uZSBidWlsdCBkaXJlY3RseSBmcm9tLA0KaHR0cHM6Ly9naXRodWIu
Y29tL3RpYW5vY29yZS9lZGsyLmdpdCBtYXN0ZXINCg0KQ29tbWl0OiAwZjM4NjdmYTZlZjAoIlVl
ZmlQYXlsb2FkUGtnL1VlZmlQYXlsb2FkRW50cnk6IEZpeCBQVCBwcm90ZWN0aW9uDQppbiA1IGxl
dmVsIHBhZ2luZyINCg0KV2l0aCBib3RoLCBJIGRvbuKAmXQgcmVtZW1iZXIgc2VlaW5nIGFueSBi
b290IGZhaWx1cmUgYW5kIHRoZSBhYm92ZSBVRUZJDQpyZWxhdGVkICJtYXA6IG5vIG1hcHBpbmcg
Zm91bmQiIGVycm9yLiBCdXQgdGhlIEd1ZXN0IGtlcm5lbCBhdCB0aW1lcw0KY29tcGxhaW50cyBh
Ym91dCBwY2kgYnJpZGdlIHdpbmRvdyBtZW1vcnkgYXNzaWdubWVudCBmYWlsdXJlcy4NCi4uLg0K
cGNpIDAwMDA6MTA6MDEuMDogYnJpZGdlIHdpbmRvdyBbbWVtIHNpemUgMHgwMDIwMDAwMCA2NGJp
dCBwcmVmXTogY2FuJ3QgYXNzaWduOyBubyBzcGFjZQ0KcGNpIDAwMDA6MTA6MDEuMDogYnJpZGdl
IHdpbmRvdyBbbWVtIHNpemUgMHgwMDIwMDAwMCA2NGJpdCBwcmVmXTogZmFpbGVkIHRvIGFzc2ln
bg0KcGNpIDAwMDA6MTA6MDAuMDogYnJpZGdlIHdpbmRvdyBbaW8gIHNpemUgMHgxMDAwXTpjYW4n
dCBhc3NpZ247IG5vIHNwYWNlDQouLi4NCg0KQnV0IEd1ZXN0IHN0aWxsIGJvb3RzIGFuZCB3b3Jr
ZWQgZmluZSBzbyBmYXIuDQoNClRoYW5rcywNClNoYW1lZXINCg==

