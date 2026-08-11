Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0676C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiB-0005at-Gu; Tue, 11 Aug 2026 01:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb54-0006YQ-2G; Mon, 10 Aug 2026 21:15:02 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb51-0006Xm-8Y; Mon, 10 Aug 2026 21:15:01 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowAA3Cu6Gd3pq5bPYBA--.22594S3;
 Tue, 11 Aug 2026 09:14:46 +0800 (CST)
Message-ID: <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 11 Aug 2026 09:14:47 +0800
Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowAA3Cu6Gd3pq5bPYBA--.22594S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8trW5KryxGr4xtw43Wrg_yoW8tFWUpF
 s7WrW7Gr95Ca4kJa97Jr1UW3WrZw4rGrWY9an3C3yvq3y5CrZxWFn8tw12gF98WFs5Jr42
 93ZFvw1a9rWkJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Jr0_Gr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
 cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx
 0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI
 67k04243AVAKzVAKj4xxMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
 1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JwCE64
 xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07bw2NNUUUUU=
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

SW4gdXNlci1vbmx5IGJ1aWxkcyBjaGVja196aWNib19lbnZjZmcoKSBza2lwcGVkIHRo
ZSBlbnZjZmcgY2hlY2sNCmVudGlyZWx5ICgjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJf
T05MWSkpLCBzbyBjYm8uaW52YWwvY2JvLmZsdXNoLw0KY2JvLnplcm8gcmV0aXJlZCB1
bmNvbmRpdGlvbmFsbHkgaW4gbGludXgtdXNlciBldmVuIHRob3VnaCB0aGUNCm1hY2hp
bmUtbGV2ZWwgZW52Y2ZnIGZpZWxkcyBhcmUgbmV2ZXIgaW5pdGlhbGl6ZWQuICBHaXZl
IHRoZQ0KdXNlci1tb2RlIGJ1aWxkIGEgc2VudmNmZy1iYXNlZCBnYXRlLCBhbmQgaW5p
dGlhbGl6ZSBTRU5WQ0ZHX0NCWkUgYXQNCnJlc2V0IHdoZW4gZXh0X3ppY2JveiBpcyBl
bmFibGVkIHNvIGNiby56ZXJvIHN0YXlzIHVzYWJsZSB3aGlsZQ0KY2JvLmludmFsL2Ni
by5mbHVzaCByZW1haW4gaWxsZWdhbCwgbWF0Y2hpbmcgdGhlIHVzZXItbW9kZSB2aWV3
IG9mIGENCnR5cGljYWwgZmlybXdhcmUva2VybmVsIHNldHVwLg0KDQpSZXNvbHZlczog
aHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80
MTA3DQpTaWduZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXguaXNj
YXMuYWMuY24+DQotLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBi
L3RhcmdldC9yaXNjdi9jcHUuYw0KaW5kZXggNWE4MmU2NTYzYmYuLjQ1Yjc2MTBhYTRm
IDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5jDQorKysgYi90YXJnZXQvcmlz
Y3YvY3B1LmMNCkBAIC0xMDYxLDYgKzEwNjEsMTQgQEAgc3RhdGljIHZvaWQgcmlzY3Zf
Y3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQ0KICNlbHNl
DQogICAgIGVudi0+cHJpdiA9IFBSVl9VOw0KICAgICBlbnYtPnNlbnZjZmcgPSAwOw0K
KyAgICAvKg0KKyAgICAgKiBNYXRjaCB0aGUgdXNlci1tb2RlIHZpZXcgb2YgYSB0eXBp
Y2FsIGZpcm13YXJlL2tlcm5lbCBzZXR1cCB3aGVyZQ0KKyAgICAgKiBjYm8uemVybyBp
cyBlbmFibGVkIGZvciB1c2VyIG1vZGU7IHRoZSBDQkNGRS9DQklFIGJpdHMgc3RheSB6
ZXJvLA0KKyAgICAgKiBzbyB0aGUgY2FjaGUtbWFuYWdlbWVudCBvcGVyYXRpb25zIHJl
bWFpbiBpbGxlZ2FsIGluIHVzZXIgbW9kZS4NCisgICAgICovDQorICAgIGlmIChyaXNj
dl9jcHVfY2ZnKGVudiktPmV4dF96aWNib3opIHsNCisgICAgICAgIGVudi0+c2VudmNm
ZyB8PSBTRU5WQ0ZHX0NCWkU7DQorICAgIH0NCiAgICAgZW52LT5tZW52Y2ZnID0gMDsN
CiAjZW5kaWYgLyogIUNPTkZJR19VU0VSX09OTFkgKi8NCiANCmRpZmYgLS1naXQgYS90
YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9vcF9o
ZWxwZXIuYw0KaW5kZXggYmEzYzdkYTM3NWEuLmI5ZDBkZWFjZGZiIDEwMDY0NA0KLS0t
IGEvdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYw0KKysrIGIvdGFyZ2V0L3Jpc2N2
L3RjZy9vcF9oZWxwZXIuYw0KQEAgLTE0Niw3ICsxNDYsMTYgQEAgdGFyZ2V0X3Vsb25n
IGhlbHBlcl9jc3Jyd19pMTI4KENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzciwNCiBz
dGF0aWMgdm9pZCBjaGVja196aWNib19lbnZjZmcoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB0
YXJnZXRfdWxvbmcgZW52Yml0cywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnRwdHJfdCByYSkNCiB7DQotI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQor
I2lmIGRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkNCisgICAgLyoNCisgICAgICogbGlu
dXgtdXNlcjogdGhlIG1hY2hpbmUtbGV2ZWwgZW52Y2ZnIGZpZWxkcyBhcmUgbm90IHBh
cnQgb2YgdGhlDQorICAgICAqIHVzZXItbW9kZSBlbnZpcm9ubWVudDsgb25seSB0aGUg
dXNlci1tb2RlIHZpZXcgb2YgdGhlIGVuYWJsaW5nDQorICAgICAqIGJpdHMgKHNlbnZj
ZmcsIGFzIGluaXRpYWxpemVkIGZvciB0aGUgZ3Vlc3QpIGFwcGxpZXMuDQorICAgICAq
Lw0KKyAgICBpZiAoIWdldF9maWVsZChlbnYtPnNlbnZjZmcsIGVudmJpdHMpKSB7DQor
ICAgICAgICByaXNjdl9yYWlzZV9leGNlcHRpb24oZW52LCBSSVNDVl9FWENQX0lMTEVH
QUxfSU5TVCwgcmEpOw0KKyAgICB9DQorI2Vsc2UNCiAgICAgaWYgKChlbnYtPnByaXYg
PCBQUlZfTSkgJiYgIWdldF9maWVsZChlbnYtPm1lbnZjZmcsIGVudmJpdHMpKSB7DQog
ICAgICAgICByaXNjdl9yYWlzZV9leGNlcHRpb24oZW52LCBSSVNDVl9FWENQX0lMTEVH
QUxfSU5TVCwgcmEpOw0KICAgICB9


