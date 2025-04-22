Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7617C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 08:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u79Rh-00010n-Dc; Tue, 22 Apr 2025 04:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u79Rc-0000xj-Nu; Tue, 22 Apr 2025 04:57:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u79RY-00058t-3T; Tue, 22 Apr 2025 04:57:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zhbbk1sS1z6K9P8;
 Tue, 22 Apr 2025 16:52:50 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 12AF41402EA;
 Tue, 22 Apr 2025 16:57:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 10:57:20 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 22 Apr 2025 10:57:20 +0200
To: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH 0/5] Add support for user creatable SMMUv3 device
Thread-Topic: [PATCH 0/5] Add support for user creatable SMMUv3 device
Thread-Index: AQHbrd5Z6XfidS8N/U6PO20X8QxpSbOpxUQAgAWkbCA=
Date: Tue, 22 Apr 2025 08:57:20 +0000
Message-ID: <8f7cc59e3745407bb7ae3d875cf97ae0@huawei.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <84870c74-f078-48c5-bead-96db1d582987@redhat.com>
In-Reply-To: <84870c74-f078-48c5-bead-96db1d582987@redhat.com>
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERvbmFsZCBEdXRpbGUgPGRk
dXRpbGVAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxOCwgMjAyNSA5OjM0IFBN
DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiBxZW11LWRldmVsQG5v
bmdudS5vcmcNCj4gQ2M6IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4gbmljb2xpbmNAbnZpZGlhLmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOw0KPiBtb2Noc0BudmlkaWEuY29tOyBzbW9z
dGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6
aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiBqaWFuZ2t1bmt1biA8amlhbmdr
dW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMC81XSBBZGQgc3VwcG9ydCBmb3IgdXNlciBjcmVhdGFibGUgU01NVXYzIGRldmljZQ0KPiAN
Cj4gU2hhbWVlciwNCj4gSGkhDQo+IA0KPiBGaXJzdCBvZmYsIGxpa2UgdGhlIHBhcnRpdGlvbmlu
ZyBvZiB0aGVzZSBwaWVjZXMuDQo+IA0KPiBPbiA0LzE1LzI1IDQ6MTAgQU0sIFNoYW1lZXIgS29s
b3RodW0gd3JvdGU6DQo+ID4gSGkgQWxsLA0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW50
cm9kdWNlcyBzdXBwb3J0IGZvciBhIHVzZXItY3JlYXRhYmxlIFNNTVV2MyBkZXZpY2UNCj4gPiAo
LWRldmljZSBhcm0tc21tdXYzLWRldikgaW4gUUVNVS4NCj4gPg0KPiBDYW4gd2UgZHJvcCB0aGUg
Jy1kZXYnLCBhcyAnYXJtLXNtbXUnIGlzIHN1ZmZpY2llbnQsIGFzIGlzICctZGV2aWNlJz8NCj4g
DQo+IEkga25vdywgaW50ZXJuYWwgdG8gUUVNVSwgdGhlcmUncyBhbHJlYWR5IGFuIEFSTV9TTU1V
LCBidXQgYXMgc3VnZ2VzdGVkDQo+IGxhdGVyLA0KPiBpZiBpdCB1c2VzIHRoZSBzYW1lIHN0cnVj
dCwgdGhlIHFlbXUgY21kbGluZSBzeW50YXggaXMgYSBiaXQgbGVzcyByZWR1bmRhbnQuDQoNClRy
dXN0IG1lIEkgdHJpZWQgdGhhdPCfmIouIFRoZSBwcm9ibGVtIGlzIHRoYXQsIHRoZSBsZWdhY3kg
b25lIGRvZXNuJ3QgaGF2ZSBhIGJ1cw0KYXNzb2NpYXRlZCB3aXRoIGl0IGFuZCB0aGUgbW9tZW50
IHdlIGNoYW5nZSB0aGF0IGFuZCBoYXZlIGJ1cyBzcGVjaWZpZWQgZm9yIHRoZQ0KICItZGV2aWNl
IGFybS1zbW11djMsIGJ1cz1wY2llLjAiIHRoZSBsZWdhY3kgc21tdXYzIGNyZWF0aW9uIGluIHZp
cnQsDQoNCmNyZWF0ZV9zbW11KCkgLS0+IHFkZXZfbmV3KFRZUEVfQVJNX1NNTVVWMykNCg0Kd2ls
bCBmYWlscyBhcyBpdCBleHBlY3RzIHRoZSBidXMgdHlwZSB0byBiZSBzcGVjaWZpZWQgZm9yIGl0
LiBJIGNvdWxkbid0IGZpbmQgYSB3YXkNCnRvIHNvbHZlIHRoYXQuDQoNCj4gDQo+ID4gVGhlIGlt
cGxlbWVudGF0aW9uIGlzIGJhc2VkIG9uIGZlZWRiYWNrIHJlY2VpdmVkIGZyb20gdGhlIFJGQ3Yy
WzBdOg0KPiA+ICJody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVzZXItY3JlYXRhYmxlIGFj
Y2VsZXJhdGVkIFNNTVV2MyINCj4gPg0KPiA+IEN1cnJlbnRseSwgUUVNVSdzIFNNTVV2MyBlbXVs
YXRpb24gKGlvbW11PXNtbXV2MykgaXMgdGllZCB0byB0aGUNCj4gbWFjaGluZQ0KPiA+IGFuZCBk
b2VzIG5vdCBzdXBwb3J0IGluc3RhbnRpYXRpbmcgbXVsdGlwbGUgU01NVXYzIGRldmljZXPigJRl
YWNoDQo+IGFzc29jaWF0ZWQNCj4gPiB3aXRoIGEgc2VwYXJhdGUgUENJZSByb290IGNvbXBsZXgu
IEluIGNvbnRyYXN0LCByZWFsLXdvcmxkIEFSTSBzeXN0ZW1zDQo+ID4gb2Z0ZW4gaW5jbHVkZSBt
dWx0aXBsZSBTTU1VdjMgaW5zdGFuY2VzLCBlYWNoIGJvdW5kIHRvIGEgZGlmZmVyZW50IFBDSWUN
Cj4gPiByb290IGNvbXBsZXguDQo+ID4NCj4gPiBUaGlzIGFsc28gbGF5cyB0aGUgZ3JvdW5kd29y
ayBmb3Igc3VwcG9ydGluZyBhY2NlbGVyYXRlZCBTTU1VdjMsIGFzDQo+ID4gcHJvcG9zZWQgaW4g
dGhlIGFmb3JlbWVudGlvbmVkIFJGQy4gUGxlYXNlIG5vdGUsIHRoZQ0KPiBhY2NlbGVyYXRlZMKg
U01NVXYzDQo+ID4gc3VwcG9ydCBpcyBub3QgcGFydCBvZiB0aGlzIHNlcmllcyBhbmQgd2lsbCBi
ZSBzZW50IG91dCBhcyBhIHNlcGFyYXRlDQo+ID4gc2VyaWVzIGxhdGVyIG9uIHRvcCBvZiB0aGlz
IG9uZS4NCj4gPg0KPiA+IFN1bW1hcnkgb2YgY2hhbmdlczoNCj4gPg0KPiA+ICDCoC1JbnRyb2R1
Y2VzIHN1cHBvcnQgZm9yIG11bHRpcGxlIC1kZXZpY2UgYXJtLXNtbXV2My1kZXYsYnVzPXBjaWUu
eA0KPiA+ICDCoCBpbnN0YW5jZXMuDQo+ID4NCj4gPiAgwqAgRXhhbXBsZSB1c2FnZToNCj4gPg0K
PiA+ICDCoCAtZGV2aWNlIGFybS1zbW11djMtZGV2LGJ1cz1wY2llLjANCj4gPiAgwqAgLWRldmlj
ZSB2aXJ0aW8tbmV0LXBjaSxidXM9cGNpZS4wDQo+ID4gIMKgIC1kZXZpY2UgcHhiLXBjaWUsaWQ9
cGNpZS4xLGJ1c19ucj0yDQo+ID4gIMKgIC1kZXZpY2UgYXJtLXNtbXV2My1kZXYsYnVzPXBjaWUu
MQ0KPiA+ICDCoCAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXBjaWUucG9ydDEsYnVzPXBjaWUu
MQ0KPiA+ICDCoCAtZGV2aWNlIHZpcnRpby1uZXQtcGNpLGJ1cz1wY2llLnBvcnQxDQo+ID4NCj4g
PiAgwqAgLVN1cHBvcnRzIGVpdGhlciB0aGUgbGVnYWN5IGlvbW11PXNtbXV2MyBvcHRpb24gb3Ig
dGhlIG5ldw0KPiA+ICDCoCAiLWRldmljZSBhcm0tc21tdXYzLWRldiIgbW9kZWwuDQo+ID4NCj4g
bmljZSEgOikNCj4gQ2FuIGl0IHN1cHBvcnQgYm90aD8gaS5lLiwgc29tZSBkZXZpY2VzIHVzaW5n
IGEgc3lzdGVtLXdpZGUsIGxlZ2FjeQ0KPiBzbW11djMsDQo+IGFuZCBzb21lIHBjaWUgZGV2aWNl
cyB1c2luZyB0aGUgLWRldmljZSBhcm0tc21tdXYzID8NCg0KUGxlYXNlIHNlZSBteSByZXBseSB0
byBwYXRjaCAjMi4gSW4gc2hvcnQgTm8sIGl0IGRvZXNuJ3Qgc3VwcG9ydCBib3RoLg0KDQpBbHNv
IEkgdGhpbmsgd2Ugc2hvdWxkIHNsb3dseSBkZXByZWNhdGUgdGhlIHVzZSBvZiBsZWdhY3kgU01N
VXYzIGdvaW5nIA0KZm9yd2FyZCB1bmxlc3MgdGhlcmUgaXMgYSBzdHJvbmcgdXNlIGNhc2UvcmVh
c29uIHRvIHN1cHBvcnQgaXQuDQoNCj4gSWYgbm90LCB0aGVuIGFkZCBhIGNoZWNrIHRvIG1pbi13
YXJuIG9yIG1heC1mYWlsLCB0aGF0IGNvbmZpZy4NCj4gSSBjYW4gc2VlIG9sZCBtYWNoaW5lcyBi
ZWluZyBjb252ZXJ0ZWQvdXBncmFkZWQgdG8gbmV3IG1hY2hpbmVzLA0KPiBhbmQgdGhleSB3aWxs
IHdhbnQgdG8gc3dpdGNoIGZyb20gbGVnYWN5LT5kZXZpY2Ugc21tdXYzLCBhbmQgY2F0Y2hpbmcN
Cj4gYW4gZWRpdC91cGRhdGUgdG8gYSBtYWNoaW5lIGNoYW5nZSAob3IgZW5hYmxpbmcgYXV0b21h
dGVkIGNvbnZlcnNpb24pDQo+IHdvdWxkIGJlIGhlbHBmdWwuDQoNClBsZWFzZSBzZWUgUGF0Y2gg
IzQuIEl0IGFscmVhZHkgY2hlY2tzIGFuZCBwcmV2ZW50cyBpZiBpbmNvbXBhdGlibGUgU01NVXYz
DQp0eXBlcyBhcmUgc3BlY2lmaWVkLiBPciBpcyB0aGUgc3VnZ2VzdGlvbiBoZXJlIGlzIHRvIGFk
ZCBzb21ldGhpbmcgZXh0cmE/DQpQbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcywNClNoYW1l
ZXINCg0K

