Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14625C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiB-0005au-HD; Tue, 11 Aug 2026 01:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEj-0007jy-EO; Mon, 10 Aug 2026 21:25:01 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEf-0007YJ-AC; Mon, 10 Aug 2026 21:25:01 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowABXLfHjeXpqxxPZBA--.17429S9;
 Tue, 11 Aug 2026 09:24:52 +0800 (CST)
Message-ID: <22f977d13e90468683000679197a0384@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: SENT
 0001-linux-user-riscv-honor-zicntr-false-for-base-counter.patch   Subject:
 [PATCH 1/7] linux-user/riscv: honor zicntr=false for base counter CSRs  
 Message-ID:
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
References: SENT
 0001-linux-user-riscv-honor-zicntr-false-for-base-counter.patch   Subject:
 [PATCH 1/7] linux-user/riscv: honor zicntr=false for base counter CSRs  
 Message-ID:
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 11 Aug 2026 09:24:52 +0800
Subject: [PATCH 7/7] target/riscv: allow whole-register moves with vill set
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowABXLfHjeXpqxxPZBA--.17429S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tF18KFyUAF1DKr1UXw4DXFb_yoW8Ar13pa
 1kCrW2kryrWa4xZayFqr47XFyxWF4Fgr48Can2qwn5XFWUGrZ2yF4F93y7KFy8JFWF9r1j
 9FWvya13uayjka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280
 aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
 AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0E
 x4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67
 k04243AVAKzVAKj4xxMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
 c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryU
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VAC
 Y4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUgE19UUUUU
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Aug 2026 01:07:37 -0400
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

V2hvbGUtcmVnaXN0ZXIgdmVjdG9yIG1vdmVzIGRvIG5vdCBkZXBlbmQgb24gdnR5cGUu
ICBUaGUgVi0xLjANCnNwZWNpZmljYXRpb24gZXhwbGljaXRseSBleGNsdWRlcyB3aG9s
ZS1yZWdpc3RlciBsb2Fkcywgc3RvcmVzIGFuZCBtb3Zlcw0KZnJvbSB0aGUgdnR5cGUg
ZGVwZW5kZW5jeSwgYW5kIFNlY3Rpb24gMTYuNiBkZWZpbmVzIHZtdjxucj5yLnYgYXMg
YSBjb3B5DQpvZiB0aGUgd2hvbGUgcmVnaXN0ZXIgZ3JvdXAgd2l0aG91dCBuZWVkaW5n
IHRvIGtub3cgb3IgY2hhbmdlIHZsIG9yDQp2dHlwZS4gIEdFTl9WTVZfV0hPTEVfVFJB
TlMgY3VycmVudGx5IHJlamVjdHMgdm12MXIvMnIvNHIvOHIgd2hlbg0KdnR5cGUudmls
bCBpcyBzZXQsIHdoaWxlIHdob2xlLXJlZ2lzdGVyIGxvYWRzIGFuZCBzdG9yZXMgYWxy
ZWFkeSBleGVjdXRlLg0KRHJvcCB0aGUgdmV4dF9jaGVja19pc2FfaWxsKCkgZ2F0ZSBm
cm9tIHRoZSBtb3ZlIHRyYW5zbGF0b3I7IHRoZSBSVlYNCmV4dGVuc2lvbiBjaGVjaywg
cmVnaXN0ZXItZ3JvdXAgYWxpZ25tZW50IGNoZWNrcyBhbmQgdnN0YXJ0IGhhbmRsaW5n
IGFyZQ0KdW5jaGFuZ2VkLg0KDQpSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3Fl
bXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80MTU0DQpTaWduZWQtb2ZmLWJ5OiB3
YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXguaXNjYXMuYWMuY24+DQotLS0NCiB0YXJn
ZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ2LmMuaW5jIHwgNCArLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2di5j
LmluYyBiL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMN
CmluZGV4IGZhMWVlODBiYzU5Li4zMmI1NDA4OTQ0OCAxMDA2NDQNCi0tLSBhL3Rhcmdl
dC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCisrKyBiL3Rhcmdl
dC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCkBAIC0zOTY4LDE0
ICszOTY4LDEyIEBAIHN0YXRpYyBib29sIHRyYW5zX3Zjb21wcmVzc192bShEaXNhc0Nv
bnRleHQgKnMsIGFyZ19yICphKQ0KIH0NCiANCiAvKg0KLSAqIFdob2xlIFZlY3RvciBS
ZWdpc3RlciBNb3ZlIEluc3RydWN0aW9ucyBkZXBlbmQgb24gdnR5cGUgcmVnaXN0ZXIo
dnNldykuDQotICogVGh1cywgd2UgbmVlZCB0byBjaGVjayB2aWxsIGJpdC4gKFNlY3Rp
b24gMTYuNikNCisgKiBXaG9sZSBWZWN0b3IgUmVnaXN0ZXIgTW92ZSBJbnN0cnVjdGlv
bnMgZG8gbm90IGRlcGVuZCBvbiB2dHlwZS4NCiAgKi8NCiAjZGVmaW5lIEdFTl9WTVZf
V0hPTEVfVFJBTlMoTkFNRSwgTEVOKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KIHN0YXRpYyBib29sIHRyYW5zXyMjTkFNRShEaXNhc0NvbnRleHQgKnMsIGFyZ18j
I05BTUUgKiBhKSAgICAgICAgICAgICAgIFwNCiB7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQogICAgIGlmIChyZXF1aXJlX3J2dihzKSAmJiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KLSAgICAgICAgdmV4dF9jaGVja19pc2Ff
aWxsKHMpICYmICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
CiAgICAgICAgIFFFTVVfSVNfQUxJR05FRChhLT5yZCwgTEVOKSAmJiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICBRRU1VX0lTX0FMSUdORUQo
YS0+cnMyLCBMRU4pKSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
ICAgICAgICAgdWludDMyX3QgbWF4c3ogPSBzLT5jZmdfcHRyLT52bGVuYiAqIExFTjsg
ICAgICAgICAgICAgICAgICAgICAgIFwNCi0tIA0KMi40My4wDQo=


