Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E63C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 13:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5ul-0004sQ-Pg; Thu, 22 May 2025 09:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1uI5uj-0004rz-Jd; Thu, 22 May 2025 09:24:49 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1uI5uf-00086d-8d; Thu, 22 May 2025 09:24:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b385m5r9bz6M4gs;
 Thu, 22 May 2025 21:19:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id BF8FF1402EE;
 Thu, 22 May 2025 21:24:33 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 May 2025 15:24:33 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 22 May 2025 15:24:33 +0200
To: Gavin Shan <gshan@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "Eric
 Auger" <eauger@redhat.com>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHbyeZ/exOrsEEeSkGHg/Tv58YKarPdDqmAgACTRACAAP7B4A==
Date: Thu, 22 May 2025 13:24:33 +0000
Message-ID: <67025b22e4864caaa5b3dd19eb6d95ac@huawei.com>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
 <b65590b1-8a6f-43e5-b367-732d6305c095@redhat.com>
 <429a8131-2b59-4800-891b-bcfbc6e44737@linaro.org>
 <0d1208fa-9fca-4b4b-bad0-8b596d5102fb@redhat.com>
In-Reply-To: <0d1208fa-9fca-4b4b-bad0-8b596d5102fb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.75.110]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SEkgR2F2aW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2F2aW4g
U2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAyMiwgMjAyNSAx
Mjo1NCBBTQ0KPiBUbzogR3VzdGF2byBSb21lcm8gPGd1c3Rhdm8ucm9tZXJvQGxpbmFyby5vcmc+
OyBTYWxpbCBNZWh0YQ0KPiA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBKb25hdGhh
biBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBJZ29yIE1hbW1lZG92
DQo+IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsgRXJpYyBBdWdlciA8ZWF1Z2VyQHJlZGhhdC5jb20+
DQoNClsuLl0NCg0KPiANCj4gSGkgR3VzdGF2byBhbmQgU2FsaWwsDQo+IA0KPiBPbiA1LzIyLzI1
IDE6MDYgQU0sIEd1c3Rhdm8gUm9tZXJvIHdyb3RlOg0KPiA+IEhpIFNhbGlsLCBHYXZpbiwgYW5k
IGZvbGtzLA0KPiA+DQo+ID4gT24gNS8yMC8yNSAyMToyMiwgR2F2aW4gU2hhbiB3cm90ZToNCj4g
Pj4gSGkgU2FsaWwsDQo+ID4+DQo+ID4+IEEga2luZGx5IHBpbmcuIHZDUFUgaG90cGx1ZyBpcyBh
biBpbXBvcnRhbnQgZmVhdHVyZSBhbmQgWW91IGhhcyBwdXQNCj4gPj4gc28gbXVjaCBlbmVyZ2ll
cyBhbmQgYW1hemluZyBlZmZvcnRzIHRvIGVuYWJsZSB0aGUgZmVhdHVyZSBmcm9tIFFFTVUNCj4g
Pj4gc2lkZSwgYnV0IGl0IHNlZW1zIGl0IGhhcyBiZWVuIHN0dWNrIHJlY2VudGx5LiBJIHJlY2Vp
dmVkIG1hbnkNCj4gPj4gbWVzc2FnZXMgZnJvbSBSZWRoYXQgaW50ZXJuYWwgYW5kIGV4dGVybmFs
IHRvIGFzayBpZiB2Q1BVIGhvdHBsdWcgaGFzDQo+ID4+IGJlZW4gc3VwcG9ydGVkIG9uIGFhcmNo
NjQgaW4gdGhlIHBhc3QuIFNvIEknbSBoZWFkaW5nIHVwIHRvIGNoZWNrIGlmDQo+ID4+IHlvdSBo
YXZlIGJhbmR3aWR0aCB0byBjb250aW51ZSB0aGUgZWZmb3J0LCBhbnkga2luZHMgb2YgaGVscHMg
YXJlDQo+IG5lZWRlZCwgZXNwZWNpYWxseSBmcm9tIG1lLg0KPiA+DQo+ID4gWW91IGNhbiBjb3Vu
dCBvbiBtZSBhcyB3ZWxsLCBTYWxpbC4gSSdtIGRlZmluaXRlbHkgaW4gYSBiZXR0ZXINCj4gPiBw
b3NpdGlvbiBub3cgdG8gaGVscCB5b3Ugd2l0aCB0aGUgdGVjaG5pY2FsIHJldmlldyBvZiB0aGUg
c2VyaWVzLCBhbmQNCj4gPiBJIGNhbiBhbHNvIHdlaWdoIGluIHRvIGhlbHAgcmVzb2x2ZSBhbnkg
cmVtYWluaW5nIGlzc3VlcyBzbyB3ZSBjYW4NCj4gPiBmaW5hbGx5IGdldCBpdCBtZXJnZWQuIERv
bid0IGdpdmUgdXAhIDopDQo+ID4NCj4gPiBNeSBzdWdnZXN0aW9uOiBnbyBhaGVhZCBhbmQgcG9z
dCB3aGF0IHlvdSBoYXZlIG5vdy4gSnVzdCBoaWdobGlnaHQgdGhlDQo+ID4gbWFpbiBwb2ludHMg
b2Ygb2JqZWN0aW9uIHJhaXNlZCBpbiB0aGUgbGFzdCByZXZpZXcgdGhhdCBzdGlsbCBuZWVkIHRv
IGJlDQo+IGFkZHJlc3NlZC4NCj4gPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlIGFu
ZCB0byBvZmZlciBoZWxwcy4gQW5vdGhlciBzdWdnZXN0aW9uIEkgaGF2ZSBpbg0KPiBtaW5kOg0K
PiBpZiB0aGVyZSBpcyB1bmNlcnRhaW50eSByZWdhcmRpbmcgdGhlIGRlc2lnbiwgaXQgd291bGQg
YmUgbmljZSB0byBwb3N0IGEgc3BlY2lmaWMNCj4gdGhyZWFkIGZvciBkaXNjdXNzaW9uIHVudGls
IGl0J3MgY2xlYXJlZCBwcmlvciB0byBkaXZpbmcgaW50byBjb2RlLiBBZnRlciB0aGUNCj4gZGVz
aWduIGlzIGFja25vd2xlZGdlZCBieSBtYWludGFpbmVycywgb3VyIGxpZmUgd2lsbCBiZSBtdWNo
IGVhc2llci4gVGhlDQo+IHBvaW50IGlzIHRvIGdldCBlbm91Z2ggYXR0ZW50aW9ucyBhbmQgZmVl
ZGJhY2tzIGZyb20gdGhlIG1haW50YWluZXJzIHVudGlsDQo+IGl0J3MgYWNrbm93bGVkZ2VkLg0K
DQoNClRoZSBjaGFuZ2VzIHdlcmUgbWFpbmx5IHRvIGFkZHJlc3MgSWdvcidzIGNvbmNlcm4gd2hp
Y2ggaGF2ZSB0byBiZSByZXNwZWN0ZWQNCmFzIGhlIGlzIGEgbWFpbnRhaW5lciBvZiB2Q1BVIGhv
dHBsdWcgb24geDg2LiBBbmQgdG8gZW5zdXJlIHRoYXQgaGlzIHRpbWUgaXMNCnV0aWxpemVkIGJl
c3QgYXMgaGUgaXMgdW5kZXJzdGFuZGFibHkgYSBidXN5IHBlcnNvbiwgd2UgYWxsIHRob3VnaHQg
dG8gc2hhcmUgdGhlDQp1cGRhdGVkIGNvZGUgdG8gaGltLg0KDQpUaGVyZSBhcmUgZGVzaWduIGNo
YW5nZXMgYnV0IHRoZXNlIGFyZSBub3Qgd2hpY2ggbWFrZXMgdGhlIGRlc2lnbiBjb21wbGV0ZWx5
DQpkaWZmZXJlbnQgYXMgd2UgaGF2ZSB0byByZXNwZWN0IHRoZSBpbnRlcmZhY2VzIHdoaWNoIGhh
dmUgYmVlbiBmcm96ZW4gd2l0aCB0aGUNCmtlcm5lbCBhbmQgaGVuY2UgdGhlIGhhbmRzaGFrZXMg
aWRlYWxseSBzaG91bGQgcmVtYWluIHNhbWUuIEFsc28sIGFzIHBhcnQgb2YNCnRoZSByZXZpZXcs
IEkndmUgaGFkIHNvbWUgaW50ZXJuYWwgZGlzY3Vzc2lvbnMgcmVsYXRlZCB0byB0aGVzZSBjaGFu
Z2VzIGluIEh1YXdlaQ0Kd2l0aCBKb25hdGhhbiBhbmQgaGUgd2FzIGluIGFncmVlbWVudCB3aXRo
IHRoZSBhcHByb2FjaC4gQnV0IG9mIGNvdXJzZSwgZW5kDQphY2tub3dsZWRnZW1lbnQgaGFzIHRv
IGNvbWUgZnJvbSBJZ29yLiDwn5iKDQoNCiANCj4gPj4gQmVzaWRlcywgSSdtIHJlbHVjdGFudGx5
IHRvIGFzayBpZiB5b3UncmUgZmluZSBmb3Igc29tZSBib2R5IGVsc2UgdG8NCj4gPj4gcGljayB0
aGlzIHVwIGFuZCBjb250aW51ZSB0aGUgZWZmb3J0LiBUaGUgY3JlZGl0cyBmb3IgYWxsIHRoZQ0K
PiA+PiBjb250cmlidXRvcnMgKEtlcWlhbiBaaHUsIEplYW4gUGhpbGlwcGUsIE1pZ3VlbCBMdWlz
IGFuZCB5b3UpIHdpbGwgYmUga2VwdC4NCj4gPg0KPiA+IEkgZG9u4oCZdCB3YW50IHRvIHNwZWFr
IGZvciBvdGhlcnMsIGJ1dCBpbiBteSB2aWV3LCBTYWxpbCBzaG91bGQgaWRlYWxseQ0KPiA+IGJl
IHRoZSBvbmUgdG8gY29tcGxldGUgdGhpcyB3b3JrIOKAlCBhcyB5b3Ugc2FpZCwgaGXigJlzIGFs
cmVhZHkgaW52ZXN0ZWQNCj4gPiBhIGdyZWF0IGRlYWwgb2YgdGltZSBhbmQgZW5lcmd5IGludG8g
aXQuDQo+ID4NCj4gPiBJdCB3b3VsZCBiZSB0cmVtZW5kb3VzbHkgaGVscGZ1bCBpZiBtYWludGFp
bmVycyBjb3VsZCBzdXBwb3J0IFNhbGlsIGluDQo+ID4gYnJpbmdpbmcgdGhpcyB0byBjb21wbGV0
aW9uLCBraW5kbHkgZ3VpZGluZyBoaW0gdG93YXJkIHRoZSBwYXRoIHRvIGdldCBpdA0KPiBmaW5h
bGl6ZWQuDQo+ID4NCj4gDQo+IEFic29sdXRlbHksIFNhbGlsIGtub3dzIGFsbCB0aGUgZGV0YWls
cywgZXNwZWNpYWxseSB0aGUgaGlzdG9yaWMgc3RlcHMgaG93IHZDUFUNCj4gaG90cGx1ZyBoYXMg
YmVlbiBldm9sdmluZy4gSSB0cnVseSBob3BlIFNhbGlsIGlzIGFibGUgdG8gY29udGludWUgdGhl
IGVmZm9ydHMNCj4gdW50aWwgdGhlIGZlYXR1cmUgbGFuZHMgdXBzdHJlYW0hDQoNCg0KU29ycnks
IGZvciBhbnkgaGFzc2xlIGNhdXNlZCBkdWUgdG8gbXkgYWJzZW5jZXMuIFllcywgSSdtIGJhY2sg
dG8gd29yayBhbmQgd2lsbA0KdHJ5IHRvIGV4cGVkaXRlIHRoZSBjaGFuZ2VzIGFuZCBwaW5nIHlv
dSBzb29uIGZvciB5b3VyIGhlbHAuDQoNClRoYW5rcyBmb3IgdW5kZXJzdGFuZGluZy4NCg0KQmVz
dCByZWdhcmRzDQpTYWxpbC4NCg0KDQo+IA0KPiBUaGFua3MsDQo+IEdhdmluDQo+IA0KDQo=

