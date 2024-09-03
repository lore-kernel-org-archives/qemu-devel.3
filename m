Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E2CCD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5P-0000Ue-B2; Tue, 03 Sep 2024 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5N-0000Lq-Mc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5L-0002u2-PQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42c7a384b18so26509445e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379730; x=1725984530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fmZw44UFxtNmu5XvjUhvfl85V31SothT2rfnjTZFuAs=;
 b=sTlZn3aw6pMOqOf//5jDyOls/ect+KjCVvTuttQ8lfzFQ4hkZ2f2o3p/aH0S0gIkGF
 +0mbkZQi1jGK2NeVN43KVcimuw0pReKjXxY/TVxejzwCvysF8ND0wnHHJr1s9Ag9ZF6f
 8DqfXi/uRxSpRkm7XufoplPqktfxU3G5p/RlGz0iPvCdYxd1yPePXbb5wq5WXDiKLqOg
 /deQTkAydElW5tJGb+rwBYnInwXhLhLKSKoChkpZ5lWL7GoGiZtErbd/NWa0vILIx+Kb
 8NBAkpvVlW3LU2C4Zt/thPfsh1FyZdzb7mDM6CRFocz+cMER5SX0aIWdq1I/NxvziLpl
 b89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379730; x=1725984530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmZw44UFxtNmu5XvjUhvfl85V31SothT2rfnjTZFuAs=;
 b=jXxtmW/16C6JjKlD5uU0px5noEdovtt70tqCIbGPvU3lHNoKLh0MrVJ5Uxz2a1Aqb2
 bJT8p0KjcB/9Lo+PN3xiQu1tciBWWuBFJF1ORmePDRHlcRwmC8NvsmLUZqsdGPDHDht6
 qQ2/4DrM+YiDFHHSQ4EU5koxM2I2SN1men7IIrhFFN81M9t4HCaPLOMNQ866Fp3hOKvn
 R1Xbmx5ur+0FIu3tzHyqyr4L6Z2cDOJTO5jywh7ekmFAHNCbnFDEW1ypcyVMvQEzy9vl
 PLVzm8t0zpF6v42B00dCseILqkh1bb1+54MBwetf+FKEOP7z7WONHmzP2u4DmbvnoK1p
 NQNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxxfdB167dyb4OyBztc109Wh3hYsMVtES/Wrgg2piP329D/AjyyM7sGLW0+3+pidBy/wHSjN6VCkEb@nongnu.org
X-Gm-Message-State: AOJu0Yz+rIgF4YmFFxM0LHqJp7P1aVXco5Kg6tMtMIGLVHzfnGECmSlh
 dhUaKe2r+QTtCJx4FH0nllv2UKuKa7RCiQFyvIEwpBm5LDnnkT86fvTFrIW9JKleM5O36UgQdsY
 M
X-Google-Smtp-Source: AGHT+IGvW5DHlTpOR59xDYnTIUmLizi9phfFG9JyL0qqIOlTUw8OgLBqCGcObJZLynZgsitWhYDv1Q==
X-Received: by 2002:a05:600c:1c89:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-42bd052b0f6mr84809015e9.0.1725379730219; 
 Tue, 03 Sep 2024 09:08:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 35/53] hw: Remove PCMCIA subsystem
