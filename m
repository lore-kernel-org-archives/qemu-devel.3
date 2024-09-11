Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFA9EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMGB-0007ml-PA; Wed, 11 Sep 2024 08:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFa-0006CL-BN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:12 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFX-0007Bv-Vr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:09 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so677706366b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056905; x=1726661705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLvbZKUD4kZ8okDx/zMPvNVTVHxXSANES/l3IRefTcE=;
 b=y2qLZM3EIhcC2/G3vRZfpvVY71AXaQWP3ZkBzyo0UrBAPkcH7QC1q+A9mDGKUssvyx
 SL3LX/5FnCYl2+c122ycduY8ZznVkPBygOIzEapn8LfH8y64neK1+IUaaqhaBMDLfKya
 VU2lgQFT6aSqhUHkILymVA2/ils0UVTFghWBgrCilbAM8c7GpM6m6XT3wckNs/Jz5k7S
 bFg2VEb/lJGxB+ZEblmypaQNNUfLT20O2WK5KenV+VutMPCW9Eqq46IMa2YANWGYC9Sj
 IVHyhiltlY4XEFxO5GmJNPrb3Ppc1UktAHUBHLnSH1PM/GwSU+UaiSANgEjJISeLRJ8g
 K1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056905; x=1726661705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLvbZKUD4kZ8okDx/zMPvNVTVHxXSANES/l3IRefTcE=;
 b=DFNTZszItmFRwnYnDr559JvW1U1TnQ6NEkcbuQGn/zIfovqvjhcBk2K7R5IYMhuk4U
 YKpcER3yFrVmSzSf2AzFx6EkRS4JjncldlQvLR15T/OhB4KFvCYJX4H2tiYuyLSx+91L
 EzY1f1l/oBlGS4EpZyGFu+3GEpGBifCbSwJAsGznxdVlbkIJZJmgCW2IUhLC343JNUm6
 wuNWFUWYaWyjH4wFk9F3nothEeXVjXlJSasXC2wAE/uN996aJC41vuGn2k76NpXIQfPc
 sc+xZaYAe0F++A4qNN4jsX2hTEYpTdD1PRXLQp5Cx0wfR/0vXQ2CZ0AArHuEHoREIb/y
 WQJg==
X-Gm-Message-State: AOJu0YwHj3Rl2dqHsYR2HqQeP3abP2P7uJXqinIJd5QyJntJaJ34Vq7M
 ZzPHudbMkEObUSXEV2VnllvaCphA2fTDw+Miwp8dIjqSYykykJJYFZAhJcsWpamPvDMaRwBw6G9
 r
X-Google-Smtp-Source: AGHT+IF2Q5CuHHBXJukvBm2j1TyGifhmEe3Rk6jBgnBEDsC0zZJ4/pMjoTuTR5SvYpr8EkYyFixPvg==
X-Received: by 2002:a17:907:961f:b0:a8d:2faf:d333 with SMTP id
 a640c23a62f3a-a8ffab83475mr394432266b.35.1726056905184; 
 Wed, 11 Sep 2024 05:15:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cf4a1fsm602958066b.181.2024.09.11.05.15.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:15:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PULL 06/56] hw/sh4: Remove sh7750_register_io_device() helper
Date: Wed, 11 Sep 2024 14:13:31 +0200
Message-ID: <20240911121422.52585-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

sh7750_register_io_device() was only used by the TC58128
NAND EEPROM which has been removed in the previous commit.
Remove it as unused code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20240903153959.18392-4-philmd@linaro.org>
---
 include/hw/sh4/sh.h | 16 -------------
 hw/sh4/sh7750.c     | 57 ++-------------------------------------------
 2 files changed, 2 insertions(+), 71 deletions(-)

diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index b726b987cc..c82feef8d0 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -38,22 +38,6 @@ struct SH7750State;
 
 struct SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem);
 
