Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090F0CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKT4c-0001sW-KW; Tue, 05 May 2026 23:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4R-0001ms-9j
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:15 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4M-0006P0-EL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:11 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-365312a27abso3119274a91.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778038621; x=1778643421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4oq7FYtdOzrIMTjc3akR5ofLqGKBG7Esq11ieVM6zY=;
 b=Ylj/W52/6wkoYPRGAHyFLJEBNncfZtM7OTS25KM/0CnLvmi/fSMjVpacoC6T8M+7t7
 lacWyOW4ZKHLWMhbEgb0cYNAdl28t/831gs8MtU3iiWnZXPy5pivFSqb2GA70b2N8VdP
 ifakgYsZ01/NwtA7ReXd7LXbrZWLmNfoohAVy+asXb8Bk7ZPkLBGwT2yfAzjqMkSex/p
 Ke63ycodV9H+5PzB7ChryIZIQZEzxGXl71edfDV0S7JkxNK1KTng3hN9GFfKNi6UeBEa
 QJRM4VSf+X2FMw6t+3lkDV997+Y0DrWMLR/0TcnDN0D76+sx4gjmwikBuyJ7Ru6L5vhZ
 yEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038621; x=1778643421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h4oq7FYtdOzrIMTjc3akR5ofLqGKBG7Esq11ieVM6zY=;
 b=BWkre9gkRLujLsZ4QW2YqyveZSeT1DDS90VkMNeQN5Cva7w/iU8gAknHkG9H4EF6Tn
 qNqslDrRU9CIbSqsll+qF6N8VvMAYhf/DLOHPN+5M+xpDU9HQ1PYRS6oy1XRSmTjVugy
 WGMeNGcqMx4e//JutLXFlELoFQGBCUCcQiM5NU5ijTp3oSblt3bWffOMFNj6i5sGB2ab
 fq1xOuabiPgt8Mtj+UmInyT3HgX0ODrF6f7ICXOOI/KGIG8G8IrCtz99p/KdSuYnqccQ
 BSklpOdioxr3usXK3zjdYJgtagyP/0g+UGCbD+7M+Ov3M0hKA/qxiONqXxDBBc69TvSj
 2UZQ==
X-Gm-Message-State: AOJu0YzgDpNw+5B3+i+qj2gCQHQIeqC8Av98X+vzbveU+e/uhNZYstV9
 F1bJocTDcj4B3QV2791sG40fRZVPWJgTJjpdHbubhjy1h+oiLXgZ//LeadE7DygKlf14JvU5TDB
 UDIVqcLJG24r4NMEFaQzV4W5dKCCMMKc7HZ3lmgPeeGrt1q7/ezKy5plL6lb89k5od+Iw4+8lef
 Lgx/cSI7M0BVUQkaJKLJFrpfMG7ZY8dtoUYD1NyDuF
X-Gm-Gg: AeBDievHs1WyxOFM/yxIW0d2mQOZWsGVyjkp1IwVBzxlQWtRc0zeo/Id1uA4xVNjJWa
 TIkXJ43D4u0h9Rw3OMJ8n++kiB2wiWd9EF9EyDRhmGbHfMOB3vsXyDnzegsZTgN5fqCl/OFE+8R
 o8lXi3IPQRUF0CilPBwCVRRpXhR6Neovds6EaEPFVWFsIzGO2nrzREy7d+NpSNu0/I2gYRS7VBA
 RHCjUnvpV36beDHNdDT329FsUORQOZdxlru6HkzLm29UURr8EsZDYPkhpl5NLlvrOvGNXueuTPj
 e8RH3MWBH+jZfW7xghxotca9SCRqfRCjRIRJ0WECHGTGd2maifUlA76c2YjD6z+6sWp25/UtK6z
 3BCO3KUf8XzDfKsTCidvC4rQC3Me29WgbqxOx6PWhVzVg+Rl93UmehaVewwj+FaPX/+MWieAZH6
 0Nj+SuJh7yq1mpaAu+LXjU92M9zgIgnUt2hLDXYR7NRx/Z30em4OdHPN4=
X-Received: by 2002:a17:902:fb43:b0:2b2:489a:f46a with SMTP id
 d9443c01a7336-2ba798d2797mr10569105ad.36.1778038620970; 
 Tue, 05 May 2026 20:37:00 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca34cfdsm7666265ad.79.2026.05.05.20.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:37:00 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Song Gao <gaosong@loongson.cn>,
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
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 1/5] accel/tcg: Pass access_type as an argument of
 tlb_set_page*()
Date: Wed,  6 May 2026 11:36:38 +0800
Message-ID: <20260506033642.3641390-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033642.3641390-1-jim.shu@sifive.com>
References: <20260506033642.3641390-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1032.google.com
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
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/tcg/cputlb.c                   | 14 ++++++++------
 include/exec/cputlb.h                | 11 +++++++----
 target/alpha/helper.c                |  2 +-
 target/avr/helper.c                  |  3 ++-
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
 18 files changed, 48 insertions(+), 34 deletions(-)

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
index 9bab1843892..61048892adf 100644
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
+    MMUAccessType qemu_access_type = MMU_DATA_LOAD;
 
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
index 39c3486ae0f..6ff7b499711 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1927,7 +1927,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
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
index 05e448d3f20..3363e2818d5 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -184,7 +184,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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


