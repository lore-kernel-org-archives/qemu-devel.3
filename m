Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A29FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHku0-0003wN-3G; Tue, 28 Apr 2026 12:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksU-00039w-A7
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksP-0003lH-57
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so9658538b3a.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777392091; x=1777996891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Hx21rvPtv3e1ezzyiyMTIiO3uaK5NV82dpiR14Fe1A=;
 b=I6cf0xLZ2xEBIqzjR+6APzJjiFFPGJOUbR0J0z3b5UILgXFyZi174TgpejsvxMhsO6
 KAisXGrB5SRt5/Q1ZcwnU0ST1wLvUjixhUiuKdnxoE03CtB+xINYFzFy1Ugm6NGHkVKL
 npwpME9m6tQd13DqR5rkRUcXl4UjIv3Xx5LyiICBz4WCC16emxk2ki8EM/NB4r7kt5b8
 Het4+RGisVQOElvW9Ok6IC0z6DljyZFfm8BZdqMa5DCm0z73VIHVVa7RXUZjgSgORJE4
 yKE7XmMILbDOSyjyyO0ECYTVzgJcXMFuSFSnPy3zOx2WAhjVwOOQ7C3qqaOkBfXzLybi
 NHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392091; x=1777996891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Hx21rvPtv3e1ezzyiyMTIiO3uaK5NV82dpiR14Fe1A=;
 b=JSwbmnoRtdZODMfq444dOWyTm/wiL/KiAMbIhXCwQsr2R21u7VOC0y09JK7KQN9Raj
 A+avl4oxMPHZkS3Xclp1XgMON32/4YWgcy2+2zXjps/eJ8MvfUFN6jsHIXVl4rbmrIRS
 PIfUzHiQEKobKs9JzQGEJxu83wLKmcPENRsWO5qqxrXYaNR564sKDDiiQaM5tx0AUgqt
 a/V4mGkLk1s25l2SThRLgxUQ6MU3JZuIUKiRlcF6naioXv7J0d8sE6zOC1/HePI/EoPq
 ws3TbuaMkncHYTLjInlR0yLaTQX0W337XBSjQ+8PD/TDYE9MShD5x1VNkpnTYQ+rtXTF
 sWkA==
X-Gm-Message-State: AOJu0Yy5tVOdHTRIbX+66IpLV7COQAUf1PEwjzo2TIbFFHl8JcVulPJj
 6wLWDFbv55zPWo/SSlG1YB6qbIB6lKKaP9DotQQ1pKVYFQxhpsl1xq3mo0BOpoZkVWklHsCU2tk
 PQUU1blfVS1+ZsvdrhBecnVvSVhNbogLUlxZVD4o586kcgxSs+5nFqxc+ADf2L1WLLdYJtzxeHj
 fgwKwjhEzSXF25dY/sEKb11KehAMphcRqX1SpJlE+l
X-Gm-Gg: AeBDiev8dlfvT9G0LT5qN991WqxFTLp+xH9BpInl9p/KlKwPoEpARHaaU0xxBEZONy4
 cDD6EWnuxIH+OvunNFsY5aEpelPPuql4fiEvGdSfBIHl4FIyahkVZUgHzbAxXsuHyTCH9VRkxnW
 1v2gW2FYsJl3iATT8QppIJh6ar4AfZDDCRncsJaoC9hWeMZ5FmmbKuHo9DYXqFayKGyC/80srmn
 SVOgbym7wRaJir0+HwEjvI08/Vxd99wLcOChjWTUlr1rwgOrx02gVR0e8cheZO1LaBXDuGpxiZF
 rP8KNmHRSPCAOFZScOigFwb52MUeKDTwjfOGZ4l6w8nMdxKAlvbVy3uL4xA+dt4DkBkALuZs6MN
 4D+pJaho6GBsS5Ic9owXwTSsu1dzW92Lonl5RFSea4E4VMyUfvqA4uG0iMzZZpR4U8vnaG6nBhQ
 Z7Hcy6CRrSsOXitQvEM0zhi7UMLKkDGHRtMinpLgX+gGzUd3UMIgfI4P0=
