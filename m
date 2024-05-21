Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FF2C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 14:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Qtj-0005ir-7g; Tue, 21 May 2024 10:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s9Qth-0005iT-KE; Tue, 21 May 2024 10:55:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s9Qte-000634-FZ; Tue, 21 May 2024 10:55:25 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VkHSY6W6rz6FGqY;
 Tue, 21 May 2024 22:51:25 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 858AF1400DD;
 Tue, 21 May 2024 22:55:14 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 15:55:14 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 21 May 2024 15:55:14 +0100
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>, Shaoqin Huang
 <shahuang@redhat.com>
Subject: RE: [PATCH V10 7/8] gdbstub: Add helper function to unregister GDB
 register space
Thread-Topic: [PATCH V10 7/8] gdbstub: Add helper function to unregister GDB
 register space
Thread-Index: AQHaqw58iWfFbXDiBUGABVy+QLlh5LGho0hdgAAHJ3A=
Date: Tue, 21 May 2024 14:55:13 +0000
Message-ID: <00d3d97d51df449a88b771174b37f979@huawei.com>
References: <20240520233241.229675-1-salil.mehta@huawei.com>
 <20240520233241.229675-8-salil.mehta@huawei.com>
 <87seybibax.fsf@draig.linaro.org>
In-Reply-To: <87seybibax.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

