Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2222BCF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHH-0006M7-0K; Wed, 02 Oct 2024 01:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHD-0006Bi-B3
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHA-0004u1-F2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b833f9b35so26748605ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848311; x=1728453111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zA5UD5St7Qe8LKtJEIm5pD9ww54mrD+N+hg4wEFqK6g=;
 b=Y+p++O2X9DWyWDUzl44zG/Tz/tK1IaEpUPvpxyLIb0+cexIJrzuAM8voyrOYvUNj0i
 RjbbPGl99RvIjSeGxJxHlGiwApYOiHLh5Y0On8wUbJ9wGwHxayIYn43rLuuFW3u+b9yW
 KJYRFI2RDbYQ/NQRspS3tukEAIZvoJfaFKU5ADadlPnBqsnP4Cgz48znH/TrqBRnzv/L
 Au8+FUkqW4G8c2JyqeDmf1LC74u+7a+EnJZm5Cbk/wEyVJRMe5eEvfgxYEG69jqwCWRH
 2T8/RmRaRhwbo0dFoT+tS40Aw0Ul3vui6ZXVePEiT4hKJ+lL0hRd3/gXKjzhQtzfW9kf
 vRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848311; x=1728453111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zA5UD5St7Qe8LKtJEIm5pD9ww54mrD+N+hg4wEFqK6g=;
 b=dt+sqHaeeLMi6oxvu1WI6RwL9adjYtFP0uwn1MMw9UoC7pKFN4nuU71jcSIZsQxfgk
 7cF2rpruGO+Gr72Bf/LLINhx3Eb/yFzHHqaOtQcRRGl1MB1S2B/v95IUzHNa10ahF3/J
 0CSz99fBl42TTj4r984Va1DlNW92LwBMLFXAMv2CRKAUA+aTrtSRY7J7e0Eagw6Npkem
 TDSYoTQSV1Su+AYPV1X8E/FBprwEajFm5dLSl4xguFxYrG8bi5iLd/F/nChsYhpjhOeZ
 LTnDFLDKD23x6nXFF0IjfYCIRsqEo0ElRj4ovRgNS2r8RDESz4oJx7VeTQPXH8myxiKV
 +hoQ==
X-Gm-Message-State: AOJu0YxPsNhEdkyRJTmsa2d14vtgsh5DFNwgoEI3OiYP2JY1YrHl4vp9
 pnGKb/u6kRLRS6gNtconGVKrEGPscFtUqA3lJJntjpRV9zKM6bKN/3MMqatT
X-Google-Smtp-Source: AGHT+IFjdG5dm/seVkFa2zegWPYH7E96zWu14kisI5iktYVJtigeQnorzLsRoA8yhD2MWWht5BT2ag==
X-Received: by 2002:a17:903:41cc:b0:20b:532d:bb17 with SMTP id
 d9443c01a7336-20bc5a6b3acmr27843805ad.54.1727848310948; 
 Tue, 01 Oct 2024 22:51:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:50 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 18/35] hw/intc: riscv-imsic: Fix interrupt state updates.
Date: Wed,  2 Oct 2024 15:50:31 +1000
Message-ID: <20241002055048.556083-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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
2.46.2


