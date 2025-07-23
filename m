Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123FEC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueckN-0006Zr-Qf; Wed, 23 Jul 2025 12:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckK-0006Mf-BQ
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckG-0007B8-8y
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so48576f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753289706; x=1753894506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTa5bJfW6USK2ct/VcofbmOwW3MIZVXHypfzQrDk0DU=;
 b=bkyOXIJ+zVMLHRnneSJagn7OqUHaa7ooWsjud0L4Xmk4QNr05M1lvJiRY5u77GtM5F
 pKR8aGcebU8e4DCwtg6loAr/rFY+nwAoDuen/dygtbPS2gcxzu83sDc/iI0hN3pKAew7
 Gp5A9H1QHkJm1ZQp5UkoOBvxNdNyyG7UK49Bo+1XvCkpwI40Ip57swEBf2mSwzcBb6zh
 7zksBNCnZ6F/n7HQrlwmurShiuUOPuMwOsKUZSs5M1zabVe2Vmevd04E/jf4mG7GXcxP
 v8f0WP4CVilWUpDZYiiQMw6dHJLPPMvduSL7IRuugEZedCseV5cA/OW3LKIt0gmNYWwu
 gJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753289706; x=1753894506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTa5bJfW6USK2ct/VcofbmOwW3MIZVXHypfzQrDk0DU=;
 b=F5Zn4CfT8447o4MCkWhrH6f1hQEmT/c41l6wayX7zs9Y6fkORG5Q1awnHnvTRBwiGF
 nUDwsEiSRh9Dyahs96JClDaDxXxMR/m/NJ6AiRYTM051xrZyUgwNKQqkXpenY62kuC2/
 qq3LpwtDqbSBgQEDR40dAvzEZJmEOWMa48hpSReEUCfUTRSFMqa04Ulp8MMadODM9+NB
 tFk2EaZHxaHEYp9oBYIRWPR86zSxnqkvT3JfjchRX95IoDYOJTmbD/0QvYe73KfiIkxs
 liuWV1aD3oeYF2K0aKu7CuENm5bicedkTTrgFj68l5TvtLGCNbR6wzm4tAUQmxDIpzKD
 9y2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEwYqmwHJ4BojB97xrM57D9FbsYxPW1L0mPuKXOKl6zpAAm0lRwZ1E1YrdBlMvBBClhDQp1/VhgVAC@nongnu.org
X-Gm-Message-State: AOJu0Yw6BlHZ/4HRZIis/3Xc6fmoZa0CV2Lm/Hv3d08/XHMOWeWxuHDs
 w5PjF9FLLOvY/njoSxdiFje8UEWV5aoJta7N600UlJDKOthR1Mka8LNow2g7kD08XNA=
X-Gm-Gg: ASbGncuus8r2Qy7W0Btlh1GhciHlSghk7ufWhf1AjAGjI5Qg2Vx0A2HKVmD9JadOlxj
 qpmHsH1oCWguVsndnBE/76ec/aztuZ3nTF+fHdnUjQ8BB1JO5QFt4BD8ZiJhhLq5l71D/aTO5Fg
 j5ZuNIvexPntmeC6hyKnIGPw/WNLJ9Xnk5vG8cQLlCtAWmGRNmYYqAikzY19zlRNFX7XaOUMly1
 F98xWKqAcdZmdh+Jazi54/moAzbIGyqctsSE96WCRb1IUreAxFh+E5ELGcEmlUhlCe4ybX/Caie
 MllhdAazMfY2E5rOywf9M83Wf1EAlypn+rAmPuAEjJvZbjPBohrUT4v6L7sik7rO/cinaeRbpBO
 brN/UKkEcDF46/0PYqHFVox4QktGU
X-Google-Smtp-Source: AGHT+IE0NI5dDL3SkJf2nXd84sp+2Ge0MP+FPE34xGi/l29G2rljJv6OIF7nJh8xWS0qVaM5F4MWQQ==
X-Received: by 2002:a05:6000:2dca:b0:3b5:f7a3:3960 with SMTP id
 ffacd0b85a97d-3b768ef9510mr3229499f8f.33.1753289706228; 
 Wed, 23 Jul 2025 09:55:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd224sm28559825e9.21.2025.07.23.09.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:55:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 2/6] target/arm: Pack mtedesc into upper 32 bits of
 descriptor
