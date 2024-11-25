Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE60D3B7F6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 09:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVkY-0008SY-Au; Mon, 25 Nov 2024 04:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1tFVkM-0008Ro-FG
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:51:10 -0500
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1tFVkJ-00062s-4p
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:51:10 -0500
To: Jason Wang <jasowang@redhat.com>
CC: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Gao,Shiyuan"
 <gaoshiyuan@baidu.com>
Subject: Re: [PATCH v2] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Thread-Topic: [PATCH v2] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Thread-Index: Ads/Hs+pPEnB06gBTlC4trhTNZqaSg==
Date: Mon, 25 Nov 2024 09:50:52 +0000
Message-ID: <39482457c84c433bab194db9fe2f49ad@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.84.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.43
X-FE-Last-Public-Client-IP: 100.100.100.49
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=zuoboqun@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Zuo,Boqun" <zuoboqun@baidu.com>
From:  "Zuo,Boqun" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQpPbiBNb24sIE5vdiAyNSwgMjAyNCAxMTo1MyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToNCj4gT24gRnJpLCBOb3YgMTUsIDIwMjQgYXQgNDowM+KAr1BNIFp1byBi
b3F1biA8enVvYm9xdW5AYmFpZHUuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IHp1b2JvcXVu
IDx6dW9ib3F1bkBiYWlkdS5jb20+DQo+ID4NCj4gPiBXaGVuIHRoZSBiYWNrZW5kIG9mIHZob3N0
X25ldCByZXN0YXJ0cyBkdXJpbmcgdGhlIHZtIGlzIHJ1bm5pbmcsDQo+ID4gdmhvc3RfbmV0IGlz
IHN0b3BwZWQgYW5kIHN0YXJ0ZWQuIFRoZSB2aXJ0aW9fZGV2aWNlX2dyYWJfaW9ldmVudGZkKCkN
Cj4gPiBmdWNudGlvbiBpbg0KPiA+IHZob3N0X25ldF9lbmFibGVfbm90aWZpZXJzKCkgd2lsbCBy
ZXN1bHQgaW4gYSBjYWxsIHRvDQo+ID4gdmlydGlvX2J1c19zZXRfaG9zdF9ub3RpZmllcigpKGFz
c2lnbj1mYWxzZSkuDQo+ID4NCj4gPiBBbmQgbm93IHZpcnRpb19kZXZpY2VfZ3JhYl9pb2V2ZW50
ZmQoKSBpcyBiYXRjaGVkIGluIGEgc2luZ2xlDQo+ID4gdHJhbnNhY3Rpb24gd2l0aCB2aXJ0aW9f
YnVzX3NldF9ob3N0X25vdGlmaWVyKCkoYXNzaWduPXRydWUpLg0KPiA+DQo+ID4gVGhpcyB0cmln
Z2VycyB0aGUgZm9sbG93aW5nIGFzc2VydGlvbjoNCj4gPg0KPiA+IGt2bV9tZW1faW9ldmVudGZk
X2RlbDogZXJyb3IgZGVsZXRpbmcgaW9ldmVudGZkOiBCYWQgZmlsZSBkZXNjcmlwdG9yDQo+ID4N
Cj4gPiBUaGlzIHBhdGNoIG1vdmVzIHZpcnRpb19kZXZpY2VfZ3JhYl9pb2V2ZW50ZmQoKSBvdXQg
b2YgdGhlIGJhdGNoIHRvDQo+ID4gZml4IHRoaXMgcHJvYmxlbS4NCj4gPg0KPiA+IFRvIGJlIG5v
dGVkIHRoYXQgdGhlIGZvciBsb29wIHRvIHJlbGVhc2UgaW9ldmVudGZkIHNob3VsZCBzdGFydCBm
cm9tDQo+ID4gaSsxLCBub3QgaSwgYmVjYXVzZSB0aGUgaS10aCBpb2V2ZW50ZmQgaGFzIGFscmVh
ZHkgYmVlbiByZWxlYXNlZCBpbg0KPiA+IHZob3N0X2Rldl9kaXNhYmxlX25vdGlmaWVyc19udnFz
KCkuDQo+ID4NCj4gPiBGaXhlczogNjE2Njc5OWY2ICgidmhvc3RfbmV0OiBjb25maWd1cmUgYWxs
IGhvc3Qgbm90aWZpZXJzIGluIGEgc2luZ2xlDQo+ID4gTVIgdHJhbnNhY3Rpb24iKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IFp1byBCb3F1biA8enVvYm9xdW5AYmFpZHUuY29tPg0KPiA+IFJlcG9ydGVk
LWJ5OiBHYW8gU2hpeXVhbiA8Z2Fvc2hpeXVhbkBiYWlkdS5jb20+DQo+IA0KPiBJIHRoaW5rIHdl
IG5lZWQgY2Mgc3RhYmxlIGZvciB0aGlzLg0KDQpPSw0KDQo+IA0KPiA+DQo+ID4gLS0tDQo+ID4N
Cj4gPiB2MS0+djI6DQo+ID4gICAgICpUbyBleHBsYWluIHdoeSB0aGUgZm9yIGxvb3AgdG8gcmVs
ZWFzZSBpb2V2ZW50ZmQgc3RhcnRzIGZyb20gaSsxOg0KPiA+ICAgICAgIDEpIGFkZCBhIGNvbW1l
bnQgaW4gdGhlIGNvZGUNCj4gPiAgICAgICAyKSBkZXNjcmliZSBpdCBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UNCj4gPiAtLS0NCj4gPiAgaHcvbmV0L3Zob3N0X25ldC5jIHwgMzUgKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L25ldC92aG9z
dF9uZXQuYyBiL2h3L25ldC92aG9zdF9uZXQuYyBpbmRleA0KPiA+IDk5N2FhYjA1NTcuLjg5MWYy
MzVhMGEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvbmV0L3Zob3N0X25ldC5jDQo+ID4gKysrIGIvaHcv
bmV0L3Zob3N0X25ldC5jDQo+ID4gQEAgLTIyOSw5ICsyMjksMjQgQEAgc3RhdGljIGludCB2aG9z
dF9uZXRfZW5hYmxlX25vdGlmaWVycyhWaXJ0SU9EZXZpY2UNCj4gKmRldiwNCj4gPiAgICAgIGlu
dCBudmhvc3RzID0gZGF0YV9xdWV1ZV9wYWlycyArIGN2cTsNCj4gPiAgICAgIHN0cnVjdCB2aG9z
dF9uZXQgKm5ldDsNCj4gPiAgICAgIHN0cnVjdCB2aG9zdF9kZXYgKmhkZXY7DQo+ID4gLSAgICBp
bnQgciwgaSwgajsNCj4gPiArICAgIGludCByLCBpLCBqLCBrOw0KPiA+ICAgICAgTmV0Q2xpZW50
U3RhdGUgKnBlZXI7DQo+ID4NCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBXZSB3aWxsIHBhc3Mg
dGhlIG5vdGlmaWVycyB0byB0aGUga2VybmVsLCBtYWtlIHN1cmUgdGhhdCBRRU1VDQo+ID4gKyAg
ICAgKiBkb2Vzbid0IGludGVyZmVyZS4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgZm9yIChpID0g
MDsgaSA8IG52aG9zdHM7IGkrKykgew0KPiA+ICsgICAgICAgIHIgPSB2aXJ0aW9fZGV2aWNlX2dy
YWJfaW9ldmVudGZkKGRldik7DQo+ID4gKyAgICAgICAgaWYgKHIgPCAwKSB7DQo+ID4gKyAgICAg
ICAgICAgIGVycm9yX3JlcG9ydCgidmhvc3QgJWQgYmluZGluZyBkb2VzIG5vdCBzdXBwb3J0IGhv
c3Qgbm90aWZpZXJzIiwgaSk7DQo+ID4gKyAgICAgICAgICAgIGZvciAoayA9IDA7IGsgPCBpOyBr
KyspIHsNCj4gPiArICAgICAgICAgICAgICAgIHZpcnRpb19kZXZpY2VfcmVsZWFzZV9pb2V2ZW50
ZmQoZGV2KTsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICByZXR1cm4gcjsN
Cj4gPiArICAgICAgICB9DQo+IA0KPiBDb3VsZCB3ZSB0d2VhayB0aGUgY29kZSB0byByZXVzZSB0
aGUgZmFpbF9udmhvc3RzPw0KDQpPSywgSSB3aWxsIG1ha2UgdGhpcyBjaGFuZ2UgYW5kIGNjIHN0
YWJsZSBpbiB0aGUgbmV4dCB2ZXJzaW9uDQoNCj4gDQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAg
ICAgLyoNCj4gPiAgICAgICAqIEJhdGNoIGFsbCB0aGUgaG9zdCBub3RpZmllcnMgaW4gYSBzaW5n
bGUgdHJhbnNhY3Rpb24gdG8gYXZvaWQNCj4gPiAgICAgICAqIHF1YWRyYXRpYyB0aW1lIGNvbXBs
ZXhpdHkgaW4gYWRkcmVzc19zcGFjZV91cGRhdGVfaW9ldmVudGZkcygpLg0KPiA+IEBAIC0yNDcs
MTYgKzI2Miw2IEBAIHN0YXRpYyBpbnQNCj4gPiB2aG9zdF9uZXRfZW5hYmxlX25vdGlmaWVycyhW
aXJ0SU9EZXZpY2UgKmRldiwNCj4gPg0KPiA+ICAgICAgICAgIG5ldCA9IGdldF92aG9zdF9uZXQo
cGVlcik7DQo+ID4gICAgICAgICAgaGRldiA9ICZuZXQtPmRldjsNCj4gPiAtICAgICAgICAvKg0K
PiA+IC0gICAgICAgICAqIFdlIHdpbGwgcGFzcyB0aGUgbm90aWZpZXJzIHRvIHRoZSBrZXJuZWws
IG1ha2Ugc3VyZSB0aGF0IFFFTVUNCj4gPiAtICAgICAgICAgKiBkb2Vzbid0IGludGVyZmVyZS4N
Cj4gPiAtICAgICAgICAgKi8NCj4gPiAtICAgICAgICByID0gdmlydGlvX2RldmljZV9ncmFiX2lv
ZXZlbnRmZChkZXYpOw0KPiA+IC0gICAgICAgIGlmIChyIDwgMCkgew0KPiA+IC0gICAgICAgICAg
ICBlcnJvcl9yZXBvcnQoImJpbmRpbmcgZG9lcyBub3Qgc3VwcG9ydCBob3N0IG5vdGlmaWVycyIp
Ow0KPiA+IC0gICAgICAgICAgICBtZW1vcnlfcmVnaW9uX3RyYW5zYWN0aW9uX2NvbW1pdCgpOw0K
PiA+IC0gICAgICAgICAgICBnb3RvIGZhaWxfbnZob3N0czsNCj4gPiAtICAgICAgICB9DQo+ID4N
Cj4gPiAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgaGRldi0+bnZxczsgaisrKSB7DQo+ID4gICAg
ICAgICAgICAgIHIgPSB2aXJ0aW9fYnVzX3NldF9ob3N0X25vdGlmaWVyKFZJUlRJT19CVVMocWJ1
cyksDQo+ID4gQEAgLTI3Nyw2ICsyODIsMTQgQEAgc3RhdGljIGludCB2aG9zdF9uZXRfZW5hYmxl
X25vdGlmaWVycyhWaXJ0SU9EZXZpY2UNCj4gKmRldiwNCj4gPiAgICAgIHJldHVybiAwOw0KPiA+
ICBmYWlsX252aG9zdHM6DQo+ID4gICAgICB2aG9zdF9uZXRfZGlzYWJsZV9ub3RpZmllcnNfbnZo
b3N0cyhkZXYsIG5jcywgZGF0YV9xdWV1ZV9wYWlycywNCj4gPiBpKTsNCj4gPiArICAgIC8qDQo+
ID4gKyAgICAgKiBUaGlzIGZvciBsb29wIHN0YXJ0cyBmcm9tIGkrMSwgbm90IGksIGJlY2F1c2Ug
dGhlIGktdGggaW9ldmVudGZkDQo+ID4gKyAgICAgKiBoYXMgYWxyZWFkeSBiZWVuIHJlbGVhc2Vk
IGluIHZob3N0X2Rldl9kaXNhYmxlX25vdGlmaWVyc19udnFzKCkuDQo+ID4gKyAgICAgKi8NCj4g
PiArICAgIGZvciAoayA9IGkgKyAxOyBrIDwgbnZob3N0czsgaysrKSB7DQo+ID4gKyAgICAgICAg
dmlydGlvX2RldmljZV9yZWxlYXNlX2lvZXZlbnRmZChkZXYpOw0KPiA+ICsgICAgfQ0KPiA+ICsN
Cj4gPiAgICAgIHJldHVybiByOw0KPiA+ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDIuMC53aW5k
b3dzLjINCj4gPg0KPiANCj4gVGhhbmtzDQoNCg==

