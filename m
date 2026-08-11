Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B6C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiB-0005ay-Uy; Tue, 11 Aug 2026 01:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEm-0007mP-MS; Mon, 10 Aug 2026 21:25:04 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEk-0007Z3-Nb; Mon, 10 Aug 2026 21:25:04 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowABXLfHjeXpqxxPZBA--.17429S5;
 Tue, 11 Aug 2026 09:24:51 +0800 (CST)
Message-ID: <e135a60a08ea481889de07ab45d686db@wangyang25.otcaix.iscas.ac.cn>
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
Subject: [PATCH 3/7] target/riscv: use element-sized path for whole-register
 ld/st
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowABXLfHjeXpqxxPZBA--.17429S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4xCw4UXrWxJrWUtr18Krg_yoW8Wr1fpF
 4rGr43KrW3tFy8AayrtF4UXF15Ca95Jw1jgas7twn8ZFs8ArWavF4q9347KFyUJFyjv34Y
 9F12yw45urWUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQ0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
 jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k042
 43AVAKzVAKj4xxMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI
 67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUyyIUUUUUU
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

bGRzdF93aG9sZV90cmFucygpIHRha2VzIGFuIGlubGluZSBUQ0cgcGF0aCB0aGF0IHBl
cmZvcm1zIDgtYnl0ZSBob3N0DQphY2Nlc3NlcyBhbmQgaW5jcmVtZW50cyB2c3RhcnQg
YnkgOCA+PiBsb2cyX2VzeiBhZnRlciBlYWNoIGFjY2Vzcy4gIFdoZW4NCm9uZSBvZiB0
aG9zZSBhY2Nlc3NlcyBmYXVsdHMgYWNyb3NzIGEgcGFnZSBib3VuZGFyeSwgdnN0YXJ0
IGlzIGxlZnQgYXQNCnRoZSBob3N0LWNodW5rIGJvdW5kYXJ5IGluc3RlYWQgb2YgdGhl
IGZhdWx0aW5nIGVsZW1lbnQgaW5kZXgsIGFuZCB3aXRoDQpzbWFsbCBWTEVOIChlLmcu
IFZMRU49MzIpIHRoZSA4LWJ5dGUgYWNjZXNzIGNhbiBhbHNvIHNwaWxsIGludG8gdGhl
DQpuZWlnaGJvdXJpbmcgcmVnaXN0ZXIuICBUaGUgZXhpc3RpbmcgZWxlbWVudC1zaXpl
ZCBoZWxwZXIgcGF0aA0KKHZleHRfbGRzdF93aG9sZSkgcmVwb3J0cyBwcmVjaXNlIHZz
dGFydCBhbmQga2VlcHMgcmVnaXN0ZXIgYm91bmRhcmllcywNCnNvIGFsd2F5cyB1c2Ug
aXQuDQoNClJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3Fl
bXUvLS93b3JrX2l0ZW1zLzQxNTANClNpZ25lZC1vZmYtYnk6IHdhbmd5YW5nIDx3YW5n
eWFuZzI1QG90Y2FpeC5pc2Nhcy5hYy5jbj4NCi0tLQ0KIHRhcmdldC9yaXNjdi90Y2cv
aW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMgfCA4ICsrKysrKystDQogMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYyBiL3Rh
cmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCmluZGV4IDIz
MjYyYjFkMDM2Li45YjlhNzUxZTU4ZSAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi90
Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCisrKyBiL3RhcmdldC9yaXNjdi90
Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCkBAIC0xMTkyLDcgKzExOTIsMTMg
QEAgc3RhdGljIGJvb2wgbGRzdF93aG9sZV90cmFucyh1aW50MzJfdCB2ZCwgdWludDMy
X3QgcnMxLCB1aW50MzJfdCBuZiwNCiAgICAgICogLSB2c3RhcnQgaXMgbm90IDAuDQog
ICAgICAqLw0KIA0KLSAgICBib29sIHVzZV9oZWxwZXJfZm4gPSAhcy0+dnN0YXJ0X2Vx
X3plcm87DQorICAgIC8qDQorICAgICAqIFRoZSBpbmxpbmUgcGF0aCBncm91cHMgYnl0
ZXMgaW50byBob3N0LXNpemVkIGFjY2Vzc2VzLiAgQSBmYXVsdCBpbg0KKyAgICAgKiB0
aGUgbWlkZGxlIG9mIHN1Y2ggYW4gYWNjZXNzIGNhbm5vdCBiZSByZXByZXNlbnRlZCBi
eSB0aGUgcmVzdWx0aW5nDQorICAgICAqIGVsZW1lbnQtaW5kZXggdnN0YXJ0LCBzbyB1
c2UgdGhlIGVsZW1lbnQtc2l6ZWQgaGVscGVyIHBhdGggd2hlbmV2ZXINCisgICAgICog
cHJlY2lzZSByZXN0YXJ0IHN0YXRlIGNhbiBiZSBvYnNlcnZlZC4NCisgICAgICovDQor
ICAgIGJvb2wgdXNlX2hlbHBlcl9mbiA9IHRydWU7DQogDQogICAgIGlmICghdXNlX2hl
bHBlcl9mbikgew0KICAgICAgICAgdWludDMyX3Qgc2l6ZSA9IHMtPmNmZ19wdHItPnZs
ZW5iICogbmY7DQotLSANCjIuNDMuMA0K