Date: Wed, 23 Jul 2025 17:54:54 +0100
Message-ID: <20250723165458.3509150-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723165458.3509150-1-peter.maydell@linaro.org>
References: <20250723165458.3509150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Instead of trying to pack mtedesc into the upper 17 bits of a 32-bit
gvec descriptor, pass the gvec descriptor in the lower 32 bits and
the mte descriptor in the upper 32 bits of a 64-bit operand.

This fixes two bugs:
 (1) in gen_sve_ldr() and gen_sve_str() call gen_mte_checkN() with a
 length value which is the SVE vector length and can be up to 256
 bytes. We don't assert there that it fits in the descriptor, so
 we would just fail to do the MTE checks on the right length of memory
 if the VL is more than 32 bytes

 (2) the new-in-SVE2p1 insns LD3Q, LD4Q, ST3Q, ST4Q also involve
 transfers of more than 32 bytes of memory. In this case we would
 assert at translate time.

(Note for potential backporting: this commit depends on the previous
"target/arm: Expand the descriptor for SME/SVE memory ops to i64".)

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expand commit message to clarify that we are fixing bugs here]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h         |  8 +-----
 target/arm/tcg/sme_helper.c    | 14 +++-------
 target/arm/tcg/sve_helper.c    | 49 +++++++++++++---------------------
 target/arm/tcg/translate-sve.c |  5 ++--
 4 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4765e44893..1b3d0244fd6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1623,19 +1623,13 @@ FIELD(PREDDESC, OPRSZ, 0, 6)
 FIELD(PREDDESC, ESZ, 6, 2)
 FIELD(PREDDESC, DATA, 8, 24)
 
-/*
- * The SVE simd_data field, for memory ops, contains either
- * rd (5 bits) or a shift count (2 bits).
- */
-#define SVE_MTEDESC_SHIFT 5
-
 /* Bits within a descriptor passed to the helper_mte_check* functions. */
 FIELD(MTEDESC, MIDX,  0, 4)
 FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - SVE_MTEDESC_SHIFT - 12)  /* size - 1 */
+FIELD(MTEDESC, SIZEM1, 12, 32 - 12)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0b55f13f8c5..075360d8b8a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -666,19 +666,16 @@ void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
 
 static inline QEMU_ALWAYS_INLINE
 void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
