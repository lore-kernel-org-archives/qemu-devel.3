Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF0C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 12:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgNMz-0007pS-3g; Fri, 07 Feb 2025 07:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tgNMw-0007lY-4U; Fri, 07 Feb 2025 07:22:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tgNMt-0001Vn-G7; Fri, 07 Feb 2025 07:22:01 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqChR64xqz6J7kR;
 Fri,  7 Feb 2025 20:19:35 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 745F81401F4;
 Fri,  7 Feb 2025 20:21:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 13:21:54 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 7 Feb 2025 13:21:54 +0100
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rMv66IAgAA0HqCAAb2VAIAIsUnQgAADD4CAAB6MsIAAJxaAgAATMvCAABLUAIAAAjUAgAAKIYCAAAJIgIAAAQ2AgAARRyD///K+AIAAERgA///xZoCAACSvgIAA9kUQ///0BIAABYWoYA==
Date: Fri, 7 Feb 2025 12:21:54 +0000
Message-ID: <64a4431fca6f429782a78c9740eadbe2@huawei.com>
References: <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com> <Z6T3cX_fM-aeYbMI@redhat.com>
 <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
 <20250206182201.GL2960738@nvidia.com> <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
 <9112ba0694bd42199e279e37fbfc9dd0@huawei.com> <Z6XhF7VTw9jnIXCb@redhat.com>
