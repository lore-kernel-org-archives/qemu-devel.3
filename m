Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A580606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTfd-0003pi-QZ; Thu, 26 Nov 2026 02:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTfa-0003lT-1h
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:26 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTfV-0003BT-9U
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:24 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Cx+9EK3Adr1SojAA--.34231S3;
 Thu, 26 Nov 2026 15:13:14 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxg8wA3AdrsX03AA--.16771S5;
 Thu, 26 Nov 2026 15:13:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 03/18] target/loongarch: Remove some unused CSR registers
Date: Thu, 26 Nov 2026 15:14:25 +0800
Message-ID: <20261126071440.3293877-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxg8wA3AdrsX03AA--.16771S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGrW5uw15Wr47Ww4UCr4rZwc_yoW5GrWkpr
 W7urWkKFW8JFZrK3WrXa4Y9wnxWr4xG3y2va1fC397KFs8X3yUXF18tas0gFy5JayrJry0
 9FnYyw4IvF4xXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=
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

CSR_CTAG is for cache emulation and CSR_MERR is for Machine Error
purpose. Now QEMU does not support these features and remove them
for the present.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h | 11 -----------
 target/loongarch/cpu.c     |  1 -
 target/loongarch/csr.c     |  1 -
 target/loongarch/disas.c   |  1 -
 4 files changed, 14 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 7830573601..fd56193888 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -182,17 +182,6 @@ FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
 FIELD(CSR_TLBRPRMD, PWE, 4, 1)
 
-/* Machine Error CSRs */
-#define LOONGARCH_CSR_MERRCTL        0x90 /* ERRCTL */
-FIELD(CSR_MERRCTL, ISMERR, 0, 1)
-#define LOONGARCH_CSR_MERRINFO1      0x91
-#define LOONGARCH_CSR_MERRINFO2      0x92
-#define LOONGARCH_CSR_MERRENTRY      0x93 /* MError exception base */
-#define LOONGARCH_CSR_MERRERA        0x94 /* MError exception PC */
-#define LOONGARCH_CSR_MERRSAVE       0x95 /* KScratch for error exception */
-
-#define LOONGARCH_CSR_CTAG           0x98 /* TagLo + TagHi */
-
 #define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
 #define LOONGARCH_CSR_MSGIR               0xa4
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 83664a7c7d..020eb88f49 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -148,7 +148,6 @@ static void loongarch_la464_init_csr(DeviceState *dev)
         }
         set_csr_flag(LOONGARCH_CSR_IMPCTL1, CSRFL_UNUSED);
         set_csr_flag(LOONGARCH_CSR_IMPCTL2, CSRFL_UNUSED);
-        set_csr_flag(LOONGARCH_CSR_CTAG, CSRFL_UNUSED);
 
         for (i = env->perf_event_num; i < MAX_PERF_EVENTS; i++) {
             set_csr_flag(LOONGARCH_CSR_PERFCTRL(i), CSRFL_UNUSED);
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 89b4240fe5..987c31b69c 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -81,7 +81,6 @@ static CSRInfo csr_info[] = {
     CSR_OFF(TLBRELO1),
     CSR_OFF(TLBREHI),
     CSR_OFF(TLBRPRMD),
-    CSR_OFF(CTAG),
     CSR_OFF_ARRAY(DMW, 0),
     CSR_OFF_ARRAY(DMW, 1),
     CSR_OFF_ARRAY(DMW, 2),
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 42ee106df0..84b8e3514d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -98,7 +98,6 @@ static const char * const csr_names[] = {
     CSR_NAME(TLBRELO1),
     CSR_NAME(TLBREHI),
     CSR_NAME(TLBRPRMD),
-    CSR_NAME(CTAG),
     CSR_NAME(DMW(0)),
     CSR_NAME(DMW(1)),
     CSR_NAME(DMW(2)),
-- 
2.54.0


