Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8902D2C57C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 23:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Oe8-0002IA-Fl; Tue, 22 Oct 2024 19:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3Oe5-0002Hb-TI; Tue, 22 Oct 2024 19:50:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3Oe3-0003Qt-R3; Tue, 22 Oct 2024 19:50:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XY82971nzz6LCm0;
 Wed, 23 Oct 2024 07:45:53 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 8A055140AB8;
 Wed, 23 Oct 2024 07:50:33 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:50:33 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 23 Oct 2024 01:50:32 +0200
To: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
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
 "shahuang@redhat.com" <shahuang@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Subject: RE: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Topic: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Index: AQHbHm6XRQnHA1hqSkuTlA12W4mCybKL2l8AgACYrgCABwol8A==
Date: Tue, 22 Oct 2024 23:50:32 +0000
Message-ID: <74bbcd75843240a98622227a3f60396b@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com>	<ZxHuVC0uDL7kEB2i@intel.com>
 <20241018161920.20524a97@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241018161920.20524a97@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.112]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQo+ICBGcm9tOiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPg0KPiAgU2VudDog
RnJpZGF5LCBPY3RvYmVyIDE4LCAyMDI0IDM6MTkgUE0NCj4gIFRvOiBaaGFvIExpdSA8emhhbzEu
bGl1QGludGVsLmNvbT4NCj4gIENjOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gIHFlbXUtYXJtQG5vbmdudS5vcmc7IG1zdEBy
ZWRoYXQuY29tOyBtYXpAa2VybmVsLm9yZzsgamVhbi0NCj4gIHBoaWxpcHBlQGxpbmFyby5vcmc7
IEpvbmF0aGFuIENhbWVyb24NCj4gIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGll
cmFsaXNpQGtlcm5lbC5vcmc7DQo+ICBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHJpY2hhcmQu
aGVuZGVyc29uQGxpbmFyby5vcmc7DQo+ICBhbmRyZXcuam9uZXNAbGludXguZGV2OyBkYXZpZEBy
ZWRoYXQuY29tOyBwaGlsbWRAbGluYXJvLm9yZzsNCj4gIGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsg
d2lsbEBrZXJuZWwub3JnOyBhcmRiQGtlcm5lbC5vcmc7DQo+ICBvbGl2ZXIudXB0b25AbGludXgu
ZGV2OyBwYm9uemluaUByZWRoYXQuY29tOyBnc2hhbkByZWRoYXQuY29tOw0KPiAgcmFmYWVsQGtl
cm5lbC5vcmc7IGJvcm50cmFlZ2VyQGxpbnV4LmlibS5jb207IGFsZXguYmVubmVlQGxpbmFyby5v
cmc7DQo+ICBucGlnZ2luQGdtYWlsLmNvbTsgaGFyc2hwYkBsaW51eC5pYm0uY29tOyBsaW51eEBh
cm1saW51eC5vcmcudWs7DQo+ICBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgaWxra2FA
b3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4gIHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29t
OyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsNCj4gIG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207IHNh
bGlsLm1laHRhQG9wbnNyYy5uZXQ7IHpodWtlcWlhbg0KPiAgPHpodWtlcWlhbjFAaHVhd2VpLmNv
bT47IHdhbmd4aW9uZ2ZlbmcgKEMpDQo+ICA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47IHdh
bmd5YW5hbiAoWSkNCj4gIDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgamlha2VybmVsMkBnbWFp
bC5jb207DQo+ICBtYW9iaWJvQGxvb25nc29uLmNuOyBsaXhpYW5nbGFpQGxvb25nc29uLmNuOyBz
aGFodWFuZ0ByZWRoYXQuY29tOw0KPiAgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBn
dXN0YXZvLnJvbWVyb0BsaW5hcm8ub3JnDQo+ICBTdWJqZWN0OiBSZTogW1BBVENIIFYxIDMvNF0g
aHcvYWNwaTogUmVmbGVjdCBBQ1BJIHZDUFUge3ByZXNlbnQsZW5hYmxlZH0NCj4gIHN0YXRlcyBp
biBBQ1BJIF9TVEEue1BSRVMsRU5BfSBCaXRzDQo+ICANCj4gIE9uIEZyaSwgMTggT2N0IDIwMjQg
MTM6MTI6NTIgKzA4MDANCj4gIFpoYW8gTGl1IDx6aGFvMS5saXVAaW50ZWwuY29tPiB3cm90ZToN
Cj4gIA0KPiAgPiBIaSBTYWxpbCwNCj4gID4NCj4gID4gT24gTW9uLCBPY3QgMTQsIDIwMjQgYXQg
MDg6MjI6MDRQTSArMDEwMCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ICA+ID4gRGF0ZTogTW9uLCAx
NCBPY3QgMjAyNCAyMDoyMjowNCArMDEwMA0KPiAgPiA+IEZyb206IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgPiA+IFN1YmplY3Q6IFtQQVRDSCBWMSAzLzRdIGh3L2Fj
cGk6IFJlZmxlY3QgQUNQSSB2Q1BVIHtwcmVzZW50LGVuYWJsZWR9DQo+ICA+ID4gc3RhdGVzICBp
biBBQ1BJIF9TVEEue1BSRVMsRU5BfSBCaXRzDQo+ICA+ID4gWC1NYWlsZXI6IGdpdC1zZW5kLWVt
YWlsIDIuMzQuMQ0KPiAgPiA+DQo+ICA+ID4gUmVmbGVjdCB0aGUgQUNQSSBDUFUgaG90cGx1ZyBg
aXNfe3ByZXNlbnQsIGVuYWJsZWR9YCBzdGF0ZXMgaW4gdGhlDQo+ICA+ID4gYF9TVEEuUFJFU2AN
Cj4gID4gPiAocHJlc2VuY2UpIGFuZCBgX1NUQS5FTkFgIChlbmFibGVkKSBiaXRzIHdoZW4gdGhl
IGd1ZXN0IGtlcm5lbA0KPiAgPiA+IGV2YWx1YXRlcyB0aGUgQUNQSSBgX1NUQWAgbWV0aG9kIGR1
cmluZyBpbml0aWFsaXphdGlvbiwgYXMgd2VsbCBhcw0KPiAgPiA+IHdoZW4gdkNQVXMgYXJlIGhv
dC1wbHVnZ2VkIG9yIGhvdC11bnBsdWdnZWQuIFRoZSBwcmVzZW5jZSBvZg0KPiAgPiA+IHVucGx1
Z2dlZCB2Q1BVcyBtYXkgbmVlZCB0byBiZSBkZWxpYmVyYXRlbHkNCj4gID4gPiAqc2ltdWxhdGVk
KiBhdCB0aGUgQUNQSSBsZXZlbCB0byBtYWludGFpbiBhICpwZXJzaXN0ZW50KiB2aWV3IG9mDQo+
ICA+ID4gdkNQVXMgZm9yIHRoZSBndWVzdCBrZXJuZWwuDQo+ICA+ID4NCj4gID4gPiBTaWduZWQt
b2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4gPiAtLS0N
Cj4gID4gPiAgaHcvYWNwaS9jcHUuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKystLS0tDQo+
ICA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiAgPiA+DQo+ICA+DQo+ICA+IEl0IHNlZW1zIHRoaXMgcGF0Y2ggY2hhbmdlcyBBQ1BJIHRhYmxl
IGxheW91dCBhbmQgdGhlbiBicmVha3MgY3VycmVudA0KPiAgPiBBQ1BJIHRhYmxlIHF0ZXN0LiBJ
J20gbm90IHN1cmUgaG93IHRvIGRvIHN1Y2ggbW9kaWZpY2F0aW9ucy4gTWF5YmUgeW91DQo+ICA+
IHNob3VsZCBmaXJzdCBkaXNhYmxlIHRoZSByZWxhdGVkIGNoZWNrcywgdGhlbiBtb2RpZnkgdGhl
IGNvZGUsIHVwZGF0ZQ0KPiAgPiB0aGUgcXRlc3QsIGFuZCBmaW5hbGx5IHJlLWVuYWJsZSB0aGUg
Y2hlY2tzIGZvciBxdGVzdC4gVGhpcyBjYW4gaGVscA0KPiAgPiB0byBhdm9pZCBhbnkgcXRlc3Qg
ZmFpbHVyZSBkdWUgdG8gdGhpcyBwYXRjaD8NCj4gIA0KPiAgc2VlIGNvbW1lbnQgYXQgdGhlIHRv
cCBvZiB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMNCg0KDQpUaGFua3MgZm9yIHRoZSBw
b2ludGVycy4NCg0KDQo+ICANCj4gID4NCj4gID4gSSB0aGluayBpdCBzaG91bGQgZ2V0IElnb3In
cyBhZHZpY2Ugb24gdGhpcy4gOikNCj4gID4NCj4gID4gQXR0YWNoIHRoZSBlcnJvciBJIG1ldDoN
Cj4gID4NCj4gID4g4pa2ICAgMi85MjAgRVJST1I6Li4vdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMt
dGVzdC5jOjU1Mzp0ZXN0X2FjcGlfYXNsOg0KPiAgYXNzZXJ0aW9uIGZhaWxlZDogKGFsbF90YWJs
ZXNfbWF0Y2gpIEVSUk9SDQo+ICA+IOKWtiAgIDMvOTIwIEVSUk9SOi4uL3Rlc3RzL3F0ZXN0L2Jp
b3MtdGFibGVzLXRlc3QuYzo1NTM6dGVzdF9hY3BpX2FzbDoNCj4gIGFzc2VydGlvbiBmYWlsZWQ6
IChhbGxfdGFibGVzX21hdGNoKSBFUlJPUg0KPiAgPiAgIDIvOTIwIHFlbXU6cXRlc3QrcXRlc3Qt
aTM4NiAvIHF0ZXN0LWkzODYvYmlvcy10YWJsZXMtdGVzdA0KPiAgRVJST1IgICAgICAgICAgICAx
LjI0cyAgIGtpbGxlZCBieSBzaWduYWwgNiBTSUdBQlJUDQo+ICA+ID4+PiBHX1RFU1RfREJVU19E
QUVNT049L21lZGlhL2xpdXpoYW8vZGF0YS9xZW11LQ0KPiAgY29vay90ZXN0cy9kYnVzLXZtc3Rh
dA0KPiAgPiA+Pj4gZS1kYWVtb24uc2gNCj4gID4gPj4+DQo+ICBBU0FOX09QVElPTlM9aGFsdF9v
bl9lcnJvcj0xOmFib3J0X29uX2Vycm9yPTE6cHJpbnRfc3VtbWFyeT0xDQo+ICA+ID4+PiBNRVNP
Tl9URVNUX0lURVJBVElPTj0xDQo+ICA+ID4+Pg0KPiAgVUJTQU5fT1BUSU9OUz1oYWx0X29uX2Vy
cm9yPTE6YWJvcnRfb25fZXJyb3I9MTpwcmludF9zdW1tYXJ5PTE6cHINCj4gIGkNCj4gID4gPj4+
IG50X3N0YWNrdHJhY2U9MSBRVEVTVF9RRU1VX0JJTkFSWT0uL3FlbXUtc3lzdGVtLWkzODYNCj4g
ID4gPj4+IE1BTExPQ19QRVJUVVJCXz0xNDINCj4gID4gPj4+DQo+ICBNU0FOX09QVElPTlM9aGFs
dF9vbl9lcnJvcj0xOmFib3J0X29uX2Vycm9yPTE6cHJpbnRfc3VtbWFyeT0xOnByaQ0KPiAgbg0K
PiAgPiA+Pj4gdF9zdGFja3RyYWNlPTENCj4gID4gPj4+IFFURVNUX1FFTVVfU1RPUkFHRV9EQUVN
T05fQklOQVJZPS4vc3RvcmFnZS0NCj4gIGRhZW1vbi9xZW11LXN0b3JhZ2UtZGFlDQo+ICA+ID4+
PiBtb24gUVRFU1RfUUVNVV9JTUc9Li9xZW11LWltZw0KPiAgPiA+Pj4gUFlUSE9OPS9tZWRpYS9s
aXV6aGFvL2RhdGEvcWVtdS0NCj4gIGNvb2svYnVpbGQvcHl2ZW52L2Jpbi9weXRob24zDQo+ICA+
ID4+PiAvbWVkaWEvbGl1emhhby9kYXRhL3FlbXUtY29vay9idWlsZC90ZXN0cy9xdGVzdC9iaW9z
LXRhYmxlcy10ZXN0DQo+ICA+ID4+PiAtLXRhcCAtaw0KPiAgPg0KPiAg4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQo+ICDigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJUNCj4gIOKAleKAleKAleKAlQ0KPiAgPiDigJXigJXigJUg4pyADQo+
ICA+DQo+ICDigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4gIOKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAlQ0KPiAg4oCV4oCV4oCV4oCV
DQo+ICA+IOKAleKAleKAlQ0KPiAgPiBzdGRlcnI6DQo+ICA+IGFjcGktdGVzdDogV2FybmluZyEg
RFNEVCBiaW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsIFthbWw6L3RtcC9hbWwtDQo+ICBWUlQ1
VjJdLCBFeHBlY3RlZCBbYW1sOnRlc3RzL2RhdGEvYWNwaS94ODYvcGMvRFNEVF0uDQo+ICA+IFNl
ZSBzb3VyY2UgZmlsZSB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMgZm9yIGluc3RydWN0
aW9ucyBvbiBob3cgdG8NCj4gIHVwZGF0ZSBleHBlY3RlZCBmaWxlcy4NCj4gID4gYWNwaS10ZXN0
OiBXYXJuaW5nISBEU0RUIG1pc21hdGNoLiBBY3R1YWwgW2FzbDovdG1wL2FzbC1UVFQ1VjIuZHNs
LA0KPiAgYW1sOi90bXAvYW1sLVZSVDVWMl0sIEV4cGVjdGVkIFthc2w6L3RtcC9hc2wtWFhNNVYy
LmRzbCwNCj4gIGFtbDp0ZXN0cy9kYXRhL2FjcGkveDg2L3BjL0RTRFRdLg0KPiAgPiAqKg0KPiAg
PiBFUlJPUjouLi90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6NTUzOnRlc3RfYWNwaV9h
c2w6IGFzc2VydGlvbg0KPiAgPiBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKQ0KPiAgPg0KPiAg
PiAodGVzdCBwcm9ncmFtIGV4aXRlZCB3aXRoIHN0YXR1cyBjb2RlIC02KQ0KPiAgPg0KPiAg4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQo+ICDigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4gIOKAleKAleKAleKAlQ0KPiAgPg0KPiAg
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQo+ICDigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4gIOKAleKAleKAleKAlQ0KPiAgPiDi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4gID4NCj4gID4gICAzLzkyMCBxZW11OnF0
ZXN0K3F0ZXN0LXg4Nl82NCAvIHF0ZXN0LXg4Nl82NC9iaW9zLXRhYmxlcy10ZXN0DQo+ICBFUlJP
UiAgICAgICAgICAgIDEuMjVzICAga2lsbGVkIGJ5IHNpZ25hbCA2IFNJR0FCUlQNCj4gID4gPj4+
IEdfVEVTVF9EQlVTX0RBRU1PTj0vbWVkaWEvbGl1emhhby9kYXRhL3FlbXUtDQo+ICBjb29rL3Rl
c3RzL2RidXMtdm1zdGF0DQo+ICA+ID4+PiBlLWRhZW1vbi5zaA0KPiAgPiA+Pj4NCj4gIEFTQU5f
T1BUSU9OUz1oYWx0X29uX2Vycm9yPTE6YWJvcnRfb25fZXJyb3I9MTpwcmludF9zdW1tYXJ5PTEN
Cj4gID4gPj4+IE1FU09OX1RFU1RfSVRFUkFUSU9OPTENCj4gID4gPj4+DQo+ICBVQlNBTl9PUFRJ
T05TPWhhbHRfb25fZXJyb3I9MTphYm9ydF9vbl9lcnJvcj0xOnByaW50X3N1bW1hcnk9MTpwcg0K
PiAgaQ0KPiAgPiA+Pj4gbnRfc3RhY2t0cmFjZT0xDQo+ICA+ID4+Pg0KPiAgTVNBTl9PUFRJT05T
PWhhbHRfb25fZXJyb3I9MTphYm9ydF9vbl9lcnJvcj0xOnByaW50X3N1bW1hcnk9MTpwcmkNCj4g
IG4NCj4gID4gPj4+IHRfc3RhY2t0cmFjZT0xDQo+ICA+ID4+PiBRVEVTVF9RRU1VX1NUT1JBR0Vf
REFFTU9OX0JJTkFSWT0uL3N0b3JhZ2UtDQo+ICBkYWVtb24vcWVtdS1zdG9yYWdlLWRhZQ0KPiAg
PiA+Pj4gbW9uIFFURVNUX1FFTVVfSU1HPS4vcWVtdS1pbWcNCj4gID4gPj4+IFBZVEhPTj0vbWVk
aWEvbGl1emhhby9kYXRhL3FlbXUtDQo+ICBjb29rL2J1aWxkL3B5dmVudi9iaW4vcHl0aG9uMw0K
PiAgPiA+Pj4gTUFMTE9DX1BFUlRVUkJfPTQxIFFURVNUX1FFTVVfQklOQVJZPS4vcWVtdS1zeXN0
ZW0tDQo+ICB4ODZfNjQNCj4gID4gPj4+IC9tZWRpYS9saXV6aGFvL2RhdGEvcWVtdS1jb29rL2J1
aWxkL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QNCj4gID4gPj4+IC0tdGFwIC1rDQo+ICA+
DQo+ICDigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4gIOKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAlQ0KPiAg4oCV4oCV4oCV4oCVDQo+
ICA+IOKAleKAleKAlSDinIANCj4gID4NCj4gIOKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAlQ0KPiAg4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCVDQo+ICDigJXigJXigJXigJUNCj4gID4g4oCV4oCV4oCVDQo+ICA+IHN0ZGVycjoNCj4gID4g
YWNwaS10ZXN0OiBXYXJuaW5nISBEU0RUIGJpbmFyeSBmaWxlIG1pc21hdGNoLiBBY3R1YWwgW2Ft
bDovdG1wL2FtbC0NCj4gIEQ1SzVWMl0sIEV4cGVjdGVkIFthbWw6dGVzdHMvZGF0YS9hY3BpL3g4
Ni9wYy9EU0RUXS4NCj4gID4gU2VlIHNvdXJjZSBmaWxlIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVz
LXRlc3QuYyBmb3IgaW5zdHJ1Y3Rpb25zIG9uIGhvdyB0bw0KPiAgdXBkYXRlIGV4cGVjdGVkIGZp
bGVzLg0KPiAgPiBhY3BpLXRlc3Q6IFdhcm5pbmchIERTRFQgbWlzbWF0Y2guIEFjdHVhbCBbYXNs
Oi90bXAvYXNsLUc2SzVWMi5kc2wsDQo+ICBhbWw6L3RtcC9hbWwtRDVLNVYyXSwgRXhwZWN0ZWQg
W2FzbDovdG1wL2FzbC1BUUQ1VjIuZHNsLA0KPiAgYW1sOnRlc3RzL2RhdGEvYWNwaS94ODYvcGMv
RFNEVF0uDQo+ICA+ICoqDQo+ICA+IEVSUk9SOi4uL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRl
c3QuYzo1NTM6dGVzdF9hY3BpX2FzbDogYXNzZXJ0aW9uDQo+ICA+IGZhaWxlZDogKGFsbF90YWJs
ZXNfbWF0Y2gpDQo+ICA+DQo+ICA+ICh0ZXN0IHByb2dyYW0gZXhpdGVkIHdpdGggc3RhdHVzIGNv
ZGUgLTYpDQo+ICA+DQo+ICA+DQo+ICA+IFJlZ2FyZHMsDQo+ICA+IFpoYW8NCj4gID4NCj4gID4N
Cj4gIA0KDQo=