In-Reply-To: <Z6XhF7VTw9jnIXCb@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSA3LCAy
MDI1IDEwOjMyIEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxp
LmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IENjOiBOaWNvbGluIENoZW4gPG5pY29saW5j
QG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUNCj4gPGpnZ0BudmlkaWEuY29tPjsgcWVtdS1h
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBlcmljLmF1Z2VyQHJlZGhh
dC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiBM
aW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA8d2FuZ3pob3Ux
QGhpc2lsaWNvbi5jb20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47DQo+
IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IHpoYW5n
ZmVpLmdhb0BsaW5hcm8ub3JnOyBuYXRoYW5jQG52aWRpYS5jb20NCj4gU3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggMC81XSBody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVzZXItY3JlYXRhYmxl
DQo+IG5lc3RlZCBTTU1VdjMNCj4gDQo+IE9uIEZyaSwgRmViIDA3LCAyMDI1IGF0IDEwOjIxOjE3
QU0gKzAwMDAsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gd3JvdGU6DQo+ID4NCj4gPg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE5pY29saW4gQ2hl
biA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2
LCAyMDI1IDg6MzMgUE0NCj4gPiA+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+ID4g
PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgRGFuaWVsIFAuIEJlcnJh
bmfDqQ0KPiA+ID4gPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0Bu
dmlkaWEuY29tPg0KPiA+ID4gQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsNCj4gPiA+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207DQo+ID4gPiBMaW51eGFybSA8bGludXhhcm1A
aHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA+ID4gPHdhbmd6aG91MUBoaXNpbGljb24uY29t
PjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0KPiA+ID4gSm9uYXRoYW4g
Q2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gPiA+IHpoYW5nZmVpLmdh
b0BsaW5hcm8ub3JnOyBuYXRoYW5jQG52aWRpYS5jb20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZD
IFBBVENIIDAvNV0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1c2VyLQ0KPiBjcmVhdGFi
bGUNCj4gPiA+IG5lc3RlZCBTTU1VdjMNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEZlYiAwNiwgMjAy
NSBhdCAwMjoyMjowMVBNIC0wNDAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPiA+IE9u
IFRodSwgRmViIDA2LCAyMDI1IGF0IDA2OjE4OjE0UE0gKzAwMDAsIFNoYW1lZXJhbGkgS29sb3Ro
dW0NCj4gVGhvZGkNCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gU28gZXZlbiBp
ZiB5b3UgaW52ZW50IGFuIGlvbW11IElEIHdlIGNhbm5vdCBhY2NlcHQgaXQgYXMgYSBoYW5kbGUN
Cj4gdG8NCj4gPiA+ID4gPiA+IGNyZWF0ZSB2aW9tbXUgaW4gaW9tbXVmZC4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IENyZWF0aW5nIHRoZSB2SU9NTVUgb25seSBoYXBwZW5zIHdoZW4gdGhlIHVzZXIg
ZG9lcyBhICBjb2xkL2hvdA0KPiA+ID4gcGx1ZyBvZg0KPiA+ID4gPiA+IGEgVkZJTyBkZXZpY2Uu
IEF0IHRoYXQgdGltZSBRZW11IGNoZWNrcyB3aGV0aGVyIHRoZSBhc3NpZ25lZCBpZA0KPiA+ID4g
bWF0Y2hlcw0KPiA+ID4gPiA+IHdpdGggd2hhdGV2ZXIgdGhlIGtlcm5lbCB0ZWxsIGl0Lg0KPiA+
ID4gPg0KPiA+ID4gPiBUaGlzIGlzIG5vdCBoYXJkIHVwIHVudGlsIHRoZSBndWVzdCBpcyBzdGFy
dGVkLiBJZiB5b3UgYm9vdCBhIGd1ZXN0DQo+ID4gPiA+IHdpdGhvdXQgYSBiYWNraW5nIHZpb21t
dSBpb21tdWZkIG9iamVjdCB0aGVuIHRoZXJlIHdpbGwgYmUgc29tZQ0KPiBtb3JlDQo+ID4gPiA+
IGNvbXBsZXhpdGllcy4NCj4gPiA+DQo+ID4gPiBZZWEsIEkgaW1hZ2luZWQgdGhhdCB0aGluZ3Mg
d291bGQgYmUgY29tcGxpY2F0ZWQgd2l0aCBob3RwbHVncy4uDQo+ID4gPg0KPiA+ID4gT24gb25l
IGhhbmQsIEkgZ290IHRoZSBwYXJ0IHRoYXQgd2UgbmVlZCBzb21lIGZpeGVkIGxpbmsgZm9yZWhh
bmQNCj4gPiA+IHRvIGVhc2UgbWlncmF0aW9uL2hvdHBsdWdzLg0KPiA+ID4NCj4gPiA+IE9uIHRo
ZSBvdGhlciBoYW5kLCBhbGwgSU9NTVVGRCBpb2N0bHMgbmVlZCBhIFZGSU8gZGV2aWNlIEZELCB3
aGljaA0KPiA+ID4gYnJpbmdzIHRoZSBpbW1lZGlhdGUgYXR0ZW50aW9uIHRoYXQgd2UgY2Fubm90
IGV2ZW4gZGVjaWRlIHZTTU1VJ3MNCj4gPiA+IGNhcGFiaWxpdGllcyBiZWluZyByZWZsZWN0ZWQg
aW4gaXRzIElEUi9JSURSIHJlZ2lzdGVycywgd2l0aG91dCBhDQo+ID4gPiBjb2xkcGx1ZyBkZXZp
Y2UgLS0gaWYgd2UgYm9vdCBhIFZNIChvbmUgdlNNTVU8LT5wU01NVSkgd2l0aCBvbmx5IGENCj4g
PiA+IGhvdHBsdWcgZGV2aWNlLCB0aGUgSU9NTVVfR0VUX0hXX0lORk8gY2Fubm90IGJlIGRvbmUg
ZHVyaW5nDQo+IGd1ZXN0DQo+ID4NCj4gPiBSaWdodC4gSSBmb3Jnb3QgYWJvdXQgdGhlIGNhbGwg
dG8gc21tdV9kZXZfZ2V0X2luZm8oKSBkdXJpbmcgdGhlIHJlc2V0Lg0KPiA+IFRoYXQgbWVhbnMg
d2UgbmVlZCBhdCBsZWFzdCBvbmUgZGV2IHBlciBHdWVzdCBTTU1VIGR1cmluZyBHdWVzdA0KPiA+
IGJvb3QgOigNCj4gDQo+IFRoYXQncyBwcmV0dHkgdW5wbGVhc2FudCBhcyBhIHVzYWdlIHJlc3Ry
aWN0aW9uLiBJdCBzb3VuZHMgbGlrZSB0aGVyZQ0KPiBuZWVkcyB0byBiZSBhIHdheSB0byBjb25m
aWd1cmUgJiBjb250cm9sIHRoZSB2SU9NTVUgaW5kZXBlbmRhbnRseSBvZg0KPiBhdHRhY2hpbmcg
YSBzcGVjaWZpYyBWRklPIGRldmljZS4NCg0KWWVzLCB0aGF0IHdvdWxkIGJlIGlkZWFsLiAgDQoN
Ckp1c3Qgd29uZGVyaW5nIHdoZXRoZXIgd2UgY2FuIGhhdmUgc29tZXRoaW5nIGxpa2UgdGhlDQp2
ZmlvX3JlZ2lzdGVyX2lvbW11X2RyaXZlcigpIGZvciBpb21tdWZkIHN1YnN5c3RlbSBieSB3aGlj
aCBpdCBjYW4gZGlyZWN0bHkNCmFjY2VzcyBpb21tdSBkcml2ZXJzIG9wcyhtYXkgYmUgYSByZXN0
cmljdGVkIHNldCkuIA0KDQpOb3Qgc3VyZSBhYm91dCB0aGUgbGF5ZXJpbmcgdmlvbGF0aW9ucyBh
bmQgb3RoZXIgc2VjdXJpdHkgaXNzdWVzIHdpdGggdGhhdC4uLg0KDQpUaGFua3MsDQpTaGFtZWVy
DQoNCg==

