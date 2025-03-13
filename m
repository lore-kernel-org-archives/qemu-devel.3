Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F987C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdpt-0007t5-RY; Thu, 13 Mar 2025 04:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsdps-0007ss-8S; Thu, 13 Mar 2025 04:22:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsdpp-0002Bz-MB; Thu, 13 Mar 2025 04:22:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD0lW3GzJz6M4Hf;
 Thu, 13 Mar 2025 16:19:19 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id E2394140CB1;
 Thu, 13 Mar 2025 16:22:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:22:28 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 13 Mar 2025 09:22:28 +0100
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
Subject: RE: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Thread-Topic: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie
 bus
Thread-Index: AQHbkps6in4QB/PMZUednFRw1zRmILNvm8wAgAAU7ID///SvAIABE/sQ
Date: Thu, 13 Mar 2025 08:22:28 +0000
Message-ID: <c0048ea814ed46278804621753a3a78c@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
 <9ffee8119fc441aeb760073c5f152fa4@huawei.com>
 <5fcaf9ee-4c95-400d-a641-20e0f17be87b@redhat.com>
In-Reply-To: <5fcaf9ee-4c95-400d-a641-20e0f17be87b@redhat.com>
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIs
IDIwMjUgNDo0MiBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4g
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpn
Z0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207
IGJlcnJhbmdlQHJlZGhhdC5jb207IG5hdGhhbmNAbnZpZGlhLmNvbTsNCj4gbW9jaHNAbnZpZGlh
LmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5j
b20+OyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5r
dW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCB2MiAwNS8yMF0gaHcvYXJtL3NtbXV2My1hY2NlbDogQXNzb2NpYXRl
IGEgcHhiLQ0KPiBwY2llIGJ1cw0KPiANCj4gDQo+IA0KPiANCj4gT24gMy8xMi8yNSA1OjM0IFBN
LCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+IEhpIEVyaWMsDQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEyLCAyMDI1
IDQ6MDggUE0NCj4gPj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPj4gPHNoYW1l
ZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+
ID4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnOyBqZ2dAbnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gPj4gZGR1dGlsZUBy
ZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+ID4+
IG1vY2hzQG52aWRpYS5jb207IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+ID4+IDxs
aW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNv
bT47DQo+ID4+IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4g
Q2FtZXJvbg0KPiA+PiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2Fv
QGxpbmFyby5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMDUvMjBdIGh3L2Fy
bS9zbW11djMtYWNjZWw6IEFzc29jaWF0ZSBhDQo+IHB4Yi0NCj4gPj4gcGNpZSBidXMNCj4gPj4N
Cj4gPj4gSGkgU2hhbWVlciwNCj4gPj4NCj4gPj4NCj4gPj4gT24gMy8xMS8yNSAzOjEwIFBNLCBT
aGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+Pj4gVXNlcsKgbXVzdCBhc3NvY2lhdGUgYSBweGIt
cGNpZSByb290IGJ1cyB0byBzbW11djMtYWNjZWwNCj4gPj4+IGFuZCB0aGF0IGlzwqBzZXQgYXMg
dGhlIHByaW1hcnktYnVzIGZvciB0aGUgc21tdSBkZXYuDQo+ID4+IHdoeSBkbyB3ZSByZXF1aXJl
IGEgcHhiLXBjaWUgcm9vdCBidXM/IHdoeSBjYW4ndCBwY2kuMCByb290IGJ1cyBiZSB1c2VkDQo+
ID4+IGZvciBzaW1wbGVyIHVzZSBjYXNlcyAoaWUuIEkganVzdCB3YW50IHRvIHBhc3N0aG91Z2gg
YSBOSUMgaW4NCj4gPj4gYWNjZWxlcmF0ZWQgbW9kZSkuIE9yIG1heSBwY2kuMCBpcyBhbHNvIGNh
bGxlZCBhIHBheC1wY2llIHJvb3QgYnVzPw0KPiA+IFRoZSBpZGVhIHdhcyBzaW5jZSBwY2llLjAg
aXMgdGhlIGRlZmF1bHQgUkMgd2l0aCB2aXJ0LCBsZWF2ZSB0aGF0IHRvIGNhc2VzDQo+IHdoZXJl
DQo+ID4gd2Ugd2FudCB0byBhdHRhY2ggYW55IGVtdWxhdGVkIGRldmljZXMgYW5kIHVzZSBweGIt
cGNpZSBiYXNlZCBSQ3MgZm9yDQo+IHZmaW8tcGNpLg0KPiB5ZXMgYnV0IGZvciBzaW1wbGVyIHVz
ZSBjYXNlIHlvdSBtYXkgbm90IHdhbnQgdGhlIGV4dHJhIHBhaW4gdG8NCj4gaW5zdGFudGlhdGUg
YSBweGItcGNpZSBkZXZpY2UuIEFjdHVhbGx5IGxpYnZpcnQgZG9lcyBub3QgaW5zdGFudGlhdGUg
aXQNCj4gYnkgZGVmYXVsdC4NCj4gPg0KPiA+PiBCZXNpZGVzLCB3aHkgZG8gd2UgcHV0IHRoZSBj
b25zdHJhaW50IHRvIHBsdWcgb24gYSByb290IGJ1cy4gSSBrbm93IHRoYXQNCj4gPj4gYXQgdGhp
cyBwb2ludCB3ZSBhbHdheXMgcGx1ZyB0byBwY2kuMCBidXQgd2l0aCB0aGUgbmV3IC1kZXZpY2Ug
b3B0aW9uIGl0DQo+ID4+IHdvdWxkIGJlIHBvc3NpYmxlIHRvIHBsdWcgaXQgYW55d2hlcmUgaW4g
dGhlIHBjaWUgaGllcmFyY2h5LiBBdCBTT0MNCj4gPj4gbGV2ZWwgY2FuJ3QgYW4gU01NVSBiZSBw
bHVnZ2VkIGFueXdoZXJlIHByb3RlY3RpbmcganVzdCBhIGZldyBSSURzPw0KPiA+IEluIG15IHVu
ZGVyc3RhbmRpbmcgbm9ybWFsbHkob3IgYXRsZWFzdCBpbiB0aGUgbW9zdCBjb21tb24gY2FzZXMp
IGl0IGlzDQo+IGF0dGFjaGVkDQo+ID4gdG8gcm9vdCBjb21wbGV4ZXMuIEFsc28gSU9SVCBtYXBw
aW5ncyBhcmUgYXQgdGhlIHJvb3QgY29tcGxleCBsZXZlbCwNCj4gcmlnaHQ/DQo+IFllcyBJIGRv
IGFncmVlIHRoZSBJT1JUIGRlc2NyaWJlcyBJRCBtYXBwaW5ncyBiZXR3ZWVuIFJDIGFuZCBTTU1V
IGJ1dA0KPiB0aGUgYWN0dWFsIElEIG1hcHBpbmdzIGFsbG93IHlvdSB0byBiZSBtdWNoIG1vcmUg
cHJlY2lzZSBhbmQgc3RhdGUgdGhhdA0KPiBhIGdpdmVuIFNNTVUgb25seSB0cmFuc2xhdGVzIGZl
dyBSSURzIHdpdGhpbiB0aGF0IFJJRCBzcGFjZS4gSWYgeW91DQo+IGZvcmNlIHRoZSBkZXZpY2Ug
YnVzIHRvIGJlIGEgcm9vdCBidXMgeW91IGNhbid0IG1vZGVsIHRoYXQgYW55bW9yZS4NCj4NCg0K
RG8gd2UgcmVhbGx5IG5lZWQgdG8gc3VwcG9ydCB0aGF0PyBXaGF0IGlmIHRoZSB1c2VyIHRoZW4g
aGF2ZSBhbm90aGVyIHNtbXV2My1hY2NlbA0KaW4gdGhlIGFzc29jaWF0ZWQgdXBzdHJlYW0gYnVz
ZXMvUkMgYXMgd2VsbD8gTm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGF0Lg0KIA0KVGhhbmtzLA0K
U2hhbWVlcg0K

