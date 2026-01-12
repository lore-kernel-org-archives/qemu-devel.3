Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239F9C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKE-0008VK-Nj; Mon, 12 Jan 2026 09:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJp-0007px-Dg
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:57 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJj-0001cC-VG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:57 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b86f81d8051so292067666b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229690; x=1768834490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaTAsRHnOdECfannlW8tUPW9PoxsrFLrXmi2zEMp9G8=;
 b=MTQ/2uSc5O9PXCLhD/gtb0LZ8iBdIOX7gECSII7u5tE0k7ai5HnR6pWvnRXENI/sUq
 rYA+xewxih7k+8yQcM2oxt03rayu0lYVo5Akb3mAk14Souxu+yY2u0tDRZQ4sjTnqGFQ
 HVs+77+Xh9Oj7dqbw17fQEhwyQmLZnsgZBiXq4VdGBwEpQeSqLYiulWQDAhA1+Qwiqd7
 T+6QkJeSHpGv9TyIfEOtME6X/Ks+pySwpO2sVZeaoxzOOH5fHipgjx9XeTC8XoGlW5ho
 1QGdQFlmvqudpQX00ae/lSaqbU4RVvaq7U5DdkjQj1Vj+69PsqCWnXEp82tXUj+zRH4s
 GSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229690; x=1768834490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BaTAsRHnOdECfannlW8tUPW9PoxsrFLrXmi2zEMp9G8=;
 b=TqmZ6xSXtSPSq0doZGMUGKGMHumfrnfJH1anwMy7f1GuIJFPqZi4pl1IIzgXmZqIJN
 aogsaAfOCvD0STQKjfY388iXxNbrQPCtwsLJivUbH5f4+/faNI98S9VPyj+IfhEuzYQ2
 DC54dNeKm8i8BCjUQBZiGUdmKF5mcsRG6p4RCNr5BX+y7zPOjyQFRTvux7zf66avVLmR
 qCbqtHmFl+dLVA9QEBJeWtuMcPZzQhTCUJizSnsHjF01uHYHPFw2OjXmOtLHY/InS+Bh
 beBwnaw7I8WbZhhmzGtNTX29JyAj9PRmB5fi6ccZF8TO75mOcq9K4YP8aXMz5jAm+6eX
 OwEQ==
X-Gm-Message-State: AOJu0YxCPQFJMCMD14uhmkvn/GbL4k9gBXV9Mrp5EnAp1ZgLKcHuk6a3
 Fj8JC41/zex5qWltxBi0ICsSexOmGIujom9SSoUdms9EKxFYluls+jiWao/u7Xnt
X-Gm-Gg: AY/fxX5PPBpZZOV1/SdqHX7of6FM+l9o776aAzbTaUHVmxHoxFatW9s9irjHE7RKI95
 J6/JpALewa8HjR1dAnV9e+d7V5ZaGZ9Kr8DxBAFA2itrKa0zG8OdU4fmoZskjibtYovRXbdiyIx
 rWbizfcp+fzbSv0GcuSmiLY+hOMt6Q2uD3oxwgdN8WjqTZuz63eW1d0k5VsKSps/3WLo8YSdfOk
 I16tT0U3xSOTxQnMTY/j/R3FOfA8At95jMvfs9I/CeAgZTlELkhqjmLWMvZemmvfUTkA0uzOwPY
 hc7mxCFx4bDOXfUdOXUUv7ngPRo9dKzxiEn+AFlsE9JuaKjFbGwnKXf6OQmhazuF88kb7ZT+S1q
 g/GC2TDFzIb4+5YS3+uY0ShByQ7c0sgJ+hsh2TTh3yqFJAogGd3NLGq6jrkJknZuE+fcSSumkq5
 dpuMzyIh2WELd0TxJzbVsMnXRXL5VgwCJySzlo2E0w+e5sPb6DjVuGjfpbOwBruQ38PEarhoZa
X-Google-Smtp-Source: AGHT+IEz8v3qcfC80squY01h4UmdnPHp3L38lnKYF+Tv3/pLx9Cjve+BGkNsM/QhYpadj5iIGsRm/Q==
X-Received: by 2002:a17:907:3d11:b0:b80:3fb7:8e68 with SMTP id
 a640c23a62f3a-b84299be630mr2295540766b.21.1768229690028; 
 Mon, 12 Jan 2026 06:54:50 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:49 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 12/14] hw/sd/sdhci: Add uSDHC-specific quirk
Date: Mon, 12 Jan 2026 15:54:16 +0100
Message-ID: <20260112145418.220506-13-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This quirk is required for imx8mp-evk to boot via u-boot successfully.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index eab814096d..3b0a26ef53 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1892,9 +1892,33 @@ static void fsl_esdhc_le_init(Object *obj)
     qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
 }
 
+static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    if (offset == SDHC_CLKCON) {
+        /* we force the reset value of the lower nibble since QEMU alters it */
+        return esdhc_read(opaque, offset, size) | 0xf;
+    }
+
+    return esdhc_read(opaque, offset, size);
+}
+
+static void usdhc_write(void *opaque, hwaddr offset, uint64_t val,
+                        unsigned size)
+{
+    if (offset == SDHC_CLKCON) {
+        if ((val & 0xf) != 1) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: SYS_CTRL[3..0] shall always be written as 0xf",
+                          DEVICE(opaque)->canonical_path);
+        }
+    }
+
+    esdhc_write(opaque, offset, val, size);
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
-    .read = esdhc_read,
-    .write = esdhc_write,
+    .read = usdhc_read,
+    .write = usdhc_write,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
-- 
2.52.0


