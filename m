Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8905D637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOTK-0003WG-N0; Wed, 13 Nov 2024 20:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSd-00028j-VY
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSW-0002pF-0c
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:50 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso883485e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546940; x=1732151740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDUBQb+LxmlUYEklKQILqed81KQyLLFPtXCqT+KpbiI=;
 b=NJi5hp/o+RYFJPs4ddXr6H9banLmcktiO4rRRFZnaOADe7R5c0XlB7OLeAkPwv8wrf
 iUc6Knaknm00TIxoHm6m54V376otS/grGHPNUFNJx9w5Sq3/pgY1n64pD0bQjhCFC90e
 OqO3lc/qRying14xQox0lsBS5lK7zBw+MgaAW4ImjXNHwfGdYk05bbFOnDj25B5wWVPB
 D8dbKVzOUciyfHcvFI/csoKpxh7enrc6oC0IdVRR4CYZ3Vc+154OlS5qLB4frK+48FLQ
 Y1qm36x/wqlOiiyDe37wMHuMozeCFjBi3/BeAn7pmg+x9Oejmq2ZbM5XTelquIKiRafD
 kHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546940; x=1732151740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDUBQb+LxmlUYEklKQILqed81KQyLLFPtXCqT+KpbiI=;
 b=Yp+WnbfdSe3O/UWqgUAtCCeg4Elp3E0zwT63V/NhOBb6UGuBJ7pv6n9Dy/Z2MZH6aG
 uQ+8iVK9W4QFBYaIypiCHj7Yziwfpckqy2tZ6todIcETYw/G9hfoYpKhdeEDNR3NXpev
 +7m5Obfc1mUXWWzkcIPAZ3tioSQ2G2+N3XmMS0XC0Ad4hXjaqb1Qoomm24jSG2u8MiY1
 JiSoSme2Za9RqKHax3PYTe3oViUuHWs0XUEDfEPeUBPmABH3bblaUNNns0xJhniGVYCJ
 qD2HW/PeGD18PhwodMjYLFvX+lyk0Ja7oB9q8iy9Eo7i6PiB5439Mpl/Wi0+4gOW5Ajl
 RmqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWu9rbW+crDXBBzQVMkW12qNM/kBYgctC1I/AexwFLzyMtzEiAxwRUQ8CsqLfSwLoq9D0ssZ2D3Z9X@nongnu.org
X-Gm-Message-State: AOJu0Yw+vkba+Kz8VyJ4AGOonbOanRTqWUN67zCkVwgyZh1p65FILtRH
 VA61oO4cZruDawxnFPtoNwS+xpBajLBruADgn7sqraUPXgjAsM4nKxO23+gGVsM=
X-Google-Smtp-Source: AGHT+IE1pgEYEqJGScSPvTrOip5pjtAnThnKSK1k4RMPDyxAX2xOyGVmGe7ZEJEGkqa83irxnX/itQ==
X-Received: by 2002:a05:600c:1c1d:b0:431:5957:27e8 with SMTP id
 5b1f17b1804b1-432d4ad89a3mr36745965e9.28.1731546939922; 
 Wed, 13 Nov 2024 17:15:39 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab7878esm1544405e9.14.2024.11.13.17.15.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/24] exec: Declare tlb_flush*() in 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:13:03 +0100
