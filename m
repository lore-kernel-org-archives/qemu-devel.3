Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ADBCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5b-0001Zn-V3; Tue, 03 Sep 2024 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5Z-0001QU-Tx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5W-0002yM-Eo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8abeso44423155e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379741; x=1725984541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=slM94TULEewYKeVq6sh2hQIHzbNpZcOVLQjaenOMVd4=;
 b=nvAt0IyBHNVh0Z+Y8z46IQSp0kHC5eh8yNE68f/sLeL1nJAg2L13hteRB4Yy3UdZUd
 YUiW8Md3IAHb2cIlZC7pdA79OdQakme/xFORRKjxgfmwGBKFdba5C+NNgD3mdpi4EeO+
 EBWJv3ahplbNBcqK/IKgzeW1CwHMtnsNVvRTnBWar3HhDh6f1sILTIDDf2gkbst9BWYc
 SLHrMPVx7VK0UZukOFEPNIf2/F/wdznT0BZomALjPZS+nzxJhGJ6c+vBTeTHLE6r0XHc
 qzA7rP2TInxoX6Qbva35DnUShA3hg/avgj7irobqXAsUYg4sANqY2a0UGHSWjPZ+R09z
 laAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379741; x=1725984541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slM94TULEewYKeVq6sh2hQIHzbNpZcOVLQjaenOMVd4=;
 b=KikrXdxoVynYhcWqjEeefI1jtAkjsn7ae3f94kR12uRUDMQj70oF1pS792oBdxhrvN
 HbGGlrecah08PfRHNoFmOjnspxdIYoaLvQQgb/ajccgijX/m3zY6fucOS5rYn6qizcd0
 E/jXoFWXI8QU/fIashPR0vzm8L2cnSHqmGx0cJiR35TyKwXOCMAnKvvM7LlXq4P4DB0E
 Utm/ouilpn8GTCafxvzuEjTH1MeO5Zk5vPoggJcsd9/vXlelufYnqitLL8oA8TMNLTpg
 3abDeKTdtHXUzUR4AFqKXkmNLZ8hIAJODUXTZ4bg8EOh/Mw3uvEZEyOTtOidiL/RYidh
 RQYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH7dZZ4zILboffbb2t1HP0SiJwxrOes0u+2RqhBfrbisY1IZGk9v1a75OPtwQi8JIF35kLg4n9jf2w@nongnu.org
X-Gm-Message-State: AOJu0Yygsr1qmlMr4igkXc9+eIYFzBFuWIWXOYYMjyxFT7rIdT4V44rB
 yKbZdJrbXCIp4HI9UVS7xNuPdmKZEFV7v7z6uWNxWp9f78dTCgdgJvTD94cMsCpBEY1HNYRWGtk
 P
X-Google-Smtp-Source: AGHT+IGuphinHyFAAa2c3Qe9qbJW4GfPgA+UFsVSNWItLDdUagVSOiOPUmrrEMO2QfKSZJTY1H7Qzg==
X-Received: by 2002:a05:600c:3b85:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-42c8dea66b1mr10526295e9.32.1725379740805; 
 Tue, 03 Sep 2024 09:09:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:09:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 46/53] hw/block: Remove ecc
Date: Tue,  3 Sep 2024 17:07:44 +0100
Message-Id: <20240903160751.4100218-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The ecc.c code was used only by the PXA2xx and OMAP2 SoC devices,
which we have removed, so it is now completely unused.

Note that hw/misc/eccmemctl.c does not in fact use any of the
code frome ecc.c, so that KConfig dependency was incorrect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/block/flash.h | 11 -----
 hw/block/ecc.c           | 91 ----------------------------------------
 hw/arm/Kconfig           |  1 -
 hw/block/Kconfig         |  3 --
 hw/block/meson.build     |  1 -
 hw/misc/Kconfig          |  1 -
 6 files changed, 108 deletions(-)
 delete mode 100644 hw/block/ecc.c

diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index b985c825a01..5fd67f5bb79 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -62,17 +62,6 @@ uint32_t nand_getbuswidth(DeviceState *dev);
 #define NAND_MFR_HYNIX      0xad
 #define NAND_MFR_MICRON     0x2c
 
-/* ecc.c */
-typedef struct {
-    uint8_t cp;     /* Column parity */
-    uint16_t lp[2]; /* Line parity */
-    uint16_t count;
-} ECCState;
-
-uint8_t ecc_digest(ECCState *s, uint8_t sample);
-void ecc_reset(ECCState *s);
-extern const VMStateDescription vmstate_ecc_state;
-
 /* m25p80.c */
 
 #define TYPE_M25P80 "m25p80-generic"
