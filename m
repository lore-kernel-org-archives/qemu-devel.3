Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B565CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQC-0005J6-WD; Thu, 21 May 2026 20:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDP6-0003fl-E1
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDP0-0004tf-2r
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bd2051167eso31329275ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408368; x=1780013168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twKNIA8iq6mVfGklHL0d5uqCz0627Z0NNMjiNjuk0ik=;
 b=TWctF2RqJeytuUIWdUm889dMHBISjpHuYw5s0Xub3PHNXV3K/chWGKujtTlE816E5g
 nAYfYNr6vyk1pGDqIxSwY+frcsJelflqZesNB0cjpUDSCwAc33nzXZIf9XePDIKCXqzg
 89T1fKRU3A3J9vClaSySiq6T5cQq20Pz/bq/KG2rnvo+WpfyrEYuLVOFzM+rSbfuBJ/C
 qMgfIsc7ORztBKegBqqahk0QM3yn2Ouezzl7bGjjY0wXuYGPY3Q2PTq/Saer46kyAAty
 XVfi00IlAWjhOxvHXD8+DQtCB6JAVlm1b9jSNH434K+qOWrjTXVX09QlcgaoxVz4KnSj
 oj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408368; x=1780013168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=twKNIA8iq6mVfGklHL0d5uqCz0627Z0NNMjiNjuk0ik=;
 b=XFezJdy5EWVPSZPh7pHn7g9yVn/GlnK5dfTKMcekmn8KIudE4eG094CcqKXSQoEOL3
 pqnyqWx/p7EmsoOlr5v64cq5j0GavB5xEjEezwPlSGmWdI5kDvDz0XkWh8m3IE7XdVAH
 0nfvpahGZ3C3WY3P5oGjxoECFE+BFBm5fjgA+NA9DbHRXWRrpmuJ++XsO2Zu6PpvGPEX
 TZ3/HWop3tre43iA76dRhIG/bRsFXav5j6xChfZAE5nY5hym9eqKSNvhhV3PS486Cb31
 tTQ084lmtOuYBAEyjditHENoJUl+qE1yDjJf00sGyqArVMyrJExnjwFK+W3io1PjaZYW
 ufUA==
X-Gm-Message-State: AOJu0Ywqcyq+PgJAYpCFbSQ+37mvLoFKO0W5QDQvY/uhYSoEnfWtbIZf
 kAG7HDItJnt5v4Yx+h8EgcvlBAUaalOUivNxnA2zVcrpfYNMDiB1zf4G5W05iDaH
X-Gm-Gg: Acq92OF9EdtkrYzz+iT0z+7jEsstkPwq8Q2KoxAtR7bDadEJ2nvJnV1iZv6vxvympCL
 MM4dS9l4DVTB8ntRB7jJDbMe9XC3ht2fgXyvKzMQ0PoBfKjcLIwnZSYyCIVG7yGj34zqUgt6/EO
 FSTjdpDx8fO+DwCv1c4RDKwq2z3TGfBCxfUtLvG9TSjSWFnngl17wJeOJCvKIHlSkFQNL+TOXeE
 Kf7Os9mjz51uUKLor2ydcG1TcpkIg56OCfVwncHTW0ru2FKhIjp1thyNFAJ5qkydafezt6Jp4O8
 HB3et0PU3NtKtbHa+yeS5pegyFWpJw+nTqHaGZTPbd1VdRCDSHeDEQaLzFCthWW9e44aVSq4iJs
 b+lCW5crJZvI0EB6N3EJxyhV5uCJvP6ytFFpSLGqBe6uhgjdhJyGdaOu27wBc4sIbTuQm951wCk
 y07Qh7YMuuUP+NlG7FQej9aZXpxY69C7wvoiVRAVDE+A==
X-Received: by 2002:a17:903:19e6:b0:2bc:7d5d:e2b7 with SMTP id
 d9443c01a7336-2beb069cff3mr11937425ad.36.1779408368113; 
 Thu, 21 May 2026 17:06:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:06:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/48] hw/intc: riscv_aplic: add trace events of APLIC
 read/write function
Date: Fri, 22 May 2026 10:03:23 +1000
Message-ID: <20260522000324.23255-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
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

From: Jim Shu <jim.shu@sifive.com>

Add the trace events for APLIC read/write functions.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260428160103.3551125-5-jim.shu@sifive.com>
[ Changes by AF:
 - Init val to zero to avoid uninitialised build errors
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 63 ++++++++++++++++++++++++++-----------------
 hw/intc/trace-events  |  4 +++
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a04e0e1a89..c2c67c29e6 100644
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
+    uint64_t val = 0;
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
index c6696f0e0a..e7d6c30448 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -353,3 +353,7 @@ loongarch_msi_set_irq(int irq_num) "set msi irq %d"
 loongarch_extioi_setirq(int irq, int level) "set extirq irq %d level %d"
 loongarch_extioi_readw(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64 "val: 0x%" PRIx64
 loongarch_extioi_writew(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64 "val: 0x%" PRIx64
+
+# riscv_aplic.c
+riscv_aplic_read(uint64_t offset, unsigned size, uint64_t value) "offset: 0x%" PRIx64 ", size: %u, value: 0x%" PRIx64
+riscv_aplic_write(uint64_t offset, unsigned size, uint64_t value) "offset: 0x%" PRIx64 ", size: %u, value: 0x%" PRIx64
-- 
2.53.0


