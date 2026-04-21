Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE72CF8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDyi-0008UK-69; Tue, 21 Apr 2026 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDyg-0008T1-Bf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:34 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDyd-0005gu-50
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35fb16e56efso2929426a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776788969; x=1777393769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3dqOfFoIBWp7Cb7bNlLy2OEHohEiraa8UK2jGzmOpM=;
 b=idLIqPguOfAkAy5vRhlVPwUiRUT88pCX9nZNPp+M1dsYbpaydw+8gVbS4/X/UmWuAf
 7Ibzn8kioceX3C+cM0bL+iAa83tlLY+fU0QPJwQrmDFMma+6j60scAjVz5JbHEgdATW+
 g25RUMkpeR+dIuo5QvTXloC0O4NjYB3LKArwrXmCFHej2Jak3PJKUWL8v793BaBRFRvi
 dYP7wcT1WsRoiABRPMTtZZCV2CJVAW7BplQMHm0fJ3Z3mltQ8f/s4T5Dtz2f6cRC2iis
 ARY/26jRyBknvAmhTwiFgddggSmL1rbC49qaITHpZ0rwPun5C81YLrNDf/ZlWTEKh5ay
 4PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776788969; x=1777393769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3dqOfFoIBWp7Cb7bNlLy2OEHohEiraa8UK2jGzmOpM=;
 b=XapnrgY1I4S9KDFn/poSUXStSzCydEKt/qJ6tpY6hxk8eNHaJ1bkzNWC9WHBTldhtC
 cCBv5X5mmU+XYlRjcO+arzfGTIrvJ2H+5fvGBC+LVprqo96uthd/ChH+DipBke/mNp35
 5Q7e3wIIxiau326tE0fiUdXnPv5lMYweMg22Bx0N0YWLQsov/GYJ1y65Hjelk0U2xpye
 JozKaCo3eeMsJ8MnFuBFK23/TaeQgW7RbCt5RepaBLYJKEOR2U0lrG5nuQf7TS1ZJMdj
 CRtVNcbyyfMme674bu75MVLtGoxxjDN111+FvZoP6q0583qh22Vc6goE4ba2LqhWnjnv
 LIxQ==
X-Gm-Message-State: AOJu0YzcUCdarjV9MLtN0uP2RXW9Md4C8P/cpLk0nIR4m17FnX9ToixM
 MyMhxbYKGdrrB/8JKUEOrhc93ZXyIZI4045C/QuPdO+tyIhUnAhU8GI5B/zGm960599po63nM7a
 KyAzXlqPRXWmNpGu2eoOC+aTrwdrAwaSNH80qH/ZP0pdFlBYuAiEVXDI8JkLAwRviArghhB+Kax
 ofneu3neomWr6QWMeFtqjEaVYt+nAbkQXswXcqq96G
X-Gm-Gg: AeBDieuYchfCT6norJUzcbPdX8WtOHcHt64b+w7xW36iyoj7wVCnz4+YkIoOaOOcJQc
 RjZtkKxi9GYcM9Fc4HlURSc9fGfNBegYbipPChpV1PwDmwOMGsTIFZvuoJcvtlt5hiI0Ffc3isI
 /NDqljysSRLXNWlhNQIxe06TikYUvyADXT6cM4WinnKLf8qNYUZwyEfRtpfg6cftnxIk0wzO/hX
 hWMQ7UDgPqjGWuln7gfaG/8M6i+iqfBXY9hMakGrBJa5GqICRzdxgcLDKfPnmEWl5HpGQ/G3Qum
 bSFSYnNiiihXRwMNifLyg4C9Q6Qsd5/GoNG3g4C+PCz5MqZrqLUjFJGwVDzTHwYGaCcdIVt8Uff
 YKOvEfFIuKwZNzI3j9pe40vD5tWU6espkqYWWr43ZWGsRy3xB53j03GWPtiPciv4jQ4NN4W0JBF
 EqvY7yRzav29WIratITPaq8gm5I/A6/093JyLIKwGwDmelVE044fvG7us=
X-Received: by 2002:a17:90b:3d01:b0:35f:b75e:fff5 with SMTP id
 98e67ed59e1d1-3614048b7admr20996157a91.22.1776788969271; 
 Tue, 21 Apr 2026 09:29:29 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140ff2e1esm13529470a91.8.2026.04.21.09.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:29:28 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 1/5] accel/tcg: Pass access_type as an argument of
 tlb_set_page*()
