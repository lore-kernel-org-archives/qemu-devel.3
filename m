Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FBEC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzv5-0005Yr-4j; Wed, 15 Jul 2026 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv2-0005XC-4B
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:00 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzuz-0007uM-RT
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:44:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=TZTajLj
 rGR3e6R7acXpAdo9xyMv1zgcxQGVdgqMtQz2KgM1XTxPsbLJ0dXsHDoxI4zwHVo0HS70WU
 GKB42dcOqu9h3rJjJTcmesmRg1dtjnptp1CAV8cBkv3K+RsMKOPtHMyXRetONgkxoLtSiV
 cdcmjDDEYAt1dlUfn9aVFz+fzxGaUJ+cil9SbMQYMM28u5nfzlkacapDx4iAHYkpMzKfeD
 BVakBch6M2PcDdqOUObTqlGhAzHivQvSSheHIS8E08MtncbUt3kWl4NijvF06UZo6XBEiS
 7gajyFX/2+wcQWVrilTyA1cFdUAuC/R8iNn42d5Ao9a59cSZobi4Mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=C
 4NmE7Kk+MtzQaZNwDS9VtzXQS6aXULBpUidEkcaWyU=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=IDIlpEbzEN+zKWBQmuxEOkwr/lSibpmDJMLJpAgoW4ENaCeULIesADUxJbdI8w1otcbt
 rxH4z3QhR6U6+ig9EXduieHLxjNbPMf7GEZUusP1Cug14hNYWKwifqI+aQhPaIiweBjtI2
 A6VMdG3/uhuPHr63ZAOYKzy8R9Owr5BH4JrHH/cI3xAZTmEPukzthsZg6awya1cbALkTxp
 tx5M6v2B1HrLVk/LS9mk9WWrPrzz81jD3Q+6GYk4R4E1xi6rHMWi6PmolbkmHZhnlN+Bn8
 FhGMVxTmLNVzwHxfdQgzdG9ISvFhxKq/KKdWRYB7K14nAvvFwbc/8LCRcW5Fqvuw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=C2tfaxC/; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=bQOEHQm0;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=C4NmE7Kk
 +MtzQaZNwDS9VtzXQS6aXULBpUidEkcaWyU=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=C2tfaxC/6TdhwKRLDioqQEFefS7SV60AduY
 a+jme/L6pnsNyyQ02KP9o4g3WH5Vt13WbJR0h5TyOc0HbA4uYjqb64aM9Jz6e0zVHMhrtV
 115pD8FpJThPWS/MBucaid+RqnQSi0ZEUK02PPzQIR7laxEDd4Z/iRtqBaOCn6+XEMjR/3
 3wOw5FyEzCSX09N5kFo5rz6lMBys9wMcL5L+KvgP8htmwoGg/DgXkp6/kxPPh80rUwj6vk
 IbD8O6BbVwMGUe7iq27tLpC82io0rp9cCEW5NYz2JxYpt4tklSkhFiF0kMxcKZcg6gbcWT
 wzYcMPSVPAKhWGjRQXeMBgZdGuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=C4NmE7Kk+MtzQaZNwDS9VtzXQS6aXULBpUidEkcaWyU=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=bQOEHQm0UZs7CaFV4x
 psYk6I6fVvGW5nhwBjYkUyp7oHbx5lDcR/Z1uKbEwUDfOPtdhu9BHdp9ARlFPXqqKSDg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 4337c747
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:50 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 71268d47;
 Wed, 15 Jul 2026 15:44:48 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 04/25] target/mips: add Octeon CP0 register state
Date: Wed, 15 Jul 2026 15:43:50 +0200
Message-ID: <20260715134447.56007-5-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Octeon firmware and kernels use implementation specific CP0 registers
for the cycle counter and local memory control.

Add CvmCount, CvmCtl, and CvmMemCtl accessors for Octeon CPUs; migrate
the new CP0 state, and translate the enabled CVMSEG virtual window to
per vCPU backing memory.
---
 target/mips/cpu.h                   |  5 +++
 target/mips/system/machine.c        | 13 +++++++
 target/mips/system/physaddr.c       | 22 +++++++++++
 target/mips/tcg/op_helper.c         |  2 +-
 target/mips/tcg/system/cp0_helper.c | 10 +++++
 target/mips/tcg/system_helper.h.inc |  1 +
 target/mips/tcg/translate.c         | 60 +++++++++++++++++++++++++++++
 7 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 319147a948..c6da52e17f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -341,6 +341,8 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG09__COUNT           0
 #define CP0_REG09__SAARI           6
 #define CP0_REG09__SAAR            7
