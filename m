Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F2C5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUQ-00063d-BX; Fri, 21 Aug 2026 00:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUO-00061g-J4
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:20 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUM-0003Bm-KF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:20 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso368690a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285057; x=1787889857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W+PCmHSRhTicbeZtNSYjuRxoRU2mRhQsx0kY/BYPfII=;
 b=m/sHvMzPriPJESeLX7qvY3xo+SPR8whLXxoYGZpF+XLiWxak3m3GBhQmTSjiZDBcUs
 oPJe9Rtobbw8h6h0pLwa727nXDcOVoOOo6l/yMR4imqHcGZYe3LtbqMFnhsq0+S8dZ8S
 C2jzjJqGuZmf597MOx2BfFVW4AES2EYgDnq5lQ10Pw1u665SI+TFenOPoGlf45EyPE9e
 7rOe4o+qXoVmoGO5hSix53PFMLBsUbM3nRoSZ4G8nVd1+W9Ou7VV+93+TE8POagcInCw
 mWzEklkx3hcwjXrPe9bAj99SELbEACCw4aPaGAk4EWnxlSRXUGNkwyvCjcGDeHnJ5/Al
 TGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285057; x=1787889857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W+PCmHSRhTicbeZtNSYjuRxoRU2mRhQsx0kY/BYPfII=;
 b=ATgBXAWrmUcC8m1uoFmQGzKLce+GYK7ddFK6Lo8DxjIEck2UOpAlopPaYg3Zmf0G5x
 8iu3qnSCuy2+LhXCKfxSHRf2zEM/BWA+41QsmwEFCXciXdzAluR6Vw4556Nc2Okvl23J
 44Xw+dJHnptbkjBMKQyPkRSOwx5c6oQPFm0FB5SE4J3dQmbCGZ2ZTvoBge2rhdY90bqA
 dSVf+lTJmTLcrDJluO13ehjiQJ+ud49MKjzA+tdYI/Jyk7yQQtYYMQ9UL/4lgk2gAbCI
 C7mrULlz2dnVyOudgGrtrnkeOo7gCK+hAdfx0iggGXceTmtCKJCb+fz68NzFHA5d+izC
 clpw==
X-Gm-Message-State: AFuF++l4fgKihz/4VUsEWnESsNXs2cVJ/FXZAdysoyJOHA0eq124/gXd
 xGWIficfU5SNzwJgYbvPxt0EIveegRV40lfb7XvhTakNZcnt8gzS76p/AObzUJ9HixVWukTtHfz
 fv5dd
X-Gm-Gg: AR+sD1070HLK+rc3j4pBaqiTHbdE+yVbO4l/Ir056T95iSCtTUNIuF9roj58jsHsRRd
 fDJGqwLfNe3qBhcm1UGjrAbSmEAzf8d/bZvU6IqO8Gnn2OiGDTGDiCfphOWAGM+YprZGNp/AxLs
 C2UkMLzWHoJMCLhneZHhMJ+Sc0kchSqrg004WC1X6wdU+c54wzMSHTybwC+vD3MbOWLd/l3441e
 hTt05ObxIkfVVlbDp8WqbDkyG1uI207txNrG4L6379EmgDSvXltbmfdhjmgTt6/ER67igR2gn7t
 oU6fsAfQQJ0N94X8QGpv5czVSGMOmBKDBTHkMVdPJWbUjwDskUz+yBMTAMSSnhap+OVwxnkmZTh
 pRsAIDR9tRT+jUBIHes6AEx1Ih3SH63on01zLC3KuYQGqDn2cRKirJPWBOp0b2wqBFbful7ThHN
 QxBQe4PM8tU5zF9MpP79YUa/K0Vgi+maqxVwFxuW2ZLuaaX0lvNkAx2mu7MhO+ouBhIFU=
X-Received: by 2002:a17:90b:57e5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-395c35f0a79mr6218841a91.14.1787285057149; 
 Thu, 20 Aug 2026 21:04:17 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 08/23] target/riscv: Rewrite vext_ldst_us
Date: Thu, 20 Aug 2026 21:03:49 -0700
Message-ID: <20260821040404.268123-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

