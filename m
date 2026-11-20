Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6A606A6B3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wr6wQqQg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUXSM-0000Yi-Sk; Fri, 20 Nov 2026 17:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSK-0000X0-Fj
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSI-00051y-DO
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:44 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2f03920c477so12404665ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795215101; x=1795819901; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ro7C8Tb4QJHDkDcoichpXiH+G9Xf7ODWN4DUZP9w2RI=;
 b=wr6wQqQgUgj8xv7tqb1YcoU75E6Qx1RWyuJE58eLogWskR0tpnKnNhE6pf8k1WOQDW
 kXqoLL51Dfh7dX8tQT6Y9sVsdGzcBjjDvQc9cHvTo0ZivRhUwIjAaGg0YLeiHTp7DWay
 1/SkwbyCHGxY8Pul/CL+h0RI5znvo1XMRSObRg1IfsbqnD5sikmd1qvsjPMNJDu0izBI
 juk9DVaV0wUKbIpc2+5U9xMykHeOJ6GhYRvDZ1DGlAGq4zlAVr5ZIUI9nd6NsD+YjQUX
 eokFS+Mf4bEnJocz6YKfVlMhFmgNcyioIajShnqrEIvHAu+dQ6W91hzR8aWK1JneNUal
 X/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795215101; x=1795819901;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ro7C8Tb4QJHDkDcoichpXiH+G9Xf7ODWN4DUZP9w2RI=;
 b=UOtHUzo8T051ya9T1fjm+Wj/6oGj5ffmEdWPiwUbAp9FRQbR1TZStDyKYJ/nkgEzTM
 BsRaov2hMTJZHxSGDCu6h46tHt0Dl7l7b9a/vj+ixjl0WfXDxCJUyySe+HNveeHN4dwz
 cFKWNvs45YgyCtJZL0v6oa8YxrBFHk3ZKFVIWy2KwH2wTMAO1in68A0bPGVdrmZuIBDg
 eBJeaKb3NXBN4jYkg+iPWf6rmQ0vd0zOdv0t5OzTD6c82a54qFCEmFSgw4s/QufvwCjP
 fLaZUlXXwBVQpN0J1lvSLvPN//ALzAS+s04J8mWhb+9zKfTVr1izL1nOYmi9u10xiS1r
 m0OQ==
X-Gm-Message-State: APuU4Z+ZdtbXTfDtXztN5p9mJ2GUYA02mz3cyF8hroYpEayS2w4w2hgx
 f+heLrR2ha3xqawQolFAuoxBZuTzFIgSpetH+dHQ7AGaA3MmiWUfBo8N4kZ6Ts/Ajb9N/wlePlB
 KAFl5
X-Gm-Gg: AZFdTZcxmoO6DIB4P8tYi2A9EK44yaamr01VSycUU8bi/2DEs2JKNJod8xFjBlbgE6g
 82StTfE+G8+W8g+Sf+SzVU4YW+7FU3x6SSNBvqwnygjubPPOgGGl2UCrtknxC7vkdZXfT52gQHs
 3lU4MGTSkU3SwUz1ZMbYZld6yP2QQdn8zhsiXEBCgrjpzibtKEWoscT3EnduJ8a46Ck1lL2qjjj
 VmqtR+vYSx9lXwNBHi2DRrN65Z3fxkS3oG/eRDbMUrEDBzNi2NTR/Hg9On/01BW77OO0GwVu2VC
 IYMZF8vJqAHMbZzV5FQO3nzkCHWbkrooI7qWwPQgfEEUjVl6plGsfh/xldFM1mZ3r9zd2ZxHfMs
 jOhWSDi3MyvxXfyzFv6IQGmV7DFaLe6PEwhvUzzfuyYR77xaGDkFtRhNihpV2waM8LppBbXNsLd
 3soME2rte1dOpCS0lfbU0tmw1N30CXi6Gv853yRPfoA1j9KMJn1m3d7P+rvDBc8CWHfLlTIrZ2e
 Casq47mcgPg507m8e8FjDw5pj5tSQIXViINzId+NNUQo9xYhmE8xlkIEQ4FVPJnboFITjLeK02w
 QWP2WWZHsMD6sXICMzL3HAuaYmQshV+HJ9Mktlym2rPjXjKjOA8d4uzi8/GLazeKdETHIt66Wls
 0/ClCSQ==
X-Received: by 2002:a17:903:2450:b0:2ef:f312:b848 with SMTP id
 d9443c01a7336-2f03f16ca8emr50658685ad.48.1795215101042; 
 Fri, 20 Nov 2026 14:51:41 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0433a3a43sm15669055ad.62.2026.11.20.14.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:51:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 3/5] accel/tcg: Fix jump cache flush after large page flush
Date: Fri, 20 Nov 2026 14:51:36 -0800
Message-ID: <20261120225138.7198-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120225138.7198-1-richard.henderson@linaro.org>
References: <20261120225138.7198-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/cputlb.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3ca484b039..d79eae58df 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -472,7 +472,8 @@ static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
     tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
 }
 
-static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
+/* Return true if the entire tlb was flushed. */
+static bool tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 {
     vaddr lp_addr = cpu->neg.tlb.d[midx].large_page_addr;
     vaddr lp_mask = cpu->neg.tlb.d[midx].large_page_mask;
@@ -480,12 +481,13 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
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
@@ -502,13 +504,14 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
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
@@ -517,8 +520,12 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
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
@@ -624,7 +631,8 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
-static void tlb_flush_range_locked(CPUState *cpu, int midx,
+/* Return true if the entire tlb was flushed. */
+static bool tlb_flush_range_locked(CPUState *cpu, int midx,
                                    vaddr addr, vaddr len,
                                    unsigned bits)
 {
@@ -644,7 +652,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      */
     if (mask < f->mask || len > f->mask) {
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-        return;
+        return true;
     }
 
     /*
@@ -654,7 +662,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      */
     if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-        return;
+        return true;
     }
 
     for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
@@ -666,6 +674,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
         }
         tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
     }
+    return false;
 }
 
 typedef struct {
@@ -678,6 +687,7 @@ typedef struct {
 static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
                                               TLBFlushRangeData d)
 {
+    bool flush_all = false;
     int mmu_idx;
 
     assert_cpu_is_self_or_stopped(cpu);
@@ -685,7 +695,8 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((d.idxmap >> mmu_idx) & 1) {
-            tlb_flush_range_locked(cpu, mmu_idx, d.addr, d.len, d.bits);
+            flush_all |= tlb_flush_range_locked(cpu, mmu_idx, d.addr,
+                                                d.len, d.bits);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
@@ -694,7 +705,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
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


