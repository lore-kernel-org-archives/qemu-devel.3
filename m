Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D83606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ofZ/mhGA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnaj-0001rV-T9; Tue, 24 Nov 2026 05:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnah-0001qW-Ta
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:35 -0500
Received: from mail-pi2-x09.google.com ([2607:f8b0:4864:3a::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnaf-0004Xk-Vc
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:35 -0500
Received: by mail-pi2-x09.google.com with SMTP id
 41be03b00d2f7-cdd769c49dbso2169196a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795515453; x=1796120253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1G+2wpleCh75E5oOKPRYO5pXOmMMO17dMIXSMPS9yeo=;
 b=ofZ/mhGATM8hF6+9LV1Ydw+Dncijbw4QxPqmD0TQMNvN/nbho2xS3sArqwPvrVVgwO
 9bjnffhj6LKvdVNzKz9mvptJzf/qbTqgPuaGDxh+H1Nbs2Myu/O8Un5i/LLUFhNc8OCB
 kU9ClfEM2CN3E0rbOKhO5ot7oO0WqcrLn6fHpUm4AEwYMOWxpQOWMnlIsFbQCh1y+516
 wyhUieY5IrNSGfqkmjF7An3J/jgWyJi0VlUFt1sagqnPgaBBwn6xCXBG4dfMqgkmMGPD
 eOz0pSniFi1FhM/cws/793dCa0obcbBbeI4xumGE09tMTTK7NNGVOEx3Sq7zMvVdiZyY
 01OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515453; x=1796120253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1G+2wpleCh75E5oOKPRYO5pXOmMMO17dMIXSMPS9yeo=;
 b=PCMkzOH7HOvJQ0gVD4q4vwfdQO0qOiCBBx/+xLzJVBETimJJ+whrWtGPc0pLf1sSG5
 HmJSLDnKOpu13ski9U/7RwxhFV0K/OIxAtjAPHMLv32foQ0OeBvsPhkQTlP6x4frOiyl
 EF/ijLtDskRfLZwlPv18p/yPueA19gcxG86KjfgcWn0wVqgqyk7fzu/Fi5j3Aw2O194S
 aA9FytPIhMunQRDqPq6Znnl5z8hg1HP4F0B5U/xGu+QxJA3MXs1H8qoI/Aw+IydSk18V
 D2I6dJteXrpiHEkPy9BTlbf1L9mmrvrHuRMJV4MIJJlm+KMVXLaceV1nqB5qluMZP7A3
 Bz2w==
X-Gm-Message-State: APuU4Z+u2WbkfFsPTCLE94BY8vrbOY94BP/zunAke/5urWH7T+Dzuke0
 lOqqdSCIV0eYBY4C6dJZQVCCLR+1vXonfT0sBTFRBEyuVgNp3HHZrr5piEGvILSYz7o=
X-Gm-Gg: AZFdTZfLwsAzAS5UrlWvANEIcTG+PSf2T7zulQdus11y9dm7WZ8S2CINMDahjkwpXQc
 BaQ9+YtZZWIn43pTGQmv+bzmXKfHErPrrTEolW+3EX5F8TtimTCdTOTvWpYljAlZE4bHqAutA2L
 W3IaOoqBMcnAFvi/cbNmjOkDKYmt7EG+Lb6U8ZCG1eYtZ/svhgnduuWp9J47MQ3+Fgvl7gArCNd
 DMsgrH1gfOvEXjKCpNIL4SaWi1ujNkhtedXHKk1DbOAbhn+nIeEzuWBwpNLIoEVCT2uKqgusKTM
 WM752Cut/7DkrF9Gcvv69jYduDO+hm8n2/b/V+Xr2d+fZCifkIJl4TFg9271H6mQMD0CbbHtlqv
 043gXNSXsX0Kj9tUq17sG8Y8x/NM4iIqkSZqS87dasF03vTyjRBGvfjcFfaB1Mf+p/SHLE/gL0k
 36SYlOjn8cfYXZjUMRf/xtmABfXN9s9jWj6JjpJSKeR1zm5Xk2CfjvKfxcorK5tTPj0LXhi2VmI
 XfpDuls/KtsV1XfWbOjKjcWuX9k1kavnYlWbCfBQiLC1PTE7+SqXZ1jI9ndapEI7NkGrIFaBAhY
 /6P+Gg9c4jRT1KnX1F1qIpVXCtSG860=
X-Received: by 2002:a05:6300:8811:b0:3e1:c1a4:91f6 with SMTP id
 adf61e73a8af0-4014ca447e7mr13187802637.13.1795515452557; 
 Tue, 24 Nov 2026 02:17:32 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cea748csm6627920a12.4.2026.11.24.02.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:17:32 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v3 3/5] target/i386: add MMU indexes for LAM-masked data
 accesses
Date: Tue, 24 Nov 2026 10:16:52 +0000
Message-ID: <20261124101655.2269531-4-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124101655.2269531-1-mdspan.github@gmail.com>
References: <20261124101655.2269531-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::9;
 envelope-from=mdspan.github@gmail.com; helo=mail-pi2-x09.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add LAM forms of the three 64-bit data indexes, and a hflags bit,
HF_LAM, that is set when CPUID reports LAM and any of CR3.LAM_U57,
CR3.LAM_U48, and CR4.LAM_SUP is set.  cpu_x86_update_cr3() and
cpu_x86_update_cr4() keep the bit up to date.  The bit is part of the
TB flags, since translate.c fixes the data mmu_idx per TB.

While HF_LAM is set, x86_mmu_index_pl() and x86_mmu_index_kernel_pl()
return the LAM forms.  Instruction fetches always use the normal
indexes, since LAM applies only to data accesses.  If LAM is not
enabled, only the normal indexes are used.

This lets the fetch and data translations of a linear address differ,
which LAM needs.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tim <mdspan.github@gmail.com>
---
v3: new patch, in place of the v2 fetch MMU indexes, as suggested in
review of v2.

 target/i386/cpu.h            | 46 ++++++++++++++++++++++++++++++++----
 target/i386/helper.c         | 13 ++++++++++
 target/i386/tcg/seg_helper.c |  2 +-
 target/i386/tcg/tcg-cpu.c    | 12 ++++++++--
 4 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e903..0923ab4f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -192,6 +192,7 @@ typedef enum X86Seg {
 #define HF_UMIP_SHIFT       27 /* CR4.UMIP */
 #define HF_AVX_EN_SHIFT     28 /* AVX Enabled (CR4+XCR0) */
 #define HF_APX_EN_SHIFT     29 /* APX Enabled (CR4+XCR0) */
+#define HF_LAM_SHIFT        30 /* LAM enabled (CR3+CR4) */
 
 #define HF_CPL_MASK          (3 << HF_CPL_SHIFT)
 #define HF_INHIBIT_IRQ_MASK  (1 << HF_INHIBIT_IRQ_SHIFT)
@@ -220,6 +221,7 @@ typedef enum X86Seg {
 #define HF_UMIP_MASK         (1 << HF_UMIP_SHIFT)
 #define HF_AVX_EN_MASK       (1 << HF_AVX_EN_SHIFT)
 #define HF_APX_EN_MASK       (1 << HF_APX_EN_SHIFT)
+#define HF_LAM_MASK          (1 << HF_LAM_SHIFT)
 
 /* hflags2 */
 
@@ -260,6 +262,9 @@ typedef enum X86Seg {
 #define CR0_CD_MASK  (1U << 30)
 #define CR0_PG_MASK  (1U << 31)
 
+#define CR3_LAM_U57_MASK (1ULL << 61)
+#define CR3_LAM_U48_MASK (1ULL << 62)
+
 #define CR4_VME_MASK  (1U << 0)
 #define CR4_PVI_MASK  (1U << 1)
 #define CR4_TSD_MASK  (1U << 2)
@@ -2781,6 +2786,7 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
 void cpu_sync_apx_hflag(CPUX86State *env);
+void cpu_sync_lam_hflag(CPUX86State *env);
 
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
@@ -2838,8 +2844,11 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define MMU_USER32_IDX     3
 #define MMU_KNOSMAP64_IDX  4
 #define MMU_KNOSMAP32_IDX  5
-#define MMU_PHYS_IDX       6
-#define MMU_NESTED_IDX     7
+#define MMU_KSMAP64_LAM_IDX    6
+#define MMU_USER64_LAM_IDX     7
+#define MMU_KNOSMAP64_LAM_IDX  8
+#define MMU_PHYS_IDX       9
+#define MMU_NESTED_IDX     10
 
 #ifdef CONFIG_USER_ONLY
 #ifdef TARGET_X86_64
@@ -2851,18 +2860,45 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 static inline bool is_mmu_index_smap(int mmu_index)
 {
-    return (mmu_index & ~1) == MMU_KSMAP64_IDX;
+    return (mmu_index & ~1) == MMU_KSMAP64_IDX ||
+           mmu_index == MMU_KSMAP64_LAM_IDX;
 }
 
 static inline bool is_mmu_index_user(int mmu_index)
 {
-    return (mmu_index & ~1) == MMU_USER64_IDX;
+    return (mmu_index & ~1) == MMU_USER64_IDX ||
+           mmu_index == MMU_USER64_LAM_IDX;
+}
+
+/* LAM masks the linear addresses of accesses with these indexes */
+static inline bool is_mmu_index_lam(int mmu_index)
+{
+    return mmu_index >= MMU_KSMAP64_LAM_IDX &&
+           mmu_index <= MMU_KNOSMAP64_LAM_IDX;
 }
 
 static inline bool is_mmu_index_32(int mmu_index)
 {
     assert(mmu_index < MMU_PHYS_IDX);
-    return mmu_index & 1;
+    return !is_mmu_index_lam(mmu_index) && (mmu_index & 1);
+}
+
+/* The LAM form of a 64-bit data index, if LAM is enabled */
+static inline int x86_mmu_index_lam(CPUX86State *env, int mmu_index)
+{
+    if (!(env->hflags & HF_LAM_MASK)) {
+        return mmu_index;
+    }
+    switch (mmu_index) {
+    case MMU_KSMAP64_IDX:
+        return MMU_KSMAP64_LAM_IDX;
+    case MMU_USER64_IDX:
+        return MMU_USER64_LAM_IDX;
+    case MMU_KNOSMAP64_IDX:
+        return MMU_KNOSMAP64_LAM_IDX;
+    default:
+        return mmu_index;
+    }
 }
 
 #define CC_DST  (env->cc_dst)
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 723e87fe..e116ae27 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -46,6 +46,17 @@ void cpu_sync_apx_hflag(CPUX86State *env)
     }
 }
 
+void cpu_sync_lam_hflag(CPUX86State *env)
+{
+    if ((env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM) &&
+        ((env->cr[3] & (CR3_LAM_U57_MASK | CR3_LAM_U48_MASK)) ||
+         (env->cr[4] & CR4_LAM_SUP_MASK))) {
+        env->hflags |= HF_LAM_MASK;
+    } else {
+        env->hflags &= ~HF_LAM_MASK;
+    }
+}
+
 void cpu_sync_avx_hflag(CPUX86State *env)
 {
     if ((env->cr[4] & CR4_OSXSAVE_MASK)
@@ -188,6 +199,7 @@ void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
 void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3)
 {
     env->cr[3] = new_cr3;
+    cpu_sync_lam_hflag(env);
     if (env->cr[0] & CR0_PG_MASK) {
         qemu_log_mask(CPU_LOG_MMU,
                         "CR3 update: CR3=" TARGET_FMT_lx "\n", new_cr3);
@@ -261,6 +273,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
     cpu_sync_bndcs_hflags(env);
     cpu_sync_avx_hflag(env);
     cpu_sync_apx_hflag(env);
+    cpu_sync_lam_hflag(env);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index f11b55d1..e26ebf3a 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -138,7 +138,7 @@ static int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
         (pl < 3 && (env->eflags & AC_MASK)
          ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX);
 
-    return mmu_index_base + mmu_index_32;
+    return x86_mmu_index_lam(env, mmu_index_base + mmu_index_32);
 }
 
 int cpu_mmu_index_kernel(CPUX86State *env)
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 167ff769..f1e9b19b 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -116,7 +116,7 @@ static void x86_restore_state_to_opc(CPUState *cs,
     }
 }
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
+static int x86_mmu_index_pl_nolam(CPUX86State *env, unsigned pl)
 {
     int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
     int mmu_index_base =
@@ -127,10 +127,18 @@ int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
     return mmu_index_base + mmu_index_32;
 }
 
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
+{
+    return x86_mmu_index_lam(env, x86_mmu_index_pl_nolam(env, pl));
+}
+
 static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUX86State *env = cpu_env(cs);
-    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+    unsigned pl = env->hflags & HF_CPL_MASK;
+
+    /* LAM does not apply to instruction fetches */
+    return ifetch ? x86_mmu_index_pl_nolam(env, pl) : x86_mmu_index_pl(env, pl);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.47.3


