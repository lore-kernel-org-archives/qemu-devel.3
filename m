Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7652CC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDtZ-00037F-0k; Tue, 06 May 2025 04:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDtV-000351-9I; Tue, 06 May 2025 04:43:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDtT-0006Dp-8R; Tue, 06 May 2025 04:43:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsBcz13JNz6M574;
 Tue,  6 May 2025 16:38:43 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 7089C1402FC;
 Tue,  6 May 2025 16:43:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 10:43:12 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 6 May 2025 10:43:12 +0200
To: Donald Dutile <ddutile@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Topic: [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Index: AQHbu00ZUUd2QcOmi06BQgcpw2jcEbO/cwCAgAASCoCABcnzAA==
Date: Tue, 6 May 2025 08:43:12 +0000
Message-ID: <0e4b8d9e17734de685e9a471ee864ff1@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-3-shameerali.kolothum.thodi@huawei.com>
 <aBT9S25tQTVGKkii@Asurada-Nvidia>
 <29e1775b-b35d-4510-a3a6-d49af81cca06@redhat.com>
In-Reply-To: <29e1775b-b35d-4510-a3a6-d49af81cca06@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9uYWxkIER1dGlsZSA8
ZGR1dGlsZUByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSAyLCAyMDI1IDc6MTggUE0N
Cj4gVG86IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IFNoYW1lZXJhbGkgS29s
b3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4g
Q2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5h
dWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29t
Ow0KPiBiZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207IG1vY2hzQG52aWRp
YS5jb207DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWku
Y29tPjsgV2FuZ3pob3UgKEIpDQo+IDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vu
a3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRo
YW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAyLzZdIGh3L2FybS92aXJ0LWFjcGktYnVpbGQ6IFVwZGF0ZSBJ
T1JUIGZvcg0KPiBtdWx0aXBsZSBzbW11djMgZGV2aWNlcw0KPiANCj4gDQo+IA0KPiBPbiA1LzIv
MjUgMToxMyBQTSwgTmljb2xpbiBDaGVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWF5IDAyLCAyMDI1
IGF0IDExOjI3OjAzQU0gKzAxMDAsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4+IEBAIC00
Myw2ICs0Myw3IEBADQo+ID4+ICAgI2luY2x1ZGUgImh3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZp
Y2UuaCINCj4gPj4gICAjaW5jbHVkZSAiaHcvYWNwaS90cG0uaCINCj4gPj4gICAjaW5jbHVkZSAi
aHcvYWNwaS9obWF0LmgiDQo+ID4+ICsjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My5oIg0KPiA+PiAg
ICNpbmNsdWRlICJody9wY2kvcGNpZV9ob3N0LmgiDQo+ID4+ICAgI2luY2x1ZGUgImh3L3BjaS9w
Y2kuaCINCj4gPj4gICAjaW5jbHVkZSAiaHcvcGNpL3BjaV9idXMuaCINCj4gPj4gQEAgLTI2Niw2
ICsyNjcsNzUgQEAgc3RhdGljIGludCBpb3J0X2lkbWFwX2NvbXBhcmUoZ2NvbnN0cG9pbnRlciBh
LA0KPiBnY29uc3Rwb2ludGVyIGIpDQo+ID4+ICAgICAgIHJldHVybiBpZG1hcF9hLT5pbnB1dF9i
YXNlIC0gaWRtYXBfYi0+aW5wdXRfYmFzZTsNCj4gPj4gICB9DQo+ID4+DQo+ID4+ICtzdHJ1Y3Qg
U01NVXYzRGV2aWNlIHsNCj4gPj4gKyAgICBpbnQgaXJxOw0KPiA+PiArICAgIGh3YWRkciBiYXNl
Ow0KPiA+PiArICAgIEdBcnJheSAqc21tdV9pZG1hcHM7DQo+ID4+ICsgICAgc2l6ZV90IG9mZnNl
dDsNCj4gPj4gK307DQo+ID4+ICt0eXBlZGVmIHN0cnVjdCBTTU1VdjNEZXZpY2UgU01NVXYzRGV2
aWNlOw0KPiA+DQo+ID4gIlNNTVV2M0RldmljZSIgc291bmRzIHRvbyBnZW5lcmFsLCBsaWtlIGNv
bWluZyBmcm9tIHNtbXV2My5oIDotLw0KPiA+DQo+ID4gR2l2ZW4gdGhpcyBkZXNjcmliZXMgU01N
VXYzJ3MgSU9SVCBub2RlLCBJIHN0aWxsIHRoaW5rIHdlIHNob3VsZCBuYW1lDQo+ID4gaXQgc29t
ZXRoaW5nIGxpa2UgIklvcnRTTU1VdjNOb2RlIiBvciBzby4NCj4gPg0KPiArMS4uIHRoZSBtb3Jl
IGdlbmVyaWMgbmFtZSBoYWQgbWUgdGhpbmtpbmcgaXQgd2FzIGJyb2FkZXIgdGhhbiBJT1JULi4N
Cj4gdGhlIElPUlQtcmVsYXRlZCBuYW1pbmcgaXMgYW4gaW1wcm92ZW1lbnQuDQoNCkkgdGhvdWdo
dCBpdCBpcyBvYnZpb3VzIGFzIEkgYWxyZWFkeSByZXBsaWVkIHRvIE5pY29saW4g8J+Yii4gSSB3
aWxsIGNvbnNpZGVyIHRoaXMuDQoNClRoYW5rcywNClNoYW1lZXINCg==