X-Received: by 2002:a05:6a00:3989:b0:82f:8a29:e3b4 with SMTP id
 d2e1a72fcca58-834ddc9558amr3530183b3a.50.1777392090710; 
 Tue, 28 Apr 2026 09:01:30 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf30fbfsm3002331b3a.33.2026.04.28.09.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:01:30 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 4/4] hw/intc: riscv_aplic: add trace events of APLIC
 read/write function
Date: Wed, 29 Apr 2026 00:01:03 +0800
Message-ID: <20260428160103.3551125-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428160103.3551125-1-jim.shu@sifive.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
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

Add the trace events for APLIC read/write functions.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/intc/riscv_aplic.c | 63 ++++++++++++++++++++++++++-----------------
 hw/intc/trace-events  |  4 +++
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a04e0e1a898..55515d1a085 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -35,6 +35,7 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
+#include "trace.h"
 
 #define APLIC_MAX_IDC                  (1UL << 14)
 #define APLIC_MAX_SOURCE               1024
@@ -626,6 +627,7 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
 static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
 {
     uint32_t irq, word, idc;
+    uint64_t val;
     RISCVAPLICState *aplic = opaque;
 
     /* Reads must be 4 byte words */
@@ -634,18 +636,18 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     if (addr == APLIC_DOMAINCFG) {
-        return APLIC_DOMAINCFG_RDONLY | aplic->domaincfg |
-               (aplic->msimode ? APLIC_DOMAINCFG_DM : 0);
+        val = APLIC_DOMAINCFG_RDONLY | aplic->domaincfg |
+              (aplic->msimode ? APLIC_DOMAINCFG_DM : 0);
     } else if ((APLIC_SOURCECFG_BASE <= addr) &&
             (addr < (APLIC_SOURCECFG_BASE + (aplic->num_irqs - 1) * 4))) {
         irq  = ((addr - APLIC_SOURCECFG_BASE) >> 2) + 1;
-        return aplic->sourcecfg[irq];
+        val = aplic->sourcecfg[irq];
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDR)) {
-        return aplic->mmsicfgaddr;
+        val = aplic->mmsicfgaddr;
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDRH)) {
-        return aplic->mmsicfgaddrH;
+        val = aplic->mmsicfgaddrH;
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_SMSICFGADDR)) {
         /*
@@ -657,65 +659,74 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
          *     only zero in at least one of the supervisor-level child
          * domains).
          */
-        return (aplic->num_children) ? aplic->smsicfgaddr : 0;
+        val = (aplic->num_children) ? aplic->smsicfgaddr : 0;
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_SMSICFGADDRH)) {
-        return (aplic->num_children) ? aplic->smsicfgaddrH : 0;
+        val = (aplic->num_children) ? aplic->smsicfgaddrH : 0;
     } else if ((APLIC_SETIP_BASE <= addr) &&
             (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
         word = (addr - APLIC_SETIP_BASE) >> 2;
-        return riscv_aplic_read_pending_word(aplic, word);
+        val = riscv_aplic_read_pending_word(aplic, word);
     } else if (addr == APLIC_SETIPNUM) {
-        return 0;
+        val = 0;
     } else if ((APLIC_CLRIP_BASE <= addr) &&
             (addr < (APLIC_CLRIP_BASE + aplic->bitfield_words * 4))) {
         word = (addr - APLIC_CLRIP_BASE) >> 2;
-        return riscv_aplic_read_input_word(aplic, word);
+        val = riscv_aplic_read_input_word(aplic, word);
     } else if (addr == APLIC_CLRIPNUM) {
-        return 0;
+        val = 0;
     } else if ((APLIC_SETIE_BASE <= addr) &&
             (addr < (APLIC_SETIE_BASE + aplic->bitfield_words * 4))) {
         word = (addr - APLIC_SETIE_BASE) >> 2;
-        return riscv_aplic_read_enabled_word(aplic, word);
+        val = riscv_aplic_read_enabled_word(aplic, word);
     } else if (addr == APLIC_SETIENUM) {
-        return 0;
+        val = 0;
     } else if ((APLIC_CLRIE_BASE <= addr) &&
             (addr < (APLIC_CLRIE_BASE + aplic->bitfield_words * 4))) {
-        return 0;
+        val = 0;
     } else if (addr == APLIC_CLRIENUM) {
-        return 0;
+        val = 0;
     } else if (addr == APLIC_SETIPNUM_LE) {
-        return 0;
+        val = 0;
     } else if (addr == APLIC_SETIPNUM_BE) {
-        return 0;
+        val = 0;
     } else if (addr == APLIC_GENMSI) {
-        return (aplic->msimode) ? aplic->genmsi : 0;
+        val = (aplic->msimode) ? aplic->genmsi : 0;
     } else if ((APLIC_TARGET_BASE <= addr) &&
             (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
         irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
         if (!riscv_aplic_source_active(aplic, irq)) {
-            return 0;
+            val = 0;
+        } else {
+            val = aplic->target[irq];
         }
-        return aplic->target[irq];
     } else if (!aplic->msimode && (APLIC_IDC_BASE <= addr) &&
             (addr < (APLIC_IDC_BASE + aplic->num_harts * APLIC_IDC_SIZE))) {
         idc = (addr - APLIC_IDC_BASE) / APLIC_IDC_SIZE;
         switch (addr - (APLIC_IDC_BASE + idc * APLIC_IDC_SIZE)) {
         case APLIC_IDC_IDELIVERY:
-            return aplic->idelivery[idc];
+            val = aplic->idelivery[idc];
+            break;
         case APLIC_IDC_IFORCE:
-            return aplic->iforce[idc];
+            val = aplic->iforce[idc];
+            break;
         case APLIC_IDC_ITHRESHOLD:
-            return aplic->ithreshold[idc];
+            val = aplic->ithreshold[idc];
+            break;
         case APLIC_IDC_TOPI:
-            return riscv_aplic_idc_topi(aplic, idc);
+            val = riscv_aplic_idc_topi(aplic, idc);
+            break;
         case APLIC_IDC_CLAIMI:
-            return riscv_aplic_idc_claimi(aplic, idc);
+            val = riscv_aplic_idc_claimi(aplic, idc);
+            break;
         default:
             goto err;
         };
     }
 
+    trace_riscv_aplic_read(addr, size, val);
+    return val;
+
 err:
     qemu_log_mask(LOG_GUEST_ERROR,
                   "%s: Invalid register read 0x%" HWADDR_PRIx "\n",
@@ -734,6 +745,8 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
         goto err;
     }
 
+    trace_riscv_aplic_write(addr, size, value);
+
     if (addr == APLIC_DOMAINCFG) {
         /* Only IE bit writable at the moment */
         value &= APLIC_DOMAINCFG_IE;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 018c609ca5e..36ea75049ab 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -330,3 +330,7 @@ loongarch_msi_set_irq(int irq_num) "set msi irq %d"
 loongarch_extioi_setirq(int irq, int level) "set extirq irq %d level %d"
 loongarch_extioi_readw(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64 "val: 0x%" PRIx64
 loongarch_extioi_writew(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64 "val: 0x%" PRIx64
+
+# riscv_aplic.c
+riscv_aplic_read(uint64_t offset, unsigned size, uint64_t value) "offset: 0x%" PRIx64 ", size: %u, value: 0x%" PRIx64
+riscv_aplic_write(uint64_t offset, unsigned size, uint64_t value) "offset: 0x%" PRIx64 ", size: %u, value: 0x%" PRIx64
-- 
2.43.0


