Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8421C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6liq-0001XB-9C; Wed, 16 Sep 2026 05:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li9-0001DD-61; Wed, 16 Sep 2026 05:13:49 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li3-00087r-N7; Wed, 16 Sep 2026 05:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=BFvmJlG3e3ljXi1N4bQQxZzgYqIiDydG3zszEMou+Gs=; b=gTVL4ceAHpHbmY7
 Ga9YHORlIL3NPZuuiO7e733wcXsMan423FK1z4pIApvGrruoUFgp+ctcE2Iaxj4Uiu6NfrVdaNgUf
 kD7fCUA+h2ByoUrSscBhcnhrpmqY0a8up3bEh4S+k9vZbok28vNDleizNvmMLGiY+IL8u8Zh0rZTm
 Ck=;
Date: Wed, 16 Sep 2026 11:18:57 +0200
Subject: [PATCH v4 02/12] target/riscv: Remove ifdefs in cpu.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-2-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=3291;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=367gC5i9cTxYMUQLiZ7x404bFso1ulNo3mGxqF0oJzI=;
 b=VGaSO+GhMr8gRB5A638bbpkwiK+PShO92GK27QgUmar+XxZ/hhBCTtUFyCWTDi/rjsjhSpnjW
 z6DjrSbQZyPD/8qyZsNmfEmIIJ4S37YAWpqb4NPHAgVCL5x40rcFxdX
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index aee1dcaaf9..e2e0547eef 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -525,7 +525,6 @@ struct CPUArchState {
     hwaddr kernel_addr;
     hwaddr fdt_addr;
 
-#ifdef CONFIG_KVM
     /* kvm timer */
     bool kvm_timer_dirty;
     uint64_t kvm_timer_time;
@@ -536,7 +535,6 @@ struct CPUArchState {
     /* KVM multiprocessor state */
     uint32_t kvm_mp_state;
     bool kvm_mp_state_loaded;
-#endif /* CONFIG_KVM */
 };
 
 /*
@@ -743,14 +741,10 @@ FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
 FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 
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
@@ -794,9 +788,6 @@ static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 }
 #endif
 
-#if defined(TARGET_RISCV32)
-#define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
-#else
 static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -805,43 +796,32 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
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


