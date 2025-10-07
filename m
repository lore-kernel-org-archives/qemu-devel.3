Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF0BCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qv-00061u-RI; Tue, 07 Oct 2025 10:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qp-0005xt-PF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QW-0002NE-RO
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so70065795e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846343; x=1760451143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=obeXY0oM+RvnNeVW9ans/XMLJrizgVMLKOkNMjRO3Fc=;
 b=ZnHY0yxkXPnvh9kkpMoP1v9Elrd2HzJ0e7X2SBCgEDRJfPfBAfu/aEleCfxhCq4/4U
 27oxQalYtHTooGcrdD3cEgm1QGxfoejX/xGw3NnWgtDSUZKgITGuFFuQJIkzFp8px2qi
 GwfzriEdRASMILMoGWb3c3+zY1hkUDDAIPgs0PDsk/TlfMg5OxnNTY9DLdrKkklusHiV
 tCIozHheS5w/FFpwX+apenyPMwEIG6pv6KLAvfEFawNVXYoTUYUI8GxmXzUfzDQuuSG/
 Py0K4T+KxUZhvuC9L41JFr9AhnlgpPfB7L42CsHiVcMwdZACCC3QhTVaNDcpjS9Z8F7c
 J5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846343; x=1760451143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obeXY0oM+RvnNeVW9ans/XMLJrizgVMLKOkNMjRO3Fc=;
 b=A5MFuobNdyiFkdAr2mLJumq1v5CbPqWF4WiJ+c9POi9JzSNJSfJodQYd+UNFVShjRE
 pwZfj0RTSXYs6CiAOhY5SDI2UAOZcHOu4drzEOHazjpm3/J/93gTyDcRiT/C+tr7p560
 9L5S0IivJ4H3HT5d767QB5kN1GRl/blLeo8QBGLqS3LV/xXA3WdMuq9/RuOJVtWux54Q
 tMckETdf3dWSK7EvhQKGd3dXJEYmI7Ph2DEnPSp+o9+RbgVY45r5x0hDiR7fnsYubaz+
 0UBbgSiQpwgd0yQdMXAnqjnnigbIS9oiVpua2+8bAzSgG6Ssat4CBMp60B+xJI/aQdx/
 vBkg==
X-Gm-Message-State: AOJu0Yxl7aJNmZv2RLThyR5c//ycTa4dBH+ycuBe9C6hMgC7mxD/B8HW
 KTz+vKMaF9BzXh77SQsfHN6HDDkbdinUcqkFMsNkfTaiacocq6E0gZpc8LJmuKoXJy5dqvwWucK
 m1zfR
X-Gm-Gg: ASbGncsGYumHPunkeO2IKf7PUPF8x68uPxF5/o5arcURwJx4FYwtijF20WFXBPRQOnZ
 dx0UnNezctgZkuLpRG+MlXRVseAtCpogWcwuIw7E+pihCvI9mHEi/prg8uuqi1k1pS5X80g/sIz
 krf6QDNcFgeeWiuqixPKJmzO1Dw/eWKU6PCdchtygPj8BJVbBH/Ih2Yhs6UF5MBN8Y66eu755rT
 phpPhaMybNqKKvJRQGLRqrd5KdxgmlZqQcFcSsSIjK8FiHNpUTd0BmwDAbSEkHqQJB+4zEUYwXb
 ANiOwAdBR09WYG5f/msJhGt2RkyYkm2wIOOSi4YgBxA45sUGCeJeVORtmBKkyj2Cs+QJdfQbeRD
 KKSi/ZewnAIev9+EL8yz0kbRzdle4pY91FR7rcjwdefOiWAkjeB2vduK7
X-Google-Smtp-Source: AGHT+IHHifXGLw1BxiL/KLjFRt5E33iKZ0810MCJ8pQdSpSJYjzwqLjfwm8aVtejEUQ6PbVDO+wHuQ==
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e7110c3d5mr144127995e9.16.1759846342747; 
 Tue, 07 Oct 2025 07:12:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/62] hw/arm: Remove sl_bootparam_write() and
 'hw/arm/sharpsl.h' header
Date: Tue,  7 Oct 2025 15:11:12 +0100
Message-ID: <20251007141123.3239867-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When removing the spitz and tosa board, commit b62151489ae
("hw/arm: Remove deprecated akita, borzoi spitz, terrier,
tosa boards") removed the last calls to sl_bootparam_write().
Remove it, along with the "hw/arm/sharpsl.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251001084047.67423-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS              |  1 -
 include/hw/arm/sharpsl.h | 17 ----------------
 hw/gpio/zaurus.c         | 42 ----------------------------------------
 3 files changed, 60 deletions(-)
 delete mode 100644 include/hw/arm/sharpsl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 75e1fa5c307..bb7fa76c324 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1006,7 +1006,6 @@ S: Odd Fixes
 F: hw/arm/collie.c
 F: hw/arm/strongarm*
 F: hw/gpio/zaurus.c
-F: include/hw/arm/sharpsl.h
 F: docs/system/arm/collie.rst
 F: tests/functional/arm/test_collie.py
 
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
deleted file mode 100644
index 1e3992fcd00..00000000000
--- a/include/hw/arm/sharpsl.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Common declarations for the Zaurii.
- *
- * This file is licensed under the GNU GPL.
- */
-
-#ifndef QEMU_SHARPSL_H
-#define QEMU_SHARPSL_H
-
-#include "exec/hwaddr.h"
-
-/* zaurus.c */
-
-#define SL_PXA_PARAM_BASE   0xa0000a00
-void sl_bootparam_write(hwaddr ptr);
-
-#endif
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index b8d27f59738..590ffde89d1 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -18,7 +18,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/arm/sharpsl.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -265,44 +264,3 @@ static void scoop_register_types(void)
 }
 
 type_init(scoop_register_types)
-
-/* Write the bootloader parameters memory area.  */
-
-#define MAGIC_CHG(a, b, c, d)   ((d << 24) | (c << 16) | (b << 8) | a)
-
-static struct QEMU_PACKED sl_param_info {
-    uint32_t comadj_keyword;
-    int32_t comadj;
-
-    uint32_t uuid_keyword;
-    char uuid[16];
-
-    uint32_t touch_keyword;
-    int32_t touch_xp;
-    int32_t touch_yp;
-    int32_t touch_xd;
-    int32_t touch_yd;
-
-    uint32_t adadj_keyword;
-    int32_t adadj;
-
-    uint32_t phad_keyword;
-    int32_t phadadj;
-} zaurus_bootparam = {
-    .comadj_keyword     = MAGIC_CHG('C', 'M', 'A', 'D'),
-    .comadj             = 125,
-    .uuid_keyword       = MAGIC_CHG('U', 'U', 'I', 'D'),
-    .uuid               = { -1 },
-    .touch_keyword      = MAGIC_CHG('T', 'U', 'C', 'H'),
-    .touch_xp           = -1,
-    .adadj_keyword      = MAGIC_CHG('B', 'V', 'A', 'D'),
-    .adadj              = -1,
-    .phad_keyword       = MAGIC_CHG('P', 'H', 'A', 'D'),
-    .phadadj            = 0x01,
-};
-
-void sl_bootparam_write(hwaddr ptr)
-{
-    cpu_physical_memory_write(ptr, &zaurus_bootparam,
-                              sizeof(struct sl_param_info));
-}
-- 
2.43.0


