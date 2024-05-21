Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12712C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 18:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9UWC-0004VL-LW; Tue, 21 May 2024 14:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s9UWA-0004SH-57; Tue, 21 May 2024 14:47:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s9UW6-0007iW-Ik; Tue, 21 May 2024 14:47:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VkNgf31lKz6J86J;
 Wed, 22 May 2024 02:46:22 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 398991400CA;
 Wed, 22 May 2024 02:47:11 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 19:47:10 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 21 May 2024 19:47:10 +0100
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
Thread-Index: AQHaqw58iWfFbXDiBUGABVy+QLlh5LGho0hdgAAHJ3CAACT3rYAANI5Q
Date: Tue, 21 May 2024 18:47:10 +0000
Message-ID: <7a13518a07dd4385846419982bd5b56d@huawei.com>
References: <20240520233241.229675-1-salil.mehta@huawei.com>
 <20240520233241.229675-8-salil.mehta@huawei.com>
 <87seybibax.fsf@draig.linaro.org>
 <00d3d97d51df449a88b771174b37f979@huawei.com>
 <87frubi402.fsf@draig.linaro.org>
In-Reply-To: <87frubi402.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.123]
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

PiAgRnJvbTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAgU2VudDog
VHVlc2RheSwgTWF5IDIxLCAyMDI0IDQ6MjMgUE0NCj4gIFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwu
bWVodGFAaHVhd2VpLmNvbT4NCj4gIA0KPiAgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdl
aS5jb20+IHdyaXRlczoNCj4gIA0KPiAgPiBIaSBBbGV4LA0KPiAgPg0KPiAgPj4gIEZyb206IEFs
ZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gID4+ICBTZW50OiBUdWVzZGF5
LCBNYXkgMjEsIDIwMjQgMTo0NSBQTQ0KPiAgPj4gIFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVo
dGFAaHVhd2VpLmNvbT4NCj4gID4+DQo+ICA+PiAgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1
YXdlaS5jb20+IHdyaXRlczoNCj4gID4+DQo+ICA+PiAgPiBBZGQgY29tbW9uIGZ1bmN0aW9uIHRv
IGhlbHAgdW5yZWdpc3RlciB0aGUgR0RCIHJlZ2lzdGVyIHNwYWNlLg0KPiAgPj4gVGhpcyAgPiBz
aGFsbCBiZSBkb25lIGluIGNvbnRleHQgdG8gdGhlIENQVSB1bnJlYWxpemF0aW9uLg0KPiAgPj4g
ID4NCj4gID4+ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3
ZWkuY29tPiAgPiBUZXN0ZWQtYnk6DQo+ICA+PiBWaXNobnUgUGFqanVyaSA8dmlzaG51QG9zLmFt
cGVyZWNvbXB1dGluZy5jb20+ICA+IFJldmlld2VkLWJ5OiAgR2F2aW4NCj4gID4+IFNoYW4gPGdz
aGFuQHJlZGhhdC5jb20+ICA+IFRlc3RlZC1ieTogWGlhbmdsYWkgTGkNCj4gID4+IDxsaXhpYW5n
bGFpQGxvb25nc29uLmNuPiAgPiBUZXN0ZWQtYnk6IE1pZ3VlbCBMdWlzDQo+ICA+PiA8bWlndWVs
Lmx1aXNAb3JhY2xlLmNvbT4gID4gUmV2aWV3ZWQtYnk6IFNoYW9xaW4gSHVhbmcNCj4gID4+IDxz
aGFodWFuZ0ByZWRoYXQuY29tPiAgPiBSZXZpZXdlZC1ieTogVmlzaG51IFBhamp1cmkNCj4gID4+
IDx2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4gID4gLS0tDQo+ICA+PiAgPiAgZ2Ric3R1
Yi9nZGJzdHViLmMgICAgICB8IDEzICsrKysrKysrKysrKysNCj4gID4+ICA+ICBody9jb3JlL2Nw
dS1jb21tb24uYyAgIHwgIDEgLQ0KPiAgPj4gID4gIGluY2x1ZGUvZXhlYy9nZGJzdHViLmggfCAg
NiArKysrKysgID4gIDMgZmlsZXMgY2hhbmdlZCwgMTkNCj4gID4+IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkgID4gID4gZGlmZiAtLWdpdCBhL2dkYnN0dWIvZ2Ric3R1Yi5jDQo+ICA+PiBi
L2dkYnN0dWIvZ2Ric3R1Yi5jIGluZGV4ICA+IGIzNTc0OTk3ZWEuLjE5NDliMDkyNDAgMTAwNjQ0
ICA+IC0tLQ0KPiAgPj4gYS9nZGJzdHViL2dkYnN0dWIuYyAgPiArKysgYi9nZGJzdHViL2dkYnN0
dWIuYyAgPiBAQCAtNjE3LDYgKzYxNywxOQ0KPiAgPj4gQEAgdm9pZCBnZGJfcmVnaXN0ZXJfY29w
cm9jZXNzb3IoQ1BVU3RhdGUgKmNwdSwNCj4gID4+ICA+ICAgICAgfQ0KPiAgPj4gID4gIH0NCj4g
ID4+ICA+DQo+ICA+PiAgPiArdm9pZCBnZGJfdW5yZWdpc3Rlcl9jb3Byb2Nlc3Nvcl9hbGwoQ1BV
U3RhdGUgKmNwdSkgew0KPiAgPj4gID4gKyAgICAvKg0KPiAgPj4gID4gKyAgICAgKiBTYWZlIHRv
IG51a2UgZXZlcnl0aGluZy4gR0RCUmVnaXN0ZXJTdGF0ZTo6eG1sIGlzIHN0YXRpYyBjb25zdCBj
aGFyDQo+ICA+PiAgc28NCj4gID4+ICA+ICsgICAgICogaXQgd29uJ3QgYmUgZnJlZWQNCj4gID4+
ICA+ICsgICAgICovDQo+ICA+PiAgPiArICAgIGdfYXJyYXlfZnJlZShjcHUtPmdkYl9yZWdzLCB0
cnVlKTsNCj4gID4+ICA+ICsNCj4gID4+ICA+ICsgICAgY3B1LT5nZGJfcmVncyA9IE5VTEw7DQo+
ICA+PiAgPiArICAgIGNwdS0+Z2RiX251bV9yZWdzID0gMDsNCj4gID4+ICA+ICsgICAgY3B1LT5n
ZGJfbnVtX2dfcmVncyA9IDA7DQo+ICA+PiAgPiArfQ0KPiAgPj4gID4gKw0KPiAgPj4gID4gIHN0
YXRpYyB2b2lkIGdkYl9wcm9jZXNzX2JyZWFrcG9pbnRfcmVtb3ZlX2FsbChHREJQcm9jZXNzICpw
KSAgew0KPiAgPj4gID4gICAgICBDUFVTdGF0ZSAqY3B1ID0gZ2RiX2dldF9maXJzdF9jcHVfaW5f
cHJvY2VzcyhwKTsgZGlmZiAtLWdpdA0KPiAgPj4gID4gYS9ody9jb3JlL2NwdS1jb21tb24uYyBi
L2h3L2NvcmUvY3B1LWNvbW1vbi5jIGluZGV4ICA+DQo+ICA+PiAwZjBhMjQ3ZjU2Li5lNTE0MGI0
YmMxIDEwMDY0NCAgPiAtLS0gYS9ody9jb3JlL2NwdS1jb21tb24uYyAgPiArKysNCj4gID4+IGIv
aHcvY29yZS9jcHUtY29tbW9uLmMgID4gQEAgLTI3NCw3ICsyNzQsNiBAQCBzdGF0aWMgdm9pZA0K
PiAgPj4gY3B1X2NvbW1vbl9maW5hbGl6ZShPYmplY3QgKm9iaikgIHsNCj4gID4+ICA+ICAgICAg
Q1BVU3RhdGUgKmNwdSA9IENQVShvYmopOw0KPiAgPj4gID4NCj4gID4+ICA+IC0gICAgZ19hcnJh
eV9mcmVlKGNwdS0+Z2RiX3JlZ3MsIFRSVUUpOw0KPiAgPj4NCj4gID4+ICBJcyB0aGlzIHBhdGNo
IG1pc3Npbmcgc29tZXRoaW5nPyBBcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGUgbmV3DQo+ICA+PiBm
dW5jdGlvbiBuZXZlciAgZ2V0cyBjYWxsZWQuDQo+ICA+DQo+ICA+DQo+ICA+IEFib3ZlIHdhcyBj
YXVzaW5nIGRvdWJsZSBmcmVlIGJlY2F1c2UgZXZlbnR1YWxseSB0aGlzIGZyZWUnbmcgb2YNCj4g
ID4gJ2dkYl9yZWdzJyBpcyBiZWluZyBkb25lIGluIGNvbnRleHQgdG8gdW4tcmVhbGl6YXRpb24g
b2YgQVJNIENQVS4gRnVuY3Rpb24NCj4gICcgZ2RiX3VucmVnaXN0ZXJfY29wcm9jZXNzb3JfYWxs
Jw0KPiAgPiB3aWxsIGJlIHVzZWQgYnkgbG9vbmdzb24gYXJjaCBhcyB3ZWxsLiBIZW5jZSwgSSBw
bGFjZWQgdGhpcyBuZXdseQ0KPiAgPiBhZGRlZCBmdW5jdGlvbiBpbiB0aGUgYXJjaCBhZ25vc3Rp
YyBwYXRjaC1zZXQNCj4gID4NCj4gID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDIzMDkyNjEwMzY1NC4zNDQyNC0xLQ0KPiAgc2FsaWwubWVodGFADQo+ICA+IGh1YXdlaS5j
b20vDQo+ICA+DQo+ICA+IEFub3RoZXIgYXBwcm9hY2ggY291bGQgYmUgdG8ga2VlcCBpdCBidXQg
bWFrZSBhYm92ZSBmcmVlJ2luZyBhcw0KPiAgY29uZGl0aW9uYWw/DQo+ICA+DQo+ICA+IC8qIGlu
IGNhc2UgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNvZGUgZGlkIG5vdCBkbyBpdHMgam9iICovIGlm
DQo+ICA+IChjcHUtPmdkYl9yZWdzKQ0KPiAgPiAgICAgZ19hcnJheV9mcmVlKGNwdS0+Z2RiX3Jl
Z3MsIFRSVUUpOw0KPiAgDQo+ICBObyBJIGRvbid0IG9iamVjdCB0byBtb3ZpbmcgaXQgdG8gYSBm
dW5jdGlvbi4gQnV0IEkgd291bGQgZXhwZWN0IHRoZSBwYXRjaA0KPiAgdGhhdCBhZGRzIHRoZSBm
dW5jdGlvbiBhbmQgcGx1bWJzIGl0IGluIHRvIGFsc28gYmUgdGhlIHBhdGNoIHRoYXQgcmVtb3Zl
cw0KPiAgdGhlIGlubGluZSBjYWxsLiBPdGhlcndpc2UgdGhlIHRyZWUgd2lsbCBiZSBicm9rZW4g
aW4gYmVoYXZpb3VyIGJldHdlZW4NCj4gIHBhdGNoZXMuDQo+ICANCg0KT2suDQoNCj4gIEp1c3Qg
bWFrZSBpdCBjbGVhciBpbiB0aGUgaGVhZGVyIHRoYXQgdGhlIHNlcmllcyBuZWVkcyB0aGUgcHJl
LXJlcXVpc2l0ZQ0KPiAgcGF0Y2hlcy4NCg0KU3VyZSwgSSB3aWxsIGFsc28gYWRkIGl0IGluIHRo
ZSBoZWFkZXIgb2YgdGhpcyBwYXRjaC4gVGhvdWdoLCBJIGRpZCBtZW50aW9uDQphYm91dCBzdWNo
IGRlcGVuZGVuY3kgaW4gdGhlIGNvdmVyIGxldHRlciBmb3IgdGhpcyBlbnRpcmUgc2VyaWVzLg0K
DQoNClBhc3RpbmcgZnJvbSB0aGUgY292ZXItbGV0dGVyOg0KDQpbKl0gaHR0cHM6Ly9naXRodWIu
Y29tL3NhbGlsLW1laHRhL3FlbXUuZ2l0IHZpcnQtY3B1aHAtYXJtdjgvcmZjLXYzLmFyY2guYWdu
b3N0aWMudjEwDQoNCk5PVEU6IEZvciBBUk0sIGFib3ZlIHdpbGwgd29yayBpbiBjb21iaW5hdGlv
biBvZiB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBhcnQgYmFzZWQgb24NClJGQyBWMiBbMV0u
IFRoaXMgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBhdGNoLXNldCBSRkMgVjMgc2hhbGwgYmUgZmxv
YXRlZCBzb29uIGFuZCBpcyBwcmVzZW50DQphdCBiZWxvdyBsb2NhdGlvbg0KDQpbKl0gaHR0cHM6
Ly9naXRodWIuY29tL3NhbGlsLW1laHRhL3FlbXUvdHJlZS92aXJ0LWNwdWhwLWFybXY4L3JmYy12
My1yYzENCg0KDQpUaGFua3MNClNhbGlsLg0KDQo+ICANCj4gIC0tDQo+ICBBbGV4IEJlbm7DqWUN
Cj4gIFZpcnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0K

