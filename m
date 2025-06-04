Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2622C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoRe-00050x-Qw; Wed, 04 Jun 2025 09:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uMoRZ-000508-9g; Wed, 04 Jun 2025 09:46:17 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uMoRV-0007ji-3w; Wed, 04 Jun 2025 09:46:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bC82H3qZ8z6HJds;
 Wed,  4 Jun 2025 21:44:23 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 958501402E9;
 Wed,  4 Jun 2025 21:45:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Jun 2025 15:45:56 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 4 Jun 2025 15:45:56 +0200
To: Cornelia Huck <cohuck@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>, "jdenemar@redhat.com"
 <jdenemar@redhat.com>
CC: "agraf@csgraf.de" <agraf@csgraf.de>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Thread-Topic: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Thread-Index: AQHbrVvRKlWe4qTsaku+jGkyYZoxlrPgb1/QgASMGwCAAWZvgIALVkAAgAFowxD///1FgIAAMBKg
Date: Wed, 4 Jun 2025 13:45:56 +0000
Message-ID: <58dee0533a40458d9cbd2049c8330c5b@huawei.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <de7db6bc22ad4f0a8ac1fac718c810a1@huawei.com> <87bjrfbkyz.fsf@redhat.com>
 <878qmibc5a.fsf@redhat.com> <87tt4wamcp.fsf@redhat.com>
 <f11e5fbddf634bbc88ba4c07bafe3f26@huawei.com> <87o6v3adle.fsf@redhat.com>
