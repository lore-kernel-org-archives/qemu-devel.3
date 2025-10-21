Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870ACCCD1BA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF7R-0004Qp-RM; Tue, 21 Oct 2025 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBF7A-0004Mc-Ix
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:21:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBF6z-0002YP-Ef
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:21:27 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso4038370b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761063682; x=1761668482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eC9YC8UsMk4PwW0SP0X/PECmIUNXr4CBp0Q0dpINKAA=;
 b=ItDYrTg5bDPnFOOQMrCzQ6TXmBmAlfygfNDlXvm1isxRFm+q/dYwJIOl4yT3wL1Jq9
 akmcN4JcgdpB+ygRUvrvlLiSQdfkbAtZ6ZjThucOfRXknv/0Vth+H44slQDAO2ihRwsY
 gjsNsdGbkh+5M1zYgXd0j+GAs8qXImdeWG+RZGbslTt3JnTUwOlD5Evbn5Vc9NkpAMVq
 hPBwXmtAEE1Dmk1/AtWvdq9CwpNDlJYbdy9r2hFc5zeZheb93Ym56vewkMW/9ckux2xq
 G1jNSwkJS/3q/I8fxuhJBrQrvhJDmwY35JolyjH58LcE9+K4LXs/ybZRLe0D+vBwtS/g
 gYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063682; x=1761668482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eC9YC8UsMk4PwW0SP0X/PECmIUNXr4CBp0Q0dpINKAA=;
 b=DWnt1ZEa+rGdHIGvhcsSVsD+BxqNYK8aU6EGW142+YVCLpKJjBJHiKxFz7WqZRJa1/
 fLiUnuegmH7vSUG+alwgFXUcYWqgk0Ehlwy9jCJXUXXfLJ3bIyKK4HP6hwwriB7vkNNV
 gNs2Ob6mYQ5IXovfngwZ9fiH1idjzmgXBooTESPgdzrQNXIWSMyDx0+QJslnXe6y6shq
 OlcZJ34vdLeJGcLvPim6fSf1MK14W5dzZepuNZXCdqP/vzRjCyU/22QvCa6LV1GI7PRc
 rNLwp+O7H1Vm8KkpJBDPtY4ZXHJef1JtW1CoeU3LZELFqj2Xhi7ZDpqsg39vT/QMlidh
 f7AA==
X-Gm-Message-State: AOJu0YxI9q8QNxSC3G3i954hyBWGiHpWDL6RjRPw8EXwJUep0jNON4wS
 WgkwBc4QrdJdyfdNwxbhY/bmHjzVTkRZ1Y5CiTMmGy1k8srei5CKnedc8B5x4ssbn8xqMsNfrtC
 G7E3JnwBhxytJW76qBV2QL0+fU9co0GFZ9kz6w5l1rGsT2C0F+T/QGFFzf3P6tL8j40XpdSH2p+
 QHQAMYynzUlDQKH4yZrDtI3OaG+5k6lNePtlv4mA==
X-Gm-Gg: ASbGncvG0eYL8LVKm7SlET1jZEjnzNhYq3xnvdnlltWC/iJyuj2uaJy+azblJgcIPAH
 Zzz6syGhbvbqbiMnNA+bAUtkovw9jlsUH5rR9gxWteJNeA+bTXTeWu57ECnIsLt4K9PoolKXtfV
 JvQPJubVi/ETR5FqahPQW3xEGiHfW4GFu1V7SogVdqWQAMCmIb1SJ2FV/zL1MGNj09yw/aFlQJ4
 GylmKCCEtok8TYHhi/GRZK5kCq5Nv8QtZFYKnCHVq/95O5QiFXLceRAqOo6ktFf3IyXm23ySSPy
 fx0Q0Fg0tmvD4Pok54DYAl/m+xjzkkBRPBWh58irRON9pymfXYgxEJkyilWT2cTIqV8PN/JpaZK
 UOfve/XrDHuIdM9b5+OKh+55GW1wAPPdsQevwxBfqqDs44bgMAYGZMG57BBNCa/StZh23L62AXF
 dFBdtxQL2eS+yAnYDTlvZQ4A==
