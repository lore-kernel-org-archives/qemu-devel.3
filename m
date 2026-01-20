Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E23AD2628A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfM-0003OR-UQ; Tue, 20 Jan 2026 13:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfC-0002Hw-TQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:15 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfA-0006Oq-8w
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso28322765e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934470; x=1769539270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oY/XtSQ2gGwc58E9vKBho+DUeDG3sgS/5ejQ5/WSECA=;
 b=HBF0tc8VoRm3/HISaW6SlRpcgyt4Gum3r/giCYXU9o5prArM7e+NJutRRKfTbOrLqu
 9oXCACYaotGNSW410hcXKJ9FkyCcbW93xSyJ2wW/lQWPXEgO0khcRe5nSdfVk3nw7UJl
 BuI06spy+JE+CmfNmKTw6m6qhyfxVXPo2nP9MoAis6TBGlVf8v/N1X/R2Ku4gcb121X4
 QwgeTust6DOe1wKTGce343+qxmy+Mbb5+Oc6Jc3Y3JN8mwKo2FxS+eAsYQT6asTqP5RO
 X34RCLeoPq+g9JPZdDzRd0QvDWZUXhvrkBzOq0aD7mIyf76nZ+bUVktiv649T3AnHW6C
 JWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934470; x=1769539270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oY/XtSQ2gGwc58E9vKBho+DUeDG3sgS/5ejQ5/WSECA=;
 b=YHcvQFG5kdut9Vv27BS2O5HZfWCvzl1rVlTVD1THWH1HBUz7GvEpmUrUAV24ULhFQ1
 O5nu9CzJ4miVT0CURr7V+k/EzOLuYhONdNgj9lVCpi7+p/7NK/M0nBFd4IV8g3Ld6CB/
 ut2kp39nofQg/9XSJRuDAXBIAmfa+/I4LT7Ixzseloj0rJ8iEXTXeQNC1APc6+ASVuAy
 zKLapt/gMWRFjCUt9f1MmBLdgAGtsF3MmYZTrsZwkdCed7+P8lHIKKPSqp2O02rO28lg
 XE50ReDUHDba7LJqi5+V5nJ3kFkxjsDWGlM84z0uwENafeInubSD4Ni5GPjDpWp3beMu
 Xf7g==
X-Gm-Message-State: AOJu0YzUahyw/XD6pMiwZJY+tPfAxNWFPnVQ6rcRFm9c3GeY7zz+NtBL
 n/rCHstEoaxt75w4/KxUDAQtE0Fleu1tgDna1Mo95Cc4tSm2dbKAw0r2e50Yh8PJQE5ir1FWcLT
 fKw2yGLU=
X-Gm-Gg: AY/fxX4zFuOd7Ty2ThVEfn4MUfdLcDvkFAeYfzdgIjngE8EUOMeDiGDOvZvbv/olvC4
 5l7S2oXOCmLiVFMqXApJh5gfjYGT6gAgy7ft81hrew4mhVfJgcjy2sAXO6/IXTekK2Nij0rs8j9
 dF9gDA/u9hkw4BaUMf4/YB6TavdGUwFZ1WzMSzvXSA4BJi4N8FfbqJ3FharDZQb2F1PQxxMikJu
 qEiZO73eKDhQI8IYVGQ0t29LNE4QzwKHhamfs84UlpOegoMdj7ihK088Snl1JwKY9pw1RHrShBJ
 6P14styLX6F/1H6a0MRFaD9j72hDtdZl48Sz9H9bz7o7FlK4mkDX62MNzrWFdEO2vfxWpxuMDTV
 8QGVJY7jTpVe74dIeN1LV3dTOp0uvBEB3ndo+L+ftHqC5UfbyfIc9+NtPlQKNSmYECclfP73ZRV
 bAuSwc4ilrDZnOCNOEN11ongGtsM6jPVmeHZI7IlBqJ831fxVYCxQkvHq/f9IV
X-Received: by 2002:a05:600c:3d97:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-48029b7db7dmr151068165e9.10.1768934469910; 
 Tue, 20 Jan 2026 10:41:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b789sm317503165e9.1.2026.01.20.10.41.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/29] hw/arm/fsl-imx25: Extract TYPE_FSL_ESDHC_LE
Date: Tue, 20 Jan 2026 19:38:51 +0100
Message-ID: <20260120183902.73845-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Extract an eSDHC (little endian) device model since the uSDHC device model
will get an uSDHC-specific MMIO quirk.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-11-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/arm/fsl-imx25.c    |  7 ++-----
 hw/sd/sdhci.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 3eb0684a890..32c52c7d0be 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -129,6 +129,7 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
                          TYPE_SYSBUS_SDHCI)
 
 #define TYPE_FSL_ESDHC_BE "fsl-esdhc-be"
+#define TYPE_FSL_ESDHC_LE "fsl-esdhc-le"
 
 #define TYPE_IMX_USDHC "imx-usdhc"
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 9e02063533c..7f65f4ca4bb 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -68,7 +68,8 @@ static void fsl_imx25_init(Object *obj)
     }
 
     for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
-        object_initialize_child(obj, "sdhc[*]", &s->esdhc[i], TYPE_IMX_USDHC);
+        object_initialize_child(obj, "sdhc[*]", &s->esdhc[i],
+                                TYPE_FSL_ESDHC_LE);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_USBS; i++) {
@@ -239,12 +240,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_ESDHC2_ADDR, FSL_IMX25_ESDHC2_IRQ },
         };
 
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "sd-spec-version", 2,
-                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
-                                 SDHCI_VENDOR_FSL, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6277abe8702..6001b71c61d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1897,6 +1897,32 @@ static void fsl_esdhc_be_init(Object *obj)
     qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
 }
 
+static const MemoryRegionOps esdhc_mmio_le_ops = {
+    .read = esdhc_read,
+    .write = esdhc_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void fsl_esdhc_le_init(Object *obj)
+{
+    SDHCIState *s = SYSBUS_SDHCI(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->io_ops = &esdhc_mmio_le_ops;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    qdev_prop_set_uint8(dev, "sd-spec-version", 2);
+    qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = esdhc_read,
     .write = esdhc_write,
@@ -1996,6 +2022,11 @@ static const TypeInfo sdhci_types[] = {
         .parent = TYPE_SYSBUS_SDHCI,
         .instance_init = fsl_esdhc_be_init,
     },
+    {
+        .name = TYPE_FSL_ESDHC_LE,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = fsl_esdhc_le_init,
+    },
     {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
-- 
2.52.0


