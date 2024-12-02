Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6C7D10DBC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 08:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI1To-0005n7-3F; Mon, 02 Dec 2024 03:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tI1T2-0005ZZ-2S; Mon, 02 Dec 2024 03:07:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tI1Su-0002gP-Un; Mon, 02 Dec 2024 03:07:36 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y1xFQ5ztkz6LCCZ;
 Mon,  2 Dec 2024 16:06:34 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 794BD14034E;
 Mon,  2 Dec 2024 16:07:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 09:07:15 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 2 Dec 2024 09:07:15 +0100
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Mostafa Saleh <smostafa@google.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peter Maydell" <peter.maydell@linaro.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "arighi@nvidia.com" <arighi@nvidia.com>,
 "ianm@nvidia.com" <ianm@nvidia.com>, "jan@nvidia.com" <jan@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>
Subject: RE: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Topic: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Index: AQHbLBPkDYWW/RlwrUqSJByfpx0jw7KiQNeAgDBWeACAADJP0A==
Date: Mon, 2 Dec 2024 08:07:14 +0000
Message-ID: <8f9d105371be44f1a1f6ba0f268d8c68@huawei.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <20241101115501.GS10193@nvidia.com>
 <CABQgh9E3ba1F_4bTxkzRmt0sDmyVR+hbxocnqSvrvwerFZwiug@mail.gmail.com>
In-Reply-To: <CABQgh9E3ba1F_4bTxkzRmt0sDmyVR+hbxocnqSvrvwerFZwiug@mail.gmail.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAyLCAyMDI0
IDY6MDUgQU0NCj4gVG86IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+IENjOiBO
aWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBTaGFtZWVyYWxpIEtvbG90aHVtIFRo
b2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBFcmljIEF1Z2Vy
DQo+IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+OyBNb3N0YWZhIFNhbGVoIDxzbW9zdGFmYUBnb29n
bGUuY29tPjsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgSmVhbi1QaGlsaXBw
ZSBCcnVja2VyIDxqZWFuLQ0KPiBwaGlsaXBwZUBsaW5hcm8ub3JnPjsgTW9yaXR6IEZpc2NoZXIg
PG1kZkBrZXJuZWwub3JnPjsgTWljaGFlbCBTaGF2aXQNCj4gPG1zaGF2aXRAZ29vZ2xlLmNvbT47
IEFuZHJlYSBCb2xvZ25hbmkgPGFib2xvZ25hQHJlZGhhdC5jb20+Ow0KPiBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPjsgUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPjsNCj4g
bmF0aGFuY0BudmlkaWEuY29tOyBhcmlnaGlAbnZpZGlhLmNvbTsgaWFubUBudmlkaWEuY29tOw0K
PiBqYW5AbnZpZGlhLmNvbTsgbW9jaHNAbnZpZGlhLmNvbQ0KPiBTdWJqZWN0OiBSZTogbmVzdGVk
LXNtbXV2MyB0b3BpYyBmb3IgUUVNVS9saWJ2aXJ0LCBOb3YgMjAyNA0KPiANCj4gSGksIE5pY28N
Cj4gDQo+IE9uIEZyaSwgMSBOb3YgMjAyNCBhdCAxOTo1NSwgSmFzb24gR3VudGhvcnBlIDxqZ2dA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIE9jdCAzMSwgMjAyNCBhdCAwOTow
OToyMFBNIC0wNzAwLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4NCj4gPiA+IEZXSVcsIFJvYmlu
IHJlcXVlc3RlZCBhIGRpZmZlcmVudCBzb2x1dGlvbiBmb3IgTVNJIG1hcHBpbmcgWzFdLCB2LnMu
DQo+ID4gPiB0aGUgUk1SIG9uZSB0aGF0IHdlIGhhdmUgYmVlbiB1c2luZyBzaW5jZSBFcmljJ3Mg
d29yay4gSSBkcmFmdGVkIGENCj4gPiA+IGZldyBWRklPL0lPTU1VRkQgcGF0Y2hlcyBmb3IgdGhh
dCwNCj4gPg0KPiA+IEkgYWxzbyB0YWxrZWQgdG8gTWFyY1ogYWJvdXQgdGhpcyBhdCBMUEMgYW5k
IGhlIHNlZW1zIHdpbGxpbmcgdG8NCj4gPiBjb25zaWRlciBpdC4gSXQgdG9vayBhIGJpdCB0byBl
eHBsYWluIGV2ZXJ5dGhpbmcgdGhvdWdoLiBTbyBJIHRoaW5rIHdlDQo+ID4gc2hvdWxkIHRyeSBp
biBOb3YvRGVjDQo+IA0KPiBXaGVuIGJvb3QgcWVtdSwgcmVwb3J0cyB0aGlzDQo+IA0KPiBxZW11
LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiBJT01NVV9JT0FTX01BUCBmYWlsZWQ6IEJhZCBhZGRy
ZXNzLCBQQ0kNCj4gQkFSPw0KPiBxZW11LXN5c3RlbS1hYXJjaDY0OiB2ZmlvX2NvbnRhaW5lcl9k
bWFfbWFwKDB4YWFhYWRkMzBmMTEwLA0KPiAweDgwMDAyMDAwMDAsIDB4MTAwMDAsIDB4ZmZmZmI4
MDMxMDAwKSA9IC0xNCAoQmFkIGFkZHJlc3MpDQo+IHFlbXUtc3lzdGVtLWFhcmNoNjQ6IHdhcm5p
bmc6IElPTU1VX0lPQVNfTUFQIGZhaWxlZDogQmFkIGFkZHJlc3MsIFBDSQ0KPiBCQVI/DQo+IHFl
bXUtc3lzdGVtLWFhcmNoNjQ6IHZmaW9fY29udGFpbmVyX2RtYV9tYXAoMHhhYWFhZGQyYmMzMTAs
DQo+IDB4ODAwMDIwMDAwMCwgMHgxMDAwMCwgMHhmZmZmYjgwMzEwMDApID0gLTE0IChCYWQgYWRk
cmVzcykNCj4gcWVtdS1zeXN0ZW0tYWFyY2g2NDogd2FybmluZzogSU9NTVVfSU9BU19NQVAgZmFp
bGVkOiBCYWQgYWRkcmVzcywgUENJDQo+IEJBUj8NCj4gcWVtdS1zeXN0ZW0tYWFyY2g2NDogdmZp
b19jb250YWluZXJfZG1hX21hcCgweGFhYWFkY2Y5MDAwMCwNCj4gMHg4MDAwMjAwMDAwLCAweDEw
MDAwLCAweGZmZmZiODAzMTAwMCkgPSAtMTQgKEJhZCBhZGRyZXNzKQ0KPiANCj4gV2lsbCB0aGlz
IGFsc28gYmUgc29sdmVkIGluIHRoZSBuZXcgTVNJIG1hcHBpbmcgcGF0Y2hzZXQ/DQoNCk5vcGUu
IFRoZXNlIGFyZSBub3QgcmVsYXRlZCB0byBNU0lzLiBUaGVzZSBtYXBwaW5ncyBhcmUgcmVxdWly
ZWQgZm9yIA0KUDJQIERNQSBiZXR3ZWVuIGRldmljZXMgYW5kIGlzIG5vdCBzdXBwb3J0ZWQgYnkg
SU9NTVVGRCBhdCB0aGUgbW9tZW50Lg0KDQpTZWUgdGhlIGRpc2N1c3Npb24gaGVyZSwNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDQyNjEwMzUwNy41NjkzYTBjYS5hbGV4LndpbGxp
YW1zb25AcmVkaGF0LmNvbS8NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

