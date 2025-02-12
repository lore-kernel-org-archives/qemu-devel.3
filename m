Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DD9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKMB-0002xU-6R; Wed, 12 Feb 2025 16:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKLt-0002vn-NB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:02 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKLr-0000Sr-VH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:01 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dd91c313bso80696f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739395978; x=1740000778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cF7/nSXhHunM2CJO3C+y1skuY8Xt+xo4KY2S2II5T6U=;
 b=vAPLxtNWrxUhnZ93vbFNKR09GDvIyXTgK4wvt76QEUXHZEgfiSZ4V5U8a8eZ0uVKgo
 kal506VmsyOQYkwDvClacQVfTnRWznxCPfj+hvCeQ18UxnIVZUcolFlJx3NfmFyN+8S7
 axmbiNhBdcLy8wGBcy5sqXYmx0d+w7rXusySw1JCuBZHfHmxSOhROIK6hqNWDoeJRq1m
 kOSd+OZGXkh28wycf6zKUashtcsFh7lyK/5JCXC1+bb4S/z6g/NwKaJfRi6VPotZ0Bbs
 wM6Z+wJTxSuvwS/BZpN8aT9iuDz+o3C7M5anVnkWB9OBX+k+BZnJW7TgTKnkPw+W9tLJ
 FSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739395978; x=1740000778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cF7/nSXhHunM2CJO3C+y1skuY8Xt+xo4KY2S2II5T6U=;
 b=kOpA2+9YBt89feqab6C44MXADKgmmUtEdyaxBwXLZ06TcKl5yBpT47bTTErIam7O+5
 FvRpjx/kmwzBi/xCFDix05Xxq0cEY1oAP/eq5dH2Oda0kt1Z5ZUbGOHQo4vFhtsc5xxr
 BcE3+gaEkxRz2LYrriZ3n+6ftUKj42BDbeGje4WGcwX5jjaeoKBcsfQOiRSSqQ/j1HAn
 2I31waf7cRgBTiSKFljMQ1hjctTOuzuWEnBdEqDyljUoywtrhzZD1O8Sv+tU16EnhGSn
 FOVfp18IrPuL1zh7yMkDZ3h586E37gfPBzm8poWs++z9WqkEgtrEAM31gA04DL2VJQsP
 skGQ==
X-Gm-Message-State: AOJu0YxZ+OGTYxAL+PqIxqxsEbQ4bx4wknhcBaXwdH/i0DShSr2OXuvr
 6tM2vD/IskoihWFBT7fTIiri5ehhvpWgnXNMyWYZNHFFhCbt3JfTtXKumXfyt/1SwXf4zwoY4PO
 RLDo=
X-Gm-Gg: ASbGncvL53Hb9/15LPNvq//EsVLHlah+pmN7EDj9a06vb68WAijSwsZXKZcTh2xnrvO
 J3g1BeGGPSf2/CpwYtlMbqoY33aoWdncTnUvxPrLFAlQYpeuLu+Su2Btt89aqx+PAG+689Ay/eI
 iOmw68+mvOZbGDCuWdIxWWiebHQtaj0imAyjtJsTjXbZUVwGG2oFjFhklNCyVVSMnSM9B9Psltr
 LIbndSGuJYFwu2tpiR7OYPHDmSoThSpo7fFDbzknxGmpIsA5jb6FnGk6tMuC1sKzfS1BHB9/TSe
 k97V6pMxmmOCjclT+D8/9+IpBA6LOBAdBqMRzbawt990aEqZUHEpgQVdydZJpTFHaA==
X-Google-Smtp-Source: AGHT+IH7uHeKNC2IgyI4IpBbzK9o8DFFag2cuF5w8ENeYpyy972A19wiVnY7odD7pCuQHrRnGEayZQ==
X-Received: by 2002:adf:f4c2:0:b0:38d:a910:b4d5 with SMTP id
 ffacd0b85a97d-38dea6050b7mr3593921f8f.54.1739395977959; 
 Wed, 12 Feb 2025 13:32:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccef7sm46800f8f.31.2025.02.12.13.32.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:32:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/19] hw: Declare various const data as 'const'
Date: Wed, 12 Feb 2025 22:32:31 +0100
Message-ID: <20250212213249.45574-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/isa/vt82c686.c     | 2 +-
 hw/rtc/m48t59-isa.c   | 2 +-
 hw/rtc/m48t59.c       | 2 +-
 hw/sensor/tmp421.c    | 2 +-
 hw/usb/hcd-ehci-pci.c | 2 +-
 hw/usb/hcd-uhci.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 6f44b381a5f..43bd67eeef2 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -224,7 +224,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    ViaPMInitInfo *info = data;
+    const ViaPMInitInfo *info = data;
 
     k->realize = via_pm_realize;
     k->config_write = pm_write_config;
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 38bc8dcf100..9c3855a3ef1 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -129,7 +129,7 @@ static void m48txx_isa_class_init(ObjectClass *klass, void *data)
 static void m48txx_isa_concrete_class_init(ObjectClass *klass, void *data)
 {
     M48txxISADeviceClass *u = M48TXX_ISA_CLASS(klass);
-    M48txxInfo *info = data;
+    const M48txxInfo *info = data;
 
     u->info = *info;
 }
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index c9bd6f878fe..3fb2f27d9d1 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -639,7 +639,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
 static void m48txx_sysbus_concrete_class_init(ObjectClass *klass, void *data)
 {
     M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_CLASS(klass);
-    M48txxInfo *info = data;
+    const M48txxInfo *info = data;
 
     u->info = *info;
 }
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 82e604279c5..007f7cd018b 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -68,7 +68,7 @@ struct TMP421State {
 
 struct TMP421Class {
     I2CSlaveClass parent_class;
-    DeviceInfo *dev;
+    const DeviceInfo *dev;
 };
 
 #define TYPE_TMP421 "tmp421-generic"
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index d410c38a8a2..e00316721ac 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -182,7 +182,7 @@ static void ehci_data_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
-    EHCIPCIInfo *i = data;
+    const EHCIPCIInfo *i = data;
 
     k->vendor_id = i->vendor_id;
     k->device_id = i->device_id;
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 8528d493d63..0561a6d801a 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1289,7 +1289,7 @@ void uhci_data_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     UHCIPCIDeviceClass *u = UHCI_CLASS(klass);
-    UHCIInfo *info = data;
+    const UHCIInfo *info = data;
 
     k->realize = info->realize ? info->realize : usb_uhci_common_realize;
     k->exit = info->unplug ? usb_uhci_exit : NULL;
-- 
2.47.1


