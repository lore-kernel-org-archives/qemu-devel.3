Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3706606A336
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTg6-00043s-Fv; Thu, 26 Nov 2026 02:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTfx-000404-0A
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:51 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTfu-0003DT-Se
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:48 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxX9Me3Adr8iojAA--.34172S3;
 Thu, 26 Nov 2026 15:13:34 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAx3c4c3AdrvX03AA--.44576S3;
 Thu, 26 Nov 2026 15:13:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 13/18] target/loongarch: Add reserved fields to CSR_MISC
Date: Thu, 26 Nov 2026 15:14:35 +0800
Message-ID: <20261126071440.3293877-14-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c4c3AdrvX03AA--.44576S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWUJw4kWFyxKFyrtr15ZFc_yoW8KrW5pr
 ZrurykK3ykWa9xCas5Xa98t3ZxXF47Gws2gayfJryxtr43XryIvFWvyw1qgFyUJ3yrGr1r
 ZF1rAFy5CaySqacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According to the manual, bits 4 and 8 of CSR_MISC are reserved and
read-only. They conflict with fields DRDTL and RPCNTL. Add fields RSV
and RSV1 to the CSR_MISC register so the reserved bits are represented
correctly and excluded from the CSR write mask.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h       | 8 +++++---
 target/loongarch/cpu.h           | 2 +-
 target/loongarch/tcg/op_helper.c | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 3dff6395b1..3e76546867 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -40,9 +40,11 @@ FIELD(CSR_EUEN, BTE, 3, 1)
 CSR_WRMASK(EUEN, 0, 4)
 
 #define LOONGARCH_CSR_MISC           0x3 /* Misc config */
-FIELD(CSR_MISC, VA32, 0, 4)
-FIELD(CSR_MISC, DRDTL, 4, 4)
-FIELD(CSR_MISC, RPCNTL, 8, 4)
+FIELD(CSR_MISC, VA32, 1, 3)
+FIELD(CSR_MISC, RSV, 4, 1)
+FIELD(CSR_MISC, DRDTL, 5, 3)
+FIELD(CSR_MISC, RSV1, 8, 1)
+FIELD(CSR_MISC, RPCNTL, 9, 3)
 FIELD(CSR_MISC, ALCL, 12, 4)
 FIELD(CSR_MISC, DWPL, 16, 3)
 CSR_WRMASK(MISC, 1, 18)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c770ad2abd..bd7441b8d8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -519,7 +519,7 @@ static inline bool is_va32(CPULoongArchState *env)
     bool va32 = !is_la64(env);
     CPUSysState *sys = env_sys(env);
     uint64_t plv = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
-    if (plv >= 1 && (FIELD_EX64(sys->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
+    if (plv >= 1 && FIELD_EX64(sys->CSR_MISC, CSR_MISC, VA32) & BIT(plv - 1)) {
         va32 = true;
     }
     return va32;
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index f8a91bed5d..8f972d0c50 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -97,7 +97,8 @@ uint64_t HELPER(rdtime_d)(CPULoongArchState *env)
     CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
 
     plv = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
-    if (extract64(sys->CSR_MISC, R_CSR_MISC_DRDTL_SHIFT + plv, 1)) {
+    if (plv >= 1 &&
+        extract64(sys->CSR_MISC, R_CSR_MISC_DRDTL_SHIFT + plv - 1, 1)) {
         do_raise_exception(env, EXCCODE_IPE, GETPC());
     }
 
-- 
2.54.0


