Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB3BC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYFH-0002Gd-H3; Thu, 13 Feb 2025 07:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYFF-0002Fw-3d
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:23:05 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYFC-0002aV-7b
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:23:04 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab7e80c4b55so180093366b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739449380; x=1740054180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5LQvdlT1sMf3RQG3zaZimZ3xYwH68boESfP4z93+Xs=;
 b=MsQvugnhOZPJvwbc+gryVwJMynIrz7ScTdSYg+t8M6IRHpQkfMITjSe7vAZbV6uFo8
 u5UpwVnfHfxtbRrC7UeKJIIDvx6Uz8Sxtn/hlIw3IGem/SSYJPs8hrRNmVOEha19dKQZ
 rXpkqljH6A/RBTGMyHPaThicHr+2qNskoglUtp2uzdOzoCv8WBbgaafRak4Rs3lwKv3n
 RCCIgiZZUqtIPiLZAzDLuX4VXg/P2E15BWHP8rl/iSX+vNjEkNYykp/PHmodbnclWtAu
 6hoAGuECw06fLzzT886idewsOXcbZ6XMuPz5VwoyK/T/7JFk7+j6GjCGnv1HwV3fqWMa
 20sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739449380; x=1740054180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5LQvdlT1sMf3RQG3zaZimZ3xYwH68boESfP4z93+Xs=;
 b=N8fMo5LWbU542qJ7CnRg0YxaLVxPWkfTV8xyH7go+V1udU+dQI8P3bHoo0U0ee1NUe
 S/gEj1KO4pvw2W2Cd5MsRn2giXTwJ0CUsQ3FvA5kosRHc0EKcIOTC1dvGijJICo4CsQW
 Wk+1RJznZUI0a9HVfTn40xXaW4xlvVH7PtsSKFZVKqCN8vzUm8108Nx9lX1T4fCB2nRm
 mZl9f2IWW4PL5euQT0uTt4DZkw0zMJ2JrhEkgL6WnKqoWBOlgdlqRD0pwImXOzBwHLtM
 xbQC+u6h3MpI5o02POccgaR6D0kL8k3nErns96TOgLgNSTfMH+xZLykuUh86ui6wKf4j
 nLJw==
X-Gm-Message-State: AOJu0Yyb73Niy5kfLx8zk0Hn5USkL8ilUtYpvPF//cltOnE3gBKO9RYD
 /melnFSjqg6NI80prAvQ+kVE+z/nvOEBHt5NyF9HsTitJtquqv24HJHLnNjDg0fERSLDIAIWYSz
 1MiY=
X-Gm-Gg: ASbGncuc2F14uu3cgmhho7e94LW2izBDzoQZZnKCbo8FKm5U9zedMR2GXpD1tsNUEal
 wZlPfZqh81saYp8PjUNTdPAb8lLwW19MFL6Zvb2R32NkXI6vSbwczBL4ba1opciFeacmclekKtc
 WAuFSPyGXSH8Ze3nx7iXY/OSro7wDbRU1pRo7coJ/zt6Wxc+/eNc6XGByIexdSDod0/dkGlI97i
 mVBiS+fZmyb289kBMRUtuSGhUR4irr5/MB3Uyej7Hs+Edh6s2as3qssfsLksjGGsCeXh/PJIlEZ
 xPhRVHlWf6qOBjvdwbN9UPfPcsr9vMsXIu2/TmHNKz76fR6zhcnYEqFrJBnw
X-Google-Smtp-Source: AGHT+IEufQtYl1GZXzBN/A//tfi/4Bn39SOfFGr2GojO+YdfJtuUJ+1rvKKa3AdiJ2TXyBjfJM41ng==
X-Received: by 2002:a17:907:7dab:b0:ab7:cc43:c51e with SMTP id
 a640c23a62f3a-aba4eba808amr304929766b.13.1739449380395; 
 Thu, 13 Feb 2025 04:23:00 -0800 (PST)
Received: from localhost.localdomain (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532832dcsm121008166b.85.2025.02.13.04.22.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Feb 2025 04:22:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 6/6] hw/ssi/xilinx_spi: Make device endianness configurable
Date: Thu, 13 Feb 2025 13:22:17 +0100
Message-ID: <20250213122217.62654-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213122217.62654-1-philmd@linaro.org>
References: <20250213122217.62654-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.

Add the "endianness" property to select the device endianness.
This property is unspecified by default, and machines need to
make it explicit.

Set the proper endianness on the single machine using the
device.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c |  1 +
 hw/ssi/xilinx_spi.c                 | 32 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 984287fdc53..21ad215e442 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -177,6 +177,7 @@ petalogix_ml605_init(MachineState *machine)
         SSIBus *spi;
 
         dev = qdev_new("xlnx.xps-spi");
+        qdev_prop_set_enum(dev, "endianness", endianness);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index fd1ff12eb1d..be5baa6b350 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -32,6 +33,7 @@
 
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "qom/object.h"
 
@@ -83,6 +85,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XilinxSPI, XILINX_SPI)
 struct XilinxSPI {
     SysBusDevice parent_obj;
 
+    EndianMode model_endianness;
     MemoryRegion mmio;
 
     qemu_irq irq;
@@ -313,14 +316,17 @@ done:
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
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void xilinx_spi_realize(DeviceState *dev, Error **errp)
@@ -329,6 +335,12 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
     XilinxSPI *s = XILINX_SPI(dev);
     int i;
 
+    if (s->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, TYPE_XILINX_SPI " property 'endianness'"
+                         " must be set to 'big' or 'little'");
+        return;
+    }
+
     DB_PRINT("\n");
 
     s->spi = ssi_create_bus(dev, "spi");
@@ -339,7 +351,8 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->cs_lines[i]);
     }
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
+    memory_region_init_io(&s->mmio, OBJECT(s),
+                          &spi_ops[s->model_endianness == ENDIAN_MODE_BIG], s,
                           "xilinx-spi", R_MAX * 4);
     sysbus_init_mmio(sbd, &s->mmio);
 
@@ -362,6 +375,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
 };
 
 static const Property xilinx_spi_properties[] = {
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XilinxSPI, model_endianness),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
 };
 
-- 
2.47.1


