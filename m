Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD8CCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jn1-0005PH-Cl; Wed, 24 Sep 2025 03:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmy-0005O8-6q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:44 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmq-0003O5-WE
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XM/Bwlfn1Sl226Bvx3vx+HDk47D8PqIg+tFiODBQbEA=; b=qWfrERk1wZVM4Vp
 fdW5MZdYgUq1ES230Gqqsa/Q320qEAmALmwa++hRPro/ITm9YsN5IYNi8d5EwjANQwDUR8tkrCzPT
 dBCqIH5pDkZzzsWm3sKQccoOJURfkbLJJkM9WqvFOpgz38LxTxHl3KwAqyg6h2W120sNZ55W24l8p
 PU=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 04/34] target/riscv: Fix size of mhartid
Date: Wed, 24 Sep 2025 09:20:54 +0200
Message-ID: <20250924072124.6493-5-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

and update formatting in log.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h         | 2 +-
 target/riscv/cpu_helper.c  | 2 +-
 target/riscv/machine.c     | 2 +-
 target/riscv/tcg/tcg-cpu.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 32e30a36ac..f94f773a84 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -279,7 +279,7 @@ struct CPUArchState {
     target_ulong geilen;
     uint64_t resetvec;
 
-    target_ulong mhartid;
+    uint64_t mhartid;
     /*
      * For RV32 this is 32-bit mstatus and 32-bit mstatush.
      * For RV64 this is a 64-bit mstatus.
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3479a62cc7..9d0683f200 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2278,7 +2278,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                      riscv_cpu_get_trap_name(cause, async));
 
     qemu_log_mask(CPU_LOG_INT,
-                  "%s: hart:"TARGET_FMT_ld", async:%d, cause:"TARGET_FMT_lx", "
+                  "%s: hart:%"PRIu64", async:%d, cause:"TARGET_FMT_lx", "
                   "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=%s\n",
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 438c44dbb0..32cc94858d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -425,7 +425,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.priv, RISCVCPU),
         VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
         VMSTATE_UINT64(env.resetvec, RISCVCPU),
-        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
+        VMSTATE_UINT64(env.mhartid, RISCVCPU),
         VMSTATE_UINT64(env.mstatus, RISCVCPU),
         VMSTATE_UINT64(env.mip, RISCVCPU),
         VMSTATE_UINT64(env.miclaim, RISCVCPU),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb279184..f90abbc594 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -471,7 +471,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
                 continue;
             }
 #ifndef CONFIG_USER_ONLY
-            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
+            warn_report("disabling %s extension for hart 0x%" PRIx64
                         " because privilege spec version does not match",
                         edata->name, env->mhartid);
 #else
-- 
2.51.0


