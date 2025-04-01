Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9C2C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 12:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbC0-0001sQ-4K; Tue, 01 Apr 2025 08:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1tzXSr-0002I6-15; Tue, 01 Apr 2025 04:59:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1tzXSn-0003xS-OX; Tue, 01 Apr 2025 04:59:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227a8cdd241so14992025ad.3; 
 Tue, 01 Apr 2025 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743497955; x=1744102755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yr/ylujgk47Z0kyANssU9cf1XdMKa/cPxXGrPAQPkiE=;
 b=S9+goyJdU+d2enQu2LdRx3z/cPBxHdm0fJNacJV511wVG66Z0MgQHVt6edLBI9C9Gn
 wL1u85rHaCR0alJbQ/l5F3dagg1zBosaBwBAoIMvZ6a4WeeSDsqGZZ7RXy1zRvdJB/GN
 tMir+v9ZU4J6se83whYgFngmSGVSEErMgGksl09sIMOYCZtYGtmi2NKu+1dpwVevh8eC
 VuCU7VmLnmx+8m3w9yxEeRMJKwW5wIVrxcAYBZT3g0f6pt2c4eUeObxYwUaIn3HKeB4P
 gWAJQ5M1X3rvzD6m3s1CnkjKeMUt4AUUeKJer+O/o4hovyD9Ta7BoA/4G5uFyDPJlgtO
 oBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743497955; x=1744102755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yr/ylujgk47Z0kyANssU9cf1XdMKa/cPxXGrPAQPkiE=;
 b=lO+HwVO3AgaLbRNSYGsDlVNDO5cFIlhnHF90usO0iayIVJQzXaXpiqy5rWuQP2TBF3
 VinepveZVnhuEFKWxysOnzIsXVMK8rPvKK7Czk0veyIWYX2ccNxQCqDxk6lPB7hremLt
 v6dk3NDUgtAgFIgmfrNqhCe4f1RTnQUfcjJ7dm/UxoXkDN2wlSnTRWCKAN5i5i5FH4Gb
 J2lt6o9ec1VPtdYs2WJbV7qQEYtMrgXGqmZ4uTy0y8Hihtf3Ki4MSTgEPmn5MzxkpWd+
 iqXohINGO1Ov6XjO/4Md4htiKcuZaGA0MoNQ8YLYpy0G+MEJhzw4M8QY9xx2yWnN7/f8
 mu9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmX97os0sB1FIptIxDRgCY0mDJZEZJsMO4RXB9tYhQE5whCVqBMFG2DRaze5U35wTsk5gkEq9YZHwu@nongnu.org
X-Gm-Message-State: AOJu0Yz34h/sBLD5PBtHXGXd5XDa0+Lk1F2jGsQtLxDbQTZya77aryQL
 PP+BngsUhtTaY7QZppC2n3EW2sEC1yqKUSyPS1HrLgNgBuEeVDwQRwjdSo0ysXM=
X-Gm-Gg: ASbGnctu899DBCteJiRrDjJ3dSJrESKc3CEWGsx0U1kDgcZv7tXO7jc4yjSbpP3crhA
 5ds14RgG1MdVf+6Wmy2FVYjeuht8S4m9b7RXBIXdNvV9nnyLzJmh//4JRc6ZMFZwqHxPlGJm9O5
 OmYeLg8ZhGUojrlOHIKxrGRtgyL1WbUgqhEoSLK7ONGnbLbqtE7mzhSsN92hC7SIj4L1w0yGshT
 be8mgKC2i8Te26hrVrlCj9azAgB0jX/Jf8fyAyyZaeDDer4fxczXUbbTBrbcbASmtX3c8Uo8wjW
 UI4n0sqRhEtLaWGDY3y1JuwfrhRp/il/Zk/JBhd5rkLr6baUYPIxmNI1Q+wdq2L0ZWV5Q4gY/yI
 TFpwgb4H2Cn5b
X-Google-Smtp-Source: AGHT+IGUhExkUTCVJ1CxkibHZ2pfpyh4lOr5lXvACkDyV0O3dmf8pWpvHhsEfas9u6ZkbFR6D/y9lw==
X-Received: by 2002:a17:902:cec8:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-2292f9f0afcmr209785925ad.40.1743497955213; 
 Tue, 01 Apr 2025 01:59:15 -0700 (PDT)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1dee68sm83047055ad.205.2025.04.01.01.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 01:59:14 -0700 (PDT)
From: Tim Lee <timlee660101@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com,
 chli30@nuvoton.com, kfting@nuvoton.com, Tim Lee <timlee660101@gmail.com>
Subject: [PATCH] hw/arm/npcm8xx_boards: Add auto zero flash image and device
 part number
Date: Tue,  1 Apr 2025 16:59:03 +0800
Message-Id: <20250401085903.224787-1-timlee660101@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=timlee660101@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 01 Apr 2025 08:58:09 -0400
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

Fix flash device part number to `mx66l1g45g` according image-bmc run on npcm8xx
evb board (SPIFlash...SF: Detected mx66l1g45g, total 128 MiB)

And add auto zero flash image size to resolve error below after executing
`./qemu-system-aarch64 -machine npcm845-evb -drive file=image-bmc`

Error message:
qemu-system-aarch64: mx66l1g45g device '/machine/unattached/device[73]'
requires 134217728 bytes, mtd0 block backend provides 67108864 bytes

Tested:
Build passes and runs ./qemu-system-aarch64 -machine npcm845-evb normally

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
 hw/arm/npcm8xx_boards.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 3fb8478e72..11b792c613 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "system/block-backend.h"
 
 #define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff
 
@@ -59,10 +60,21 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
 {
     DeviceState *flash;
     qemu_irq flash_cs;
+    BlockBackend *blk;
+    uint64_t blk_size, perm, shared_perm;
 
     flash = qdev_new(flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+        blk = blk_by_legacy_dinfo(dinfo);
+        blk_size = blk_getlength(blk);
+        if (blk_size < fiu->flash_size) {
+            blk_get_perm(blk, &perm, &shared_perm);
+            blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_abort);
+            blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE_OFF,
+                         BDRV_REQ_ZERO_WRITE, &error_abort);
+            blk_set_perm(blk, perm, shared_perm, &error_abort);
+        }
     }
     qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
 
@@ -194,7 +206,8 @@ static void npcm845_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm8xx_load_bootrom(machine, soc);
-    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
+    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
+                          drive_get(IF_MTD, 0, 0));
     npcm845_evb_i2c_init(soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
     npcm8xx_load_kernel(machine, soc);
-- 
2.34.1


