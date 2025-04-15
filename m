Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C1C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bSn-00027y-9d; Tue, 15 Apr 2025 04:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bR3-0002KD-Og
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQy-00026q-DY
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:25 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-aee773df955so5009712a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704858; x=1745309658; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zQPqjXYVy2MZpkzlsyhoG+MQg9fKVsZKI/VvPlBGP+g=;
 b=N7mMyMdRGPQf0dIpQU/OVlwAMYxUxcV1n/OGIz+wrFwK93dW9069jOjTaaS0n52t+h
 LEjVirUYggSviMMPEeijTH78VlXE0qJCQ9JxA1q5igSHUFyxJiUA63OsHooWQ1zXrh5r
 QmiZlAgcbdEkdubWsYz5F9zLURccAig6GU4Q/oU2F2q3/WtJL7w/j2kdeCikpWI9q5NA
 7JN/mBTws5jlSqUZd2LspUskU25JGFcsRwJLAsRqFx/ZIq1Sv2h3fTZ4D72ExxiHbIRL
 HD/xMib3x8kHW/EgOnxfz6EeYUToQuzNIIPxvvsTUJuFnw2BMXfuITXXccwHEahfaIou
 NbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704858; x=1745309658;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQPqjXYVy2MZpkzlsyhoG+MQg9fKVsZKI/VvPlBGP+g=;
 b=WW9VvT3uHov0Vw1NVeCBE2F8zgtbAWOiKg2hd84LQgGcysJk6dYfDnsoKObO3Rpdmp
 4OAtpvoTZqphkbXBGqWqvuXWPbgJLI3i7NOZReFf79b1VcZ+o2Ck31XUMcp2WB/Y2esm
 U+UReo51BacTfvS0PStB0spYLdiHjCtk9tAJ6J279vpr1lKWlnlPSwyaypGOqmtjpeGM
 ioFb0fOmkttP2HFtPRAQhnDRmxTMh+zAWcLxIOfq0mPPSZWPez/MPRhXRjiC/dXI+onP
 ocAJJ45k4Eo1x+4SR4by2EIaDnYidJx9blzITJ3ocP5mXQdYWDr+6cjClq/v8ssSCOZ3
 oylA==
X-Gm-Message-State: AOJu0YyIheavehUiDefcgmoRnU3kJTYy2YtorD+Og33sad5rTuTkoUdC
 Ujl0it/7wg3olQWbzAJDWXYtJcwwc5MAV00XVnIswbCfonF6l21JxODKsHhZ04uM2N6uAlwnyQE
 /vZsaHRc/fODVihqHPgAI7Tou6wilXfGA6DEFapkX2xO7/+FcEMPa7N62BXOEuEVO2k8DWMgOx2
 iDK0idHmgmVRzQ7rHk4g0ACffCPiHnSfT5KQ==
X-Gm-Gg: ASbGncuUSMSg9a8Axd8pjXKf6gpQr8e73mCHYEPECEkcWfDN0fNAUzgw3kXOViSQ1bv
 QIzKH0vkhVv7B9/SwRXyFhjWZc10h4xocpMynqJ+KGymyyQbnEhu02b1xqHaSJU3/G7jSxt6i+v
 NQIv1wlOVvbjWIJEN3vfvN3nd3V04zjdYaYfJ4DwwUpRh+XFkmBRAFCnJqHDscWPiF0esm66Ilp
 SIhN6NUM6Bw0DDWqvrIN3oG6MMq7N2XXMQCd6mQgmEY4GpsLk0wMqyHW4/U7jxfxoIfkb2e8Cjs
 25AP91xvu40bkkIKodXkACJJavEm3Uux4P5F/FrUqhsLNTqY/4fgc8AnmSWNN8o=
X-Google-Smtp-Source: AGHT+IEJg5jW4QGqUiG5bxHCIDAmrdq674y5ICzayPjEgScWyAIJNmh/JIegAJbkrErhimbC448xmA==
X-Received: by 2002:a17:902:fc8d:b0:220:cfb7:56eb with SMTP id
 d9443c01a7336-22c249da9a8mr33204635ad.26.1744704857666; 
 Tue, 15 Apr 2025 01:14:17 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:14:17 -0700 (PDT)
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
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 16/17] hw/misc: riscv_wgchecker: Check the slot settings in
 translate
Date: Tue, 15 Apr 2025 16:12:30 +0800
Message-Id: <20250415081231.21186-17-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=jim.shu@sifive.com; helo=mail-pg1-x52e.google.com
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


