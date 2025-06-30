Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84C4C83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 07:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW8aM-0003de-Hd; Mon, 30 Jun 2025 03:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uW8aH-0003cu-LM; Mon, 30 Jun 2025 03:05:45 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uW8aF-0003MT-IB; Mon, 30 Jun 2025 03:05:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bVxtx1llGz6L56B;
 Mon, 30 Jun 2025 15:02:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 197A91402F1;
 Mon, 30 Jun 2025 15:05:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 09:05:35 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 09:05:35 +0200
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
Subject: RE: [PATCH v5 06/11] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Thread-Topic: [PATCH v5 06/11] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Thread-Index: AQHb5Ci5FbhTt10phUunNrQS3OB7wrQWzVSAgASELAA=
Date: Mon, 30 Jun 2025 07:05:35 +0000
Message-ID: <67920203735d48edb1151ca7ba096bf9@huawei.com>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-7-shameerali.kolothum.thodi@huawei.com>
 <5af5e1a5-f81a-4ae8-80d1-3ebb749097f3@redhat.com>
In-Reply-To: <5af5e1a5-f81a-4ae8-80d1-3ebb749097f3@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMjcsIDIwMjUgMTowNCBQ
TQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gcWVtdS1kZXZlbEBu
b25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29t
OyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJl
ZGhhdC5jb207IGltYW1tZWRvQHJlZGhhdC5jb207DQo+IG5hdGhhbmNAbnZpZGlhLmNvbTsgbW9j
aHNAbnZpZGlhLmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsNCj4gZ3VzdGF2by5yb21lcm9AbGlu
YXJvLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdQ0KPiAoQikg
PHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdl
aS5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
Ow0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDA2
LzExXSBody9wY2k6IEludHJvZHVjZQ0KPiBwY2lfc2V0dXBfaW9tbXVfcGVyX2J1cygpIGZvciBw
ZXItYnVzIElPTU1VIG9wcyByZXRyaWV2YWwNCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA2
LzIzLzI1IDExOjQyIEFNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEN1cnJlbnRseSwg
cGNpX3NldHVwX2lvbW11KCkgcmVnaXN0ZXJzIElPTU1VIG9wcyBmb3IgYSBnaXZlbiBQQ0lCdXMu
DQo+ID4gSG93ZXZlciwgd2hlbiByZXRyaWV2aW5nIElPTU1VIG9wcyBmb3IgYSBkZXZpY2UgdXNp
bmcNCj4gPiBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKSwgdGhlIGZ1bmN0aW9uIGNo
ZWNrcyB0aGUgcGFyZW50X2Rldg0KPiA+IGFuZCBmZXRjaGVzIElPTU1VIG9wcyBmcm9tIHRoZSBw
YXJlbnQgZGV2aWNlLCBldmVuIGlmIHRoZSBjdXJyZW50DQo+ID4gYnVzIGRvZXMgbm90IGhhdmUg
YW55IGFzc29jaWF0ZWQgSU9NTVUgb3BzLg0KPiA+DQo+ID4gVGhpcyBiZWhhdmlvciB3b3JrcyBm
b3Igbm93IGJlY2F1c2UgUUVNVSdzIElPTU1VIGltcGxlbWVudGF0aW9ucw0KPiBhcmUNCj4gPiBn
bG9iYWxseSBzY29wZWQsIGFuZCBob3N0IGJyaWRnZXMgcmVseSBvbiB0aGUgYnlwYXNzX2lvbW11
IHByb3BlcnR5DQo+ID4gdG8gc2tpcCBJT01NVSB0cmFuc2xhdGlvbiB3aGVuIG5lZWRlZC4NCj4g
Pg0KPiA+IEhvd2V2ZXIsIHRoaXMgbW9kZWwgd2lsbCBicmVhayB3aXRoIHRoZSBzb29uIHRvIGJl
IGludHJvZHVjZWQNCj4gPiBhcm0tc21tdXYzIGRldmljZSwgd2hpY2ggYWxsb3dzIHVzZXJzIHRv
IGFzc29jaWF0ZSB0aGUgSU9NTVUNCj4gPiB3aXRoIGEgc3BlY2lmaWMgUENJZSByb290IGNvbXBs
ZXggKGUuZy4sIHRoZSBkZWZhdWx0IHBjaWUuMA0KPiA+IG9yIGEgcHhiLXBjaWUgcm9vdCBjb21w
bGV4KS4NCj4gPg0KPiA+IEZvciBleGFtcGxlLCBjb25zaWRlciB0aGUgZm9sbG93aW5nIHNldHVw
IHdpdGggbXVsdGlwbGUgcm9vdA0KPiA+IGNvbXBsZXhlczoNCj4gPg0KPiA+IC1kZXZpY2UgYXJt
LXNtbXV2MyxwcmltYXJ5LWJ1cz1wY2llLjAsaWQ9c21tdXYzLjAgXA0KPiA+IC4uLg0KPiA+IC1k
ZXZpY2UgcHhiLXBjaWUsaWQ9cGNpZS4xLGJ1c19ucj04LGJ1cz1wY2llLjAgXA0KPiA+IC1kZXZp
Y2UgcGNpZS1yb290LXBvcnQsaWQ9cGNpZS5wb3J0MSxidXM9cGNpZS4xIFwNCj4gPiAtZGV2aWNl
IHZpcnRpby1uZXQtcGNpLGJ1cz1wY2llLnBvcnQxDQo+ID4NCj4gPiBJbiBRZW11LCBweGItcGNp
ZSBhY3RzIGFzIGEgc3BlY2lhbCByb290IGNvbXBsZXggd2hvc2UgcGFyZW50IGlzDQo+ID4gZWZm
ZWN0aXZlbHkgdGhlIGRlZmF1bHQgcm9vdCBjb21wbGV4KHBjaWUuMCkuIEhlbmNlLCB0aG91Z2gg
cGNpZS4xDQo+ID4gaGFzIG5vIGFzc29jaWF0ZWQgU01NVXYzIGFzIHBlciBhYm92ZSwNCj4gcGNp
X2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKCkNCj4gPiB3aWxsIGluY29ycmVjdGx5IHJldHVy
biB0aGUgSU9NTVUgb3BzIGZyb20gcGNpZS4wIGR1ZSB0byB0aGUgZmFsbGJhY2sNCj4gPiB2aWEg
cGFyZW50X2Rldi4NCj4gPg0KPiA+IFRvIGZpeCB0aGlzLCBpbnRyb2R1Y2UgYSBuZXcgaGVscGVy
IHBjaV9zZXR1cF9pb21tdV9wZXJfYnVzKCkgdGhhdA0KPiA+IGV4cGxpY2l0bHkgc2V0cyB0aGUg
bmV3IGlvbW11X3Blcl9idXMgZmllbGQgaW4gdGhlIFBDSUJ1cyBzdHJ1Y3R1cmUuDQo+ID4gVXBk
YXRlIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbigpIHRvIHVzZSB0aGlzIHdoZW4gZGV0
ZXJtaW5pbmcNCj4gPiB0aGUgY29ycmVjdCBJT01NVSBvcHMsIGVuc3VyaW5nIGFjY3VyYXRlIGJl
aGF2aW9yIGZvciBwZXItYnVzIElPTU1Vcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1l
ZXIgS29sb3RodW0NCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4g
PiAtLS0NCj4gPiBQbGVhc2UgcmVmZXIgY292ZXIgbGV0dGVyIGZvciBtb3JlIGRldGFpbHMgb24g
dGhlIGlzc3VlIHRoYXQNCj4gPiB0aGlzIGlzIHRyeWluZyB0byBmaXguDQo+ID4gLS0tDQo+ID4g
IGh3L3BjaS9wY2kuYyAgICAgICAgICAgICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgaW5jbHVkZS9ody9wY2kvcGNpLmggICAgIHwgIDIgKysNCj4gPiAgaW5jbHVkZS9ody9w
Y2kvcGNpX2J1cy5oIHwgIDEgKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCj4g
PiBpbmRleCBjNzBiNWNlZWJhLi5lMTk0MGMwNWQ5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3BjaS9w
Y2kuYw0KPiA+ICsrKyBiL2h3L3BjaS9wY2kuYw0KPiA+IEBAIC0yOTA5LDYgKzI5MDksMTkgQEAg
c3RhdGljIHZvaWQNCj4gcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKFBDSURldmljZSAq
ZGV2LA0KPiA+ICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAg
ICAgLyoNCj4gPiArICAgICAgICAgKiBXaGVuIG11bHRpcGxlIFBDSSBFeHByZXNzIFJvb3QgQnVz
ZXMgYXJlIGRlZmluZWQgdXNpbmcgcHhiLQ0KPiBwY2llLA0KPiA+ICsgICAgICAgICAqIHRoZSBJ
T01NVSBjb25maWd1cmF0aW9uIG1heSBiZSBzcGVjaWZpYyB0byBlYWNoIHJvb3QgYnVzLg0KPiBI
b3dldmVyLA0KPiA+ICsgICAgICAgICAqIHB4Yi1wY2llIGFjdHMgYXMgYSBzcGVjaWFsIHJvb3Qg
Y29tcGxleCB3aG9zZSBwYXJlbnQgaXMNCj4gZWZmZWN0aXZlbHkNCj4gPiArICAgICAgICAgKiB0
aGUgZGVmYXVsdCByb290IGNvbXBsZXgocGNpZS4wKS4gRW5zdXJlIHRoYXQgd2UgcmV0cmlldmUg
dGhlDQo+IEkgZ2VuZXJhbGx5IGxlYXZlIGEgc3BhY2UgYmVmb3JlIHRoZSBvcGVuaW5nIGJyYWNr
ZXQuIEhlcmUgYW5kIGVsc2V3aGVyZQ0KDQpPay4NCg0KPiA+ICsgICAgICAgICAqIGNvcnJlY3Qg
SU9NTVUgb3BzKGlmIGFueSkgaW4gc3VjaCBjYXNlcy4NCj4gPiArICAgICAgICAgKi8NCj4gPiAr
ICAgICAgICBpZiAocGNpX2J1c19pc19leHByZXNzKGlvbW11X2J1cykgJiYNCj4gcGNpX2J1c19p
c19yb290KGlvbW11X2J1cykpIHsNCj4gPiArICAgICAgICAgICAgaWYgKCFpb21tdV9idXMtPmlv
bW11X3Blcl9idXMgJiYgcGFyZW50X2J1cy0NCj4gPmlvbW11X3Blcl9idXMpIHsNCj4gPiArICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgfQ0K
PiA+ICsNCj4gPiAgICAgICAgICBpb21tdV9idXMgPSBwYXJlbnRfYnVzOw0KPiA+ICAgICAgfQ0K
PiA+DQo+ID4gQEAgLTMxNjksNiArMzE4MiwxOCBAQCB2b2lkIHBjaV9zZXR1cF9pb21tdShQQ0lC
dXMgKmJ1cywgY29uc3QNCj4gUENJSU9NTVVPcHMgKm9wcywgdm9pZCAqb3BhcXVlKQ0KPiA+ICAg
ICAgYnVzLT5pb21tdV9vcGFxdWUgPSBvcGFxdWU7DQo+ID4gIH0NCj4gPg0KPiA+ICsvKg0KPiA+
ICsgKiBUaGlzIGlzIHNhbWUgYXMgcGNpX3NldHVwX2lvbW11KCkgZXhjZXB0IGl0IHNldHMgdGhl
IGlvbW11X3Blcl9idXMNCj4gPiArICogdG8gdHJ1ZSBpbmRpY2F0aW5nIHRoZSBpb21tdSBpcyBz
cGVjaWZpYyB0byB0aGlzIGJ1cyBhbmQNCj4gPiArICogbm90IGFwcGxpY2FibGUgdG8gYW55IHBh
cmVudCBvciBjaGlsZC4NCj4gb3IgY2hpbGQ/IGlmIHRoZXJlIGFyZSByb290IHBvcnRzIGJlbG93
LCBkb2Vzbid0IGl0IHByb3RlY3QgdGhlbSBhcyB3ZWxsPw0KDQpZZWFoLiBJdCB3aWxsIGNvdmVy
IHJvb3QgcG9ydHMuIEFjdHVhbGx5IEkgbWVhbnQgdGhlIHJvb3QgYnVzZXMgYW5kIHNwZWNpZmlj
YWxseQ0KdGhlIHBjaS4wIGFuZCBweGItcGNpZSBzcGVjaWFsIHJlbGF0aW9uc2hpcCBoZXJlLiBJ
IHdpbGwgdXBkYXRlIGFuZCBtYWtlIGl0IGNsZWFyLg0KDQo+IA0KPiBCZXNpZGVzIGxvb2tzIE9L
IHRvIG1lLiBIb3dldmVyIEkgd291bGQgZW5jb3VyYWdlIHlvdSB0byBhZGQgcGNpDQo+IG1haW50
YWluZXJzIChNU1QpIGluIHRvLg0KDQpTdXJlLg0KDQo+IGJlc2lkZXMsDQo+IFJldmlld2VkLWJ5
OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQoNClRoYW5rcywNClNoYW1lZXIN
Cg0KIA0KPiANCj4gRXJpYw0KPiA+ICsgKi8NCj4gPiArdm9pZCBwY2lfc2V0dXBfaW9tbXVfcGVy
X2J1cyhQQ0lCdXMgKmJ1cywgY29uc3QgUENJSU9NTVVPcHMgKm9wcywNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2b2lkICpvcGFxdWUpDQo+ID4gK3sNCj4gPiArICAgIHBjaV9z
ZXR1cF9pb21tdShidXMsIG9wcywgb3BhcXVlKTsNCj4gPiArICAgIGJ1cy0+aW9tbXVfcGVyX2J1
cyA9IHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIHBjaV9kZXZfZ2V0X3c2
NChQQ0lCdXMgKmIsIFBDSURldmljZSAqZGV2LCB2b2lkICpvcGFxdWUpDQo+ID4gIHsNCj4gPiAg
ICAgIFJhbmdlICpyYW5nZSA9IG9wYXF1ZTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9w
Y2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KPiA+IGluZGV4IGRmM2NjN2I4NzUuLmEz
ZTA4NzBhMTUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj4gPiArKysg
Yi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KPiA+IEBAIC03NjQsNiArNzY0LDggQEAgaW50IHBjaV9p
b21tdV91bnJlZ2lzdGVyX2lvdGxiX25vdGlmaWVyKFBDSURldmljZQ0KPiAqZGV2LCB1aW50MzJf
dCBwYXNpZCwNCj4gPiAgICovDQo+ID4gIHZvaWQgcGNpX3NldHVwX2lvbW11KFBDSUJ1cyAqYnVz
LCBjb25zdCBQQ0lJT01NVU9wcyAqb3BzLCB2b2lkDQo+ICpvcGFxdWUpOw0KPiA+DQo+ID4gK3Zv
aWQgcGNpX3NldHVwX2lvbW11X3Blcl9idXMoUENJQnVzICpidXMsIGNvbnN0IFBDSUlPTU1VT3Bz
ICpvcHMsDQo+IHZvaWQgKm9wYXF1ZSk7DQo+ID4gKw0KPiA+ICBwY2lidXNfdCBwY2lfYmFyX2Fk
ZHJlc3MoUENJRGV2aWNlICpkLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHJl
ZywgdWludDhfdCB0eXBlLCBwY2lidXNfdCBzaXplKTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L3BjaS9wY2lfYnVzLmggYi9pbmNsdWRlL2h3L3BjaS9wY2lfYnVzLmgNCj4gPiBp
bmRleCAyMjYxMzEyNTQ2Li5jNzM4NDQ2Nzg4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcv
cGNpL3BjaV9idXMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaV9idXMuaA0KPiA+IEBA
IC0zNSw2ICszNSw3IEBAIHN0cnVjdCBQQ0lCdXMgew0KPiA+ICAgICAgZW51bSBQQ0lCdXNGbGFn
cyBmbGFnczsNCj4gPiAgICAgIGNvbnN0IFBDSUlPTU1VT3BzICppb21tdV9vcHM7DQo+ID4gICAg
ICB2b2lkICppb21tdV9vcGFxdWU7DQo+ID4gKyAgICBib29sIGlvbW11X3Blcl9idXM7DQo+ID4g
ICAgICB1aW50OF90IGRldmZuX21pbjsNCj4gPiAgICAgIHVpbnQzMl90IHNsb3RfcmVzZXJ2ZWRf
bWFzazsNCj4gPiAgICAgIHBjaV9zZXRfaXJxX2ZuIHNldF9pcnE7DQo+IA0KDQo=

