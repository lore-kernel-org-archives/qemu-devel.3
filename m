Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8D606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTUy5-0004wk-ED; Tue, 17 Nov 2026 21:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xTUy2-0004uk-Ef
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:00:10 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xTUxz-0008EF-FZ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:00:10 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Dxl7WdBv1qjqggAA--.731S3;
 Wed, 18 Nov 2026 09:59:57 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAx3c6bBv1q2Xg1AA--.41804S5;
 Wed, 18 Nov 2026 09:59:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/loongarch: Remove csrrd_cpuid() helper
Date: Wed, 18 Nov 2026 10:01:29 +0800
Message-ID: <20261118020130.2418653-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118020130.2418653-1-maobibo@loongson.cn>
References: <20261118020130.2418653-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c6bBv1q2Xg1AA--.41804S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF13AF1kCF17WF1fJr13Awc_yoW5Gr4fpr
 Wa9rW7KF48GaykA3WSq345tw1UZr4UKa12qan3t34S9a13Xrs2qr40qrnFgF1DJayUWr1F
 q3WFyr18AFWUX3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=
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

CSR_CPUID is initialized to cs->cpu_index at the beginning of
loongarch_cpu_reset_hold(), so it can be read through the generic CSR
read path. No special helper is needed.

HELPER(csrrd_cpuid) is problematic when the vCPU is in guest mode,
whereas the generic path works correctly. Remove the csrrd_cpuid()
helper.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/csr_helper.c                      | 10 ----------
 target/loongarch/tcg/helper.h                          |  1 -
 target/loongarch/tcg/insn_trans/trans_privileged.c.inc |  1 -
 3 files changed, 12 deletions(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 7cba8035df..07b4b25fbd 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -60,16 +60,6 @@ target_ulong HELPER(csrrd_pgd)(CPULoongArchState *env)
     return v;
 }
 
-target_ulong HELPER(csrrd_cpuid)(CPULoongArchState *env)
-{
-    LoongArchCPU *lac = env_archcpu(env);
-    CPUSysState *sys = env_sys(env);
-
-    sys->CSR_CPUID = CPU(lac)->cpu_index;
-
-    return sys->CSR_CPUID;
-}
-
 target_ulong HELPER(csrrd_tval)(CPULoongArchState *env)
 {
     return cpu_loongarch_get_timer_ticks(env_timer(env));
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 7ee655b027..60ebf35d1f 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -96,7 +96,6 @@ DEF_HELPER_1(rdtime_d, i64, env)
 #ifndef CONFIG_USER_ONLY
 /* CSRs helper */
 DEF_HELPER_1(csrrd_pgd, i64, env)
-DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
 DEF_HELPER_1(csrrd_msgir, i64, env)
 DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 6728ce5ec9..7d12e06b35 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -80,7 +80,6 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
     SET_CSR_FUNC(PWCL,  NULL, gen_helper_csrwr_pwcl);
     SET_CSR_FUNC(PWCH,  NULL, gen_helper_csrwr_pwch);
-    SET_CSR_FUNC(CPUID, gen_helper_csrrd_cpuid, NULL);
     SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr_tcfg);
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
     SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
-- 
2.54.0


