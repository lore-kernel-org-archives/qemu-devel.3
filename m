Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C735DEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMn1-0007xD-Qc; Sun, 08 Mar 2026 18:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmn-0007hl-QX
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmm-0003n2-6s
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso89225145e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009582; x=1773614382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TwvQ29jY5wUxFvvCaCnGTpkivDzrqW+t2E04DI+HqDU=;
 b=EyVvm0/N53qBub1LTkAUMqXOwyrA2eMazcYCsTQetZ47F+vaP+0wuNYsGIiyvbwrrr
 JZJfLCy6eRUKaOkKRUnzdqB6JcJ+kiyfikN5HZ3pQ+adEqxtDC7WNCtgjtlCcKJHF2dr
 b5iBRzRVIOaVczNE/l+wb9HXWvgYwSGcAIc7ZDI0SjVHe9G2sUcUqHnY/kRyM96rnLpF
 ZxwRHRtyMAyI6H8siR3Misj9/jNG6fTx4dNN3uJPveeCdaFemEa7Ja3nQc36Y9wove6P
 jQ6oppr+eLKZATeHGdhv0IFgK9/+sj8iQFOR2UTnGkC9kmpYsJpRZOXcbJ5USbJR1Nib
 Zujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009582; x=1773614382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TwvQ29jY5wUxFvvCaCnGTpkivDzrqW+t2E04DI+HqDU=;
 b=CS5EdHI8XUNL0bYnZ1Jxd/kmZa3q17y1RoPlJy/pxjKFjxPW5jW8H6FCKxJzQtRtbd
 yQ27ePdzAc56lJFdMnDY7qmsMvT8AGfevOfKgaybnIo3cF46fh/S/p73fMSqUBTJiTLG
 xW33Vg7HE8nfp5w/qB5nM0WdzR3iNQ+a+RYaf1dribkmT9yCBGMQiYAjw/6mtTtI1m65
 TjXgh1bSxduV7tGYSDuXx/daN6TmVQRvYbOEYJCYDPbWj6UeeJT8+82MJyQSvcBQu2Vf
 aqxVFiNWbHZxvS9/JTIWIoI0lLV2Gguq9DUYg3/gU6NV4H4ku3/FrfboJj3waIYgJQ5W
 A7jA==
X-Gm-Message-State: AOJu0Yx0Ju/9eFJ5ELnsOKQ+Q4TXMKkaEpnlHW6Ce17k7Yj38LEjCVG5
 lRQMZitQdiEUuuIiu4EtftgyJZVGm3IOV1mpPtfK8Ui/XuRQ7xXZclPiGRvG9h+w8q9Fsxsz2xp
 EHT1HSrQ=
X-Gm-Gg: ATEYQzyHlRpnz+XHI7p5Irx98ckC14df7rQLGrmD8agMXxRDFW71vw7NQhip6su+ngc
 OGTKbU8R2AznTlJNICQqtAm/Y4pJu+594lt/CrPyPU1GhaeZydudkvCKcx2dzJKAiqi7MnRHBfE
 BZ3KWwmEd8wDgPE+ws8RSPoHKBFqiSG71TJD7JhtiyDOOXDmU3zF8Eja6Z7K1vFDo8feTZIO4fr
 Nu8aX3/BoTVn5XKy2HSYksG/HQyxZRu/c+t/csVOWqmPh5D5e3+pWXyaKWrmc8b+8t2kh330+Es
 bKqj+vP3nAt3xXW9/zK+dh2mzhBHulcq3npX4t2lx0Zhpqo49EXy/2/osJs2r5sJLp2RZgIsmcz
 v33XgY8smICgkIX0N0rPJyuw+0xKpTotbHU+Tr8HhlIkf6A820Ij1fhuKkKVqCSIbKq5owx9yHk
 ECeCUaE6rgcJMqftu3Y8NdFzQQwF3fQAaZGtRKN+SefbwAiuksYtiCAfUWL1Fdk4dpX2tPRtLwp
 jpvYQ==
X-Received: by 2002:a05:600c:1d1e:b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-48526951ca9mr161802845e9.22.1773009581873; 
 Sun, 08 Mar 2026 15:39:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad97abasm19409055f8f.10.2026.03.08.15.39.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/49] ati-vga: Allow setting EDID parameters directly
Date: Sun,  8 Mar 2026 23:34:29 +0100
Message-ID: <20260308223433.25503-46-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The EDID generation has some parameters that can be set via properties
but since ati-vga uses i2c-ddc it is only accessible with -global
option. Expose these properties so users can more easily set it via
e.g. -device ati-vga,xres=1024,yres=768.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260305233717.1D08F5969F6@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_int.h |  2 ++
 hw/display/ati.c     | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 98f57ca5fa4..874c63eb544 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -13,6 +13,7 @@
 #include "qemu/units.h"
 #include "hw/pci/pci_device.h"
 #include "hw/i2c/bitbang_i2c.h"
+#include "hw/display/i2c-ddc.h"
 #include "vga_int.h"
 #include "qom/object.h"
 
@@ -108,6 +109,7 @@ struct ATIVGAState {
     QEMUCursor *cursor;
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
+    I2CDDCState i2cddc;
     MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6cf243bcf95..9a7c5703b0f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -28,7 +28,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "ui/console.h"
-#include "hw/display/i2c-ddc.h"
 #include "trace.h"
 
 #define ATI_DEBUG_HW_CURSOR 0
@@ -1039,6 +1038,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
 {
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
+    I2CBus *i2cbus;
     uint64_t aper_size;
 
 #ifndef CONFIG_PIXMAN
@@ -1087,11 +1087,10 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     }
 
     /* ddc, edid */
-    I2CBus *i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
+    i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
     bitbang_i2c_init(&s->bbi2c, i2cbus);
-    I2CSlave *i2cddc = I2C_SLAVE(qdev_new(TYPE_I2CDDC));
-    i2c_slave_set_address(i2cddc, 0x50);
-    qdev_realize_and_unref(DEVICE(i2cddc), BUS(i2cbus), &error_abort);
+    i2c_slave_set_address(I2C_SLAVE(&s->i2cddc), 0x50);
+    qdev_realize(DEVICE(&s->i2cddc), BUS(i2cbus), &error_abort);
 
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
@@ -1147,6 +1146,7 @@ static const Property ati_vga_properties[] = {
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
     /* this is a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
     DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
+    DEFINE_EDID_PROPERTIES(ATIVGAState, i2cddc.edid_info),
 };
 
 static void ati_vga_class_init(ObjectClass *klass, const void *data)
@@ -1169,6 +1169,9 @@ static void ati_vga_class_init(ObjectClass *klass, const void *data)
 
 static void ati_vga_init(Object *o)
 {
+    ATIVGAState *s = ATI_VGA(o);
+
+    object_initialize_child(o, "edid", &s->i2cddc, TYPE_I2CDDC);
     object_property_set_description(o, "x-pixman", "Use pixman for: "
                                     "1: fill, 2: blit");
 }
-- 
2.53.0


