Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556E8E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Ha-0007Wa-Kz; Sun, 12 Jan 2025 17:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HX-0007Ut-BB
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HU-0006Pp-A9
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so35916795e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720279; x=1737325079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFVPbF7stzQL/SqDLEkr/HWvwoJrRGJFOJxTEnGaiiQ=;
 b=Dw27Pdc1FVbZJcdQb2BULqpE+4etAfeMYvNaUz0dX2mCmYD7/3GGRRhDXHfAEotx4H
 yY59bi5ALHS63H1cPncAPCJ6GORXVSkv1hTj5YsevWVYG0ynXlcSvCdNQ0Gax/OYFnph
 bNHNivPiKaVFDYeFg+FBzO+1Y+H4BlSjeRIyrncPMkTkPiT5N2BLmU+Al0N5LPixaZo8
 4b7c+Ty3YVo/XMmjc13jC7sP3lBtDXMaFsDiFsIRkXBVZUGVPjguMBDlgyNa1zLAI4aT
 k9fUeULqhl4BmD3e7RSZ7K85SGoJHe9WVClVz7Zfe/pTpusD15yzJJ5C8PKKUzM91NO9
 1DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720279; x=1737325079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFVPbF7stzQL/SqDLEkr/HWvwoJrRGJFOJxTEnGaiiQ=;
 b=YVwwW29Lf8FXyR/eJnxsfua+hHXE+1iCGO640nm5YMAr3SOgtPfyzrx2dfrFt4ym07
 TeAiJUCjLSOoPpuAHxykpc1YQXGogtAdZ89xa4WOfkUUOms0G7/kf9IeYU1Ib6EhV7qo
 eKXAqUliIB5KlzzszKHFfmYpjPvKklv6QfUBisR4eoxqMctmKGfWZE8JgpS1KG6qdIzY
 u970P8oz9Ix9FpS/Z14MyHxjoWz+ktikYhFXjZ9uW828r5TKZqKS0ImNF29Rqb84YvSs
 GjR7YY1slFUvUlnh5COrbnuyMoZFebWVy1GKvRw9VKuZ9QW6x3gPaBS4twoaaTEuEIO2
 gx3g==
X-Gm-Message-State: AOJu0YxKVIytNyqg2MK+N1uPpx+b8Dl0ViBImCMD4A7yIq5Hu9Mx1Owb
 EM8cGVY3ylz6f5Z1ztUleLYJBkiXe09NL8YuEkzKS+NT7k4m9TXfVwhPPZSGT7xujUqBrhGaipr
 73SI=
X-Gm-Gg: ASbGncsqF0hriVZAuF+rVsruEfTIpbrM6dbRQVmY9PxU/mdypnka4BrWUN5TLSAyq/W
 97hdQ2d/9hcsSPo4P+5SyJ/kk1ofHhMZsakSsEMgreUP7jOhWLxnBtCUObUGtagOiK+B017E+Nn
 Bnov8Byakzg0J1F+kb+0Fu0EiXhq1yuqStKcUrN/VtvgirPKTXP9reooL1gQLrETb/uh25aUwl7
 uh2jfCdBKoVqoAINsD9E39gXxaoadmm3JLpouA5OLupg35rzjuuecOSToJS4J5FN5PF4K+o3Pa3
 IyNJonBG4Xv+7Y13ySJ84QEutaPu3ls=
X-Google-Smtp-Source: AGHT+IH3dDRlA5jJBRXgYGKX+3TNZCeA3/XT1r74msV8PRnAGUjIjNKMNp2B+NtHwwESA3QRhlfVHQ==
X-Received: by 2002:a05:600c:138d:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-436e26c4a1amr161949855e9.13.1736720279176; 
 Sun, 12 Jan 2025 14:17:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm10823837f8f.10.2025.01.12.14.17.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:17:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/49] hw/usb: Inline usb_new()
Date: Sun, 12 Jan 2025 23:16:42 +0100
Message-ID: <20250112221726.30206-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Inline the 3 uses of usb_new().

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240216110313.17039-11-philmd@linaro.org>
---
 include/hw/usb.h    | 7 +------
 hw/usb/bus.c        | 3 ++-
 hw/usb/dev-serial.c | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index bb778cb844b..e410693d0c6 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -579,11 +579,6 @@ void usb_pcap_init(FILE *fp);
 void usb_pcap_ctrl(USBPacket *p, bool setup);
 void usb_pcap_data(USBPacket *p, bool setup);
 
-static inline USBDevice *usb_new(const char *name)
-{
-    return USB_DEVICE(qdev_new(name));
-}
-
 static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
@@ -591,7 +586,7 @@ static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **er
 
 static inline USBDevice *usb_create_simple(USBBus *bus, const char *name)
 {
-    USBDevice *dev = usb_new(name);
+    USBDevice *dev = USB_DEVICE(qdev_new(name));
 
     usb_realize_and_unref(dev, bus, &error_abort);
     return dev;
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 7e7deaadcaf..f45b82c776d 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -662,7 +662,8 @@ USBDevice *usbdevice_create(const char *driver)
         return NULL;
     }
 
-    dev = f->usbdevice_init ? f->usbdevice_init() : usb_new(f->name);
+    dev = f->usbdevice_init ? f->usbdevice_init()
+                            : USB_DEVICE(qdev_new(f->name));
     if (!dev) {
         error_report("Failed to create USB device '%s'", f->name);
         return NULL;
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index a0821db902f..aa50a92e26f 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -624,7 +624,7 @@ static USBDevice *usb_braille_init(void)
         return NULL;
     }
 
-    dev = usb_new("usb-braille");
+    dev = USB_DEVICE(qdev_new("usb-braille"));
     qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
     return dev;
 }
-- 
2.47.1


