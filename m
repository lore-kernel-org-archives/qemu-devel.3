Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E79C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy82S-00041A-Ly; Sun, 23 Aug 2026 09:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82E-0003uk-Od; Sun, 23 Aug 2026 09:14:51 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82B-0007Oh-AL; Sun, 23 Aug 2026 09:14:50 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowAD3Yz478opq7al2Bg--.8255S8;
 Sun, 23 Aug 2026 21:14:35 +0800 (CST)
Message-ID: <d2fef5916c826b522d2b2293e210fdabbc7b200b.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
References: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email via .NET SmtpClient
MIME-Version: 1.0
From: wangyang25@otcaix.iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Date: 23 Aug 2026 21:14:35 +0800
Subject: [PATCH 5/5] target/riscv: enforce SSE precedence for ssp CSR access
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: zQCowAD3Yz478opq7al2Bg--.8255S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDKF17CFyxXFyrXFy5urg_yoW8WF4rpF
 18G390ka9YgasIyan3Jr1DWF13Gw1rJwsrXw1xCw4jvr15ArW3GasFgFsxtFyrJFWDGr42
 vr42yF4ruF4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUdSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280
 aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
 AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0E
 x4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACY4
 xI67k04243AVAKzVAKj4xxM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtwCY02Av
 z4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
 xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
 MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
 0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
 JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJwCE64xvF2IEb7IF0Fy7YxBIdaVFxh
 VjvjDU0xZFpf9x07jaD73UUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

V2hlbiBtZW52Y2ZnLlNTRSBpcyBjbGVhciwgc3NwIGFjY2VzcyBiZWxvdyBNIG1vZGUg
cmFpc2VzIGFuCmlsbGVnYWwtaW5zdHJ1Y3Rpb24gZXhjZXB0aW9uIGJlZm9yZSB2aXJ0
dWFsLWluc3RydWN0aW9uIGNsYXNzaWZpY2F0aW9uLgpBcHBseSB0aGUgaGVudmNmZy9z
ZW52Y2ZnIGNoZWNrcyBmb3IgVlMvVlUgYW5kIHByZXNlcnZlIHRoZSB1c2VyLW9ubHkK
cGF0aC4KUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVt
dS8tL3dvcmtfaXRlbXMvNDIyNgoKU2lnbmVkLW9mZi1ieTogd2FuZ3lhbmcgPHdhbmd5
YW5nMjVAb3RjYWl4LmlzY2FzLmFjLmNuPgotLS0KIHRhcmdldC9yaXNjdi90Y2cvY3Ny
LmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKaW5k
ZXggZmQwMDUzOC4uMTdhNmZjMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9j
c3IuYworKysgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jCkBAIC0yMDEsMTUgKzIwMSwz
NCBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gY2ZpX3NzKENQVVJJU0NWU3RhdGUgKmVu
diwgaW50IGNzcm5vKQogICAgICAgICByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOwogICAg
IH0KIAotICAgIC8qIGlmIGJjZmkgbm90IGFjdGl2ZSBmb3IgY3VycmVudCBlbnYsIGFj
Y2VzcyB0byBjc3IgaXMgaWxsZWdhbCAqLwotICAgIGlmICghY3B1X2dldF9iY2ZpZW4o
ZW52KSkgewogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCi0gICAgICAgIGlm
IChlbnYtPmRlYnVnZ2VyKSB7Ci0gICAgICAgICAgICByZXR1cm4gUklTQ1ZfRVhDUF9O
T05FOwotICAgICAgICB9IGVsc2UgaWYgKGVudi0+dmlydF9lbmFibGVkKSB7CisgICAg
aWYgKGVudi0+ZGVidWdnZXIpIHsKKyAgICAgICAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9O
RTsKKyAgICB9CisKKyAgICAvKiBwcml2IDwgTSBhbmQgbWVudmNmZy5TU0UgPSAwIG11
c3QgcmFpc2UgaWxsZWdhbC1pbnN0cnVjdGlvbiAqLworICAgIGlmICghKGVudi0+bWVu
dmNmZyAmIE1FTlZDRkdfU1NFKSkgeworICAgICAgICByZXR1cm4gUklTQ1ZfRVhDUF9J
TExFR0FMX0lOU1Q7CisgICAgfQorCisgICAgaWYgKGVudi0+dmlydF9lbmFibGVkKSB7
CisgICAgICAgIGlmIChlbnYtPnByaXYgPT0gUFJWX1MpIHsKKyAgICAgICAgICAgIGlm
IChlbnYtPmhlbnZjZmcgJiBIRU5WQ0ZHX1NTRSkgeworICAgICAgICAgICAgICAgIHJl
dHVybiBSSVNDVl9FWENQX05PTkU7CisgICAgICAgICAgICB9CisgICAgICAgICAgICBy
ZXR1cm4gUklTQ1ZfRVhDUF9WSVJUX0lOU1RSVUNUSU9OX0ZBVUxUOworICAgICAgICB9
CisgICAgICAgIGlmIChlbnYtPnByaXYgPT0gUFJWX1UpIHsKKyAgICAgICAgICAgIGlm
ICgoZW52LT5oZW52Y2ZnICYgSEVOVkNGR19TU0UpICYmCisgICAgICAgICAgICAgICAg
KGVudi0+c2VudmNmZyAmIFNFTlZDRkdfU1NFKSkgeworICAgICAgICAgICAgICAgIHJl
dHVybiBSSVNDVl9FWENQX05PTkU7CisgICAgICAgICAgICB9CiAgICAgICAgICAgICBy
ZXR1cm4gUklTQ1ZfRVhDUF9WSVJUX0lOU1RSVUNUSU9OX0ZBVUxUOwogICAgICAgICB9
CisgICAgfQogI2VuZGlmCisKKyAgICBpZiAoIWNwdV9nZXRfYmNmaWVuKGVudikpIHsK
ICAgICAgICAgcmV0dXJuIFJJU0NWX0VYQ1BfSUxMRUdBTF9JTlNUOwogICAgIH0KIAot
LSAKMi41NS4wLndpbmRvd3MuMgoK


