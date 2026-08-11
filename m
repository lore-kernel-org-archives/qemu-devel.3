Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE73BC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiE-0005d3-IX; Tue, 11 Aug 2026 01:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb55-0006Yr-Aj; Mon, 10 Aug 2026 21:15:03 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb53-0006YF-3q; Mon, 10 Aug 2026 21:15:03 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowAA3Cu6Gd3pq5bPYBA--.22594S5;
 Tue, 11 Aug 2026 09:14:48 +0800 (CST)
Message-ID: <1244b2ba3a874624a23e2c5a18922ae2@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: SENT
 0001-target-riscv--honor-zicbo--envcfg-gating-in-linux-user-mode.patch  
 Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode   Message-ID:
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
References: SENT
 0001-target-riscv--honor-zicbo--envcfg-gating-in-linux-user-mode.patch  
 Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode   Message-ID:
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 11 Aug 2026 09:14:48 +0800
Subject: [PATCH 3/4] target/riscv: enforce even register constraints for
 Zdinx fcvt pairs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowAA3Cu6Gd3pq5bPYBA--.22594S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkAr4kJFyDJw4fZFW3trb_yoW8Gr1fpF
 s3CF4jkrZ8Kry0yay0yr4rCF47WFs3G3y8Ww1Sqws5Xa1DGrZFqFsYkr4ayr17JFsrtr4F
 vF1j9r15WFWjq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQ0b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
 jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k042
 43AVAKzVAKj4xxMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI
 67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUxlksDUUUU
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

ZmN2dC5kLmggYW5kIGZjdnQuaC5kIGFjY2VzcyBhIDY0LWJpdCBkb3VibGUgaGVsZCBp
biBhIHJlZ2lzdGVyDQpwYWlyLCBzbyB1bmRlciBaZGlueC9aaGlueG1pbiB0aGUgb2Rk
LXJkIChmY3Z0LmQuaCkgYW5kIG9kZC1yczENCihmY3Z0LmguZCkgZW5jb2RpbmdzIGFy
ZSByZXNlcnZlZC4gIEFkZCB0aGUgbWlzc2luZyBSRVFVSVJFX0VWRU4NCmNoZWNrcyBz
byB0aG9zZSBlbmNvZGluZ3MgcmFpc2UgYW4gaWxsZWdhbC1pbnN0cnVjdGlvbiBleGNl
cHRpb24NCmluc3RlYWQgb2YgcmV0aXJpbmcuDQoNClJlc29sdmVzOiBodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQxMDkNClNpZ25l
ZC1vZmYtYnk6IHdhbmd5YW5nIDx3YW5neWFuZzI1QG90Y2FpeC5pc2Nhcy5hYy5jbj4N
Ci0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJh
bnNfcnZ6ZmguYy5pbmMgYi90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNf
cnZ6ZmguYy5pbmMNCmluZGV4IGYzNmI0NmMyMTE4Li42ZWU3MTUwNmQ2MiAxMDA2NDQN
Ci0tLSBhL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnpmaC5jLmlu
Yw0KKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2emZoLmMu
aW5jDQpAQCAtNDEzLDYgKzQxMyw3IEBAIHN0YXRpYyBib29sIHRyYW5zX2ZjdnRfZF9o
KERpc2FzQ29udGV4dCAqY3R4LCBhcmdfZmN2dF9kX2ggKmEpDQogICAgIFJFUVVJUkVf
RlBVOw0KICAgICBSRVFVSVJFX1pGSE1JTl9PUl9aSElOWE1JTihjdHgpOw0KICAgICBS
RVFVSVJFX1pESU5YX09SX0QoY3R4KTsNCisgICAgUkVRVUlSRV9FVkVOKGN0eCwgYS0+
cmQpOw0KIA0KICAgICBUQ0d2X2k2NCBkZXN0ID0gZGVzdF9mcHIoY3R4LCBhLT5yZCk7
DQogICAgIFRDR3ZfaTY0IHNyYzEgPSBnZXRfZnByX2hzKGN0eCwgYS0+cnMxKTsNCkBA
IC00NDcsNiArNDQ4LDcgQEAgc3RhdGljIGJvb2wgdHJhbnNfZmN2dF9oX2QoRGlzYXND
b250ZXh0ICpjdHgsIGFyZ19mY3Z0X2hfZCAqYSkNCiAgICAgUkVRVUlSRV9GUFU7DQog
ICAgIFJFUVVJUkVfWkZITUlOX09SX1pISU5YTUlOKGN0eCk7DQogICAgIFJFUVVJUkVf
WkRJTlhfT1JfRChjdHgpOw0KKyAgICBSRVFVSVJFX0VWRU4oY3R4LCBhLT5yczEpOw0K
IA0KICAgICBUQ0d2X2k2NCBkZXN0ID0gZGVzdF9mcHIoY3R4LCBhLT5yZCk7DQogICAg
IFRDR3ZfaTY0IHNyYzEgPSBnZXRfZnByX2QoY3R4LCBhLT5yczEpOw==