+#define CP0_REG09__CVMCOUNT        6
+#define CP0_REG09__CVMCTL          7
 /* CP0 Register 10 */
 #define CP0_REG10__ENTRYHI         0
 #define CP0_REG10__GUESTCTL1       4
@@ -349,6 +351,7 @@ typedef struct mips_def_t mips_def_t;
 /* CP0 Register 11 */
 #define CP0_REG11__COMPARE         0
 #define CP0_REG11__GUESTCTL0EXT    4
+#define CP0_REG11__CVMMEMCTL       7
 /* CP0 Register 12 */
 #define CP0_REG12__STATUS          0
 #define CP0_REG12__INTCTL          1
@@ -787,6 +790,7 @@ typedef struct CPUArchState {
  * CP0 Register 9
  */
     int32_t CP0_Count;
+    target_ulong CP0_CvmCtl;
 #define CP0SAARI_TARGET 0    /*  5..0  */
 #define CP0SAAR_BASE    12   /* 43..12 */
 #define CP0SAAR_SIZE    1    /*  5..1  */
@@ -801,6 +805,7 @@ typedef struct CPUArchState {
  * CP0 Register 11
  */
     int32_t CP0_Compare;
+    target_ulong CP0_CvmMemCtl;
 /*
  * CP0 Register 12
  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index bd1e4002cf..3661da0566 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -372,6 +372,18 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
     }
 };
 
+static const VMStateDescription mips_vmstate_octeon_cp0 = {
+    .name = "cpu/octeon_cp0",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.CP0_CvmCtl, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_CvmMemCtl, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -490,6 +502,7 @@ const VMStateDescription vmstate_mips_cpu = {
         &mips_vmstate_timer,
         &mips_vmstate_octeon_multiplier,
         &mips_vmstate_octeon_crypto,
+        &mips_vmstate_octeon_cp0,
         NULL
     }
 };
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 626d7ccc4c..a0538d8b6b 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -21,6 +21,14 @@
 #include "exec/page-protection.h"
 #include "../internal.h"
 
+/*
+ * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
+ * the guest sees the virtual CVMSEG window, not this physical address.
+ */
+#define OCTEON_CVMSEG_BASE 0x10000000000ULL
+#define OCTEON_CVMSEG_SIZE 0x4000ULL
+#define OCTEON_CVMSEG_MASK 0x3fffULL
+
 static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
 {
     /*
@@ -128,6 +136,20 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
     int ret = TLBRET_MATCH;
     target_ulong address = real_address;
 
+#if defined(TARGET_MIPS64)
+    if ((env->insn_flags & INSN_OCTEON) && (env->CP0_CvmMemCtl & 0x100) &&
+        address >= 0xffffffffffff8000ULL &&
+        address <= 0xffffffffffffbfffULL) {
+        MIPSCPU *cpu = env_archcpu(env);
+
+        *physical = OCTEON_CVMSEG_BASE +
+                    CPU(cpu)->cpu_index * OCTEON_CVMSEG_SIZE +
+                    (address & OCTEON_CVMSEG_MASK);
+        *prot = PAGE_READ | PAGE_WRITE;
+        return TLBRET_MATCH;
+    }
+#endif
+
     if (address <= USEG_LIMIT) {
         /* useg */
         uint16_t segctl;
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index df1b5c3734..2bfe661ef2 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -268,7 +268,7 @@ target_ulong helper_rdhwr_cvmcount(CPUMIPSState *env)
 #ifdef CONFIG_USER_ONLY
     return cpu_get_host_ticks();
 #else
-    return (uint32_t)cpu_mips_get_count(env);
+    return helper_mfc0_cvmcount(env);
 #endif
 }
 
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index ba6b487b75..1c23d2a525 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -23,6 +23,8 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/timer.h"
+#include "hw/core/clock.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
@@ -374,6 +376,14 @@ target_ulong helper_mfc0_count(CPUMIPSState *env)
     return (int32_t)cpu_mips_get_count(env);
 }
 
+target_ulong helper_mfc0_cvmcount(CPUMIPSState *env)
+{
+    MIPSCPU *cpu = env_archcpu(env);
+
+    return clock_ns_to_ticks(cpu->clock,
+                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+}
+
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
diff --git a/target/mips/tcg/system_helper.h.inc b/target/mips/tcg/system_helper.h.inc
index eaac5e2c6f..c8b6d8b92c 100644
--- a/target/mips/tcg/system_helper.h.inc
+++ b/target/mips/tcg/system_helper.h.inc
@@ -31,6 +31,7 @@ DEF_HELPER_1(mftc0_tcschedule, tl, env)
 DEF_HELPER_1(mfc0_tcschefback, tl, env)
 DEF_HELPER_1(mftc0_tcschefback, tl, env)
 DEF_HELPER_1(mfc0_count, tl, env)
+DEF_HELPER_1(mfc0_cvmcount, tl, env)
 DEF_HELPER_1(mftc0_entryhi, tl, env)
 DEF_HELPER_1(mftc0_status, tl, env)
 DEF_HELPER_1(mftc0_cause, tl, env)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e3467d1525..123ba6aecd 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -5460,6 +5460,19 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
+        case CP0_REG09__CVMCOUNT:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            translator_io_start(&ctx->base);
+            gen_helper_mfc0_cvmcount(arg, tcg_env);
+            tcg_gen_ext32s_tl(arg, arg);
+            register_name = "CvmCount";
+            break;
+        case CP0_REG09__CVMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_ld_tl(arg, tcg_env, offsetof(CPUMIPSState, CP0_CvmCtl));
+            tcg_gen_ext32s_tl(arg, arg);
+            register_name = "CvmCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -5481,6 +5494,13 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
             register_name = "Compare";
             break;
+        case CP0_REG11__CVMMEMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_ld_tl(arg, tcg_env,
+                          offsetof(CPUMIPSState, CP0_CvmMemCtl));
+            tcg_gen_ext32s_tl(arg, arg);
+            register_name = "CvmMemCtl";
+            break;
         /* 6,7 are implementation dependent */
         default:
             goto cp0_unimplemented;
@@ -6176,6 +6196,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(tcg_env, arg);
             register_name = "Count";
             break;
+        case CP0_REG09__CVMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_st_tl(arg, tcg_env, offsetof(CPUMIPSState, CP0_CvmCtl));
+            register_name = "CvmCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6196,6 +6221,13 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_compare(tcg_env, arg);
             register_name = "Compare";
             break;
+        case CP0_REG11__CVMMEMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_st_tl(arg, tcg_env,
+                          offsetof(CPUMIPSState, CP0_CvmMemCtl));
+            ctx->base.is_jmp = DISAS_STOP;
+            register_name = "CvmMemCtl";
+            break;
         /* 6,7 are implementation dependent */
         default:
             goto cp0_unimplemented;
@@ -6940,6 +6972,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
+        case CP0_REG09__CVMCOUNT:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            translator_io_start(&ctx->base);
+            gen_helper_mfc0_cvmcount(arg, tcg_env);
+            register_name = "CvmCount";
+            break;
+        case CP0_REG09__CVMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_ld_tl(arg, tcg_env, offsetof(CPUMIPSState, CP0_CvmCtl));
+            register_name = "CvmCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6960,6 +7003,12 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
             register_name = "Compare";
             break;
+        case CP0_REG11__CVMMEMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_ld_tl(arg, tcg_env,
+                          offsetof(CPUMIPSState, CP0_CvmMemCtl));
+            register_name = "CvmMemCtl";
+            break;
         /* 6,7 are implementation dependent */
         default:
             goto cp0_unimplemented;
@@ -7642,6 +7691,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(tcg_env, arg);
             register_name = "Count";
             break;
+        case CP0_REG09__CVMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_st_tl(arg, tcg_env, offsetof(CPUMIPSState, CP0_CvmCtl));
+            register_name = "CvmCtl";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7664,6 +7718,12 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_compare(tcg_env, arg);
             register_name = "Compare";
             break;
+        case CP0_REG11__CVMMEMCTL:
+            CP0_CHECK(ctx->insn_flags & INSN_OCTEON);
+            tcg_gen_st_tl(arg, tcg_env,
+                          offsetof(CPUMIPSState, CP0_CvmMemCtl));
+            register_name = "CvmMemCtl";
+            break;
         /* 6,7 are implementation dependent */
         default:
             goto cp0_unimplemented;
-- 
2.54.0