-                 target_ulong addr, uint32_t desc, uintptr_t ra,
+                 target_ulong addr, uint64_t desc, uintptr_t ra,
                  const int esz, bool vertical,
                  sve_ldst1_host_fn *host_fn,
                  sve_ldst1_tlb_fn *tlb_fn,
                  ClearFn *clr_fn,
                  CopyFn *cpy_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
     int bit55 = extract64(addr, 55, 1);
 
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
     /* Perform gross MTE suppression early. */
     if (!tbi_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
@@ -854,16 +851,13 @@ void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
 
 static inline QEMU_ALWAYS_INLINE
 void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
-                 uint32_t desc, uintptr_t ra, int esz, bool vertical,
+                 uint64_t desc, uintptr_t ra, int esz, bool vertical,
                  sve_ldst1_host_fn *host_fn,
                  sve_ldst1_tlb_fn *tlb_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
     int bit55 = extract64(addr, 55, 1);
 
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
     /* Perform gross MTE suppression early. */
     if (!tbi_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9fc2c05879b..d0fb4138d21 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6362,17 +6362,14 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
 
 static inline QEMU_ALWAYS_INLINE
 void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
-                   uint32_t desc, const uintptr_t ra,
+                   uint64_t desc, const uintptr_t ra,
                    const int esz, const int msz, const int N,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
     int bit55 = extract64(addr, 55, 1);
 
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
     /* Perform gross MTE suppression early. */
     if (!tbi_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
@@ -6727,17 +6724,14 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
 
 static inline QEMU_ALWAYS_INLINE
 void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
-                       uint32_t desc, const uintptr_t retaddr,
+                       uint64_t desc, const uintptr_t retaddr,
                        const int esz, const int msz, const SVEContFault fault,
                        sve_ldst1_host_fn *host_fn,
                        sve_ldst1_tlb_fn *tlb_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
     int bit55 = extract64(addr, 55, 1);
 
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
     /* Perform gross MTE suppression early. */
     if (!tbi_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
@@ -6985,17 +6979,14 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
 
 static inline QEMU_ALWAYS_INLINE
 void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
-                   uint32_t desc, const uintptr_t ra,
+                   uint64_t desc, const uintptr_t ra,
                    const int esz, const int msz, const int N,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
     int bit55 = extract64(addr, 55, 1);
 
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
     /* Perform gross MTE suppression early. */
     if (!tbi_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
@@ -7183,14 +7174,12 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
 
 static inline QEMU_ALWAYS_INLINE
 void sve_ld1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-                   target_ulong base, uint32_t desc, uintptr_t retaddr,
+                   target_ulong base, uint64_t desc, uintptr_t retaddr,
                    int esize, int msize, zreg_off_fn *off_fn,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
 
     /*
      * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
@@ -7395,15 +7384,13 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
 
 static inline QEMU_ALWAYS_INLINE
 void sve_ldff1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-                     target_ulong base, uint32_t desc, uintptr_t retaddr,
+                     target_ulong base, uint64_t desc, uintptr_t retaddr,
                      const int esz, const int msz,
                      zreg_off_fn *off_fn,
                      sve_ldst1_host_fn *host_fn,
                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
 
     /*
      * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
@@ -7600,14 +7587,12 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
 
 static inline QEMU_ALWAYS_INLINE
 void sve_st1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-                   target_ulong base, uint32_t desc, uintptr_t retaddr,
+                   target_ulong base, uint64_t desc, uintptr_t retaddr,
                    int esize, int msize, zreg_off_fn *off_fn,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    uint32_t mtedesc = desc >> 32;
 
     /*
      * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
@@ -7853,14 +7838,15 @@ static void sve2p1_cont_ldst_mte_check(SVEContLdSt *info, CPUARMState *env,
 
 static inline QEMU_ALWAYS_INLINE
 void sve2p1_ld1_c(CPUARMState *env, ARMVectorReg *zd, const vaddr addr,
-                  uint32_t png, uint32_t desc,
+                  uint32_t png, uint64_t desc64,
                   const uintptr_t ra, const MemOp esz,
                   sve_ldst1_host_fn *host_fn,
                   sve_ldst1_tlb_fn *tlb_fn)
 {
+    uint32_t mtedesc = desc64 >> 32;
+    uint32_t desc = desc64;
     const unsigned N = (desc >> SIMD_DATA_SHIFT) & 1 ? 4 : 2;
     const unsigned rstride = 1 << ((desc >> (SIMD_DATA_SHIFT + 1)) % 4);
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
     const intptr_t reg_max = simd_oprsz(desc);
     const unsigned esize = 1 << esz;
     intptr_t count_off, count_last;
@@ -8025,14 +8011,15 @@ DO_LD1_2(ld1dd, MO_64)
 
 static inline QEMU_ALWAYS_INLINE
 void sve2p1_st1_c(CPUARMState *env, ARMVectorReg *zd, const vaddr addr,
-                  uint32_t png, uint32_t desc,
+                  uint32_t png, uint64_t desc64,
                   const uintptr_t ra, const int esz,
                   sve_ldst1_host_fn *host_fn,
                   sve_ldst1_tlb_fn *tlb_fn)
 {
+    uint32_t mtedesc = desc64 >> 32;
+    uint32_t desc = desc64;
     const unsigned N = (desc >> SIMD_DATA_SHIFT) & 1 ? 4 : 2;
     const unsigned rstride = 1 << ((desc >> (SIMD_DATA_SHIFT + 1)) % 4);
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
     const intptr_t reg_max = simd_oprsz(desc);
     const unsigned esize = 1 << esz;
     intptr_t count_off, count_last;
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 849151826e2..5cba7b87bdc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4893,7 +4893,6 @@ uint64_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
     assert(nregs >= 1 && nregs <= 4);
     sizem1 = (nregs << msz) - 1;
     assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
-    assert(data < 1u << SVE_MTEDESC_SHIFT);
 
     if (s->mte_active[0]) {
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
@@ -4901,9 +4900,9 @@ uint64_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
-        desc <<= SVE_MTEDESC_SHIFT;
+        desc <<= 32;
     }
-    return simd_desc(vsz, vsz, desc | data);
+    return simd_desc(vsz, vsz, data) | desc;
 }
 
 static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
-- 
2.43.0


