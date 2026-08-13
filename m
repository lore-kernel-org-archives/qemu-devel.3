Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7B0C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSqH-0002rd-Nu; Thu, 13 Aug 2026 06:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqF-0002qw-R2; Thu, 13 Aug 2026 06:39:19 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqC-00014y-Ox; Thu, 13 Aug 2026 06:39:19 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACnrz3Knn1qgUMmBQ--.60519S7;
 Thu, 13 Aug 2026 18:39:06 +0800 (CST)
Message-ID: <b65b32243af243c0b349e0f81a69fabd@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
References: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 13 Aug 2026 18:39:06 +0800
Subject: [PATCH v2 4/4] target/riscv: make cm.mva01s/cm.mvsa01 high-sreg
 forms illegal on RV32E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: rQCowACnrz3Knn1qgUMmBQ--.60519S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uw47ZrWUWw4kGw1DZrW3GFg_yoW8XFyfpr
 4fCryxGryYkrWFy3yrCw17uF13JF4ft3y8Wa13twn09ay5GrZFgF4Fkr43tFs5AFn5Wr4a
 9F4Yy3WUWa1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280
 aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
 AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0E
 x4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67
 k04243AVAKzVAKj4xxMxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
 JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCE
 FcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IUY0iiDUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
bXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80MTEwDQpSZXZpZXdlZC1ieTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KU2lnbmVkLW9m
Zi1ieTogd2FuZ3lhbmcgPHdhbmd5YW5nMjVAb3RjYWl4LmlzY2FzLmFjLmNuPg0KLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19y
dnpjZS5jLmluYyBiL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnpj
ZS5jLmluYw0KaW5kZXggNzFiNGNhNTQ3M2MuLmZlZjUyMmQzOTMyIDEwMDY0NA0KLS0t
IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2emNlLmMuaW5jDQor
KysgYi90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6Y2UuYy5pbmMN
CkBAIC0yNzMsNiArMjczLDEwIEBAIHN0YXRpYyBib29sIHRyYW5zX2NtX212YTAxcyhE
aXNhc0NvbnRleHQgKmN0eCwgYXJnX2NtX212YTAxcyAqYSkNCiB7DQogICAgIFJFUVVJ
UkVfWkNNUChjdHgpOw0KIA0KKyAgICBpZiAoaGFzX2V4dChjdHgsIFJWRSkgJiYgKGEt
PnJzMSA+IDkgfHwgYS0+cnMyID4gOSkpIHsNCisgICAgICAgIHJldHVybiBmYWxzZTsN
CisgICAgfQ0KKw0KICAgICBUQ0d2IHNyYzEgPSBnZXRfZ3ByKGN0eCwgYS0+cnMxLCBF
WFRfTk9ORSk7DQogICAgIFRDR3Ygc3JjMiA9IGdldF9ncHIoY3R4LCBhLT5yczIsIEVY
VF9OT05FKTsNCiANCkBAIC0yODYsNiArMjkwLDEwIEBAIHN0YXRpYyBib29sIHRyYW5z
X2NtX212c2EwMShEaXNhc0NvbnRleHQgKmN0eCwgYXJnX2NtX212c2EwMSAqYSkNCiB7
DQogICAgIFJFUVVJUkVfWkNNUChjdHgpOw0KIA0KKyAgICBpZiAoaGFzX2V4dChjdHgs
IFJWRSkgJiYgKGEtPnJzMSA+IDkgfHwgYS0+cnMyID4gOSkpIHsNCisgICAgICAgIHJl
dHVybiBmYWxzZTsNCisgICAgfQ0KKw0KICAgICBpZiAoYS0+cnMxID09IGEtPnJzMikg
ew0KICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICB9


