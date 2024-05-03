Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A000AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 19:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2yhd-0006Y1-GJ; Fri, 03 May 2024 15:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s2yha-0006XF-Hf; Fri, 03 May 2024 15:36:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s2yhX-0005Sf-Ol; Fri, 03 May 2024 15:36:14 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VWLcn6wcSz6K6g0;
 Sat,  4 May 2024 03:35:37 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
 by mail.maildlp.com (Postfix) with ESMTPS id B9D5D140B54;
 Sat,  4 May 2024 03:36:00 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 May 2024 20:36:00 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Fri, 3 May 2024 20:36:00 +0100
To: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
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
 Linuxarm <linuxarm@huawei.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>
Subject: RE: [PATCH V8 7/8] gdbstub: Add helper function to unregister GDB
 register space
Thread-Topic: [PATCH V8 7/8] gdbstub: Add helper function to unregister GDB
 register space
Thread-Index: AQHadCFhTRuMleCuw0qaMYaEBMUPxLFYOFYAgC33MmA=
Date: Fri, 3 May 2024 19:36:00 +0000
Message-ID: <2e0f85f252fe4c8b913c0fad45e60575@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-8-salil.mehta@huawei.com>
 <884099cd-f57f-417e-aff9-52a7d77dab31@amperemail.onmicrosoft.com>
In-Reply-To: <884099cd-f57f-417e-aff9-52a7d77dab31@amperemail.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.152.25]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

