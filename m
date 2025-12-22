Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB539E66886
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 01:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXUkh-0006UT-SP; Sun, 21 Dec 2025 20:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1vXUkc-0006Sa-VX
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 20:30:20 -0500
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1vXUkY-0001Fw-9t
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 20:30:18 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=h7znasO4yFWClX/qSLjoSRZg9q7K66lwZwj2OF1ATkI=;
 b=MGlWcrbEqndKg0t69D1zJ+RUJB81amVjolcIoxvrPdcKrrA5hZ0pmxSxvuIomplAIa8lIRzTN
 aBI3nenOzrh+xehqJu3Ajrwq23mtXBW/tjVX8kTQNKCwkLFWxZPCiJLvTrYb73ZFAfnQ62Uk8iC
 81asUgWzL9nL1VIOMDiEynQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dZL8X22krz1K968;
 Mon, 22 Dec 2025 09:26:52 +0800 (CST)
Received: from kwepemf500016.china.huawei.com (unknown [7.202.181.3])
 by mail.maildlp.com (Postfix) with ESMTPS id B7A8D40539;
 Mon, 22 Dec 2025 09:29:55 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 kwepemf500016.china.huawei.com (7.202.181.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Dec 2025 09:29:55 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Mon, 22 Dec 2025 09:29:55 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: zhenwei pi <zhenwei.pi@linux.dev>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "mcascell@redhat.com"
 <mcascell@redhat.com>, "nakamurajames123@gmail.com"
 <nakamurajames123@gmail.com>, zhenwei pi <pizhenwei@tensorfer.com>
Subject: RE: [PATCH v2 2/2] cryptodev-builtin: Limit the maximum size
Thread-Topic: [PATCH v2 2/2] cryptodev-builtin: Limit the maximum size
Thread-Index: AQHcciOr+4OFtEYdmEKfeveyGFwwarUs39pQ
Date: Mon, 22 Dec 2025 01:29:54 +0000
Message-ID: <60bb168c3ffb4eaba31c7699750c9625@huawei.com>
References: <20251221024321.143196-1-zhenwei.pi@linux.dev>
 <20251221024321.143196-3-zhenwei.pi@linux.dev>
In-Reply-To: <20251221024321.143196-3-zhenwei.pi@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.54.122]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=113.46.200.225;
 envelope-from=arei.gonglei@huawei.com; helo=canpmsgout10.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogemhlbndlaSBwaSA8
