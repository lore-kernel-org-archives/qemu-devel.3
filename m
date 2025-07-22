Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8BC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueDxg-0004UJ-J2; Tue, 22 Jul 2025 10:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueDub-0000sj-EY
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:24:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueDuX-00047A-IC
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:24:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74b56b1d301so3690854b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753194243; x=1753799043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrF1vHGtSO3E3m9Cbx8z/e49hBsbMliHEM6bpEc4hXY=;
 b=fkIXsq8xD7Zj0nYSxntL7OObqsfu6DtB/M3yXcMrcntzZgatZKqkgGX3SwBdEW885o
 sPM/tRP4tmiXTrRcVeM9dIF7Q4crZNCMZlklcHnEhcfJzkDndVRvuIGSFV8gAEl47KA/
 LUkvgYmOYJ7DqKCpIJHuBqEpFhXsDBTCOqnDxJRyc8+PbR2lVd8jx+zWWGwTj2RittHf
 7NEwgMtdAXoo1iirVAZCYkLLMuQfJ/xiRqiTsnCtLPDftUIE5gREqrzBUIwJJBYSU+07
 50JulDbL0gFJxgGh0oGrn9ZTDroR4B2W3CGMMyhVflqHuAW0ZjJiB56mJbwcGIqoGiRw
 SyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753194243; x=1753799043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrF1vHGtSO3E3m9Cbx8z/e49hBsbMliHEM6bpEc4hXY=;
 b=ZzHXT3sntOzgzY29yH2GYKSJLPqqoFleYX3W1h0SC346o1a5h67IqnIzPbk9KUcot2
 adwH07oN5Ti3dCS3XG0AjjW8lDfu9/SbX5H8L/63L+gKFhNwrNOuRLgTHCIT+IrRBuC3
 9Zy+/nWm5GNIPb8cM9gDiWh5jrbDRptivsp4Z6xA8LNBKwZO5QHEexM1QNE8tDPM5cUe
 kVQzRjEPugcVSpw9OdvHKqXadOcfrO5Xc5x0ld2ZriVaUT/wSJMm0SFEfUpAk9b3dfq+
 /Wbi9cNWITVP9gtihAAE7TJVXXxme7AWcjTFZaaopwG5eZfhiBvQUB1wR9xZQ5iQIXSd
 wsbg==
X-Gm-Message-State: AOJu0YxzplCYoWUBKNPqPNxRMU4f5H+IAp1OX2eCHZlziU5smg6l3nFv
 Mv6rlZl5261d6bS59vNQpT/NNUVSY3Csh/9ohWROGsAylBeAuGhvXpVLIE5VlSyZ1Q/VsRTfp6j
 GkgdO
X-Gm-Gg: ASbGncvm/RsJ8BTwU3NRG5TCRJlJl8yM/znxTWkxipIgGYoo5gRpbLZP+10CeZlwRUg
 r8HHux+wNqsAuPq6ViZ7z71N0CBRyGXX2it2eHcDYi83rJPgQBgY++leWAwPJ1JqKnxC77dnfjk
 NZ0YeMzt8COkzDYtLBzkRlPXYkBANoQGG706k1WP0Nv29vc7gd8r9DbVDLeHKOEf5C4m90mt3gy
 Frbv8nXZKN31xVEiGdPQ8ncb/XIXuhhoRtohTKdkHcie08hNrbLvWaHftbVLTJJ0jIvHmqQXwMU
 PIbnvoSrWoR0tTs8bPn3n22B+Qm5HncNf+fXk9H6/G15/EfxSZwGugdqhRvNVm3waXKgR//2p8M
 fiwHa+08pcz6XydNG9mfILhVLLi+M
X-Google-Smtp-Source: AGHT+IFRQHqZqmy9iTuTTwCJqRetWeHvzZkKOJAXygRuUWT24VrMAFE4SBntCxxpRR3URazFP6hQtQ==
X-Received: by 2002:a05:6a21:7a8c:b0:237:89a6:fb00 with SMTP id
 adf61e73a8af0-23811447f92mr41833987637.15.1753194243472; 
 Tue, 22 Jul 2025 07:24:03 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2fe653a7sm7274980a12.2.2025.07.22.07.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 07:24:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH 2/2] target/arm: Pack mtedesc into upper 32 bits of descriptor
Date: Tue, 22 Jul 2025 07:23:58 -0700
Message-ID: <20250722142358.253998-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722142358.253998-1-richard.henderson@linaro.org>
References: <20250722142358.253998-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Instead of trying to pack mtedesc into the upper 17 bits
of a 32-bit gvec descriptor, pass the gvec descriptor in
the lower 32 bits and the mte descriptor in the upper 32
bits of a 64-bit operand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h         |  8 +-----
 target/arm/tcg/sme_helper.c    | 14 +++-------
 target/arm/tcg/sve_helper.c    | 49 +++++++++++++---------------------
 target/arm/tcg/translate-sve.c |  5 ++--
 4 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4765e4489..1b3d0244fd 100644
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
index 0b55f13f8c..075360d8b8 100644
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
index 9fc2c05879..d0fb4138d2 100644
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
index 849151826e..5cba7b87bd 100644
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


