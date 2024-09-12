Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CB7EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socRq-0002wr-Em; Thu, 12 Sep 2024 01:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRV-0001OH-Cq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRT-0003CL-I4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so394530b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119150; x=1726723950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zhLGtCZcCsv5nuPN09/CvN94G3XOM8d23tZVuRBYY0=;
 b=QjCjrDEjTGdnWKf+H0Z+BChnUahrtkOteDZcqxD5vZJpqndoRrQCgUqcVM36MEd5kP
 NF9psgarVzAilPjdblZ9JBx2jjwItsv3BbZjF/Zfqd2Rxe+4aY3BLe6ZmvXj+cOkC01s
 2GYo9b23B+PoKYHGomcm0kyhFocImoueGIj39JJd9YTWrGNIQjRxaMZkOTUMQlPIYcq+
 YazatZCuSqhLpH25GFjaGvsyjCwIoywvDpIWaedmE0SW298LGDpRn+ibouTCJYiCBRSW
 wxGTTV+bhjoe+wgnHkkL2YhJs92OxX61YMR/x2GOv+hPJQ+YNmMtX1WeBnrsA24nYfq6
 Q+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119150; x=1726723950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zhLGtCZcCsv5nuPN09/CvN94G3XOM8d23tZVuRBYY0=;
 b=TrXt+TbtpUggHO4Zo1Qip4RY+Yvwj8mA5+NB7dQAe4PiMF2b+cEIoQEVnehIGDR+4N
 Torvx01NSBlViYy5iK/POZRkBlMDyRF++ugrdwKNkfAVLjjfMaeoLJWf+Cz+99m1t57H
 AyUTepX1uYhDqwSGUpYwXTDH0nHWd1COhEVpUpzaYhF/a0nfDAh0/EFXN2IwnCyI8dMT
 qgJx01dqOZmUUHBYGgd0GbIaIJ49aqpCYnZ8p/9o9KFhlJ2mcIaupMmZwV8wZe7lfgAv
 qftVJfZk7tL3ksq1o8LAYbEXLEbyetFDh/HSV7rQjn/piAsvraFVRX2mHi9jfMrlsFh4
 ZFtg==
X-Gm-Message-State: AOJu0Yzwfc+pHOKPQ4Kqs4mCZ1+nc3ScEQfV7o80J4tiBOvFk/QDODr7
 fS8KPPKqSRGvAeZwMgNY8SX5Dtt855JLG8Ge4VTytilsz45LmEgUcc8hCQ==
X-Google-Smtp-Source: AGHT+IG/81Q56w6sffhk9aDWntHda+qv0m7ca4orwUvZw8u2DFZD5/q9Ni1ZAqPRJEYKsppTQG10NA==
X-Received: by 2002:a05:6a00:228a:b0:717:87af:fca0 with SMTP id
 d2e1a72fcca58-71925f9de4emr2900521b3a.0.1726119149517; 
 Wed, 11 Sep 2024 22:32:29 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/47] hw/intc: riscv-imsic: Fix interrupt state updates.
Date: Thu, 12 Sep 2024 15:29:52 +1000
Message-ID: <20240912052953.2552501-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The IMSIC state variable eistate[] is modified by CSR instructions
within a range dedicated to the local CPU and by MMIO writes from any CPU.
Access to eistate from MMIO accessors is protected by the BQL, but
read-modify-write (RMW) sequences from CSRRW do not acquire the BQL,
making the RMW sequence vulnerable to a race condition with MMIO access
from a remote CPU.

This race can manifest as missing IPI or MSI in multi-CPU systems, eg:

[   43.008092] watchdog: BUG: soft lockup - CPU#2 stuck for 27s! [kworker/u19:1:52]
[   43.011723] CPU: 2 UID: 0 PID: 52 Comm: kworker/u19:1 Not tainted 6.11.0-rc6
[   43.013070] Workqueue: events_unbound deferred_probe_work_func
[   43.018776] [<ffffffff800b4a86>] smp_call_function_many_cond+0x190/0x5c2
[   43.019205] [<ffffffff800b4f28>] on_each_cpu_cond_mask+0x20/0x32
[   43.019447] [<ffffffff8001069a>] __flush_tlb_range+0xf2/0x190
[   43.019683] [<ffffffff80010914>] flush_tlb_kernel_range+0x20/0x28

