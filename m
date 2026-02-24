Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE1AF4BB71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux6A-0008P3-Pn; Tue, 24 Feb 2026 13:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vux67-0008Nm-A3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:25:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vux63-00054t-R8
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:25:26 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL5jS4L5fzJ46CD;
 Wed, 25 Feb 2026 02:24:44 +0800 (CST)
Received: from dubpeml100006.china.huawei.com (unknown [7.214.145.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 8F92440539;
 Wed, 25 Feb 2026 02:25:06 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml100006.china.huawei.com (7.214.145.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 18:25:06 +0000
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Tue, 24 Feb 2026 18:25:05 +0000
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: RE: [PULL 13/33] hw/cxl: Add support for Maintenance command and Post
 Package Repair (PPR)
Thread-Topic: [PULL 13/33] hw/cxl: Add support for Maintenance command and
 Post Package Repair (PPR)
Thread-Index: AQHcpAhOTpwueHMiR0+Cbloy2UBl1LWRrmiAgAB7v3A=
Date: Tue, 24 Feb 2026 18:25:05 +0000
Message-ID: <b973578d97a24cdd8b1965f6769adf61@huawei.com>
References: <cover.1771770471.git.mst@redhat.com>
 <5e5a86bab8308a9d5db09cbfdf12cc3751dce0f7.1771770471.git.mst@redhat.com>
 <CAFEAcA_CsVe4TUVm3o_-BA4hXvi2xAThGX5T97amgTQKW_kiYA@mail.gmail.com>
In-Reply-To: <CAFEAcA_CsVe4TUVm3o_-BA4hXvi2xAThGX5T97amgTQKW_kiYA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.189]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Shiju Jose <shiju.jose@huawei.com>
From:  Shiju Jose via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPg0KPlNlbnQ6IDI0IEZlYnJ1YXJ5IDIwMjYgMTA6NDkNCj5Ubzog
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj5DYzogcWVtdS1kZXZlbEBub25n
bnUub3JnOyBEYXZpZGxvaHIgQnVlc28gPGRhdmVAc3Rnb2xhYnMubmV0PjsgU2hpanUgSm9zZQ0K
PjxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+PGpvbmF0aGFuLmNh
bWVyb25AaHVhd2VpLmNvbT47IEZhbiBOaSA8ZmFuLm5pQHNhbXN1bmcuY29tPg0KPlN1YmplY3Q6
IFJlOiBbUFVMTCAxMy8zM10gaHcvY3hsOiBBZGQgc3VwcG9ydCBmb3IgTWFpbnRlbmFuY2UgY29t
bWFuZCBhbmQNCj5Qb3N0IFBhY2thZ2UgUmVwYWlyIChQUFIpDQo+DQo+T24gU3VuLCAyMiBGZWIg
MjAyNiBhdCAxNDoyOCwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
DQo+Pg0KPj4gRnJvbTogRGF2aWRsb2hyIEJ1ZXNvIDxkYXZlQHN0Z29sYWJzLm5ldD4NCj4+DQo+
PiBUaGlzIGFkZHMgaW5pdGlhbCBzdXBwb3J0IGZvciB0aGUgTWFpbnRlbmFuY2UgY29tbWFuZCwg
c3BlY2lmaWNhbGx5DQo+PiB0aGUgc29mdCBhbmQgaGFyZCBQUFIgb3BlcmF0aW9ucyBvbiBhIGRw
YS4gVGhlIGltcGxlbWVudGF0aW9uIGFsbG93cw0KPj4gdG8gYmUgZXhlY3V0ZWQgYXQgcnVudGlt
ZSwgdGhlcmVmb3JlIHNlbWFudGljYWxseSwgZGF0YSBpcyByZXRhaW5lZA0KPj4gYW5kIENYTC5t
ZW0gcmVxdWVzdHMgYXJlIGNvcnJlY3RseSBwcm9jZXNzZWQuDQo+DQo+SGk7IENvdmVyaXR5IGVt
aXRzIGEgd2FybmluZyBoZXJlIChDSUQgMTY0NTMyNSkgZm9yIHVzZSBvZiBzdHJuY3B5KCk6DQo+
DQo+PiArc3RhdGljIHZvaWQgY3hsX21ib3hfY3JlYXRlX21lbV9zcGFyaW5nX2V2ZW50X3JlY29y
ZHMoQ1hMVHlwZTNEZXYNCj4qY3QzZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDhfdCBtYWludF9vcF9jbGFzcywgdWludDhfdCBtYWludF9vcF9zdWJfY2xhc3MsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENYTE1haW50ZW5hbmNlICplbnQpIHsNCj4+ICsg
ICAgQ1hMRXZlbnRTcGFyaW5nIGV2ZW50X3JlYyA9IHt9Ow0KPj4gKw0KPj4gKyAgICBjeGxfYXNz
aWduX2V2ZW50X2hlYWRlcigmZXZlbnRfcmVjLmhkciwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJnNwYXJpbmdfdXVpZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KDEgPDwgQ1hMX0VWRU5UX1RZUEVfSU5GTyksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNpemVvZihldmVudF9yZWMpLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
eGxfZGV2aWNlX2dldF90aW1lc3RhbXAoJmN0M2QtPmN4bF9kc3RhdGUpLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAxLCBtYWludF9vcF9jbGFzcywgMSwgbWFpbnRfb3Bfc3ViX2Ns
YXNzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAwLCAwLCAwKTsNCj4+ICsg
ICAgaWYgKGVudCkgew0KPj4gKyAgICAgICAgZXZlbnRfcmVjLmZsYWdzID0gMDsNCj4+ICsgICAg
ICAgIGV2ZW50X3JlYy5yZXN1bHQgPSAwOw0KPj4gKyAgICAgICAgc3R3X2xlX3AoJmV2ZW50X3Jl
Yy5yZXNfYXZhaWwsIDIpOw0KPj4gKyAgICAgICAgc3R3X2xlX3AoJmV2ZW50X3JlYy52YWxpZGl0
eV9mbGFncywgZW50LT52YWxpZGl0eV9mbGFncyk7DQo+PiArICAgICAgICBldmVudF9yZWMuY2hh
bm5lbCA9IGVudC0+Y2hhbm5lbDsNCj4+ICsgICAgICAgIGV2ZW50X3JlYy5yYW5rID0gZW50LT5y
YW5rOw0KPj4gKyAgICAgICAgc3QyNF9sZV9wKGV2ZW50X3JlYy5uaWJibGVfbWFzaywgZW50LT5u
aWJibGVfbWFzayk7DQo+PiArICAgICAgICBldmVudF9yZWMuYmFua19ncm91cCA9IGVudC0+YmFu
a19ncm91cDsNCj4+ICsgICAgICAgIGV2ZW50X3JlYy5iYW5rID0gZW50LT5iYW5rOw0KPj4gKyAg
ICAgICAgc3QyNF9sZV9wKGV2ZW50X3JlYy5yb3csIGVudC0+cm93KTsNCj4+ICsgICAgICAgIHN0
d19sZV9wKCZldmVudF9yZWMuY29sdW1uLCBlbnQtPmNvbHVtbik7DQo+PiArICAgICAgICBldmVu
dF9yZWMuc3ViX2NoYW5uZWwgPSBlbnQtPnN1Yl9jaGFubmVsOw0KPj4gKyAgICAgICAgaWYgKGVu
dC0+dmFsaWRpdHlfZmxhZ3MgJiBDWExfTVNFUl9WQUxJRF9DT01QX0lEKSB7DQo+PiArICAgICAg
ICAgICAgc3RybmNweSgoY2hhciAqKWV2ZW50X3JlYy5jb21wb25lbnRfaWQsIChjaGFyICopZW50
LT5jb21wb25lbnRfaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICBzaXplb2YoZXZlbnRfcmVj
LmNvbXBvbmVudF9pZCkpOw0KPg0KPlNpbmNlIHRoaXMgZG9lcyBhIHN0cm5jcHkoKSB3aXRoIGEg
bGVuZ3RoIHBhcmFtZXRlciBlcXVhbCB0byB0aGUgZnVsbCBzaXplIG9mIHRoZQ0KPnN0cnVjdCBh
cnJheSBmaWVsZDoNCj4NCj4+ICsgICAgdWludDhfdCBjb21wb25lbnRfaWRbQ1hMX0VWRU5UX0dF
Tl9NRURfQ09NUF9JRF9TSVpFXTsNCj4NCj5pdCBtaWdodCByZXN1bHQgaW4gdGhlcmUgYmVpbmcg
bm8gTlVMIHRlcm1pbmF0b3Igb24gdGhlIGVuZC4NCj4NCj5JcyB0aGF0IHRoZSBpbnRlbmRlZCBi
ZWhhdmlvdXIgPw0KDQpUaGFua3MgUGV0ZXIgZm9yIHJlcG9ydGluZy4NCmNvbXBvbmVudF9pZCBp
cyBmaXhlZCBkYXRhIGxlbmd0aCBvZiAxNiBieXRlcyB3aXRob3V0IE5VTEwgdGVybWluYXRvciAg
KENYTCBzcGVjIDMuMiBUYWJsZSA4LTU2Lg0KQ29tcG9uZW50IElkZW50aWZpZXIgRm9ybWF0ICks
ICBidXQgSSB0aGluayBuZWVkIHRvIHVzZSBtZW1jcHkgaW5zdGVhZCAodGVzdGVkIG9rYXkpIHRv
IGZpeCB0aGlzIHdhcm5pbmc/DQoNCj4NCj5Db252ZXJzZWx5LCBpbiB0aGlzIGZ1bmN0aW9uOg0K
Pg0KPj4gK3N0YXRpYyB2b2lkIGN4bF9tYWludGVuYW5jZV9pbnNlcnQoQ1hMVHlwZTNEZXYgKmN0
M2QsIHVpbnQ2NF90IGRwYSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgaGFzX2NoYW5uZWwsIHVpbnQ4X3QgY2hhbm5lbCwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgaGFzX3JhbmssIHVpbnQ4X3QgcmFuaywNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaGFzX25pYmJsZV9tYXNrLCB1aW50
MzJfdCBuaWJibGVfbWFzaywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgaGFzX2JhbmtfZ3JvdXAsIHVpbnQ4X3QgYmFua19ncm91cCwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaGFzX2JhbmssIHVpbnQ4X3QgYmFuaywNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaGFzX3JvdywgdWludDMy
X3Qgcm93LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBoYXNf
Y29sdW1uLCB1aW50MTZfdCBjb2x1bW4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBjaGFyICpjb21wb25lbnRfaWQsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIGhhc19jb21wX2lkX3BsZG0sIGJvb2wgaXNfY29tcF9pZF9w
bGRtLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBoYXNfc3Vi
X2NoYW5uZWwsIHVpbnQ4X3QNCj4+ICtzdWJfY2hhbm5lbCkgew0KPj4gKyAgICBDWExNYWludGVu
YW5jZSAqZW50LCAqbTsNCj4+ICsNCj4+ICsgICAgUUxJU1RfRk9SRUFDSChlbnQsICZjdDNkLT5t
YWludF9saXN0LCBub2RlKSB7DQo+PiArICAgICAgICBpZiAoZHBhID09IGVudC0+ZHBhKSB7DQo+
PiArICAgICAgICAgICAgcmV0dXJuOw0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICB9DQo+PiArICAg
IG0gPSBnX25ldzAoQ1hMTWFpbnRlbmFuY2UsIDEpOw0KPj4gKyAgICBtZW1zZXQobSwgMCwgc2l6
ZW9mKCptKSk7DQo+DQo+KFNpZGUgbm90ZTogdGhpcyBtZW1zZXQoKSBpcyBub3Qgd2FudGVkLCBi
ZWNhdXNlIGdfbmV3MCgpIGlzIHNwZWNpZmljYWxseSAiYWxsb2NhdGUNCj5hbmQgemVybyB0aGlz
Ii4pDQo+DQo+PiArICAgIGlmIChjb21wb25lbnRfaWQpIHsNCj4+ICsgICAgICAgIHN0cm5jcHko
KGNoYXIgKiltLT5jb21wb25lbnRfaWQsIGNvbXBvbmVudF9pZCwNCj4+ICsgICAgICAgICAgICAg
ICAgc2l6ZW9mKG0tPmNvbXBvbmVudF9pZCkgLSAxKTsNCj4NCj4uLi5oZXJlIHdlIGRvIGxpbWl0
IHRoZSBzdHJuY3B5IHNpemUgdG8gb25lIGxlc3MgdGhhbiB0aGUgYXJyYXkgc2l6ZSwgd2hpY2gg
KHRvZ2V0aGVyDQo+d2l0aCB0aGUgZmFjdCB3ZSdyZSBkb2luZyBpdCBpbnRvIHplcm9lZA0KPm1l
bW9yeSkgbWVhbnMgaXQgd2lsbCBhbHdheXMgYmUgTlVMIHRlcm1pbmF0ZWQuDQpUaGlzIHNob3Vs
ZCAgY29weSAgQ1hMX0VWRU5UX0dFTl9NRURfQ09NUF9JRF9TSVpFICgxNikgYnl0ZXMgaW5zdGVh
ZCBvZg0KQ1hMX0VWRU5UX0dFTl9NRURfQ09NUF9JRF9TSVpFIC0gMSBhbmQgYWxzbyBJIHRoaW5r
IHNob3VsZCB1c2UgbWVtY3B5IGluc3RlYWQNCmFzIGFib3ZlICh0ZXN0ZWQgb2theSk/DQptZW1j
cHkoKGNoYXIgKiltLT5jb21wb25lbnRfaWQsIGNvbXBvbmVudF9pZCwNCiAgICAgICAgICAgICAg
ICAgc2l6ZW9mKG0tPmNvbXBvbmVudF9pZCkpOw0KSWYgc28sIHRoaXMgc2hvdWxkIGJlIGZpeGVk
IGluIG90aGVyIENYTCBldmVudHMgcmVjb3JkcyBhcyB3ZWxsLg0KPg0KPkFyZSB0aGVzZSB0d28g
dGhpbmdzIHJlYWxseSBzdXBwb3NlZCB0byBiZSBoYW5kbGVkIGRpZmZlcmVudGx5ID8NCj4NCj4+
ICsgICAgICAgIG0tPnZhbGlkaXR5X2ZsYWdzIHw9IENYTF9NU0VSX1ZBTElEX0NPTVBfSUQ7DQo+
PiArICAgICAgICBpZiAoaGFzX2NvbXBfaWRfcGxkbSAmJiBpc19jb21wX2lkX3BsZG0pIHsNCj4+
ICsgICAgICAgICAgICBtLT52YWxpZGl0eV9mbGFncyB8PSBDWExfTVNFUl9WQUxJRF9DT01QX0lE
X0ZPUk1BVDsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBRTElTVF9J
TlNFUlRfSEVBRCgmY3QzZC0+bWFpbnRfbGlzdCwgbSwgbm9kZSk7IH0NCj4NCj50aGFua3MNCj4t
LSBQTU0NCg0KVGhhbmtzLA0KU2hpanUNCg==

