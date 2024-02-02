Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECB5C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmRz-00017q-Qd; Fri, 02 Feb 2024 00:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRy-00016p-FQ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:54 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRw-0001d7-J0
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:54 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bbbc6e51d0so1137084b6e.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853051; x=1707457851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svD0DyA2m73gq/Ge9byYTLFCXR2+v+Cj9UWYFuKF40Y=;
 b=E7rjE4vdx+SRFzxMUGjYPvOEWmfJ7FU6VHpSQk+l+BD6XJ4ojJbvxvw0LPzsqIz5dT
 ugvWQVzJCdDXP5/FXfw1zOIRtR7wRYCuDV1LUjMVc6QcPtnu8miY8dTac2Fg6hiBqr/t
 w/AXy0jADET55x91Dk5npMwiW674lXkDf7D4j2TlX8My1RngRjSLMCItwwG3K4CkeZuW
 4OEWhgClPaxrcnyKoKPO0xcXxeRm7hEDT+/giME/DqthoVCpKOJoBroNsxsbFBSVg8ir
 aLwWBROw2Bqj8wqdAd92F5GDrIopKlBs0PwuPKx7MReWoGu0DT8C686xEMItZvMmrDAe
 D6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853051; x=1707457851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svD0DyA2m73gq/Ge9byYTLFCXR2+v+Cj9UWYFuKF40Y=;
 b=ADYirDWKRSrJh2shaVKbFKX730Jes3nDNZ+03q1VPAjN2kIVRu4g5+POambTjAL3Og
 /4bT8t5j5WCZexQZcZ5UFh5ELfqoI0v4FjfiNjkViielb8sl6HPO2GY2xtur0kj7C/Xx
 GNH/bSsAhrvOT3hRu5mPZEpixVOUA5LZGI0xXe4+ZN2qmQKsU5hbJsEdL/4JbnhZZuGR
 sdNAgEX+KPrNDCfmBhNdl+ZIL9xKuHrOKWndS2jy7xgvAF2F3w29HEybsMBXYISvxa6Z
 pA/87QjGKvnBc+x9r0eArj6dxZrgh38sLvkxtwIOcHxSDJ8anGuml/FWvBDsDP2FAP8M
 QuJw==
X-Gm-Message-State: AOJu0Yw3ARHHmKrRB7/0lOE47eCOBtPNa41igsj2Bcdaqm1uoH4+MWDC
 uEQqhc4cjkxfmr33VsRjp6zb2uaRgFpGx2thlSN3Qeq4GU9EFcx3yxRK/bvjn+caebG8omS+l8u
 06pw=
X-Google-Smtp-Source: AGHT+IH2mcKxZhWMpCrWPzcQrFyvi4gs2k0b23AVSefYZDD0DxqAFDncJZN8/pwL0qcqLqrGPgalgQ==
X-Received: by 2002:a05:6808:1587:b0:3bf:c3d5:c68f with SMTP id
 t7-20020a056808158700b003bfc3d5c68fmr20167oiw.0.1706853051087; 
 Thu, 01 Feb 2024 21:50:51 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/57] target/arm: Split out arm_env_mmu_index
Date: Fri,  2 Feb 2024 15:49:43 +1000
Message-Id: <20240202055036.684176-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  5 +++++
 target/arm/helper.c         |  2 +-
 target/arm/tcg/helper-a64.c |  4 ++--
 target/arm/tcg/mte_helper.c | 18 +++++++++---------
 target/arm/tcg/sve_helper.c |  8 ++++----
 target/arm/tcg/tlb_helper.c |  2 +-
 6 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 71d6c70bf3..fc337fe40e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -40,6 +40,11 @@
 #define BANK_HYP    6
 #define BANK_MON    7
 