Date: Wed, 22 Apr 2026 00:29:08 +0800
Message-ID: <20260421162912.3295598-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421162912.3295598-1-jim.shu@sifive.com>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x102b.google.com
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

Pass the access_type so that we could know CPU will do the read or
write access. Then, CPU can fill the CPUTLBEntry[Full] of the specific
permission (@prot).

It is fine for address_space_translate*() to return different section of
read and write access. tlb_set_page*() only sets 'CPUTLBEntry.addr_*'
for specific @prot, so access from another @prot will only get TLB miss
and start to overwrite 'CPUTLBEntry[Full]' with new @prot.

It is the preliminary patch of next commit to pass the iommu_flags
to IOMMUMemoryRegion from access_type.

Signed-off-by: Jim Shu <jim.shu@sifive.com>

---
 accel/tcg/cputlb.c                   | 14 ++++++++------
 include/exec/cputlb.h                | 11 +++++++----
 target/alpha/helper.c                |  2 +-
 target/avr/helper.c                  |  3 ++-
 target/hppa/mem_helper.c             |  1 -
 target/i386/tcg/system/excp_helper.c |  3 ++-
 target/loongarch/tcg/tlb_helper.c    |  2 +-
 target/m68k/helper.c                 | 10 +++++++---
 target/microblaze/helper.c           |  8 ++++----
 target/mips/tcg/system/tlb_helper.c  |  4 ++--
 target/or1k/mmu.c                    |  2 +-
 target/ppc/mmu_helper.c              |  2 +-
 target/riscv/cpu_helper.c            |  2 +-
 target/rx/cpu.c                      |  3 ++-
 target/s390x/tcg/excp_helper.c       |  2 +-
 target/sh4/helper.c                  |  3 ++-
 target/sparc/mmu_helper.c            |  6 +++---
 target/tricore/helper.c              |  2 +-
 target/xtensa/helper.c               |  3 ++-
 19 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d6115bbb0a4..3bc951603dc 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1022,7 +1022,8 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
  * critical section.
  */
 void tlb_set_page_full(CPUState *cpu, int mmu_idx,
-                       vaddr addr, CPUTLBEntryFull *full)
+                       vaddr addr, MMUAccessType access_type,
+                       CPUTLBEntryFull *full)
 {
     CPUTLB *tlb = &cpu->neg.tlb;
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
@@ -1185,7 +1186,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
 void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs, int prot,
-                             int mmu_idx, vaddr size)
+                             MMUAccessType access_type, int mmu_idx,
+                             vaddr size)
 {
     CPUTLBEntryFull full = {
         .phys_addr = paddr,
@@ -1195,15 +1197,15 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
     };
 
     assert(is_power_of_2(size));
-    tlb_set_page_full(cpu, mmu_idx, addr, &full);
+    tlb_set_page_full(cpu, mmu_idx, addr, access_type, &full);
 }
 
 void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
+                  hwaddr paddr, int prot, MMUAccessType access_type,
                   int mmu_idx, vaddr size)
 {
     tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
-                            prot, mmu_idx, size);
+                            prot, access_type, mmu_idx, size);
 }
 
 /**
@@ -1245,7 +1247,7 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
     if (ops->tlb_fill_align) {
         if (ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
                                 memop, size, probe, ra)) {
-            tlb_set_page_full(cpu, mmu_idx, addr, &full);
+            tlb_set_page_full(cpu, mmu_idx, addr, type, &full);
             return true;
         }
     } else {
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 3a9603a6965..47fa4302a9a 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -41,6 +41,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
  * @cpu: CPU context
  * @mmu_idx: mmu index of the tlb to modify
  * @addr: virtual address of the entry to add
+ * @access_type: access was read/write/execute
  * @full: the details of the tlb entry
  *
  * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
@@ -56,6 +57,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
  * used by tlb_flush_page.
  */
 void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
+                       MMUAccessType access_type,
                        CPUTLBEntryFull *full);
 
 /**
@@ -65,6 +67,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
  * @paddr: physical address of the page
  * @attrs: memory transaction attributes
  * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
+ * @access_type: access was read/write/execute
  * @mmu_idx: MMU index to insert TLB entry for
  * @size: size of the page in bytes
  *
@@ -81,9 +84,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
  * used by tlb_flush_page.
  */
 void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
