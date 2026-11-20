Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4B606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUDLB-0007Ft-8O; Thu, 19 Nov 2026 20:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xUDL7-0006w7-1R
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:22:57 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xUDL4-0007U7-Kw
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:22:56 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxpvDioP9qHmIhAA--.30204S3;
 Fri, 20 Nov 2026 09:22:42 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxpMzhoP9qvQs2AA--.15906S2;
 Fri, 20 Nov 2026 09:22:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/16] target/loongarch: Define some csrwr helper functions
 static
Date: Fri, 20 Nov 2026 09:23:56 +0800
Message-ID: <20261120012356.2656317-17-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120012356.2656317-1-maobibo@loongson.cn>
References: <20261120012356.2656317-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMzhoP9qvQs2AA--.15906S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFWfZF43ZF4rCrW7WF17urX_yoWrKryxpF
 W2kry7ZFW8KFWSv3WfGasxKr1DZr17G3yfZF4Iy34Ika1UJrykJryUAw4IyFyDJ3y5Wr1f
 taykZw18ZrW3XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsdb1UUUUU
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

The csrwr_xxx helper funtions are called by generic csrwr helper.
Here define csrwr_xxx helper funtions as static and remove prefix
HELPER.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/csr_helper.c | 28 ++++++++++++++--------------
 target/loongarch/tcg/helper.h     |  7 -------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 4ea4b9b0f8..4040f587c1 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -19,7 +19,7 @@
 #include "cpu-mmu.h"
 #include "csr.h"
 
-target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env, target_ulong val)
+static target_ulong csrwr_stlbps(CPULoongArchState *env, target_ulong val)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_STLBPS;
@@ -88,7 +88,7 @@ target_ulong HELPER(csrrd_msgir)(CPULoongArchState *env)
     return irq;
 }
 
-target_ulong HELPER(csrwr_estat)(CPULoongArchState *env, target_ulong val)
+static target_ulong csrwr_estat(CPULoongArchState *env, target_ulong val)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_ESTAT;
@@ -109,7 +109,7 @@ target_ulong HELPER(csrwr_estat)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_asid)(CPULoongArchState *env, target_ulong val)
+static target_ulong csrwr_asid(CPULoongArchState *env, target_ulong val)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_ASID;
@@ -122,7 +122,7 @@ target_ulong HELPER(csrwr_asid)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env, target_ulong val)
+static target_ulong csrwr_tcfg(CPULoongArchState *env, target_ulong val)
 {
     CPUTimerState *timer = env_timer(env);
     CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
@@ -133,7 +133,7 @@ target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_ticlr)(CPULoongArchState *env, target_ulong val)
+static target_ulong csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 {
     CPUTimerState *timer = env_timer(env);
     int64_t old_v = 0;
@@ -146,7 +146,7 @@ target_ulong HELPER(csrwr_ticlr)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env, target_ulong val)
+static target_ulong csrwr_pwcl(CPULoongArchState *env, target_ulong val)
 {
     uint8_t shift, ptbase;
     CPUSysState *sys = env_sys(env);
@@ -171,7 +171,7 @@ target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env, target_ulong val)
+static target_ulong csrwr_pwch(CPULoongArchState *env, target_ulong val)
 {
     uint8_t has_ptw;
     CPUSysState *sys = env_sys(env);
@@ -195,25 +195,25 @@ target_ulong HELPER(csrwr)(CPULoongArchState *env, target_ulong val,
 
     switch (csr) {
     case LOONGARCH_CSR_STLBPS:
-        return HELPER(csrwr_stlbps)(env, val);
+        return csrwr_stlbps(env, val);
 
     case LOONGARCH_CSR_ESTAT:
-        return HELPER(csrwr_estat)(env, val);
+        return csrwr_estat(env, val);
 
     case LOONGARCH_CSR_ASID:
-        return HELPER(csrwr_asid)(env, val);
+        return csrwr_asid(env, val);
 
     case LOONGARCH_CSR_TCFG:
-        return HELPER(csrwr_tcfg)(env, val);
+        return csrwr_tcfg(env, val);
 
     case LOONGARCH_CSR_TICLR:
-        return HELPER(csrwr_ticlr)(env, val);
+        return csrwr_ticlr(env, val);
 
     case LOONGARCH_CSR_PWCL:
-        return HELPER(csrwr_pwcl)(env, val);
+        return csrwr_pwcl(env, val);
 
     case LOONGARCH_CSR_PWCH:
-        return HELPER(csrwr_pwch)(env, val);
+        return csrwr_pwch(env, val);
 
     default:
         csrinfo = get_csr(csr);
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 719fa8b86a..8138778cc6 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -98,13 +98,6 @@ DEF_HELPER_1(rdtime_d, i64, env)
 DEF_HELPER_1(csrrd_pgd, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
 DEF_HELPER_1(csrrd_msgir, i64, env)
-DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
-DEF_HELPER_2(csrwr_estat, i64, env, tl)
-DEF_HELPER_2(csrwr_asid, i64, env, tl)
-DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
-DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
-DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
-DEF_HELPER_2(csrwr_pwch, i64, env, tl)
 DEF_HELPER_3(csrwr, i64, env, tl, i32)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
 DEF_HELPER_2(iocsrrd_h, i64, env, tl)
-- 
2.54.0


