Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCF6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgf3-0004oD-Ub; Wed, 20 May 2026 09:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgf1-0004lg-Jx; Wed, 20 May 2026 09:08:31 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgez-00014Q-Vy; Wed, 20 May 2026 09:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=YeO8kilKBqm6uFA065zmaxbEvX+hUUiA+JHTmJIafRQ=; b=V8BY3oCuy4Y5Dei
 q4vS7lVT1ZrYnOhafLbLXw2HDdw3Bcpo+4sxRyEX+txMSaOWI759dan04E3ZGm8FIivoo3llkOY6M
 wangIAQR6d7o0vc1wY3lc/yItHbdzRrvq2eFjhn8VgHReuzEUTHNfYEZwv2IiXsrizOj1SdVZQkDW
 YU=;
Date: Wed, 20 May 2026 15:13:00 +0200
Subject: [PATCH v3 08/14] target/riscv: Remove ifdefs in cpu.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-8-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=3280;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=QrxpqMnDo2J81ZPudJyrgp1ZyZwaRixwpojN0+zzb/E=;
 b=NdNjyy7KVqZUIeirIeuyJCZKuM0XiwUQbYJi+uFT77EYBreoL+vFQd5L7yuFRmynx635KMaiS
 zAobOEhRmaXB9gACJAMtFQCEDlCO9dCRUK6twvyrwND389J8hq2QIiZ
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

KVM fields of CPURISCVState are now always exposed as CONFIG_KVM cannot
be used in common code.

riscv_cpu_mxl() is changed to return CPURISCVState::misa_mxl
unconditionally, as use of target_riscv64() would result in an extra
load and compare with TargetInfo::target_arch.  We might as well just
perform a single load.  Likewise, for cpu_recompute_xl(),
cpu_address_xl(), and riscv_cpu_sxl(), we opt for returning the
corresponding CPURISCVState field with ifdefs for system mode adding
extra conditions.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f521686c43..5dc76f07bf 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -493,14 +493,12 @@ struct CPUArchState {
     hwaddr kernel_addr;
     hwaddr fdt_addr;
 
-#ifdef CONFIG_KVM
     /* kvm timer */
     bool kvm_timer_dirty;
     uint64_t kvm_timer_time;
     uint64_t kvm_timer_compare;
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
-#endif /* CONFIG_KVM */
 
     /* RNMI */
     uint64_t mnscratch;
@@ -706,14 +704,10 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
 
-#ifdef TARGET_RISCV32
-#define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
 {
     return env->misa_mxl;
 }
-#endif
 #define riscv_cpu_mxl_bits(env) (1UL << (4 + riscv_cpu_mxl(env)))
 
 static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
@@ -757,9 +751,6 @@ static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 }
 #endif
 
-#if defined(TARGET_RISCV32)
-#define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -768,43 +759,32 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
     return env->misa_mxl;
 #endif
 }
-#endif
 
-#if defined(TARGET_RISCV32)
-#define cpu_address_xl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 {
-#ifdef CONFIG_USER_ONLY
-    return env->xl;
-#else
-    privilege_mode_t mode = cpu_address_mode(env);
-
-    return cpu_get_xl(env, mode);
+#ifndef CONFIG_USER_ONLY
+    if (target_riscv64()) {
+        privilege_mode_t mode = cpu_address_mode(env);
+        return cpu_get_xl(env, mode);
+    }
 #endif
+    return env->xl;
 }
-#endif
 
 static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
 {
     return 16 << env->xl;
 }
 
-#ifdef TARGET_RISCV32
-#define riscv_cpu_sxl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 {
-#ifdef CONFIG_USER_ONLY
-    return env->misa_mxl;
-#else
+#ifndef CONFIG_USER_ONLY
     if (env->misa_mxl != MXL_RV32) {
         return get_field(env->mstatus, MSTATUS64_SXL);
     }
 #endif
-    return MXL_RV32;
+    return env->misa_mxl;
 }
-#endif
 
 /*
  * Returns the current effective privilege mode.

-- 
2.52.0


