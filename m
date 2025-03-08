Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694F7C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1sW-00074P-Dj; Sat, 08 Mar 2025 16:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rH-0005bO-NM
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:39 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rE-0003wZ-R3
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:23 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39140bd6317so246487f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469839; x=1742074639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6w2s7vpLMt8PGTRM64NH99KcirJjbualG9t0DnJnfI=;
 b=cyWVjh0z1ZCNvJBY+sgXujX7MvN5vbGkZ6k1fZwzJmzKapkpld6mOoGPYV9owkDRC2
 yysRDLfW6H7aG3N1YzlSYrMD/qxNTNLyNJkBVwBh8eMyQMFdwxFUCKksRXWPBU+BfH3J
 3gEAZGraI5tfpJRtbU7V/jk/mLX/CgO02lY1g7wNNfQs0TVi9/crV+09k7D1GKBka9BK
 bnwxbJgT2rZC2c15jpZKOiNlbaiuA6mVSgP3VBlFWbzWtQ1nIMbTolHUZKuu3IcQl7sj
 u8NwQINJaUi80+fLWZXoLZoZL6V0YocwFm4fwQEk3i+cOTcpJ0zdkQvtRFfrvLnhqpIy
 BrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469839; x=1742074639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6w2s7vpLMt8PGTRM64NH99KcirJjbualG9t0DnJnfI=;
 b=sGF6TSIEbEPJrxACREyNKc8qhyFifWHqHhhsJU7xZPwCgyCZo8B6UJqp0/L4PLvU5e
 1zmH37w+r16bbPn5EeCUFuhVRR//E4MCSAxqEgRvCOxadhA/6+eQdspPvCRyicsSZxTe
 tClCp64qn7eB4sLhCOB7cs2rAcoJrbGvT2ATdc+IDvU+1CZ1s7oZpSjXbVWDQGRGWF2U
 UTqvNO9KiPQxD3Cq/sQqLTzvqZF3HQ6J8nmbTSA82mHl9w+eBzDh8zIv11akOBDVKcql
 X4+sW4e1n9gMLfXYLPoYKCIOOv80o3q93xbl3ArX1Fhk1C/kVrOojFplDINh+17QB/lf
 SCwQ==
X-Gm-Message-State: AOJu0Yxt0xMt0fzpoeDnddifkeb7uW035jReE1zW7i2aMsexSi/T/DWS
 CviFYvRIA2mmWMdYWj7oBLmP3ksYgnOrKyMkMJfT5p3UztA7gTB2916CsLZA9uyjae3Id/kLqXr
 cTA0=
X-Gm-Gg: ASbGncta/Lc/UtvYiH9Xbw2aAWk2VDJ3Oukqe1GqPByuLY5xFRFU8aVYW5PGc4u/4Cs
 w0IYYQ3UJi3Ki5Ur8pZ3E+V1sdf9Vv03PaK34xkL5tzUtPJIlyHHQjtZAaHmT9SHxuMv1ejdNwU
 GHXHiGYs3YvhngPYy0Waz1kY+L8Fc8OMoasdt4cMrKVmi/ISbXMjaED+d9HaBvB9k2EP0Oe+trb
 zPSGWvYG8EtJgtpP1Q1Ll0qG+MhPS5PX12fMmX6J8posjuEB9U7G4vU+3/Sh43ow45abCESxGeC
 5RQDSZ670pLsL9DGjPVu+TKESDlvI3TzD3k8fpYRTSxWR5pf0JlInJtVaThBWkoFMPDwIb67dUf
 VgbgOhdEJD7UHgVc6hQE=
X-Google-Smtp-Source: AGHT+IHd/Cl9BUOitYGQQY6N+ZtglqfA5CZfDE84IrbB5Vxox40pVnN5He/DwpjGmvVlXSE0s7ybNw==
X-Received: by 2002:a5d:5f45:0:b0:38d:d9bd:18a6 with SMTP id
 ffacd0b85a97d-39132dc545dmr4796426f8f.42.1741469839210; 
 Sat, 08 Mar 2025 13:37:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031e3sm9748796f8f.82.2025.03.08.13.37.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:18 -0800 (PST)
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
Subject: [PATCH v4 07/14] hw/sd/sdhci: Allow SDHCI classes to register their
 own MemoryRegionOps
Date: Sat,  8 Mar 2025 22:36:33 +0100
Message-ID: <20250308213640.13138-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
index 637067fef50..ae485f90dfe 100644
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
@@ -1446,6 +1444,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
     const char *class_name = object_get_typename(OBJECT(s));
 
+    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
         /* s->io_ops is little endian by default */
@@ -1889,17 +1888,11 @@ static const MemoryRegionOps usdhc_mmio_ops = {
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
@@ -1956,11 +1949,13 @@ static const MemoryRegionOps sdhci_s3c_mmio_ops = {
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
@@ -1982,13 +1977,12 @@ static const TypeInfo sdhci_types[] = {
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


