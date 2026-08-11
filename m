Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836D7C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiE-0005d2-Ab; Tue, 11 Aug 2026 01:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb54-0006YP-2J; Mon, 10 Aug 2026 21:15:02 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtb51-0006Y5-54; Mon, 10 Aug 2026 21:15:01 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowAA3Cu6Gd3pq5bPYBA--.22594S6;
 Tue, 11 Aug 2026 09:14:48 +0800 (CST)
Message-ID: <506ceee00a6b4199b3efd87352bbe530@wangyang25.otcaix.iscas.ac.cn>
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
Date: 11 Aug 2026 09:14:49 +0800
Subject: [PATCH 4/4] target/riscv: make cm.mva01s/cm.mvsa01 high-sreg forms
 illegal on RV32E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowAA3Cu6Gd3pq5bPYBA--.22594S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw47ZrWUWw4kGw1DZrW3GFg_yoW8Xr47pr
 4fCryxGrZ0kayFy3yFyw47uF15JF4ft3yrWa13twn09ay5GrZ2qr4Fkr43tF4rZFn5Wr4S
 9F4Yy3WUu3yvqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQ0b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
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
 67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUsl1vDUUUU
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

VGhlIFpjbXAgcHNldWRvY29kZSBtYXJrcyBjbS5tdmEwMXMvY20ubXZzYTAxIGFzIHJl
c2VydmVkIG9uIFJWMzJFDQp3aGVuIGVpdGhlciBjb21wcmVzc2VkIHNhdmVkLXJlZ2lz
dGVyIHNlbGVjdG9yIGlzIGFib3ZlIHMxLCBidXQgdGhlDQp0cmFuc2xhdG9ycyBvbmx5
IGNoZWNrZWQgUkVRVUlSRV9aQ01QLiAgU2luY2UgJXIxcy8lcjJzIG1hcCB0aGUNCnNl
bGVjdG9ycyB0byByZWdpc3RlciBudW1iZXJzICh4OC94OSBmb3IgczAvczEsIHgxOC4u
eDIzIGZvcg0KczIuLnM3KSwgYWRkIGEgZ2F0ZSB0aGF0IHJldHVybnMgZmFsc2Ugd2hl
biBSVkUgaXMgZW5hYmxlZCBhbmQNCmVpdGhlciBvcGVyYW5kIGV4Y2VlZHMgeDksIHNv
IHRoZSBoaWdoLXNyZWcgZm9ybXMgcmFpc2UgYW4NCmlsbGVnYWwtaW5zdHJ1Y3Rpb24g
ZXhjZXB0aW9uIHdoaWxlIHRoZSBzMC9zMSBmb3JtcyBhbmQgYWxsIFJWMzJJDQpmb3Jt
cyBrZWVwIHJldGlyaW5nLg0KDQpSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3Fl
bXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80MTEwDQpTaWduZWQtb2ZmLWJ5OiB3
YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXguaXNjYXMuYWMuY24+DQotLS0NCiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2emNlLmMu
aW5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2emNlLmMuaW5j
DQppbmRleCA3MWI0Y2E1NDczYy4uZmVmNTIyZDM5MzIgMTAwNjQ0DQotLS0gYS90YXJn
ZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6Y2UuYy5pbmMNCisrKyBiL3Rh
cmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnpjZS5jLmluYw0KQEAgLTI3
Myw2ICsyNzMsMTAgQEAgc3RhdGljIGJvb2wgdHJhbnNfY21fbXZhMDFzKERpc2FzQ29u
dGV4dCAqY3R4LCBhcmdfY21fbXZhMDFzICphKQ0KIHsNCiAgICAgUkVRVUlSRV9aQ01Q
KGN0eCk7DQogDQorICAgIGlmIChoYXNfZXh0KGN0eCwgUlZFKSAmJiAoYS0+cnMxID4g
OSB8fCBhLT5yczIgPiA5KSkgew0KKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9
DQorDQogICAgIFRDR3Ygc3JjMSA9IGdldF9ncHIoY3R4LCBhLT5yczEsIEVYVF9OT05F
KTsNCiAgICAgVENHdiBzcmMyID0gZ2V0X2dwcihjdHgsIGEtPnJzMiwgRVhUX05PTkUp
Ow0KIA0KQEAgLTI4Niw2ICsyOTAsMTAgQEAgc3RhdGljIGJvb2wgdHJhbnNfY21fbXZz
YTAxKERpc2FzQ29udGV4dCAqY3R4LCBhcmdfY21fbXZzYTAxICphKQ0KIHsNCiAgICAg
UkVRVUlSRV9aQ01QKGN0eCk7DQogDQorICAgIGlmIChoYXNfZXh0KGN0eCwgUlZFKSAm
JiAoYS0+cnMxID4gOSB8fCBhLT5yczIgPiA5KSkgew0KKyAgICAgICAgcmV0dXJuIGZh
bHNlOw0KKyAgICB9DQorDQogICAgIGlmIChhLT5yczEgPT0gYS0+cnMyKSB7DQogICAg
ICAgICByZXR1cm4gZmFsc2U7DQogICAgIH0=


