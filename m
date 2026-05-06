Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7995CD3427
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKT4k-0001vY-Oj; Tue, 05 May 2026 23:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4h-0001u0-4a
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4e-0006Ta-15
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ba0714574fso17407165ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778038642; x=1778643442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix2N1B+KeW2rwppNiX+U7l1Odcv5hQSP4LHRBe+DC4I=;
 b=noQsmFbVJBwuxRZGcRLMIznj/Ivk2/RMFODtlpyjMMiwzrd2NpifmzHsFGkaqGoBpw
 PuaEePufiWT+2eE+1ZDz4qAu8vKS5XJ3TODfFlc3sRE1Q+AU5CuJpkCBc9BGxj7UhKiP
 ugNeMC63I36K03CZeUV+1SjMbKDaNn7LHLe8gFUQ82vL/3MRNSInUmpK8vkVS4t0VbZ4
 wMKP5BQkdb8vVYPnKaiAWxPjPn7VEnqbIFGEg5liXSZhWeNMLGUF4EpkcO0DEH/OyT+6
 o9Pe+ubQhrZMqR/g5PXiV3EjodpdjzJxQww3n2BjqOZrg6tnbte1h3UMwOqakW2JhdUl
 kS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038642; x=1778643442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ix2N1B+KeW2rwppNiX+U7l1Odcv5hQSP4LHRBe+DC4I=;
 b=PKKWGIsFhxf0sZqpnEvKVZdBhlvQqXAWziq0aESxeIPc/OxImLiamv88EzX5lx01Fk
 EbyUr3HCyIwiwr8N/X4epxPLVeHfJu9YQJMvfg17Kv9ljs1u6lol7n1bv8cLnplpbj18
 t+27EBi2B1IoEP7CbjPc3B5Mamx6UZK5g2qanB2pqhIKZWhKqSj/TzNqBjm4Y2YPx1XZ
 hRlEgsnOOx6YBxTy/tN5N1h0CSUW20pxcJNIXdeljc5R0gY+CqBLqJhi7OHG1EtWSOtv
 C+7ZLh4j9bF/fiEDwOHZ9QV89WnGPlcbB4dzDfM5SeURlz9ytYYILzlrBr9LQn9e+Val
 7g3w==
X-Gm-Message-State: AOJu0Yz6a/86yJDPbeBKGdnka1qqQrD0HIHWrDi6P7qEnPCtUdihGQAM
 oqTOSoK0JAzaVR97lo/zZo2Yz6/B8P8N8MQJtNb9lesgfiaWdonLmLJPc8+iYKcLwQX0xSytTOj
 +kNvgJ+4JAlwD/1885xWB6fUpYzDjQ5lMy2yjl/G3cmmDGUkrp7t+OK8uhRkupQMUaxU8mm9W3B
 PZGeQSvHtjli29+OgKx/vDDL0HIEfePd2MaAlVHbTy
X-Gm-Gg: AeBDieudVrc0Kh1Q7vJdYVPDKc476Qw46gzr4iUPBOTyvztgJWgnaVYYdVzOTj4CQ1h
 0WPlkMt6rVu+rZzdtL6tehMAW2zM8QEc3j2Mds7mrtOip7r9ylWbRd/ir9tiXfsW385b8TqO6TT
 JGLuzvJfEqPmD4fcgN5M/n6HZsAgI6tz63hSWq6UV8hn/fqn3BuCljZoRcMWK4fbdrmEwDcS2tF
 cB7YVWtAok9YiEDKFPtXrJ6WKTqbxEKCJw35Lpuabv1OqylJyWnVbwMs1qCEE4G6KX6yiX8kYId
 7ctFVVkJzxDfjGF6wcaLKHbyjJSKd5VMpDpLFTlC7UHwXW1KXvaZ3NlFy00k1BUWyxEHPyBalZn
 6/P6zy/SI3i7YgqC0fsHX4UQqctXoGTdwdrYJcy8dpFFHZ+TYv+eZETakamhc3fDsMEv2c2zAvw
 N9RCpedkJKs0VYf10COY+kHcRu616z84QfTRY4rfBEN/12jAYQqacJ7wM=
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id
 d9443c01a7336-2ba7908bfb1mr15835875ad.13.1778038642149; 
 Tue, 05 May 2026 20:37:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca34cfdsm7666265ad.79.2026.05.05.20.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:37:21 -0700 (PDT)
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
Subject: [PATCH v3 4/5] accel/tcg: Add IOMMU lazy translation function
Date: Wed,  6 May 2026 11:36:41 +0800
Message-ID: <20260506033642.3641390-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033642.3641390-1-jim.shu@sifive.com>
References: <20260506033642.3641390-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62a.google.com
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