SGkgVmlzaG51LA0KU29ycnkgZm9yIHRoZSBkZWxheSBpbiByZXBseS4gU3RpbGwgY2F0Y2hpbmcg
dXAuDQoNCj4gIEZyb206IFZpc2hudSBQYWpqdXJpIDx2aXNobnVAYW1wZXJlbWFpbC5vbm1pY3Jv
c29mdC5jb20+IA0KPiAgU2VudDogVGh1cnNkYXksIEFwcmlsIDQsIDIwMjQgMzowMiBQTQ0KPiAg
VG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnOyBxZW11LWFybUBub25nbnUub3JnDQo+ICANCj4gIEhpIFNhbGlsLA0KPiAgT24gMTIt
MDMtMjAyNCAwNzoyOSwgU2FsaWwgTWVodGEgd3JvdGU6DQo+PiAgQWRkIGNvbW1vbiBmdW5jdGlv
biB0byBoZWxwIHVucmVnaXN0ZXIgdGhlIEdEQiByZWdpc3RlciBzcGFjZS4gVGhpcyBzaGFsbCBi
ZQ0KPj4gIGRvbmUgaW4gY29udGV4dCB0byB0aGUgQ1BVIHVucmVhbGl6YXRpb24uDQo+PiAgDQo+
PiAgU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgbWFpbHRvOnNhbGlsLm1laHRhQGh1YXdlaS5j
b20NCj4+ICBUZXN0ZWQtYnk6IFZpc2hudSBQYWpqdXJpIG1haWx0bzp2aXNobnVAb3MuYW1wZXJl
Y29tcHV0aW5nLmNvbQ0KPj4gIFJldmlld2VkLWJ5OiBHYXZpbiBTaGFuIG1haWx0bzpnc2hhbkBy
ZWRoYXQuY29tDQo+PiAgVGVzdGVkLWJ5OiBYaWFuZ2xhaSBMaSBtYWlsdG86bGl4aWFuZ2xhaUBs
b29uZ3Nvbi5jbg0KPj4gIFRlc3RlZC1ieTogTWlndWVsIEx1aXMgbWFpbHRvOm1pZ3VlbC5sdWlz
QG9yYWNsZS5jb20NCj4+ICBSZXZpZXdlZC1ieTogU2hhb3FpbiBIdWFuZyBtYWlsdG86c2hhaHVh
bmdAcmVkaGF0LmNvbQ0KPj4gIC0tLQ0KPj4gICBnZGJzdHViL2dkYnN0dWIuYz4gIHwgMTIgKysr
KysrKysrKysrDQo+PiAgIGluY2x1ZGUvZXhlYy9nZGJzdHViLmggfCAgNiArKysrKysNCj4+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+PiAgDQo+PiAgZGlmZiAtLWdpdCBh
L2dkYnN0dWIvZ2Ric3R1Yi5jIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4+ICBpbmRleCAxN2VmY2Fl
MGQwLi5hODQ0OWRjMzA5IDEwMDY0NA0KPj4gIC0tLSBhL2dkYnN0dWIvZ2Ric3R1Yi5jDQo+PiAg
KysrIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4+ICBAQCAtNjE1LDYgKzYxNSwxOCBAQCB2b2lkIGdk
Yl9yZWdpc3Rlcl9jb3Byb2Nlc3NvcihDUFVTdGF0ZSAqY3B1LA0KPj4gICAgICAgfQ0KPj4gICB9
DQo+PiAgIA0KPj4gICt2b2lkIGdkYl91bnJlZ2lzdGVyX2NvcHJvY2Vzc29yX2FsbChDUFVTdGF0
ZSAqY3B1KQ0KPj4gICt7DQo+PiAgKyAgICAvKg0KPj4gICsgICAgICogU2FmZSB0byBudWtlIGV2
ZXJ5dGhpbmcuIEdEQlJlZ2lzdGVyU3RhdGU6OnhtbCBpcyBzdGF0aWMgY29uc3QgY2hhciBzbw0K
Pj4gICsgICAgICogaXQgd29uJ3QgYmUgZnJlZWQNCj4+ICArICAgICAqLw0KPj4gICsgICAgZ19h
cnJheV9mcmVlKGNwdS0+Z2RiX3JlZ3MsIHRydWUpOw0KPj4gICsNCj4+ICArICAgIGNwdS0+Z2Ri
X3JlZ3MgPSBOVUxMOw0KPj4gICsgICAgY3B1LT5nZGJfbnVtX2dfcmVncyA9IDA7DQo+ICBMaWtl
d2lzZSwgeW91IG1heSBuZWVkIHRvIHNldCBnZGJfbnVtX3JlZ3MgdG8gemVybyBhcyB3ZWxsLg0K
DQoNClN1cmUsIHRoYW5rcy4NCg0KDQo+PiAgK30NCj4+ICArDQo+PiAgIHN0YXRpYyB2b2lkIGdk
Yl9wcm9jZXNzX2JyZWFrcG9pbnRfcmVtb3ZlX2FsbChHREJQcm9jZXNzICpwKQ0KPj4gICB7DQo+
PiAgICAgICBDUFVTdGF0ZSAqY3B1ID0gZ2RiX2dldF9maXJzdF9jcHVfaW5fcHJvY2VzcyhwKTsN
Cj4+ICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL2dkYnN0dWIuaCBiL2luY2x1ZGUvZXhlYy9n
ZGJzdHViLmgNCj4+ICBpbmRleCBlYjE0YjkxMTM5Li4yNDlkNGQ0YmM4IDEwMDY0NA0KPj4gIC0t
LSBhL2luY2x1ZGUvZXhlYy9nZGJzdHViLmgNCj4+ICArKysgYi9pbmNsdWRlL2V4ZWMvZ2Ric3R1
Yi5oDQo+PiAgQEAgLTQ5LDYgKzQ5LDEyIEBAIHZvaWQgZ2RiX3JlZ2lzdGVyX2NvcHJvY2Vzc29y
KENQVVN0YXRlICpjcHUsDQo+PiAgPiAgPiAgPiAgPiAgPiAgIGdkYl9nZXRfcmVnX2NiIGdldF9y
ZWcsIGdkYl9zZXRfcmVnX2NiIHNldF9yZWcsDQo+PiAgPiAgPiAgPiAgPiAgPiAgIGNvbnN0IEdE
QkZlYXR1cmUgKmZlYXR1cmUsIGludCBnX3Bvcyk7DQo+PiAgIA0KPj4gICsvKioNCj4+ICArICog
Z2RiX3VucmVnaXN0ZXJfY29wcm9jZXNzb3JfYWxsKCkgLSB1bnJlZ2lzdGVycyBzdXBwbGVtZW50
YWwgc2V0IG9mIHJlZ2lzdGVycw0KPj4gICsgKiBAY3B1IC0gdGhlIENQVSBhc3NvY2lhdGVkIHdp
dGggcmVnaXN0ZXJzDQo+PiAgKyAqLw0KPj4gICt2b2lkIGdkYl91bnJlZ2lzdGVyX2NvcHJvY2Vz
c29yX2FsbChDUFVTdGF0ZSAqY3B1KTsNCj4+ICArDQo+PiAgIC8qKg0KPj4gICAgKiBnZGJzZXJ2
ZXJfc3RhcnQ6IHN0YXJ0IHRoZSBnZGIgc2VydmVyDQo+PiAgICAqIEBwb3J0X29yX2RldmljZTog
Y29ubmVjdGlvbiBzcGVjIGZvciBnZGINCj4+ICBPdGhlcndpc2UsIExvb2tzIGdvb2QgdG8gbWUu
ICBGZWVsIGZyZWUgdG8gYWRkDQo+PiAgUmV2aWV3ZWQtYnk6ICJWaXNobnUgUGFqanVyaSIgbWFp
bHRvOnZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tDQoNClRoYW5rcw0KU2FsaWwuDQoNCg0K
Pj4gIFJlZ2FyZHMsDQo+PiAgLVZpc2hudQ0KDQo=

