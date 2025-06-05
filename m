Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19CCC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN8YA-0007XH-Sn; Thu, 05 Jun 2025 07:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uN8Y8-0007Wp-M1; Thu, 05 Jun 2025 07:14:20 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uN8Y6-0008JW-Ps; Thu, 05 Jun 2025 07:14:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bChfB1569z6K92c;
 Thu,  5 Jun 2025 19:13:54 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 9ED931402F3;
 Thu,  5 Jun 2025 19:14:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 13:14:08 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 5 Jun 2025 13:14:08 +0200
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
Subject: RE: [PATCH v3 3/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Topic: [PATCH v3 3/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Index: AQHb09UHlACLRi0rpkeRI8gAlENq9LP0N1YAgAA2neA=
Date: Thu, 5 Jun 2025 11:14:08 +0000
Message-ID: <29fbc5cb09844d5785ca4e8cf77ca288@huawei.com>
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-4-shameerali.kolothum.thodi@huawei.com>
 <af1f7082-dc4b-4f44-9b85-aa6ba9221e71@redhat.com>
In-Reply-To: <af1f7082-dc4b-4f44-9b85-aa6ba9221e71@redhat.com>
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSA1LCAyMDI1IDEwOjU4
IEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiBxZW11LWRldmVs
QG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5j
b207IG5pY29saW5jQG52aWRpYS5jb207DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOw0KPiBtb2Noc0BudmlkaWEuY29tOyBzbW9z
dGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6
aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiBqaWFuZ2t1bmt1biA8amlhbmdr
dW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMy82XSBody9hcm0vdmlydC1hY3BpLWJ1aWxkOiBVcGRhdGUgSU9SVCBmb3INCj4gbXVs
dGlwbGUgc21tdXYzIGRldmljZXMNCj4gDQo+IEhpIFNoYW1lZXIsDQo+IE9uIDYvMi8yNSA1OjQx
IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IFdpdGggdGhlIHNvb24gdG8gYmUgaW50
cm9kdWNlZCB1c2VyLWNyZWF0YWJsZSBTTU1VdjMgZGV2aWNlcyBmb3IgdmlydCwNCj4gPiBpdCBp
cyBwb3NzaWJsZSB0byBoYXZlIG11bHRpcGxlIFNNTVV2MyBkZXZpY2VzIGFzc29jaWF0ZWQgd2l0
aA0KPiA+IGRpZmZlcmVudCBQQ0llIHJvb3QgY29tcGxleGVzLg0KPiA+DQo+ID4gVXBkYXRlIElP
UlQgbm9kZXMgYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtv
bG90aHVtDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0t
DQo+ID4gIGh3L2FybS92aXJ0LWFjcGktYnVpbGQuYyB8IDU0DQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYyBi
L2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYyBpbmRleA0KPiA+IGJkMjY4NTNlZjYuLmI0ZmY3MWI4
YjcgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jDQo+ID4gKysrIGIv
aHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jDQo+ID4gQEAgLTQzLDYgKzQzLDcgQEANCj4gPiAgI2lu
Y2x1ZGUgImh3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuaCINCj4gPiAgI2luY2x1ZGUgImh3
L2FjcGkvdHBtLmgiDQo+ID4gICNpbmNsdWRlICJody9hY3BpL2htYXQuaCINCj4gPiArI2luY2x1
ZGUgImh3L2FybS9zbW11djMuaCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2llX2hvc3QuaCIN
Cj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2kuaCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2lf
YnVzLmgiDQo+ID4gQEAgLTI4OCw2ICsyODksNTQgQEAgZ2V0X3NtbXV2M19sZWdhY3lfZGV2KFZp
cnRNYWNoaW5lU3RhdGUgKnZtcywNCj4gdm9pZCAqb3BhcXVlKQ0KPiA+ICAgICAgZ19hcnJheV9h
cHBlbmRfdmFsKHNkZXZfYmxvYiwgc2Rldik7ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzbW11
djNfZGV2X2lkbWFwX2NvbXBhcmUoZ2NvbnN0cG9pbnRlciBhLCBnY29uc3Rwb2ludGVyDQo+IGIp
DQo+ID4gK3sNCj4gPiArICAgIEFjcGlJb3J0U01NVXYzRGV2ICpzZGV2X2EgPSAoQWNwaUlvcnRT
TU1VdjNEZXYgKilhOw0KPiA+ICsgICAgQWNwaUlvcnRTTU1VdjNEZXYgKnNkZXZfYiA9IChBY3Bp
SW9ydFNNTVV2M0RldiAqKWI7DQo+ID4gKyAgICBBY3BpSW9ydElkTWFwcGluZyAqbWFwX2EgPSAm
Z19hcnJheV9pbmRleChzZGV2X2EtPmlkbWFwcywNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEFjcGlJb3J0SWRNYXBwaW5nLCAwKTsNCj4gPiArICAg
IEFjcGlJb3J0SWRNYXBwaW5nICptYXBfYiA9ICZnX2FycmF5X2luZGV4KHNkZXZfYi0+aWRtYXBz
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQWNw
aUlvcnRJZE1hcHBpbmcsIDApOw0KPiA+ICsgICAgcmV0dXJuIG1hcF9hLT5pbnB1dF9iYXNlIC0g
bWFwX2ItPmlucHV0X2Jhc2U7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZ2V0X3NtbXV2M19k
ZXZpY2VzKE9iamVjdCAqb2JqLCB2b2lkICpvcGFxdWUpIHsNCj4gPiArICAgIFZpcnRNYWNoaW5l
U3RhdGUgKnZtcyA9IFZJUlRfTUFDSElORShxZGV2X2dldF9tYWNoaW5lKCkpOw0KPiA+ICsgICAg
R0FycmF5ICpzZGV2X2Jsb2IgPSBvcGFxdWU7DQo+ID4gKyAgICBBY3BpSW9ydElkTWFwcGluZyBp
ZG1hcDsNCj4gPiArICAgIFBsYXRmb3JtQnVzRGV2aWNlICpwYnVzOw0KPiA+ICsgICAgQWNwaUlv
cnRTTU1VdjNEZXYgc2RldjsNCj4gPiArICAgIGludCBtaW5fYnVzLCBtYXhfYnVzOw0KPiA+ICsg
ICAgU3lzQnVzRGV2aWNlICpzYmRldjsNCj4gPiArICAgIFBDSUJ1cyAqYnVzOw0KPiA+ICsNCj4g
PiArICAgIGlmICghb2JqZWN0X2R5bmFtaWNfY2FzdChvYmosIFRZUEVfQVJNX1NNTVVWMykpIHsN
Cj4gPiArICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBidXMg
PSBQQ0lfQlVTKG9iamVjdF9wcm9wZXJ0eV9nZXRfbGluayhvYmosICJwcmltYXJ5LWJ1cyIsDQo+
ICZlcnJvcl9hYm9ydCkpOw0KPiA+ICsgICAgaWYgKCFidXMpIHsNCj4gPiArICAgICAgICByZXR1
cm4gMDsNCj4gPiArICAgIH0NCj4gY2FuIGl0IGhhcHBlbiBhZnRlciBwYXRjaCAxPw0KDQpOb3Qg
cmVhbGx5LiBXaWxsIHJlbW92ZS4NCg0KPiA+ICsNCj4gPiArICAgIHBidXMgPSBQTEFURk9STV9C
VVNfREVWSUNFKHZtcy0+cGxhdGZvcm1fYnVzX2Rldik7DQo+ID4gKyAgICBzYmRldiA9IFNZU19C
VVNfREVWSUNFKG9iaik7DQo+ID4gKyAgICBzZGV2LmJhc2UgPSBwbGF0Zm9ybV9idXNfZ2V0X21t
aW9fYWRkcihwYnVzLCBzYmRldiwgMCk7DQo+ID4gKyAgICBzZGV2LmJhc2UgKz0gdm1zLT5tZW1t
YXBbVklSVF9QTEFURk9STV9CVVNdLmJhc2U7DQo+ID4gKyAgICBzZGV2LmlycSA9IHBsYXRmb3Jt
X2J1c19nZXRfaXJxbihwYnVzLCBzYmRldiwgMCk7DQo+ID4gKyAgICBzZGV2LmlycSArPSB2bXMt
PmlycW1hcFtWSVJUX1BMQVRGT1JNX0JVU107DQo+ID4gKyAgICBzZGV2LmlycSArPSBBUk1fU1BJ
X0JBU0U7DQo+ID4gKw0KPiA+ICsgICAgcGNpX2J1c19yYW5nZShidXMsICZtaW5fYnVzLCAmbWF4
X2J1cyk7DQo+ID4gKyAgICBzZGV2LmlkbWFwcyA9IGdfYXJyYXlfbmV3KGZhbHNlLCB0cnVlLCBz
aXplb2YoQWNwaUlvcnRJZE1hcHBpbmcpKTsNCj4gPiArICAgIGlkbWFwLmlucHV0X2Jhc2UgPSBt
aW5fYnVzIDw8IDgsDQo+ID4gKyAgICBpZG1hcC5pZF9jb3VudCA9IChtYXhfYnVzIC0gbWluX2J1
cyArIDEpIDw8IDgsDQo+ID4gKyAgICBnX2FycmF5X2FwcGVuZF92YWwoc2Rldi5pZG1hcHMsIGlk
bWFwKTsNCj4gPiArICAgIGdfYXJyYXlfYXBwZW5kX3ZhbChzZGV2X2Jsb2IsIHNkZXYpOw0KPiA+
ICsgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIElucHV0IE91
dHB1dCBSZW1hcHBpbmcgVGFibGUgKElPUlQpDQo+ID4gICAqIENvbmZvcm1zIHRvICJJTyBSZW1h
cHBpbmcgVGFibGUgU3lzdGVtIFNvZnR3YXJlIG9uIEFSTQ0KPiBQbGF0Zm9ybXMiLA0KPiA+IEBA
IC0zMTksNiArMzY4LDExIEBAIGJ1aWxkX2lvcnQoR0FycmF5ICp0YWJsZV9kYXRhLCBCSU9TTGlu
a2VyDQo+ICpsaW5rZXIsIFZpcnRNYWNoaW5lU3RhdGUgKnZtcykNCj4gPiAgICAgICAgICAgKi8N
Cj4gPiAgICAgICAgICBzZGV2ID0gJmdfYXJyYXlfaW5kZXgoc21tdXYzX2RldnMsIEFjcGlJb3J0
U01NVXYzRGV2LCAwKTsNCj4gPiAgICAgICAgICBnX2FycmF5X3NvcnQoc2Rldi0+aWRtYXBzLCBp
b3J0X2lkbWFwX2NvbXBhcmUpOw0KPiA+ICsgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICBvYmpl
Y3RfY2hpbGRfZm9yZWFjaF9yZWN1cnNpdmUob2JqZWN0X2dldF9yb290KCksDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdldF9zbW11djNfZGV2aWNlcywgc21t
dXYzX2RldnMpOw0KPiA+ICsgICAgICAgIC8qIFNvcnQgdGhlIHNtbXV2MyBkZXZpY2VzKGlmIGFu
eSkgYnkgc21tdSBpZG1hcCBpbnB1dF9iYXNlICovDQo+ID4gKyAgICAgICAgZ19hcnJheV9zb3J0
KHNtbXV2M19kZXZzLCBzbW11djNfZGV2X2lkbWFwX2NvbXBhcmUpOw0KPiBHaXZlbiB0aGUgZ29y
d2luZyBjb21wbGV4aXR5IG9mIHRoZSBJRE1BUCBjb21wdXRhdGlvbiBjb21wdXRhdGlvbiBJDQo+
IHdvdWxkIHN1Z2dlc3QgdG8gYWRkIHNvbWUgSURNQVAgZXhhbXBsZXMgZWl0aGVyIGluIGNvbW1l
bnQgb3IgY29tbWl0DQo+IG1zZyB0byBpbGx1c3RyYXRlIGhvdyB0aGUgaWRtYXBzIGxvb2sgbGlr
ZSAoc2ltaWxhciB0byB3aGF0IGNhbiBiZSBmb3VuZCBpbg0KPiB0aGUgSU9SVCBzcGVjKS4NCg0K
T2suIEkgd2lsbCBhZGQgc29tZSBjb21tZW50cyB3aXRoIGV4YW1wbGUgdG8gZGVzY3JpYmUgdGhl
IG1hcHBpbmdzLg0KDQpUaGFua3MsDQpTaGFtZWVyDQogDQoNCg==

