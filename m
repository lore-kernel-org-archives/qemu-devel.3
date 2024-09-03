Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F09CD3437
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slU5c-0000eV-Bh; Tue, 03 Sep 2024 10:01:01 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <changbin.du@huawei.com>)
 id 1slU5G-0000Ua-Pq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:00:42 -0400
Received: from [45.249.212.191] (helo=szxga05-in.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <changbin.du@huawei.com>)
 id 1slU4P-0006iU-A6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:00:21 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wymq44wrzz1HJCP;
 Tue,  3 Sep 2024 21:36:00 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
 by mail.maildlp.com (Postfix) with ESMTPS id 321F51400D7;
 Tue,  3 Sep 2024 21:39:27 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 3 Sep 2024 21:39:26 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034; 
 Tue, 3 Sep 2024 21:39:26 +0800
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: duchangbin <changbin.du@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] hw/arm/boot: Report error msg if loading elf/dtb failed
Thread-Topic: [PATCH v2] hw/arm/boot: Report error msg if loading elf/dtb
 failed
Thread-Index: AQHa+srYcUaTo3na7EqowavTo5/fzrJEaGGAgAGu7IA=
Date: Tue, 3 Sep 2024 13:39:26 +0000
Message-ID: <263aa8df87ff461d96fdc55763aeac79@huawei.com>
References: <20240830105304.2547406-1-changbin.du@huawei.com>
 <7c67704e-a067-4b6e-8acb-51b33cf17ee0@linaro.org>
In-Reply-To: <7c67704e-a067-4b6e-8acb-51b33cf17ee0@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.110.54.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <86EEC0691B7FFA40A984F4780746E21C@huawei.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 45.249.212.191 (deferred)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=changbin.du@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  duchangbin <changbin.du@huawei.com>
From:  duchangbin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gTW9uLCBTZXAgMDIsIDIwMjQgYXQgMDk6NTU6MTlQTSArMDIwMCwgUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgd3JvdGU6DQo+IEhpIENoYW5nYmluLA0KPiANCj4gT24gMzAvOC8yNCAxMjo1Mywg
Q2hhbmdiaW4gRHUgdmlhIHdyb3RlOg0KPiA+IFByaW50IGVycm9ycyBiZWZvcmUgZXhpdC4gRG8g
bm90IGV4aXQgc2lsZW50bHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbmdiaW4gRHUg
PGNoYW5nYmluLmR1QGh1YXdlaS5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gdjI6IHJlbW92ZSBt
c2cgZm9yIGFybV9sb2FkX2R0Yi4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9ib290LmMgfCAxICsN
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9ody9hcm0vYm9vdC5jIGIvaHcvYXJtL2Jvb3QuYw0KPiA+IGluZGV4IGQ0ODBhN2RhMDJj
Zi4uZTE1YmYwOTdhNTU5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9ib290LmMNCj4gPiArKysg
Yi9ody9hcm0vYm9vdC5jDQo+ID4gQEAgLTgzOSw2ICs4MzksNyBAQCBzdGF0aWMgc3NpemVfdCBh
cm1fbG9hZF9lbGYoc3RydWN0IGFybV9ib290X2luZm8gKmluZm8sIHVpbnQ2NF90ICpwZW50cnks
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgMSwgZGF0YV9zd2FiLCBhcyk7DQo+ID4gICAg
ICAgaWYgKHJldCA8PSAwKSB7DQo+ID4gICAgICAgICAgIC8qIFRoZSBoZWFkZXIgbG9hZGVkIGJ1
dCB0aGUgaW1hZ2UgZGlkbid0ICovDQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJjb3VsZCBu
b3QgbG9hZCBlbGYgJyVzJyIsIGluZm8tPmtlcm5lbF9maWxlbmFtZSk7DQo+IA0KPiAiQ291bGQg
Li4uIiAoY2FwcykNCj4gDQo+ICJody9sb2FkZXIuaCIgaXMgbm90IHdlbGwgZG9jdW1lbnRlZCwg
YnV0IGl0IHNlZW1zIGxvYWRfZWxmKigpIHJldHVybnM6DQo+IA0KPiAgICNkZWZpbmUgRUxGX0xP
QURfRkFJTEVEICAgICAgIC0xDQo+ICAgI2RlZmluZSBFTEZfTE9BRF9OT1RfRUxGICAgICAgLTIN
Cj4gICAjZGVmaW5lIEVMRl9MT0FEX1dST05HX0FSQ0ggICAtMw0KPiAgICNkZWZpbmUgRUxGX0xP
QURfV1JPTkdfRU5ESUFOIC00DQo+ICAgI2RlZmluZSBFTEZfTE9BRF9UT09fQklHICAgICAgLTUN
Cj4gDQo+IEFuZCB3ZSBjYW4gZGlzcGxheSB0aGlzIGVycm9yIGNhbGxpbmc6DQo+IA0KPiAgIGNv
bnN0IGNoYXIgKmxvYWRfZWxmX3N0cmVycm9yKHNzaXplX3QgZXJyb3IpOw0KPiANCj4gU28gd2Ug
Y2FuIGJlIG1vcmUgcHJlY2lzZSBoZXJlIHVzaW5nOg0KPiANCj4gICBlcnJvcl9yZXBvcnQoIkNv
dWxkIG5vdCBsb2FkIGVsZiAnJXMnIiwgaW5mby0+a2VybmVsX2ZpbGVuYW1lLA0KPiAgICAgICAg
ICAgICAgICBsb2FkX2VsZl9zdHJlcnJvcihyZXQpKTsNCj4gDQo+ID4gICAgICAgICAgIGV4aXQo
MSk7DQo+ID4gICAgICAgfQ0KPiANCj4gQmV0dGVyIChidXQgb3V0IG9mIHNjb3BlIG9mIHRoaXMg
cGF0Y2gpIGNvdWxkIGJlIHRvIHBhc3MgYW4gRXJyb3IgKmVycnANCj4gYXJndW1lbnQgdG8gdGhl
IGxvYWRfZWxmKigpIGZhbWlseSBvZiBmdW5jdGlvbnMsIGFuZCBmaWxsIGl0IHdpdGggdGhlDQo+
IGFwcHJvcHJpYXRlIGVycm9yIG1lc3NhZ2UuDQo+DQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlv
bi4gSSBjaGFuZ2VkIGl0IGFzIGJlbG93Og0KKyAgICAgICAgZXJyb3JfcmVwb3J0KCJDb3VsZG4n
dCBsb2FkIGVsZiAnJXMnOiAlcyIsDQorICAgICAgICAgICAgICAgICAgICAgaW5mby0+a2VybmVs
X2ZpbGVuYW1lLCBsb2FkX2VsZl9zdHJlcnJvcihyZXQpKTsNCg0KJCBxZW11LXN5c3RlbS1hYXJj
aDY0IC1NIHZpcnQgLWtlcm5lbCAvd29yay9saW51eC92bWxpbnV4DQpxZW11LXN5c3RlbS1hYXJj
aDY0OiBDb3VsZG4ndCBsb2FkIGVsZiAnL3dvcmsvbGludXgvdm1saW51eCc6IFRoZSBpbWFnZSBp
cyBmcm9tIGluY29tcGF0aWJsZSBhcmNoaXRlY3R1cmUNCg0KPiBSZWdhcmRzLA0KPiANCj4gUGhp
bC4NCg0KLS0gDQpDaGVlcnMsDQpDaGFuZ2JpbiBEdQ0K

