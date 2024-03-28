Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FBAC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 05:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpiMi-0000rj-DX; Thu, 28 Mar 2024 01:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMf-0000rC-MG; Thu, 28 Mar 2024 01:31:49 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMd-0008U6-6g; Thu, 28 Mar 2024 01:31:49 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso341872a12.2; 
 Wed, 27 Mar 2024 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711603905; x=1712208705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLe7MoYc/51z8mNQf8kAXAmjjbRb31oNJF+RZzZQ1zM=;
 b=WQdriyA7bAiN+qpWKJ9TkQmZXm2Y5ak2DDWJiYkxWdpvBmiU41goI7sZXDOilYb+5s
 8Ttdn/31cpodHEcwJk8UFFFfEZtP9QZDdqhhB2z2oTNoJo+iorE9zKWRRyxmfmcsBVw0
 W/Y1dQly86n50gvI7Q3a1HW3Qsehf7LXujwUkRiuE1QeVwcOo05x9uGk/DGvn3n3Iz8C
 k8MBI7FZkqtUy0flNNgPbXuj1vR30/AQc0b1zF9RcFg3z0DYffs3t2ET2o+tZWXCd1M5
 mbIeh53pR6JXUXxYVUBQdlMSg8LTcxhoR5uQPHJdOB0VOsX6Gzn9HQhnvmI31+3pGDCa
 nPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711603905; x=1712208705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLe7MoYc/51z8mNQf8kAXAmjjbRb31oNJF+RZzZQ1zM=;
 b=cCX8AcvRTVim3z8Lboe2CtfWWQXmRdCRiCUI2t+Vp7IxsVoRkiCtkSui+nedbls3cZ
 AEJoYaV5UjyCu5t7YavtVdgP6r5HmFWnS8o2FRa8cU9sbl+XytLGsktQzi3ireVczxO5
 ZbOnuqTPs96Y8qBrf6aqWAPfF0/V9o6muX75Jx3Vb5mFf8KSw8NTXHMDhyDC/vcuuIsX
 R8BCt414XZyJSm8zFViLZyqSnCmXB1QLfCKrxT2bOBgdiK5C79kNssfI1ILHhek2FnBK
 cfRWO+suGd+EE0vBOE2aD/fPIW3PCD83ybasutYfR+UNCkneAE0ceOZD9Ljm2jLTQzbM
 XIJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+KIGtV+S67+X0REcq3qTKcl8Mqad7v2Bxws8FBmXw5yoAY6RmW1pgU3J1NHpxLcKjWHwjgofP6+LiI+DJpGZpZmA0Ymg=
X-Gm-Message-State: AOJu0Yyew9Ynkq3AippBkSGYCtMxFOEpZ73VRskBsEe6syM65XvqMGSe
 SVjU4PMczwTGv9MitIwT3yS3ij8MXkX2IPYSsQ9j14anOfH1EJzkB9mSVJ39G3U=
X-Google-Smtp-Source: AGHT+IGABe57sLDM47Kk6bBspIS9HKK3Pr3gbAtTj8hqghXshy5wiDcy/f+YlLQzxMkHSaOSwOmksg==
X-Received: by 2002:a17:902:ea09:b0:1db:8fd6:915e with SMTP id
 s9-20020a170902ea0900b001db8fd6915emr1979836plg.33.1711603905170; 
 Wed, 27 Mar 2024 22:31:45 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a170902654d00b001e211a290efsm535018pln.132.2024.03.27.22.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 22:31:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/3] tcg/cputlb: Remove non-synced variants of global TLB
 flushes
Date: Thu, 28 Mar 2024 15:31:30 +1000
Message-ID: <20240328053131.2604454-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240328053131.2604454-1-npiggin@gmail.com>
References: <20240328053131.2604454-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

These are no longer used.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/multi-thread-tcg.rst |  13 ++--
 include/exec/exec-all.h         |  97 +++++-------------------------
 accel/tcg/cputlb.c              | 103 --------------------------------
 3 files changed, 19 insertions(+), 194 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 1420789fff..d706c27ea7 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -205,15 +205,10 @@ DESIGN REQUIREMENTS:
 
 (Current solution)
 