+static inline int arm_env_mmu_index(CPUARMState *env)
+{
+    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
+}
+
 static inline bool excp_is_internal(int excp)
 {
     /* Return true if this exception number represents a QEMU-internal
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 945d8571a6..b0488caf40 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7841,7 +7841,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
     uint64_t vaddr_in = (uint64_t) value;
     uint64_t vaddr = vaddr_in & ~(dline_size - 1);
     void *haddr;
-    int mem_idx = cpu_mmu_index(env, false);
+    int mem_idx = arm_env_mmu_index(env);
 
     /* This won't be crossing page boundaries */
     haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 198b975f20..ebaa7f00df 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -856,7 +856,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         tbii = EX_TBFLAG_A64(env->hflags, TBII);
         if ((tbii >> extract64(new_pc, 55, 1)) & 1) {
             /* TBI is enabled. */
-            int core_mmu_idx = cpu_mmu_index(env, false);
+            int core_mmu_idx = arm_env_mmu_index(env);
             if (regime_has_2_ranges(core_to_aa64_mmu_idx(core_mmu_idx))) {
                 new_pc = sextract64(new_pc, 0, 56);
             } else {
@@ -925,7 +925,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
      */
     int blocklen = 4 << env_archcpu(env)->dcz_blocksize;
     uint64_t vaddr = vaddr_in & ~(blocklen - 1);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     void *mem;
 
     /*
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index ffb8ea1c34..d971b81370 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -291,7 +291,7 @@ static int load_tag1(uint64_t ptr, uint8_t *mem)
 
 uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
     int rtag = 0;
 
@@ -311,7 +311,7 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
 {
     if (unlikely(!QEMU_IS_ALIGNED(ptr, TAG_GRANULE))) {
         arm_cpu_do_unaligned_access(env_cpu(env), ptr, MMU_DATA_STORE,
-                                    cpu_mmu_index(env, false), ra);
+                                    arm_env_mmu_index(env), ra);
         g_assert_not_reached();
     }
 }
@@ -344,7 +344,7 @@ typedef void stg_store1(uint64_t, uint8_t *, int);
 static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
                           uintptr_t ra, stg_store1 store1)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
 
     check_tag_aligned(env, ptr, ra);
@@ -371,7 +371,7 @@ void HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 
 void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
 
     check_tag_aligned(env, ptr, ra);
@@ -381,7 +381,7 @@ void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
 static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
                            uintptr_t ra, stg_store1 store1)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     int tag = allocation_tag_from_addr(xt);
     uint8_t *mem1, *mem2;
 
@@ -429,7 +429,7 @@ void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 
 void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
     int in_page = -(ptr | TARGET_PAGE_MASK);
 
@@ -445,7 +445,7 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
 
 uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
     int gm_bs = env_archcpu(env)->gm_blocksize;
     int gm_bs_bytes = 4 << gm_bs;
@@ -505,7 +505,7 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 
 void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
     int gm_bs = env_archcpu(env)->gm_blocksize;
     int gm_bs_bytes = 4 << gm_bs;
@@ -555,7 +555,7 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
 void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
 {
     uintptr_t ra = GETPC();
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     int log2_dcz_bytes, log2_tag_bytes;
     intptr_t dcz_bytes, tag_bytes;
     uint8_t *mem;
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f006d152cc..bce4295d28 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5481,7 +5481,7 @@ bool sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault,
                          CPUARMState *env, target_ulong addr,
                          MMUAccessType access_type, uintptr_t retaddr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = arm_env_mmu_index(env);
     int mem_off = info->mem_off_first[0];
     bool nofault = fault == FAULT_NO;
     bool have_work = true;
@@ -6529,7 +6529,7 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = arm_env_mmu_index(env);
     const intptr_t reg_max = simd_oprsz(desc);
     const int scale = simd_data(desc);
     ARMVectorReg scratch;
@@ -6715,7 +6715,7 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                  sve_ldst1_host_fn *host_fn,
                  sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = arm_env_mmu_index(env);
     const intptr_t reg_max = simd_oprsz(desc);
     const int scale = simd_data(desc);
     const int esize = 1 << esz;
@@ -6920,7 +6920,7 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = arm_env_mmu_index(env);
     const intptr_t reg_max = simd_oprsz(desc);
     const int scale = simd_data(desc);
     void *host[ARM_MAX_VQ * 4];
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 5477c7fb7d..885bf4ec14 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -281,7 +281,7 @@ void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
-    int mmu_idx = cpu_mmu_index(env, true);
+    int mmu_idx = arm_env_mmu_index(env);
     uint32_t fsc;
 
     env->exception.vaddress = pc;
-- 
2.34.1


