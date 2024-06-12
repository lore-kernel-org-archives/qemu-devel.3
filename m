Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD55C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJ9N-0005EV-FT; Wed, 12 Jun 2024 04:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ9M-0005Cz-0J
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:16:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ9I-0006pL-SC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:16:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f6f031549bso18335775ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718180163; x=1718784963; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YBsKz2cXW2irXTYX6EDVGeIkb/sGQaekYYfYimSeHNs=;
 b=HYYkazSea+v0kWRPaUOkwuoPTLEmjqUJsBfA4nWFPULem3yUJeZSrugi5ah1sLVbOB
 XMhsg8eXUF1dMp43rjyQeAn9RBXbsiElnypCR7Y2CGZEv+CcQF83KT9LjRalS3En7l+R
 IkGWoYlpQFDgLwrwd96SNo/SKcomLnhH3ZWVW62g6v2ciq24hRvXLyEaJHR2FTC2vEtt
 ae2l8wb93Sy97BzIS0cCz9WOtVephP+kMOle9bnKS2zTzq+UB84JCHeO1MdtrpZhi830
 wlQQppL2ohlst/JLRbiMCv/d1M5Yh+EtyOBjQkniHGCvlPv8ES9l58rB4Ks1EQDjQTTt
 YHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180163; x=1718784963;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YBsKz2cXW2irXTYX6EDVGeIkb/sGQaekYYfYimSeHNs=;
 b=txZw7ORv6OVQSjnevK8718xIZbr8ajvopTfNKp5hWdwY1THSENm+iTqSeGUHAVFHjM
 PIEEa7Ajbv1BkrGUVW1dUYyOnRf65QodWan3V04kWavHijteB8fKfO+WL/X7hLWdYimh
 moD4Ip7Ro7jyz3oEyFpijkBXLiLBkhDIAJjYWYDo+YKzeHCLJszhxjZn+892r/aoMDGm
 CR/z1qDOgjg0aBNJa68qd5rNnjMfxlDzE8+jm1BUxba8C2SbRWAvjMpAgcIm5VPFVUeB
 XlV1BpZuYd6ZvHTN86IQwUllSZGiJZerNxFQmxnHdDcMB8OH2WSwcYAzHJE6Elx1B+fy
 E6Dg==
X-Gm-Message-State: AOJu0YwiUV2ft8LgF4TyUZlNoe3npNvdyadp1ekG4vMYPE20azNjMvuk
 2cZFqy+2FAr7IWWQagLZgL88P3P9x8xYoQFlxZfZ5PvyXHdnKxuN8pGDTLU7GsPm6XXyJGT4sC9
 f+1YgT51HKgZsbpxBFdxbMIVA/Z8k8T8Q9PhqQJKbR+xa3iAeC2v1Rf6ERFebClc3b5kA62l+bs
 PoIL/npoC/E+r9PEFLP2IsbbRE6IDIM0CqUWkDjqpnMg==
X-Google-Smtp-Source: AGHT+IG37UdgaXu8P2JE+gz6Z04qZbuplDZsS5uh0eTnm+7cZyvd+6A2KsrYWqSuWBp0hb0P1u7NNA==
X-Received: by 2002:a17:902:d2c6:b0:1f7:178e:60a4 with SMTP id
 d9443c01a7336-1f83b517aabmr13665965ad.7.1718180162752; 
 Wed, 12 Jun 2024 01:16:02 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8393e8e53sm11363875ad.16.2024.06.12.01.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:16:02 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
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
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [RFC PATCH 15/16] hw/misc: riscv_wgchecker: Check the slot settings
 in translate
Date: Wed, 12 Jun 2024 16:14:15 +0800
Message-Id: <20240612081416.29704-16-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 55e5e8127f..cab4e40921 100644
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
index a64c7f0f9f..80907c45d2 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -359,3 +359,4 @@ riscv_wgchecker_mmio_write(uint64_t base, uint64_t offset, unsigned int size, ui
 riscv_wgc_mem_blocked_read(uint64_t addr, unsigned size, uint32_t wid) "wgChecker blocked read: offset 0x%" PRIx64 " size %u wid %" PRIu32
 riscv_wgc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, uint32_t wid) "wgChecker blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u wid %" PRIu32
 riscv_wgc_translate(uint64_t addr, int flags, int wid, const char *res) "wgChecker translate: addr 0x%016" PRIx64 " flags 0x%x wid %d: %s"
+riscv_wgc_iommu_notify_all(void) "wgChecker iommu: notifying UNMAP for all"
-- 
2.17.1