Message-ID: <20241114011310.3615-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h                | 187 +++++++++++++++++++++++++++
 include/exec/exec-all.h              | 183 --------------------------
 accel/tcg/tcg-accel-ops.c            |   1 +
 cpu-target.c                         |   1 +
 hw/intc/armv7m_nvic.c                |   2 +-
 hw/ppc/spapr_nested.c                |   1 +
 hw/sh4/sh7750.c                      |   1 +
 system/watchpoint.c                  |   2 +-
 target/alpha/helper.c                |   2 +-
 target/alpha/sys_helper.c            |   2 +-
 target/arm/helper.c                  |   1 +
 target/avr/helper.c                  |   2 +-
 target/hppa/mem_helper.c             |   1 +
 target/i386/helper.c                 |   1 +
 target/i386/machine.c                |   2 +-
 target/i386/tcg/fpu_helper.c         |   2 +-
 target/i386/tcg/misc_helper.c        |   2 +-
 target/i386/tcg/sysemu/misc_helper.c |   2 +-
 target/i386/tcg/sysemu/svm_helper.c  |   2 +-
 target/loongarch/tcg/csr_helper.c    |   2 +-
 target/loongarch/tcg/tlb_helper.c    |   2 +-
 target/m68k/helper.c                 |   2 +-
 target/microblaze/mmu.c              |   2 +-
 target/mips/sysemu/cp0.c             |   2 +-
 target/mips/tcg/sysemu/cp0_helper.c  |   2 +-
 target/mips/tcg/sysemu/tlb_helper.c  |   2 +-
 target/openrisc/mmu.c                |   2 +-
 target/openrisc/sys_helper.c         |   1 +
 target/ppc/helper_regs.c             |   2 +-
 target/ppc/misc_helper.c             |   1 +
 target/ppc/mmu_helper.c              |   1 +
 target/riscv/cpu_helper.c            |   2 +-
 target/riscv/csr.c                   |   1 +
 target/riscv/op_helper.c             |   1 +
 target/riscv/pmp.c                   |   2 +-
 target/rx/cpu.c                      |   2 +-
 target/s390x/gdbstub.c               |   2 +-
 target/s390x/sigp.c                  |   2 +-
 target/s390x/tcg/excp_helper.c       |   1 +
 target/s390x/tcg/mem_helper.c        |   1 +
 target/s390x/tcg/misc_helper.c       |   1 +
 target/sh4/helper.c                  |   2 +-
 target/sparc/ldst_helper.c           |   1 +
 target/tricore/helper.c              |   2 +-
 target/xtensa/helper.c               |   2 +-
 target/xtensa/mmu_helper.c           |   1 +
 46 files changed, 231 insertions(+), 210 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 9075d94ec5..07c4bc669e 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -39,6 +39,141 @@ void tlb_init(CPUState *cpu);
  */
 void tlb_destroy(CPUState *cpu);
 
+/**
+ * tlb_flush_page:
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all
+ * MMU indexes.
+ */
+void tlb_flush_page(CPUState *cpu, vaddr addr);
+
+/**
+ * tlb_flush_page_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of all CPUs, for all
+ * MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
+
+/**
+ * tlb_flush:
+ * @cpu: CPU whose TLB should be flushed
+ *
+ * Flush the entire TLB for the specified CPU. Most CPU architectures
+ * allow the implementation to drop entries from the TLB at any time
+ * so this is generally safe. If more selective flushing is required
+ * use one of the other functions for efficiency.
+ */
+void tlb_flush(CPUState *cpu);
+
+/**
+ * tlb_flush_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ *
+ * Flush the entire TLB for all CPUs, for all MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_all_cpus_synced(CPUState *src_cpu);
+
+/**
+ * tlb_flush_page_by_mmuidx:
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of the specified CPU, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
+                              uint16_t idxmap);
+
+/**
+ * tlb_flush_page_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of all CPUs, for the specified
+ * MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                              uint16_t idxmap);
+
+/**
+ * tlb_flush_by_mmuidx:
+ * @cpu: CPU whose TLB should be flushed
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from the TLB of the specified CPU, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
+
+/**
+ * tlb_flush_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from the TLB of all CPUs, for the specified
+ * MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
+
+/**
+ * tlb_flush_page_bits_by_mmuidx
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of mmu indexes to flush
+ * @bits: number of significant bits in address
+ *
+ * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
+ */
+void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
+                                   uint16_t idxmap, unsigned bits);
+
+/* Similarly, with broadcast and syncing. */
+void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                                   uint16_t idxmap,
+                                                   unsigned bits);
+
+/**
+ * tlb_flush_range_by_mmuidx
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of the start of the range to be flushed
+ * @len: length of range to be flushed
+ * @idxmap: bitmap of mmu indexes to flush
+ * @bits: number of significant bits in address
+ *
+ * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
+ * comparing only the low @bits worth of each virtual page.
+ */
+void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                               vaddr len, uint16_t idxmap,
+                               unsigned bits);
+
+/* Similarly, with broadcast and syncing. */
+void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                               vaddr addr,
+                                               vaddr len,
+                                               uint16_t idxmap,
+                                               unsigned bits);
+
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
 
@@ -50,6 +185,58 @@ static inline void tlb_init(CPUState *cpu)
 static inline void tlb_destroy(CPUState *cpu)
 {
 }
