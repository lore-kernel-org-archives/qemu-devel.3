Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA760606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTff-0003si-Dp; Thu, 26 Nov 2026 02:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTfa-0003lR-18
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:26 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTfV-0003Ba-9r
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:24 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bx79IN3Adr1yojAA--.34693S3;
 Thu, 26 Nov 2026 15:13:17 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxJs0M3Adrtn03AA--.2429S2;
 Thu, 26 Nov 2026 15:13:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 04/18] target/loongarch: Move field definition of some CSR
 register to cpu-csr.h
Date: Thu, 26 Nov 2026 15:14:26 +0800
Message-ID: <20261126071440.3293877-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxJs0M3Adrtn03AA--.2429S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw13XF4DtFy3Jr1rtrWUtrc_yoW5AF47pr
 43CrWkKryjq3y2k3WrXa98G3W3Xr4xCwsrXay3JrWxtF1UZ340yrZ7tanYgFy5ArZ5Gr18
 ur1rA3yj93W5JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UiVysUUUUU=
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

The field definition of CSR_CRMD/CSR_MSGIS is in file cpu.h, here
move them to file cpu-csr.h, so that all CSR register and field
definition are put together.

There is no function change, and it is only code movement.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h | 16 ++++++++++++++++
 target/loongarch/cpu.h     | 17 -----------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index fd56193888..8ae7f9a4f4 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -14,6 +14,13 @@
 
 /* Basic CSRs */
 #define LOONGARCH_CSR_CRMD           0x0 /* Current mode info */
+FIELD(CSR_CRMD, PLV, 0, 2)
+FIELD(CSR_CRMD, IE, 2, 1)
+FIELD(CSR_CRMD, DA, 3, 1)
+FIELD(CSR_CRMD, PG, 4, 1)
+FIELD(CSR_CRMD, DATF, 5, 2)
+FIELD(CSR_CRMD, DATM, 7, 2)
+FIELD(CSR_CRMD, WE, 9, 1)
 
 #define LOONGARCH_CSR_PRMD           0x1 /* Prev-exception mode info */
 FIELD(CSR_PRMD, PPLV, 0, 2)
@@ -182,8 +189,16 @@ FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
 FIELD(CSR_TLBRPRMD, PWE, 4, 1)
 
+/*Msg interrupt registers */
+#define N_MSGIS                      4
 #define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
+FIELD(CSR_MSGIS, IS, 0, 63)
+
 #define LOONGARCH_CSR_MSGIR               0xa4
+FIELD(CSR_MSGIR, INTNUM, 0, 8)
+FIELD(CSR_MSGIR, ACTIVE, 31, 1)
+
+FIELD(CSR_MSGIE, PT, 0, 8)
 
 /* Direct map windows CSRs*/
 #define LOONGARCH_CSR_DMW(N)         (0x180 + N)
@@ -197,6 +212,7 @@ FIELD(CSR_DMW_32, VSEG, 29, 3)
 FIELD(CSR_DMW_64, VSEG, 60, 4)
 
 /* Performance Counter registers */
+#define MAX_PERF_EVENTS              16
 #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
 #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8dae4e12cf..c770ad2abd 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -226,15 +226,6 @@ FIELD(CPUCFG20, L3IU_WAYS, 0, 16)
 FIELD(CPUCFG20, L3IU_SETS, 16, 8)
 FIELD(CPUCFG20, L3IU_SIZE, 24, 7)
 
-/*CSR_CRMD */
-FIELD(CSR_CRMD, PLV, 0, 2)
-FIELD(CSR_CRMD, IE, 2, 1)
-FIELD(CSR_CRMD, DA, 3, 1)
-FIELD(CSR_CRMD, PG, 4, 1)
-FIELD(CSR_CRMD, DATF, 5, 2)
-FIELD(CSR_CRMD, DATM, 7, 2)
-FIELD(CSR_CRMD, WE, 9, 1)
-
 extern const char * const regnames[32];
 extern const char * const fregnames[32];
 
@@ -243,7 +234,6 @@ extern const char * const fregnames[32];
 #define IRQ_IPI     12
 #define INT_DMSI    14
 
-#define MAX_PERF_EVENTS        16
 #define LOONGARCH_STLB         2048 /* 2048 STLB */
 #define LOONGARCH_MTLB         64   /* 64 MTLB */
 #define LOONGARCH_TLB_MAX      (LOONGARCH_STLB + LOONGARCH_MTLB)
@@ -256,13 +246,6 @@ FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
 
-/*Msg interrupt registers */
-#define N_MSGIS                4
-FIELD(CSR_MSGIS, IS, 0, 63)
-FIELD(CSR_MSGIR, INTNUM, 0, 8)
-FIELD(CSR_MSGIR, ACTIVE, 31, 1)
-FIELD(CSR_MSGIE, PT, 0, 8)
-
 #define LSX_LEN    (128)
 #define LASX_LEN   (256)
 
-- 
2.54.0