In-Reply-To: <87o6v3adle.fsf@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ybmVsaWEgSHVjayA8
Y29odWNrQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSA0LCAyMDI1IDE6MzYg
UE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3Ro
dW0udGhvZGlAaHVhd2VpLmNvbT47IGVyaWMuYXVnZXIucHJvQGdtYWlsLmNvbTsNCj4gZXJpYy5h
dWdlckByZWRoYXQuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJtQG5vbmdudS5v
cmc7DQo+IGt2bWFybUBsaXN0cy5saW51eC5kZXY7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsN
Cj4gcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgYWxleC5iZW5uZWVAbGluYXJvLm9yZzsg
bWF6QGtlcm5lbC5vcmc7DQo+IG9saXZlci51cHRvbkBsaW51eC5kZXY7IHNlYm90dEByZWRoYXQu
Y29tOyBhcm1icnVAcmVkaGF0LmNvbTsNCj4gYmVycmFuZ2VAcmVkaGF0LmNvbTsgYWJvbG9nbmFA
cmVkaGF0LmNvbTsgamRlbmVtYXJAcmVkaGF0LmNvbQ0KPiBDYzogYWdyYWZAY3NncmFmLmRlOyBz
aGFodWFuZ0ByZWRoYXQuY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gcGhpbG1kQGxpbmFy
by5vcmc7IHBib256aW5pQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MyAwMC8x
MF0ga3ZtL2FybTogSW50cm9kdWNlIGEgY3VzdG9taXphYmxlIGFhcmNoNjQNCj4gS1ZNIGhvc3Qg
bW9kZWwNCj4gDQo+IE9uIFdlZCwgSnVuIDA0IDIwMjUsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhv
ZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDb3JuZWxpYSBIdWNr
IDxjb2h1Y2tAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSnVuZSAzLCAyMDI1IDQ6
MTUgUE0NCj4gPj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPj4gPHNoYW1lZXJh
bGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IGVyaWMuYXVnZXIucHJvQGdtYWlsLmNvbTsN
Cj4gPj4gZXJpYy5hdWdlckByZWRoYXQuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOw0KPiA+PiBrdm1hcm1AbGlzdHMubGludXguZGV2OyBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7DQo+ID4+IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IGFs
ZXguYmVubmVlQGxpbmFyby5vcmc7DQo+IG1hekBrZXJuZWwub3JnOw0KPiA+PiBvbGl2ZXIudXB0
b25AbGludXguZGV2OyBzZWJvdHRAcmVkaGF0LmNvbTsgYXJtYnJ1QHJlZGhhdC5jb207DQo+ID4+
IGJlcnJhbmdlQHJlZGhhdC5jb207IGFib2xvZ25hQHJlZGhhdC5jb207IGpkZW5lbWFyQHJlZGhh
dC5jb20NCj4gPj4gQ2M6IGFncmFmQGNzZ3JhZi5kZTsgc2hhaHVhbmdAcmVkaGF0LmNvbTsgbWFy
ay5ydXRsYW5kQGFybS5jb207DQo+ID4+IHBoaWxtZEBsaW5hcm8ub3JnOyBwYm9uemluaUByZWRo
YXQuY29tDQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMDAvMTBdIGt2bS9hcm06IEludHJv
ZHVjZSBhIGN1c3RvbWl6YWJsZQ0KPiBhYXJjaDY0DQo+ID4+IEtWTSBob3N0IG1vZGVsDQo+ID4+
DQo+ID4+IE9uIFR1ZSwgTWF5IDI3IDIwMjUsIENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQu
Y29tPiB3cm90ZToNCj4gPj4gPiBUaGUgY29udmVyc2lvbiBmdW5jdGlvbnMgYXJlIG5vdCBhdCBm
YXVsdCBoZXJlLCBidXQgd2UncmUgbWlzc2luZw0KPiA+PiA+IHJlZ2lzdGVycy4gSWYgd2UgaGF2
ZSBNSURSIGFuZCBmcmllbmRzIHdyaXRhYmxlLCB0aGV5IHNob3cgdXAgaW4gdGhlDQo+ID4+ID4g
bWFza3MgcmV0dXJuZWQgYnkgdGhlIGtlcm5lbCwgYnV0IHRoZXkgYXJlIG5vdCBwcmVzZW50IGlu
IHRoZSBrZXJuZWwncw0KPiA+PiA+IHN5c3JlZyBmaWxlIHdoZXJlIHdlIGdlbmVyYXRlIG91ciBk
ZWZpbml0aW9ucyBmcm9tLCBhbmQNCj4gPj4gPiBrdm1faWR4X3RvX2lkcmVnc19pZHgoKSBhc3Nl
cnRzIGluc3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVycm9yLCB3aGljaA0KPiA+PiA+IGlzIGtpbmQg
b2Ygc3Vib3B0aW1hbC4uLg0KPiA+PiA+DQo+ID4+ID4gU28gSSBzZWUgdHdvIHBvc3NpYmxlIHdh
eXMgdG8gZml4IHRoaXM6DQo+ID4+ID4gLSBhZGQgTUlEUiBhbmQgZnJpZW5kcyB0byB0aGUga2Vy
bmVsJ3Mgc3lzcmVnIGZpbGUNCj4gPj4gPiAtIGFkZCBNSURSIGFuZCBmcmllbmRzIGluIFFFTVUn
cyBjcHUtc3lzcmVncy5oLmluYyBmaWxlLCBhbmQgb25seQ0KPiBhcHBlbmQNCj4gPj4gPiAgIGdl
bmVyYXRlZCBkZWZpbml0aW9ucyB0aGVyZQ0KPiA+PiA+DQo+ID4+ID4gRmlyc3Qgb3B0aW9uIG1l
YW5zIG9uZSBtb3JlIHJvdW5kIHRyaXAsIHNlY29uZCBvcHRpb25zIGhhcyBtb3JlDQo+ID4+ID4g
cG90ZW50aWFsIGZvciBtZXNzaW5nIHRoaW5ncyB1cCBpZiB3ZSBrZWVwIHN0dWZmIGxvY2FsIHRv
IFFFTVUuDQo+ID4+DQo+ID4+IFdpdGggdGhlIHBhdGNoIGJlbG93LCB0aGluZ3Mgd29yayBmb3Ig
bWUgd2l0aCBhIDYuMTUrIGtlcm5lbC4gSXQncyBhIGJpdA0KPiA+DQo+ID4gWWVzIHdvcmtzIGZv
ciBtZSB0b28gbm93LiBUaGFua3MuDQo+IA0KPiBUaGFua3MgZm9yIGNoZWNraW5nLg0KPiANCj4g
Pg0KPiA+PiBtZXNzeSwgdGhvdWdoLCBhbmQgcmFpc2VzIHF1ZXN0aW9ucyAoaG93IGRvIHdlIHdh
bnQgdG8gaGFuZGxlIHRob3NlDQo+IHJlZ3MNCj4gPj4gYWNyb3NzIGFjY2VsZXJhdG9ycywgZm9y
IGV4YW1wbGUsIG9yIGhvdyB3ZSBjYW4gbWFrZSBzdXJlIHRoYXQgdGhlIGNvZGUNCj4gaXMNCj4g
Pj4gbW9yZSByb2J1c3Qgd2hlbiByZWdpc3RlcnMgYXJlIGFkZGVkLikNCj4gPj4NCj4gPj4gTXkg
YmlnZ2VzdCBxdWVzdGlvbiwgaG93ZXZlciwgaXMgaG93IHRoaXMgaW50ZXJhY3RzIHdpdGggdGhl
IGZyYW1ld29yaw0KPiB0bw0KPiA+PiBwcm92aWRlIGxpc3RzIG9mIE1JRFIvUkVWSURSL0FJRFIg
Zm9yIGVycmF0YSBtYW5hZ2VtZW50LiBUaGUgaGFjaw0KPiBiZWxvdw0KPiA+PiBhZGRzIHByb3Bl
cnRpZXMgdG8gY29uZmlndXJlIHRob3NlIHJlZ3MsIEkgZ3Vlc3Mgd2UnZCB3YW50IHRvIHN1cHBy
ZXNzDQo+ID4+IGFkZGluZyB0aGUgcHJvcHMgaW4gb3JkZXIgdG8gYXZvaWQgY29uZmxpY3RzLg0K
PiA+DQo+ID4gTm90IHN1cmUgaG93IHRoaXMgaW1wYWN0cyB0aGUgZXJyYXRhIG1hbmFnZW1lbnQg
dGhvdWdoLiBNeSBpbml0aWFsIHRha2UNCj4gb24NCj4gPiB0aGlzIHdhcywgdXNlciB3aWxsIHBy
b3ZpZGUgYSBsaXN0IG9mIHRhcmdldCBDUFUgaWRzIHRocm91Z2ggY29tbWFuZCBsaW5lDQo+IGFu
ZA0KPiA+IHRoYXQgd2lsbCBiZSB1c2VkIHRvIHNldCB0aGUgdGFyZ2V0IENQVXMgZm9yIGVycmF0
YSBtYW5hZ2VtZW50KGlmIGtlcm5lbA0KPiA+IHN1cHBvcnRzIGl0KS4NCj4gPg0KPiA+IEVnOg0K
PiA+IC1tYWNoaW5lIHZpcnQsLi4sIHgtdGFyZ2V0LWltcGwtY3B1cz0weE1JRFIxOjB4UkVWSURS
MS0weE1JRFIyOlJFVklEUjINCj4gDQo+IEknbSBhIGJpdCBjb25mdXNlZCBieSB0aGUgcmFuZ2Us
IEknZCByYXRoZXIgZXhwZWN0IGEgbGlzdCBvZiB0dXBsZXMsDQo+IGUuZy4gPG1pZHI+OjxyZXZp
ZHI+LDxtaWRyPjo8cmV2aWRyPiwgLi4uDQoNCkhtbS4uaXMgdGhlIGNvbmNlcm4gaGVyZSBpcyB0
aGUgZm9ybWF0IG9yIHRoZSBudW1iZXIgb2YgZW50cmllcz8NCg0KPiANCj4gPg0KPiA+IEFuZCB0
aGVzZSB3aWxsIGJlIHN0b3JlZCBpbiwNCj4gPg0KPiA+ICNkZWZpbmUgTUFYX1RBUkdFVF9JTVBM
X0NQVVMgICAgNA0KPiA+IHR5cGVkZWYgc3RydWN0IFRhcmdldEltcGxDcHUgew0KPiA+ICAgICAg
dWludDMyX3QgbWlkcjsNCj4gPiAgICAgIHVpbnQzMl90IHJldmlkcjsNCj4gDQo+IElzbid0IHJl
dmlkciBhIDY0IGJpdCB2YWx1ZT8NCg0KWWVzLiBJbiBmYWN0IHRoZXkgYm90aCBhcmUsIHRob3Vn
aCBNSURSIG9ubHkgdXNlcyAzMiBiaXRzIG5vdy4gV2lsbCBjaGFuZ2UuDQoNCj4gDQo+ID4gfSBU
YXJnZXRJbXBsQ3B1Ow0KPiA+DQo+ID4NCj4gPiBQbGVhc2Ugc2VlIHRoZSBpbml0aWFsIChhIGhh
Y2sgZm9yIHRlc3Rpbmcga2VybmVsKSBpbXBsZW1lbnRhdGlvbiBoZXJlLA0KPiA+DQo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9oaXNpbGljb24vcWVtdS9jb21taXQvYTM5M2MxMTgwMjc0YzczZDM0ZjMy
ZWFhYjY2DQo+IDc2NGE4NzRhOWFkMzENCj4gPg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB0
aGVyZSBpcyBhIGJldHRlci9wcmVmZXJyZWQgd2F5IG9mIG9idGFpbmluZyB0aGlzDQo+ID4gdGFy
Z2V0IENQVSBsaXN0IGZyb20gdXNlci4NCj4gDQo+IEknbSBtb3N0bHkgd29uZGVyaW5nIGFib3V0
IGNvbmZsaWN0aW5nIHZhbHVlcyBiZXR3ZWVuICJ3ZSBtYWtlIE1JRFIgZXQNCj4gYWwuIHdyaXRh
YmxlLCBzbyB3ZSBoYXZlIGEgdmFsdWUgZGlmZmVyZW50IGZyb20gd2hhdCB0aGUgaG9zdCBzZWVz
IiBhbmQNCj4gIndlIHByb3ZpZGUgYSBsaXN0IG9mIHBvc3NpYmxlIHZhbHVlcyB0byB0aGUgZ3Vl
c3QsIHNvIGl0IGNhbiBwcmVwYXJlDQo+IGZvciBydW5uaW5nIG9uIHRob3NlIGhvc3RzIi4gRG8g
d2Ugd2FudCB0byBiZSBhYmxlIHRvIHByb3ZpZGUgYSBjb21tb24NCj4gc2V0IHRvIHRoZSBndWVz
dCwgYW5kIHRoZW4gZW5saWdodGVuIGl0IHdpdGggdGhlIGxpc3Qgb2Ygc3lzdGVtcyB0aGF0IGl0
DQo+IGFjdHVhbGx5ICptaWdodCogcnVuIG9uPyBBIGJlbmVmaXQgd291bGQgYmUgdGhhdCBpdCBj
b3VsZCBhbHdheXMgb2JzZXJ2ZQ0KPiB0aGUgc2FtZSAoY29uZmlndXJlZCkgcmVnaXN0ZXIgZW50
cmllcywgcmVnYXJkbGVzcyB3aGVyZSBpdCBydW5zIChuZWVkcw0KPiBtb3JlIHBsdW1iaW5nIGlu
IFFFTVUsIEkgdGhpbmsuKSBXZSdkIGFsc28gbmVlZCB0byBiZSBjbGVhciBhYm91dCB3aGF0DQo+
IHdlJ2QgcmVxdWlyZSAoaS5lLiBkbyB3ZSBleHBlY3QgdGhhdCBib3RoIHRoZSByZWFsIGhvc3Qg
dmFsdWVzIGFuZCB0aGUNCj4gY29uZmlndXJlZCB2YWx1ZXMgYXJlIHByZXNlbnQgaW4gdGhlIGxp
c3Q/KQ0KDQpUaGUgZXhwZWN0YXRpb24gZnJvbSBrZXJuZWwgaXMgdGhhdCB3aGVuIHRhcmdldCBl
cnJhdGEgQ1BVcyBhcmUgc3BlY2lmaWVkLA0KaXQgaW5jbHVkZXMgdGhlIGN1cnJlbnQgaG9zdCBD
UFUgSWRzIGFzIHdlbGwuIFdlIGNvdWxkIGNoZWNrIHRvIHNlZSB0aGUgbGlzdCBpbmNsdWRlcw0K
dGhlIGhvc3Qgb25lLiBCdXQgSSBhbSBub3Qgc3VyZSBob3cgd2UgY2FuIHZhbGlkYXRlIHRoZSBj
b21wbGV0ZSBsaXN0IHByb3ZpZGVkDQpieSB1c2VyIHRob3VnaC4gSSB0aGluaywgIHRoZSBvbnVz
IG9mIGRlY2lkaW5nIHdoaWNoIHBsYXRmb3JtcyB0aGlzIEd1ZXN0IFZNIGlzDQpnb2luZyB0byBy
dW4gZHVyaW5nIGl0cyBsaWZlIHRpbWUgYW5kIHNwZWNpZnlpbmcgdGhhdCBjb3JyZWN0bHkgaXMg
d2l0aCB0aGUgdXNlci4NCg0KPiANCj4gTm90IHN1cmUgaWYgdGhlIG1hY2hpbmUgbGV2ZWwgaXMg
dGhlIHJpZ2h0IHBsYWNlIHRvIGNvbmZpZ3VyZSB0aGlzLCBvcg0KPiBpZiBpdCBuZWVkcyB0byBn
byB0byB0aGUgY3B1IG9wdGlvbnMuIFdoaWxlIGl0IGlzIGEgbWFjaGluZS13aWRlDQo+IGNvbmZp
Z3VyYXRpb24sIGl0IGFsc28gbWVhbnMgdGhhdCB3ZSBjb25maWd1cmUgc29tZSBjcHUgZmVhdHVy
ZXMgaW4gdHdvDQo+IGRpZmZlcmVudCBwbGFjZXMgKGV2ZW4gaWYgdGhleSBzZXJ2ZSBhIGRpZmZl
cmVudCBwdXJwb3NlLikNCg0KSSBleHBsb2l0ZWQgTWFjaGluZVN0YXRlIGZvciBlYXNlIG9mIGhh
Y2tpbmcg8J+Yii4gQnV0IG5vdCBzdXJlIHRoaXMgYmVsb25ncyB0byBDUFUNCmVpdGhlciBhcyBp
dCBpcyB2ZXJ5IHNwZWNpZmljIHRvIEtWTSBpcyBlbmFibGVkLCBzdXBwb3J0ZWQga2VybmVsIGV0
Yy4NCiANCj4gV2UgY291bGQgYWxzbyBjaG9vc2UgdG8gbm90IGV4cG9zZSBwcm9wZXJ0aWVzIGZv
ciBNSURSIGFuZCBmcmllbmRzIGF0DQo+IGFsbCwgZXZlbiBpZiB0aGV5IGFyZSB3cml0YWJsZS4N
Cj4NCg0KRG9lcyB0aGF0IG1lYW4gUWVtdSBmaWd1cmVzIG91dCBhbGwgdGhlIHN1cHBvcnRlZCB0
YXJnZXQgSWRzIGJhc2VkIG9uIHRoZSANCkhvc3QgQ1BVICBJZHM/DQoNClRoYW5rcywNClNoYW1l
ZXINCiANCg0K

