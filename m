Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5859606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lpBzgE98
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQRx3-00009v-3G; Mon, 09 Nov 2026 11:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQRwv-00007y-TG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:10:26 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQRws-0005pO-HF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:10:25 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8b6a88e4341so489530b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794240620; x=1794845420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=adk1JsPeBW4+Kfln6py+xXiqLaz3hQIK2Unr5QU7qjE=;
 b=lpBzgE983bXiMRorEWArwERM1WI+yhh3conLVkyebY7Fau8WpafamRXVNdw3QxNX2G
 i4WFiB3asMouNoPvSXhrLUPmpfdZHBhSAmWDLIHH22NHn2sCGvF2TcxWFFQinhj4xZl8
 obzOhQMlmgoGQtxZv18bKkatSym777UdjtfpH074uyGPkGgYn894GKrtNzXZ9JfY3wJE
 gAs3GYO7y083OyShjUySFeicW1M0ML7oMcrTP8TTK3ySYaqdIyXNwqpanuNRlJl0tCxH
 9soSpkuGGDMo/Ycy8d2Ciewvk2sEES43rTerwONnHTHwoQYWacRzvKO1U37Ih4EJ2nxE
 dmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240620; x=1794845420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=adk1JsPeBW4+Kfln6py+xXiqLaz3hQIK2Unr5QU7qjE=;
 b=m3OSVi/p1bBjGfDEsQZwoyZ7q5vy3/CKIPaGfrpKep1a6WmvbqVkj0cv5zk8nzUB/n
 hR1ELmTIDFEafQVzJc3iVAYkr2QZq/uVWLS0QOxBzll7tKRtlnvwa+xgJo8tddwp/qGZ
 ZsEy9nuKMXXd9WKDJUxh39IIwPsmOz/OZ8HWv4AfCL3bQbz+iiloNDxbwOJiUOuhqbWm
 a+Fxx9NfBvVPNiOybqEGJZIVuI+jG4WM0IDjsofeynWjAQDA+28LcLXHPDPOQPKbUVv/
 xVP0yY8ZUHAzqdSxB/QlAM3+eW5LSTDF2tIAhX6+7bsla0Wk9UbB8Pz0IhrBclsyju9v
 dQmA==
X-Gm-Message-State: APuU4Z+p3ol/Fng4tWQFFcjUd5LFbeLPXCdCLoSsgA2EcEJNSdrWiMjo
 HXcPhEnygwT7UzT90b4xIm55RB/rVe2/myrFU6wFnI77KLioD05zu7Utv+VXA+gIqLJReDZ+Qp5
 kdKp2
X-Gm-Gg: AYBFou3Z49boIHfJjecZ7wO9HjfGkWoS83LMoZI9lfAAUN/w7E5wmJxDyIh4vm0VU3i
 mQyfsGoIDX3oAlFkTaxDB0EMyzXkNZ8HkWm6nPi6vDD6aihzrIJKTYW+4OPVwegNqRa6tsfHNoc
 rOB39mNSxrMo70YIqzkA+ZWYnJClA1qgDoo8N2XDpyeBIwec+/ohfC8qa/E1TFuMMtKCw8nL2Am
 BCsSGm5cFde0cQsKSKyuIvIrATSu1+xhUNLHlfViAr6VfXq/utVPGpU9vAqywH5DyuVvJBQa7rM
 v83Oq7vYOtpALgrL7pC/GcCmzgfQGrou/E7OkcDX/FoiEkHv3GZIC7XbXAYCs457O89NHdgAijQ
 Jxuk8+aPR6TOMTAkZElBLiUFtG9uDqXb0I38sPg8MB0RY4RrkwW/fJ9IXsxFB8pG9yuGmVXR1DQ
 L8dzNRfvG9wvcbmieXF/1sdhShT+ffYfONGn3ki5FCNGCLQDimmGh3ZnJ71gBdVi5wdw2jyTMOF
 IKFmHki1qPsg5t6sdlHISLDBqxFYhD9fOxixCYKcYK/obcp2+6sIiInmc6pvXB+Yxtrk/3NpTod
 uN1va6MO1ayTUk5Un+/TKKCRWP5vE77owf7fgpl71FO4SoR6J4Q2See3eGwV
