Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67481C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFKI-0003Ri-65; Tue, 08 Jul 2025 16:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZEOi-0002eM-OB; Tue, 08 Jul 2025 15:54:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZEOb-0000ml-CM; Tue, 08 Jul 2025 15:54:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bby1C07Rpz6GDLX;
 Tue,  8 Jul 2025 18:25:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4EB8214037D;
 Tue,  8 Jul 2025 18:28:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 12:28:44 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 8 Jul 2025 12:28:44 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Thread-Topic: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Thread-Index: AQHb6/xJlPtpAHu5pEuj91bLuyZP37QnvekAgAA0r1D//+6FAIAALBYA
Date: Tue, 8 Jul 2025 10:28:43 +0000
Message-ID: <2cdccd4f63264986b6b5392d9a2486dc@huawei.com>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-9-shameerali.kolothum.thodi@huawei.com>
 <b05cd1f5-db7a-45d3-a582-85c808adcd04@redhat.com>
 <e4cd2ccede7b46df9bbcf63dcf492fcf@huawei.com>
 <785c5904-001b-4e1b-8fae-9b8539668e96@redhat.com>
In-Reply-To: <785c5904-001b-4e1b-8fae-9b8539668e96@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDgsIDIwMjUgMTA6NDcg
QU0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3Ro
dW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlhLmNv
bTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUBy
ZWRoYXQuY29tOyBpbWFtbWVkb0ByZWRoYXQuY29tOw0KPiBuYXRoYW5jQG52aWRpYS5jb207IG1v
Y2hzQG52aWRpYS5jb207IHNtb3N0YWZhQGdvb2dsZS5jb207DQo+IGd1c3Rhdm8ucm9tZXJvQGxp
bmFyby5vcmc7IG1zdEByZWRoYXQuY29tOw0KPiBtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbTsg
TGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBXYW5nemhvdSAoQikgPHdhbmd6aG91
MUBoaXNpbGljb24uY29tPjsgamlhbmdrdW5rdW4NCj4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+
OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA4LzEyXSBody9h
cm0vdmlydDogQWxsb3cgdXNlci1jcmVhdGFibGUgU01NVXYzDQo+IGRldiBpbnN0YW50aWF0aW9u
DQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNy84LzI1IDEwOjU0IEFNLCBTaGFtZWVyYWxp
IEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+IEhpIEVyaWMsDQo+ID4NCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRo
YXQuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDgsIDIwMjUgODo0MSBBTQ0KPiA+PiBU
bzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA+PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gPj4gcWVtdS1kZXZlbEBu
b25nbnUub3JnDQo+ID4+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEu
Y29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiA+PiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJh
bmdlQHJlZGhhdC5jb207IGltYW1tZWRvQHJlZGhhdC5jb207DQo+ID4+IG5hdGhhbmNAbnZpZGlh
LmNvbTsgbW9jaHNAbnZpZGlhLmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsNCj4gPj4gZ3VzdGF2
by5yb21lcm9AbGluYXJvLm9yZzsgbXN0QHJlZGhhdC5jb207DQo+ID4+IG1hcmNlbC5hcGZlbGJh
dW1AZ21haWwuY29tOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+ID4+IFdhbmd6
aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+OyBqaWFuZ2t1bmt1bg0KPiA+PiA8amlh
bmdrdW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPj4gPGpvbmF0aGFuLmNh
bWVyb25AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+ID4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjYgMDgvMTJdIGh3L2FybS92aXJ0OiBBbGxvdyB1c2VyLWNyZWF0YWJsZQ0K
PiBTTU1VdjMNCj4gPj4gZGV2IGluc3RhbnRpYXRpb24NCj4gPj4NCj4gPj4gSGkgU2hhbWVlciwN
Cj4gPj4NCj4gPj4gT24gNy8zLzI1IDEwOjQ2IEFNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0K
PiA+Pj4gQWxsb3cgY29sZC1wbHVnZ2luZyBvZiBhbiBTTU1VdjMgZGV2aWNlIG9uIHRoZSB2aXJ0
IG1hY2hpbmUgd2hlbiBubw0KPiA+Pj4gZ2xvYmFsIChsZWdhY3kpIFNNTVV2MyBpcyBwcmVzZW50
IG9yIHdoZW4gYSB2aXJ0aW8taW9tbXUgaXMgc3BlY2lmaWVkLg0KPiA+Pj4NCj4gPj4+IFRoaXMg
dXNlci1jcmVhdGVkIFNNTVV2MyBkZXZpY2UgaXMgdGllZCB0byBhIHNwZWNpZmljIFBDSSBidXMg
cHJvdmlkZWQNCj4gPj4+IGJ5IHRoZSB1c2VyLCBzbyBlbnN1cmUgdGhlIElPTU1VIG9wcyBhcmUg
Y29uZmlndXJlZCBhY2NvcmRpbmdseS4NCj4gPj4+DQo+ID4+PiBEdWUgdG8gY3VycmVudCBsaW1p
dGF0aW9ucyBpbiBRRU1V4oCZcyBkZXZpY2UgdHJlZSBzdXBwb3J0LCBzcGVjaWZpY2FsbHkNCj4g
Pj4+IGl0cyBpbmFiaWxpdHkgdG8gcHJvcGVybHkgcHJlc2VudCBweGItcGNpZSBiYXNlZCByb290
IGNvbXBsZXhlcyBhbmQNCj4gPj4+IHRoZWlyIGRldmljZXMsIHRoZSBkZXZpY2UgdHJlZSBzdXBw
b3J0IGZvciB0aGUgbmV3IFNNTVV2MyBkZXZpY2UgaXMNCj4gPj4+IGxpbWl0ZWQgdG8gY2FzZXMg
d2hlcmUgaXQgaXMgYXR0YWNoZWQgdG8gdGhlIGRlZmF1bHQgcGNpZS4wIHJvb3QgY29tcGxleC4N
Cj4gPj4+DQo+ID4+PiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2Ft
ZXJvbkBodWF3ZWkuY29tPg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4gPj4+IFRlc3RlZC1ieTogTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZp
ZGlhLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPj4gPHNo
YW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGh3
L2FybS9zbW11LWNvbW1vbi5jICAgICAgICAgfCAgOCArKysrKy0NCj4gPj4+ICBody9hcm0vc21t
dXYzLmMgICAgICAgICAgICAgIHwgIDIgKysNCj4gPj4+ICBody9hcm0vdmlydC5jICAgICAgICAg
ICAgICAgIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+PiAg
aHcvY29yZS9zeXNidXMtZmR0LmMgICAgICAgICB8ICAzICsrKw0KPiA+Pj4gIGluY2x1ZGUvaHcv
YXJtL3NtbXUtY29tbW9uLmggfCAgMSArDQo+ID4+PiAgNSBmaWxlcyBjaGFuZ2VkLCA2MyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2h3L2Fy
bS9zbW11LWNvbW1vbi5jIGIvaHcvYXJtL3NtbXUtY29tbW9uLmMNCj4gPj4+IGluZGV4IGIxNWU3
ZmQwZTQuLjJlZTQ2OTEyOTkgMTAwNjQ0DQo+ID4+PiAtLS0gYS9ody9hcm0vc21tdS1jb21tb24u
Yw0KPiA+Pj4gKysrIGIvaHcvYXJtL3NtbXUtY29tbW9uLmMNCj4gPj4+IEBAIC05NTksNyArOTU5
LDEyIEBAIHN0YXRpYyB2b2lkIHNtbXVfYmFzZV9yZWFsaXplKERldmljZVN0YXRlDQo+ICpkZXYs
DQo+ID4+IEVycm9yICoqZXJycCkNCj4gPj4+ICAgICAgICAgICAgICAgICAgZ290byBvdXRfZXJy
Ow0KPiA+Pj4gICAgICAgICAgICAgIH0NCj4gPj4+ICAgICAgICAgIH0NCj4gPj4+IC0gICAgICAg
IHBjaV9zZXR1cF9pb21tdShwY2lfYnVzLCAmc21tdV9vcHMsIHMpOw0KPiA+Pj4gKw0KPiA+Pj4g
KyAgICAgICAgaWYgKHMtPnNtbXVfcGVyX2J1cykgew0KPiA+Pj4gKyAgICAgICAgICAgIHBjaV9z
ZXR1cF9pb21tdV9wZXJfYnVzKHBjaV9idXMsICZzbW11X29wcywgcyk7DQo+ID4+PiArICAgICAg
ICB9IGVsc2Ugew0KPiA+Pj4gKyAgICAgICAgICAgIHBjaV9zZXR1cF9pb21tdShwY2lfYnVzLCAm
c21tdV9vcHMsIHMpOw0KPiA+Pj4gKyAgICAgICAgfQ0KPiA+Pj4gICAgICAgICAgcmV0dXJuOw0K
PiA+Pj4gICAgICB9DQo+ID4+PiAgb3V0X2VycjoNCj4gPj4+IEBAIC05ODQsNiArOTg5LDcgQEAg
c3RhdGljIHZvaWQgc21tdV9iYXNlX3Jlc2V0X2V4aXQoT2JqZWN0ICpvYmosDQo+ID4+IFJlc2V0
VHlwZSB0eXBlKQ0KPiA+Pj4gIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSBzbW11X2Rldl9wcm9wZXJ0
aWVzW10gPSB7DQo+ID4+PiAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJidXNfbnVtIiwgU01NVVN0
YXRlLCBidXNfbnVtLCAwKSwNCj4gPj4+ICsgICAgREVGSU5FX1BST1BfQk9PTCgic21tdV9wZXJf
YnVzIiwgU01NVVN0YXRlLCBzbW11X3Blcl9idXMsDQo+ID4+IGZhbHNlKSwNCj4gPj4+ICAgICAg
REVGSU5FX1BST1BfTElOSygicHJpbWFyeS1idXMiLCBTTU1VU3RhdGUsIHByaW1hcnlfYnVzLA0K
PiA+Pj4gICAgICAgICAgICAgICAgICAgICAgIFRZUEVfUENJX0JVUywgUENJQnVzICopLA0KPiA+
Pj4gIH07DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My5jIGIvaHcvYXJtL3NtbXV2
My5jDQo+ID4+PiBpbmRleCBhYjY3OTcyMzUzLi5iY2Y4YWY4ZGM3IDEwMDY0NA0KPiA+Pj4gLS0t
IGEvaHcvYXJtL3NtbXV2My5jDQo+ID4+PiArKysgYi9ody9hcm0vc21tdXYzLmMNCj4gPj4+IEBA
IC0xOTk2LDYgKzE5OTYsOCBAQCBzdGF0aWMgdm9pZCBzbW11djNfY2xhc3NfaW5pdChPYmplY3RD
bGFzcw0KPiA+PiAqa2xhc3MsIGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4+PiAgICAgIGRldmljZV9j
bGFzc19zZXRfcGFyZW50X3JlYWxpemUoZGMsIHNtbXVfcmVhbGl6ZSwNCj4gPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYy0+cGFyZW50X3JlYWxpemUpOw0KPiA+Pj4g
ICAgICBkZXZpY2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCBzbW11djNfcHJvcGVydGllcyk7DQo+ID4+
PiArICAgIGRjLT5ob3RwbHVnZ2FibGUgPSBmYWxzZTsNCj4gPj4+ICsgICAgZGMtPnVzZXJfY3Jl
YXRhYmxlID0gdHJ1ZTsNCj4gPj4+ICB9DQo+ID4+Pg0KPiA+Pj4gIHN0YXRpYyBpbnQgc21tdXYz
X25vdGlmeV9mbGFnX2NoYW5nZWQoSU9NTVVNZW1vcnlSZWdpb24NCj4gKmlvbW11LA0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMgYi9ody9hcm0vdmlydC5jDQo+ID4+PiBpbmRleCAw
NWExNDg4MWNmLi44NjYyMTczYzQzIDEwMDY0NA0KPiA+Pj4gLS0tIGEvaHcvYXJtL3ZpcnQuYw0K
PiA+Pj4gKysrIGIvaHcvYXJtL3ZpcnQuYw0KPiA+Pj4gQEAgLTU2LDYgKzU2LDcgQEANCj4gPj4+
ICAjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCINCj4gPj4+ICAjaW5jbHVkZSAicWVtdS9lcnJvci1y
ZXBvcnQuaCINCj4gPj4+ICAjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCj4gPj4+ICsjaW5jbHVk
ZSAiaHcvcGNpL3BjaV9idXMuaCINCj4gPj4+ICAjaW5jbHVkZSAiaHcvcGNpLWhvc3QvZ3BleC5o
Ig0KPiA+Pj4gICNpbmNsdWRlICJody92aXJ0aW8vdmlydGlvLXBjaS5oIg0KPiA+Pj4gICNpbmNs
dWRlICJody9jb3JlL3N5c2J1cy1mZHQuaCINCj4gPj4+IEBAIC0xNDQwLDYgKzE0NDEsMjggQEAg
c3RhdGljIHZvaWQNCj4gY3JlYXRlX3NtbXV2M19kdF9iaW5kaW5ncyhjb25zdA0KPiA+PiBWaXJ0
TWFjaGluZVN0YXRlICp2bXMsIGh3YWRkciBiYXNlLA0KPiA+Pj4gICAgICBnX2ZyZWUobm9kZSk7
DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+ICtzdGF0aWMgdm9pZCBjcmVhdGVfc21tdXYzX2Rldl9k
dGIoVmlydE1hY2hpbmVTdGF0ZSAqdm1zLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBEZXZpY2VTdGF0ZSAqZGV2LCBQQ0lCdXMgKmJ1cykNCj4gPj4+ICt7DQo+ID4+
PiArICAgIFBsYXRmb3JtQnVzRGV2aWNlICpwYnVzID0gUExBVEZPUk1fQlVTX0RFVklDRSh2bXMt
DQo+ID4+PiBwbGF0Zm9ybV9idXNfZGV2KTsNCj4gPj4+ICsgICAgU3lzQnVzRGV2aWNlICpzYmRl
diA9IFNZU19CVVNfREVWSUNFKGRldik7DQo+ID4+PiArICAgIGludCBpcnEgPSBwbGF0Zm9ybV9i
dXNfZ2V0X2lycW4ocGJ1cywgc2JkZXYsIDApOw0KPiA+Pj4gKyAgICBod2FkZHIgYmFzZSA9IHBs
YXRmb3JtX2J1c19nZXRfbW1pb19hZGRyKHBidXMsIHNiZGV2LCAwKTsNCj4gPj4+ICsgICAgTWFj
aGluZVN0YXRlICptcyA9IE1BQ0hJTkUodm1zKTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgaWYgKHN0
cmNtcCgicGNpZS4wIiwgYnVzLT5xYnVzLm5hbWUpKSB7DQo+ID4+PiArICAgICAgICB3YXJuX3Jl
cG9ydCgiU01NVXYzIGRldmljZSBvbmx5IHN1cHBvcnRlZCB3aXRoIHBjaWUuMCBmb3INCj4gRFQi
KTsNCj4gPj4gd2hpbGUgdGVzdGluZyB0aGUgc2VyaWVzIEkgaGl0IHRoZSB3YXJuaW5nIHdpdGgg
YSByaGVsIGd1ZXN0IHdoaWNoIGJvb3RzDQo+ID4+IHdpdGggQUNQSS4NCj4gPj4gSSB0aGluayB3
ZSBzaGFsbCBtYWtlIHRoZSBjaGVjayBzbWFydGVyIHRvIGF2b2lkIHRoYXQuDQo+ID4+IG1heWJl
IGFsc28gY2hlY2sgZmlybXdhcmVfbG9hZGVkIGFuZCB2aXJ0X2lzX2FjcGlfZW5hYmxlZCgpPw0K
PiA+IFRoYW5rcyBmb3IgZ2l2aW5nIGl0IGEgc3Bpbi4gWWVzLCBqdXN0IGNvbmZpcm1lZCB0aGF0
IHRoZSB3YXJuaW5nIGFwcGVhcnMuDQo+ID4gVGhlIGFib3ZlIGNoZWNrIHdpbGwgd29yaywgYnV0
IGNhbiB3ZSBtYWtlIHVzZSBvZiB2bXMtPmFjcGlfZGV2IGZvcg0KPiA+IHRoaXMgY2hlY2sgaW5z
dGVhZD8gSXQgaXMgZXNzZW50aWFsbHkgdGhlIHNhbWUgYW5kIEkgdGhpbmsgdGhhdCB3aWxsIHdv
cmsuDQo+ID4NCj4gPiAgICAgaWYgKCF2bXMtPmFjcGlfZGV2ICYmIHN0cmNtcCgicGNpZS4wIiwg
YnVzLT5xYnVzLm5hbWUpKQ0KPiB0aGUgbG9naWNhbCBkZXBlbmRlbmN5IG9uIGFjcGlfZGV2IGlz
IG1heWJlIG5vdCB0aGF0IHN0cmFpZ2h0Zm9yd2FyZC4NCj4gQWxzbyBpdCBoYXMgaGFzX2dlZCBh
bmQgYWFyY2g2NCBjaGVjaw0KPiBJIHRoaW5nIEkgd291bGQgc2ltcGx5IGNoZWNrICEoZmlybXdh
cmVfbG9hZGVkICYmDQo+IHZpcnRfaXNfYWNwaV9lbmFibGVkKHZtcykpLiBhYm91dCB0aGUgYWFy
Y2g2NCBjaGVjayBJIGFtIG5vdCBzdXJlIHRoaXMNCj4gaXMgbmVlZGVkLg0KDQpSaWdodC4gSSB0
aGluayBoYXNfZ2VkIGlzIGVuYWJsZSBieSBkZWZhdWx0IGZyb20gNC4xIGFuZCBvbiBhYXJjaDY0
LCBpc24ndA0KU01NVVYzIG9ubHkgZW5hYmxlZCBmb3IgQVJNNjQgY2FzZXM/IEF0IGxlYXN0IG9u
IGtlcm5lbCBpdCBpcywgSSB0aGluay4NCg0KQW55d2F5LCBhZ3JlZSwgdGhlIGZpcm13YXJlX2xv
YWRlZCAmJiB2aXJ0X2lzX2FjcGlfZW5hYmxlZCh2bXMpIGlzDQptb3JlIHJlYWRhYmxlLiBJIHdp
bGwgZml4IGl0Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