diff --git a/hw/block/ecc.c b/hw/block/ecc.c
deleted file mode 100644
index ed889a4184f..00000000000
--- a/hw/block/ecc.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Calculate Error-correcting Codes. Used by NAND Flash controllers
- * (not by NAND chips).
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "migration/vmstate.h"
-#include "hw/block/flash.h"
-
-/*
- * Pre-calculated 256-way 1 byte column parity.  Table borrowed from Linux.
- */
-static const uint8_t nand_ecc_precalc_table[] = {
-    0x00, 0x55, 0x56, 0x03, 0x59, 0x0c, 0x0f, 0x5a,
-    0x5a, 0x0f, 0x0c, 0x59, 0x03, 0x56, 0x55, 0x00,
-    0x65, 0x30, 0x33, 0x66, 0x3c, 0x69, 0x6a, 0x3f,
-    0x3f, 0x6a, 0x69, 0x3c, 0x66, 0x33, 0x30, 0x65,
-    0x66, 0x33, 0x30, 0x65, 0x3f, 0x6a, 0x69, 0x3c,
-    0x3c, 0x69, 0x6a, 0x3f, 0x65, 0x30, 0x33, 0x66,
-    0x03, 0x56, 0x55, 0x00, 0x5a, 0x0f, 0x0c, 0x59,
-    0x59, 0x0c, 0x0f, 0x5a, 0x00, 0x55, 0x56, 0x03,
-    0x69, 0x3c, 0x3f, 0x6a, 0x30, 0x65, 0x66, 0x33,
-    0x33, 0x66, 0x65, 0x30, 0x6a, 0x3f, 0x3c, 0x69,
-    0x0c, 0x59, 0x5a, 0x0f, 0x55, 0x00, 0x03, 0x56,
-    0x56, 0x03, 0x00, 0x55, 0x0f, 0x5a, 0x59, 0x0c,
-    0x0f, 0x5a, 0x59, 0x0c, 0x56, 0x03, 0x00, 0x55,
-    0x55, 0x00, 0x03, 0x56, 0x0c, 0x59, 0x5a, 0x0f,
-    0x6a, 0x3f, 0x3c, 0x69, 0x33, 0x66, 0x65, 0x30,
-    0x30, 0x65, 0x66, 0x33, 0x69, 0x3c, 0x3f, 0x6a,
-    0x6a, 0x3f, 0x3c, 0x69, 0x33, 0x66, 0x65, 0x30,
-    0x30, 0x65, 0x66, 0x33, 0x69, 0x3c, 0x3f, 0x6a,
-    0x0f, 0x5a, 0x59, 0x0c, 0x56, 0x03, 0x00, 0x55,
-    0x55, 0x00, 0x03, 0x56, 0x0c, 0x59, 0x5a, 0x0f,
-    0x0c, 0x59, 0x5a, 0x0f, 0x55, 0x00, 0x03, 0x56,
-    0x56, 0x03, 0x00, 0x55, 0x0f, 0x5a, 0x59, 0x0c,
-    0x69, 0x3c, 0x3f, 0x6a, 0x30, 0x65, 0x66, 0x33,
-    0x33, 0x66, 0x65, 0x30, 0x6a, 0x3f, 0x3c, 0x69,
-    0x03, 0x56, 0x55, 0x00, 0x5a, 0x0f, 0x0c, 0x59,
-    0x59, 0x0c, 0x0f, 0x5a, 0x00, 0x55, 0x56, 0x03,
-    0x66, 0x33, 0x30, 0x65, 0x3f, 0x6a, 0x69, 0x3c,
-    0x3c, 0x69, 0x6a, 0x3f, 0x65, 0x30, 0x33, 0x66,
-    0x65, 0x30, 0x33, 0x66, 0x3c, 0x69, 0x6a, 0x3f,
-    0x3f, 0x6a, 0x69, 0x3c, 0x66, 0x33, 0x30, 0x65,
-    0x00, 0x55, 0x56, 0x03, 0x59, 0x0c, 0x0f, 0x5a,
-    0x5a, 0x0f, 0x0c, 0x59, 0x03, 0x56, 0x55, 0x00,
-};
-
-/* Update ECC parity count.  */
-uint8_t ecc_digest(ECCState *s, uint8_t sample)
-{
-    uint8_t idx = nand_ecc_precalc_table[sample];
-
-    s->cp ^= idx & 0x3f;
-    if (idx & 0x40) {
-        s->lp[0] ^= ~s->count;
-        s->lp[1] ^= s->count;
-    }
-    s->count ++;
-
-    return sample;
-}
-
-/* Reinitialise the counters.  */
-void ecc_reset(ECCState *s)
-{
-    s->lp[0] = 0x0000;
-    s->lp[1] = 0x0000;
-    s->cp = 0x00;
-    s->count = 0;
-}
-
-/* Save/restore */
-const VMStateDescription vmstate_ecc_state = {
-    .name = "ecc-state",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(cp, ECCState),
-        VMSTATE_UINT16_ARRAY(lp, ECCState, 2),
-        VMSTATE_UINT16(count, ECCState),
-        VMSTATE_END_OF_LIST(),
-    },
-};
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a70ceff504b..7b19a9559f6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -146,7 +146,6 @@ config OMAP
     bool
     select FRAMEBUFFER
     select I2C
-    select ECC
     select NAND
     select PFLASH_CFI01
     select SD
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 002d255dced..741390742c2 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -22,9 +22,6 @@ config PFLASH_CFI01
 config PFLASH_CFI02
     bool
 
-config ECC
-    bool
-
 config TC58128
     bool
 
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 74c8eb9e735..3735065631a 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -3,7 +3,6 @@ system_ss.add(files(
   'cdrom.c',
   'hd-geometry.c'
 ))
-system_ss.add(when: 'CONFIG_ECC', if_true: files('ecc.c'))
 system_ss.add(when: 'CONFIG_FDC', if_true: files('fdc.c'))
 system_ss.add(when: 'CONFIG_FDC_ISA', if_true: files('fdc-isa.c'))
 system_ss.add(when: 'CONFIG_FDC_SYSBUS', if_true: files('fdc-sysbus.c'))
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b832..8568aaa2293 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -74,7 +74,6 @@ config IVSHMEM_DEVICE
 
 config ECCMEMCTL
     bool
-    select ECC
 
 config IMX
     bool
-- 
2.34.1


