Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85358C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcR0x-00063V-P4; Mon, 27 Jan 2025 10:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tcR0f-0005xL-4y; Mon, 27 Jan 2025 10:26:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tcR0c-0003a0-Ji; Mon, 27 Jan 2025 10:26:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhXJm6w1lz6L51M;
 Mon, 27 Jan 2025 23:24:24 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 940DF1400D4;
 Mon, 27 Jan 2025 23:26:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 16:26:34 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 27 Jan 2025 16:26:34 +0100
To: Nathan Chen <nathanc@nvidia.com>
CC: "ddutile@redhat.com" <ddutile@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rK0OI0AgAyjUACAIpIKgIAAEq8AgAVS2bCAPl33AIAECLLQ
Date: Mon, 27 Jan 2025 15:26:34 +0000
Message-ID: <0b281d2f8ebf4368b7e7b97aa0a4cfd3@huawei.com>
References: <31db1f75110e46ccaffffb801e894605@huawei.com>
 <a80c78fd-6203-4aca-a3d3-d67a68b8e595@nvidia.com>
In-Reply-To: <a80c78fd-6203-4aca-a3d3-d67a68b8e595@nvidia.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoZW4gPG5h
dGhhbmNAbnZpZGlhLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgMjUsIDIwMjUgMjo0
NCBBTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogZGR1dGlsZUByZWRoYXQuY29tOyBlcmljLmF1Z2Vy
QHJlZGhhdC5jb207IGpnZ0BudmlkaWEuY29tOw0KPiBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5A
aHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2Vp
LmNvbT47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gbmF0aGFuY0BudmlkaWEu
Y29tOyBuaWNvbGluY0BudmlkaWEuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7DQo+IHFl
bXUtYXJtQG5vbmdudS5vcmc7IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+
Ow0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IFN1
YmplY3Q6IFJFOiBbUkZDIFBBVENIIDAvNV0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1
c2VyLWNyZWF0YWJsZQ0KPiBuZXN0ZWQgU01NVXYzDQo+IA0KPiA+PiAgPndpdGggYW4gZXJyb3Ig
bWVzc2FnZSBpbmRpY2F0aW5nIERNQSBtYXBwaW5nIGZhaWxlZCBmb3IgdGhlDQo+ID4+IHBhc3N0
aHJvdWdoID5kZXZpY2VzLg0KPiA+Pg0KPiA+PiBBIGNvcnJlY3Rpb24gLSB0aGUgbWVzc2FnZSBp
bmRpY2F0ZXMgVUVGSSBmYWlsZWQgdG8gZmluZCBhIG1hcHBpbmcgZm9yDQo+ID4+IHRoZSBib290
IHBhcnRpdGlvbiAoIm1hcDogbm8gbWFwcGluZyBmb3VuZCIpLCBub3QgdGhhdCBETUEgbWFwcGlu
Zw0KPiA+PiBmYWlsZWQuIEJ1dCBlYXJsaWVyIEVESyBkZWJ1ZyBsb2dzIHN0aWxsIHNob3cgUENJ
IGhvc3QgYnJpZGdlIHJlc291cmNlDQo+ID4+IGNvbmZsaWN0cyBmb3IgdGhlIHBhc3N0aHJvdWdo
IGRldmljZXMgdGhhdCBzZWVtIHJlbGF0ZWQgdG8gdGhlIFZNIGJvb3QNCj4gPj4gZmFpbHVyZS4N
Cj4gPg0KPiA+IEkgaGF2ZSB0cmllZCBhIDIwMjMgdmVyc2lvbiBFRkkgd2hpY2ggd29ya3MuIEFu
ZCBmb3IgbW9yZSByZWNlbnQgdGVzdHMgSQ0KPiBhbQ0KPiA+IHVzaW5nIGEgb25lIGJ1aWx0IGRp
cmVjdGx5IGZyb20sDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3RpYW5vY29yZS9lZGsyLmdpdCBt
YXN0ZXINCj4gPg0KPiA+IENvbW1pdDogMGYzODY3ZmE2ZWYwKCJVZWZpUGF5bG9hZFBrZy9VZWZp
UGF5bG9hZEVudHJ5OiBGaXggUFQNCj4gcHJvdGVjdGlvbg0KPiA+IGluIDUgbGV2ZWwgcGFnaW5n
Ig0KPiA+DQo+ID4gV2l0aCBib3RoLCBJIGRvbuKAmXQgcmVtZW1iZXIgc2VlaW5nIGFueSBib290
IGZhaWx1cmUgYW5kIHRoZSBhYm92ZSBVRUZJDQo+ID4gcmVsYXRlZCAibWFwOiBubyBtYXBwaW5n
IGZvdW5kIiBlcnJvci4gQnV0IHRoZSBHdWVzdCBrZXJuZWwgYXQgdGltZXMNCj4gPiBjb21wbGFp
bnRzIGFib3V0IHBjaSBicmlkZ2Ugd2luZG93IG1lbW9yeSBhc3NpZ25tZW50IGZhaWx1cmVzLg0K
PiA+IC4uLg0KPiA+IHBjaSAwMDAwOjEwOjAxLjA6IGJyaWRnZSB3aW5kb3cgW21lbSBzaXplIDB4
MDAyMDAwMDAgNjRiaXQgcHJlZl06IGNhbid0DQo+IGFzc2lnbjsgbm8gc3BhY2UNCj4gPiBwY2kg
MDAwMDoxMDowMS4wOiBicmlkZ2Ugd2luZG93IFttZW0gc2l6ZSAweDAwMjAwMDAwIDY0Yml0IHBy
ZWZdOiBmYWlsZWQNCj4gdG8gYXNzaWduDQo+ID4gcGNpIDAwMDA6MTA6MDAuMDogYnJpZGdlIHdp
bmRvdyBbaW8gIHNpemUgMHgxMDAwXTpjYW4ndCBhc3NpZ247IG5vIHNwYWNlDQo+ID4gLi4uDQo+
ID4NCj4gPiBCdXQgR3Vlc3Qgc3RpbGwgYm9vdHMgYW5kIHdvcmtlZCBmaW5lIHNvIGZhci4NCj4g
DQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBKdXN0IGxldHRpbmcgeW91IGtub3cgSSByZXNvbHZlZCB0
aGlzIGJ5IGluY3JlYXNpbmcgdGhlIE1NSU8gcmVnaW9uIHNpemUNCj4gaW4gaHcvYXJtL3ZpcnQu
YyB0byBzdXBwb3J0IHBhc3NpbmcgdGhyb3VnaCBHUFVzIHdpdGggbGFyZ2UgQkFSIHJlZ2lvbnMN
Cj4gKFZJUlRfSElHSF9QQ0lFX01NSU8pLiBUaGFua3MgZm9yIHRha2luZyBhIGxvb2suDQo+IA0K
DQpPay4gVGhhbmtzIGZvciB0aGF0LiBEb2VzIHRoYXQgbWVhbiBtYXkgYmUgYW4gb3B0aW9uYWwg
cHJvcGVydHkgdG8gc3BlY2lmeQ0KdGhlIHNpemUgZm9yIFZJUlRfSElHSF9QQ0lFX01NSU8gaXMg
d29ydGggYWRkaW5nPw0KDQpBbmQgZm9yIHRoZSBQQ0kgYnJpZGdlIHdpbmRvdyBzcGVjaWZpYyBl
cnJvcnMgdGhhdCBJIG1lbnRpb25lZCBhYm92ZSwNCg0KPj5wY2kgMDAwMDoxMDowMS4wOiBicmlk
Z2Ugd2luZG93IFttZW0gc2l6ZSAweDAwMjAwMDAwIDY0Yml0IHByZWZdOiBjYW4ndCBhc3NpZ247
IG5vIHNwYWNlDQoNCmFkZGluZyAgIiJtZW0tcmVzZXJ2ZT1YIiBhbmQgImlvLXJlc2VydmU9WCIg
dG8gcGNpZS1yb290LXBvcnQgaGVscHMuDQoNClRoYW5rcywNClNoYW1lZXINCg0KDQo=