-typedef struct {
-    /* The callback will be triggered if any of the designated lines change */
-    uint16_t portamask_trigger;
-    uint16_t portbmask_trigger;
-    /* Return 0 if no action was taken */
-    int (*port_change_cb) (uint16_t porta, uint16_t portb,
-                           uint16_t *periph_pdtra,
-                           uint16_t *periph_portdira,
-                           uint16_t *periph_pdtrb,
-                           uint16_t *periph_portdirb);
-} sh7750_io_device;
-
-int sh7750_register_io_device(struct SH7750State *s,
-                              sh7750_io_device *device);
-
-/* sh_serial.c */
 #define TYPE_SH_SERIAL "sh-serial"
 #define SH_SERIAL_FEAT_SCIF (1 << 0)
 
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index ebe0fd96d9..8041b3b651 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -38,8 +38,6 @@
 #include "exec/exec-all.h"
 #include "trace.h"
 
-#define NB_DEVICES 4
-
 typedef struct SH7750State {
     MemoryRegion iomem;
     MemoryRegion iomem_1f0;
@@ -75,7 +73,6 @@ typedef struct SH7750State {
     uint16_t periph_portdira; /* Direction seen from the peripherals */
     uint16_t periph_pdtrb;    /* Imposed by the peripherals */
     uint16_t periph_portdirb; /* Direction seen from the peripherals */
-    sh7750_io_device *devices[NB_DEVICES]; /* External peripherals */
 
     /* Cache */
     uint32_t ccr;
@@ -92,19 +89,6 @@ static inline int has_bcr3_and_bcr4(SH7750State *s)
  * I/O ports
  */
 
-int sh7750_register_io_device(SH7750State *s, sh7750_io_device *device)
-{
-    int i;
-
-    for (i = 0; i < NB_DEVICES; i++) {
-        if (s->devices[i] == NULL) {
-            s->devices[i] = device;
-            return 0;
-        }
-    }
-    return -1;
-}
-
 static uint16_t portdir(uint32_t v)
 {
 #define EVENPORTMASK(n) ((v & (1 << ((n) << 1))) >> (n))
@@ -142,63 +126,26 @@ static uint16_t portb_lines(SH7750State *s)
         (~(s->portdirb | s->periph_portdirb) & s->portpullupb); /* Pullups */
 }
 
-static void gen_port_interrupts(SH7750State *s)
-{
-    /* XXXXX interrupts not generated */
-}
-
 static void porta_changed(SH7750State *s, uint16_t prev)
 {
-    uint16_t currenta, changes;
-    int i, r = 0;
+    uint16_t currenta;
 
     currenta = porta_lines(s);
     if (currenta == prev) {
         return;
     }
     trace_sh7750_porta(prev, currenta, s->pdtra, s->pctra);
-    changes = currenta ^ prev;
-
-    for (i = 0; i < NB_DEVICES; i++) {
-        if (s->devices[i] && (s->devices[i]->portamask_trigger & changes)) {
-            r |= s->devices[i]->port_change_cb(currenta, portb_lines(s),
-                                               &s->periph_pdtra,
-                                               &s->periph_portdira,
-                                               &s->periph_pdtrb,
-                                               &s->periph_portdirb);
-        }
-    }
-
-    if (r) {
-        gen_port_interrupts(s);
-    }
 }
 
 static void portb_changed(SH7750State *s, uint16_t prev)
 {
-    uint16_t currentb, changes;
-    int i, r = 0;
+    uint16_t currentb;
 
     currentb = portb_lines(s);
     if (currentb == prev) {
         return;
     }
     trace_sh7750_portb(prev, currentb, s->pdtrb, s->pctrb);
-    changes = currentb ^ prev;
-
-    for (i = 0; i < NB_DEVICES; i++) {
-        if (s->devices[i] && (s->devices[i]->portbmask_trigger & changes)) {
-            r |= s->devices[i]->port_change_cb(portb_lines(s), currentb,
-                                               &s->periph_pdtra,
-                                               &s->periph_portdira,
-                                               &s->periph_pdtrb,
-                                               &s->periph_portdirb);
-        }
-    }
-
-    if (r) {
-        gen_port_interrupts(s);
-    }
 }
 
 /*
-- 
2.45.2


