Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A8606A69D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JyYXOzik
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUXSL-0000XI-3k; Fri, 20 Nov 2026 17:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSI-0000W6-Vy
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:43 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSH-00051p-4y
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:42 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2f048476ab9so8426505ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795215100; x=1795819900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4mfywixBu8XIDUthKgWSc/tv6kkHJlGIqcsD/as65z8=;
 b=JyYXOzikBSoevqoyKZJADHsf/sKZV7NR+CpvIhplg+SXAauIhi7mihDi4u/0O140wN
 AXe6RWGKK4jd7uHe8oZbpcxCNF/vzy4+T7/QMfzxJenJq7XOo8CqL0WmSP41KLF1HqiS
 HRmTBDMz6jBtmB1U2qFpj7YTizdJhp5wdtbnLhJxtTRlNRAep19odbVLGGw0rkg+RPpi
 uxWqIAig97aRJ7rkyYTi0rRjao79M8Ep/VGYo1wufkSPQ4T/2hgnQEKv9Sxee3AfwLVw
 owecxVryGyBKOU6lY2xv7+mTfmROz5Ld/20tou3Pmbwr9N7CvZKehaOM+dOz8xCe2U6X
 pIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795215100; x=1795819900;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4mfywixBu8XIDUthKgWSc/tv6kkHJlGIqcsD/as65z8=;
 b=yqln8tUHGQB759h/rFUl6IHynUgBuayOeK137n2IK2vRGPBLS0ogLGU+62B86Z6yO8
 GLhceSj2C3iw+Dh2O9b8rwxyW4C64JdiVWqrCZr+Qq9J+gQtnIsla/M209g1wKDeMpeB
 CQCEL9Ox8DwPpmqG8zjYJp23ju6gcRr/sxNL0iS6su71pXsmXfU3vqOLLdTU8I73u6+a
 Jit01ej9Nb+C2wYVOYZl22f+t6SUguUZz+IL+5Rxqcx/JL7ADtwBd/DAUi9NaYP4BQ0K
 0gXqKOiQgDm5SCf3PAkrjc0ie8uoEujV5gngS1+0pOBXvVhorCz+inp7GE1OOD/Rz0D5
 T0Fw==
X-Gm-Message-State: APuU4Z+Cor/D6djCUvab7fGJZqgnXGtvefqLzQfue3GipnSBcNNDPe3N
 ojAEupeAI8NAhs7oAPotdJWcpckWrf/1gbEeDauKNCaDWCVWqlgm0KSLwR3IFs2fvH9Hx5LDUxy
 hozJ8
X-Gm-Gg: AZFdTZeKqmStZXA+yMIBzhfy8XpJxH4Q5aL1/vB0t+z82zata5otn7AvudZqSNLhxsa
 IvtkE6z0/fkZJUgl0Un94WfJv/mDskTIh1ggGnzZaHifIfXOqmHTV4IeoakfL62SBqY1uLuwCtv
 KsscmsAqLToSe4h7APOYyvjAjNZBRrbEHbbYZUXERGOH+HsuPAh0zG61gNK5ZsHAo57V5gYFbYw
 gpXq+dkkF/x5WMn9ZC1NPGYI2ZwbIuFB4J+E5G6uBE5O3bpekeLlr06CZ+DQjRijx2kfENBjMDW
 Pb1d4hrzp4g/dO4ikdbuKghmLKl0dQqbvpESgmItt9vVfr2jklRPdOVxJLUUJdb8gWDPXnzjVyp
 HzOMYyA9kMynFWgvG9P71D/zPgf2kNzShR0YI2EEBu4RnttNHxbI8FAlZSFD5/6/oCWM5o60gZN
 D9xn71N3W8ZOUYnzrCXZ9iX2g9jLaKe+X3MaH3z6Y/6JsbR1DZ6iBcX5rrIHfRru46zN7qkA876
 JkxMGILNAc7CGEMBmsdWFpL2cBteov33KgEn6omVcrZa874TNzS1lNEz3OYMXt+qxbzk/mIG9If
 TofHgEw0q1oIzbClzeSZ0yK305MVcvqpFnh1g8qOO3x2vljscId77wsD35hAxQ==
X-Received: by 2002:a17:902:f70f:b0:2ef:e1a8:ef1f with SMTP id
 d9443c01a7336-2f03ef44b2emr44338125ad.5.1795215099616; 
 Fri, 20 Nov 2026 14:51:39 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0433a3a43sm15669055ad.62.2026.11.20.14.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:51:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/5] accel/tcg: Drop DEBUG_TLB_LOG_GATE
Date: Fri, 20 Nov 2026 14:51:34 -0800
Message-ID: <20261120225138.7198-2-richard.henderson@linaro.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These disabled logs could be transformed to trace events
needed at at later date.  Just delete them for now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


