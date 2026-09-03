Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA99C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x22Jh-0000dP-6Y; Thu, 03 Sep 2026 03:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3138947285@qq.com>) id 1x22Je-0000cv-Di
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:56:59 -0400
Received: from out203-205-221-149.mail.qq.com ([203.205.221.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3138947285@qq.com>) id 1x22Jb-0005jy-EP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1788422208; bh=ecihUJvTXqtI8yMcYIIzf34Sfa1kpNexUvrECdtHbdM=;
 h=From:To:Cc:Subject:Date;
 b=retA50Mg9HeYO1IZjr110w8jh7r+IW0UCkUbKbLO02oFY2B6nBubCk5CXNSWfDEuG
 Mt6w5PDXsRVTAAbVsc1vaNphxtuLbRnc71Ce/qQRxq0MgA5MOwuasXwO2q0eBSMzzd
 RkudCqLRwIONfSzOVxuynBy1SOjHNsiR3Wp/xAWM=
Received: from Win11-9700X.localdomain
 ([240e:398:adf0:2560:dc86:1426:97f0:785b])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id E2E3F2E2; Thu, 03 Sep 2026 15:56:46 +0800
X-QQ-mid: xmsmtpt1788422206to5dkrs1n
Message-ID: <tencent_FA380D5D8DA060298F4F0B220D3D00E45A08@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9i381h+Lwe0b6rxKsXg3AeVrJ7M75v5tx3kbpagQUM2P9+I7rUUZ
 lyY4vv15ncZr35wzNx9qjALlFv5vtaD+YPspzmcCoxhmpqISkX3Mi+rZ7+wQAgoBqVF5oV+z1nU/
 iHyEzMnNn18d+Gc/OM1qDwSYykA8G74AKkagLdmYPMuUwiEhQJkjC4AYnltERr/2RHpdZYmVAe+X
 eLh5+gRgAcNg+MYwvSEgkSmx1uCZj1sxwiO8Ck6yfNC/pUT8CxBGGIK08D8wVNb1YrSZwLYnK8Re
 NvuYDYd+OI+ikKPY0lWQXPrEYjEKB7WbQn/QwXe7LyePf+OuNYFSOhlfix3pKeZZkK/h1/FF9oCe
 XrQniEizTzySzLwO1q7VmKGfby6gkF+sFonifZUoxUkpGV9psEC4768/9QgIDN/vDz19QKaeeCNC
 gWi4MremEuPtfYo9JB1ewjU2pMsL+aFvr6+2gERYcITXQcrC/YZqKPaWPPAfE32yDjtFxtVyOQSD
 mN6W+Ew35biRdCs8wZVk/eCYP65hnysp+B6sXimXodAswpbjO5B7osVPDHlsu3aC2r3lA7Ps9ZxZ
 nLZinmV2gO+jIwSQfglCJ8tDfCw6zQpGy8YEUi0t7muFSVHZcMoHrDhdWiVyoNG2qBzr70EhbkLO
 iR3afGxAGiDwtnibj0eNYToqQGFpfG/fDev6wSA+0eHFikKIE7rL6+QeGs+BD5jFpytUM7G6ida+
 GuF0fUxbYM6/QtvwEv8IwzkJMoGS3190igb1qN2IY0Hwjl+YPOeO8hFtTMOdWOuQLzC4cNDzyLJY
 i7eOXEBOaQcIjdo2PVKhDlHpOIZ2ySa5b+WA0hl3pPBM+h8b1NHgnvFaop5Ct//JadulXxAbZRhY
 oYYWt7dd5VqbcOSfjVkIO7zhdgfmmMhd/hDuo+EN8Txg2WSr3txM0Vd2+cFgD1SGKJ30QNvJ6dJi
 4ExDsYXP5YH47BXVufdnOEwyxJ499CGBSaypE3vhb3xraL6WaqyBEVkesjDcy/GulJtDY5y/zEv9
 Num6dJUvbj+ZHV3zmhZ+dehDM5mmQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Jiajun Liang <3138947285@qq.com>
To: qemu-devel@nongnu.org
Cc: pbarbuda@microsoft.com, mohamed@unpredictable.fr
Subject: [PATCH] whpx: intercept CPUID leaf 4 so guests get the host cache
 topology
Date: Thu, 03 Sep 2026 15:56:46 +0800
X-OQ-MSGID: <178842220603.9862.3674685426630821508@qq.com>
X-Mailer: python-smtplib (git-send-email equivalent)
Received-SPF: pass client-ip=203.205.221.149; envelope-from=3138947285@qq.com;
 helo=out203-205-221-149.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbSA4OWM4Njg0MDhhMmI3MWY4MzhjNjk2NGQ0NDYxYzQ4MGExMDhkMGU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKaWFqdW4gTGlhbmcgPDMxMzg5NDcyODVAcXEuY29tPgpEYXRl
OiBNb24sIDMxIEF1ZyAyMDI2IDE4OjQ0OjQyICswODAwClN1YmplY3Q6IFtQQVRDSF0gd2hweDog
aW50ZXJjZXB0IENQVUlEIGxlYWYgNCBzbyBndWVzdHMgZ2V0IHRoZSBob3N0IGNhY2hlCiB0b3Bv
bG9neQoKVGhlIGh5cGVydmlzb3IgYW5zd2VyZWQgQ1BVSUQgbGVhZiA0IChkZXRlcm1pbmlzdGlj
IGNhY2hlIHBhcmFtZXRlcnMpCml0c2VsZiBiZWNhdXNlIGxlYWYgNCB3YXMgbm90IGluIHRoZSBw
YXJ0aXRpb24ncyBDUFVJRCBleGl0IGxpc3QuIEl0cwphbnN3ZXIgZGVnZW5lcmF0ZXMgb24gdGhp
cyBzZXR1cDogdGhlIGZpcnN0IHN1YmxlYWYgcmVwb3J0cyBjYWNoZSB0eXBlIDAKKG5vIG1vcmUg
Y2FjaGVzKSwgc28gYSBndWVzdCBkZXJpdmluZyBpdHMgY29yZSBjb3VudCBmcm9tCmxlYWY0LkVB
WFszMToyNl0rMSBmYWxscyBiYWNrIHRvIDEgY29yZSBwZXIgcGFja2FnZSB3aGlsZSBsZWFmIDEg
c3RpbGwKcmVwb3J0cyAxNiBsb2dpY2FsIHByb2Nlc3NvcnMuIFhOVSB0aGVuIGNvbXB1dGVzCm5Q
VGhyZWFkc1BlckNvcmUgPSAxNiAvIDEgYW5kIGRpdmlkZXMgYnkgemVybyBkb3duc3RyZWFtIGlu
CmNwdV90aHJlYWRfYWxsb2MgZHVyaW5nIHNtcF9pbml0IChrZXJuZWwgcGFuaWMsIGRpdmlkZSBl
cnJvcikuCgpBZGQgbGVhZiA0IHRvIHRoZSBDUFVJRCBleGl0IGxpc3Qgc28gUUVNVSdzIGNwdV94
ODZfY3B1aWQgYW5zd2VycyBpdAp3aXRoIHRoZSBjb25maWd1cmVkIGNhY2hlIHRvcG9sb2d5IGlu
c3RlYWQuCgpDb250cmFjdDogSW50ZWwgU0RNIFZvbC4yIENQVUlEIGxlYWYgNCBkZWZpbmVzIEVB
WFszMToyNl0gYXMgdGhlCm1heGltdW0gbnVtYmVyIG9mIGFkZHJlc3NhYmxlIElEcyBmb3IgbG9n
aWNhbCBwcm9jZXNzb3JzIHNoYXJpbmcgdGhpcwpjYWNoZTsgUUVNVSBidWlsZHMgdGhhdCBmcm9t
IGVudi0+Y2FjaGVfaW5mby4KClZlcmlmaWVkIG9uIHRoZSB4ODYgbWFjT1MgLyBXSFBYIHBhdGh3
YXkgKFdpbmRvd3MgMTEgaG9zdCk6IHRoZSBndWVzdApub3cgcXVlcmllcyBsZWFmIDQgKHByZXZp
b3VzbHkgaXQgbmV2ZXIgcmVhY2hlZCBRRU1VKSwgY29yZXMgcGVyIHBhY2thZ2UKaXMgZGVyaXZl
ZCBhcyAxNiwgdGhlIGRpdmlkZSBlcnJvciBkaXNhcHBlYXJzLCBhbmQgdGhlIGd1ZXN0IGFkdmFu
Y2VzCnBhc3Qgc21wX2luaXQgdGhyb3VnaCBWTSBib290c3RyYXAsIHNjaGVkdWxlciBpbml0LCBh
bmQgTWFjaCBvYmplY3QKc2V0dXAuCgpTaWduZWQtb2ZmLWJ5OiBKaWFqdW4gTGlhbmcgPDMxMzg5
NDcyODVAcXEuY29tPgotLS0KIHRhcmdldC9pMzg2L3docHgvd2hweC1hbGwuYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9pMzg2L3docHgvd2hweC1hbGwuYyBiL3RhcmdldC9pMzg2L3docHgvd2hweC1hbGwu
YwppbmRleCAxMTNmNzlhLi5hOWU3NGM5IDEwMDY0NAotLS0gYS90YXJnZXQvaTM4Ni93aHB4L3do
cHgtYWxsLmMKKysrIGIvdGFyZ2V0L2kzODYvd2hweC93aHB4LWFsbC5jCkBAIC0zMDM5LDcgKzMw
MzksNyBAQCBpbnQgd2hweF9hY2NlbF9pbml0KEFjY2VsU3RhdGUgKmFzLCBNYWNoaW5lU3RhdGUg
Km1zKQogICAgIFdIVl9QUk9DRVNTT1JfRkVBVFVSRVNfQkFOS1MgcHJvY2Vzc29yX2ZlYXR1cmVz
OwogICAgIFdIVl9QUk9DRVNTT1JfUEVSRk1PTl9GRUFUVVJFUyBwZXJmbW9uX2ZlYXR1cmVzOwog
Ci0gICAgVUlOVDMyIGNwdWlkRXhpdExpc3RbXSA9IHsweDAsIDB4MSwgMHg2LCAweDcsIDB4Yiwg
MHhkLCAweDE0LCAweDI0LCAweDI5LCAweDFFLAorICAgIFVJTlQzMiBjcHVpZEV4aXRMaXN0W10g
PSB7MHgwLCAweDEsIDB4NCwgMHg2LCAweDcsIDB4YiwgMHhkLCAweDE0LCAweDI0LCAweDI5LCAw
eDFFLAogICAgICAgICAweDQwMDAwMDAwLCAweDQwMDAwMDAxLCAweDQwMDAwMDEwLCAweDgwMDAw
MDAwLCAweDgwMDAwMDAxLAogICAgICAgICAweDgwMDAwMDAyLCAweDgwMDAwMDAzLCAweDgwMDAw
MDA0LCAweDgwMDAwMDA3LCAweDgwMDAwMDA4LAogICAgICAgICAweDgwMDAwMDBBLCAweDgwMDAw
MDIxLCAweDgwMDAwMDIyLCAweEMwMDAwMDAwLCAweEMwMDAwMDAxfTsKLS0gCjIuNTUuMAoK


