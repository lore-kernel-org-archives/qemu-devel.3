Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F7EC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEnTO-00028j-0h; Wed, 05 Jun 2024 06:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sEnTL-00028C-UO
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:02:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sEnTJ-0004rD-Nl
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:02:23 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VvNFf2BSvz2Cjsl;
 Wed,  5 Jun 2024 17:58:30 +0800 (CST)
Received: from dggpeml500014.china.huawei.com (unknown [7.185.36.63])
 by mail.maildlp.com (Postfix) with ESMTPS id AA0131A0188;
 Wed,  5 Jun 2024 18:02:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 dggpeml500014.china.huawei.com (7.185.36.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 18:02:11 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Wed, 5 Jun 2024 18:02:11 +0800
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "yu.zhang@ionos.com"
 <yu.zhang@ionos.com>, "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>, zhengchuan
 <zhengchuan@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "lizhijian@fujitsu.com"
 <lizhijian@fujitsu.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)"
 <lixiao91@huawei.com>, "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
Subject: RE: [PATCH 1/6] migration: remove RDMA live migration temporarily
Thread-Topic: [PATCH 1/6] migration: remove RDMA live migration temporarily
Thread-Index: AQHatni6DJD3CiQfS0m1DFPrsMEherG3HGyAgAHVElA=
Date: Wed, 5 Jun 2024 10:02:11 +0000
Message-ID: <78de06918788452ea46d27700dcc9010@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
 <11017c4b-e0db-4f2e-af1d-54bc2c416e5e@redhat.com>
In-Reply-To: <11017c4b-e0db-4f2e-af1d-54bc2c416e5e@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.124.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=arei.gonglei@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  "Gonglei (Arei)" <arei.gonglei@huawei.com>
From:  "Gonglei (Arei)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJh
bmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDQsIDIw
MjQgMTA6MDIgUE0NCj4gVG86IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXJ4QHJlZGhhdC5jb207IHl1Lnpo
YW5nQGlvbm9zLmNvbTsgbWdhbGF4eUBha2FtYWkuY29tOw0KPiBlbG1hci5nZXJkZXNAaW9ub3Mu
Y29tOyB6aGVuZ2NodWFuIDx6aGVuZ2NodWFuQGh1YXdlaS5jb20+Ow0KPiBiZXJyYW5nZUByZWRo
YXQuY29tOyBhcm1icnVAcmVkaGF0LmNvbTsgbGl6aGlqaWFuQGZ1aml0c3UuY29tOw0KPiBwYm9u
emluaUByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsgWGlleGlhbmd5b3UNCj4gPHhpZXhpYW5n
eW91QGh1YXdlaS5jb20+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGl4aWFvIChIKQ0K
PiA8bGl4aWFvOTFAaHVhd2VpLmNvbT47IGppbnB1LndhbmdAaW9ub3MuY29tOyBXYW5namlhbGlu
DQo+IDx3YW5namlhbGluMjNAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzZd
IG1pZ3JhdGlvbjogcmVtb3ZlIFJETUEgbGl2ZSBtaWdyYXRpb24gdGVtcG9yYXJpbHkNCj4gDQo+
IE9uIDA0LjA2LjI0IDE0OjE0LCBHb25nbGVpIHZpYSB3cm90ZToNCj4gPiBGcm9tOiBKaWFsaW4g
V2FuZyA8d2FuZ2ppYWxpbjIzQGh1YXdlaS5jb20+DQo+ID4NCj4gPiBUaGUgbmV3IFJETUEgbGl2
ZSBtaWdyYXRpb24gd2lsbCBiZSBpbnRyb2R1Y2VkIGluIHRoZSB1cGNvbWluZyBmZXcNCj4gPiBj
b21taXRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbGluIFdhbmcgPHdhbmdqaWFsaW4y
M0BodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdvbmdsZWkgPGFyZWkuZ29uZ2xlaUBo
dWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gLQ0KPiA+IC0gICAgLyog
QXZvaWQgcmFtX2Jsb2NrX2Rpc2NhcmRfZGlzYWJsZSgpLCBjYW5ub3QgY2hhbmdlIGR1cmluZyBt
aWdyYXRpb24uDQo+ICovDQo+ID4gLSAgICBpZiAocmFtX2Jsb2NrX2Rpc2NhcmRfaXNfcmVxdWly
ZWQoKSkgew0KPiA+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwgIlJETUE6IGNhbm5vdCBkaXNh
YmxlIFJBTSBkaXNjYXJkIik7DQo+ID4gLSAgICAgICAgcmV0dXJuOw0KPiA+IC0gICAgfQ0KPiAN
Cj4gSSdtIHBhcnRpY3VsYXJseSBpbnRlcmVzdGVkIGluIHRoZSBpbnRlcmFjdGlvbiB3aXRoIHZp
cnRpby1iYWxsb29uL3ZpcnRpby1tZW0uDQo+IA0KPiBEbyB3ZSBzdGlsbCBoYXZlIHRvIGRpc2Fi
bGUgZGlzY2FyZGluZyBvZiBSQU0sIGFuZCB3aGVyZSB3b3VsZCB5b3UgZG8gdGhhdCBpbg0KPiB0
aGUgcmV3cml0ZT8NCj4gDQoNClllcywgd2UgZG8uIFdlIGRpZG4ndCBjaGFuZ2UgdGhlIGxvZ2lj
LiBUaGFua3MgZm9yIHlvdXIgY2F0Y2hpbmcuDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo+IC0t
DQo+IENoZWVycywNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCg0K