-                             hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, vaddr size);
-
+                             hwaddr paddr, MemTxAttrs attrs, int prot,
+                             MMUAccessType access_type, int mmu_idx,
+                             vaddr size);
 /**
  * tlb_set_page:
  *
@@ -92,7 +95,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
  * as a convenience for CPUs which don't use memory transaction attributes.
  */
 void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
+                  hwaddr paddr, int prot, MMUAccessType access_type,
                   int mmu_idx, vaddr size);
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 179dc2dc7ae..7645ff27e20 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -328,7 +328,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     }
 
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
-                 prot, mmu_idx, TARGET_PAGE_SIZE);
+                 prot, access_type, mmu_idx, TARGET_PAGE_SIZE);
     return true;
 }
 
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 365c8c60e19..4f536f08676 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -143,7 +143,8 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         prot = PAGE_READ | PAGE_WRITE;
     }
 
-    tlb_set_page(cs, address, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
+    tlb_set_page(cs, address, paddr, prot, access_type, mmu_idx,
+                 TARGET_PAGE_SIZE);
     return true;
 }
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index ffbad8acfd2..63606c19d07 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -482,7 +482,6 @@ bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
     out->prot = prot;
     out->attrs = MEMTXATTRS_UNSPECIFIED;
     out->lg_page_size = TARGET_PAGE_BITS;
-
     return true;
 }
 
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index d7ea77c8558..0fdae83f0a2 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -628,7 +628,8 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         tlb_set_page_with_attrs(cs, addr & TARGET_PAGE_MASK,
                                 out.paddr & TARGET_PAGE_MASK,
                                 cpu_get_mem_attrs(env),
-                                out.prot, mmu_idx, out.page_size);
+                                out.prot, access_type, mmu_idx,
+                                out.page_size);
         return true;
     }
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c0fd8527fe9..f84a62e2861 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -669,7 +669,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         prot = context.prot;
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     access_type, mmu_idx, TARGET_PAGE_SIZE);
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
                       " prot %d\n", __func__, address, physical, prot);
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bab1843892..0de0a7dd248 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -969,7 +969,7 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      address & TARGET_PAGE_MASK,
                      PAGE_READ | PAGE_WRITE | PAGE_EXEC,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     qemu_access_type, mmu_idx, TARGET_PAGE_SIZE);
         return true;
     }
 
@@ -989,7 +989,8 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                                address, access_type, &page_size);
     if (likely(ret == 0)) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot, mmu_idx, page_size);
+                     physical & TARGET_PAGE_MASK, prot, qemu_access_type,
+                     mmu_idx, page_size);
         return true;
     }
 
@@ -1461,6 +1462,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
     int prot;
     int ret;
     target_ulong page_size;
+    MMUAccessType qemu_access_type;
 
     access_type = ACCESS_PTEST;
     if (env->dfc & 4) {
@@ -1468,9 +1470,11 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
     }
     if ((env->dfc & 3) == 2) {
         access_type |= ACCESS_CODE;
+        qemu_access_type = MMU_INST_FETCH;
     }
     if (!is_read) {
         access_type |= ACCESS_STORE;
+        qemu_access_type = MMU_DATA_STORE;
     }
 
     env->mmu.mmusr = 0;
@@ -1480,7 +1484,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
     if (ret == 0) {
         tlb_set_page(env_cpu(env), addr & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK,
-                     prot, access_type & ACCESS_SUPER ?
+                     prot, qemu_access_type, access_type & ACCESS_SUPER ?
                      MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
     }
 }
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a1857b72172..2bdf8c3ea03 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -101,8 +101,8 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         /* MMU disabled or not available.  */
         address &= TARGET_PAGE_MASK;
         prot = PAGE_RWX;
-        tlb_set_page_with_attrs(cs, address, address, attrs, prot, mmu_idx,
-                                TARGET_PAGE_SIZE);
+        tlb_set_page_with_attrs(cs, address, address, attrs, prot, access_type,
+                                mmu_idx, TARGET_PAGE_SIZE);
         return true;
     }
 
@@ -113,8 +113,8 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
         qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
                       mmu_idx, vaddr, paddr, lu.prot);
