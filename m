Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032A1D49211
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 11:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD0Bm-0005xu-GY; Mon, 18 Nov 2024 06:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tD0Be-0005wr-1u; Mon, 18 Nov 2024 06:44:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tD0Bb-0003CL-PC; Mon, 18 Nov 2024 06:44:57 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XsQlH0VqBz6LD8Y;
 Mon, 18 Nov 2024 19:44:27 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 717651403A1;
 Mon, 18 Nov 2024 19:44:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:44:46 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 18 Nov 2024 12:44:46 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Thread-Topic: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Thread-Index: AQHbMd3CYnIzOIz3QUan4PDL8HOdprK8zVGAgAAjLhA=
Date: Mon, 18 Nov 2024 11:44:46 +0000
Message-ID: <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
In-Reply-To: <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE4LCAyMDI0IDEw
OjAyIEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiBxZW11LWRl
dmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRp
YS5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgTGludXhh
cm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikNCj4gPHdhbmd6aG91MUBoaXNp
bGljb24uY29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0KPiBKb25h
dGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiB6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCA0LzVdIGh3L2FybS92aXJ0
LWFjcGktYnVpbGQ6IEJ1aWxkIElPUlQgd2l0aA0KPiBtdWx0aXBsZSBTTU1VIG5vZGVzDQo+IA0K
DQo+ID4gICAgICAvKiBOdW1iZXIgb2YgSU9SVCBOb2RlcyAqLw0KPiA+IEBAIC0zNDIsMTAgKzM1
Niw5IEBAIGJ1aWxkX2lvcnQoR0FycmF5ICp0YWJsZV9kYXRhLCBCSU9TTGlua2VyDQo+ICpsaW5r
ZXIsIFZpcnRNYWNoaW5lU3RhdGUgKnZtcykNCj4gPiAgICAgIC8qIEdJQyBJVFMgSWRlbnRpZmll
ciBBcnJheSAqLw0KPiA+ICAgICAgYnVpbGRfYXBwZW5kX2ludF9ub3ByZWZpeCh0YWJsZV9kYXRh
LCAwIC8qIE1BRFQgdHJhbnNsYXRpb25faWQgKi8sDQo+IDQpOw0KPiA+DQo+ID4gLSAgICBpZiAo
dm1zLT5pb21tdSA9PSBWSVJUX0lPTU1VX1NNTVVWMykgew0KPiA+IC0gICAgICAgIGludCBpcnEg
PSAgdm1zLT5pcnFtYXBbVklSVF9TTU1VXSArIEFSTV9TUElfQkFTRTsNCj4gPiArICAgIGZvciAo
aSA9IDA7IGkgPCBudW1fc21tdXM7IGkrKykgew0KPiA+ICsgICAgICAgIHNtbXVfb2Zmc2V0W2ld
ID0gdGFibGVfZGF0YS0+bGVuIC0gdGFibGUudGFibGVfb2Zmc2V0Ow0KPiA+DQo+IEkgd291bGQg
aGF2ZSBleHBlY3RlZCBjaGFuZ2VzIGluIHRoZSBzbW11IGlkbWFwIGhhcyB3ZWxsLiBJZiBhIGdp
dmVuDQo+IFNNTVUgaW5zdGFuY2Ugbm93IHByb3RlY3RzIGEgZ2l2ZW4gYnVzIGhpZXJhcmNoeSBz
aG91bGRuJ3QgaXQgYmUNCj4gcmVmbGVjdGVkIGluIGEgZGlmZmVyZW50aWF0ZWQgU01NVSBpZG1h
cCBmb3IgZWFjaCBvZiB0aGVtIChSSUQgc3Vic2V0IG9mDQo+IFNNTVUtPnBjaS1idXMgbWFwcGlu
ZyB0byBhIHNwZWNpZmljIElPUlQgU01NVSBub2RlKT8gSG93IGlzIGl0IGRvbmUNCj4gY3VycmVu
dGx5Pw0KDQpJIHRob3VnaHQgdGhhdCBzbW11X2lkbWFwcyB3aWxsIGJlIGhhbmRsZWQgYnkgdGhp
cyA/DQoNCm9iamVjdF9jaGlsZF9mb3JlYWNoX3JlY3Vyc2l2ZShvYmplY3RfZ2V0X3Jvb3QoKSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvcnRfaG9zdF9icmlkZ2Vz
LCBzbW11X2lkbWFwcyk7DQoNCkJ1dCBpdCBpcyBwb3NzaWJsZSB0aGF0LCB0aGVyZSBpcyBhIGJ1
ZyBpbiB0aGlzIElPUlQgZ2VuZXJhdGlvbiBoZXJlIGFzIEkgYW0gbm90DQphYmxlIHRvIGhvdCBh
ZGQgIGRldmljZXMuIEl0IGxvb2tzIGxpa2UgdGhlIHBjaWVocCBpbnRlcnJ1cHQgaXMgbm90IGdl
bmVyYXRlZC9yZWNlaXZlZA0KZm9yIHNvbWUgcmVhc29uLiBOaWNvbGluWzBdIGlzIHN1c3BlY3Rp
bmcgdGhlIG1pbi9tYXggYnVzIHJhbmdlIGluDQppb3J0X2hvc3RfYnJpZGdlcygpIG1heSBub3Qg
bGVhdmUgZW5vdWdoIHJhbmdlcyBmb3IgaG90IGFkZCBsYXRlci4NCg0KQ29sZCBwbHVnZ2luZyBk
ZXZpY2VzIHRvIGRpZmZlcmVudCBTTU1VdjMvcGNpZS1weGIgc2VlbXMgdG8gYmUgYWxyaWdodC4N
Cg0KSSB3aWxsIGRlYnVnIHRoYXQgc29vbi4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KWzBdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvWnpQZDFGJTJGVUEyTUtNYndsQEFzdXJhZGEt
TnZpZGlhLw0KDQoNCg==

