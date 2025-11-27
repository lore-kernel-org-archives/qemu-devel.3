Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80882D116E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 02:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOSC4-0006kO-VU; Wed, 26 Nov 2025 21:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1vOSC2-0006kA-JQ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 21:57:15 -0500
Received: from canpmsgout09.his.huawei.com ([113.46.200.224])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1vOSBz-00066b-0I
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 21:57:14 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Y7BxDbg4bdv4BDzf7rAkIcpMiEXK+EOaT5aAFRhGzKw=;
 b=vtlbnpr79vyLMfCWa3osxg5KQ0eywVNabCQb0hdJzsQ9KOO6GqDftXzubHsStWDitU02+LgWv
 RWutGRlHR+6V2F4N4uFbCh9UIWV50hFqriQLyP4TFTuBXcodqrMWAJ7BjlvPNuwC6UGRJlIp2VA
 z6AhgD0RVL19Tky0RW+NZDw=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dH1Hq29xKz1cyQN;
 Thu, 27 Nov 2025 10:55:03 +0800 (CST)
Received: from kwepemf500018.china.huawei.com (unknown [7.202.181.5])
 by mail.maildlp.com (Postfix) with ESMTPS id 0BDA41A016C;
 Thu, 27 Nov 2025 10:56:52 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 kwepemf500018.china.huawei.com (7.202.181.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 10:56:51 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Thu, 27 Nov 2025 10:56:51 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Bibo Mao <maobibo@loongson.cn>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>, QEMU devel
 <qemu-devel@nongnu.org>
Subject: RE: virtio-crypto: Inquiry about virtio crypto
Thread-Topic: virtio-crypto: Inquiry about virtio crypto
Thread-Index: AQHcXz+QGuy/j9piuEGQ/DhWNYsWN7UF0tvg
Date: Thu, 27 Nov 2025 02:56:51 +0000
Message-ID: <027ff08db97d414da0ccc24a439e75d0@huawei.com>
References: <d4258604-e678-f975-0733-71190cf4067d@loongson.cn>
In-Reply-To: <d4258604-e678-f975-0733-71190cf4067d@loongson.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.54.122]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=113.46.200.224;
 envelope-from=arei.gonglei@huawei.com; helo=canpmsgout09.his.huawei.com
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlibyBNYW8gPG1h
b2JpYm9AbG9vbmdzb24uY24+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyNywgMjAyNSA5
OjQzIEFNDQo+IFRvOiBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+
IENjOiBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC5kZXY7IGxpbnV4LWtlcm5lbA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IFFFTVUgZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gU3ViamVjdDogdmlydGlvLWNy
eXB0bzogSW5xdWlyeSBhYm91dCB2aXJ0aW8gY3J5cHRvDQo+IA0KPiBIaSBnb25nbGVpLA0KPiAN
Cj4gICAgIEkgYW0gaW52ZXN0aWdhdGluZyBob3cgdG8gdXNlIEhXIGNyeXB0byBhY2NlbGVyYXRv
ciBpbiBWTS4gSXQgc2VlbXMgdGhhdA0KPiB2aXJ0aW8tY3J5cHRvIGlzIG9uZSBvcHRpb24sIGhv
d2V2ZXIgb25seSBhZXMgc2tjaXBoZXIgYWxnbyBpcyBzdXBwb3J0ZWQgYW5kDQoNCkFjdHVhbGx5
IGFrY2lwaGVyIHNlcnZpY2UgaGFkIGJlZW4gc3VwcG9ydGVkIGJ5IHZpcnRpby1jcnlwdG8gaW4g
MjAyMi4NCg0KPiB2aXJ0aW8tY3J5cHRvIGRldmljZSBpcyBub3Qgc3VnZ2VzdGVkIGJ5IFJIRUwg
MTAuDQo+IA0KPiBodHRwczovL2RvY3MucmVkaGF0LmNvbS9lbi9kb2N1bWVudGF0aW9uL3JlZF9o
YXRfZW50ZXJwcmlzZV9saW51eC8xMC9odG1sDQo+IC9jb25maWd1cmluZ19hbmRfbWFuYWdpbmdf
bGludXhfdmlydHVhbF9tYWNoaW5lcy9mZWF0dXJlLXN1cHBvcnQtYW5kLWxpbWl0DQo+IGF0aW9u
cy1pbi1yaGVsLTEwLXZpcnR1YWxpemF0aW9uDQo+IA0KPiAgICBJIHdhbnQgdG8ga25vdyB3aGF0
IGlzIHRoZSBwb3RlbnRpYWwgaXNzdWVkIHdpdGggdmlydGlvLWNyeXB0by4NCj4gDQoNClRoaXMg
cXVlc3Rpb24gaXMgdG9vIGJpZywgbWF5YmUgeW91J2QgYmV0dGVyIGFzayBSSEVMIGd1eXMuIDoo
DQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo+IFJlZ2FyZHMNCj4gQmlibyBNYW8NCg0KDQo=

