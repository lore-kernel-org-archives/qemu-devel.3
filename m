Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BC7D2C57C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 23:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3OZF-0001LZ-7u; Tue, 22 Oct 2024 19:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3OZA-0001LA-Pw; Tue, 22 Oct 2024 19:45:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3OZ7-00031i-UU; Tue, 22 Oct 2024 19:45:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XY7wB1gHlz6L765;
 Wed, 23 Oct 2024 07:40:42 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id C4164140B35;
 Wed, 23 Oct 2024 07:45:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:45:21 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 23 Oct 2024 01:45:21 +0200
To: Zhao Liu <zhao1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
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
 <shahuang@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Subject: RE: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Topic: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Index: AQHbHm6XRQnHA1hqSkuTlA12W4mCybKL2l8AgAehDuA=
Date: Tue, 22 Oct 2024 23:45:21 +0000
Message-ID: <b1d6b121f8d54d1a93e13666782cca99@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com> <ZxHuVC0uDL7kEB2i@intel.com>
In-Reply-To: <ZxHuVC0uDL7kEB2i@intel.com>
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

SGkgWmhhbywNCg0KU29ycnksIGZvciB0aGUgbGF0ZSByZXBseS4gSSB3YXMgYXdheSBsYXN0IHdl
ZWsgd2l0aCBvbmx5IGludGVybWl0dGVudCBhY2Nlc3MNCnRvIHRoZSBtYWlscy4NCg0KPiAgRnJv
bTogWmhhbyBMaXUgPHpoYW8xLmxpdUBpbnRlbC5jb20+DQo+ICBTZW50OiBGcmlkYXksIE9jdG9i
ZXIgMTgsIDIwMjQgNjoxMyBBTQ0KPiAgVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3
ZWkuY29tPg0KPiAgDQo+ICBIaSBTYWxpbCwNCj4gIA0KPiAgT24gTW9uLCBPY3QgMTQsIDIwMjQg
YXQgMDg6MjI6MDRQTSArMDEwMCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ICA+IERhdGU6IE1vbiwg
MTQgT2N0IDIwMjQgMjA6MjI6MDQgKzAxMDANCj4gID4gRnJvbTogU2FsaWwgTWVodGEgPHNhbGls
Lm1laHRhQGh1YXdlaS5jb20+DQo+ICA+IFN1YmplY3Q6IFtQQVRDSCBWMSAzLzRdIGh3L2FjcGk6
IFJlZmxlY3QgQUNQSSB2Q1BVIHtwcmVzZW50LGVuYWJsZWR9DQo+ICA+IHN0YXRlcyAgaW4gQUNQ
SSBfU1RBLntQUkVTLEVOQX0gQml0cw0KPiAgPiBYLU1haWxlcjogZ2l0LXNlbmQtZW1haWwgMi4z
NC4xDQo+ICA+DQo+ICA+IFJlZmxlY3QgdGhlIEFDUEkgQ1BVIGhvdHBsdWcgYGlzX3twcmVzZW50
LCBlbmFibGVkfWAgc3RhdGVzIGluIHRoZQ0KPiAgPiBgX1NUQS5QUkVTYA0KPiAgPiAocHJlc2Vu
Y2UpIGFuZCBgX1NUQS5FTkFgIChlbmFibGVkKSBiaXRzIHdoZW4gdGhlIGd1ZXN0IGtlcm5lbA0K
PiAgPiBldmFsdWF0ZXMgdGhlIEFDUEkgYF9TVEFgIG1ldGhvZCBkdXJpbmcgaW5pdGlhbGl6YXRp
b24sIGFzIHdlbGwgYXMNCj4gID4gd2hlbiB2Q1BVcyBhcmUgaG90LXBsdWdnZWQgb3IgaG90LXVu
cGx1Z2dlZC4gVGhlIHByZXNlbmNlIG9mDQo+ICB1bnBsdWdnZWQNCj4gID4gdkNQVXMgbWF5IG5l
ZWQgdG8gYmUgZGVsaWJlcmF0ZWx5DQo+ICA+ICpzaW11bGF0ZWQqIGF0IHRoZSBBQ1BJIGxldmVs
IHRvIG1haW50YWluIGEgKnBlcnNpc3RlbnQqIHZpZXcgb2YgdkNQVXMNCj4gID4gZm9yIHRoZSBn
dWVzdCBrZXJuZWwuDQo+ICA+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgPiAtLS0NCj4gID4gIGh3L2FjcGkvY3B1LmMgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ICA+DQo+ICANCj4gIEl0IHNlZW1zIHRoaXMgcGF0
Y2ggY2hhbmdlcyBBQ1BJIHRhYmxlIGxheW91dCBhbmQgdGhlbiBicmVha3MgY3VycmVudCBBQ1BJ
DQo+ICB0YWJsZSBxdGVzdC4gSSdtIG5vdCBzdXJlIGhvdyB0byBkbyBzdWNoIG1vZGlmaWNhdGlv
bnMuIE1heWJlIHlvdSBzaG91bGQNCj4gIGZpcnN0IGRpc2FibGUgdGhlIHJlbGF0ZWQgY2hlY2tz
LCB0aGVuIG1vZGlmeSB0aGUgY29kZSwgdXBkYXRlIHRoZSBxdGVzdCwgYW5kDQo+ICBmaW5hbGx5
IHJlLWVuYWJsZSB0aGUgY2hlY2tzIGZvciBxdGVzdC4gVGhpcyBjYW4gaGVscCB0byBhdm9pZCBh
bnkgcXRlc3QgZmFpbHVyZQ0KPiAgZHVlIHRvIHRoaXMgcGF0Y2g/DQoNCg0KVGhhbmtzIGZvciBy
ZXBvcnRpbmcuIExldCBtZSBnZXQgYmFjayB0byB5b3Ugb24gdGhpcy4NCg0KDQo+ICANCj4gIEkg
dGhpbmsgaXQgc2hvdWxkIGdldCBJZ29yJ3MgYWR2aWNlIG9uIHRoaXMuIDopDQo+ICANCj4gIEF0
dGFjaCB0aGUgZXJyb3IgSSBtZXQ6DQo+ICANCj4gIOKWtiAgIDIvOTIwIEVSUk9SOi4uL3Rlc3Rz
L3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzo1NTM6dGVzdF9hY3BpX2FzbDoNCj4gIGFzc2VydGlv
biBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKSBFUlJPUg0KPiAg4pa2ICAgMy85MjAgRVJST1I6
Li4vdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOjU1Mzp0ZXN0X2FjcGlfYXNsOg0KPiAg
YXNzZXJ0aW9uIGZhaWxlZDogKGFsbF90YWJsZXNfbWF0Y2gpIEVSUk9SDQo+ICAgIDIvOTIwIHFl
bXU6cXRlc3QrcXRlc3QtaTM4NiAvIHF0ZXN0LWkzODYvYmlvcy10YWJsZXMtdGVzdA0KPiAgRVJS
T1IgICAgICAgICAgICAxLjI0cyAgIGtpbGxlZCBieSBzaWduYWwgNiBTSUdBQlJUDQo+ICA+Pj4g
R19URVNUX0RCVVNfREFFTU9OPS9tZWRpYS9saXV6aGFvL2RhdGEvcWVtdS0NCj4gIGNvb2svdGVz
dHMvZGJ1cy12bXN0YXRlLQ0KPiAgPj4+IGRhZW1vbi5zaA0KPiAgPj4+IEFTQU5fT1BUSU9OUz1o
YWx0X29uX2Vycm9yPTE6YWJvcnRfb25fZXJyb3I9MTpwcmludF9zdW1tYXJ5PTENCj4gID4+PiBN
RVNPTl9URVNUX0lURVJBVElPTj0xDQo+ICA+Pj4NCj4gIFVCU0FOX09QVElPTlM9aGFsdF9vbl9l
cnJvcj0xOmFib3J0X29uX2Vycm9yPTE6cHJpbnRfc3VtbWFyeT0xOnByDQo+ICBpbnQNCj4gID4+
PiBfc3RhY2t0cmFjZT0xIFFURVNUX1FFTVVfQklOQVJZPS4vcWVtdS1zeXN0ZW0taTM4Ng0KPiAg
Pj4+IE1BTExPQ19QRVJUVVJCXz0xNDINCj4gID4+Pg0KPiAgTVNBTl9PUFRJT05TPWhhbHRfb25f
ZXJyb3I9MTphYm9ydF9vbl9lcnJvcj0xOnByaW50X3N1bW1hcnk9MTpwcmkNCj4gIG50Xw0KPiAg
Pj4+IHN0YWNrdHJhY2U9MQ0KPiAgPj4+IFFURVNUX1FFTVVfU1RPUkFHRV9EQUVNT05fQklOQVJZ
PS4vc3RvcmFnZS0NCj4gIGRhZW1vbi9xZW11LXN0b3JhZ2UtZGFlbW8NCj4gID4+PiBuIFFURVNU
X1FFTVVfSU1HPS4vcWVtdS1pbWcNCj4gID4+PiBQWVRIT049L21lZGlhL2xpdXpoYW8vZGF0YS9x
ZW11LWNvb2svYnVpbGQvcHl2ZW52L2Jpbi9weXRob24zDQo+ICA+Pj4gL21lZGlhL2xpdXpoYW8v
ZGF0YS9xZW11LWNvb2svYnVpbGQvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdA0KPiAgPj4+
IC0tdGFwIC1rDQo+ICDigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJUN
Cj4gIOKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAlQ0KPiAg4oCV4oCV
4oCV4oCV4oCV4oCV4oCVIOKcgA0KPiAg4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCVDQo+ICDigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJUN
Cj4gIOKAleKAleKAleKAleKAleKAleKAlQ0KPiAgc3RkZXJyOg0KPiAgYWNwaS10ZXN0OiBXYXJu
aW5nISBEU0RUIGJpbmFyeSBmaWxlIG1pc21hdGNoLiBBY3R1YWwgW2FtbDovdG1wL2FtbC0NCj4g
IFZSVDVWMl0sIEV4cGVjdGVkIFthbWw6dGVzdHMvZGF0YS9hY3BpL3g4Ni9wYy9EU0RUXS4NCj4g
IFNlZSBzb3VyY2UgZmlsZSB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMgZm9yIGluc3Ry
dWN0aW9ucyBvbiBob3cgdG8NCj4gIHVwZGF0ZSBleHBlY3RlZCBmaWxlcy4NCj4gIGFjcGktdGVz
dDogV2FybmluZyEgRFNEVCBtaXNtYXRjaC4gQWN0dWFsIFthc2w6L3RtcC9hc2wtVFRUNVYyLmRz
bCwNCj4gIGFtbDovdG1wL2FtbC1WUlQ1VjJdLCBFeHBlY3RlZCBbYXNsOi90bXAvYXNsLVhYTTVW
Mi5kc2wsDQo+ICBhbWw6dGVzdHMvZGF0YS9hY3BpL3g4Ni9wYy9EU0RUXS4NCj4gICoqDQo+ICBF
UlJPUjouLi90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6NTUzOnRlc3RfYWNwaV9hc2w6
IGFzc2VydGlvbiBmYWlsZWQ6DQo+ICAoYWxsX3RhYmxlc19tYXRjaCkNCj4gIA0KPiAgKHRlc3Qg
cHJvZ3JhbSBleGl0ZWQgd2l0aCBzdGF0dXMgY29kZSAtNikNCj4gIOKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAlQ0KPiAg4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCVDQo+ICDigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJUNCj4gIOKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAlQ0KPiAg
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQo+
ICANCj4gICAgMy85MjAgcWVtdTpxdGVzdCtxdGVzdC14ODZfNjQgLyBxdGVzdC14ODZfNjQvYmlv
cy10YWJsZXMtdGVzdA0KPiAgRVJST1IgICAgICAgICAgICAxLjI1cyAgIGtpbGxlZCBieSBzaWdu
YWwgNiBTSUdBQlJUDQo+ICA+Pj4gR19URVNUX0RCVVNfREFFTU9OPS9tZWRpYS9saXV6aGFvL2Rh
dGEvcWVtdS0NCj4gIGNvb2svdGVzdHMvZGJ1cy12bXN0YXRlLQ0KPiAgPj4+IGRhZW1vbi5zaA0K
PiAgPj4+IEFTQU5fT1BUSU9OUz1oYWx0X29uX2Vycm9yPTE6YWJvcnRfb25fZXJyb3I9MTpwcmlu
dF9zdW1tYXJ5PTENCj4gID4+PiBNRVNPTl9URVNUX0lURVJBVElPTj0xDQo+ICA+Pj4NCj4gIFVC
U0FOX09QVElPTlM9aGFsdF9vbl9lcnJvcj0xOmFib3J0X29uX2Vycm9yPTE6cHJpbnRfc3VtbWFy
eT0xOnByDQo+ICBpbnQNCj4gID4+PiBfc3RhY2t0cmFjZT0xDQo+ICA+Pj4NCj4gIE1TQU5fT1BU
SU9OUz1oYWx0X29uX2Vycm9yPTE6YWJvcnRfb25fZXJyb3I9MTpwcmludF9zdW1tYXJ5PTE6cHJp
DQo+ICBudF8NCj4gID4+PiBzdGFja3RyYWNlPTENCj4gID4+PiBRVEVTVF9RRU1VX1NUT1JBR0Vf
REFFTU9OX0JJTkFSWT0uL3N0b3JhZ2UtDQo+ICBkYWVtb24vcWVtdS1zdG9yYWdlLWRhZW1vDQo+
ICA+Pj4gbiBRVEVTVF9RRU1VX0lNRz0uL3FlbXUtaW1nDQo+ICA+Pj4gUFlUSE9OPS9tZWRpYS9s
aXV6aGFvL2RhdGEvcWVtdS1jb29rL2J1aWxkL3B5dmVudi9iaW4vcHl0aG9uMw0KPiAgPj4+IE1B
TExPQ19QRVJUVVJCXz00MSBRVEVTVF9RRU1VX0JJTkFSWT0uL3FlbXUtc3lzdGVtLQ0KPiAgeDg2
XzY0DQo+ICA+Pj4gL21lZGlhL2xpdXpoYW8vZGF0YS9xZW11LWNvb2svYnVpbGQvdGVzdHMvcXRl
c3QvYmlvcy10YWJsZXMtdGVzdA0KPiAgPj4+IC0tdGFwIC1rDQo+ICDigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4gIOKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAlQ0KPiAg4oCV4oCV4oCV4oCV4oCV4oCV4oCVIOKcgA0KPiAg4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQo+ICDigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4gIOKAleKAleKAleKAleKAleKAleKAlQ0KPiAg
c3RkZXJyOg0KPiAgYWNwaS10ZXN0OiBXYXJuaW5nISBEU0RUIGJpbmFyeSBmaWxlIG1pc21hdGNo
LiBBY3R1YWwgW2FtbDovdG1wL2FtbC0NCj4gIEQ1SzVWMl0sIEV4cGVjdGVkIFthbWw6dGVzdHMv
ZGF0YS9hY3BpL3g4Ni9wYy9EU0RUXS4NCj4gIFNlZSBzb3VyY2UgZmlsZSB0ZXN0cy9xdGVzdC9i
aW9zLXRhYmxlcy10ZXN0LmMgZm9yIGluc3RydWN0aW9ucyBvbiBob3cgdG8NCj4gIHVwZGF0ZSBl
eHBlY3RlZCBmaWxlcy4NCj4gIGFjcGktdGVzdDogV2FybmluZyEgRFNEVCBtaXNtYXRjaC4gQWN0
dWFsIFthc2w6L3RtcC9hc2wtRzZLNVYyLmRzbCwNCj4gIGFtbDovdG1wL2FtbC1ENUs1VjJdLCBF
eHBlY3RlZCBbYXNsOi90bXAvYXNsLUFRRDVWMi5kc2wsDQo+ICBhbWw6dGVzdHMvZGF0YS9hY3Bp
L3g4Ni9wYy9EU0RUXS4NCj4gICoqDQo+ICBFUlJPUjouLi90ZXN0cy9xdGVzdC9iaW9zLXRhYmxl
cy10ZXN0LmM6NTUzOnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6DQo+ICAoYWxsX3Rh
Ymxlc19tYXRjaCkNCj4gIA0KPiAgKHRlc3QgcHJvZ3JhbSBleGl0ZWQgd2l0aCBzdGF0dXMgY29k
ZSAtNikNCj4gIA0KPiAgDQo+ICBSZWdhcmRzLA0KPiAgWmhhbw0KPiAgDQo+ICANCg0K

