Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61E8C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 03:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLa53-0002EY-1k; Sun, 23 Jun 2024 23:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLa51-0002EN-HU
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 23:09:19 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLa4t-0005zp-Qo
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 23:09:19 -0400
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: Failed to hot-plug device to pxb bridge
Thread-Topic: Failed to hot-plug device to pxb bridge
Thread-Index: AQHaw4XI87/5oTfsUESpKSNFbrbm9LHWO2qk
Date: Mon, 24 Jun 2024 03:08:55 +0000
Message-ID: <74e8929fd34d496ea64aab6b3a136b3b@baidu.com>
References: <3A8D097B-3BA7-40DC-8DDF-D79B7BEE5CEE@baidu.com>,
 <20240530160919.01a3effc@imammedo.users.ipa.redhat.com>,
 <2cae6cf3c0f64b509ceed04be6a8bd70@baidu.com>
In-Reply-To: <2cae6cf3c0f64b509ceed04be6a8bd70@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.68]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.12
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiBJIGNoZWNrZWQgdGhlIGd1ZXN0IGRtZXNnIGFuZCBmb3VuZCB0aGF0IGZhaWxlZCBsb2FkIHNo
cGMgZHJpdmVyLg0KPiAgIFsgICAgMC45NjY2NjhdIHNocGNocCAwMDAwOjAwOjA1LjA6IFJlcXVl
c3RpbmcgY29udHJvbCBvZiBTSFBDIGhvdHBsdWcgdmlhIE9TSFAgKFxfU0JfLlBDSTAuUzI4XykN
Cj4gICBbICAgIDAuOTY4MjM4XSBzaHBjaHAgMDAwMDowMDowNS4wOiBSZXF1ZXN0aW5nIGNvbnRy
b2wgb2YgU0hQQyBob3RwbHVnIHZpYSBPU0hQIChcX1NCXy5QQ0kwKQ0KPiAgIFsgICAgMC45Njkx
NjBdIHNocGNocCAwMDAwOjAwOjA1LjA6IENhbm5vdCBnZXQgY29udHJvbCBvZiBTSFBDIGhvdHBs
dWcNCj4gICBbICAgIDAuOTY5ODc2XSBzaHBjaHAgMDAwMDowMDowNi4wOiBSZXF1ZXN0aW5nIGNv
bnRyb2wgb2YgU0hQQyBob3RwbHVnIHZpYSBPU0hQIChcX1NCXy5QQ0kwLlMzMF8pDQo+ICAgWyAg
ICAwLjk3MTQ1NF0gc2hwY2hwIDAwMDA6MDA6MDYuMDogUmVxdWVzdGluZyBjb250cm9sIG9mIFNI
UEMgaG90cGx1ZyB2aWEgT1NIUCAoXF9TQl8uUENJMCkNCj4gICBbICAgIDAuOTcyMzc2XSBzaHBj
aHAgMDAwMDowMDowNi4wOiBDYW5ub3QgZ2V0IGNvbnRyb2wgb2YgU0hQQyBob3RwbHVnDQo+ICAg
WyAgICAwLjk3MzExOV0gc2hwY2hwIDAwMDA6ODA6MDAuMDogUmVxdWVzdGluZyBjb250cm9sIG9m
IFNIUEMgaG90cGx1ZyB2aWEgT1NIUCAoXF9TQl8uUEM4MCkNCj4gICBbICAgIDAuOTc0Njc0XSBz
aHBjaHAgMDAwMDo4MDowMC4wOiBDYW5ub3QgZ2V0IGNvbnRyb2wgb2YgU0hQQyBob3RwbHVnDQo+
ICAgWyAgICAwLjk3OTQyMl0gc2hwY2hwIDAwMDA6ODE6MDEuMDogUmVxdWVzdGluZyBjb250cm9s
IG9mIFNIUEMgaG90cGx1ZyB2aWEgT1NIUCAoXF9TQl8uUEM4MCkNCj4gICBbICAgIDAuOTgwOTQ4
XSBzaHBjaHAgMDAwMDo4MTowMS4wOiBDYW5ub3QgZ2V0IGNvbnRyb2wgb2YgU0hQQyBob3RwbHVn
DQo+ICAgWyAgICAwLjk4MTY4NV0gc2hwY2hwIDAwMDA6NjA6MDAuMDogUmVxdWVzdGluZyBjb250
cm9sIG9mIFNIUEMgaG90cGx1ZyB2aWEgT1NIUCAoXF9TQl8uUEM2MCkNCj4gICBbICAgIDAuOTk0
NjIzXSBzaHBjaHAgMDAwMDo2MDowMC4wOiBDYW5ub3QgZ2V0IGNvbnRyb2wgb2YgU0hQQyBob3Rw
bHVnDQo+ICAgWyAgICAwLjk5NTM0OV0gc2hwY2hwIDAwMDA6NjE6MDEuMDogUmVxdWVzdGluZyBj
b250cm9sIG9mIFNIUEMgaG90cGx1ZyB2aWEgT1NIUCAoXF9TQl8uUEM2MCkNCj4gICBbICAgIDAu
OTk2ODkxXSBzaHBjaHAgMDAwMDo2MTowMS4wOiBDYW5ub3QgZ2V0IGNvbnRyb2wgb2YgU0hQQyBo
b3RwbHVnDQo+ICAgWyAgICAwLjk5NzYyNl0gc2hwY2hwOiBTdGFuZGFyZCBIb3QgUGx1ZyBQQ0kg
Q29udHJvbGxlciBEcml2ZXIgdmVyc2lvbjogMC40DQo+IFJlYWQgdGhlIHNocGMgZHJpdmVyIGNv
ZGUsIEkgZm91bmQgdGhhdCBiZWZvcmUgc2hwY19pbml0IGl0IG5lZWQgY2hlY2sgdGhlIHNocGMg
Y2FwYWJpbGl0eSBvZiBicmlkZ2Uoc2hwY19jYXBhYmxlKSBhbmQNCj4gZ2V0IGhvdHBsdWcgY29u
dHJvbCBmcm9tIGZpcm13YXJlKGFjcGlfZ2V0X2hwX2h3X2NvbnRyb2xfZnJvbV9maXJtd2FyZSkg
aW4gc2hwY19wcm9iZS4NCj4gSG93ZXJ2ZXIgaXQgcmV0dXJuIGZhaWwgaW4gYWNwaV9nZXRfaHBf
aHdfY29udHJvbF9mcm9tX2Zpcm13YXJlLiBJIGR1bXAgdGhlIGFjcGlkIHRhYmxlLCBub3QgZm91
bmQgT1NDIGFuZCBPU0hQDQo+IG1ldGhvZCBpbiBkc2R0LmRzbC4NCj4gSW4gdGhlIFFFTVUgYnVp
bGRfZHNkdCwgbm90IGZvdW5kIGJ1aWxkIG9zYyBtZXRob2QgaW4gaTQ0MGZ4Lg0KPiBQdXR0aW5n
IGFzaWRlIHRoaXMgcHhiIHNjZW5hcmlvLCBJIHN1c3BlY3QgdGhhdCBhZnRlciBkaXNhYmxlIGFj
cGktcGNpLWhvdHBsdWctd2l0aC1icmlkZ2Utc3VwcG9ydCwNCj4gaG90LXBsdWcgaW50byB0aGUg
UENJIGJyaWRnZSB2aWEgU0hQQyBjYW4gYmUgc3VjY2Vzc2Z1bCBpbiBpNDQwZnggPw0KDQpBZnRl
ciBhZGRpbmcgb3NocCBtZXRob2QgaW4gYnVpbGRfZHNkdCwgdGhlIFNIUEMgZHJpdmVyIGxvYWQg
c3VjZXNzIGFuZCBob3RwbHVnIGRldmljZSBzdWNlc3MuIE1heWJlIHdlIG5lZWQgYSBwYXRjaA0K
Zml4IGl0ID8NCg0KDQoNCg0KICAgIA==

