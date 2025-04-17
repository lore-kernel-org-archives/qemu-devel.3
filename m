Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2A9C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MtJ-0000aj-Pu; Thu, 17 Apr 2025 06:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MtH-0000XD-EH
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MtB-0003nq-SC
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2279915e06eso6755485ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887276; x=1745492076; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zQPqjXYVy2MZpkzlsyhoG+MQg9fKVsZKI/VvPlBGP+g=;
 b=KRK9X5QTdQjpJLo6yOINvlj9KNuSEZCmQYkhb84enEeg73Il+kiDaRGsfFQARZ7z3V
 uSMVCBCJXXYAyreSozkODU23DUq47ydms9WvkI7O/VYTryY4zukxrAgTYPxOrSKAN6Lj
 n1fxkQn05d+BMC0QGpfRMpygV7vLlE1psUifyWyUZUk2VEdU/rGlT7WRLHkjI/AmUclB
 X8bl8hHNSPdYEg43CdEueMNFWor2ibYzws5kaV4Frd1uFLlaBs9cFEAFTeKs84Uy5HgV
 WtYxPzTgO/EpZLdVVkxzgxdJ56JTlVUgJrDgt/gb4LUdiU1TDTAAYWJK1HXWnx/I6r4P
 z3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887276; x=1745492076;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQPqjXYVy2MZpkzlsyhoG+MQg9fKVsZKI/VvPlBGP+g=;
 b=qQmc/BYU3q65njs1cEqZUqtB9OYQ7WhD6du/538Od0/xsizUDMjD5taE2O9xvNlxUT
 BgZ8o/UurHixQvYupZ5rSGzlOIqIZsBBeKXt45e7jiiCeXqFQ5Nmmayj+vZhV7Yl/3NU
 rwWnXMRrYjPa5Chv6dUQ4ZxSRKlTk6pqUlrjqMxkFrq8XeyY7NwpJELI2A1vWfF0oCFQ
 1J8mjX30TYKJ2QYltUeLIL/caVPbbY3CSqtqIr1PJrIaTVViaYjkgnFsniCxYyZnfV+d
 5j4Ybe+zkt75XQXHayn4AFhlhMkkjetYJOu+Cj3OkcLOWT0MDFE0EvxZE96DCFV0emAf
 OOzw==
X-Gm-Message-State: AOJu0YyQsi5Do6P9hYpDYN6zqFR/iE/SBAn8QRK0WYZaXnGEWgCdEmlN
 W0dm02jGxz3Q+1vJ2OPtpc1aPA9bmWzQrvb6IGxOBb45IasF6ubipPInSrAzox8oA90IK/z3mux
 klxwMwZZPPzVNw8paDNl6aV/yrGN4gIMbq4OGgbVm98VwYMtD25jl3YLRzksPgObJlTZ9my+Fal
 +hChFDaB3Eroe0wdr8uqahTq5xftwJxyBiTg==
X-Gm-Gg: ASbGncvDAWSS8/fali/KVjUnyE9nFqd7TwLO6r3/0xfWPETdLqhgcsWcFVkDIIO94iu
 B3Lr/XTqha669Kfxn52qXGGWCfuKUAyhqOGo1j078HR9gPumEZ1jtAEhy7akvs8RJJIiK34O7R/
 r7IIwCwtP7fwcSpmGxdut2l9YSAfrQ5z7sRzg4smr0iiOFgubMCFQp9RjBsv9qplzjVXvzfUfQn
 XRpzXlUHKj8nB6jamGEnJIc0CGZuzBquXziiVQdF1eN8eZGJbhNuAK2OwihMi2xZbSxHhoTfqMz
 4U++/AN51sGufyvTL8ebecGOozPYN4HvSHaW/bkfF9FJ6IIUGrLNeAd2aCXidr4=
X-Google-Smtp-Source: AGHT+IE4m/QZrr2Q6Luap6Pg7J62BHPXXU9yOa9/DWDaGYQ/X6pxr3b7Xqvv907SRhkPiLLuthmhAA==
X-Received: by 2002:a17:902:ea12:b0:223:5241:f5ca with SMTP id
 d9443c01a7336-22c358db91bmr60556795ad.20.1744887275787; 
 Thu, 17 Apr 2025 03:54:35 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:54:35 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 17/18] hw/misc: riscv_wgchecker: Check the slot settings in
 translate
Date: Thu, 17 Apr 2025 18:52:48 +0800
Message-Id: <20250417105249.18232-18-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x634.google.com
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

The final part of wgChecker we need to implement is actually using the
wgChecker slots programmed by guest to determine whether to block the
transaction or not.

Since this means we now change transaction mappings when
the guest writes to wgChecker slots, we must also call the IOMMU
notifiers at that point.

