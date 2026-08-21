Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E276C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUS-00066S-Mp; Fri, 21 Aug 2026 00:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUP-00062m-RH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:21 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUO-0003CU-54
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso687786a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285059; x=1787889859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7bhHwXmi5Ia9z6djPqPB3zlOaGaSOImvwNPGZX3JZAw=;
 b=vVp7DJVDUeyLpilXHQ81gwM7zuZxoMktecorvaqSs7KY+xxQ/SfYdYdT/oo/YL8Iyq
 +gb+l4dDFzNCN0iV8AVPP+XWWtnPCTr3VEOKBdPwc72aX0P6Zp3fqpwlLwcgesoVG3M3
 SPdVroyezE3O5MlL1WfplTYpWX1BawE1AboUA98eSyh4FPGjRuxvDwsnQH/exY1zzDb2
 5gAOyOe/rKNLl3dybiezQG2ClplNCTxKMR/DURPr7hGCu7YC/rqiVcoN+MHdNDNE1x03
 zQrHgS4t8Op84ZgYwK6J+fzWCpX2taPtRnJhaW4dmDu1FrX0BFKcx8uJRJtrlZCTPB1d
 +wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285059; x=1787889859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7bhHwXmi5Ia9z6djPqPB3zlOaGaSOImvwNPGZX3JZAw=;
 b=MRzXaTpOCENPPjK4UQLTSioy/bM1XCS8g3gFcBYa7CqTA8MtXFkKHt7KphbFa8swiq
 p7yHpNwvUTT3n0Ru1C9uc9/HxAiVtOvCAkOoJAFyYtWEFfFwWmxcASx5RRQ+prMjlFYm
 oEYE8jrQ5c2eOSCkV4bWovVhhdVBCEw5dLKmMMe8bL00FD/YgAXUxjcYb1PEPpmXeE5F
 YowZYrPEgn7gpT6BRu7iurPDknisUJpw79W/Ekld7q5W7BELFFFUvy6sREQhb9pcw95T
 l//KlhF8zuyjVpjhxuB45FfNJED3A61lpIOBjos5iWnIjXjiDYMSqmm1X1rYkSCD3qrk
 Uj/w==
X-Gm-Message-State: AFuF++kC916g8t9mpZlL+e39J1rxdvsqDb+rtE3l0uoK5WitQdrZasWd
 3FEWKZqSTXK4dPYQrrmrf8RZE6PiA2PUKTl75pqKRMKlUj472d7cYXkkrsXeM4PvrFKl2VIP0fd
 fKSeU
X-Gm-Gg: AR+sD12mfcsrlz4e30SiAZFeqzcGZPSS+LXfJdOX/zrC+5rw+7icr133SM0alzBwPvD
 1T/4eEgvdXwETHCzvg/9aF/2mwhHbElIWksOLaq53jRLOduyaVxjtRKGTbijL2vPeqRKyzF8edi
 toaXFd+ffWc+kzmbPtEH/noEmi1ROELEdAF7uDEEDAYk+GqGTL6/AImwzyk28ev9JoTVl2amwBB
 uSp8JGKD8qbjaWwhFSpuvK2PYuQhOFCFarXVA5K0ocSnS1Hys1STa8cO/YuH9iNt2nwqn6n7kfR
 z/euCWDKhmIM0HLleNm6Czm5PBIjJw0/Veinn7QWJncHAlctegwDWj45yld8RoTBwboJKr2/04R
 vua1u9Mx3riz3+tANQn6vRSkT2ycws6vUIJE2p8U3rQNdb2dvwtFK6Qr/qjaoUcFui8ENApXSjm
 r99zdoBNt5naK4RTKCqA2eLCH9YL7riDm1+cudAZ8Tlp35fg4nMxvsRQFKZo3a7H7rt14=
X-Received: by 2002:a17:90a:e7c2:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-395c3a959b2mr6191648a91.15.1787285058599; 
 Thu, 20 Aug 2026 21:04:18 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 10/23] target/riscv: Split out vext_ldst_us_notail
Date: Thu, 20 Aug 2026 21:03:51 -0700
Message-ID: <20260821040404.268123-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Split out vext_ldst_us_tail that doesn't use 'desc'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 34 +++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index abfd2ec45d..76f3babed6 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -472,14 +472,14 @@ static void vext_test_alignment(CPURISCVState *env, vaddr addr, uint32_t esz,
 }
 
 static inline QEMU_ALWAYS_INLINE void
-vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
-             vext_ldst_elem_fn_tlb *ldst_tlb,
-             vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
-             uint32_t evl, uintptr_t ra, bool is_load)
+vext_ldst_us_notail(void *vd, target_ulong base, CPURISCVState *env,
+                    uint32_t log2_esz, uint32_t nf, uint32_t evl,
+                    uint32_t max_elems, bool vma,
+                    vext_ldst_elem_fn_tlb *ldst_tlb,
+                    vext_ldst_elem_fn_host *ldst_host,
+                    uintptr_t ra, bool is_load)
 {
     target_ulong elems, addr, last, last_in_page, page_split;
-    uint32_t nf = vext_nf(desc);
-    uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     int mmu_index = riscv_env_mmu_index(env, false);
@@ -503,7 +503,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         for (; i < evl; env->vstart = ++i, addr += esz) {
             ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
         }
-        goto tail;
+        return;
     }
 #endif
 
@@ -535,7 +535,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
         /* Usually the first page contains the entire vector. */
         if (likely(page_evl == evl)) {
-            goto tail;
+            return;
         }
         env->vstart = i = page_evl;
         addr += elems * msize;
@@ -545,7 +545,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     if (unlikely(page_split % msize)) {
         vext_ldst_nf_tlb(env, vd, addr, i++, nf, esz, max_elems, ldst_tlb, ra);
         if (i == evl) {
-            goto tail;
+            return;
         }
         env->vstart = i;
         addr += msize;
@@ -564,10 +564,22 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         vext_page_ldst_us_tlb(env, vd, addr, i, evl, nf, log2_esz, max_elems,
                               ldst_tlb, mmu_index, ra);
     }
+}
+
+static inline QEMU_ALWAYS_INLINE void
+vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
+             vext_ldst_elem_fn_tlb *ldst_tlb,
+             vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
+             uint32_t evl, uintptr_t ra, bool is_load)
+{
+    uint32_t nf = vext_nf(desc);
+    uint32_t max_elems = vext_max_elems(desc, log2_esz);
+
+    vext_ldst_us_notail(vd, base, env, log2_esz, vext_nf(desc), evl, max_elems,
+                        vext_vma(desc), ldst_tlb, ldst_host, ra, is_load);
 
- tail:
     env->vstart = 0;
-    vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(evl, vd, desc, nf, 1 << log2_esz, max_elems);
 }
 
 /*
-- 
2.43.0


