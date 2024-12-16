Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DABE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 10:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7vD-0001hJ-40; Mon, 16 Dec 2024 05:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tN7v3-0001fS-Fv; Mon, 16 Dec 2024 05:01:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tN7uy-0006PB-ER; Mon, 16 Dec 2024 05:01:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBb1x2QlPz6K6Vx;
 Mon, 16 Dec 2024 17:56:37 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 3FBB1140D26;
 Mon, 16 Dec 2024 18:01:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Dec 2024 11:01:29 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 16 Dec 2024 11:01:29 +0100
To: Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeg
Date: Mon, 16 Dec 2024 10:01:29 +0000
Message-ID: <329445b2f68a47269292aefb34584375@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
In-Reply-To: <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDEzLCAy
MDI0IDE6MzMgUE0NCj4gVG86IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+IENj
OiBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPjsgU2hhbWVlcmFsaSBL
b2xvdGh1bQ0KPiBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsg
cWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gcWVtdS1kZXZlbEBub25nbnUub3JnOyBlcmljLmF1Z2Vy
QHJlZGhhdC5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsg
TGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikNCj4gPHdhbmd6aG91
MUBoaXNpbGljb24uY29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0K
PiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiB6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzVdIGh3L2Fy
bS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNlci1jcmVhdGFibGUNCj4gbmVzdGVkIFNNTVV2Mw0K
PiANCj4gT24gRnJpLCAxMyBEZWMgMjAyNCBhdCAxMjo0NiwgSmFzb24gR3VudGhvcnBlIDxqZ2dA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIERlYyAxMywgMjAyNCBhdCAxMjow
MDo0M1BNICswMDAwLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBO
b3YgMDgsIDIwMjQgYXQgMTI6NTI6MzdQTSArMDAwMCwgU2hhbWVlciBLb2xvdGh1bSB2aWEgd3Jv
dGU6DQo+ID4gPiA+IEhpLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHNlcmllcyBhZGRzIGluaXRp
YWwgc3VwcG9ydCBmb3IgYSB1c2VyLWNyZWF0YWJsZSAiYXJtLXNtbXV2My0NCj4gbmVzdGVkIg0K
PiA+ID4gPiBkZXZpY2UgdG8gUWVtdS4gQXQgcHJlc2VudCB0aGUgUWVtdSBBUk0gU01NVXYzIGVt
dWxhdGlvbiBpcyBwZXINCj4gbWFjaGluZQ0KPiA+ID4gPiBhbmQgY2Fubm90IHN1cHBvcnQgbXVs
dGlwbGUgU01NVXYzcy4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gb3JkZXIgdG8gc3VwcG9ydCB2Zmlv
LXBjaSBkZXYgYXNzaWdubWVudCB3aXRoIHZTTU1VdjMsIHRoZQ0KPiBwaHlzaWNhbA0KPiA+ID4g
PiBTTU1VdjMgaGFzIHRvIGJlIGNvbmZpZ3VyZWQgaW4gbmVzdGVkIG1vZGUuIEhhdmluZyBhIHBs
dWdnYWJsZQ0KPiA+ID4gPiAiYXJtLXNtbXV2My1uZXN0ZWQiIGRldmljZSBlbmFibGVzIHVzIHRv
IGhhdmUgbXVsdGlwbGUgdlNNTVV2Mw0KPiBmb3IgR3Vlc3RzDQo+ID4gPiA+IHJ1bm5pbmcgb24g
YSBob3N0IHdpdGggbXVsdGlwbGUgcGh5c2ljYWwgU01NVXYzcy4gQSBmZXcgYmVuZWZpdHMgb2YN
Cj4gZG9pbmcNCj4gPiA+ID4gdGhpcyBhcmUsDQo+ID4gPg0KPiA+ID4gSSdtIG5vdCB2ZXJ5IGZh
bWlsaWFyIHdpdGggYXJtLCBidXQgZnJvbSB0aGlzIGRlc2NyaXB0aW9uIEknbSBub3QNCj4gPiA+
IHJlYWxseSBzZWVpbmcgaG93ICJuZXN0aW5nIiBpcyBpbnZvbHZlZCBoZXJlLiBZb3UncmUgb25s
eSB0YWxraW5nDQo+ID4gPiBhYm91dCB0aGUgaG9zdCBhbmQgMSBMMSBndWVzdCwgbm8gTDIgZ3Vl
c3QuDQo+ID4NCj4gPiBuZXN0aW5nIGlzIHRoZSB0ZXJtIHRoZSBpb21tdSBzaWRlIGlzIHVzaW5n
IHRvIHJlZmVyIHRvIHRoZSAyDQo+ID4gZGltZW5zaW9uYWwgcGFnaW5nLCBpZSBhIGd1ZXN0IHBh
Z2UgdGFibGUgb24gdG9wIG9mIGEgaHlwZXJ2aXNvciBwYWdlDQo+ID4gdGFibGUuDQo+IA0KPiBJ
c24ndCB0aGF0IG1vcmUgdXN1YWxseSBjYWxsZWQgInR3byBzdGFnZSIgcGFnaW5nPyBDYWxsaW5n
DQo+IHRoYXQgIm5lc3RpbmciIHNlZW1zIGxpa2UgaXQgaXMgZ29pbmcgdG8gYmUgbWFzc2l2ZWx5
IGNvbmZ1c2luZy4uLg0KDQpZZXMuIFRoaXMgd2lsbCBiZSByZW5hbWVkIGluIGZ1dHVyZSByZXZp
c2lvbnMgYXMgYXJtLXNtbXV2My1hY2NlbC4NCg0KPiANCj4gQWxzbywgaG93IGRvZXMgaXQgcmVs
YXRlIHRvIHdoYXQgdGhpcyBzZXJpZXMgc2VlbXMgdG8gYmUNCj4gZG9pbmcsIHdoZXJlIHdlIHBy
b3ZpZGUgdGhlIGd1ZXN0IHdpdGggdHdvIHNlcGFyYXRlIFNNTVVzPw0KPiAoQXJlIHRob3NlIHR3
byBTTU1VcyAibmVzdGVkIiBpbiB0aGUgc2Vuc2UgdGhhdCBvbmUgaXMgc2l0dGluZw0KPiBiZWhp
bmQgdGhlIG90aGVyPykNCg0KSSBkb24ndCB0aGluayBpdCByZXF1aXJlcyB0d28gU01NVXMgaW4g
R3Vlc3QuIFRoZSBuZXN0ZWQgb3IgInR3bw0Kc3RhZ2UiIG1lYW5zIHRoZSBzdGFnZSAxIHBhZ2Ug
dGFibGUgaXMgb3duZWQgYnkgR3Vlc3QgYW5kIHN0YWdlIDINCmJ5IGhvc3QuIEFuZCB0aGlzIGlz
IGFjaGlldmVkIGJ5IElPTU1VRkQgcHJvdmlkZWQgSU9DVExzLiANCg0KVGhlcmUgaXMgYSBwcmVj
dXJzZXIgdG8gdGhpcyBzZXJpZXMgd2hlcmUgdGhlIHN1cHBvcnQgZm9yIGh3IGFjY2VsZXJhdGVk
DQoyIHN0YWdlIHN1cHBvcnQgaXMgYWRkZWQgaW4gUWVtdSBTTU1VdjMgY29kZS4NCg0KUGxlYXNl
IHNlZSB0aGUgY29tcGxldGUgYnJhbmNoIGhlcmUsDQpodHRwczovL2dpdGh1Yi5jb20vaGlzaWxp
Y29uL3FlbXUvY29tbWl0cy9wcml2YXRlLXNtbXV2My1uZXN0ZWQtZGV2LXJmYy12MS8NCkFuZCBw
YXRjaGVzIHByaW9yIHRvIHRoaXMgY29tbWl0IGFkZHMgdGhhdCBzdXBwb3J0OiANCjRjY2RiZTM6
ICgiY292ZXItbGV0dGVyOiBBZGQgSFcgYWNjZWxlcmF0ZWQgbmVzdGluZyBzdXBwb3J0IGZvciBh
cm0NClNNTVV2MyIpDQoNCk5pY29saW4gaXMgc29vbiBnb2luZyB0byBzZW5kIG91dCB0aG9zZSBm
b3IgcmV2aWV3LiBPciBJIGNhbiBpbmNsdWRlDQp0aG9zZSBpbiB0aGlzIHNlcmllcyBzbyB0aGF0
IGl0IGdpdmVzIGEgY29tcGxldGUgcGljdHVyZS4gTmljb2xpbj8NCg0KSG9wZSB0aGlzIGNsYXJp
ZmllcyBhbnkgY29uZnVzaW9uLg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg0KDQo=