+static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
+{
+}
+static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
+{
+}
+static inline void tlb_flush(CPUState *cpu)
+{
+}
+static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
+{
+}
+static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
+                                            vaddr addr, uint16_t idxmap)
+{
+}
+
+static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                            vaddr addr,
+                                                            uint16_t idxmap)
+{
+}
+static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                       uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
+                                                 vaddr addr,
+                                                 uint16_t idxmap,
+                                                 unsigned bits)
+{
+}
+static inline void
+tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                              uint16_t idxmap, unsigned bits)
+{
+}
+static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                                             vaddr len, uint16_t idxmap,
+                                             unsigned bits)
+{
+}
+static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                             vaddr addr,
+                                                             vaddr len,
+                                                             uint16_t idxmap,
+                                                             unsigned bits)
+{
+}
 
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2e58540005..36dbc191cd 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -46,189 +46,6 @@ static inline bool cpu_loop_exit_requested(CPUState *cpu)
     return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
 }
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-/**
- * tlb_flush_page:
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- *
- * Flush one page from the TLB of the specified CPU, for all
- * MMU indexes.
- */
-void tlb_flush_page(CPUState *cpu, vaddr addr);
-/**
- * tlb_flush_page_all_cpus_synced:
- * @cpu: src CPU of the flush
- * @addr: virtual address of page to be flushed
- *
- * Flush one page from the TLB of all CPUs, for all
- * MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
-/**
- * tlb_flush:
- * @cpu: CPU whose TLB should be flushed
- *
- * Flush the entire TLB for the specified CPU. Most CPU architectures
- * allow the implementation to drop entries from the TLB at any time
- * so this is generally safe. If more selective flushing is required
- * use one of the other functions for efficiency.
- */
-void tlb_flush(CPUState *cpu);
-/**
- * tlb_flush_all_cpus_synced:
- * @cpu: src CPU of the flush
- *
- * Flush the entire TLB for all CPUs, for all MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_all_cpus_synced(CPUState *src_cpu);
-/**
- * tlb_flush_page_by_mmuidx:
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush one page from the TLB of the specified CPU, for the specified
- * MMU indexes.
- */
-void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
-                              uint16_t idxmap);
-/**
- * tlb_flush_page_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush one page from the TLB of all CPUs, for the specified
- * MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx:
- * @cpu: CPU whose TLB should be flushed
- * @wait: If true ensure synchronisation by exiting the cpu_loop
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush all entries from the TLB of the specified CPU, for the specified
- * MMU indexes.
- */
-void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush all entries from the TLB of all CPUs, for the specified
- * MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
-
-/**
- * tlb_flush_page_bits_by_mmuidx
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of mmu indexes to flush
- * @bits: number of significant bits in address
- *
- * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
- */
-void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
-                                   uint16_t idxmap, unsigned bits);
-
-/* Similarly, with broadcast and syncing. */
-void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
-    (CPUState *cpu, vaddr addr, uint16_t idxmap, unsigned bits);
-
-/**
- * tlb_flush_range_by_mmuidx
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of the start of the range to be flushed
- * @len: length of range to be flushed
- * @idxmap: bitmap of mmu indexes to flush
- * @bits: number of significant bits in address
- *
- * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
- * comparing only the low @bits worth of each virtual page.
- */
-void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                               vaddr len, uint16_t idxmap,
-                               unsigned bits);
-
-/* Similarly, with broadcast and syncing. */
-void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                               vaddr addr,
-                                               vaddr len,
-                                               uint16_t idxmap,
-                                               unsigned bits);
-
-#else
-static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
-{
-}
-static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
-{
-}
-static inline void tlb_flush(CPUState *cpu)
-{
-}
-static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
-{
-}
-static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
-                                            vaddr addr, uint16_t idxmap)
-{
-}
-
-static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
-{
-}
-static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                            vaddr addr,
-                                                            uint16_t idxmap)
-{
-}
-static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                       uint16_t idxmap)
-{
-}
-static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
-                                                 vaddr addr,
-                                                 uint16_t idxmap,
-                                                 unsigned bits)
-{
-}
-static inline void
-tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap, unsigned bits)
-{
-}
-static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                                             vaddr len, uint16_t idxmap,
-                                             unsigned bits)
-{
-}
-static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                             vaddr addr,
-                                                             vaddr len,
-                                                             uint16_t idxmap,
-                                                             unsigned bits)
-{
-}
-#endif
-
 #if defined(CONFIG_TCG)
 
 /**
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 22486c5dff..663831700d 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -33,6 +33,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
diff --git a/cpu-target.c b/cpu-target.c
index 499facf774..63d563cd0b 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -40,6 +40,7 @@
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "exec/translate-all.h"
 #include "exec/log.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 98f3cf59bc..b0a638e035 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -22,7 +22,7 @@
 #include "sysemu/runstate.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/memop.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 7def8eb73b..23958c6383 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 8041b3b651..9692d5b624 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -36,6 +36,7 @@
 #include "hw/sh4/sh_intc.h"
 #include "hw/timer/tmu012.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "trace.h"
 
 typedef struct SH7750State {
diff --git a/system/watchpoint.c b/system/watchpoint.c
index f7366574a3..622463e11b 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -19,8 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "exec/exec-all.h"
 #include "exec/cpu-all.h"
+#include "exec/cputlb.h"
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2f1000c99f..57cefcba14 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 768116ef32..95cf3d2560 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "exec/helper-proto.h"
 #include "sysemu/runstate.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f38eb054c0..c2e400643a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -19,6 +19,7 @@
 #include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include <zlib.h> /* for crc32 */
 #include "hw/irq.h"
 #include "sysemu/cpu-timers.h"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 345708a1b3..f255126016 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index b8c3e55170..7a1729ccd2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 75c52e2143..84a17172ba 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -21,6 +21,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/translation-block.h"
 #include "sysemu/runstate.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/machine.c b/target/i386/machine.c
