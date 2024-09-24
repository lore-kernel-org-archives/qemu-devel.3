Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F72DCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsj-0002EC-H4; Tue, 24 Sep 2024 18:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDse-0001rL-HS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsc-0001jK-IZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718d91eef2eso236174b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216373; x=1727821173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33F3ya+fqBx/xYgY52iatM++wmrPToizA8MVXxMx/wE=;
 b=L7m8IOyhnjqfkPY7k5fXfWQoxXJKNaRGJkZRd6lZUisvlgCP/WsRxbOvpK7doqYvKN
 359g/KQCmkZni50AOfzDB0Swf/B35IXi8rJe1Co5guqSWXqxE3/xpSc4Wk/8BbkgWo0H
 r3dCY1Y54IW5Ihd6+eERNyf09Ff1iExwzLyVjMED0nSX8LvxFdZc0cUyftvSdhV1nGm1
 zPS1uBFC2yXUqQAHeU0Auq2KNhsq+h2kU/Sbrvij1Yy8J4NQdYz/GaWHA5UFi/Gnv+UO
 bh/LHiB5Hxnl2kTLa1EMl5aCtUX+PRhDIXSXMNepMrvNDHR9QjELKhYm1MJVMzW+/Z3j
 76uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216373; x=1727821173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33F3ya+fqBx/xYgY52iatM++wmrPToizA8MVXxMx/wE=;
 b=JULtTbpcGKLjeU+dLT66+6L6jlgQPM7oEhaQ2phYwxzwZRf1b+utas2xdSbe92EFOL
 G0bSk4ejEt5bypSCIfNnW/oSl8T1XNIAtkPpiU4lhxCX0GKkFn/f3HUlp9WY6H+Ow+Gg
 idf1fpPUfUBh5q3I1kLanLUIygCByCnolL08iX28n9xsVFYMmCbDSyk2wq/kT7WvkUSh
 EcsbWxLJLet5otY0riTSz62EyE878wC75SqgFHs7rQ5CtDC9J3nPXzOJZAlxId0rjWya
 DqKFb1Ku31Z8CJoBzKmTQ2ZMCDeEayr5nxQ7BkyDwhxbDCWk7jgsWnhP+Akal3JhZV0v
 FV6A==
X-Gm-Message-State: AOJu0YyE4a2vnYV/NcXz7qH8RSN93L5LgyNxlccneWWUXMw/AgfB0nLX
 MTazbXK4Ngj/Rq/KY4mThwYkXMc/FZtqMZuHvIlXZJ9j9Vl9nBE9gbOTYQ==
X-Google-Smtp-Source: AGHT+IFDC+6v15uRcyDzCsFcGFoc5TYS2qdfyO2bIt8Ui+mKEohtJQoyULRV03ulfhsNAT/NOHO8bw==
X-Received: by 2002:a05:6a00:3d4a:b0:717:9743:e4fb with SMTP id
 d2e1a72fcca58-71b0b2d3ebbmr1009538b3a.14.1727216372804; 
 Tue, 24 Sep 2024 15:19:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 30/47] hw/intc: riscv-imsic: Fix interrupt state updates.
Date: Wed, 25 Sep 2024 08:17:31 +1000
Message-ID: <20240924221751.2688389-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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
2.46.1


