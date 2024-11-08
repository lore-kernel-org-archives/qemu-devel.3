Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0208CD5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R9g-0004j4-BL; Fri, 08 Nov 2024 10:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9Y-00043U-QL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:05 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9X-0005Xw-3Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:04 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53a007743e7so2825722e87.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080639; x=1731685439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yvAnRqHOJ8zMrJh8p3qdMbAMq8Ve9ZQx1fNBTquDvI=;
 b=aLEbvY6WsltmxxzrqjdYqAU1vvSuXEo4yKqXUDuLGyxcXACkUKKF1+sqdBOGh9amK9
 IacH1BS8GwD/28yNTSpuE2SJACC1Lm/EopbY3e1GoNLexTMR1j15c+rIhnq4hRp+Cvfa
 vhkWQVSEtygjqkvZS4BCD9BIkwI/dbPWt9k1qG4QZUG+VLky++DDTLTinbzH8AqyBHal
 qha38QbeINyjL/hXUyIAfZKEj0czwRWuXTvs+Hoe+bt+9Y46PVVmVDm6MvVKSyMA/KFz
 mMIzlkeASEGOl4gRIaB51Ns26FkdiBlPf3NhIGlLtgsbKoQSuy3TN6mwcKW5oww8oLid
 IL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080639; x=1731685439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yvAnRqHOJ8zMrJh8p3qdMbAMq8Ve9ZQx1fNBTquDvI=;
 b=QBKbN3eya/ws6+4VCG1TRIJUCWd/4kmhtcOp4H1E2eOpKsgyH0ajxGEmIdS6/NG6tE
 nvyHUy7SCr7n55z0+MRxLkMN+Xuaq7Z97tmlJuyu5HknPgshQnidUNyTlpAUXPuz1RcW
 CK2AN4s+g7WoBOjDdC6vZyMZHTJi6Ab5tz+vzvzqwaUfPEXjGJ1gD7NdBmmcbiNbRQ6s
 l2YB9Vh6GqTAEfYd07MfVR0w2qSK1p6LspP7SgkKl46ZSq6k3sg190Au+Dln2jO+uzsC
 5q/t21BJFXzferUfWfsiuROCcqDzR5aSA0/Qe+PenGGjKjEXxNh8eHbe5BJfWzyT6uxc
 yULA==
X-Gm-Message-State: AOJu0Yy4sF/RfeMDd+VNYX/cj3lD02yUmM+BGegZtS5RyOWapLRNVgqI
 /QIVtiIm9ya5ZpnQo63kaSlByPouVuhLe+nmVvs0MfTOaq0fVHvr187APZgK2K6muuDIq96A+pN
 v
X-Google-Smtp-Source: AGHT+IFysdd0sB0oM1y+OBmZx0gw8cECxiOrtqq9YEeOGFH6EohwgFb6RAjFTMlultPEbK+MRxo+zg==
X-Received: by 2002:a05:6512:acf:b0:539:adb0:b86 with SMTP id
 2adb3069b0e04-53d862308eemr1899220e87.14.1731080639025; 
 Fri, 08 Nov 2024 07:43:59 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b3505sm107581395e9.15.2024.11.08.07.43.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:43:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/17] hw/ssi/xilinx_spi: Make device endianness
 configurable
Date: Fri,  8 Nov 2024 15:43:08 +0000
Message-ID: <20241108154317.12129-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xlnx-zynqmp.c |  4 ++++
 hw/ssi/xilinx_spi.c  | 24 +++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

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
index 7f1e1808c5..8926ffb927 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -83,6 +83,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XilinxSPI, XILINX_SPI)
 struct XilinxSPI {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
 
     qemu_irq irq;
@@ -313,14 +314,17 @@ done:
     xlx_spi_update_irq(s);
 }
 
-static const MemoryRegionOps spi_ops = {
-    .read = spi_read,
-    .write = spi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
+static const MemoryRegionOps spi_ops[2] = {
+    [0 ... 1] = {
+        .read = spi_read,
+        .write = spi_write,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+    },
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void xilinx_spi_realize(DeviceState *dev, Error **errp)
@@ -339,7 +343,8 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->cs_lines[i]);
     }
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
+    memory_region_init_io(&s->mmio, OBJECT(s),
+                          &spi_ops[s->little_endian_model], s,
                           "xilinx-spi", R_MAX * 4);
     sysbus_init_mmio(sbd, &s->mmio);
 
@@ -362,6 +367,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
 };
 
 static Property xilinx_spi_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxSPI, little_endian_model, true),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.45.2


