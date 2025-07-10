Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D46EC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuKu-0002jA-Er; Thu, 10 Jul 2025 12:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZu24-0004x7-AS; Thu, 10 Jul 2025 12:22:04 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZu1x-0002A5-MG; Thu, 10 Jul 2025 12:21:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdKnt4WHrz6M4nZ;
 Fri, 11 Jul 2025 00:20:34 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id C4D4814025A;
 Fri, 11 Jul 2025 00:21:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Jul 2025 18:21:41 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 10 Jul 2025 18:21:41 +0200
To: Donald Dutile <ddutile@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Thread-Topic: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Thread-Index: AQHb8B7pgOmyuAHGhEyK6x0wrBLpebQonB8AgADVIJCAAOn5gIAAnLIwgABtrwCAACdXkA==
Date: Thu, 10 Jul 2025 16:21:41 +0000
Message-ID: <f3bfc4cdb0ca47da8f3e4bc38b58d3b6@huawei.com>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
 <aG2M/BI3UAYxKCD3@Asurada-Nvidia>
 <741503f8f96148b389b875e6b6812c1a@huawei.com>
 <aG8ECVeOYXPzBEVB@Asurada-Nvidia>
 <3a51c0e0f3ce4c2580ff596008615439@huawei.com>
 <aef834e0-d6dc-40d0-a6aa-24ed44b77325@redhat.com>
