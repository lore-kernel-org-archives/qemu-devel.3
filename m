Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD4AD29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rEy-0005Jb-1r; Wed, 06 Nov 2024 20:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEv-00059v-RB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEu-00038J-2B
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:13 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so3996425e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942590; x=1731547390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TuPwiqIhCeXBlsbOfNhFENqptld55kTTq3KPR5HdoQA=;
 b=xQElYISAxUBpBVklCJ9WCRLxSsUBo3nwEIRa0JYNJKghA+vIdMxOKjLNy1uiEE0lG9
 hXDhvvn/+3a56SxaM9FJBt9CbQbrVpHrW6VAGsSE6hSS2J8mXZ4He/AOXOIBMy17dv+O
 tK2zaYM3iwj0JzZxEEiPpeGpL1uG8uzmbURJDIQqVCO1pYFNTo8bPIQaYzDa1BY4fBmQ
 G9aIVg5hf6hFyR4dvb8u6lZ1qwy3K0es503mkyIC3pvtCizRhxsbq7My4zsL8IQO00H7
 3+YuT9sveHVHBSh31N51FsV2FmzGiIDt8exACJ72ArI69PMHULO2xVDLfVP8Yyil/BqO
 D0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942590; x=1731547390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuPwiqIhCeXBlsbOfNhFENqptld55kTTq3KPR5HdoQA=;
 b=RVaFYYP+vBgHXLuveAY04O3OWyw2sCipUkvqCgREvyT0mZEWtX980Y/qWakmyKAiJr
 OxiBKNgUSYhIDquotjUO4yLCeSDvcRb/O9MNCNqIQrb433Q38t8PHapSJrw5IMqnoplh
 Vew3jxiabLwjFzSv97yxJBY+tucihIwk0D7B1ED/lD0m5g8H0qKMI0syZ2Y7dHaq9VV8
 D1V7uDdZ54A7Kk7UezxWa8lYaLtLK+X5y8qDqhZI9JjPjJT1zW0Xa5k/2DByQzSSoVr7
 TDfG2IBfMFYWvuUxmgODkSLp6arrV/Io395G1mcpHy0hDjqtZdSDazPONQy2lAwkoSW/
 5eYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv8aaIv8osUfXM5W+6vfzoMPA97ltwUG/Mpubu8e34DDyUXNnh6YDtRz/HaxI4U0sWCmP2qQcxgSLV@nongnu.org
X-Gm-Message-State: AOJu0YztKHNgngwwlvQ+tozU0AQDj6i3Ws8S9rUL7IxNwbNND3N6mnDU
 zQ2tnX1DQdsLTFP6vb6uISVIy5ygV6OHXe909Y8ckN9WiaUImERqRUo8G2k5M0cDAkuw89DktDX
 T
X-Google-Smtp-Source: AGHT+IFezyeIDooFzWwnn1R7g3sGBfWkuBzcSwmwplcjcJ0m+3F65+GYnt7m+0SiPsTu1aO5sUHQ8Q==
X-Received: by 2002:a05:600c:510f:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-432b14bd38emr1457565e9.10.1730942590423; 
 Wed, 06 Nov 2024 17:23:10 -0800 (PST)
Received: from localhost.localdomain ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97e62csm240261f8f.37.2024.11.06.17.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:23:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/16] hw/char/xilinx_uartlite: Make device endianness
 configurable
Date: Thu,  7 Nov 2024 01:22:13 +0000
Message-ID: <20241107012223.94337-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness on the single machine using the
device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c                | 44 ++++++++++++++++--------
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 3022b3d8ef..c43bf1a030 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -57,6 +57,7 @@
 struct XilinxUARTLite {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
     CharBackend chr;
     qemu_irq irq;
@@ -166,21 +167,36 @@ uart_write(void *opaque, hwaddr addr,
     uart_update_irq(s);
 }
 
-static const MemoryRegionOps uart_ops = {
-    .read = uart_read,
-    .write = uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
+static const MemoryRegionOps uart_ops[2] = {
+    {
+        .read = uart_read,
+        .write = uart_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+    }, {
+        .read = uart_read,
+        .write = uart_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
     }
 };
 
 static Property xilinx_uartlite_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxUARTLite, little_endian_model, true),
     DEFINE_PROP_CHR("chardev", XilinxUARTLite, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -219,6 +235,9 @@ static void xilinx_uartlite_realize(DeviceState *dev, Error **errp)
 {
     XilinxUARTLite *s = XILINX_UARTLITE(dev);
 
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &uart_ops[s->little_endian_model],
+                          s, "xlnx.xps-uartlite", R_MAX * 4);
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
                              uart_event, NULL, s, NULL, true);
 }
@@ -228,9 +247,6 @@ static void xilinx_uartlite_init(Object *obj)
     XilinxUARTLite *s = XILINX_UARTLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
-                          "xlnx.xps-uartlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c0136d84c3..bd8b85fa54 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -107,6 +107,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     }
 
     dev = qdev_new(TYPE_XILINX_UARTLITE);
+    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
-- 
2.45.2