Date: Tue,  3 Sep 2024 17:07:33 +0100
Message-Id: <20240903160751.4100218-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The only PCMCIA subsystem was the PXA2xx SoC and the machines
using it, which have now been removed. Although in theory
we have a few machine types which have PCMCIA (e.g. kzm,
the strongarm machines, sh4's sh7750), none of those machines
implement their PCMCIA controller, and they're all old and
no longer very interesting machine types.

Rather than keeping all the PCMCIA code in-tree without any
active users of it, delete it. If we need PCMCIA in future
we can always resurrect it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/pcmcia.h   | 63 -------------------------------------------
 hw/pcmcia/pcmcia.c    | 24 -----------------
 hw/Kconfig            |  1 -
 hw/meson.build        |  1 -
 hw/pcmcia/Kconfig     |  2 --
 hw/pcmcia/meson.build |  1 -
 6 files changed, 92 deletions(-)
 delete mode 100644 include/hw/pcmcia.h
 delete mode 100644 hw/pcmcia/pcmcia.c
 delete mode 100644 hw/pcmcia/Kconfig
 delete mode 100644 hw/pcmcia/meson.build

diff --git a/include/hw/pcmcia.h b/include/hw/pcmcia.h
deleted file mode 100644
index 6c08ad616a5..00000000000
--- a/include/hw/pcmcia.h
+++ /dev/null
@@ -1,63 +0,0 @@
-#ifndef HW_PCMCIA_H
-#define HW_PCMCIA_H
-
-/* PCMCIA/Cardbus */
-
-#include "hw/qdev-core.h"
-#include "qom/object.h"
-
-typedef struct PCMCIASocket {
-    qemu_irq irq;
-    bool attached;
-} PCMCIASocket;
-
-#define TYPE_PCMCIA_CARD "pcmcia-card"
-OBJECT_DECLARE_TYPE(PCMCIACardState, PCMCIACardClass, PCMCIA_CARD)
-
-struct PCMCIACardState {
-    /*< private >*/
-    DeviceState parent_obj;
-    /*< public >*/
-
-    PCMCIASocket *slot;
-};
-
-struct PCMCIACardClass {
-    /*< private >*/
-    DeviceClass parent_class;
-    /*< public >*/
-
-    int (*attach)(PCMCIACardState *state);
-    int (*detach)(PCMCIACardState *state);
-
-    const uint8_t *cis;
-    int cis_len;
-
-    /* Only valid if attached */
-    uint8_t (*attr_read)(PCMCIACardState *card, uint32_t address);
-    void (*attr_write)(PCMCIACardState *card, uint32_t address, uint8_t value);
-    uint16_t (*common_read)(PCMCIACardState *card, uint32_t address);
-    void (*common_write)(PCMCIACardState *card,
-                         uint32_t address, uint16_t value);
-    uint16_t (*io_read)(PCMCIACardState *card, uint32_t address);
-    void (*io_write)(PCMCIACardState *card, uint32_t address, uint16_t value);
-};
-
-#define CISTPL_DEVICE         0x01  /* 5V Device Information Tuple */
-#define CISTPL_NO_LINK        0x14  /* No Link Tuple */
-#define CISTPL_VERS_1         0x15  /* Level 1 Version Tuple */
-#define CISTPL_JEDEC_C        0x18  /* JEDEC ID Tuple */
-#define CISTPL_JEDEC_A        0x19  /* JEDEC ID Tuple */
-#define CISTPL_CONFIG         0x1a  /* Configuration Tuple */
-#define CISTPL_CFTABLE_ENTRY  0x1b  /* 16-bit PCCard Configuration */
-#define CISTPL_DEVICE_OC      0x1c  /* Additional Device Information */
-#define CISTPL_DEVICE_OA      0x1d  /* Additional Device Information */
-#define CISTPL_DEVICE_GEO     0x1e  /* Additional Device Information */
-#define CISTPL_DEVICE_GEO_A   0x1f  /* Additional Device Information */
-#define CISTPL_MANFID         0x20  /* Manufacture ID Tuple */
-#define CISTPL_FUNCID         0x21  /* Function ID Tuple */
-#define CISTPL_FUNCE          0x22  /* Function Extension Tuple */
-#define CISTPL_END            0xff  /* Tuple End */
-#define CISTPL_ENDMARK        0xff
-
-#endif
diff --git a/hw/pcmcia/pcmcia.c b/hw/pcmcia/pcmcia.c
deleted file mode 100644
index 03d13e7d670..00000000000
--- a/hw/pcmcia/pcmcia.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * PCMCIA emulation
- *
- * Copyright 2013 SUSE LINUX Products GmbH
- */
-
-#include "qemu/osdep.h"
-#include "qemu/module.h"
-#include "hw/pcmcia.h"
-
-static const TypeInfo pcmcia_card_type_info = {
-    .name = TYPE_PCMCIA_CARD,
-    .parent = TYPE_DEVICE,
-    .instance_size = sizeof(PCMCIACardState),
-    .abstract = true,
-    .class_size = sizeof(PCMCIACardClass),
-};
-
-static void pcmcia_register_types(void)
-{
-    type_register_static(&pcmcia_card_type_info);
-}
-
-type_init(pcmcia_register_types)
diff --git a/hw/Kconfig b/hw/Kconfig
index f7866e76f73..72aea9b8b73 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -27,7 +27,6 @@ source nvme/Kconfig
 source nvram/Kconfig
 source pci-bridge/Kconfig
 source pci-host/Kconfig
-source pcmcia/Kconfig
 source pci/Kconfig
 source remote/Kconfig
 source rtc/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index 1c6308fe957..b871cdca75c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -27,7 +27,6 @@ subdir('nvram')
 subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
-subdir('pcmcia')
 subdir('rtc')
 subdir('scsi')
 subdir('sd')
diff --git a/hw/pcmcia/Kconfig b/hw/pcmcia/Kconfig
deleted file mode 100644
index 41f2df91366..00000000000
--- a/hw/pcmcia/Kconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-config PCMCIA
-    bool
diff --git a/hw/pcmcia/meson.build b/hw/pcmcia/meson.build
deleted file mode 100644
index edcb7f5d263..00000000000
--- a/hw/pcmcia/meson.build
+++ /dev/null
@@ -1 +0,0 @@
-system_ss.add(when: 'CONFIG_PCMCIA', if_true: files('pcmcia.c'))
-- 
2.34.1


