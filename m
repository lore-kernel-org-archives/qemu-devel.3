Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2460AC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 09:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAQMR-0000jD-RO; Thu, 01 May 2025 05:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uAQMP-0000iQ-6x; Thu, 01 May 2025 05:37:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uAQMM-00071D-19; Thu, 01 May 2025 05:37:40 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zp86Z60cFz67Zs4;
 Thu,  1 May 2025 17:35:18 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id D96B11403A8;
 Thu,  1 May 2025 17:37:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 May 2025 11:37:26 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 1 May 2025 11:37:26 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Donald Dutile
 <ddutile@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH 0/5] Add support for user creatable SMMUv3 device
Thread-Topic: [PATCH 0/5] Add support for user creatable SMMUv3 device
Thread-Index: AQHbrd5Z6XfidS8N/U6PO20X8QxpSbOpxUQAgAWkbCCACfM5gIADFckAgAEqLPA=
Date: Thu, 1 May 2025 09:37:26 +0000
Message-ID: <42c4d5b8f755433391ea0c87ca259910@huawei.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <84870c74-f078-48c5-bead-96db1d582987@redhat.com>
 <8f7cc59e3745407bb7ae3d875cf97ae0@huawei.com>
 <7446ba2c-0dbb-44dc-9e48-300f431dcf85@redhat.com>
 <a37de640-1b6f-4b95-8ba0-ce7b78c10418@redhat.com>