X-Received: by 2002:a05:6a00:1d92:b0:8b5:bd06:7aa with SMTP id
 d2e1a72fcca58-8ba83bd0431mr104883b3a.6.1794240619624; 
 Mon, 09 Nov 2026 08:10:19 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b648e55e85sm1598946b3a.17.2026.11.09.08.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:10:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 1/2] accel/tcg: Drop DEBUG_TLB_LOG_GATE
Date: Mon,  9 Nov 2026 08:10:15 -0800
Message-ID: <20261109161016.43218-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109161016.43218-1-richard.henderson@linaro.org>
References: <20261109161016.43218-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These disabled logs could be transformed to trace events
needed at at later date.  Just delete them for now.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 48 ++--------------------------------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dc83f3bad8..efb8fb1f57 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -55,31 +55,15 @@
 #include "backend-ldst.h"
 
 
-/* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
-/* #define DEBUG_TLB */
-/* #define DEBUG_TLB_LOG */
+/* DEBUG defines */
+#define DEBUG_TLB
 
 #ifdef DEBUG_TLB
 # define DEBUG_TLB_GATE 1
-# ifdef DEBUG_TLB_LOG
-#  define DEBUG_TLB_LOG_GATE 1
-# else
-#  define DEBUG_TLB_LOG_GATE 0
-# endif
 #else
 # define DEBUG_TLB_GATE 0
-# define DEBUG_TLB_LOG_GATE 0
 #endif
 
-#define tlb_debug(fmt, ...) do { \
-    if (DEBUG_TLB_LOG_GATE) { \
-        qemu_log_mask(CPU_LOG_MMU, "%s: " fmt, __func__, \
-                      ## __VA_ARGS__); \
-    } else if (DEBUG_TLB_GATE) { \
-        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
-    } \
-} while (0)
-
 #define assert_cpu_is_self(cpu) do {                              \
         if (DEBUG_TLB_GATE) {                                     \
             g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
@@ -375,8 +359,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
-
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
 
     all_dirty = cpu->neg.tlb.c.dirty;
@@ -409,8 +391,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
 void tlb_flush_by_mmuidx(CPUState *cpu, MMUIdxMap idxmap)
 {
-    tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
-
     assert_cpu_is_self(cpu);
 
     tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
@@ -425,8 +405,6 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, MMUIdxMap idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
 
-    tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
-
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
 }
@@ -507,9 +485,6 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
-        tlb_debug("forcing full flush midx %d (%016"
-                  VADDR_PRIx "/%016" VADDR_PRIx ")\n",
-                  midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
     } else {
         if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
@@ -536,8 +511,6 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page addr: %016" VADDR_PRIx " mmu_map:0x%x\n", addr, idxmap);
-
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((idxmap >> mmu_idx) & 1) {
@@ -600,8 +573,6 @@ static void tlb_flush_page_by_mmuidx_async_2(CPUState *cpu,
 
 void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, MMUIdxMap idxmap)
 {
-    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
-
     assert_cpu_is_self(cpu);
 
     /* This should already be page aligned */
@@ -619,8 +590,6 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               vaddr addr,
                                               MMUIdxMap idxmap)
 {
-    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
-
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
 
@@ -680,9 +649,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      * test all of the entries in the TLB than it will to flush it all.
      */
     if (mask < f->mask || len > f->mask) {
-        tlb_debug("forcing full flush midx %d ("
-                  "%016" VADDR_PRIx "/%016" VADDR_PRIx "+%016" VADDR_PRIx ")\n",
-                  midx, addr, mask, len);
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
         return;
     }
@@ -693,9 +659,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      * we only need to test the end of the range.
      */
     if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
-        tlb_debug("forcing full flush midx %d ("
-                  "%016" VADDR_PRIx "/%016" VADDR_PRIx ")\n",
-                  midx, d->large_page_addr, d->large_page_mask);
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
         return;
     }
@@ -725,9 +688,6 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("range: %016" VADDR_PRIx "/%u+%016" VADDR_PRIx " mmu_map:0x%x\n",
-              d.addr, d.bits, d.len, d.idxmap);
-
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((d.idxmap >> mmu_idx) & 1) {
@@ -1053,10 +1013,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                                                 &xlat, &sz, full->attrs, &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
-    tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
-              " prot=%x idx=%d\n",
-              addr, full->phys_addr, prot, mmu_idx);
-
     read_flags = full->tlb_fill_flags;
     if (full->lg_page_size < TARGET_PAGE_BITS) {
         /* Repeat the MMU check and TLB fill on every access.  */
-- 
2.53.0