One tricky part here is that the perm of 'blocked_io_as' is the
condition of deny access. For example, if wgChecker only permits RO
access, the perm of 'downstream_as' will be IOMMU_RO and the perm of
'blocked_io_as' will be IOMMU_WO.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/riscv_wgchecker.c | 70 ++++++++++++++++++++++++++++++++++++---
 hw/misc/trace-events      |  1 +
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
index 5d2af7946f..5a70231837 100644
--- a/hw/misc/riscv_wgchecker.c
+++ b/hw/misc/riscv_wgchecker.c
@@ -100,6 +100,52 @@ REG32(SLOT_CFG,             0x010)
 #define P_READ                  (1 << 0)
 #define P_WRITE                 (1 << 1)
 
+static IOMMUAccessFlags wgc_perm_to_iommu_flags(int wgc_perm)
+{
+    if (wgc_perm == (P_READ | P_WRITE)) {
+        return IOMMU_RW;
+    } else if (wgc_perm & P_WRITE) {
+        return IOMMU_WO;
+    } else if (wgc_perm & P_READ) {
+        return IOMMU_RO;
+    } else {
+        return IOMMU_NONE;
+    }
+}
+
+static void wgchecker_iommu_notify_all(RISCVWgCheckerState *s)
+{
+    /*
+     * Do tlb_flush() to whole address space via memory_region_notify_iommu()
+     * when wgChecker changes it's config.
+     */
+
+    IOMMUTLBEvent event = {
+        .entry = {
+            .addr_mask = -1ULL,
+        }
+    };
+
+    trace_riscv_wgc_iommu_notify_all();
+
+    for (int i=0; i<WGC_NUM_REGIONS; i++) {
+        WgCheckerRegion *region = &s->mem_regions[i];
+        uint32_t nworlds = worldguard_config->nworlds;
+
+        if (!region->downstream) {
+            continue;
+        }
+        event.entry.iova = 0;
+        event.entry.translated_addr = 0;
+        event.type = IOMMU_NOTIFIER_UNMAP;
+        event.entry.perm = IOMMU_NONE;
+
+        for (int wid=0; wid<nworlds; wid++) {
+            memory_region_notify_iommu(&region->upstream, wid, event);
+        }
+    }
+}
+
 static void decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
 {
     /*
@@ -309,6 +355,9 @@ static IOMMUTLBEntry riscv_wgc_translate(IOMMUMemoryRegion *iommu,
 {
     WgCheckerRegion *region = container_of(iommu, WgCheckerRegion, upstream);
     RISCVWgCheckerState *s = RISCV_WGCHECKER(region->wgchecker);
+    bool is_write;
+    WgAccessResult result;
+    int wgc_perm;
     hwaddr phys_addr;
     uint64_t region_size;
 
@@ -327,18 +376,25 @@ static IOMMUTLBEntry riscv_wgc_translate(IOMMUMemoryRegion *iommu,
      * Look at the wgChecker configuration for this address, and
      * return a TLB entry directing the transaction at either
      * downstream_as or blocked_io_as, as appropriate.
-     * For the moment, always permit accesses.
      */
 
     /* Use physical address instead of offset */
     phys_addr = addr + region->region_offset;
+    is_write = (flags == IOMMU_WO);
 
-    is_success = true;
+    result = wgc_check_access(s, phys_addr, iommu_idx, is_write);
 
     trace_riscv_wgc_translate(phys_addr, flags,
-        iommu_idx, is_success ? "pass" : "block");
+        iommu_idx, result.is_success ? "pass" : "block");
 
-    ret.target_as = is_success ? &region->downstream_as : &region->blocked_io_as;
+    wgc_perm = result.perm;
+    if (!result.is_success) {
+        /* if target_as is blocked_io_as, the perm is the condition of deny access. */
+        wgc_perm ^= (P_READ | P_WRITE);
+    }
+    ret.perm = wgc_perm_to_iommu_flags(wgc_perm);
+
+    ret.target_as = result.is_success ? &region->downstream_as : &region->blocked_io_as;
     return ret;
 }
 
@@ -604,6 +660,9 @@ static void riscv_wgchecker_writeq(void *opaque, hwaddr addr,
             break;
         }
 
+        /* Flush softmmu TLB when wgChecker changes config. */
+        wgchecker_iommu_notify_all(s);
+
         return;
     }
 
@@ -699,6 +758,9 @@ static void riscv_wgchecker_writel(void *opaque, hwaddr addr,
             break;
         }
 
+        /* Flush softmmu TLB when wgChecker changes config. */
+        wgchecker_iommu_notify_all(s);
+
         return;
     }
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b1d8538220..54dfcd50a1 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -403,3 +403,4 @@ riscv_wgchecker_mmio_write(uint64_t base, uint64_t offset, unsigned int size, ui
 riscv_wgc_mem_blocked_read(uint64_t addr, unsigned size, uint32_t wid) "wgChecker blocked read: offset 0x%" PRIx64 " size %u wid %" PRIu32
 riscv_wgc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, uint32_t wid) "wgChecker blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u wid %" PRIu32
 riscv_wgc_translate(uint64_t addr, int flags, int wid, const char *res) "wgChecker translate: addr 0x%016" PRIx64 " flags 0x%x wid %d: %s"
+riscv_wgc_iommu_notify_all(void) "wgChecker iommu: notifying UNMAP for all"
-- 
2.17.1


