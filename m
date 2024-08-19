Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D93C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 13:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg264-0007td-Fy; Mon, 19 Aug 2024 09:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg260-0007pz-2I; Mon, 19 Aug 2024 09:06:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg25x-0006dU-4W; Mon, 19 Aug 2024 09:06:51 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnXpq3CSsz6K5lc;
 Mon, 19 Aug 2024 21:03:47 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 960D31400DB;
 Mon, 19 Aug 2024 21:06:40 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 14:06:40 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 19 Aug 2024 14:06:40 +0100
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
Subject: RE: [PATCH RFC V3 06/29] arm/virt,kvm: Pre-create disabled possible
 vCPUs @machine init
Thread-Topic: [PATCH RFC V3 06/29] arm/virt, kvm: Pre-create disabled possible
 vCPUs @machine init
Thread-Index: AQHavesHnOf3VuoG/EWl7BGab5TyaLIuZYWAgACOOvA=
Date: Mon, 19 Aug 2024 13:06:39 +0000
Message-ID: <1bbe0c9dd0404013aa6a05a1ca5cd59a@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-7-salil.mehta@huawei.com>
 <28f3107f-0267-4112-b0ca-da59df2968ae@redhat.com>
In-Reply-To: <28f3107f-0267-4112-b0ca-da59df2968ae@redhat.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
ZW50OiBNb25kYXksIEF1Z3VzdCAxOSwgMjAyNCA2OjMyIEFNDQo+ICBUbzogU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ICBxZW11
LWFybUBub25nbnUub3JnOyBtc3RAcmVkaGF0LmNvbQ0KPiAgDQo+ICBPbiA2LzE0LzI0IDk6MzYg
QU0sIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiBJbiB0aGUgQVJNdjggYXJjaGl0ZWN0dXJlLCB0
aGUgR0lDIG11c3Qga25vdyBhbGwgdGhlIENQVXMgaXQgaXMNCj4gID4gY29ubmVjdGVkIHRvIGR1
cmluZyBpdHMgaW5pdGlhbGl6YXRpb24sIGFuZCB0aGlzIGNhbm5vdCBjaGFuZ2UNCj4gID4gYWZ0
ZXJ3YXJkLiBUaGlzIG11c3QgYmUgZW5zdXJlZCBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uIG9m
IHRoZSBWR0lDDQo+ICA+IGFzIHdlbGwgaW4gS1ZNLCB3aGljaCByZXF1aXJlcyBhbGwgdkNQVXMg
dG8gYmUgY3JlYXRlZCBhbmQgcHJlc2VudA0KPiAgPiBkdXJpbmcgaXRzIGluaXRpYWxpemF0aW9u
LiBUaGlzIGlzIG5lY2Vzc2FyeQ0KPiAgPiBiZWNhdXNlOg0KPiAgPg0KPiAgPiAxLiBUaGUgYXNz
b2NpYXRpb24gYmV0d2VlbiBHSUNDIGFuZCBNUElEUiBtdXN0IGJlIGZpeGVkIGF0IFZNDQo+ICBp
bml0aWFsaXphdGlvbg0KPiAgPiAgICAgdGltZS4gVGhpcyBpcyByZXByZXNlbnRlZCBieSB0aGUg
cmVnaXN0ZXIgYEdJQ19UWVBFUihtcF9hZmZpbml0eSwNCj4gIHByb2NfbnVtKWAuDQo+ICA+IDIu
IEdJQ0MgKENQVSBpbnRlcmZhY2VzKSwgR0lDUiAocmVkaXN0cmlidXRvcnMpLCBldGMuLCBtdXN0
IGFsbCBiZSBpbml0aWFsaXplZA0KPiAgPiAgICAgYXQgYm9vdCB0aW1lLg0KPiAgPiAzLiBNZW1v
cnkgcmVnaW9ucyBhc3NvY2lhdGVkIHdpdGggR0lDUiwgZXRjLiwgY2Fubm90IGJlIGNoYW5nZWQg
KGFkZGVkLCBkZWxldGVkLA0KPiAgPiAgICAgb3IgbW9kaWZpZWQpIGFmdGVyIHRoZSBWTSBoYXMg
YmVlbiBpbml0aWFsaXplZC4NCj4gID4NCj4gID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgdG8g
cHJlLWNyZWF0ZSBhbGwgcG9zc2libGUgdkNQVXMgd2l0aGluIHRoZQ0KPiAgPiBob3N0IHVzaW5n
IHRoZSBLVk0gaW50ZXJmYWNlIGFzIHBhcnQgb2YgdGhlIHZpcnR1YWwgbWFjaGluZQ0KPiAgPiBp
bml0aWFsaXphdGlvbi4gVGhlc2UgdkNQVXMgY2FuIGxhdGVyIGJlIGF0dGFjaGVkIHRvIFFPTS9B
Q1BJIHdoZW4NCj4gID4gdGhleSBhcmUgYWN0dWFsbHkgaG90LXBsdWdnZWQgYW5kIG1hZGUgcHJl
c2VudC4NCj4gID4NCj4gID4gQ28tZGV2ZWxvcGVkLWJ5OiBLZXFpYW4gWmh1IDx6aHVrZXFpYW4x
QGh1YXdlaS5jb20+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlhbjFA
aHVhd2VpLmNvbT4NCj4gID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRh
QGh1YXdlaS5jb20+DQo+ICA+IFJlcG9ydGVkLWJ5OiBWaXNobnUgUGFqanVyaSA8dmlzaG51QG9z
LmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ICA+IFtWUDogSWRlbnRpZmllZCBDUFUgc3RhbGwgaXNz
dWUgJiBzdWdnZXN0ZWQgcHJvYmFibGUgZml4XQ0KPiAgPiAtLS0NCj4gID4gICBody9hcm0vdmly
dC5jICAgICAgICAgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
DQo+ICAtLS0NCj4gID4gICBpbmNsdWRlL2h3L2NvcmUvY3B1LmggfCAgMSArDQo+ICA+ICAgdGFy
Z2V0L2FybS9jcHU2NC5jICAgIHwgIDEgKw0KPiAgPiAgIHRhcmdldC9hcm0va3ZtLmMgICAgICB8
IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gID4gICB0YXJnZXQvYXJtL2t2
bV9hcm0uaCAgfCAxMSArKysrKysrKysNCj4gID4gICA1IGZpbGVzIGNoYW5nZWQsIDk5IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiAgPg0KPiAgDQo+ICBUaGUgdkNQVSBmaWxlIGRl
c2NyaXB0b3IgaXMgYXNzb2NpYXRlZCB3aXRoIGEgZmVhdHVyZSBiaXRtYXAgd2hlbiB0aGUgZmls
ZQ0KPiAgZGVzY3JpcHRvciBpcyBpbml0aWFsaXplZCBieSBpb2N0bCh2bV9mZCwgS1ZNX0FSTV9W
Q1BVX0lOSVQsICZpbml0KS4gVGhlDQo+ICBmZWF0dXJlIGJpdG1hcCBpcyBzb3J0ZWQgb3V0IGJh
c2VkIG9uIHRoZSB2Q1BVIHByb3BlcnRpZXMuIFRoZSB2Q1BVDQo+ICBwcm9wZXJ0aWVzIGNhbiBi
ZSBkaWZmZXJlbnQgd2hlbiB0aGUgdkNQVSBmaWxlIGRlc2NyaXB0b3IgaXMgaW5pdGlhbGl6ZWQg
Zm9yDQo+ICB0aGUgZmlyc3QgdGltZSB3aGVuIHRoZSB2Q1BVIGlzIGluc3RhbnRpYXRlZCwgYW5k
IHJlLWluaXRpYWxpemVkIHdoZW4gdGhlDQo+ICB2Q1BVIGlzIGhvdCBhZGRlZC4NCg0KICANCj4g
IEl0IGNhbiBsZWFkIHRvIHN5c3RlbSBjcmFzaCBhcyBiZWxvdy4gV2UgcHJvYmFibHkgbmVlZCBh
IG1lY2hhbmlzbSB0bw0KPiAgZGlzYWxsb3cgcGFzc2luZyBleHRyYSBwcm9wZXJ0aWVzIHdoZW4g
dkNQVSBpcyBob3QgYWRkZWQgdG8gYXZvaWQgdGhlDQo+ICBjb25mbGljdHMgdG8gdGhlIGdsb2Jh
bCBwcm9wZXJ0aWVzIGZyb20gdGhlIGNvbW1hbmQgbGluZSAiLWNwdQ0KPiAgaG9zdCxwbXU9b24i
LiBTb21lIG9mIHRoZSBwcm9wZXJ0aWVzIGxpa2UgImlkIiwgInNvY2tldC1pZCINCj4gIGFyZSBz
dGlsbCBuZWVkZWQuDQoNCg0KWWVzLCBHb29kIGNhdGNoLiBJIGtuZXcgdGhhdCBidXQgSXQgYWxt
b3N0IHdlbnQgdW5kZXIgbXkgaG9vZC4gVGhhbmtzIGZvcg0KcG9pbnRpbmcgYW5kIHJlbWluZGlu
ZyBpdC4gV2UgbmVlZCBhIGNoZWNrIHRoZXJlLiBXaWxsIGZpeCBpdC4NCg0KDQo+ICANCj4gIC9o
b21lL2dhdmluL3NhbmRib3gvcWVtdS5tYWluL2J1aWxkL3FlbXUtc3lzdGVtLWFhcmNoNjQgICAg
ICAgICAgICAgICAgICBcDQo+ICAtYWNjZWwga3ZtIC1tYWNoaW5lIHZpcnQsZ2ljLXZlcnNpb249
aG9zdCxudmRpbW09b24gICAgICAgICAgICAgICAgICAgICAgXA0KPiAgLWNwdSBob3N0IC1zbXAg
bWF4Y3B1cz0yLGNwdXM9MSxzb2NrZXRzPTIsY2x1c3RlcnM9MSxjb3Jlcz0xLHRocmVhZHM9MQ0K
PiAgXA0KPiAgLW0gNDA5Nk0sc2xvdHM9MTYsbWF4bWVtPTEyOEcgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFt
LGlkPW1lbTAsc2l6ZT0yMDQ4TSAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAtb2Jq
ZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxpZD1tZW0xLHNpemU9MjA0OE0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPiAgLW51bWEgbm9kZSxub2RlaWQ9MCxtZW1kZXY9bWVtMCxjcHVzPTAt
MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gIC1udW1hIG5vZGUsbm9kZWlk
PTEsbWVtZGV2PW1lbTEsY3B1cz0xLTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ICAtTCAvaG9tZS9nYXZpbi9zYW5kYm94L3FlbXUubWFpbi9idWlsZC9wYy1iaW9zICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KPiAgLW1vbml0b3Igbm9uZSAtc2VyaWFsIG1vbjpzdGRp
byAtbm9ncmFwaGljICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gIC1nZGIgdGNw
Ojo2NjY2IC1xbXAgdGNwOmxvY2FsaG9zdDo1NTU1LHNlcnZlcix3YWl0PW9mZiAgICAgICAgICAg
ICAgICAgICBcDQo+ICAtYmlvcyAvaG9tZS9nYXZpbi9zYW5kYm94L3FlbXUubWFpbi9idWlsZC9w
Yy1iaW9zL2VkazItYWFyY2g2NC0NCj4gIGNvZGUuZmQgICBcDQo+ICAta2VybmVsIC9ob21lL2dh
dmluL3NhbmRib3gvbGludXguZ3Vlc3QvYXJjaC9hcm02NC9ib290L0ltYWdlICAgICAgICAgICAg
XA0KPiAgLWluaXRyZCAvaG9tZS9nYXZpbi9zYW5kYm94L2ltYWdlcy9yb290ZnMuY3Bpby54eiAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gIC1hcHBlbmQgbWVtaHBfZGVmYXVsdF9zdGF0ZT1v
bmxpbmVfbW92YWJsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgIDoN
Cj4gIChxZW11KSBkZXZpY2VfYWRkIGhvc3QtYXJtLWNwdSxpZD1jcHUxLHNvY2tldC1pZD0xLHBt
dT1vZmYNCj4gIGt2bV9hcmNoX2luaXRfdmNwdTogRXJyb3IgLTIyIGZyb20ga3ZtX2FybV92Y3B1
X2luaXQoKQ0KPiAgcWVtdS1zeXN0ZW0tYWFyY2g2NDoga3ZtX2luaXRfdmNwdToga3ZtX2FyY2hf
aW5pdF92Y3B1IGZhaWxlZCAoMSk6DQo+ICBJbnZhbGlkIGFyZ3VtZW50DQoNClllcy4gdGhhbmtz
Lg0KDQo+ICANCj4gIFRoYW5rcywNCj4gIEdhdmluDQo+ICANCg0K

