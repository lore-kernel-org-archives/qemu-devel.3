Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBB0F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDzE-0000NM-Jn; Tue, 21 Apr 2026 12:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDz4-00005S-4B
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:30:02 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDyz-0005kC-Nh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:56 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so1795896a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776788989; x=1777393789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APky2fuLBKI2WECyMzceROTH37228n1Vh/hCfj/U6G4=;
 b=C+LELdZC8QEdqIZKXRfz1JIFDFuG0IqsPl9lyu6cF84qkQeEnpanuLWFZF9gnAj9+G
 quRFGfCKrQg7FM3Nua1hR2A3659WbH+mYtOkhrScuKPVmjyM5u9+wAiqVb+96BQfBieN
 dOedK5UnDUpa3kJ+OXR5IVGLeCCYKrV+cv8AB36clNohIfG/YO/RCIpBC0AoXWjUsDxx
 qIQRqaYeBWRH1Xm4Ia5IAxJfw7D0r9U+vSXvCqfMjVtAGeRVILR+HQLN6E8Kez35FFMx
 EQ8capYjVi+j1NETDMcHZ5KLFzp4zEqab0iIM3uv1jYC6Y9SPekuZowXlYPBkiBVhTBV
 Bt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776788989; x=1777393789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=APky2fuLBKI2WECyMzceROTH37228n1Vh/hCfj/U6G4=;
 b=hyHCQnTgrbOTh/p+CEbAL0lW5RJ19YTQZ+V/UThQiG2+WyFF1ZNcGFLkAgkpQGnw5b
 ixKiYGcdXDRfZP0hZfCSGBBJPLNzaFxxzzaVpHJ0TnZ5gqdEMwWSWKh1iOKYj67asEfE
 zDpJyHDGLkZC+f0A9uLj4qbtQGGIZ/kXzp7qWoLBVCCraEertaBmUX+RkLhYJm7orHmX
 vAvnC+/iQ9m8IJyUOYx+AxFYJkBaVI+jxtUobUiIcxxc09Id7FH6puNsFUFDWg/S1oT9
 leo/lj4g4pztmrYXkmumZSn2wSBlvKQBdxw2ekhTOd7P4gdlw2o0+ZSerLNmJ7P3qIsw
 Yw2g==
X-Gm-Message-State: AOJu0YzLKGO1Mvk4Unm8VOMKF1jdQXohVofaPEH9pUF7HstQD2BxuQ2r
 0HO1Uq0WczwG48gouESId3M6nZf7gThORxSe8iVsmN2QNASDb3pqE2jLpwNj4pnrAD7tkjroxnk
 RLgbmRplLvgQw/WtYCVlI76Kech1C2NaywuY+MD32m75Yk71VMuwn1wVWv8zsUpdySK6I5y9sYr
 aDk8ibtyXnD969wKTuAbh2LiiKvcyvpyVqJVWc2kWR
X-Gm-Gg: AeBDiesGjVGQxYfkUQ7s5lOxTu56qZ0T932fkU+KypIqDCZ0Rn+AeTuoa5umVME0wyA
 BO81otsccqGO+ZQ3tD1YF80d10aipfNXXDluxBmnjaLx+qV2VbSuQkSwf6MsEhXjCgGTfqh18pP
 89R4Nh6hLQk4NUDPt90a1K2qXwwFOZvPzaAVH5uMpRjyduK3TYGmyDepObaYrjDG/7WxdYHxRD6
 zAQk89ctnqYOSiyu85KLEXrYZpXv5oiw6QiN6OMzMEvNJZdIG0h9Uwn00jN4Az0nX3dYiqUBeXe
 /zOpJiQecz4JEbfkFq9kQE6220+20IjQ5J8rxsOm3EoQN58A1Mdz4HuePqUHIOs/HOA5yl84vDR
 LHoP49cAX0VIkW5QAMXmzbeM5qeSno4dufBCT0OCoNCdDcfNjf1GIcQBM1U0U3GB1LD4CUmROc/
 ea7VXkoTmQgwjUQwfVV9qJ46v6jJaj5lSyip+EYyDQnF+ld9T+bDSCJlZbpLwh09DhZg==
X-Received: by 2002:a17:90b:2891:b0:359:fd9a:c50c with SMTP id
 98e67ed59e1d1-361404ae963mr17422285a91.22.1776788988528; 
 Tue, 21 Apr 2026 09:29:48 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140ff2e1esm13529470a91.8.2026.04.21.09.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:29:47 -0700 (PDT)
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
Subject: [PATCH v2 4/5] accel/tcg: Add IOMMU lazy translation function
Date: Wed, 22 Apr 2026 00:29:11 +0800
Message-ID: <20260421162912.3295598-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421162912.3295598-1-jim.shu@sifive.com>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1030.google.com
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
index 04e1f970caf..465614c5d9a 100644
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


