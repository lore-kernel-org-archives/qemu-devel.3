Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0372E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIpL-0006T7-9R; Wed, 11 Dec 2024 04:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tLIpJ-0006Qn-4s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:16:13 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tLIpG-00016F-9x
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:16:12 -0500
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y7VKG6233zRj3l;
 Wed, 11 Dec 2024 17:14:10 +0800 (CST)
Received: from dggems706-chm.china.huawei.com (unknown [10.3.19.183])
 by mail.maildlp.com (Postfix) with ESMTPS id D876214011D;
 Wed, 11 Dec 2024 17:15:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 17:15:54 +0800
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 11 Dec 2024 10:15:53 +0100
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>
CC: "philmd@linaro.org" <philmd@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH v3] fw_cfg: Don't set callback_opaque NULL in
 fw_cfg_modify_bytes_read()
Thread-Topic: [PATCH v3] fw_cfg: Don't set callback_opaque NULL in
 fw_cfg_modify_bytes_read()
Thread-Index: AQHbRYYskB/W/HLdXUmBWggln5lL2LLgvrxQ
Date: Wed, 11 Dec 2024 09:15:53 +0000
Message-ID: <d7800cd30fbe4d23ab019f4d35792469@huawei.com>
References: <20241203131806.37548-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20241203131806.37548-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=szxga03-in.huawei.com
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksDQoNCkEgZ2VudGxlIHBpbmcgb24gdGhpcy4NCg0KSG9wZSB0aGUgZml4IGhlcmUgaXMgc3Rp
bGwgdmFsaWQgYW5kIGNhbiBiZSBwaWNrZWQgdXAuIA0KTm90IHN1cmUgYnkgd2hvbSB0aGlzIHdp
bGwgZ2V0IHBpY2tlZCB1cCB0aG91Z2guDQoNCkBHZXJkPw0KDQpUaGFua3MsDQpTaGFtZWVyDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlciBLb2xvdGh1bSA8
c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAzLCAyMDI0IDE6MTggUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBD
YzogcGhpbG1kQGxpbmFyby5vcmc7IGtyYXhlbEByZWRoYXQuY29tOyBpbWFtbWVkb0ByZWRoYXQu
Y29tOw0KPiB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsgbGludXhhcm1AaHVhd2VpLmNvbQ0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjNdIGZ3X2NmZzogRG9uJ3Qgc2V0IGNhbGxiYWNrX29wYXF1ZSBOVUxM
IGluDQo+IGZ3X2NmZ19tb2RpZnlfYnl0ZXNfcmVhZCgpDQo+IA0KPiBPbiBhcm0vdmlydCBwbGF0
Zm9ybSwgQ2hlbiBYaWFuZyByZXBvcnRlZCBhIEd1ZXN0IGNyYXNoIHdoaWxlDQo+IGF0dGVtcHRp
bmcgdGhlIGJlbG93IHN0ZXBzLA0KPiANCj4gMS4gTGF1bmNoIHRoZSBHdWVzdCB3aXRoIG52ZGlt
bT1vbg0KPiAyLiBIb3QtYWRkIGEgTlZESU1NIGRldg0KPiAzLiBSZWJvb3QNCj4gNC4gR3Vlc3Qg
Ym9vdHMgZmluZS4NCj4gNS4gUmVib290IGFnYWluLg0KPiA2LiBHdWVzdCBib290IGZhaWxzLg0K
PiANCj4gUUVNVV9FRkkgcmVwb3J0cyB0aGUgYmVsb3cgZXJyb3I6DQo+IFByb2Nlc3NDbWRBZGRQ
b2ludGVyOiBpbnZhbGlkIHBvaW50ZXIgdmFsdWUgaW4gImV0Yy9hY3BpL3RhYmxlcyINCj4gT25S
b290QnJpZGdlc0Nvbm5lY3RlZDogSW5zdGFsbEFjcGlUYWJsZXM6IFByb3RvY29sIEVycm9yDQo+
IA0KPiBEZWJ1Z2dpbmcgc2hvd3MgdGhhdCBvbiBmaXJzdCByZWJvb3QoYWZ0ZXIgaG90IGFkZGlu
ZyBOVkRJTU0pLA0KPiBRZW11IHVwZGF0ZXMgdGhlIGV0Yy90YWJsZS1sb2FkZXIgbGVuLA0KPiAN
Cj4gcWVtdV9yYW1fcmVzaXplKCkNCj4gwqAgZndfY2ZnX21vZGlmeV9maWxlKCkNCj4gwqAgwqAg
wqBmd19jZmdfbW9kaWZ5X2J5dGVzX3JlYWQoKQ0KPiANCj4gQW5kIGluIGZ3X2NmZ19tb2RpZnlf
Ynl0ZXNfcmVhZCgpIHdlIHNldCB0aGUgImNhbGxiYWNrX29wYXF1ZSIgZm9yDQo+IHRoZSBrZXkg
ZW50cnkgdG8gTlVMTC4gQmVjYXVzZcKgb2YgdGhpcywgb24gdGhlIHNlY29uZCByZWJvb3QsDQo+
IHZpcnRfYWNwaV9idWlsZF91cGRhdGUoKSBpcyBjYWxsZWQgd2l0aCBhIE5VTEwgImJ1aWxkX3N0
YXRlIiBhbmQNCj4gcmV0dXJucyB3aXRob3V0IHVwZGF0aW5nIHRoZSBBQ1BJIHRhYmxlcy4gVGhp
cyBzZWVtcyB0byBiZQ0KPiB1cHNldHRpbmcgdGhlIGZpcm13YXJlLg0KPiANCj4gVG8gZml4IHRo
aXMsIGRvbid0IGNoYW5nZSB0aGUgY2FsbGJhY2tfb3BhcXVlIGluDQo+IGZ3X2NmZ19tb2RpZnlf
Ynl0ZXNfcmVhZCgpLg0KPiANCj4gRml4ZXM6IGJkYmI1YjE3MDZkMTY1ICgiZndfY2ZnOiBhZGQg
ZndfY2ZnX21hY2hpbmVfcmVzZXQgZnVuY3Rpb24iKQ0KPiBSZXBvcnRlZC1ieTogY2hlbnhpYW5n
IDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPg0KPiBBY2tlZC1ieTogSWdvciBNYW1tZWRvdiA8
aW1hbW1lZG9AcmVkaGF0LmNvbT4NCj4gQWNrZWQtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEBy
ZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiBIaSwNCj4gDQo+IEkgZm9y
Z290IHRvIGZvbGxvdy11cCBvbiB0aGUgdjIgYW5kIGl0IG5ldmVyIGdvdCBwaWNrZWQgdXAuDQo+
IFRoYW5rcyB0byBXYW5nemhvdSB3aG8gcmVjZW50bHkgcmUtcnVuIHRoZSB0ZXN0cyBhbmQgZm91
bmQgdGhhdA0KPiB0aGUgcHJvYmxlbSBtZW50aW9uZWQgYWJvdmUgc3RpbGwgZXhpc3RzLiBIZW5j
ZSByZXNlbmRpbmcgdGhlIHYyLg0KPiANCj4gdjItLT52MzoNCj4gIC1KdXN0IHJlYmFzZS4NCj4g
DQo+IHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjIwOTA4MTYwMzU0
LjIwMjMtMS0NCj4gc2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tLw0KPiB2MTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwODI1MTYxODQyLjg0MS0xLQ0KPiBzaGFt
ZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20vDQo+IA0KPiBUaGFua3MsDQo+IFNoYW1l
ZXINCj4gLS0tDQo+ICBody9udnJhbS9md19jZmcuYyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9udnJhbS9md19jZmcuYyBiL2h3
L252cmFtL2Z3X2NmZy5jDQo+IGluZGV4IGI2NDQ1Nzc3MzQuLjc0ZWRiMWU0Y2YgMTAwNjQ0DQo+
IC0tLSBhL2h3L252cmFtL2Z3X2NmZy5jDQo+ICsrKyBiL2h3L252cmFtL2Z3X2NmZy5jDQo+IEBA
IC03MzAsNyArNzMwLDYgQEAgc3RhdGljIHZvaWQgKmZ3X2NmZ19tb2RpZnlfYnl0ZXNfcmVhZChG
V0NmZ1N0YXRlDQo+ICpzLCB1aW50MTZfdCBrZXksDQo+ICAgICAgcHRyID0gcy0+ZW50cmllc1th
cmNoXVtrZXldLmRhdGE7DQo+ICAgICAgcy0+ZW50cmllc1thcmNoXVtrZXldLmRhdGEgPSBkYXRh
Ow0KPiAgICAgIHMtPmVudHJpZXNbYXJjaF1ba2V5XS5sZW4gPSBsZW47DQo+IC0gICAgcy0+ZW50
cmllc1thcmNoXVtrZXldLmNhbGxiYWNrX29wYXF1ZSA9IE5VTEw7DQo+ICAgICAgcy0+ZW50cmll
c1thcmNoXVtrZXldLmFsbG93X3dyaXRlID0gZmFsc2U7DQo+IA0KPiAgICAgIHJldHVybiBwdHI7
DQo+IC0tDQo+IDIuMzQuMQ0KDQo=

