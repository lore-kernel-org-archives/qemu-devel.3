Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4CCC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1sc-0007Wz-Vt; Sat, 08 Mar 2025 16:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rV-0005fN-35
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rQ-0003yC-NQ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso2341525e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469850; x=1742074650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wkzg1rgBZYx7/P9JJbBLn54qiF2GNm1BHKLu67eKlHs=;
 b=LfOix6EkbgcMtvg0buO2uRWw47oAeB5hf+ao8m0pF/qGFlEzxJPN2WIAA4aanR2zsO
 HUZicvWWGGFXAYn27GTYkmznhvH/ClXfnAaC7j7TwgC4QB6jub3VT3dbllqkRVl+S+3y
 WLcq8Y0HvHNOp2g+JZdhm9tjMcdMMns6tdw6qV4y9vX5xM0HtG3n1LRiGxmAHL0xVcLv
 dsiuriK4fweRMnM3Q7q/aUqY7rESwFJnQzF+IpSnbMU3Gx1tSwGH1vnF+IdlinXMtafC
 aVtVRVBDXB2jRiLX/dUAlCXvNJp3FmhL/GV3IX8SVGAT27a0iMAlm3lW4/lQijLvSB3w
 /4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469850; x=1742074650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wkzg1rgBZYx7/P9JJbBLn54qiF2GNm1BHKLu67eKlHs=;
 b=Og0Sfi1o9qMrE4JevB9tXlq13mEw4JaDdUUePF84zZuN26vCCOslAFcMGFYTXNwFSf
 /BoUwebvJNVqwF+CRhJECsai6Fq0Mi6jgBw3qiqd0PeJ5TTVJbm4L0UlALtDyG6LvhSj
 AwIUyfhUMLLAPUdg9HbGuFI18ioJS36FcAhfSDJ9LX3DJJzBbYiqglk1jVGLp6yI4ssg
 otmhPKJjDe3higkYRT8DDQrPc+xW5gjQBd7wV3w7W6+DWE+Dv0WJQJU+63HU6SEDKiHB
 zjUAhm0w+TFQlD2bN/9N5ozuJiThct7bXuUxhdU85LUL9YTPuz0nPk3vAGclNlJyxpJH
 L07w==
X-Gm-Message-State: AOJu0YxnPe2MUu8QGPOD2VOyIqpqLJDzGQlrXiAKSk+UsuKH+W4wUC4D
 7jXyatDY2G0d/UantEeVShf0hmtXTUAYTLaRITfxzTdbUgAdaJmQHkPl3hyIKzQW3OpLaCwKwQL
 nqnM=
X-Gm-Gg: ASbGnctmDUM4G/V8npjre+WkY5Pa7fQQJWA5DuAOaJaiv1YH5mfN15VjMT/U8bSotiS
 VUOVCMY9oamrwVoJPoQ4+RdbSBRh1mIs35OuniIdyPiL+2pzbpQgTgm0zOzHoHWiDyX5GNpLMSV
 TRz18ZbU93F6sFZL/lhaIYtv2C0TJkP5ZfSwtAzFoak7Q624SCMrtVnLwozJH1kFUIYh7I0jkzo
 FCS0yAB9hCP5k2eRqT7v0ZCHbCpxtF3js96lCU1CHKmT7yz8M0xRfjzoROnN40lSZawj9P7bbaG
 wiu6sxqmRoswERSade3+2k/gLB+/g9gzLdr1asiBMvfjIOnXn3gn7SzTClWWq1WAn4GlUy9ltf9
 jCBCV3wySHdLY0Obaoq4=
X-Google-Smtp-Source: AGHT+IFuw5FCfRa6FnlmSvaR2gOW4pYMwDMOuU2LgXEu3jSIuVp/fWAk573TmvtIan3Ax6XdxqIJ8w==
X-Received: by 2002:a05:600c:450f:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-43c687174a1mr51658455e9.29.1741469850402; 
 Sat, 08 Mar 2025 13:37:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce48165c0sm41083115e9.26.2025.03.08.13.37.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 09/14] hw/sd/sdhci: Unify default MemoryRegionOps
Date: Sat,  8 Mar 2025 22:36:35 +0100
Message-ID: <20250308213640.13138-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Note, sdhci_mmio_le_ops[] was missing .impl.access_size = 4.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a2e7162e289..23af3958a1d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1372,30 +1372,22 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
                        value >> shift, value >> shift);
 }
 
-static const MemoryRegionOps sdhci_mmio_le_ops = {
-    .read = sdhci_read,
-    .write = sdhci_write,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-        .unaligned = false
+static const MemoryRegionOps sdhci_mmio_ops[2] = {
+    [0 ... 1] = {
+        .read = sdhci_read,
+        .write = sdhci_write,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+            .unaligned = false
+        },
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps sdhci_mmio_be_ops = {
-    .read = sdhci_read,
-    .write = sdhci_write,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-        .unaligned = false
-    },
-    .endianness = DEVICE_BIG_ENDIAN,
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
@@ -1443,10 +1435,12 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     ERRP_GUARD();
     SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
     const char *class_name = object_get_typename(OBJECT(s));
+    unsigned ops_index;
 
-    s->io_ops = sc->io_ops ?: (s->endianness == DEVICE_BIG_ENDIAN ?
-                               &sdhci_mmio_be_ops : &sdhci_mmio_le_ops);
-    if (s->io_ops->endianness != s->endianness) {
+    ops_index = s->endianness == DEVICE_BIG_ENDIAN ? 1 : 0;
+
+    s->io_ops = sc->io_ops ?: &sdhci_mmio_ops[ops_index];
+    if (s->io_ops->endianness != sdhci_mmio_ops[ops_index].endianness) {
         error_setg(errp, "Invalid endianness for SD controller");
         return;
     }
-- 
2.47.1


