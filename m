Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE37BC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret0x-0006Nr-8L; Tue, 27 Feb 2024 03:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret0v-0006Mw-OH
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret0s-0007oG-Kb
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412af574659so875515e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023232; x=1709628032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFksONIBdqYx5443JbI5pC5i+NSIyfbO3mN1D7EMdV4=;
 b=M9rBA+wkHQinY9Wx6xSndxiOK6YJ9GlEZsdqoijNFtW3aNGxtKFPuEmeXDIzQKlDCz
 SQBnmviT8XLh8N3Drff4U2TUIdYpaybaRSTlb0CIx9HNCJvgwkuFDkkiO5jdqmsQmsSQ
 e8dnNwIyHNPLPX7qQSX4hWtBj6eQhiaHDV9yPSLqsmAYek02eblUpy3Wi99ngG42Q2RV
 ucw8naiSVz6SyAwdqYDHngfuFGzmEI2rvIqojZaXR5xnRiWNF/irnVyCdCvyRz+B2n9H
 B3OD/fXU+D1hxVUx+bq9nZMpybJnh8x+g+chBxezQWZu/xducHM0ZEBVM6ZvGmHHWIOc
 nbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023232; x=1709628032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFksONIBdqYx5443JbI5pC5i+NSIyfbO3mN1D7EMdV4=;
 b=RdnKU7K5bfnNvermtmjLRvnrftvIHDB1fX3oniIv4Kth9mS1YUuHFNKHWXUN2T8vhz
 mF1TLeMpetF7YANU939hpYq8M0JHRfjDnSFlv3QGZKQ1jkUapgIKBuWwdJgWnXF1sSnp
 +uC86PRRdLmfEbeTINFmH+Nwt1UuDCbAEJrCqBK3bTxexMx2PY40wbqbjPoO6OXW8fKZ
 uUrQF5bpGsEGXL/66fMfD6VjQ4puMFPW924psdbWsDimL7qyVrkOm0U9tiY98O1hDXU1
 pKMr3hDSy59LmWPTKcPDZYhJ6vSP0Bn6io3KajdOdmD6p4qRrsD9tGwi4FneU9vm2/pY
 v/0A==
X-Gm-Message-State: AOJu0YzSAWDdvkYvt9MsGvP0tVn2HE+0iEr3oDcn1i6hzHFGddiP6MxJ
 6biQhSEHOvofvxjIHG6FHdkJHK2N5Wd3zt5peLpK5RkHx9DuKrHDH0e7SjXgBqgW5SYaeeOUZjD
 J
X-Google-Smtp-Source: AGHT+IFjfaT4JHPc0z/TAs3m/80pAdTwcyrEIitLqCYksLyOFCjLQ9YqhOIBTe1sHoBUUXJHJn3DYw==
X-Received: by 2002:a05:600c:3b08:b0:412:a0e5:728f with SMTP id
 m8-20020a05600c3b0800b00412a0e5728fmr5388423wms.21.1709023232617; 
 Tue, 27 Feb 2024 00:40:32 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c4e4d00b00412ad7c8298sm1016497wmq.8.2024.02.27.00.40.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:40:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 07/30] hw/nubus-device: round Declaration ROM memory region
 address to qemu_target_page_size()
Date: Tue, 27 Feb 2024 09:39:23 +0100
Message-ID: <20240227083948.5427-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Declaration ROM binary images can be any arbitrary size, however if a host ROM
memory region is not aligned to qemu_target_page_size() then we fail the
"assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().

Ensure that the host ROM memory region is aligned to qemu_target_page_size()
and adjust the offset at which the Declaration ROM image is loaded, since Nubus
ROM images are unusual in that they are aligned to the end of the slot address
space.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20240111102954.449462-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nubus/nubus-device.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 49008e4938..be4cb24696 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
+#include "exec/target_page.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/nubus/nubus.h"
@@ -30,7 +31,8 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
     NubusDevice *nd = NUBUS_DEVICE(dev);
     char *name, *path;
     hwaddr slot_offset;
-    int64_t size;
+    int64_t size, align_size;
+    uint8_t *rom_ptr;
     int ret;
 
     /* Super */
@@ -76,16 +78,24 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
         }
 
         name = g_strdup_printf("nubus-slot-%x-declaration-rom", nd->slot);
-        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, size,
+
+        /*
+         * Ensure ROM memory region is aligned to target page size regardless
+         * of the size of the Declaration ROM image
+         */
+        align_size = ROUND_UP(size, qemu_target_page_size());
+        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, align_size,
                                &error_abort);
-        ret = load_image_mr(path, &nd->decl_rom);
+        rom_ptr = memory_region_get_ram_ptr(&nd->decl_rom);
+        ret = load_image_size(path, rom_ptr + (uintptr_t)(align_size - size),
+                              size);
         g_free(path);
         g_free(name);
         if (ret < 0) {
             error_setg(errp, "could not load romfile \"%s\"", nd->romfile);
             return;
         }
-        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - size,
+        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - align_size,
                                     &nd->decl_rom);
     }
 }
-- 
2.41.0


