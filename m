Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CA5C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzSE-0007MP-CU; Sat, 08 Mar 2025 14:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRx-00070L-RM
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:06 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRv-0003Zz-K7
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bd45e4d91so17149585e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460581; x=1742065381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tnj+mTi8s7/bMf+Ney6NYzMHgEQnS0OOPbvhz438H5o=;
 b=Q6Reit88KFJXCxeDD20PQGv2eTkrorznqwF1/WQJamO7udYKooPocC2pWNdp1sGwQU
 JRHs6UuCKWO4KXG+OVqF4Fn1GxNFyvqSLXtq5zj3WuMLnPvFAeuKxkaDs2cPfglGMNWi
 uxwAwmEVcH9nyQqoRAkznX+RgS/mPZ/xwWappD5e0Sm8hbR6kQLa+5cZ4m3VE1+NgYCi
 Eqdm2dgnX82Y2XAx+QHg0laO/m3rzkhc0OKTiNS0BvcZueVE3DXjZxN5Yr5TORAmZ2TE
 7PHaOA+oDNOYnojFtYIy5hJPxsNy3izKdeRAG6SO8X62ZURrM3FxA37OdJxu8BNy8Koq
 EaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460581; x=1742065381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tnj+mTi8s7/bMf+Ney6NYzMHgEQnS0OOPbvhz438H5o=;
 b=JA+lwavxcZR3TwPLEw0f42Nx7KtYYRuLrMzvMli5hNxVPJvxpEqEBm5AKQKR0okXIi
 v75MhYq7PTNJDKtuJgUQfPE/OlcTMGNLYYTj64RTJR8kwdwYQt46Tb1Hi1mXks6DKPeY
 belmV/T9dAJuUSI5o6/CtmVwUQNg7zJUOjlCGs2Woy1YW7agCvYWIfVHtycZS9LOQlDn
 Dy+1HkO7BbduvVExyoYaTrgnCeNyGkijB1BOPam3IFfQy5DVbRtXyTw0b4dxDi9lUuxC
 bamNTkhaipBciyiA6eTmts0HEX7kGceVN71wUUfRbK8S3zOZfVzC3epnnMUAGVfNerff
 S9iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEYaqI9W31t7TXGc1iAHAff1SAXnaB8RPfCaJ47/xbw0h0qyPlOSgplmtWzLKqE1u9D6Y+qZfirBxH@nongnu.org
X-Gm-Message-State: AOJu0YyEMW+1yxAQIQJDLaKmPctpepcz5Vd3EY0VqPuAKOJSwcj5s2SE
 bPJlevzDrm97H6TMdaqtgijSOQu1CSg4KXOk8ukZRe1O9KGvspzlmz9+rv8wcfc=
X-Gm-Gg: ASbGnctobHvAgjgctbOCOY1OoslLegOcfAZCpjI9LcMy9dWxB/yjSG+QcAlw7S1PM5o
 SCPig6LxYO2CGWx99ReosrNd5Ac9kkAzVz4WAOEmFdG3ANsofTBNJSkhMhF9ihtKk83ZxOEV5Iq
 DzDggUkTHgJO+jLfUZQCCx8LXOtLpAY1igaV/WWBURoBaloI3uK2Ejs4fUh0DFQ1RtdO3Yh49jZ
 dl8p36o7Wb/fNmHVaOV7TJjTnCj2xd0t/LucZFslW52w+qN/IrL0JkcJQU227odNff9yZDsuThB
 0c2ZpaNJVIcBTCOl9BcN7Q0gas8e3zH9lbcfen4yWa6zTDjcV8WD3e15xwxHg93SC/V9oBJuQPQ
 9wn+ttfAR7LqtQgmx4ChBAIB6DpnY2Q==
X-Google-Smtp-Source: AGHT+IH7Lq7VQOQ+CIuQ2bfM0fQWfnNjqK0CSKbQfrwLjrJY96CjfmYfNAB2pwVH4FMd4K5hftDfNw==
X-Received: by 2002:a05:600c:5118:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-43ce4ac8229mr23840105e9.6.1741460581506; 
 Sat, 08 Mar 2025 11:03:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce9f2d081sm27980775e9.21.2025.03.08.11.03.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:03:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/12] hw/sd/sdhci: Allow SDHCI classes to register their
 own MemoryRegionOps
Date: Sat,  8 Mar 2025 20:02:24 +0100
Message-ID: <20250308190230.7508-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Add MemoryRegionOps as a class property. For now it is only
used by TYPE_IMX_USDHC.
Otherwise the default remains in little endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 2709a7a69d5..60a0442c805 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -112,6 +112,7 @@ typedef struct SDHCIClass {
         SysBusDeviceClass sbd_parent_class;
     };
 
+    const MemoryRegionOps *io_ops;
     uint32_t quirks;
     uint64_t iomem_size;
 } SDHCIClass;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 59d506cafa3..d87a7bb45a4 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1427,8 +1427,6 @@ void sdhci_initfn(SDHCIState *s)
                                    sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      sdhci_data_transfer, s);
-
-    s->io_ops = &sdhci_mmio_le_ops;
 }
 
 void sdhci_uninitfn(SDHCIState *s)
@@ -1445,6 +1443,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     ERRP_GUARD();
     SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
 
+    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
         /* s->io_ops is little endian by default */
@@ -1888,17 +1887,11 @@ static const MemoryRegionOps usdhc_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void imx_usdhc_init(Object *obj)
-{
-    SDHCIState *s = SYSBUS_SDHCI(obj);
-
-    s->io_ops = &usdhc_mmio_ops;
-}
-
 static void imx_usdhc_class_init(ObjectClass *oc, void *data)
 {
     SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
 
+    sc->io_ops = &usdhc_mmio_ops;
     sc->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
 
     sdhci_common_class_init(oc, data);
@@ -1955,11 +1948,13 @@ static const MemoryRegionOps sdhci_s3c_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void sdhci_s3c_init(Object *obj)
+static void sdhci_s3c_class_init(ObjectClass *oc, void *data)
 {
-    SDHCIState *s = SYSBUS_SDHCI(obj);
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
 
-    s->io_ops = &sdhci_s3c_mmio_ops;
+    sc->io_ops = &sdhci_s3c_mmio_ops;
+
+    sdhci_common_class_init(oc, data);
 }
 
 static const TypeInfo sdhci_types[] = {
@@ -1981,13 +1976,12 @@ static const TypeInfo sdhci_types[] = {
     {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
-        .instance_init = imx_usdhc_init,
         .class_init = imx_usdhc_class_init,
     },
     {
         .name = TYPE_S3C_SDHCI,
         .parent = TYPE_SYSBUS_SDHCI,
-        .instance_init = sdhci_s3c_init,
+        .class_init = sdhci_s3c_class_init,
     },
 };
 
-- 
2.47.1