-We have updated cputlb.c to defer operations when a cross-vCPU
-operation with async_run_on_cpu() which ensures each vCPU sees a
-coherent state when it next runs its work (in a few instructions
-time).
-
-A new set up operations (tlb_flush_*_all_cpus) take an additional flag
-which when set will force synchronisation by setting the source vCPUs
-work as "safe work" and exiting the cpu run loop. This ensure by the
-time execution restarts all flush operations have completed.
+A new set of tlb flush operations (tlb_flush_*_all_cpus_synced) force
+synchronisation by setting the source vCPUs work as "safe work" and
+exiting the cpu run loop. This ensures that by the time execution
+restarts all flush operations have completed.
 
 TLB flag updates are all done atomically and are also protected by the
 corresponding page lock.
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3e53501691..7cf9faa63f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -66,24 +66,15 @@ void tlb_destroy(CPUState *cpu);
  */
 void tlb_flush_page(CPUState *cpu, vaddr addr);
 /**
- * tlb_flush_page_all_cpus:
+ * tlb_flush_page_all_cpus_synced:
  * @cpu: src CPU of the flush
  * @addr: virtual address of page to be flushed
  *
- * Flush one page from the TLB of the specified CPU, for all
+ * Flush one page from the TLB of all CPUs, for all
  * MMU indexes.
- */
-void tlb_flush_page_all_cpus(CPUState *src, vaddr addr);
-/**
- * tlb_flush_page_all_cpus_synced:
- * @cpu: src CPU of the flush
- * @addr: virtual address of page to be flushed
  *
- * Flush one page from the TLB of the specified CPU, for all MMU
- * indexes like tlb_flush_page_all_cpus except the source vCPUs work
- * is scheduled as safe work meaning all flushes will be complete once
- * the source vCPUs safe work is complete. This will depend on when
- * the guests translation ends the TB.
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
 /**
@@ -96,19 +87,14 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
  * use one of the other functions for efficiency.
  */
 void tlb_flush(CPUState *cpu);
-/**
- * tlb_flush_all_cpus:
- * @cpu: src CPU of the flush
- */
-void tlb_flush_all_cpus(CPUState *src_cpu);
 /**
  * tlb_flush_all_cpus_synced:
  * @cpu: src CPU of the flush
  *
- * Like tlb_flush_all_cpus except this except the source vCPUs work is
- * scheduled as safe work meaning all flushes will be complete once
- * the source vCPUs safe work is complete. This will depend on when
- * the guests translation ends the TB.
+ * Flush the entire TLB for all CPUs, for all MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_all_cpus_synced(CPUState *src_cpu);
 /**
@@ -123,27 +109,16 @@ void tlb_flush_all_cpus_synced(CPUState *src_cpu);
 void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
                               uint16_t idxmap);
 /**
- * tlb_flush_page_by_mmuidx_all_cpus:
+ * tlb_flush_page_by_mmuidx_all_cpus_synced:
  * @cpu: Originating CPU of the flush
  * @addr: virtual address of page to be flushed
  * @idxmap: bitmap of MMU indexes to flush
  *
  * Flush one page from the TLB of all CPUs, for the specified
  * MMU indexes.
- */
-void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                       uint16_t idxmap);
-/**
- * tlb_flush_page_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
  *
- * Flush one page from the TLB of all CPUs, for the specified MMU
- * indexes like tlb_flush_page_by_mmuidx_all_cpus except the source
- * vCPUs work is scheduled as safe work meaning all flushes will be
- * complete once  the source vCPUs safe work is complete. This will
- * depend on when the guests translation ends the TB.
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
                                               uint16_t idxmap);
@@ -158,24 +133,15 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
  */
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
 /**
- * tlb_flush_by_mmuidx_all_cpus:
+ * tlb_flush_by_mmuidx_all_cpus_synced:
  * @cpu: Originating CPU of the flush
  * @idxmap: bitmap of MMU indexes to flush
  *
- * Flush all entries from all TLBs of all CPUs, for the specified
+ * Flush all entries from the TLB of all CPUs, for the specified
  * MMU indexes.
- */
-void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @idxmap: bitmap of MMU indexes to flush
  *
- * Flush all entries from all TLBs of all CPUs, for the specified
- * MMU indexes like tlb_flush_by_mmuidx_all_cpus except except the source
- * vCPUs work is scheduled as safe work meaning all flushes will be
- * complete once  the source vCPUs safe work is complete. This will
- * depend on when the guests translation ends the TB.
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
 
@@ -192,8 +158,6 @@ void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
                                    uint16_t idxmap, unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
-void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                            uint16_t idxmap, unsigned bits);
 void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
     (CPUState *cpu, vaddr addr, uint16_t idxmap, unsigned bits);
 
@@ -213,9 +177,6 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
                                unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
-void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                        vaddr len, uint16_t idxmap,
-                                        unsigned bits);
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                vaddr addr,
                                                vaddr len,
@@ -288,18 +249,12 @@ static inline void tlb_destroy(CPUState *cpu)
 static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
 }
-static inline void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
-{
-}
 static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
 {
 }
 static inline void tlb_flush(CPUState *cpu)
 {
 }
-static inline void tlb_flush_all_cpus(CPUState *src_cpu)
-{
-}
 static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
 {
 }
@@ -311,20 +266,11 @@ static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
 static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
 }
-static inline void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu,
-                                                     vaddr addr,
-                                                     uint16_t idxmap)
-{
-}
 static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                             vaddr addr,
                                                             uint16_t idxmap)
 {
 }
