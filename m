Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFCECD3443
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slVdu-0003S5-6J; Tue, 03 Sep 2024 11:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVdr-0003Gc-BE
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVdo-0006XK-1l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bbffe38e6so30346505e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725378015; x=1725982815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wuy63rQA82RKd97+v08/nlvdm3U3xnXpwkNWTWLl3/8=;
 b=W8riVIH2+D6aApWw0pmko5Ev0vIOuyOyuRwJw0V1+kMJDCaNJ+c1mwpqgHuFWdd8qk
 TyOl144wn8zfsJ3Q8FEIHToNM25R3IZ9n2B5R02gChysYT6MWNrXAd6M6b2ZJWbLVvnS
 AulIMLhZ1jhWer1zqxHWhTN9RPKVbsxdSpDn25F7ZrAMb+227knwy75athhsomqfqUFV
 8Ee49/2oBjd2qCC0aR+J17Kxbp5dwcuAQlHXwbpXZB3zxgM16IHQIxDWPipM83Vm/Dbs
 KIIvheTUgziyMfpen3wLK5lj4LoZodLysQbzpkRU1K+EPbrKidxT7d3AYg9qxT26VRgP
 0x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725378015; x=1725982815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wuy63rQA82RKd97+v08/nlvdm3U3xnXpwkNWTWLl3/8=;
 b=eLMQRBB1TKFxvGVzM8/yChEpa7nuIdSZFG972m5OnfBpxtO+7TLjs/oR+wTAICYSY+
 ULW4KxOZswhDDqjunLGI6MXpM6jukCR+XcajgH19z+MegawYNEhgSDe7oRn11gFS6VfW
 IVZvl5IN0vz+pm8ulEFLElc0dqEEXkEpNsePiBDKwX/q2BPdwD5bOS1Zk/mkTlbSKekc
 +DtcBIWzD0Ij7jQsB6FlTijH7LgNGiTdP0qtd5bz0AsY3ETRbJRJwZVXcM8CuQ0FivGH
 uQh+NzHw+zesdvd7mJm+u8E90I1r/ZjCdQZsFSqWaAzL59/50DqtyNGctpVSacILSmSr
 bjBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW39KntmLKKhqdc5nDqHrABWcTMUViwpoArVyUKQnqYJriDASZx8KdgsVE4VZnU1o3zSLr9AXmoYFyJ@nongnu.org
X-Gm-Message-State: AOJu0YwEMaM15+27p0x5hjksHR+H0lxuO0Bzs9oFlB/3/palxCMsYQ24
 TXkihWeVuNg93KTSSFgJPeng2ZISVMUvUK+FXLpOacLj+shxzcEQXuhXrPrJs4s=
X-Google-Smtp-Source: AGHT+IGyevKnzVu803RSdMfgNKlamGBAX7wFk9WO2mvIAhDDOSHpMM8FUWiSsUaxuwijRnfk+WlUpA==
X-Received: by 2002:adf:e5d2:0:b0:374:baf1:41bb with SMTP id
 ffacd0b85a97d-374baf14276mr6864469f8f.3.1725378015148; 
 Tue, 03 Sep 2024 08:40:15 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c90c6c06sm6793002f8f.84.2024.09.03.08.40.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 08:40:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Samuel Tardieu <sam@rfc1149.net>,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Magnus Damm <magnus.damm@gmail.com>,
 qemu-block@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/sh4: Remove sh7750_register_io_device() helper
Date: Tue,  3 Sep 2024 17:39:59 +0200
Message-ID: <20240903153959.18392-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903153959.18392-1-philmd@linaro.org>
References: <20240903153959.18392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