-        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, lu.prot, mmu_idx,
-                                TARGET_PAGE_SIZE);
+        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, lu.prot, access_type,
+                                mmu_idx, TARGET_PAGE_SIZE);
         return true;
     }
 
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 566924b079e..bf08ba29d02 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -934,7 +934,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     access_type, mmu_idx, TARGET_PAGE_SIZE);
         return true;
     }
 #if !defined(TARGET_MIPS64)
@@ -952,7 +952,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             if (ret == TLBRET_MATCH) {
                 tlb_set_page(cs, address & TARGET_PAGE_MASK,
                              physical & TARGET_PAGE_MASK, prot,
-                             mmu_idx, TARGET_PAGE_SIZE);
+                             access_type, mmu_idx, TARGET_PAGE_SIZE);
                 return true;
             }
         }
diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
index 315debaf3e5..c14f03081e1 100644
--- a/target/or1k/mmu.c
+++ b/target/or1k/mmu.c
@@ -127,7 +127,7 @@ bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     if (likely(excp == 0)) {
         tlb_set_page(cs, addr & TARGET_PAGE_MASK,
                      phys_addr & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     access_type, mmu_idx, TARGET_PAGE_SIZE);
         return true;
     }
     if (probe) {
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ac607054027..8b55a9e4ddf 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1369,7 +1369,7 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
     if (ppc_xlate(cpu, eaddr, access_type, &raddr,
                   &page_size, &prot, mmu_idx, !probe)) {
         tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
-                     prot, mmu_idx, 1UL << page_size);
+                     prot, access_type, mmu_idx, 1UL << page_size);
         return true;
     }
     if (probe) {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90e..ee0292e3423 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1874,7 +1874,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     if (ret == TRANSLATE_SUCCESS) {
         tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
-                     prot, mmu_idx, tlb_size);
+                     prot, access_type, mmu_idx, tlb_size);
         return true;
     } else if (probe) {
         return false;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index b5284199e6d..6114e345e65 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -194,7 +194,8 @@ static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     /* Linear mapping */
     address = physical = addr & TARGET_PAGE_MASK;
     prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+    tlb_set_page(cs, address, physical, prot, access_type,
+                 mmu_idx, TARGET_PAGE_SIZE);
     return true;
 }
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 41b0017d767..6d89a8c328e 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -182,7 +182,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
                       __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
         tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     access_type, mmu_idx, TARGET_PAGE_SIZE);
         return true;
     }
     if (probe) {
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5d6295618f5..2542d3d88f5 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -812,7 +812,8 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == MMU_OK) {
         address &= TARGET_PAGE_MASK;
         physical &= TARGET_PAGE_MASK;
-        tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+        tlb_set_page(cs, address, physical, prot, access_type, mmu_idx,
+                     TARGET_PAGE_SIZE);
         return true;
     }
     if (probe) {
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index a6f76a1ab76..316f4182848 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -236,7 +236,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       "Translate at %" VADDR_PRIx " -> "
                       HWADDR_FMT_plx ", vaddr " TARGET_FMT_lx "\n",
                       address, full.phys_addr, vaddr);
-        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
+        tlb_set_page_full(cs, mmu_idx, vaddr, access_type, &full);
         return true;
     }
 
@@ -252,7 +252,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
            neverland. Fake/overridden mappings will be flushed when
            switching to normal mode. */
         full.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
+        tlb_set_page_full(cs, mmu_idx, vaddr, access_type, &full);
         return true;
     } else {
         if (access_type == MMU_INST_FETCH) {
@@ -777,7 +777,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         trace_mmu_helper_mmu_fault(address, full.phys_addr, mmu_idx, env->tl,
                                    env->dmmu.mmu_primary_context,
                                    env->dmmu.mmu_secondary_context);
-        tlb_set_page_full(cs, mmu_idx, address, &full);
+        tlb_set_page_full(cs, mmu_idx, address, access_type, &full);
         return true;
     }
     if (probe) {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7ee8c7fd699..a7173dc73f0 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -86,7 +86,7 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     rw, mmu_idx, TARGET_PAGE_SIZE);
         return true;
     } else {
         assert(ret < 0);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2d93b45036d..2cd51ba0cb7 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -282,7 +282,8 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         tlb_set_page(cs,
                      address & TARGET_PAGE_MASK,
                      paddr & TARGET_PAGE_MASK,
-                     access, mmu_idx, page_size);
+                     access, access_type, mmu_idx,
+                     page_size);
         return true;
     } else if (probe) {
         return false;
-- 
2.43.0


