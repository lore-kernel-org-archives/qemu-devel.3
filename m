Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5BAC83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 07:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW8Wt-0002Vt-I8; Mon, 30 Jun 2025 03:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uW8Wk-0002Ts-Py; Mon, 30 Jun 2025 03:02:06 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uW8Wg-0002me-Cu; Mon, 30 Jun 2025 03:02:05 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bVxpH3G4tz6L56p;
 Mon, 30 Jun 2025 14:58:47 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 41CE71404F9;
 Mon, 30 Jun 2025 15:01:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 09:01:34 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 09:01:34 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v5 01/11] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Thread-Topic: [PATCH v5 01/11] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Thread-Index: AQHb5DEr1suXs2EpZkOF8l8kChjVYbQWyeSAgASGELA=
Date: Mon, 30 Jun 2025 07:01:33 +0000
Message-ID: <5a0ee9d2e27e47e6a4b443ef6e645b52@huawei.com>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-2-shameerali.kolothum.thodi@huawei.com>
 <ce1d4b22-d613-4143-9b50-bd3e8047bff8@redhat.com>
In-Reply-To: <ce1d4b22-d613-4143-9b50-bd3e8047bff8@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAy
NSAxMjo1MiBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFs
aS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0Bu
dmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJl
cnJhbmdlQHJlZGhhdC5jb207IGltYW1tZWRvQHJlZGhhdC5jb207DQo+IG5hdGhhbmNAbnZpZGlh
LmNvbTsgbW9jaHNAbnZpZGlhLmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsNCj4gZ3VzdGF2by5y
b21lcm9AbGluYXJvLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhv
dQ0KPiAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vu
a3VuQGh1YXdlaS5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb20+Ow0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDAxLzExXSBody9hcm0vc21tdS1jb21tb246IENoZWNrIFNNTVUgaGFzDQo+IFBDSWUg
Um9vdCBDb21wbGV4IGFzc29jaWF0aW9uDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNi8y
My8yNSAxMTo0MiBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBXZSBvbmx5IGFsbG93
IGRlZmF1bHQgUENJZSBSb290IENvbXBsZXgocGNpZS4wKSBvciBweGItcGNpZSBiYXNlZCBleHRy
YQ0KPiA+IHJvb3QgY29tcGxleGVzIHRvIGJlIGFzc29jaWF0ZWQgd2l0aCBTTU1VLg0KPiA+DQo+
ID4gQWx0aG91Z2ggdGhpcyBjaGFuZ2UgZG9lcyBub3QgYWZmZWN0IGZ1bmN0aW9uYWxpdHkgYXQg
cHJlc2VudCwgaXQgaXMNCj4gPiByZXF1aXJlZCB3aGVuIHdlIGFkZCBzdXBwb3J0IGZvciB1c2Vy
LWNyZWF0YWJsZSBTTU1VdjMgZGV2aWNlcyBpbg0KPiA+IGZ1dHVyZSBwYXRjaGVzLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9hcm0vc21tdS1jb21tb24uYyAg
ICAgICAgICAgICAgICB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIGh3
L3BjaS1icmlkZ2UvcGNpX2V4cGFuZGVyX2JyaWRnZS5jIHwgIDEgLQ0KPiA+ICBpbmNsdWRlL2h3
L3BjaS9wY2lfYnJpZGdlLmggICAgICAgICB8ICAxICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAy
NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L2FybS9zbW11LWNvbW1vbi5jIGIvaHcvYXJtL3NtbXUtY29tbW9uLmMNCj4gPiBpbmRleCBmMzli
OTllNTI2Li5iMTVlN2ZkMGU0IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11LWNvbW1vbi5j
DQo+ID4gKysrIGIvaHcvYXJtL3NtbXUtY29tbW9uLmMNCj4gPiBAQCAtMjAsNiArMjAsNyBAQA0K
PiA+ICAjaW5jbHVkZSAidHJhY2UuaCINCj4gPiAgI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X3BhZ2Uu
aCINCj4gPiAgI2luY2x1ZGUgImh3L2NvcmUvY3B1LmgiDQo+ID4gKyNpbmNsdWRlICJody9wY2kv
cGNpX2JyaWRnZS5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQo+ID4g
ICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ID4gICNpbmNsdWRlICJxZW11L2poYXNoLmgiDQo+
ID4gQEAgLTkyNSw2ICs5MjYsNyBAQCBzdGF0aWMgdm9pZCBzbW11X2Jhc2VfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LA0KPiBFcnJvciAqKmVycnApDQo+ID4gIHsNCj4gPiAgICAgIFNNTVVTdGF0
ZSAqcyA9IEFSTV9TTU1VKGRldik7DQo+ID4gICAgICBTTU1VQmFzZUNsYXNzICpzYmMgPSBBUk1f
U01NVV9HRVRfQ0xBU1MoZGV2KTsNCj4gPiArICAgIFBDSUJ1cyAqcGNpX2J1cyA9IHMtPnByaW1h
cnlfYnVzOw0KPiA+ICAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ID4NCj4gPiAgICAg
IHNiYy0+cGFyZW50X3JlYWxpemUoZGV2LCAmbG9jYWxfZXJyKTsNCj4gPiBAQCAtOTM3LDExICs5
MzksMzIgQEAgc3RhdGljIHZvaWQgc21tdV9iYXNlX3JlYWxpemUoRGV2aWNlU3RhdGUNCj4gKmRl
diwgRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ19mcmVlLCBnX2ZyZWUpOw0KPiA+ICAgICAgcy0+c21tdV9wY2lidXNfYnlfYnVzcHRyID0g
Z19oYXNoX3RhYmxlX25ldyhOVUxMLCBOVUxMKTsNCj4gPg0KPiA+IC0gICAgaWYgKHMtPnByaW1h
cnlfYnVzKSB7DQo+ID4gLSAgICAgICAgcGNpX3NldHVwX2lvbW11KHMtPnByaW1hcnlfYnVzLCAm
c21tdV9vcHMsIHMpOw0KPiA+IC0gICAgfSBlbHNlIHsNCj4gPiArICAgIGlmICghcGNpX2J1cykg
ew0KPiA+ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlNNTVUgaXMgbm90IGF0dGFjaGVkIHRv
IGFueSBQQ0kgYnVzISIpOw0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiAr
DQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogV2Ugb25seSBhbGxvdyBkZWZhdWx0IFBDSWUgUm9v
dCBDb21wbGV4KHBjaWUuMCkgb3IgcHhiLXBjaWUgYmFzZWQNCj4gZXh0cmENCj4gPiArICAgICAq
IHJvb3QgY29tcGxleGVzIHRvIGJlIGFzc29jaWF0ZWQgd2l0aCBTTU1VLg0KPiA+ICsgICAgICov
DQo+ID4gKyAgICBpZiAocGNpX2J1c19pc19leHByZXNzKHBjaV9idXMpICYmIHBjaV9idXNfaXNf
cm9vdChwY2lfYnVzKSAmJg0KPiA+ICsgICAgICAgIG9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNU
KHBjaV9idXMpLT5wYXJlbnQsDQo+IFRZUEVfUENJX0hPU1RfQlJJREdFKSkgew0KPiA+ICsgICAg
ICAgIC8qDQo+ID4gKyAgICAgICAgICogRm9yIHB4Yi1wY2llLCBwYXJlbnRfZGV2IHdpbGwgYmUg
c2V0LiBNYWtlIHN1cmUgaXQgaXMNCj4gPiArICAgICAgICAgKiBweGItcGNpZSBpbmRlZWQuDQo+
ID4gKyAgICAgICAgICovDQo+ID4gKyAgICAgICAgaWYgKHBjaV9idXMtPnBhcmVudF9kZXYpIHsN
Cj4gPiArICAgICAgICAgICAgaWYgKCFvYmplY3RfZHluYW1pY19jYXN0KE9CSkVDVChwY2lfYnVz
KSwgVFlQRV9QWEJfUENJRV9CVVMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICBnb3RvIG91dF9l
cnI7DQo+ID4gKyAgICAgICAgICAgIH0NCj4gSSBzdGlsbCB3b25kZXIgd2hldGhlciB0aGUgYWJv
dmUgY2hlY2sgd2FzIG1hbmRhdGVkIGFzIGl0IHdvcmtzIGZvciB3aGF0DQo+IGl0IGlzIG1lYW50
Og0KDQpBZGRlZCB0aGF0IGNoZWNrIHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBzdXBwb3J0IHB4Yi1j
eGwgd2hpY2ggaXMgb2YgdHlwZQ0KUENJX0hPU1RfQlJJREdFLiBPbmNlIHRoZSBjeGwgc3VwcG9y
dCBmb3IgQVJNIGlzIHVwIHN0cmVhbWVkIGFuZCB0ZXN0ZWQNCndpdGggU01NVXYzLCB3ZSBjYW4g
cmVsYXggdGhpcyBpZiByZXF1aXJlZC4NCg0KPiBSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg==