X-Google-Smtp-Source: AGHT+IH+zFQ5lzpqAqaMbs0TXG30X3bygXGYGISXE3B3C0r5eD94gFVNBIlKnzB9yExBvMUtp1+YNw==
X-Received: by 2002:a05:6a21:3290:b0:32d:a6d1:22b2 with SMTP id
 adf61e73a8af0-334a85047a0mr24997564637.10.1761063682008; 
 Tue, 21 Oct 2025 09:21:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23011088fsm11720280b3a.65.2025.10.21.09.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:21:21 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 17/18] hw/misc: riscv_wgchecker: Check the slot settings in
 translate
Date: Wed, 22 Oct 2025 00:21:07 +0800
Message-ID: <20251021162108.585468-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42f.google.com
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/riscv_wgchecker.c | 70 ++++++++++++++++++++++++++++++++++++---
 hw/misc/trace-events      |  1 +
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
index b4acdaa294..c23b076b1c 100644
--- a/hw/misc/riscv_wgchecker.c
+++ b/hw/misc/riscv_wgchecker.c
@@ -99,6 +99,52 @@ REG32(SLOT_CFG,             0x010)
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
+    trace_riscv_wgchecker_iommu_notify_all();
+
+    for (int i = 0; i < WGC_NUM_REGIONS; i++) {
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
+        for (int wid = 0; wid < nworlds; wid++) {
+            memory_region_notify_iommu(&region->upstream, wid, event);
+        }
+    }
+}
+
 static void decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
 {
     /*
@@ -317,6 +363,9 @@ static IOMMUTLBEntry riscv_wgc_translate(IOMMUMemoryRegion *iommu,
 {
     WgCheckerRegion *region = container_of(iommu, WgCheckerRegion, upstream);
     RISCVWgCheckerState *s = RISCV_WGCHECKER(region->wgchecker);
+    bool is_write;
+    WgAccessResult result;
+    int wgc_perm;
     hwaddr phys_addr;
     uint64_t region_size;
 
@@ -335,18 +384,25 @@ static IOMMUTLBEntry riscv_wgc_translate(IOMMUMemoryRegion *iommu,
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
 
     trace_riscv_wgchecker_translate(phys_addr, flags,
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
 
@@ -612,6 +668,9 @@ static void riscv_wgchecker_writeq(void *opaque, hwaddr addr,
             break;
         }
 
+        /* Flush softmmu TLB when wgChecker changes config. */
+        wgchecker_iommu_notify_all(s);
+
         return;
     }
 
@@ -708,6 +767,9 @@ static void riscv_wgchecker_writel(void *opaque, hwaddr addr,
             break;
         }
 
+        /* Flush softmmu TLB when wgChecker changes config. */
+        wgchecker_iommu_notify_all(s);
+
         return;
     }
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 7617b8843f..8505a9f964 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -417,3 +417,4 @@ riscv_wgchecker_mmio_write(uint64_t base, uint64_t offset, unsigned int size, ui
 riscv_wgchecker_mem_blocked_read(uint64_t phys_addr, unsigned size, uint32_t wid) "phys_addr = 0x%" PRIx64 ", size = %u, wid = %" PRIu32
 riscv_wgchecker_mem_blocked_write(uint64_t phys_addr, uint64_t data, unsigned size, uint32_t wid) "phys_addr = 0x%" PRIx64 ", data = 0x%" PRIx64 ", size = %u, wid = %" PRIu32
 riscv_wgchecker_translate(uint64_t addr, int flags, int wid, const char *res) "addr = 0x%016" PRIx64 ", flags = 0x%x, wid = %d: %s"
+riscv_wgchecker_iommu_notify_all(void) "notifying UNMAP for all"
-- 
2.43.0


