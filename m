Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E15D2628A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfI-0002lA-00; Tue, 20 Jan 2026 13:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGf5-00024K-Ll
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGf2-0006NQ-3J
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso41051405e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934457; x=1769539257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=71vYPuesJZVL1sHiUiUpnearbClouxECSoF3wg7sPq0=;
 b=ztQ8Yeb52iaOmkGGA3Zk7KP1l9jCfoLpM7JUOMenFMI71QT/sOlx/mXkkZB6vWqqE4
 vCIaj4Ba2DTgE3lpGkh2YRgiW4qaZlK35asds1gf/T12R9RGZrGEQTFxXbfSq4tqWEgg
 JKafXbcrRkhvHf2DhbEFxz7j8geGr5kjdnP0OSTVhSnkBI3XxwKg4/Iy/rm1ku4oUWJE
 cxMWzTN2nc+SzhlhIG8BxP3bOxHkFRNb6q6oQo+0V0o30rU2NYGnufeIFGROTPpiJbEu
 r7kik9MB3QvBOPYNnLq42rB8CWwTVAE3QCWyHMVxiUp8Ko+zmVfBhHEGhzk6Jd+f0Xka
 q0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934457; x=1769539257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=71vYPuesJZVL1sHiUiUpnearbClouxECSoF3wg7sPq0=;
 b=Ifsp9boEKEUSRW0HDIrdlNTpnXcSkdQNHRoDJwE3spJdeyfdZEHWAaoY+REA1DR+g/
 QxctomYDSxJKpx4r0BGCzhvR5t05DoS5ClWQ1o+93PAbasODxqwg7c5FcGetv+7QPUqg
 ML2Li0XtO3LIUelLoLk+/00kIbJisyuUoF4uSyygqL2acQNa3r/b4DdHbKojNlv8tlXG
 1XpTer+2Paqo4hIpiWibWvIYLdqJW7ossMvW+gQkXfMd/Nq8KOGkpCX88EheLHjDmX9w
 /VZzzdqI49mjwZipeptoFswG4/4DnTl9JoUxNrAcwfi2vRNDKMrrx90q2EW3TPFAY8tW
 5HvQ==
X-Gm-Message-State: AOJu0YxW7kdNazvGRGWNK0BULuO3gFvdrp6vYjybFxCmnyX7AgipsGlI
 jAnmuXFCxjTehdZY4zisQ2OJljDyQbIxap+uC21Xc8WyIePjGpNH5N47gFRkaUWl78yqG86UYVi
 qipYPYmE=
X-Gm-Gg: AY/fxX5gLYJzZX95Hg4Z7R9bobHCsMqyLTpDTCN7GMnzqFRc0FQMZZfIGbwSvFmpuJV
 raDdPoDWTpBp4dgtcjyYDM174To+2G1LAx0bjOcFAANpqFGXB6gEeRJr2vhFwFERlDbr9LuwvG6
 0LnzlIJXo9g67M9HeZWSMN5J7cnZu33mBj4W8ir4JmrRJQlotEAhoFXrNg4+JJpi83PJr7GqV66
 pxMb0JQdQ5IYOIhKfo7lVEvQguZ03K5et4nRbP6Pa90CrPJZ/0twhfBWtrer/J5skLu0qj37Eqv
 +UazqXCtwJhASeun42nUq9S4mMahmDlTGzeHc9x7iDzTxtM2WdZ7pQkJyOF9sIF3OY6V94uqVD6
 agd2hvqmaYxxPoyrv92Se+GuvqGnjnOMuPKNezR9+zyZ2QwoxMQmGk+pS51OXmU/XUMp+YciQ/t
 q+MNXGbJ2UWJPh1414eKj4U3nB2If7z5ub3mJNB1Lfl0j9TA2y2klrHEt4lVUC
X-Received: by 2002:a05:600c:628c:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-4801e34e809mr185825535e9.34.1768934456682; 
 Tue, 20 Jan 2026 10:40:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480424a63f2sm1343625e9.6.2026.01.20.10.40.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/29] hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE
Date: Tue, 20 Jan 2026 19:38:49 +0100
Message-ID: <20260120183902.73845-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
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

For now, TYPE_FSL_ESDHC_BE is basically a big-endian variant of
TYPE_IMX_USDHC. It will be used in the e500 machines in the next step which
prevents Linux to flood the console with "mmc0: Internal clock never
stabilised" messages.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-9-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 32962c210d7..3eb0684a890 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -128,6 +128,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
 DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
                          TYPE_SYSBUS_SDHCI)
 
+#define TYPE_FSL_ESDHC_BE "fsl-esdhc-be"
+
 #define TYPE_IMX_USDHC "imx-usdhc"
 
 #define TYPE_S3C_SDHCI "s3c-sdhci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 531dd3c2911..6277abe8702 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1871,6 +1871,32 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     }
 }
 
+static const MemoryRegionOps esdhc_mmio_be_ops = {
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
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsl_esdhc_be_init(Object *obj)
+{
+    SDHCIState *s = SYSBUS_SDHCI(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->io_ops = &esdhc_mmio_be_ops;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    qdev_prop_set_uint8(dev, "sd-spec-version", 2);
+    qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = esdhc_read,
     .write = esdhc_write,
@@ -1965,6 +1991,11 @@ static const TypeInfo sdhci_types[] = {
         .instance_finalize = sdhci_sysbus_finalize,
         .class_init = sdhci_sysbus_class_init,
     },
+    {
+        .name = TYPE_FSL_ESDHC_BE,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = fsl_esdhc_be_init,
+    },
     {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
-- 
2.52.0