-static inline void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap)
-{
-}
-
 static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
@@ -335,12 +281,6 @@ static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
                                                  unsigned bits)
 {
 }
-static inline void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu,
-                                                          vaddr addr,
-                                                          uint16_t idxmap,
-                                                          unsigned bits)
-{
-}
 static inline void
 tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
                                               uint16_t idxmap, unsigned bits)
@@ -351,13 +291,6 @@ static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
                                              unsigned bits)
 {
 }
-static inline void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu,
-                                                      vaddr addr,
-                                                      vaddr len,
-                                                      uint16_t idxmap,
-                                                      unsigned bits)
-{
-}
 static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                              vaddr addr,
                                                              vaddr len,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 93b1ca810b..8ff3aa5e50 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -379,21 +379,6 @@ void tlb_flush(CPUState *cpu)
     tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
 }
 
-void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
-{
-    const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
-
-    tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
-
-    flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
-    fn(src_cpu, RUN_ON_CPU_HOST_INT(idxmap));
-}
-
-void tlb_flush_all_cpus(CPUState *src_cpu)
-{
-    tlb_flush_by_mmuidx_all_cpus(src_cpu, ALL_MMUIDX_BITS);
-}
-
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
@@ -604,46 +589,6 @@ void tlb_flush_page(CPUState *cpu, vaddr addr)
     tlb_flush_page_by_mmuidx(cpu, addr, ALL_MMUIDX_BITS);
 }
 
-void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, vaddr addr,
-                                       uint16_t idxmap)
-{
-    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
-
-    /* This should already be page aligned */
-    addr &= TARGET_PAGE_MASK;
-
-    /*
-     * Allocate memory to hold addr+idxmap only when needed.
-     * See tlb_flush_page_by_mmuidx for details.
-     */
-    if (idxmap < TARGET_PAGE_SIZE) {
-        flush_all_helper(src_cpu, tlb_flush_page_by_mmuidx_async_1,
-                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
-    } else {
-        CPUState *dst_cpu;
-
-        /* Allocate a separate data block for each destination cpu.  */
-        CPU_FOREACH(dst_cpu) {
-            if (dst_cpu != src_cpu) {
-                TLBFlushPageByMMUIdxData *d
-                    = g_new(TLBFlushPageByMMUIdxData, 1);
-
-                d->addr = addr;
-                d->idxmap = idxmap;
-                async_run_on_cpu(dst_cpu, tlb_flush_page_by_mmuidx_async_2,
-                                 RUN_ON_CPU_HOST_PTR(d));
-            }
-        }
-    }
-
-    tlb_flush_page_by_mmuidx_async_0(src_cpu, addr, idxmap);
-}
-
-void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
-{
-    tlb_flush_page_by_mmuidx_all_cpus(src, addr, ALL_MMUIDX_BITS);
-}
-
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               vaddr addr,
                                               uint16_t idxmap)
@@ -835,54 +780,6 @@ void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
     tlb_flush_range_by_mmuidx(cpu, addr, TARGET_PAGE_SIZE, idxmap, bits);
 }
 
-void tlb_flush_range_by_mmuidx_all_cpus(CPUState *src_cpu,
-                                        vaddr addr, vaddr len,
-                                        uint16_t idxmap, unsigned bits)
-{
-    TLBFlushRangeData d;
-    CPUState *dst_cpu;
-
-    /*
-     * If all bits are significant, and len is small,
-     * this devolves to tlb_flush_page.
-     */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
-        tlb_flush_page_by_mmuidx_all_cpus(src_cpu, addr, idxmap);
-        return;
-    }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx_all_cpus(src_cpu, idxmap);
-        return;
-    }
-
-    /* This should already be page aligned */
-    d.addr = addr & TARGET_PAGE_MASK;
-    d.len = len;
-    d.idxmap = idxmap;
-    d.bits = bits;
-
-    /* Allocate a separate data block for each destination cpu.  */
-    CPU_FOREACH(dst_cpu) {
-        if (dst_cpu != src_cpu) {
-            TLBFlushRangeData *p = g_memdup(&d, sizeof(d));
-            async_run_on_cpu(dst_cpu,
-                             tlb_flush_range_by_mmuidx_async_1,
-                             RUN_ON_CPU_HOST_PTR(p));
-        }
-    }
-
-    tlb_flush_range_by_mmuidx_async_0(src_cpu, d);
-}
-
-void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *src_cpu,
-                                            vaddr addr, uint16_t idxmap,
-                                            unsigned bits)
-{
-    tlb_flush_range_by_mmuidx_all_cpus(src_cpu, addr, TARGET_PAGE_SIZE,
-                                       idxmap, bits);
-}
-
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                                vaddr addr,
                                                vaddr len,
-- 
2.42.0


