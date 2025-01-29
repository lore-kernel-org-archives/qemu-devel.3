Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D280C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td39k-0001nv-Vc; Wed, 29 Jan 2025 03:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1td39j-0001ma-9z
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:10:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1td39h-0002Sj-8S
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:10:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YjZZX3BrQz6K9CP;
 Wed, 29 Jan 2025 16:09:56 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id CD911140866;
 Wed, 29 Jan 2025 16:10:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 Jan 2025 09:10:31 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 29 Jan 2025 09:10:31 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Matt Ochs
 <mochs@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nathan Chen
 <nathanc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: RE: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Topic: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Index: AQHbcZ4cYA4z6rsGGkubzpet1LJ8N7Msbd1g///4zACAADxkgIAAr1YAgAATHUA=
Date: Wed, 29 Jan 2025 08:10:31 +0000
Message-ID: <188a25cb7640462ba1cb81456a2fdd90@huawei.com>
References: <20250128160237.3379569-1-mochs@nvidia.com>
 <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
 <cb91da0e-9163-4e59-a060-4a76a077c5d5@redhat.com>
 <BDF4F631-8A96-41B5-B7CE-2BD631C23A2B@nvidia.com>
 <0d303a69-0779-4309-9c00-c76afc82d324@redhat.com>
In-Reply-To: <0d303a69-0779-4309-9c00-c76afc82d324@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjksIDIwMjUg
Nzo1NiBBTQ0KPiBUbzogTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgU2hhbWVlcmFsaSBL
b2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0K
PiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+OyBBbmtpdCBBZ3Jhd2FsDQo+IDxhbmtpdGFAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gaHcvYXJtL3ZpcnQ6IFN1cHBvcnQgbGFyZ2VyIGhpZ2htZW0gTU1JTyByZWdp
b25zDQoNCg0KPiA+Pj4+ICsgICAgaWYgKHNpemUgPCBleHRlbmRlZF9tZW1tYXBbVklSVF9ISUdI
X1BDSUVfTU1JT10uc2l6ZSkgew0KPiA+Pj4gTm90IHN1cmUgaXQgaXMgYmV0dGVyIHRvIGZhbGxi
YWNrIHRvIGRlZmF1bHQgc2l6ZSBoZXJlIGluc3RlYWQgb2Ygc2V0dGluZw0KPiBlcnJvci4NCj4g
Pj4gSSB0aGluayBpZiB0aGUgdXNlciBzZXRzIGEgdmFsdWUgaXQgc2hhbGwgYmUgb2JleWVkDQo+
ID4gQWdyZWVkLg0KPiA+DQo+ID4+IE5vdGUgdGhhdCBwZXIgdGhlIGR5bmFtaWMgbWVtb3J5IG1h
cCBhbGdvLCBjaGFuZ2luZyB0aGUgc2l6ZSB3aWxsIGFsc28NCj4gPj4gY2hhbmdlIHRoZSBiYXNl
IGFkZHJlc3MuIFNlZQ0KPiA+Pg0KPiA+PiB2aXJ0X3NldF9oaWdoX21lbW1hcCgpLiBCeSB0aGUg
d2F5biB3aHkgZG8gd2UgZm9yYmlkIGEgc21hbGxlciBzaXplPw0KPiA+IFRoYXTigJlzIGEgZ29v
ZCBwb2ludCwgSSB3aWxsIHJlbW92ZSB0aGlzIGNoZWNrLg0KDQpJcyB0aGVyZSByZWFsbHkgYSB1
c2UgY2FzZSB3aGVyZSBhIHVzZXIgd2lsbCB3YW50IGEgc21hbGxlciBzaXplIHRoYW4gZGVmYXVs
dD8NCg0KPiA+DQo+ID4+Pj4gKyAgICBvYmplY3RfY2xhc3NfcHJvcGVydHlfYWRkKG9jLCAiaGln
aG1lbS1tbWlvLXNpemUiLCAic2l6ZSIsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdmlydF9nZXRfaGlnaG1lbV9tbWlvX3NpemUsDQo+ID4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydF9zZXRfaGlnaG1lbV9tbWlvX3NpemUsDQo+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgTlVMTCk7DQo+
ID4+Pj4gKyAgICBvYmplY3RfY2xhc3NfcHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKG9jLCAiaGln
aG1lbS1tbWlvLXNpemUiLA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAiU2V0IGV4dGVuZGVkIE1NSU8gbWVtb3J5IG1hcCBzaXplIik7DQo+ID4+Pj4g
Kw0KPiA+Pj4gSSB0aGluayB0aGlzIHByb2JhYmx5IG5lZWRzIGJhY2t3YXJkIGNvbXBhdGliaWxp
dHkgdG8ga2VlcCBtaWdyYXRpb24NCj4gaGFwcHkuDQo+ID4+PiBJc24ndCBpdD8gU2VlIHRoZSBu
b19oaWdobWVtX2NvbXBhY3QgaGFuZGxpbmcuDQo+ID4+IEkgZ3Vlc3MgaWYgd2Uga2VlcCB0aGUg
c2FtZSB2YWx1ZSBhcyBkZWZhdWx0IHdlIGFyZSBnb29kLiBUaGUgZGlmZmVyZW5jZQ0KPiA+PiB3
aXRoIGhpZ2htZW1fY29tcGFjdCBpcyBpdCB3YXMgc2V0IGJ5IGRlZmF1bHQgZnJvbSA3LjIgb253
YXJkcyBoZW5jZQ0KPiA+PiBjaGFuZ2luZyB0aGUgbW1pbyBsYXlvdXQuIEhlcmUgYnkgZGVmYXVs
dCB5b3Uga2VlcCB0aGUgc2FtZSBJSVVDLg0KPiA+IEnigJltIG5vdCBzdXJlIEkgc2VlIGFuIGlz
c3VlIHNpbmNlIHRoZSBjb2RlIGlzIGRpcmVjdGx5IG1vZGlmeWluZyB0aGUgc2l6ZQ0KPiB2YWx1
ZQ0KPiA+IGluIHRoZSBleHRlbmRlZF9tZW1tYXAgYXJyYXkuDQo+IA0KPiBJIG1lYW50IHRoYXQg
aWYgYnkgZGVmYXVsdCB3ZSBrZWVwIHRoZSBzaXplIHZhbHVlIGVxdWFsIHRvIDUxMkcgKHRoZQ0K
PiBleGlzdGluZyBkZWZhdWx0IHZhbHVlKSwgSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGNhcmUg
YWJvdXQgY29tcGF0cy4NCg0KWWVhaC4gSWYgaXQgaGFzIGRlZmF1bHQgc2l6ZSAsIGl0IHNob3Vs
ZCBiZSBPayBJIGd1ZXNzLiBCdXQgd2hhdCBpZiwNCg0KWW91ciBzb3VyY2UgaXMgc29tZXRoaW5n
IGxpa2UsDQoNCi4vcWVtdS1uZXcgLW1hY2hpbmUgdmlydC05LjEsLi4uLGhpZ2htZW0tbW1pby1z
aXplPVhYWA0KDQphbmQgaGFzIGEgdGFyZ2V0IFZNIHN0YXJ0ZWQgd2l0aA0KDQouL3FlbXUtOS4x
ICAtbWFjaGluZSB2aXJ0LC4uLg0KDQpUaGUgbWlncmF0aW9uIHdpbGwgYmUgc3RpbGwgc3VjY2Vz
c2Z1bCBidXQgd2lsbCBoYXZlIG1lbW9yeSBtYXAgZGlmZmVyZW5jZXMsIHJpZ2h0Pw0KDQpPciB0
aGUgYWJvdmUgaXMgbm90IGNvbnNpZGVyZWQgYXMgYSB2YWxpZCB1c2UgY2FzZSBhbmQgdGhlIG9u
dXMgb2YgbWFraW5nDQpzdXJlIHdlIGFyZSB1c2luZyBpdCBjb3JyZWN0bHkgd2l0aCBkZWZhdWx0
IHNpemUgaXMgb24gdGhlIHVzZXIuIA0KDQpUaGFua3MsDQpTSGFtZWVyDQoNCg0KDQoNCg==