In-Reply-To: <aef834e0-d6dc-40d0-a6aa-24ed44b77325@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.153.84]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9uYWxkIER1dGlsZSA8
ZGR1dGlsZUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAxMCwgMjAyNSA1OjAw
IFBNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+OyBOaWNvbGluIENoZW4NCj4gPG5pY29saW5jQG52aWRpYS5j
b20+DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+
IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZp
ZGlhLmNvbTsNCj4gYmVycmFuZ2VAcmVkaGF0LmNvbTsgaW1hbW1lZG9AcmVkaGF0LmNvbTsgbmF0
aGFuY0BudmlkaWEuY29tOw0KPiBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUuY29t
OyBndXN0YXZvLnJvbWVyb0BsaW5hcm8ub3JnOw0KPiBtc3RAcmVkaGF0LmNvbTsgbWFyY2VsLmFw
ZmVsYmF1bUBnbWFpbC5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2Fu
Z3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5na3Vua3VuIDxqaWFu
Z2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJv
bkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NyAwNy8xMl0gaHcvcGNpOiBJbnRyb2R1Y2UNCj4gcGNpX3NldHVwX2lvbW11X3Blcl9i
dXMoKSBmb3IgcGVyLWJ1cyBJT01NVSBvcHMgcmV0cmlldmFsDQo+IA0KPiANCj4gDQo+IE9uIDcv
MTAvMjUgMzozNyBBTSwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPg0KPiA+
DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE5pY29saW4gQ2hl
biA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTAsIDIw
MjUgMTowNyBBTQ0KPiA+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+PiBDYzogcWVtdS1hcm1Abm9uZ251
Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiA+PiBlcmljLmF1Z2VyQHJlZGhhdC5jb207
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+ID4+IGRkdXRpbGVA
cmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsgaW1hbW1lZG9AcmVkaGF0LmNvbTsNCj4g
Pj4gbmF0aGFuY0BudmlkaWEuY29tOyBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUu
Y29tOw0KPiA+PiBndXN0YXZvLnJvbWVyb0BsaW5hcm8ub3JnOyBtc3RAcmVkaGF0LmNvbTsNCj4g
Pj4gbWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWku
Y29tPjsNCj4gV2FuZ3pob3UNCj4gPj4gKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IGpp
YW5na3Vua3VuDQo+IDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsNCj4gPj4gSm9uYXRoYW4gQ2Ft
ZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gPj4gemhhbmdmZWkuZ2FvQGxp
bmFyby5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwNy8xMl0gaHcvcGNpOiBJbnRy
b2R1Y2UNCj4gPj4gcGNpX3NldHVwX2lvbW11X3Blcl9idXMoKSBmb3IgcGVyLWJ1cyBJT01NVSBv
cHMgcmV0cmlldmFsDQo+ID4+DQo+ID4+IE9uIFdlZCwgSnVsIDA5LCAyMDI1IGF0IDA4OjIwOjM1
QU0gKzAwMDAsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPj4gd3JvdGU6DQo+ID4+Pj4g
T24gVHVlLCBKdWwgMDgsIDIwMjUgYXQgMDQ6NDA6NTBQTSArMDEwMCwgU2hhbWVlciBLb2xvdGh1
bSB3cm90ZToNCj4gPj4+Pj4gQEAgLTI5MDksNiArMjkwOSwxOSBAQCBzdGF0aWMgdm9pZA0KPiA+
Pj4+IHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihQQ0lEZXZpY2UgKmRldiwNCj4gPj4+
Pj4gICAgICAgICAgICAgICB9DQo+ID4+Pj4+ICAgICAgICAgICB9DQo+ID4+Pj4+DQo+ID4+Pj4+
ICsgICAgICAgIC8qDQo+ID4+Pj4+ICsgICAgICAgICAqIFdoZW4gbXVsdGlwbGUgUENJIEV4cHJl
c3MgUm9vdCBCdXNlcyBhcmUgZGVmaW5lZCB1c2luZw0KPiA+Pj4+PiArIHB4Yi0NCj4gPj4+PiBw
Y2llLA0KPiA+Pj4+PiArICAgICAgICAgKiB0aGUgSU9NTVUgY29uZmlndXJhdGlvbiBtYXkgYmUg
c3BlY2lmaWMgdG8gZWFjaCByb290IGJ1cy4NCj4gPj4+PiBIb3dldmVyLA0KPiA+Pj4+PiArICAg
ICAgICAgKiBweGItcGNpZSBhY3RzIGFzIGEgc3BlY2lhbCByb290IGNvbXBsZXggd2hvc2UgcGFy
ZW50DQo+ID4+Pj4+ICsgaXMNCj4gPj4+PiBlZmZlY3RpdmVseQ0KPiA+Pj4+PiArICAgICAgICAg
KiB0aGUgZGVmYXVsdCByb290IGNvbXBsZXgocGNpZS4wKS4gRW5zdXJlIHRoYXQgd2UgcmV0cmll
dmUgdGhlDQo+ID4+Pj4+ICsgICAgICAgICAqIGNvcnJlY3QgSU9NTVUgb3BzKGlmIGFueSkgaW4g
c3VjaCBjYXNlcy4NCj4gPj4+Pj4gKyAgICAgICAgICovDQo+ID4+Pj4+ICsgICAgICAgIGlmIChw
Y2lfYnVzX2lzX2V4cHJlc3MoaW9tbXVfYnVzKSAmJg0KPiA+Pj4+IHBjaV9idXNfaXNfcm9vdChp
b21tdV9idXMpKSB7DQo+ID4+Pj4+ICsgICAgICAgICAgICBpZiAoIWlvbW11X2J1cy0+aW9tbXVf
cGVyX2J1cyAmJiBwYXJlbnRfYnVzLQ0KPiA+Pj4+PiBpb21tdV9wZXJfYnVzKSB7DQo+ID4+Pj4+
ICsgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4+Pj4NCj4gPj4+PiBNaW5kIGVsYWJvcmF0aW5n
IHdoeSB0aGUgY3VycmVudCBidXMgbXVzdCB1bnNldCBpb21tdV9wZXJfYnVzDQo+ID4+IHdoaWxl
DQo+ID4+Pj4gaXRzIHBhcmVudCBzZXRzIGlvbW11X3Blcl9idXM/DQo+ID4+Pj4NCj4gPj4+PiBN
eSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgZm9yIGEgcHhiLXBjaWUgd2Ugc2hvdWxkIHNldA0KPiBp
b21tdV9wZXJfYnVzDQo+ID4+Pj4gYnV0IGZvciBpdHMgcGFyZW50ICh0aGUgZGVmYXVsdCByb290
IGNvbXBsZXgpIHdlIHNob3VsZCB1bnNldCBpdHMNCj4gPj4+PiBpb21tdV9wZXJfYnVzPw0KPiA+
Pj4NCj4gPj4+IFdlbGwsIGZvciBuZXcgYXJtLXNtbXV2MyBkZXYgeW91IG5lZWQgYW4gYXNzb2Np
YXRlZCBwY2llIHJvb3QNCj4gPj4+IGNvbXBsZXguIEVpdGhlciB0aGUgZGVmYXVsdCBwY2llLjAg
b3IgYSBweGItcGNpZSBvbmUuIEFuZCBhcyBJDQo+ID4+PiBtZW50aW9uZWQgaW4gbXkgcmVwbHkg
dG8gdGhlIG90aGVyIHRocmVhZChwYXRjaCAjMikgYW5kIGNvbW1pdCBsb2cNCj4gPj4gaGVyZSwN
Cj4gPj4+IHRoZSBweGItcGNpZSBpcyBzcGVjaWFsIGV4dHJhIHJvb3QgY29tcGxleCBpbiBRZW11
IHdoaWNoIGhhcyBwY2llLjANCj4gPj4+IGhhcyBwYXJlbnQgYnVzLg0KPiA+Pj4NCj4gPj4+IFRo
ZSBhYm92ZSBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKSBhdCBwcmVzZW50LCBpdGVy
YXRlIG92ZXINCj4gPj4gdGhlDQo+ID4+PiBwYXJlbnRfZGV2IGlmIGl0IGlzIHNldCBhbmQgcmV0
dXJucyB0aGUgcGFyZW50X2J1cyBJT01NVSBvcHMgZXZlbiBpZg0KPiA+Pj4gdGhlIGFzc29jaWF0
ZWQgcHhiLXBjaWUgYnVzIGRvZXNuJ3QgaGF2ZSBhbnkgSU9NTVUuIFRoaXMgY3JlYXRlcw0KPiA+
Pj4gcHJvYmxlbSBmb3IgYSBjYXNlIHRoYXQgaXMgZGVzY3JpYmVkIGhlcmUgaW4gdGhlIGNvdmVy
IGxldHRlciBoZXJlLA0KPiA+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8y
MDI1MDcwODE1NDA1NS4xMDEwMTItMS0NCj4gPj4gc2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBo
dWF3ZWkuY29tLw0KPiA+Pj4NCj4gPj4+IChQbGVhc2Ugc2VlICJNYWpvciBjaGFuZ2VzIGZyb20g
djQ6IiBzZWN0aW9uKQ0KPiA+Pj4NCj4gPj4+IFRvIGFkZHJlc3MgdGhhdCBpc3N1ZSwgdGhpcyBw
YXRjaCBpbnRyb2R1Y2VzIGFuIG5ldyBoZWxwZXIgZnVuY3Rpb24NCj4gPj4+IHRvDQo+ID4+IHNw
ZWNpZnkgdGhhdA0KPiA+Pj4gdGhlIElPTU1VIG9wcyBhcmUgc3BlY2lmaWMgdG8gdGhlIGFzc29j
aWF0ZWQgcm9vdA0KPiA+PiBjb21wbGV4KGlvbW11X3Blcl9idXMpIGFuZA0KPiA+Pj4gdXNlIHRo
YXQgdG8gcmV0dXJuIHRoZSBjb3JyZWN0IElPTU1VIG9wcy4NCj4gPj4+DQo+ID4+PiBIb3BlIHdp
dGggdGhhdCBjb250ZXh0IGl0IGlzIGNsZWFyIG5vdy4NCj4gPj4NCj4gPj4gSG1tLCBJIHdhcyBu
b3QgcXVlc3Rpb25pbmcgdGhlIGNvbnRleHQsIEkgZ2V0IHdoYXQgdGhlIHBhdGNoIGlzDQo+ID4+
IHN1cHBvc2VkIHRvIGRvLg0KPiA+Pg0KPiA+PiBJIHdhcyBhc2tpbmcgdGhlIGxvZ2ljIHRoYXQg
aXMgdW5jbGVhciB0byBtZSB3aHkgaXQgYnJlYWtzIHdoZW46DQo+ID4+ICAgICAgIXB4Yi1wY2ll
LT5pb21tdV9wZXJfYnVzICYmIHBjaWUuMC0+aW9tbXVfcGVyX2J1cw0KPiA+Pg0KPiA+PiBPciBp
biB3aGljaCBjYXNlIHBjaWUuMCB3b3VsZCBiZSBzZXQgdG8gaW9tbXVfcGVyX2J1cz10cnVlPw0K
PiA+DQo+ID4gWWVzLiBDb25zaWRlciB0aGUgZXhhbXBsZSBJIGdhdmUgaW4gY292ZXIgIGxldHRl
ciwNCj4gPg0KPiA+IC1kZXZpY2UgYXJtLXNtbXV2MyxwcmltYXJ5LWJ1cz1wY2llLjAsaWQ9c21t
dXYzLjEgXCAtZGV2aWNlDQo+ID4gdmlydGlvLW5ldC1wY2ksYnVzPXBjaWUuMCxuZXRkZXY9bmV0
MCxpZD12aXJ0aW9uZXQuMCBcIC1kZXZpY2UNCj4gPiBweGItcGNpZSxpZD1wY2llLjEsYnVzX25y
PTgsYnVzPXBjaWUuMCBcIC1kZXZpY2UNCj4gPiBhcm0tc21tdXYzLHByaW1hcnktYnVzPXBjaWUu
MSxpZD1zbW11djMuMiBcIC1kZXZpY2UNCj4gPiBwY2llLXJvb3QtcG9ydCxpZD1wY2llLnBvcnQx
LGNoYXNzaXM9MixidXM9cGNpZS4xIFwgLWRldmljZQ0KPiA+IHZpcnRpby1uZXQtcGNpLGJ1cz1w
Y2llLnBvcnQxLG5ldGRldj1uZXQxLGlkPXZpcnRpb25ldC4xDQo+ID4NCj4gPiBwY2llLjAgaXMg
YmVoaW5kIG5ldyBTTU1VdjMgZGV2KHNtbXV2My4xKSBhbmQgaGFzIGlvbW11X3Blcl9idXMNCj4g
c2V0Lg0KPiA+IHBjaWUuMSBoYXMgbm8gU01NdjNVIGFuZCBpb21tdV9wZXJfYnVzIGlzIG5vdCBz
ZXQgZm9yIGl0Lg0KPiBwY2llLjEgZG9lc24ndD8gICB0aGVuIHdoYXQgaXMgdGhpcyBsaW5lIHNh
eWluZy9tZWFuaW5nPzoNCj4gICAtZGV2aWNlIGFybS1zbW11djMscHJpbWFyeS1idXM9cGNpZS4x
LGlkPXNtbXV2My4yIFwNCj4gDQo+IEkgcmVhZCB0aGF0IGFzIGFuIHNtbXV2MyBhdHRhY2hlZCB0
byBwY2llLjEsIHdpdGggYW4gaWQgb2Ygc21tdXYzLjI7IGp1c3QNCj4gYXMgSSByZWFkIHRoaXMg
Y29uZmlnOg0KPiAgIC1kZXZpY2UgYXJtLXNtbXV2MyxwcmltYXJ5LWJ1cz1wY2llLjAsaWQ9c21t
dXYzLjEgXCBhcyBhbiBzbW11djMNCj4gYXR0YWNoZWQgdG8gcGNpZS4wIGl3dGggaWQgc21tdXYz
LjENCg0KT29wcy4uSSBmb3Jnb3QgdG8gZGVsZXRlIHRoYXQgZnJvbSB0aGUgY29uZmlnOg0KVGhp
cyBpcyB3aGF0IEkgbWVhbnQsDQoNCi1kZXZpY2UgYXJtLXNtbXV2MyxwcmltYXJ5LWJ1cz1wY2ll
LjAsaWQ9c21tdXYzLjEgXA0KLWRldmljZSB2aXJ0aW8tbmV0LXBjaSxidXM9cGNpZS4wLG5ldGRl
dj1uZXQwLGlkPXZpcnRpb25ldC4wIFwNCi1kZXZpY2UgcHhiLXBjaWUsaWQ9cGNpZS4xLGJ1c19u
cj04LGJ1cz1wY2llLjAgXA0KLWRldmljZSBwY2llLXJvb3QtcG9ydCxpZD1wY2llLnBvcnQxLGNo
YXNzaXM9MixidXM9cGNpZS4xIFwNCi1kZXZpY2UgdmlydGlvLW5ldC1wY2ksYnVzPXBjaWUucG9y
dDEsbmV0ZGV2PW5ldDEsaWQ9dmlydGlvbmV0LjEgXA0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCj4g
DQo+ID4NCj4gPiBBbmQgd2UgZG9uJ3Qgd2FudCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2
Zm4oKSB0byByZXR1cm4gcGNpZS4wJ3MNCj4gPiBJT01NVSBvcHMgZm9yIHZpcnRpb25ldC4xLiBI
ZW5jZSB0aGUgYnJlYWsuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gU2hhbWVlcg0KPiA+DQo+IA0K
DQo=

