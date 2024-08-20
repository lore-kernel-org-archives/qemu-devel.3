Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE17C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSO6-0008VC-5j; Tue, 20 Aug 2024 13:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sgSNx-0007yh-Sa; Tue, 20 Aug 2024 13:11:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sgSNr-00080Y-QL; Tue, 20 Aug 2024 13:11:06 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WpGBC2Tslz6K9FP;
 Wed, 21 Aug 2024 01:08:03 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id D14CE1400C9;
 Wed, 21 Aug 2024 01:10:59 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 18:10:59 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 20 Aug 2024 18:10:59 +0100
To: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 11/29] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
Thread-Topic: [PATCH RFC V3 11/29] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
Thread-Index: AQHavetL6ZWS3kCPn0Wbiq50SP2k0LIkrOeAgAo4YQCAALwQAIABKTWg
Date: Tue, 20 Aug 2024 17:10:59 +0000
Message-ID: <1b6f5681cd5b4d1c887c5423faf5875f@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-12-salil.mehta@huawei.com>
 <143ad7d2-8f45-4428-bed3-891203a49029@redhat.com>
 <b6bdee28101741169048819c0d562bfc@huawei.com>
 <52ae18ca-0a5a-44d4-95f5-56cfc7a035a8@redhat.com>
In-Reply-To: <52ae18ca-0a5a-44d4-95f5-56cfc7a035a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgR2F2aW4sDQoNCj4gIEZyb206IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+ICBT
ZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMjQgMToyMiBBTQ0KPiAgVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gIA0KPiAgSGkgU2FsaWwsDQo+ICAN
Cj4gIE9uIDgvMTkvMjQgMTA6MTAgUE0sIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPj4gICBGcm9t
OiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiAgPj4gICBTZW50OiBUdWVzZGF5LCBB
dWd1c3QgMTMsIDIwMjQgMjowNSBBTQ0KPiAgPj4gICBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ICA+PiAgIHFlbXUtYXJt
QG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tDQo+ICA+Pg0KPiAgPj4gICBPbiA2LzE0LzI0IDk6
MzYgQU0sIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPj4gICA+IEFDUEkgQ1BVIGhvdHBsdWcgc3Rh
dGUgKGlzX3ByZXNlbnQ9X1NUQS5QUkVTRU5ULA0KPiAgPj4gICA+IGlzX2VuYWJsZWQ9X1NUQS5F
TkFCTEVEKSBmb3IgYWxsIHRoZSBwb3NzaWJsZSB2Q1BVcyBNVVNUIGJlDQo+ICA+PiAgID4gaW5p
dGlhbGl6ZWQgZHVyaW5nIG1hY2hpbmUgaW5pdC4gVGhpcyBpcyBkb25lIGR1cmluZyB0aGUgY3Jl
YXRpb24gb2YNCj4gID4+ICAgPiB0aGUgR0VEIGRldmljZS4gVk1NL1FlbXUgTVVTVCBleHBvc2Uv
ZmFrZSB0aGUgQUNQSSBzdGF0ZSBvZiB0aGUNCj4gID4+ICAgPiBkaXNhYmxlZCB2Q1BVcyB0byB0
aGUgR3Vlc3Qga2VybmVsIGFzICdwcmVzZW50JyAoX1NUQS5QUkVTRU5UKSBhbHdheXMNCj4gID4+
ICAgPiBpLmUuIEFDUEkgcGVyc2lzdGVudC4gaWYgdGhlICdkaXNhYmxlZCcgdkNQVSBvYmplY3Rl
cyBhcmUgZGVzdHJveWVkDQo+ICA+PiAgID4gYmVmb3JlIHRoZSBHRUQgZGV2aWNlIGhhcyBiZWVu
IGNyZWF0ZWQgdGhlbiB0aGVpciBBQ1BJIGhvdHBsdWcgc3RhdGUNCj4gID4+ICAgPiBtaWdodCBu
b3QgZ2V0IGluaXRpYWxpemVkIGNvcnJlY3RseSBhcyBhY3BpX3BlcnNpc3RlbnQgZmxhZyBpcyBw
YXJ0IG9mIHRoZQ0KPiAgPj4gICBDUFVTdGF0ZS4gVGhpcyB3aWxsIGV4cG9zZSB3cm9uZyBzdGF0
dXMgb2YgdGhlIHVucGx1Z2dlZCB2Q1BVcyB0byB0aGUNCj4gID4+ICAgR3Vlc3Qga2VybmVsLg0K
PiAgPj4gICA+DQo+ICA+PiAgID4gSGVuY2UsIG1vdmluZyB0aGUgR0VEIGRldmljZSBjcmVhdGlv
biBiZWZvcmUgZGlzYWJsZWQgdkNQVSBvYmplY3RzIGdldA0KPiAgPj4gICA+IGRlc3Ryb3llZCBh
cyBwYXJ0IG9mIHRoZSBwb3N0IENQVSBpbml0IHJvdXRpbmUuDQo+ICA+PiAgID4NCj4gID4+ICAg
PiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4g
ID4+ICAgPiAtLS0NCj4gID4+ICAgPiAgIGh3L2FybS92aXJ0LmMgfCAxMCArKysrKysrLS0tDQo+
ICA+PiAgID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiAgPj4gICA+DQo+ICA+PiAgID4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMgYi9ody9h
cm0vdmlydC5jIGluZGV4DQo+ICA+PiAgID4gOTE4YmNiOWExYi4uNWY5ODE2MjU4NyAxMDA2NDQN
Cj4gID4+ICAgPiAtLS0gYS9ody9hcm0vdmlydC5jDQo+ICA+PiAgID4gKysrIGIvaHcvYXJtL3Zp
cnQuYw0KPiAgPj4gICA+IEBAIC0yNDY3LDYgKzI0NjcsMTIgQEAgc3RhdGljIHZvaWQgbWFjaHZp
cnRfaW5pdChNYWNoaW5lU3RhdGUNCj4gID4+ICAgPiAqbWFjaGluZSkNCj4gID4+ICAgPg0KPiAg
Pj4gICA+ICAgICAgIGNyZWF0ZV9naWModm1zLCBzeXNtZW0pOw0KPiAgPj4gICA+DQo+ICA+PiAg
ID4gKyAgICBoYXNfZ2VkID0gaGFzX2dlZCAmJiBhYXJjaDY0ICYmIGZpcm13YXJlX2xvYWRlZCAm
Jg0KPiAgPj4gICA+ICsgICAgICAgICAgICAgIHZpcnRfaXNfYWNwaV9lbmFibGVkKHZtcyk7DQo+
ICA+PiAgID4gKyAgICBpZiAoaGFzX2dlZCkgew0KPiAgPj4gICA+ICsgICAgICAgIHZtcy0+YWNw
aV9kZXYgPSBjcmVhdGVfYWNwaV9nZWQodm1zKTsNCj4gID4+ICAgPiArICAgIH0NCj4gID4+ICAg
PiArDQo+ICA+PiAgID4gICAgICAgdmlydF9jcHVfcG9zdF9pbml0KHZtcywgc3lzbWVtKTsNCj4g
ID4+ICAgPg0KPiAgPj4gICA+ICAgICAgIGZkdF9hZGRfcG11X25vZGVzKHZtcyk7DQo+ICA+PiAg
ID4gQEAgLTI0ODksOSArMjQ5NSw3IEBAIHN0YXRpYyB2b2lkIG1hY2h2aXJ0X2luaXQoTWFjaGlu
ZVN0YXRlDQo+ICA+PiAgICptYWNoaW5lKQ0KPiAgPj4gICA+DQo+ICA+PiAgID4gICAgICAgY3Jl
YXRlX3BjaWUodm1zKTsNCj4gID4+ICAgPg0KPiAgPj4gICA+IC0gICAgaWYgKGhhc19nZWQgJiYg
YWFyY2g2NCAmJiBmaXJtd2FyZV9sb2FkZWQgJiYNCj4gID4+ICAgdmlydF9pc19hY3BpX2VuYWJs
ZWQodm1zKSkgew0KPiAgPj4gICA+IC0gICAgICAgIHZtcy0+YWNwaV9kZXYgPSBjcmVhdGVfYWNw
aV9nZWQodm1zKTsNCj4gID4+ICAgPiAtICAgIH0gZWxzZSB7DQo+ICA+PiAgID4gKyAgICBpZiAo
IWhhc19nZWQpIHsNCj4gID4+ICAgPiAgICAgICAgICAgY3JlYXRlX2dwaW9fZGV2aWNlcyh2bXMs
IFZJUlRfR1BJTywgc3lzbWVtKTsNCj4gID4+ICAgPiAgICAgICB9DQo+ICA+PiAgID4NCj4gID4+
DQo+ICA+PiAgIEl0J3MgbGlrZWx5IHRoZSBHUElPIGRldmljZSBjYW4gYmUgY3JlYXRlZCBiZWZv
cmUgdGhvc2UgZGlzYWJsZWQgQ1BVIG9iamVjdHMNCj4gID4+ICAgYXJlIGRlc3Ryb3llZC4gSXQg
bWVhbnMgdGhlIHdob2xlIGNodW5rIG9mIGNvZGUgY2FuIGJlIG1vdmVkIHRvZ2V0aGVyLCBJDQo+
ICA+PiAgIHRoaW5rLg0KPiAgPg0KPiAgPiBJIHdhcyBub3QgdG90YWxseSBzdXJlIG9mIHRoaXMu
IEhlbmNlLCBrZXB0IHRoZSBvcmRlciBvZiB0aGUgcmVzdCBsaWtlDQo+ICA+IHRoYXQuIEkgY2Fu
IGRlZmluaXRlbHkgY2hlY2sgYWdhaW4gaWYgd2UgY2FuIGRvIHRoYXQgdG8gcmVkdWNlIHRoZSBj
aGFuZ2UuDQo+ICA+DQo+ICANCj4gIEBoYXNfZ2VkIGlzIHRoZSBlcXVpdmFsZW50IHRvICchdm1j
LT5ub19nZWQnIGluaXRpYWxseSBhbmQgdGhlbiBpdCdzDQo+ICBvdmVycmlkZWQgYnkgdGhlIGZv
bGxvd2luZyBjaGFuZ2VzIGluIHRoaXMgcGF0Y2guIFRoZSBzeW50YXggb2YgQGhhc19nZWQNCj4g
IGhhcyBiZWVuIGNoYW5nZWQgYW5kIGl0J3Mgbm90IHRoZSBiZXN0IG5hbWUgdG8gbWF0Y2ggdGhl
IGNoYW5nZXMuIFRoZXJlDQo+ICBhcmUgdHdvIHNvbHV0aW9uczogKDEpIFJlbmFtZSBAaGFzX2dl
ZCB0byBzb21ldGhpbmcgbWVhbmluZ2Z1bCBhbmQNCj4gIG1hdGNoaW5nIHdpdGggdGhlIGNoYW5n
ZXM7ICgyKSBNb3ZlIHRoZSB3aG9sZSBjaHVuayBvZiBjb2Rlcywgd2hpY2ggSQ0KPiAgcHJlZmVy
cmVkLiBUaGUgR1BJTyBkZXZpY2UgYW5kIEdFRCBkZXZpY2UgYXJlIHN1cHBsZW1lbnRpbmcgdG8g
ZWFjaA0KPiAgb3RoZXIsIG1lYW5pbmcgR1BJTyBkZXZpY2Ugd2lsbCBiZSBjcmVhdGVkIHdoZW4g
R0VEIGRldmljZSBoYXMgYmVlbg0KPiAgZGlzYWxsb3dlZC4NCj4gIA0KPiAgICAgICBoYXNfZ2Vk
ID0gaGFzX2dlZCAmJiBhYXJjaDY0ICYmIGZpcm13YXJlX2xvYWRlZCAmJg0KPiAgdmlydF9pc19h
Y3BpX2VuYWJsZWQodm1zKTsNCj4gIA0KPiAgVGhlIGNvZGUgdG8gYmUgbW92ZWQgdG9nZXRoZXIg
aW4gdmlydC5jIHNpbmNlIHRoZXkncmUgY29ycmVsYXRlZDoNCj4gIA0KPiAgICAgICBpZiAoaGFz
X2dlZCAmJiBhYXJjaDY0ICYmIGZpcm13YXJlX2xvYWRlZCAmJg0KPiAgdmlydF9pc19hY3BpX2Vu
YWJsZWQodm1zKSkgew0KPiAgICAgICAgICAgdm1zLT5hY3BpX2RldiA9IGNyZWF0ZV9hY3BpX2dl
ZCh2bXMpOw0KPiAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgY3JlYXRlX2dwaW9fZGV2aWNl
cyh2bXMsIFZJUlRfR1BJTywgc3lzbWVtKTsNCj4gICAgICAgfQ0KPiAgDQo+ICAgICAgIGlmICh2
bXMtPnNlY3VyZSAmJiAhdm1jLT5ub19zZWN1cmVfZ3Bpbykgew0KPiAgICAgICAgICAgY3JlYXRl
X2dwaW9fZGV2aWNlcyh2bXMsIFZJUlRfU0VDVVJFX0dQSU8sIHNlY3VyZV9zeXNtZW0pOw0KPiAg
ICAgICB9DQo+ICANCj4gICAgICAgIC8qIGNvbm5lY3QgcG93ZXJkb3duIHJlcXVlc3QgKi8NCj4g
ICAgICAgIHZtcy0+cG93ZXJkb3duX25vdGlmaWVyLm5vdGlmeSA9IHZpcnRfcG93ZXJkb3duX3Jl
cTsNCj4gICAgICAgIHFlbXVfcmVnaXN0ZXJfcG93ZXJkb3duX25vdGlmaWVyKCZ2bXMtPnBvd2Vy
ZG93bl9ub3RpZmllcik7DQoNCg0KSWYgdGhlcmUgaXMgbm8gZGVwZW5kZW5jeSB0aGVuIHdlIGNh
biBjb21wbGV0ZWx5IG1vdmUgYmVmb3JlICAgdmlydF9jcHVfcG9zdF9pbml0KCkuDQpJJ2xsIGdl
dCBiYWNrIHRvIHlvdSBvbiB0aGlzLg0KDQpUaGFua3MNClNhbGlsLg0KDQo+ICANCj4gIFRoYW5r
cywNCj4gIEdhdmluDQo+ICANCj4gIA0KPiAgDQo+ICANCg0K

