Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FA9C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLl3j-0008GL-Kp; Mon, 24 Jun 2024 10:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1sLl3e-0008G1-M4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:52:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1sLl3b-00019e-B0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:52:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W79qy1gFmz6K9c9;
 Mon, 24 Jun 2024 22:50:38 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 40935140517;
 Mon, 24 Jun 2024 22:52:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 15:52:16 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039; 
 Mon, 24 Jun 2024 15:52:16 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "mchehab+huawei@kernel.org"
 <mchehab+huawei@kernel.org>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Thread-Topic: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Thread-Index: AQHaw/tJLIq1TYj6SUerz3Wdqaz/XbHW4WwAgAAhxoA=
Date: Mon, 24 Jun 2024 14:52:16 +0000
Message-ID: <3becac0608344c9d853f0658902f1753@huawei.com>
References: <20240621165115.336-1-shiju.jose@huawei.com>
 <CAFEAcA9CQ_D168MmD+VbQsegUVsJuiXBP64oH0SgL=bD8EDJOA@mail.gmail.com>
In-Reply-To: <CAFEAcA9CQ_D168MmD+VbQsegUVsJuiXBP64oH0SgL=bD8EDJOA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.34.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shiju Jose <shiju.jose@huawei.com>
From:  Shiju Jose via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhhbmtzIFBldGVyIGZvciB0aGUgdmFsdWFibGUgY29tbWVudHMuIA0KDQo+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+DQo+U2VudDogMjQgSnVuZSAyMDI0IDE0OjQ4DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1
Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBsaW51eC1lZGFj
QHZnZXIua2VybmVsLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPjxqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb20+OyBtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnOyB0YW54aWFvZmVpDQo+PHRhbnhp
YW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+
OyBMaW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUkZDIFBB
VENIIDEvMV0gaHcvYXJtOiBGVyBmaXJzdCBBUk0gcHJvY2Vzc29yIGVycm9yIGluamVjdGlvbi4N
Cj4NCj5PbiBGcmksIDIxIEp1biAyMDI0IGF0IDE3OjUyLCBzaGlqdS5qb3NlLS0tIHZpYSA8cWVt
dS1kZXZlbEBub25nbnUub3JnPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBTaGlqdSBKb3NlIDxzaGlq
dS5qb3NlQGh1YXdlaS5jb20+DQo+Pg0KPg0KPg0KPg0KPj4gZGlmZiAtLWdpdCBhL2h3L2FybS9h
cm1fZXJyb3JfaW5qZWN0LmMgYi9ody9hcm0vYXJtX2Vycm9yX2luamVjdC5jIG5ldw0KPj4gZmls
ZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwLi45NTNhOWQ2NzA1DQo+PiAtLS0gL2Rldi9u
dWxsDQo+PiArKysgYi9ody9hcm0vYXJtX2Vycm9yX2luamVjdC5jDQo+PiBAQCAtMCwwICsxLDQ5
IEBADQo+PiArLyoNCj4+ICsgKiBDWEwgVHlwZSAzIChtZW1vcnkgZXhwYW5kZXIpIGRldmljZQ0K
Pg0KPlRoaXMgZG9lc24ndCBzZWVtIHRvIG1hdGNoIHdoYXQgdGhlIGZpbGUgYWN0dWFsbHkgZG9l
cy4NCg0KSSB3aWxsIHVwZGF0ZS4gDQo+DQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQoQykgMjAy
MCBJbnRlbCBDb3Jwb3JhdGlvbi4NCj4+ICsgKg0KPj4gKyAqIFRoaXMgd29yayBpcyBsaWNlbnNl
ZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHUEwsIHZlcnNpb24gMi4NCj4+ICsgU2VlIHRo
ZQ0KPj4gKyAqIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4+ICsg
Kg0KPj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtdjItb25seQ0KPg0KPldoeSBh
cmUgdGhlc2UgbmV3IGZpbGVzIEdQTC12Mi1vbmx5PyBPdXIgZ2VuZXJhbCBwcmVmZXJlbmNlIChz
ZWUgdGhlIExJQ0VOU0UpDQo+ZmlsZSBpcyBmb3IgR1BMLXYyLW9yLWFueS1sYXRlci12ZXJzaW9u
Lg0KPg0KPkkgYWxzbyBub3RpY2UgdGhhdCB0aGlzIGZpbGUgaXMgbWFya2VkIGFzIGNvcHlyaWdo
dCBJbnRlbCwgYnV0IHlvdSdyZSBzdWJtaXR0aW5nDQo+ZnJvbSBhIEh1YXdlaSBlbWFpbCBhZGRy
ZXNzLiAgV2hhdCdzIHRoZSBoaXN0b3J5IG9mIHRoaXMgY29kZT8NClRoYW5rcyBmb3IgcG9pbnRp
bmcgdGhpcyBlcnJvci4gDQpTdXJlIEkgd2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4gDQo+
DQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+ICsjaW5jbHVk
ZSAicWVtdS91bml0cy5oIg0KPj4gKyNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPj4g
KyNpbmNsdWRlICJxYXBpLWNvbW1hbmRzLWFybS1lcnJvci1pbmplY3QuaCINCj4+ICsjaW5jbHVk
ZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQo+PiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+
ICsjaW5jbHVkZSAicWVtdS9sb2cuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCj4+
ICsjaW5jbHVkZSAicWVtdS9wbWVtLmgiDQo+PiArI2luY2x1ZGUgInFlbXUvcmFuZ2UuaCINCj4+
ICsjaW5jbHVkZSAicWVtdS9yY3UuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9ndWVzdC1yYW5kb20u
aCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2hvc3RtZW0uaCINCj4+ICsjaW5jbHVkZSAic3lzZW11
L251bWEuaCINCj4+ICsjaW5jbHVkZSAiaHcvYm9hcmRzLmgiDQo+PiArI2luY2x1ZGUgImh3L2Fj
cGkvZ2hlcy5oIg0KPg0KPkxvb2tpbmcgYXQgdGhlIGNvZGUgaGVyZSBJJ20gcHJldHR5IHN1cmUg
eW91IGRvbid0IG5lZWQgYW55d2hlcmUgbmVhciBhbGwgb2YNCj50aGVzZSBpbmNsdWRlIGxpbmVz
Lg0KSSB3aWxsIGNoZWNrIHRoaXMgYW5kIGZpeC4NCj4NCj4+ICsNCj4+ICsjZGVmaW5lIERXT1JE
X0JZVEUgNA0KPg0KPlRoaXMgc2VlbXMgdG8gYmUgdW51c2VkLg0KTm90IHVzZWQuIEkgd2lsbCBk
ZWxldGUgdGhpcy4NCj4NCj50aGFua3MNCj4tLSBQTU0NCg0KVGhhbmtzLA0KU2hpanUNCg==

