Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11B606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GiPPVTWn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTiiN-00025f-BF; Wed, 18 Nov 2026 11:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTihs-000240-Bo
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:40:29 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTihq-000867-JO
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:40:24 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3b3bf3bef9aso1189911a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 08:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795020021; x=1795624821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FoGqK6Pd7vieo9G9KZm78HRcBEWeUIe5kPNDuSMjfCQ=;
 b=GiPPVTWnhLrPg/27lSV6xD8guigtVvEopjvXCyMvLymtpu6ROcI/7H3F4yZNcVKDNE
 OThbfW/EjxhPulqR7RlGGZy0OieJ6LeYySMzKVz2P7RotegdrBQbNFgxFv+pd4L4oV7N
 43hU+S37hZ+hwMR/n2owG0+ovJgsuICdx5LukDW4asqoCLyoutfn/f2a8gTvsjmHeCS6
 CncoM2SBTJpj/vMJUOGFe8AtTb5pyiJi9dXBb5w4lS3C/bw/XqnqFwuwujoN09a6ylLV
 nlr+BcxjoIJHiWDKUyX2/uK6k02j78BM/HeZusubYfXQKNFYn0TSXCeOVBkj4rj8iiDV
 m1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020021; x=1795624821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FoGqK6Pd7vieo9G9KZm78HRcBEWeUIe5kPNDuSMjfCQ=;
 b=kJ0bmxtmXXs7Y/ao2k1EJT3BtV/ZRUK3VzPUpRrexJOmX0vlbFOcS121rBBf/uhT4+
 RHCaTGBAshKbDysP8Cw+0ufuErkFGM5wesjcetFLYu4DWBxRsbWx10SYll4tKXgmWNtr
 vWp909NqCCQ5fgetMcxGyWDliMlrCmLwH8ZQ/iVZylZhY8t06XLtPYEICvagdYo8Li3/
 RLcSOJjbVUnaA6tgwD13LCszRI1l0ITtyZ9od7KiGr2qPU4LHTuKx92dNA78iGhydvbv
 34xKj06s41vuYYGu0EBItBA8/3fJ7W/ssyhmN2nzhR/ff5yUyQVn943cYTOnblWEfgb3
 fCVQ==
X-Gm-Message-State: APuU4Z8zq8/j+HqBswLjRpejotEL8kHMueXoGn5hd9/aUrYYhjykN4Tc
 mEN3d4c4j5jiYrRWIT8qLI8zSIN0xOGkQUJk4FAZXhs+ZiJi5VJQIJEYfYkjLvPUpCA8pzWylSv
 lDu8T
X-Gm-Gg: AZFdTZe8Vyks5rTIh+afI9sggvhNBYKBuGa3GnKz2s3CPQ6nbC5QZIvVS4bbYfIAKTL
 IXT/59I+9k+udT3XRf5wkqt2phg0fgGa58TMLNwmQV6OHzHmikou6iHQIaiweVw9LWsjxqaqxPn
 Ej2qVa3XKW39HsdcLIMoS/xioLtu1FqnggU6VpZXORo4lqNRqjcnA5+RJuMk2dUzL2KvD+aadxs
 HvBwTLaIjJTL07LN/UwfHVCtGUQzqTYyfAYDY6eOIjsVh+nsFedKhmAaFIdQ2glQevP1QIjCIYv
 w3lRIOygsNv4vAXvnUW/wW60gn0BdLmAHekuc499TuXgANq4wcQPm93gTds57xQVza3sdDn1/jG
 KzmlT4A516/TwMTIJBRUOOVXMXCTsysf5gA8G5JnTLMbm80/1jDOqq2SvXGK7UUXBRpOxipOt9D
 dgbOsJmifr1cVdTBrW2scWhLhTy7ayysLQEPAUqbaUlYrjPpcRGvxP2cmpU/rqbqqdrWIQKcae6
 8heL/mTRcIYNp/qrFVdlGjZZX3pAOe4NdJUOF4tB9BADQMvNsNiQIVZN1ECW/4Ffmy4eJ4eGvoE
 IRzzSDksopWjXcj6ehqXrYoTMWLvRauM9V1wvAF80O99Qc7rvaLg9wFq12oj