emhlbndlaS5waUBsaW51eC5kZXY+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgMjEsIDIwMjUg
MTA6NDMgQU0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogbXN0QHJlZGhhdC5j
b207IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47DQo+IG1jYXNjZWxs
QHJlZGhhdC5jb207IG5ha2FtdXJhamFtZXMxMjNAZ21haWwuY29tOyB6aGVud2VpIHBpDQo+IDxw
aXpoZW53ZWlAdGVuc29yZmVyLmNvbT47IHpoZW53ZWkgcGkgPHpoZW53ZWkucGlAbGludXguZGV2
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi8yXSBjcnlwdG9kZXYtYnVpbHRpbjogTGltaXQgdGhl
IG1heGltdW0gc2l6ZQ0KPiANCj4gRnJvbTogemhlbndlaSBwaSA8cGl6aGVud2VpQHRlbnNvcmZl
ci5jb20+DQo+IA0KPiBUaGlzIGJhY2tlbmQgZHJpdmVyIGlzIHVzZWQgZm9yIGRlbW9uc3RyYXRp
b24gcHVycG9zZXMgb25seSwgdW5saW1pdGVkIHNpemUgbGVhZHMNCj4gUUVNVSBPT00uDQo+IA0K
PiBGaXhlczogQ1ZFLTIwMjUtMTQ4NzYNCg0KQWN0dWFsbHksIEkgZG9uJ3QgdGhpbmsgdGhpcyBm
aXggaGFzIGFueXRoaW5nIHRvIGRvIHdpdGggdGhlIENWRS4gWW91IGNhbiBjb25zaWRlciBpdCBh
biBpbXByb3ZlbWVudC4NCg0KPiBGaXhlczogMTY1M2E1ZjNmYzcgKCJjcnlwdG9kZXY6IGludHJv
ZHVjZSBhIG5ldyBjcnlwdG9kZXYgYmFja2VuZCIpDQo+IFJlcG9ydGVkLWJ5OiDsnbTsnqzsmIEg
PG5ha2FtdXJhamFtZXMxMjNAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiB6aGVud2VpIHBp
IDx6aGVud2VpLnBpQGxpbnV4LmRldj4NCj4gLS0tDQo+ICBiYWNrZW5kcy9jcnlwdG9kZXYtYnVp
bHRpbi5jIHwgOSArKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvY3J5cHRvZGV2LWJ1
aWx0aW4uYyBiL2JhY2tlbmRzL2NyeXB0b2Rldi1idWlsdGluLmMgaW5kZXgNCj4gMDQxNGMwMWUw
Ni4uNTVhM2ZiZDI3YiAxMDA2NDQNCj4gLS0tIGEvYmFja2VuZHMvY3J5cHRvZGV2LWJ1aWx0aW4u
Yw0KPiArKysgYi9iYWNrZW5kcy9jcnlwdG9kZXYtYnVpbHRpbi5jDQo+IEBAIC01Myw2ICs1Myw4
IEBAIHR5cGVkZWYgc3RydWN0IENyeXB0b0RldkJhY2tlbmRCdWlsdGluU2Vzc2lvbiB7DQo+IA0K
PiAgI2RlZmluZSBDUllQVE9ERVZfQlVJVExJTl9NQVhfQVVUSF9LRVlfTEVOICAgIDUxMg0KPiAg
I2RlZmluZSBDUllQVE9ERVZfQlVJVExJTl9NQVhfQ0lQSEVSX0tFWV9MRU4gIDY0DQo+ICsvKiBk
ZW1vbnN0cmF0aW9uIHB1cnBvc2VzIG9ubHksIHVzZSBhIGxpbWl0ZWQgc2l6ZSB0byBhdm9pZCBR
RU1VIE9PTSAqLw0KPiArI2RlZmluZSBDUllQVE9ERVZfQlVJVExJTl9NQVhfUkVRVUVTVF9TSVpF
ICAoMTAyNCAqIDEwMjQpDQo+IA0KPiAgc3RydWN0IENyeXB0b0RldkJhY2tlbmRCdWlsdGluIHsN
Cj4gICAgICBDcnlwdG9EZXZCYWNrZW5kIHBhcmVudF9vYmo7DQo+IEBAIC05OCwxMiArMTAwLDcg
QEAgc3RhdGljIHZvaWQgY3J5cHRvZGV2X2J1aWx0aW5faW5pdCgNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAxdSA8PA0KPiBRQ1JZUFRPREVWX0JBQ0tFTkRfU0VSVklDRV9UWVBFX01BQzsN
Cj4gICAgICBiYWNrZW5kLT5jb25mLmNpcGhlcl9hbGdvX2wgPSAxdSA8PCBWSVJUSU9fQ1JZUFRP
X0NJUEhFUl9BRVNfQ0JDOw0KPiAgICAgIGJhY2tlbmQtPmNvbmYuaGFzaF9hbGdvID0gMXUgPDwg
VklSVElPX0NSWVBUT19IQVNIX1NIQTE7DQo+IC0gICAgLyoNCj4gLSAgICAgKiBTZXQgdGhlIE1h
eGltdW0gbGVuZ3RoIG9mIGNyeXB0byByZXF1ZXN0Lg0KPiAtICAgICAqIFdoeSB0aGlzIHZhbHVl
PyBKdXN0IGF2b2lkIHRvIG92ZXJmbG93IHdoZW4NCj4gLSAgICAgKiBtZW1vcnkgYWxsb2NhdGlv
biBmb3IgZWFjaCBjcnlwdG8gcmVxdWVzdC4NCj4gLSAgICAgKi8NCj4gLSAgICBiYWNrZW5kLT5j
b25mLm1heF9zaXplID0gTE9OR19NQVggLSBzaXplb2YoQ3J5cHRvRGV2QmFja2VuZE9wSW5mbyk7
DQo+ICsgICAgYmFja2VuZC0+Y29uZi5tYXhfc2l6ZSA9IENSWVBUT0RFVl9CVUlUTElOX01BWF9S
RVFVRVNUX1NJWkU7DQo+ICAgICAgYmFja2VuZC0+Y29uZi5tYXhfY2lwaGVyX2tleV9sZW4gPQ0K
PiBDUllQVE9ERVZfQlVJVExJTl9NQVhfQ0lQSEVSX0tFWV9MRU47DQo+ICAgICAgYmFja2VuZC0+
Y29uZi5tYXhfYXV0aF9rZXlfbGVuID0NCj4gQ1JZUFRPREVWX0JVSVRMSU5fTUFYX0FVVEhfS0VZ
X0xFTjsNCj4gICAgICBjcnlwdG9kZXZfYnVpbHRpbl9pbml0X2FrY2lwaGVyKGJhY2tlbmQpOw0K
PiAtLQ0KPiAyLjQzLjANCg0K