The lazy translation will translate IOMMU regions of the specific
access_type and store the result into the CPUTLBEntryFull.

For CPUTLBEntry, lazy translation may update 'addend' and 'addr_idx'
array. We restrict IOMMU region to have a single non-zero 'addend'
across all permissions. Also, lazy translation only updates the
'addr_idx' for the permissions specified in @prot.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/tcg/cputlb.c    | 168 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/core/cpu.h |  15 ++++
 2 files changed, 183 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f0c049e1551..5735f632896 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1272,6 +1272,174 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                           mmu_idx, retaddr);
 }
 
+/*
+ * Perform lazy IOMMU translation for a CPUTLBEntry/CPUTLBEntryFull.
+ * This is called when CPU utilize the TLB entry in the slow path.
+ * Updates both entry and full entry to IOMMU translated data for the
+ * specific access type.
+ */
+static void
+tlb_translate_iommu(CPUState *cpu, int mmu_idx,
+                    vaddr addr, MMUAccessType access_type,
+                    CPUTLBEntryFull *full)
+{
+    CPUTLB *tlb = &cpu->neg.tlb;
+    MemoryRegionSection *section;
+    unsigned int read_flags, write_flags;
+    uintptr_t addend;
+    CPUTLBEntry *te;
+    hwaddr iotlb, xlat, sz, paddr_page;
+    vaddr addr_page;
+    int asidx, wp_flags, prot;
+    bool is_ram, is_romd;
+
+    if (!full->is_iommu || (full->iommu_last_at == access_type)) {
+        return;
+    }
+
+    assert_cpu_is_self(cpu);
+
+    if (full->lg_page_size <= TARGET_PAGE_BITS) {
+        sz = TARGET_PAGE_SIZE;
+    } else {
+        sz = (hwaddr)1 << full->lg_page_size;
+        tlb_add_large_page(cpu, mmu_idx, addr, sz);
+    }
+    addr_page = addr & TARGET_PAGE_MASK;
+    paddr_page = full->phys_addr & TARGET_PAGE_MASK;
+
+    prot = full->prot;
+    asidx = cpu_asidx_from_attrs(cpu, full->attrs);
+
+    section = address_space_translate_for_iotlb_late(cpu, asidx, paddr_page,
+                                                     &xlat, &sz, full->attrs,
+                                                     &prot, access_type);
+
+    assert(sz >= TARGET_PAGE_SIZE);
+
+    tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
+              " prot=%x idx=%d\n",
+              addr, full->phys_addr, prot, mmu_idx);
+
+    is_ram = memory_region_is_ram(section->mr);
+    is_romd = memory_region_is_romd(section->mr);
+
+    read_flags = full->tlb_fill_flags;
+    if (full->lg_page_size < TARGET_PAGE_BITS) {
+        /* Repeat the MMU check and TLB fill on every access.  */
+        read_flags |= TLB_INVALID_MASK;
+    }
+
+    if (is_ram || is_romd) {
+        /* RAM and ROMD both have associated host memory. */
+        addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
+    } else {
+        /* I/O and IOMMU does not; force the host address to NULL. */
+        addend = 0;
+    }
+
+    write_flags = read_flags;
+
+    if (is_ram) {
+        iotlb = memory_region_get_ram_addr(section->mr) + xlat;
+        assert(!(iotlb & ~TARGET_PAGE_MASK));
+        /*
+         * Computing is_clean is expensive; avoid all that unless
+         * the page is actually writable.
+         */
+        if (prot & PAGE_WRITE) {
+            if (section->readonly) {
+                write_flags |= TLB_DISCARD_WRITE;
+            } else if (physical_memory_is_clean(iotlb)) {
+                write_flags |= TLB_NOTDIRTY;
+            }
+        }
+    } else {
+        /* I/O or ROMD */
+        iotlb = xlat;
+        /*
+         * Writes to romd devices must go through MMIO to enable write.
+         * Reads to romd devices go through the ram_ptr found above,
+         * but of course reads to I/O must go through MMIO.
+         */
+        write_flags |= TLB_MMIO;
+        if (!is_romd) {
+            read_flags = write_flags;
+        }
+    }
+
+    wp_flags = cpu_watchpoint_address_matches(cpu, addr_page,
+                                              TARGET_PAGE_SIZE);
+
+    /* Update the CPUTLBEntryFull for this access type. */
+    full->iommu_last_at = access_type;
+    full->xlat_offset = iotlb - addr_page;
+    full->section = section;
+    full->phys_addr = paddr_page;
+
+    /* Update the CPUTLBEntry: addend and addr_idx */
+    tlb = &cpu->neg.tlb;
+    te = tlb_entry(cpu, mmu_idx, addr_page);
+
+    qemu_spin_lock(&tlb->c.lock);
+
+    /*
+     * If IOMMU region is translated to the memories (has associated
+     * host memory), it will update the 'addend' to access memories in the
+     * fast path. Otherwise, IO region do not update the 'addend' because
+     * it might be already used by memory region from the other permissions.
+     * It is fine since IO region do not use addend.
+     */
+    if (is_ram || is_romd) {
+        if (te->addend + addr_page) {
+            /* addend of untranslated IOMMU region is 0 - addr_page. */
+
+            /*
+             * CPUTLBEntry only has 1 addend across all permissions.
+             * We don't support the IOMMUMemoryRegion to be translated to
+             * 2 different host memories from the different permissions.
+             * QEMU will trigger an assertion for such case.
+             */
+            g_assert(addend == te->addend + addr_page);
+        } else {
+            te->addend = addend - addr_page;
+        }
+    }
+
+    /*
+     * In the IOMMU lazy translation, we only update TLB flags for the
+     * permissions specified in @prot. For other permissions, we still
+     * keep the original TLB flags (e.g. TLB_IOMMU if not translated).
+     */
+    if (prot & PAGE_EXEC) {
+        tlb_set_compare(full, te, addr_page, read_flags,
+                        MMU_INST_FETCH, prot & PAGE_EXEC);
+    }
+
+    if (wp_flags & BP_MEM_READ) {
+        read_flags |= TLB_WATCHPOINT;
+    }
+    if (prot & PAGE_READ) {
+        tlb_set_compare(full, te, addr_page, read_flags,
+                        MMU_DATA_LOAD, prot & PAGE_READ);
+    }
+
+    if (prot & PAGE_WRITE_INV) {
+        write_flags |= TLB_INVALID_MASK;
+    }
+    if (wp_flags & BP_MEM_WRITE) {
+        write_flags |= TLB_WATCHPOINT;
+    }
+    if (prot & PAGE_WRITE) {
+        tlb_set_compare(full, te, addr_page, write_flags,
+                        MMU_DATA_STORE, prot & PAGE_WRITE);
+    }
+
+    qemu_spin_unlock(&tlb->c.lock);
+
+    return;
+}
+
 static MemoryRegionSection *
 io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
            vaddr addr, uintptr_t retaddr)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 207a7a1becb..cfbce50d1c5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -254,6 +254,21 @@ struct CPUTLBEntryFull {
      */
     uint8_t slow_flags[MMU_ACCESS_COUNT];
 
+    /*
+     * @is_iommu indicates if the MemoryRegion is an IOMMU.
+     * When true, IOMMU translation is deferred until the entry is used.
+     */
+    bool is_iommu;
+
+    /*
+     * @iommu_last_at contains the access_type of last IOMMU translation.
+     * It means that this entry currently stores the translated data of
+     * IOMMU region with this access_type.
+     * When it is MMU_ACCESS_COUNT, the entry stores untranslated data of
+     * IOMMU region.
+     */
+    MMUAccessType iommu_last_at;
+
     /*
      * Allow target-specific additions to this structure.
      * This may be used to cache items from the guest cpu
-- 
2.43.0