SGkgQWxleCwNCg0KPiAgRnJvbTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
Pg0KPiAgU2VudDogVHVlc2RheSwgTWF5IDIxLCAyMDI0IDE6NDUgUE0NCj4gIFRvOiBTYWxpbCBN
ZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIA0KPiAgU2FsaWwgTWVodGEgPHNhbGls
Lm1laHRhQGh1YXdlaS5jb20+IHdyaXRlczoNCj4gIA0KPiAgPiBBZGQgY29tbW9uIGZ1bmN0aW9u
IHRvIGhlbHAgdW5yZWdpc3RlciB0aGUgR0RCIHJlZ2lzdGVyIHNwYWNlLiBUaGlzDQo+ICA+IHNo
YWxsIGJlIGRvbmUgaW4gY29udGV4dCB0byB0aGUgQ1BVIHVucmVhbGl6YXRpb24uDQo+ICA+DQo+
ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiAgPiBUZXN0ZWQtYnk6IFZpc2hudSBQYWpqdXJpIDx2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5n
LmNvbT4NCj4gID4gUmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+
ICA+IFRlc3RlZC1ieTogWGlhbmdsYWkgTGkgPGxpeGlhbmdsYWlAbG9vbmdzb24uY24+DQo+ICA+
IFRlc3RlZC1ieTogTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+ICA+IFJl
dmlld2VkLWJ5OiBTaGFvcWluIEh1YW5nIDxzaGFodWFuZ0ByZWRoYXQuY29tPg0KPiAgPiBSZXZp
ZXdlZC1ieTogVmlzaG51IFBhamp1cmkgPHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0K
PiAgPiAtLS0NCj4gID4gIGdkYnN0dWIvZ2Ric3R1Yi5jICAgICAgfCAxMyArKysrKysrKysrKysr
DQo+ICA+ICBody9jb3JlL2NwdS1jb21tb24uYyAgIHwgIDEgLQ0KPiAgPiAgaW5jbHVkZS9leGVj
L2dkYnN0dWIuaCB8ICA2ICsrKysrKw0KPiAgPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICA+DQo+ICA+IGRpZmYgLS1naXQgYS9nZGJzdHViL2dk
YnN0dWIuYyBiL2dkYnN0dWIvZ2Ric3R1Yi5jIGluZGV4DQo+ICA+IGIzNTc0OTk3ZWEuLjE5NDli
MDkyNDAgMTAwNjQ0DQo+ICA+IC0tLSBhL2dkYnN0dWIvZ2Ric3R1Yi5jDQo+ICA+ICsrKyBiL2dk
YnN0dWIvZ2Ric3R1Yi5jDQo+ICA+IEBAIC02MTcsNiArNjE3LDE5IEBAIHZvaWQgZ2RiX3JlZ2lz
dGVyX2NvcHJvY2Vzc29yKENQVVN0YXRlICpjcHUsDQo+ICA+ICAgICAgfQ0KPiAgPiAgfQ0KPiAg
Pg0KPiAgPiArdm9pZCBnZGJfdW5yZWdpc3Rlcl9jb3Byb2Nlc3Nvcl9hbGwoQ1BVU3RhdGUgKmNw
dSkgew0KPiAgPiArICAgIC8qDQo+ICA+ICsgICAgICogU2FmZSB0byBudWtlIGV2ZXJ5dGhpbmcu
IEdEQlJlZ2lzdGVyU3RhdGU6OnhtbCBpcyBzdGF0aWMgY29uc3QgY2hhcg0KPiAgc28NCj4gID4g
KyAgICAgKiBpdCB3b24ndCBiZSBmcmVlZA0KPiAgPiArICAgICAqLw0KPiAgPiArICAgIGdfYXJy
YXlfZnJlZShjcHUtPmdkYl9yZWdzLCB0cnVlKTsNCj4gID4gKw0KPiAgPiArICAgIGNwdS0+Z2Ri
X3JlZ3MgPSBOVUxMOw0KPiAgPiArICAgIGNwdS0+Z2RiX251bV9yZWdzID0gMDsNCj4gID4gKyAg
ICBjcHUtPmdkYl9udW1fZ19yZWdzID0gMDsNCj4gID4gK30NCj4gID4gKw0KPiAgPiAgc3RhdGlj
IHZvaWQgZ2RiX3Byb2Nlc3NfYnJlYWtwb2ludF9yZW1vdmVfYWxsKEdEQlByb2Nlc3MgKnApICB7
DQo+ICA+ICAgICAgQ1BVU3RhdGUgKmNwdSA9IGdkYl9nZXRfZmlyc3RfY3B1X2luX3Byb2Nlc3Mo
cCk7IGRpZmYgLS1naXQNCj4gID4gYS9ody9jb3JlL2NwdS1jb21tb24uYyBiL2h3L2NvcmUvY3B1
LWNvbW1vbi5jIGluZGV4DQo+ICA+IDBmMGEyNDdmNTYuLmU1MTQwYjRiYzEgMTAwNjQ0DQo+ICA+
IC0tLSBhL2h3L2NvcmUvY3B1LWNvbW1vbi5jDQo+ICA+ICsrKyBiL2h3L2NvcmUvY3B1LWNvbW1v
bi5jDQo+ICA+IEBAIC0yNzQsNyArMjc0LDYgQEAgc3RhdGljIHZvaWQgY3B1X2NvbW1vbl9maW5h
bGl6ZShPYmplY3QgKm9iaikgIHsNCj4gID4gICAgICBDUFVTdGF0ZSAqY3B1ID0gQ1BVKG9iaik7
DQo+ICA+DQo+ICA+IC0gICAgZ19hcnJheV9mcmVlKGNwdS0+Z2RiX3JlZ3MsIFRSVUUpOw0KPiAg
DQo+ICBJcyB0aGlzIHBhdGNoIG1pc3Npbmcgc29tZXRoaW5nPyBBcyBmYXIgYXMgSSBjYW4gdGVs
bCB0aGUgbmV3IGZ1bmN0aW9uIG5ldmVyDQo+ICBnZXRzIGNhbGxlZC4NCg0KDQpBYm92ZSB3YXMg
Y2F1c2luZyBkb3VibGUgZnJlZSBiZWNhdXNlIGV2ZW50dWFsbHkgdGhpcyBmcmVlJ25nIG9mICdn
ZGJfcmVncycgaXMgYmVpbmcNCmRvbmUgaW4gY29udGV4dCB0byB1bi1yZWFsaXphdGlvbiBvZiBB
Uk0gQ1BVLiBGdW5jdGlvbiAnIGdkYl91bnJlZ2lzdGVyX2NvcHJvY2Vzc29yX2FsbCcNCndpbGwg
YmUgdXNlZCBieSBsb29uZ3NvbiBhcmNoIGFzIHdlbGwuIEhlbmNlLCBJIHBsYWNlZCB0aGlzIG5l
d2x5IGFkZGVkIGZ1bmN0aW9uDQppbiB0aGUgYXJjaCBhZ25vc3RpYyBwYXRjaC1zZXQgDQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyMzA5MjYxMDM2NTQuMzQ0MjQtMS1z
YWxpbC5tZWh0YUBodWF3ZWkuY29tLw0KDQpBbm90aGVyIGFwcHJvYWNoIGNvdWxkIGJlIHRvIGtl
ZXAgaXQgYnV0IG1ha2UgYWJvdmUgZnJlZSdpbmcgYXMgY29uZGl0aW9uYWw/DQoNCi8qIGluIGNh
c2UgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNvZGUgZGlkIG5vdCBkbyBpdHMgam9iICovDQppZiAo
Y3B1LT5nZGJfcmVncykNCiAgICBnX2FycmF5X2ZyZWUoY3B1LT5nZGJfcmVncywgVFJVRSk7DQoN
Cg0KQmVzdCByZWdhcmRzDQpTYWxpbC4NCg0KDQo+ICANCj4gID4gICAgICBxZW11X2xvY2tjbnRf
ZGVzdHJveSgmY3B1LT5pbl9pb2N0bF9sb2NrKTsNCj4gID4gICAgICBxZW11X211dGV4X2Rlc3Ry
b3koJmNwdS0+d29ya19tdXRleCk7DQo+ICA+ICB9DQo+ICA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2V4ZWMvZ2Ric3R1Yi5oIGIvaW5jbHVkZS9leGVjL2dkYnN0dWIuaCBpbmRleA0KPiAgPiBlYjE0
YjkxMTM5Li4yNDlkNGQ0YmM4IDEwMDY0NA0KPiAgPiAtLS0gYS9pbmNsdWRlL2V4ZWMvZ2Ric3R1
Yi5oDQo+ICA+ICsrKyBiL2luY2x1ZGUvZXhlYy9nZGJzdHViLmgNCj4gID4gQEAgLTQ5LDYgKzQ5
LDEyIEBAIHZvaWQgZ2RiX3JlZ2lzdGVyX2NvcHJvY2Vzc29yKENQVVN0YXRlICpjcHUsDQo+ICA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZGJfZ2V0X3JlZ19jYiBnZXRfcmVnLCBn
ZGJfc2V0X3JlZ19jYiBzZXRfcmVnLA0KPiAgPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3QgR0RCRmVhdHVyZSAqZmVhdHVyZSwgaW50IGdfcG9zKTsNCj4gID4NCj4gID4gKy8q
Kg0KPiAgPiArICogZ2RiX3VucmVnaXN0ZXJfY29wcm9jZXNzb3JfYWxsKCkgLSB1bnJlZ2lzdGVy
cyBzdXBwbGVtZW50YWwgc2V0IG9mDQo+ICA+ICtyZWdpc3RlcnMNCj4gID4gKyAqIEBjcHUgLSB0
aGUgQ1BVIGFzc29jaWF0ZWQgd2l0aCByZWdpc3RlcnMgICovIHZvaWQNCj4gID4gK2dkYl91bnJl
Z2lzdGVyX2NvcHJvY2Vzc29yX2FsbChDUFVTdGF0ZSAqY3B1KTsNCj4gID4gKw0KPiAgPiAgLyoq
DQo+ICA+ICAgKiBnZGJzZXJ2ZXJfc3RhcnQ6IHN0YXJ0IHRoZSBnZGIgc2VydmVyDQo+ICA+ICAg
KiBAcG9ydF9vcl9kZXZpY2U6IGNvbm5lY3Rpb24gc3BlYyBmb3IgZ2RiDQo+ICANCj4gIC0tDQo+
ICBBbGV4IEJlbm7DqWUNCj4gIFZpcnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0K

