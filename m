Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2FBC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZVr-0006GE-3F; Tue, 02 Jul 2024 05:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sOZVp-0006G5-IN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:09:21 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sOZVm-0002mZ-Hc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:09:21 -0400
To: Igor Mammedov <imammedo@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Topic: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Index: AQHazF97s5L1XqY6Y0meoofaV9dT3A==
Date: Tue, 2 Jul 2024 09:09:03 +0000
Message-ID: <ed18dd457d584a059aa0d94285046c2b@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
 <6d033738d79d4b9a83fe216679f8e587@baidu.com>
 <20240701104000.52df4854@imammedo.users.ipa.redhat.com>
 <02403c2f69574128a1700d8b3db37381@baidu.com>
 <b7fmdp5joww5plrwr3hfedv4zfoicxrzbtynaoui452y4zrtq2@hi236cyermam>
 <bdf1a67fa18249cb9947adba8732323f@baidu.com>,
 <20240702102642.22f89d81@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240702102642.22f89d81@imammedo.users.ipa.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.138]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.52
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiA+ID4gPiA+ID4gSWYgSSB3YW50IHRvIHVzZSBBQ1BJIFBDSSBob3RwbHVnIGluIHRoZSBweGIg
YnJpZGdlLCB3aGF0IGVsc2UgbmVlZCB0byBiZSBkb25lPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
ZG9lcyBpdCBoYXZlIHRvIGJlIGhvdHBsdWcgZGlyZWN0bHkgaW50byBweGIgb3INCj4gPiA+ID4g
PiB3b3VsZCBiZSBpdCBiZSBzdWZmaWNpZW50IHRvIGhhdmUgaG90cGx1ZyBzdXBwb3J0DQo+ID4g
PiA+ID4gb24gcGNpLWJyaWRnZSBhdHRhY2hlZCB0byBhIHB4Yj8NCj4gPiA+ID4NCj4gPiA+ID4g
SXQncyBzdWZmaWNpZW50IHRvIGhvdHBsdWcgc3VwcG9ydCBvbiBwY2ktYnJpZGdlIGF0dGFjaGVk
IHRvIGEgcHhiLg0KPiA+ID4NCj4gPiA+IC4uLiBidXQgSSBndWVzcyB1c2luZyB0aGlzIGluc3Rl
YWQgd291bGQgYmUgYmV0dGVyIGFueXdheT8NCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIyMDQyMjEzNTEwMS42NTc5NjgyM0ByZWRoYXQuY29tL3QvI3I4MzFkNTg5ZjI0
M2MyNDMzNGEwOTk5NTYyMGI3NDQwODg0N2E4N2EwDQo+ID4NCj4gPiBBY2NvcmRpbmcgdGhpcyBt
ZXNzYWdlLCBJdCBzZWVtcyB0aGF0IHRoZSBjdXJyZW50IFFFTVUgZG9lcyBub3Qgc3VwcG9ydCBp
dCB5ZXQuDQo+ID4gSSB0cmllZCB0byBob3RwbHVnIG9uIHBjaS1icmlkZ2UgYXR0YWNoZWQgdG8g
YSBweGIsIG5vIGRldmljZSBmb3VuZCBpbiB0aGUgZ3Vlc3QuDQo+IFNIUEMgd29ya3MgZm9yIHEz
NSwgd2hpY2ggcHJvdmlkZXMgX09TQy4NCj4gSXQgaXMgYnJva2VuIGZvciBwYyBtYWNoaW5lIHRo
b3VnaCwgc2luY2UgbWFjaGluZSBsYWNrcyBlaXRoZXIgX09TQyBvciBPU0hQLg0KPiBUaGVvcmV0
aWNhbGx5IFNIUEMgc2hvdWxkIHN0aWxsIHdvcmsgZm9yIGhvdHBsdWdnZWQgYnJpZGdlcw0KPiAo
aS5lLiB3aXRoIEFDUEkgaG90cGx1ZyBlbmFibGVkLCB3aGVuIG9uZSBob3RwbHVncyBhIGJyaWRn
ZSBpbnRvDQo+IHBjaS4wLCBidXQgSSBoYXZlbid0IHRyaWVkIHRoYXQgbGF0ZWx5KQ0KPiBJJ20g
c3RpbGwgbm90IHN1cmUgaWYgd2Ugc2hvdWxkIG1ha2UgT1NIUCBnbG9iYWwsIG9yIHB1dCBpdCBv
bmx5DQo+IHVuZGVyIGJyaWRnZXMgdGhhdCBoYXZlIHNoY3A9b24gJiYgZG9uJ3QgaGF2ZSBBQ1BJ
IGhvdHBsdWcuDQo+IFRoZSBsYXRlciBzZWVtcyBjbGVhbmVyIHRob3VnaC4NCg0KX09TQyBpcyBn
bG9iYWwsIHNldHRpbmcgdGhlIE9TSFAgbWV0aG9kIHRvIGdsb2JhbCBhbHNvIG1ha2VzIHNlbnNl
Pw0KT2YgY291cnNlo6x0aGUgbGF0ZXIgc2VlbXMgY2xlYW5lci4NCg0KQWRkIHRoZSBPU0hQIG1l
dGhvZCBhbmQgc2hwYz1vbiwgaG90cGx1ZyBkZXZpY2UgdG8gcGNpLWJyaWRnZQ0KYXR0YWNoZWQg
dG8gYSBweGIgd2FzIHN1Y2Vzc2Z1bC4gV2hhdCBkbyBJIG5lZWQgdG8gYWRkIHRvIHRoZSBRRU1V
DQppZiBJIHdhbnQgdG8gdXNlIHRoZSBBQ1BJIHBjaSBob3RwbHVnIHVuZGVyIHRoZSBwY2ktYnJp
ZGdlIGF0dGFjaGVkIHRvIGEgcHhiPw0KDQpUaGFua3Mu

