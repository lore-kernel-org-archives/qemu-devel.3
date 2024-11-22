Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C67E69185
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 17:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXcp-0004R3-IZ; Fri, 22 Nov 2024 12:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tEXca-0003zT-Jv; Fri, 22 Nov 2024 12:39:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tEXcX-0003BU-3m; Fri, 22 Nov 2024 12:39:07 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xw2LD2gdSz6K6K9;
 Sat, 23 Nov 2024 01:35:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id BB05B1400CA;
 Sat, 23 Nov 2024 01:38:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 18:38:54 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 22 Nov 2024 18:38:54 +0100
To: Nathan Chen <nathanc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rK0OI0AgAyjUACAALVrYIAA+aSAgAEZOCA=
Date: Fri, 22 Nov 2024 17:38:54 +0000
Message-ID: <4f657876547f4001935f7314ecb8f8ca@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
 <04024d09ebad4d83ab0679f6bb3b3774@huawei.com>
 <d2bc4fdb-3188-4063-8ead-f2ccefec9c81@nvidia.com>
In-Reply-To: <d2bc4fdb-3188-4063-8ead-f2ccefec9c81@nvidia.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoZW4gPG5h
dGhhbmNAbnZpZGlhLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAyMiwgMjAyNCAxOjQy
IEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVs
QG5vbmdudS5vcmc7DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBMaW51eGFybSA8
bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA8d2FuZ3pob3UxQGhpc2lsaWNv
bi5jb20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47DQo+IEpvbmF0aGFu
IENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IHpoYW5nZmVpLmdhb0Bs
aW5hcm8ub3JnOyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUkZDIFBBVENIIDAvNV0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1c2VyLWNy
ZWF0YWJsZQ0KPiBuZXN0ZWQgU01NVXYzDQo+IA0KPiAgPj4gQWxzbyBhcyBhIGhlYWRzIHVwLCBJ
J3ZlIGFkZGVkIHN1cHBvcnQgZm9yIGF1dG8taW5zZXJ0aW5nIFBDSWUgc3dpdGNoDQo+ICA+PiBi
ZXR3ZWVuIHRoZSBQWEIgYW5kIEdQVXMgaW4gbGlidmlydCB0byBhdHRhY2ggbXVsdGlwbGUgZGV2
aWNlcyB0byBhDQo+IFNNTVUNCj4gID4+IG5vZGUgcGVyIGxpYnZpcnQncyBkb2N1bWVudGF0aW9u
IC0gIklmIHlvdSBpbnRlbmQgdG8gcGx1ZyBtdWx0aXBsZQ0KPiAgPj4gZGV2aWNlcyBpbnRvIGEg
cGNpZS1leHBhbmRlci1idXMsIHlvdSBtdXN0IGNvbm5lY3QgYQ0KPiAgPj4gcGNpZS1zd2l0Y2gt
dXBzdHJlYW0tcG9ydCB0byB0aGUgcGNpZS1yb290LXBvcnQgdGhhdCBpcyBwbHVnZ2VkIGludG8g
dGhlDQo+ICA+PiBwY2llLWV4cGFuZGVyLWJ1cywgYW5kIG11bHRpcGxlIHBjaWUtc3dpdGNoLWRv
d25zdHJlYW0tcG9ydHMgdG8gdGhlDQo+ICA+PiBwY2llLXN3aXRjaC11cHN0cmVhbS1wb3J0Ii4g
RnV0dXJlIHVuaXQtdGVzdHMgc2hvdWxkIGZvbGxvdyB0aGlzDQo+ICA+PiB0b3BvbG9neSBjb25m
aWd1cmF0aW9uLg0KPiAgPg0KPiAgPiBPay4gQ291bGQgeW91IHBsZWFzZSBnaXZlIG1lIGFuIGV4
YW1wbGUgUWVtdSBlcXVpdmFsZW50IGNvbW1hbmQNCj4gb3B0aW9uLA0KPiAgPiBpZiBwb3NzaWJs
ZSwgZm9yIHRoZSBhYm92ZSBjYXNlLiBJIGFtIG5vdCB0aGF0IGZhbWlsaWFyIHdpdGggbGlidmly
dA0KPiBhbmQgSSB3b3VsZA0KPiAgPiBhbHNvIGxpa2UgdG8gdGVzdCB0aGUgYWJvdmUgc2NlbmFy
aW8uDQo+IA0KPiBZb3UgY2FuIHVzZSAiLWRldmljZSB4MzEzMC11cHN0cmVhbSIgZm9yIHRoZSB1
cHN0cmVhbSBzd2l0Y2ggcG9ydCwgYW5kDQo+ICItZGV2aWNlIHhpbzMxMzAtZG93bnN0cmVhbSIg
Zm9yIHRoZSBkb3duc3RyZWFtIHBvcnQ6DQo+IA0KPiAgIC1kZXZpY2UgcHhiLXBjaWUsYnVzX25y
PTI1MCxpZD1wY2kuMSxidXM9cGNpZS4wLGFkZHI9MHgxIFwNCj4gICAtZGV2aWNlIHBjaWUtcm9v
dC1wb3J0LGlkPXBjaS4yLGJ1cz1wY2kuMSxhZGRyPTB4MCBcDQo+ICAgLWRldmljZSB4MzEzMC11
cHN0cmVhbSxpZD1wY2kuMyxidXM9cGNpLjIsYWRkcj0weDAgXA0KPiAgIC1kZXZpY2UgeGlvMzEz
MC0NCj4gZG93bnN0cmVhbSxpZD1wY2kuNCxidXM9cGNpLjMsYWRkcj0weDAsY2hhc3Npcz0xNyxw
b3J0PTEgXA0KPiAgIC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDA5OjAxOjAwLjAsaWQ9aG9zdGRl
djAsYnVzPXBjaS40LGFkZHI9MHgwIFwNCj4gICAtZGV2aWNlIGFybS1zbW11djMtbmVzdGVkLHBj
aS1idXM9cGNpLjENCg0KVGhhbmtzLiBKdXN0IHdvbmRlcmluZyB3aHkgbGlidmlydCBtYW5kYXRl
cyB1c2FnZSBvZiBwY2llLXN3aXRjaCBmb3IgbXVsdGlwbGUNCmRldmljZSBwbHVnZ2luZyByYXRo
ZXIgdGhhbiBqdXN0IHVzaW5nIHBjaWUtcm9vdC1wb3J0cz8NCg0KUGxlYXNlIGxldCBtZSBpZiB0
aGVyZSBpcyBhbnkgYWR2YW50YWdlIGluIGRvaW5nIHNvIHRoYXQgeW91IGFyZSBhd2FyZSBvZi4N
Cg0KVGhhbmtzLA0KU2hhbWVlcg0K

