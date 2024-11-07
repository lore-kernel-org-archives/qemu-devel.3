Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F07D29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rF6-0005Y5-Cx; Wed, 06 Nov 2024 20:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rF0-0005RY-Va
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:19 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEz-00039C-FC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so3874475e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942596; x=1731547396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8b7EtynsPdTlIUnymud+/C6nv+jv5HCTN85r9i8c40=;
 b=KQASY5aPrZjMt3Lpdhv5xylbZN6Um2JxHh4UrMQJUJ4sVQZxfNzS+jopxT90x6KDcm
 BDQKoLry3OfAV2npiTXI5W11VSnaznkYxqxXC90YINFnlfymyYzhFvDuuRjvXD/Rg2Yj
 42uYJESUVDDhM9RSa1FtXo0Lh5FRF0A8l7u1869Up37GnDGzXbEGmuAugE9tuC82eqIX
 TvjKPRoHicbFTv4DuInmsyppvOTmgovfWfMB90HMBpME8ICefAUlyYadxO9laDG/0sbR
 yHaQ+iUi5L5h8zaYlKl+Q9Mww3yCq9f0469RsEk+eFFXkf3wW8UCjjU6nbR49bTj6jyQ
 ZESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942596; x=1731547396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8b7EtynsPdTlIUnymud+/C6nv+jv5HCTN85r9i8c40=;
 b=pfW7cjHeafkPi8JRgeM1xKaIU4lSF9NCRMIdKb+WTaI52aW2aty47SY/wLVMfjQu45
 Dif74MTqJv1R1284nsZcFc76gYs27ySPbedGoOib7UF+lWKzSt7zYQDOcXQaPVM0Uq1h
 n/4lYW/fsrpS7iyM9DkA5js0AlKII3LLz2wn+VmUoBDOPoOn0RVMvhIrUn0j6MuN2cDF
 DpKbr9wDYTxALL2Xa5+9QCeaq2qnPTst8j/7nfgYYqtCUqQQVSB90dqwixkwFLlV+fcR
 EtcrH6gvK8N6XMQHjvlAbtpGgqiQEM75k/hyyp1TAzkSURmAN/RL77ZnKXjVmZmlT8Qg
 VfyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsaIEgPCdb6YlkZgR4MVJaS0uLXRWf2s7Gp40GzIoQYHWFch5gGoBeslY+FPH6pEcKsomqiii/QkET@nongnu.org
X-Gm-Message-State: AOJu0YzNMcJFIo62hED4OoorTJ10L57pf8VNJDk3nHBgk+rt6wdGfrfY
 RtsNjt+E48+C1clCop2x87A9X+2ZYSUIO/v+owNrmXY3emqbYs5c2EW+gwGK/d4=
X-Google-Smtp-Source: AGHT+IEE+kVRBrvkx86XAbC+aBhLKVgnFhUk+rSZA8giQ5ex0ZUN4jL+1ahb3VgvYCznf7OLVnrRAQ==
X-Received: by 2002:a05:600c:3c9c:b0:431:5194:1687 with SMTP id
 5b1f17b1804b1-432b14d1f05mr1578485e9.18.1730942596042; 
 Wed, 06 Nov 2024 17:23:16 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a2732e10sm46049145e9.2.2024.11.06.17.23.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:23:15 -0800 (PST)
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
Subject: [PATCH v2 08/16] hw/ssi/xilinx_spi: Make device endianness
 configurable
Date: Thu,  7 Nov 2024 01:22:14 +0000
Message-ID: <20241107012223.94337-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/arm/xlnx-zynqmp.c |  4 ++++
 hw/ssi/xilinx_spi.c  | 29 +++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ab2d50e31b..e735dbdf82 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -714,6 +714,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
         gchar *bus_name;
 
+        if (!object_property_set_bool(OBJECT(&s->spi[i])), "little-endian",
+                                      true, errp)) {
+            return;
+        }
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 7f1e1808c5..2a0c9bca05 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -83,6 +83,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XilinxSPI, XILINX_SPI)
 struct XilinxSPI {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
 
     qemu_irq irq;
@@ -313,13 +314,23 @@ done:
     xlx_spi_update_irq(s);
 }
 
-static const MemoryRegionOps spi_ops = {
-    .read = spi_read,
-    .write = spi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
+static const MemoryRegionOps spi_ops[2] = {
+    {
+        .read = spi_read,
+        .write = spi_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+    }, {
+        .read = spi_read,
+        .write = spi_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
     }
 };
 
@@ -339,7 +350,8 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->cs_lines[i]);
     }
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
+    memory_region_init_io(&s->mmio, OBJECT(s),
+                          &spi_ops[s->little_endian_model], s,
                           "xilinx-spi", R_MAX * 4);
     sysbus_init_mmio(sbd, &s->mmio);
 
@@ -362,6 +374,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
 };
 
 static Property xilinx_spi_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxSPI, little_endian_model, true),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.45.2


