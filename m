Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE15C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacB-0006Lr-89; Mon, 10 Feb 2025 15:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thac6-0006Gh-Jg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thac3-0003cJ-CD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso48058275e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220157; x=1739824957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYj1i0C2Bzb8mJTlz6kNhAyO1j8/RdFzATqWG3urJNQ=;
 b=S30yiYi5/13bzm0QteEdEcOMAadosYfGQDRGdsdvDHi3znzNPOG9T17Mz89+7mVVth
 v9Ri9DxLIg7SL1tGYSKMbU4pLsXUcaCsv8TWpYddnNKMTnGjyhVh5cG8YdNs9w8QyQWx
 57eCRHPiD1bkLQEgQjja2mNiQCDpaNAtTcFEqM3sgaFW4MAujeRJlzLblO+0oLOOCLq4
 NLZs5qr6CGwRaF4BlI4x/BPZ2a8PrqIuNqp8/pgzpSlPCIbrjXhb5vy/u4LIreQuLRHI
 4ii1dYbFv7aFGqwUZ3gNe3A50F0uZJkuA+LCefkZ1yCpLhtRcWG5GdqjNByhgN99sshy
 k91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220157; x=1739824957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYj1i0C2Bzb8mJTlz6kNhAyO1j8/RdFzATqWG3urJNQ=;
 b=EwXDOlsAtYZ7gQ8qgW1JHXzMKp5GZPMypIXmDdjgFIN3IhbpSsK/oojZMt8v7cvWUQ
 /AXHD4PBNEw3OZdya8ixh0PjFBUSdfzaiB4lhlXF65EH+9bGMPV5/DCjbKZFhW2XUHL/
 86fN2cc09cs8IE7Eob9ywufc/l4QdEYT7SCuTSgk22ZvWw4X/rM9nPBXrpw+vdlXV0OP
 Hb/BBdclyiBsRHI5aCp3YQAox9Wbh8p4qF4IxMsrizlYRFdlQjeEh6NnsED9df04zY5z
 gN5f0Hl4BNreje/s55S8H5jQQw62V830UUXjlWZqCF0IITCS6IS1QdqM26t3TvmfDlPv
 JYuQ==
X-Gm-Message-State: AOJu0Yxpj+221QsZVC2e5lIs270vlnyrVDuh9/n4cG1xLEg4IXqQ95zb
 yAYUj8qqdul4q/EVYjL048rY6jpgD3M5wlQDplxepy8AZhLwNffChSxwSCfDOW+cKmLiW5mJlHO
 WmuY=
X-Gm-Gg: ASbGncvRZLOu2+lLjonxiVt5n4p1Ve4mN2829+smsOSLke5sEghoL6ftWI6WS/yz4hR
 VtuM6tp4eWqV+LotZ2eAt6MRWPcjzhCVNRMAYuiE2yYcU3RIBOmGLSnEIn2sVBhjdv4YmSd3cvd
 FwNcJWpjIFPJ9EXAMwuE4n9HdgFCcGG/Pu51gBO/cuKBGyYpXPkLDdqVKBSNiiI+aB3G3VZRC6b
 zEapE2cEi/Kgdaf5PFAGQJdJnz9bR/LypuIIQ9vcyp3WysTVD8BLKR3lR3Q5Qx4CPR0w5M3Gjl3
 uQIdmRoZnNNbF0tpmdgGzZ8iNa7qoqb9hEIa/FvMZ1aQJ1/WCJmSay/zl2iCRxPYAQ==
X-Google-Smtp-Source: AGHT+IF6O5pXWB9UXMPh2mDILfcy102zxeO/PwIAFIDE+pGH0X0cSKb7LwTTqvrxM3SMMemnlCrRVw==
X-Received: by 2002:a5d:6705:0:b0:386:3e3c:efd with SMTP id
 ffacd0b85a97d-38dc9359019mr11007358f8f.44.1739220156654; 
 Mon, 10 Feb 2025 12:42:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4438sm195336895e9.25.2025.02.10.12.42.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/32] hw/ssi/xilinx_spi: Make device endianness configurable
Date: Mon, 10 Feb 2025 21:41:38 +0100
Message-ID: <20250210204204.54407-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250206131052.30207-7-philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c |  1 +
 hw/ssi/xilinx_spi.c                 | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index bbda70aa93b..a795c6385b4 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -175,6 +175,7 @@ petalogix_ml605_init(MachineState *machine)
         SSIBus *spi;
 
         dev = qdev_new("xlnx.xps-spi");
+        qdev_prop_set_bit(dev, "little-endian", true);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index fd1ff12eb1d..299004ff36d 100644
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
 
 static const Property xilinx_spi_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxSPI, little_endian_model, true),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
 };
 
-- 
2.47.1