In-Reply-To: <a37de640-1b6f-4b95-8ba0-ce7b78c10418@redhat.com>
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
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMzAs
IDIwMjUgNjo0OCBQTQ0KPiBUbzogRG9uYWxkIER1dGlsZSA8ZGR1dGlsZUByZWRoYXQuY29tPjsg
U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBo
dWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29tOyBuaWNvbGlu
Y0BudmlkaWEuY29tOw0KPiBiZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207
IG1vY2hzQG52aWRpYS5jb207DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtIDxsaW51
eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpDQo+IDx3YW5nemhvdTFAaGlzaWxpY29uLmNv
bT47IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsNCj4gSm9uYXRoYW4gQ2Ft
ZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gemhhbmdmZWkuZ2FvQGxpbmFy
by5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzVdIEFkZCBzdXBwb3J0IGZvciB1c2VyIGNy
ZWF0YWJsZSBTTU1VdjMgZGV2aWNlDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNC8yOC8y
NSA4OjQxIFBNLCBEb25hbGQgRHV0aWxlIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiA0LzIyLzI1
IDQ6NTcgQU0sIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3JvdGU6DQo+ID4+DQo+ID4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogRG9uYWxkIER1dGlsZSA8ZGR1
dGlsZUByZWRoYXQuY29tPg0KPiA+Pj4gU2VudDogRnJpZGF5LCBBcHJpbCAxOCwgMjAyNSA5OjM0
IFBNDQo+ID4+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA+Pj4gPHNoYW1lZXJh
bGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+ID4+
PiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPj4+IENjOiBlcmljLmF1Z2VyQHJlZGhhdC5jb207
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+ID4+PiBuaWNvbGlu
Y0BudmlkaWEuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+
ID4+PiBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA+
Pj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGlj
b24uY29tPjsNCj4gPj4+IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9u
YXRoYW4gQ2FtZXJvbg0KPiA+Pj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IHpoYW5n
ZmVpLmdhb0BsaW5hcm8ub3JnDQo+ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNV0gQWRkIHN1
cHBvcnQgZm9yIHVzZXIgY3JlYXRhYmxlIFNNTVV2Mw0KPiBkZXZpY2UNCj4gPj4+DQo+ID4+PiBT
aGFtZWVyLA0KPiA+Pj4gSGkhDQo+ID4+Pg0KPiA+Pj4gRmlyc3Qgb2ZmLCBsaWtlIHRoZSBwYXJ0
aXRpb25pbmcgb2YgdGhlc2UgcGllY2VzLg0KPiA+Pj4NCj4gPj4+IE9uIDQvMTUvMjUgNDoxMCBB
TSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPj4+PiBIaSBBbGwsDQo+ID4+Pj4NCj4gPj4+
PiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIHN1cHBvcnQgZm9yIGEgdXNlci1jcmVhdGFi
bGUgU01NVXYzDQo+ID4+Pj4gZGV2aWNlDQo+ID4+Pj4gKC1kZXZpY2UgYXJtLXNtbXV2My1kZXYp
IGluIFFFTVUuDQo+ID4+Pj4NCj4gPj4+IENhbiB3ZSBkcm9wIHRoZSAnLWRldicsIGFzICdhcm0t
c21tdScgaXMgc3VmZmljaWVudCwgYXMgaXMgJy1kZXZpY2UnPw0KPiA+Pj4NCj4gPj4+IEkga25v
dywgaW50ZXJuYWwgdG8gUUVNVSwgdGhlcmUncyBhbHJlYWR5IGFuIEFSTV9TTU1VLCBidXQgYXMN
Cj4gc3VnZ2VzdGVkDQo+ID4+PiBsYXRlciwNCj4gPj4+IGlmIGl0IHVzZXMgdGhlIHNhbWUgc3Ry
dWN0LCB0aGUgcWVtdSBjbWRsaW5lIHN5bnRheCBpcyBhIGJpdCBsZXNzDQo+ID4+PiByZWR1bmRh
bnQuDQo+ID4+DQo+ID4+IFRydXN0IG1lIEkgdHJpZWQgdGhhdPCfmIouIFRoZSBwcm9ibGVtIGlz
IHRoYXQsIHRoZSBsZWdhY3kgb25lIGRvZXNuJ3QNCj4gPj4gaGF2ZSBhIGJ1cw0KPiA+PiBhc3Nv
Y2lhdGVkIHdpdGggaXQgYW5kIHRoZSBtb21lbnQgd2UgY2hhbmdlIHRoYXQgYW5kIGhhdmUgYnVz
DQo+ID4+IHNwZWNpZmllZCBmb3IgdGhlDQo+ID4+IMKgICItZGV2aWNlIGFybS1zbW11djMsIGJ1
cz1wY2llLjAiIHRoZSBsZWdhY3kgc21tdXYzIGNyZWF0aW9uIGluIHZpcnQsDQo+ID4+DQo+ID4+
IGNyZWF0ZV9zbW11KCkgLS0+IHFkZXZfbmV3KFRZUEVfQVJNX1NNTVVWMykNCj4gSSBoYXZlIHRo
ZSBpbXByZXNzaW9uIHlvdSBjYW4gYWNoaWV2ZSB5b3VyIGdvYWwgYnkgcmVwbGFjaW5nDQo+IHN5
c2J1c19yZWFsaXplX2FuZF91bnJlZihTWVNfQlVTX0RFVklDRShkZXYpLCAmZXJyb3JfZmF0YWwp
Ow0KPiBieQ0KPiBxZGV2X3JlYWxpemVfYW5kX3VucmVmKGRldiwgJmJ1cy0+cWJ1cywgJmVycm9y
X2ZhdGFsKTsNCj4gU2VlIGh0dHBzOi8vZ2l0aHViLmNvbS9lYXVnZXIvcWVtdS90cmVlL2FybS1z
bW11djMtZGV2LXJjMA0KDQpDb29sIS4gVGhhdCBkb2VzIHRoZSB0cmljay4gVGhhbmtzLg0KIA0K
PiBhbmQgaXRzIHRvcCBwYXRjaC4NCj4gDQo+IGluZGVlZCBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYg
d2UgY291bGQgcmV1c2UgdGhlIHNhbWUgZGV2aWNlLg0KDQpJIHdpbGwgcmVzcGluIHNvb24gd2l0
aCB0aGUgYWJvdmUgYW5kIGFkZHJlc3Npbmcgb3RoZXIgY29tbWVudHMgcmVjZWl2ZWQuDQoNClRo
YW5rcywNClNoYW1lZXINCg0K