index b4610325aa..2a08b26a4b 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
 #include "kvm/hyperv.h"
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 53b49bb297..868d12381f 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -21,7 +21,7 @@
 #include <math.h>
 #include "cpu.h"
 #include "tcg-cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index ed4cda8001..2b5f092a23 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "helper-tcg.h"
 
 /*
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 094aa56a20..75cd592267 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -23,7 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "tcg/helper-tcg.h"
 #include "hw/i386/apic.h"
 
diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 9db8ad62a0..0def3afb14 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "tcg/helper-tcg.h"
 
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefa..d486b8f23b 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -11,7 +11,7 @@
 #include "internals.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "hw/irq.h"
 #include "cpu-csr.h"
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391..40603202e5 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -12,7 +12,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bfc6ae97c..fc8ea87ddb 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 2423ac6172..f8587d5ac4 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 
 static unsigned int tlb_decode_size(unsigned int f)
diff --git a/target/mips/sysemu/cp0.c b/target/mips/sysemu/cp0.c
index bae37f515b..ff7d3db00c 100644
--- a/target/mips/sysemu/cp0.c
+++ b/target/mips/sysemu/cp0.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 
 /* Called for updates to CP0_Status.  */
 void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc)
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index 79a5c833ce..01a07a169f 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -27,7 +27,7 @@
 #include "internal.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 
 
 /* SMP helpers.  */
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index e98bb95951..b545d49a6b 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -21,7 +21,7 @@
 
 #include "cpu.h"
 #include "internal.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index c632d5230b..47ac783c52 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 77567afba4..21bc137ccc 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 42c681ca4a..61432c165b 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/main-loop.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "helper_regs.h"
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index f0ca80153b..e379da6010 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b167b37e0a..718070b600 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -24,6 +24,7 @@
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/log.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69ea..767db4a5cc 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -23,7 +23,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "pmu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9846770820..9e1c4ab0e7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -25,6 +25,7 @@
 #include "pmu.h"
 #include "time_helper.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "sysemu/cpu-timers.h"
 #include "qemu/guest-random.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b..212ba97408 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index a1b36664fc..1bf962cf1b 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "trace.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 945ae6e9e5..add51d4477 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "migration/vmstate.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/translation-block.h"
 #include "hw/loader.h"
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 63373f02ce..865313c98f 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "qemu/bitops.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 08aaecf12b..0d18f14251 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -15,7 +15,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "sysemu/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 4c0b692c9e..003ed86413 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 0e12dae2aa..2ad54d7133 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -25,6 +25,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "hw/core/tcg-cpu-ops.h"
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 303f86d363..e3401f4efe 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "qapi/error.h"
 #include "tcg_s390x.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 9659c69550..a45c38cc4d 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/log.h"
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d92c9f1593..ae2a5fb4ab 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -24,6 +24,7 @@
 #include "tcg/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "asi.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7014255f77..d88dd20305 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -19,7 +19,7 @@
 #include "qemu/log.h"
 #include "hw/registerfields.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index ca214b948a..6327bf048f 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 29b84d5dbf..91b869fb50 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -33,6 +33,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 
 #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
-- 
2.45.2


