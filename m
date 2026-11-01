Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE5606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=BKZGwJCD;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=nrT83usx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWZ5-0000xV-8T; Sun, 01 Nov 2026 09:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX6-0006aV-2D
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:41 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX2-000849-J6
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=wbxbPWF
 mE1FPjMXZamJQOfK99u+nYiKlVuyYWmW01Sr2Bx2X6XOMR704vJD7+nOAiE0tn1jmgdylX
 AZJotwFqFBd9FoU38UVfiikLcOERH49QHjISUrr/kFlIo1PmE9bK3h8zl3uUdyUChtAcoc
 qy3b68+BzBwfCMEKzSzaJh3e1k29Wk7JLSW4fOUQEUn21x+uZ8NeI99hsZ0SaO6ruV6XZ1
 hpB01jvsgjLjHhHNd0wIJu0lNHHCgMMAb1WG7PwG91zzpw2wIY/Ccik/f9hmrfEANpx5vt
 jOPMDIFP9iFOpMjCrzAaS0bo4qbUBuovsfBUjv7BAzIhmC4yEdF59vg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=T
 raLkADbJ9o373x/k0ZOfQ5MMhBKBfESCo6n8IncZsI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Eafp+59rUucZvTPj7uulXxAiTuwBRDU0IErp9/e2lLlZ6Bo+GBQe9SrV8bpVXwVCHeuv
 lWHnKAnn5p6aFwgQ9nEkbZIhmKH/tv48BoSM7N+Pz8uCuIcZk//pKU/JvGT1suMCBTr84l
 pgefZq9+lOFfTNah+yeJpelwQ8VFKUrRcZ9FO5ZJKfQUtnaneX0emMbJA25/GnFifMrEnW
 KZOwKI4Rdcs6jcPiixPXR0lw/59GxpOcZd1kJZunf4hN5PPZHBlPpdOtdglYImqg8aNE3/
 yNHp+tAvpNwGjf86bEhaZnzrpVmZFqG/n7l2UvbA8wQSIAU0fk11JbjoP856ZF2Q==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=BKZGwJCD; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=nrT83usx;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=TraLkADb
 J9o373x/k0ZOfQ5MMhBKBfESCo6n8IncZsI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=BKZGwJCD1hSJdLHD/IMHCqS7JauRMY5K5KG
 58n1DWUfAluklmoODPvHzAtlN+gmFDq7/oZ8fqagOo7Sd5tI9JvHActlOdeuviYKcLWEbQ
 cilthIpKEd2r6vXHLaVymffDlg3YcE1EFLRQuzwBzKg5cm1ScIJxtgrfC+3LenxQlHYurv
 cLorSlVK4R1DofBLkQu5NdekfH/QCnbC+FwuacT9+Hkxn44QBHZy3Ntfl2vhUAoivAe1YS
 KAHr69VD3Ol0a39BMs6+vz9uSmU1EyfNEHHEShbQnTCI5RO/NJizAB2EczfxiXv6T/oQHz
 5k7IsUwuRTucvSS+C67Ct+jqg6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=TraLkADbJ9o373x/k0ZOfQ5MMhBKBfESCo6n8IncZsI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=nrT83usxvqqvFI7cDu
 RYg406eqZdxzIL+XQFE4cQl9W33N3oquwr3FzV89lNpqyi91zjZRfFbJpM5O1uwX3SCQ==
Received: by mx2.catap.net (OpenSMTPD) id 3f2eac50;
 Sun, 1 Nov 2026 15:27:34 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 763c7c7f;
 Sun, 1 Nov 2026 15:27:30 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 04/26] target/mips: add Octeon CP0 register state
Date: Sun,  1 Nov 2026 15:23:20 +0100
Message-ID: <20261101142723.41346-5-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Octeon firmware and kernels use implementation specific CP0 registers
for the cycle counter and local memory control.

Add CvmCount, CvmCtl, and CvmMemCtl accessors for Octeon CPUs; migrate
the new CP0 state, and translate the enabled CVMSEG virtual window to
per vCPU backing memory.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
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
index b080c5de4d..0e7fd7cafe 100644
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
index 69968022cd..76316f2be7 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -22,6 +22,14 @@
 #include "exec/target_page.h"
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
@@ -129,6 +137,20 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
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
index c3f0c05bc3..ddd812fa81 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -268,7 +268,7 @@ target_ulong HELPER(rdhwr_cvmcount)(CPUMIPSState *env)
 #ifdef CONFIG_USER_ONLY
     return cpu_get_host_ticks();
 #else
-    return (uint32_t)cpu_mips_get_count(env);
+    return helper_mfc0_cvmcount(env);
 #endif
 }
 
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index ceffcc3732..33fb7365d7 100644
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
@@ -374,6 +376,14 @@ target_ulong HELPER(mfc0_count)(CPUMIPSState *env)
     return (int32_t)cpu_mips_get_count(env);
 }
 
+target_ulong HELPER(mfc0_cvmcount)(CPUMIPSState *env)
+{
+    MIPSCPU *cpu = env_archcpu(env);
+
+    return clock_ns_to_ticks(cpu->clock,
+                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+}
+
 target_ulong HELPER(mftc0_entryhi)(CPUMIPSState *env)
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
index 936f8c4edd..7996f35baa 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -5461,6 +5461,19 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -5482,6 +5495,13 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -6177,6 +6197,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -6197,6 +6222,13 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -6941,6 +6973,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -6961,6 +7004,12 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7643,6 +7692,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7665,6 +7719,12 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
2.56.0