We already computed the page split here, which means we
were quite ready to call probe_access directly.  Do so,
then use vext_ldst_nf_{host,tlb} to load the elements.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 88 ++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 505f0331f2..36e64465f2 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -477,17 +477,19 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
              uint32_t evl, uintptr_t ra, bool is_load)
 {
-    target_ulong page_split, elems, addr;
+    target_ulong elems, addr, last, last_in_page, page_split;
     uint32_t nf = vext_nf(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     int mmu_index = riscv_env_mmu_index(env, false);
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
+    uint32_t i = env->vstart;
+    void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, evl);
 
-    addr = base + env->vstart * msize;
+    addr = base + i * msize;
 
     /* Recognize alignment fault before memory protection fault. */
     vext_test_alignment(env, addr, esz, access_type, mmu_index, ra);
@@ -498,50 +500,72 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
      * by simply calling ldst_tlb.
      */
     if (nf == 1 && (evl << log2_esz) <= 6) {
-        for (uint32_t i = env->vstart; i < evl;
-             env->vstart = ++i, addr += esz) {
+        for (; i < evl; env->vstart = ++i, addr += esz) {
             ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
         }
-        env->vstart = 0;
-        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
-        return;
+        goto tail;
     }
 #endif
 
-    /* Calculate the page range of first page */
+    /* Calculate the page range of first page. */
+    last = base + evl * msize - 1;
+    last_in_page = addr | ~TARGET_PAGE_MASK;
     page_split = -(addr | TARGET_PAGE_MASK);
-    /* Get number of elements */
-    elems = page_split / msize;
-    if (unlikely(env->vstart + elems >= evl)) {
-        elems = evl - env->vstart;
-    }
+
+    /* Validate the first page is accessible. */
+    host = probe_access(env, adjust_addr(env, addr),
+                        MIN(last, last_in_page) - addr + 1,
+                        access_type, mmu_index, ra);
+
+    /* Get number of complete elements in the first page. */
+    elems = MIN(page_split / msize, evl - i);
 
     /* Load/store elements in the first page */
     if (likely(elems)) {
-        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
-    }
+        uint32_t page_evl = i + elems;
 
-    /* Load/store elements in the second page */
-    if (unlikely(env->vstart < evl)) {
-        addr = base + env->vstart * msize;
-
-        /* Cross page element */
-        if (unlikely(page_split % msize)) {
-            vext_ldst_nf_tlb(env, vd, addr, env->vstart,
-                             nf, esz, max_elems, ldst_tlb, ra);
-            env->vstart++;
-            addr += msize;
+        if (host) {
+            vext_page_ldst_us_host(vd, host, i, page_evl, nf, log2_esz,
+                                   max_elems, ldst_host, is_load);
+        } else {
+            vext_page_ldst_us_tlb(env, vd, addr, i, page_evl, nf,
+                                  log2_esz, max_elems,
+                                  ldst_tlb, mmu_index, ra);
         }
 
-        /* Get number of elements of second page */
-        elems = evl - env->vstart;
-
-        /* Load/store elements in the second page */
-        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
+        /* Usually the first page contains the entire vector. */
+        if (likely(page_evl == evl)) {
+            goto tail;
+        }
+        env->vstart = i = page_evl;
+        addr += elems * msize;
     }
 
+    /* Cross page element */
+    if (unlikely(page_split % msize)) {
+        vext_ldst_nf_tlb(env, vd, addr, i++, nf, esz, max_elems, ldst_tlb, ra);
+        if (i == evl) {
+            goto tail;
+        }
+        env->vstart = i;
+        addr += msize;
+    }
+
+    /* Validate the second page is accessible. */
+    assert(i < evl);
+    elems = evl - i;
+    host = probe_access(env, adjust_addr(env, addr), elems * msize,
+                        access_type, mmu_index, ra);
+
+    if (host) {
+        vext_page_ldst_us_host(vd, host, i, evl, nf, log2_esz,
+                               max_elems, ldst_host, is_load);
+    } else {
+        vext_page_ldst_us_tlb(env, vd, addr, i, evl, nf, log2_esz, max_elems,
+                              ldst_tlb, mmu_index, ra);
+    }
+
+ tail:
     env->vstart = 0;
     vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
 }
-- 
2.43.0