The interrupt line raise/lower sequence was changed to prevent a race
between the evaluation of the eistate and the execution of the qemu_irq
raise/lower, ensuring that the interrupt line is not incorrectly
deactivated based on a stale topei check result. To avoid holding BQL
all modifications of eistate are converted to atomic operations.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <a7604e4d61068ca4d384ae2a1377e1521d4d0235.1725651699.git.tjeznach@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_imsic.c | 50 +++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index b90f0d731d..9ef65d4012 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -55,7 +55,7 @@ static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
                (imsic->eithreshold[page] <= imsic->num_irqs)) ?
                imsic->eithreshold[page] : imsic->num_irqs;
     for (i = 1; i < max_irq; i++) {
-        if ((imsic->eistate[base + i] & IMSIC_EISTATE_ENPEND) ==
+        if ((qatomic_read(&imsic->eistate[base + i]) & IMSIC_EISTATE_ENPEND) ==
                 IMSIC_EISTATE_ENPEND) {
             return (i << IMSIC_TOPEI_IID_SHIFT) | i;
         }
@@ -66,10 +66,24 @@ static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
 
 static void riscv_imsic_update(RISCVIMSICState *imsic, uint32_t page)
 {
+    uint32_t base = page * imsic->num_irqs;
+
+    /*
+     * Lower the interrupt line if necessary, then evaluate the current
+     * IMSIC state.
+     * This sequence ensures that any race between evaluating the eistate and
+     * updating the interrupt line will not result in an incorrectly
+     * deactivated connected CPU IRQ line.
+     * If multiple interrupts are pending, this sequence functions identically
+     * to qemu_irq_pulse.
+     */
+
+    if (qatomic_fetch_and(&imsic->eistate[base], ~IMSIC_EISTATE_ENPEND)) {
+        qemu_irq_lower(imsic->external_irqs[page]);
+    }
     if (imsic->eidelivery[page] && riscv_imsic_topei(imsic, page)) {
         qemu_irq_raise(imsic->external_irqs[page]);
-    } else {
-        qemu_irq_lower(imsic->external_irqs[page]);
+        qatomic_or(&imsic->eistate[base], IMSIC_EISTATE_ENPEND);
     }
 }
 
@@ -125,12 +139,11 @@ static int riscv_imsic_topei_rmw(RISCVIMSICState *imsic, uint32_t page,
         topei >>= IMSIC_TOPEI_IID_SHIFT;
         base = page * imsic->num_irqs;
         if (topei) {
-            imsic->eistate[base + topei] &= ~IMSIC_EISTATE_PENDING;
+            qatomic_and(&imsic->eistate[base + topei], ~IMSIC_EISTATE_PENDING);
         }
-
-        riscv_imsic_update(imsic, page);
     }
 
+    riscv_imsic_update(imsic, page);
     return 0;
 }
 
@@ -139,7 +152,7 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
                                uint32_t num, bool pend, target_ulong *val,
                                target_ulong new_val, target_ulong wr_mask)
 {
-    uint32_t i, base;
+    uint32_t i, base, prev;
     target_ulong mask;
     uint32_t state = (pend) ? IMSIC_EISTATE_PENDING : IMSIC_EISTATE_ENABLED;
 
@@ -157,10 +170,6 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
 
     if (val) {
         *val = 0;
-        for (i = 0; i < xlen; i++) {
-            mask = (target_ulong)1 << i;
-            *val |= (imsic->eistate[base + i] & state) ? mask : 0;
-        }
     }
 
     for (i = 0; i < xlen; i++) {
@@ -172,10 +181,15 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
         mask = (target_ulong)1 << i;
         if (wr_mask & mask) {
             if (new_val & mask) {
-                imsic->eistate[base + i] |= state;
+                prev = qatomic_fetch_or(&imsic->eistate[base + i], state);
             } else {
-                imsic->eistate[base + i] &= ~state;
+                prev = qatomic_fetch_and(&imsic->eistate[base + i], ~state);
             }
+        } else {
+            prev = qatomic_read(&imsic->eistate[base + i]);
+        }
+        if (val && (prev & state)) {
+            *val |= mask;
         }
     }
 
@@ -302,14 +316,14 @@ static void riscv_imsic_write(void *opaque, hwaddr addr, uint64_t value,
     page = addr >> IMSIC_MMIO_PAGE_SHIFT;
     if ((addr & (IMSIC_MMIO_PAGE_SZ - 1)) == IMSIC_MMIO_PAGE_LE) {
         if (value && (value < imsic->num_irqs)) {
-            imsic->eistate[(page * imsic->num_irqs) + value] |=
-                                                    IMSIC_EISTATE_PENDING;
+            qatomic_or(&imsic->eistate[(page * imsic->num_irqs) + value],
+                       IMSIC_EISTATE_PENDING);
+
+            /* Update CPU external interrupt status */
+            riscv_imsic_update(imsic, page);
         }
     }
 
-    /* Update CPU external interrupt status */
-    riscv_imsic_update(imsic, page);
-
     return;
 
 err:
-- 
2.46.0


