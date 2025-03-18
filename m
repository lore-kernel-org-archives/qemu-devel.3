Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FC3C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTXj-0000hf-TL; Tue, 18 Mar 2025 05:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuTXh-0000hJ-3v; Tue, 18 Mar 2025 05:47:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuTXe-0007Sg-IB; Tue, 18 Mar 2025 05:47:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZH6Nl3XvBz6LD9m;
 Tue, 18 Mar 2025 17:43:51 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 55728140137;
 Tue, 18 Mar 2025 17:47:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Mar 2025 10:47:08 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 18 Mar 2025 10:47:08 +0100
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
Subject: RE: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce callbacks for
 PCIIOMMUOps
Thread-Topic: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce callbacks for
 PCIIOMMUOps
Thread-Index: AQHbkqnXk2A5Q1HeeUCFKLsnwwQVo7NvoCEAgAEVsnCABs4CAIABK+jQ
Date: Tue, 18 Mar 2025 09:47:07 +0000
Message-ID: <4603b8d654be45288f949a40c26d6ef3@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-8-shameerali.kolothum.thodi@huawei.com>
 <fe047856-b564-4776-8651-daa65c02133b@redhat.com>
 <2606bc1d06f24495a8f382b3d1af3fc6@huawei.com>
 <1105d100-dd1e-4aca-b518-50f903967416@redhat.com>
In-Reply-To: <1105d100-dd1e-4aca-b518-50f903967416@redhat.com>
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE3LCAyMDI1IDQ6NTIg
UE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3Ro
dW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlhLmNv
bTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUBy
ZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hzQG52aWRpYS5jb207IHNtb3N0
YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3po
b3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5na3Vua3VuIDxqaWFuZ2t1
bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBo
dWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggdjIgMDcvMjBdIGh3L2FybS9zbW11LWNvbW1vbjogSW50cm9kdWNlDQo+IGNhbGxiYWNr
cyBmb3IgUENJSU9NTVVPcHMNCg0KDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiAzLzEzLzI1IDk6
MDkgQU0sIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3JvdGU6DQo+ID4gSGkgRXJpYywNCj4g
Pg0KPiA+Pj4gICAgICBib29sIGFjY2VsOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICBBZGRyZXNzU3Bh
Y2UgKiAoKmdldF9hZGRyZXNzX3NwYWNlKShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLA0KPiBp
bnQNCj4gPj4gZGV2Zm4pOw0KPiA+Pj4gKyAgICBib29sICgqc2V0X2lvbW11X2RldmljZSkoUENJ
QnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLA0KPiA+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlICpkZXYsIEVycm9yICoqZXJycCk7DQo+ID4+
PiArICAgIHZvaWQgKCp1bnNldF9pb21tdV9kZXZpY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFx
dWUsIGludCBkZXZmbik7DQo+ID4+IEkgdGhpbmsgdGhpcyBzaG91bGQgYmUgZXhwb3NlZCBieSBh
IGNsYXNzIGFuZCBvbmx5IGltcGxlbWVudGVkIGluIHRoZQ0KPiA+PiBzbW11djMgYWNjZWwgZGV2
aWNlLiBBZGRpbmcgdGhvc2UgY2JzIGRpcmVjdGx5IGluIHRoZSBTdGF0ZSBsb29rcyBub3QgdGhl
DQo+ID4+IHN0ZCB3YXkuDQo+ID4gT2suIFlvdSBtZWFuIHdlIGNhbiBkaXJlY3RseSBwbGFjZSAg
UENJSU9NTVVPcHMgKm9wcyBoZXJlIHRoZW4/DQo+IFdoZW4gSSBmaXJzdCBza2ltbWVkIHRocm91
Z2ggdGhlIHNlcmllcyBJIGFzc3VtZWQgeW91IHdvdWxkIHVzZSAyDQo+IHNlcGVyYXRlIGRldmlj
ZXMsIGluIHdoaWNoIGNhc2UgdGhhdCB3b3VsZCB1c2UgMiBkaWZmZXJlbnQNCj4gaW1wbGVtZW50
YXRpb25zIG9mIHRoZSBzYW1lIGNsYXNzLiBZb3UgbWF5IGhhdmUgYSBsb29rIGF0DQo+IGRvY3Mv
ZGV2ZWwvcW9tLnJzdCBhbmQgTWV0aG9kcyBhbmQgY2xhc3MgdGhlcmUuDQo+IA0KPiBOb3cgYXMg
SSBjb21tZW50ZWQgZWFybGllciBJIHRoaW5rIHRoZSBlbmQgdXNlciBzaGFsbCBpbnN0YW50aWF0
ZSB0aGUNCj4gc2FtZSBkZXZpY2UgZm9yIG5vbiBhY2NlbCBhbmQgYWNjZWwuIEkgd291bGQgYWR2
b2NhdGUgZm9yIHBhc3NpbmcgYW4NCj4gb3B0aW9uIHRlbGxpbmcgd2hldGhlciB3ZSB3YW50IGFj
Y2VsIG1vZGFsaXR5LiBUaGVuIGl0IHJhdGhlciBsb29rcyBsaWtlDQo+IHdoYXQgd2FzIGRvbmUg
Zm9yIHZmaW8gZGV2aWNlIHdpdGggZWl0aGVyIGxlZ2FjeSBvciBpb21tdWZkIGJhY2tlbmQuDQo+
IA0KPiBkZXBlbmRpbmcgb24gd2hldGhlciB0aGUgaW9tbXVmZCBvcHRpb24gaXMgcGFzc2VkIHlv
dSBzZWxlY3QgdGhlIHJpZ2h0DQo+IGNsYXNzIGltcGxlbWVudGF0aW9uOg0KPiBzZWUgaHcvdmZp
by9jb21tb24uYyBhbmQgdmZpb19hdHRhY2hfZGV2aWNlDQo+IA0KPiANCj4gwqDCoMKgIGNvbnN0
IFZGSU9JT01NVUNsYXNzICpvcHMgPQ0KPiDCoMKgwqDCoMKgwqDCoCBWRklPX0lPTU1VX0NMQVNT
KG9iamVjdF9jbGFzc19ieV9uYW1lKFRZUEVfVkZJT19JT01NVV9MRUdBDQo+IENZKSk7DQo+IA0K
PiDCoMKgwqAgaWYgKHZiYXNlZGV2LT5pb21tdWZkKSB7DQo+IMKgwqDCoMKgwqDCoMKgIG9wcyA9
DQo+IFZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklPX0lPTU1V
X0lPTU1VRkQpDQo+ICk7DQo+IMKgwqDCoCB9DQo+IA0KPiBJIHdvdWxkIGRvaW5nIHNvbWV0aGlu
ZyBzaW1pbGFyIGZvciBzZWxlY3RpbmcgdGhlIHJpZ2h0IG9wcyBkZXBlbmRpbmcgb24NCj4gdGhl
IHBhc3NlZCBvcHRpb24uDQo+IA0KPiBJIGhvcGUgdGhpcyBoZWxwcw0KDQpUaGFua3MgRXJpYy4g
SSB3aWxsIHRha2UgYSBsb29rLg0KDQpTaGFtZWVyDQo=