X-Received: by 2002:a17:90b:56d0:b0:3ac:7c52:fae5 with SMTP id
 98e67ed59e1d1-3b3d07d4ecfmr3108379a91.50.1795020020718; 
 Wed, 18 Nov 2026 08:40:20 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3f6bbe469sm18992a91.11.2026.11.18.08.40.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:40:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 for-11.2] accel/tcg: Fix jump cache flush after large page
 flush
Date: Wed, 18 Nov 2026 08:40:19 -0800
Message-ID: <20261118164019.258874-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a large page flush occurs, flush the entire jump cache.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4873
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Apply the same fix to range-based flushes.
---
 accel/tcg/cputlb.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3ca484b039..463d002607 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -472,7 +472,7 @@ static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
     tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
 }
 
-static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
+static bool tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 {
     vaddr lp_addr = cpu->neg.tlb.d[midx].large_page_addr;
     vaddr lp_mask = cpu->neg.tlb.d[midx].large_page_mask;
@@ -480,12 +480,13 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-    } else {
-        if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
-            tlb_n_used_entries_dec(cpu, midx);
-        }
-        tlb_flush_vtlb_page_locked(cpu, midx, page);
+        return true;
     }
+    if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
+        tlb_n_used_entries_dec(cpu, midx);
+    }
+    tlb_flush_vtlb_page_locked(cpu, midx, page);
+    return false;
 }
 
 /**
@@ -502,13 +503,14 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
                                              MMUIdxMap idxmap)
 {
     int mmu_idx;
+    bool flush_all = false;
 
     assert_cpu_is_self_or_stopped(cpu);
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((idxmap >> mmu_idx) & 1) {
-            tlb_flush_page_locked(cpu, mmu_idx, addr);
+            flush_all |= tlb_flush_page_locked(cpu, mmu_idx, addr);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
@@ -517,8 +519,12 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
      * Discard jump cache entries for any tb which might potentially
      * overlap the flushed page, which includes the previous.
      */
-    tb_jmp_cache_clear_page(cpu, addr - TARGET_PAGE_SIZE);
-    tb_jmp_cache_clear_page(cpu, addr);
+    if (flush_all) {
+        tcg_flush_jmp_cache(cpu);
+    } else {
+        tb_jmp_cache_clear_page(cpu, addr - TARGET_PAGE_SIZE);
+        tb_jmp_cache_clear_page(cpu, addr);
+    }
 }
 
 /**
@@ -624,7 +630,7 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
-static void tlb_flush_range_locked(CPUState *cpu, int midx,
+static bool tlb_flush_range_locked(CPUState *cpu, int midx,
                                    vaddr addr, vaddr len,
                                    unsigned bits)
 {
@@ -644,7 +650,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      */
     if (mask < f->mask || len > f->mask) {
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-        return;
+        return true;
     }
 
     /*
@@ -654,7 +660,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      */
     if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-        return;
+        return true;
     }
 
     for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
@@ -666,6 +672,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
         }
         tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
     }
+    return false;
 }
 
 typedef struct {
@@ -678,6 +685,7 @@ typedef struct {
 static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
                                               TLBFlushRangeData d)
 {
+    bool flush_all = false;
     int mmu_idx;
 
     assert_cpu_is_self_or_stopped(cpu);
@@ -685,7 +693,8 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((d.idxmap >> mmu_idx) & 1) {
-            tlb_flush_range_locked(cpu, mmu_idx, d.addr, d.len, d.bits);
+            flush_all |= tlb_flush_range_locked(cpu, mmu_idx, d.addr,
+                                                d.len, d.bits);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
@@ -694,7 +703,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
      * If the length is larger than the jump cache size, then it will take
      * longer to clear each entry individually than it will to clear it all.
      */
-    if (d.len >= (TARGET_PAGE_SIZE * TB_JMP_CACHE_SIZE)) {
+    if (flush_all || d.len >= (TARGET_PAGE_SIZE * TB_JMP_CACHE_SIZE)) {
         tcg_flush_jmp_cache(cpu);
         return;
     }
-- 
2.53.0


