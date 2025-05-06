Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FB6C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCESt-0001KA-6C; Tue, 06 May 2025 05:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCESm-0001JH-GD; Tue, 06 May 2025 05:19:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCESj-0002pi-U4; Tue, 06 May 2025 05:19:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsCWy3JVPz6K9lD;
 Tue,  6 May 2025 17:19:26 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id BD555140373;
 Tue,  6 May 2025 17:19:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 11:19:36 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 6 May 2025 11:19:36 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 3/6] hw/arm/virt: Factor out common SMMUV3 dt bindings
 code
Thread-Topic: [PATCH v2 3/6] hw/arm/virt: Factor out common SMMUV3 dt bindings
 code
Thread-Index: AQHbu00b8fX0gegQfEO/g7XdQ0ReRLPDoJAAgAG27NA=
Date: Tue, 6 May 2025 09:19:36 +0000
Message-ID: <e2e43104047e4294b3feab4726512e0a@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-4-shameerali.kolothum.thodi@huawei.com>
 <fd53570b-7e2c-47db-9d31-93a9d2327f2f@redhat.com>
In-Reply-To: <fd53570b-7e2c-47db-9d31-93a9d2327f2f@redhat.com>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSA1LCAyMDI1IDEwOjAyIEFN
DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiBxZW11LWRldmVsQG5v
bmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207
IG5pY29saW5jQG52aWRpYS5jb207DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVk
aGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOw0KPiBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFm
YUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91
IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiBqaWFuZ2t1bmt1biA8amlhbmdrdW5r
dW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVh
d2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMy82XSBody9hcm0vdmlydDogRmFjdG9yIG91dCBjb21tb24gU01NVVYzIGR0DQo+IGJpbmRp
bmdzIGNvZGUNCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA1LzIvMjUgMTI6MjcgUE0sIFNo
YW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGludGVuZGVk
LiBUaGlzIHdpbGwgYmUgdXNlZnVsIHdoZW4gd2UNCj4gPiBhZGQgc3VwcG9ydCBmb3IgdXNlci1j
cmVhdGFibGUgc21tdXYzIGRldmljZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIg
S29sb3RodW0NCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gPiAt
LS0NCj4gPiAgaHcvYXJtL3ZpcnQuYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9u
cygrKSwgMjUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3ZpcnQu
YyBiL2h3L2FybS92aXJ0LmMNCj4gPiBpbmRleCBkZDM1NWY0NDU0Li40NjRlODRhZTY3IDEwMDY0
NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4gPiArKysgYi9ody9hcm0vdmlydC5jDQo+ID4g
QEAgLTE0MTgsMTkgKzE0MTgsNDMgQEAgc3RhdGljIHZvaWQgY3JlYXRlX3BjaWVfaXJxX21hcChj
b25zdA0KPiBNYWNoaW5lU3RhdGUgKm1zLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAweDcgICAgICAgICAgIC8qIFBDSSBpcnEgKi8pOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGlj
IHZvaWQgY3JlYXRlX3NtbXV2M19kdF9iaW5kaW5ncyhjb25zdCBWaXJ0TWFjaGluZVN0YXRlICp2
bXMsDQo+IGh3YWRkciBiYXNlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGh3YWRkciBzaXplLCBpbnQgaXJxKQ0KPiA+ICt7DQo+ID4gKyAgICBjaGFyICpub2Rl
Ow0KPiA+ICsgICAgY29uc3QgY2hhciBjb21wYXRbXSA9ICJhcm0sc21tdS12MyI7DQo+ID4gKyAg
ICBjb25zdCBjaGFyIGlycV9uYW1lc1tdID0gImV2ZW50cVwwcHJpcVwwY21kcS1zeW5jXDBnZXJy
b3IiOw0KPiA+ICsgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUodm1zKTsNCj4gPiArDQo+
ID4gKyAgICBub2RlID0gZ19zdHJkdXBfcHJpbnRmKCIvc21tdXYzQCUiIFBSSXg2NCwgYmFzZSk7
DQo+ID4gKyAgICBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCBub2RlKTsNCj4gPiArICAg
IHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9kZSwgImNvbXBhdGlibGUiLCBjb21wYXQsDQo+
IHNpemVvZihjb21wYXQpKTsNCj4gPiArICAgIHFlbXVfZmR0X3NldHByb3Bfc2l6ZWRfY2VsbHMo
bXMtPmZkdCwgbm9kZSwgInJlZyIsIDIsIGJhc2UsIDIsIHNpemUpOw0KPiA+ICsNCj4gPiArICAg
IHFlbXVfZmR0X3NldHByb3BfY2VsbHMobXMtPmZkdCwgbm9kZSwgImludGVycnVwdHMiLA0KPiA+
ICsgICAgICAgICAgICBHSUNfRkRUX0lSUV9UWVBFX1NQSSwgaXJxICAgICwgR0lDX0ZEVF9JUlFf
RkxBR1NfRURHRV9MT19ISSwNCj4gPiArICAgICAgICAgICAgR0lDX0ZEVF9JUlFfVFlQRV9TUEks
IGlycSArIDEsDQo+IEdJQ19GRFRfSVJRX0ZMQUdTX0VER0VfTE9fSEksDQo+ID4gKyAgICAgICAg
ICAgIEdJQ19GRFRfSVJRX1RZUEVfU1BJLCBpcnEgKyAyLA0KPiBHSUNfRkRUX0lSUV9GTEFHU19F
REdFX0xPX0hJLA0KPiA+ICsgICAgICAgICAgICBHSUNfRkRUX0lSUV9UWVBFX1NQSSwgaXJxICsg
MywNCj4gR0lDX0ZEVF9JUlFfRkxBR1NfRURHRV9MT19ISSk7DQo+ID4gKw0KPiA+ICsgICAgcWVt
dV9mZHRfc2V0cHJvcChtcy0+ZmR0LCBub2RlLCAiaW50ZXJydXB0LW5hbWVzIiwgaXJxX25hbWVz
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzaXplb2YoaXJxX25hbWVzKSk7DQo+ID4gKw0K
PiA+ICsgICAgcWVtdV9mZHRfc2V0cHJvcChtcy0+ZmR0LCBub2RlLCAiZG1hLWNvaGVyZW50Iiwg
TlVMTCwgMCk7DQo+ID4gKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZSwg
IiNpb21tdS1jZWxscyIsIDEpOw0KPiA+ICsgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5m
ZHQsIG5vZGUsICJwaGFuZGxlIiwgdm1zLQ0KPiA+aW9tbXVfcGhhbmRsZSk7DQo+ID4gKyAgICBn
X2ZyZWUobm9kZSk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIGNyZWF0ZV9zbW11
KGNvbnN0IFZpcnRNYWNoaW5lU3RhdGUgKnZtcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgUENJQnVzICpidXMpDQo+ID4gIHsNCj4gPiAgICAgIFZpcnRNYWNoaW5lQ2xhc3MgKnZtYyA9
IFZJUlRfTUFDSElORV9HRVRfQ0xBU1Modm1zKTsNCj4gPiAtICAgIGNoYXIgKm5vZGU7DQo+ID4g
LSAgICBjb25zdCBjaGFyIGNvbXBhdFtdID0gImFybSxzbW11LXYzIjsNCj4gPiAgICAgIGludCBp
cnEgPSAgdm1zLT5pcnFtYXBbVklSVF9TTU1VXTsNCj4gPiAgICAgIGludCBpOw0KPiA+ICAgICAg
aHdhZGRyIGJhc2UgPSB2bXMtPm1lbW1hcFtWSVJUX1NNTVVdLmJhc2U7DQo+ID4gICAgICBod2Fk
ZHIgc2l6ZSA9IHZtcy0+bWVtbWFwW1ZJUlRfU01NVV0uc2l6ZTsNCj4gPiAtICAgIGNvbnN0IGNo
YXIgaXJxX25hbWVzW10gPSAiZXZlbnRxXDBwcmlxXDBjbWRxLXN5bmNcMGdlcnJvciI7DQo+ID4g
ICAgICBEZXZpY2VTdGF0ZSAqZGV2Ow0KPiA+IC0gICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJ
TkUodm1zKTsNCj4gPg0KPiA+ICAgICAgaWYgKHZtcy0+aW9tbXUgIT0gVklSVF9JT01NVV9TTU1V
VjMgfHwgIXZtcy0+aW9tbXVfcGhhbmRsZSkgew0KPiA+ICAgICAgICAgIHJldHVybjsNCj4gPiBA
QCAtMTQ0OSwyNyArMTQ3Myw3IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV9zbW11KGNvbnN0DQo+IFZp
cnRNYWNoaW5lU3RhdGUgKnZtcywNCj4gPiAgICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEoU1lT
X0JVU19ERVZJQ0UoZGV2KSwgaSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRl
dl9nZXRfZ3Bpb19pbih2bXMtPmdpYywgaXJxICsgaSkpOw0KPiA+ICAgICAgfQ0KPiA+IC0NCj4g
PiAtICAgIG5vZGUgPSBnX3N0cmR1cF9wcmludGYoIi9zbW11djNAJSIgUFJJeDY0LCBiYXNlKTsN
Cj4gPiAtICAgIHFlbXVfZmR0X2FkZF9zdWJub2RlKG1zLT5mZHQsIG5vZGUpOw0KPiA+IC0gICAg
cWVtdV9mZHRfc2V0cHJvcChtcy0+ZmR0LCBub2RlLCAiY29tcGF0aWJsZSIsIGNvbXBhdCwNCj4g
c2l6ZW9mKGNvbXBhdCkpOw0KPiA+IC0gICAgcWVtdV9mZHRfc2V0cHJvcF9zaXplZF9jZWxscyht
cy0+ZmR0LCBub2RlLCAicmVnIiwgMiwgYmFzZSwgMiwgc2l6ZSk7DQo+ID4gLQ0KPiA+IC0gICAg
cWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+ZmR0LCBub2RlLCAiaW50ZXJydXB0cyIsDQo+ID4g
LSAgICAgICAgICAgIEdJQ19GRFRfSVJRX1RZUEVfU1BJLCBpcnEgICAgLCBHSUNfRkRUX0lSUV9G
TEFHU19FREdFX0xPX0hJLA0KPiA+IC0gICAgICAgICAgICBHSUNfRkRUX0lSUV9UWVBFX1NQSSwg
aXJxICsgMSwgR0lDX0ZEVF9JUlFfRkxBR1NfRURHRV9MT19ISSwNCj4gPiAtICAgICAgICAgICAg
R0lDX0ZEVF9JUlFfVFlQRV9TUEksIGlycSArIDIsIEdJQ19GRFRfSVJRX0ZMQUdTX0VER0VfTE9f
SEksDQo+ID4gLSAgICAgICAgICAgIEdJQ19GRFRfSVJRX1RZUEVfU1BJLCBpcnEgKyAzLA0KPiBH
SUNfRkRUX0lSUV9GTEFHU19FREdFX0xPX0hJKTsNCj4gPiAtDQo+ID4gLSAgICBxZW11X2ZkdF9z
ZXRwcm9wKG1zLT5mZHQsIG5vZGUsICJpbnRlcnJ1cHQtbmFtZXMiLCBpcnFfbmFtZXMsDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgIHNpemVvZihpcnFfbmFtZXMpKTsNCj4gPiAtDQo+ID4gLSAg
ICBxZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGUsICJkbWEtY29oZXJlbnQiLCBOVUxMLCAw
KTsNCj4gPiAtDQo+ID4gLSAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZSwg
IiNpb21tdS1jZWxscyIsIDEpOw0KPiA+IC0NCj4gPiAtICAgIHFlbXVfZmR0X3NldHByb3BfY2Vs
bChtcy0+ZmR0LCBub2RlLCAicGhhbmRsZSIsIHZtcy0NCj4gPmlvbW11X3BoYW5kbGUpOw0KPiA+
IC0gICAgZ19mcmVlKG5vZGUpOw0KPiA+ICsgICAgY3JlYXRlX3NtbXV2M19kdF9iaW5kaW5ncyh2
bXMsIGJhc2UsIHNpemUsIGlycSk7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBjcmVh
dGVfdmlydGlvX2lvbW11X2R0X2JpbmRpbmdzKFZpcnRNYWNoaW5lU3RhdGUgKnZtcykNCj4gUmV2
aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gDQo+IG5vdGhp
bmcgdG8gZG8gd2l0aCB0aGF0IHBhdGNoIGJ1dCBJIGp1c3Qgbm90aWNlZCB3ZSBvbWl0dGVkIHRv
IHN1cHBvcnQgdGhlDQo+IA0KPiBieXBhc3NfaW9tbXU9dHJ1ZSBhbG9uZyB3aXRoIERUIG1vZGUu
IEkgZG9uJ3Qgc2VlIHRoZSBpb21tdS1tYXANCj4gcHJvcGVydHkgc2V0IGFjY29yZGluZ2x5Lg0K
PiANCj4gU29tZXRoaW5nIHRvIGZ1cnRoZXIgY29uc29saWRhdGU/DQoNClllcy4gSXQgbG9va3Mg
bGlrZSBjdXJyZW50bHkgdGhlIHZpcnQgU01NVXYzIERUIGNvZGUgZG9lc24ndCB0YWtlIGNhcmUg
b2YNCmJ5cGFzc19pb21tdT10cnVlIGNhc2UuIEkgd2lsbCBhZGQgdGhhdCBjaGVjay4NCg0KVGhh
bmtzLA0KU2hhbWVlcg0K

