Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B56C021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASC-0008Oo-KQ; Sun, 23 Feb 2025 06:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASB-0008OR-I7; Sun, 23 Feb 2025 06:47:23 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASA-0005vF-0O; Sun, 23 Feb 2025 06:47:23 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e0b70fb1daso3745564a12.1; 
 Sun, 23 Feb 2025 03:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311239; x=1740916039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taPzlqnqNA89HRzJHV1fOaa3mxJcu/UNcmQ7477fRUY=;
 b=KnB4SRno5QcP6WcJYHs53weqhT9GPJrwH41Yep9RCyAT+2sgWHn06ft0qDu9UAVDm1
 +3lfIuABw+1RF/CIEeKAooERkrDhz0Ypiknk8NktbRqO/TdinNxVpESobKWzo3WYMS70
 LIKRd+fibT3C4AD0zKNJ6ddUBD7hCw85/0Ey74verK2xonA7jgcv/uzoUFTqYFMYuYEI
 iBUcZY6PErIv7QcFzAP2dqUMZjIBrJYXpdn2y8smJ1Euupgy09ZWCt8wi3PWh82OxlaT
 Z/TrVskG/Flm3UAvp7yDy75RdCfLcRzuhrBwBjpAICg7YW/nwVhrGhBr/UX/2uyELMvi
 IQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311239; x=1740916039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=taPzlqnqNA89HRzJHV1fOaa3mxJcu/UNcmQ7477fRUY=;
 b=cLF03E2PMZ6kCdkBKUv5A0751oa1YEhA81Y8T/GRn/HI80ls/cUa+ZCTLa0sklhVkN
 qCZ1u0CvKQibuTN2OVPzKu7imKU86cXdM4OUb2/wP4gZBDWdQPdCt5JrMc74ZVtApri8
 YdLmc5FeRzWhaGXYC1Yrn67fbk+FbLCYAJpl2B1dj/QXlhU1/jLUZNvTfzFudqRQhjEu
 qA4EjLRRYIoumT4iSxi5m/JkNHar6/uhuoKcZyFqd4pkufsqrvvxKEJgqFvkqwRAvzlW
 y4VxTP/bb/AF74nTlPenplD+TyEWaHucZG5XwI2puIQridA1ohQQ6+BcK1wEhwn6tVO7
 5e1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnNfXY03uCxyIugapyi8Xk5zsCbgNOArLPZtpkUFDmaGW7ifkRLastjTMeyRowB6cBXLE4y5UeiA==@nongnu.org
X-Gm-Message-State: AOJu0Yw1eYwXvm93QpDrQOTnsP+7rd6yDDILV7W3iFmspooOjIPJNxrV
 d0NxL+3k6MboyCy5/27eY1RWEpTYvFKv1iaiyt+sCTdwwb9iZiPIXw2Ceg==
X-Gm-Gg: ASbGnctvjgsc9vxy+QMMNGoNQn41ZtlnqWhZKEwIrBGYGbixbkLlDyO8nFLdve9oekZ
 tIhUK2RqctKK3X21TrV35dHq7JfMPllmvoY6h2uMdgmZY2lEWYfOsmvWdeGqr1lucd126TpSjkJ
 IPDsWrLal10Mxsh1NiGPCQmWVZ0fL+yGb2sRKnEltFvMMihSEnrtpvoV4UehxSMKZ7AnUpagxph
 dia0qmm8+3kfe7Cl8ocbZJ/LSXsfsF1eNtx5cfBEch4j4K/X1uSFrCX+cHIEjkV2dozwCDM/MpI
 KSkUQJ9rCdMCMTLoGUcMRigxeBDbL6+oQOJuWEQURQwWeouQoUaL8HfwmYxd0lttgkYASBfYf/U
 OjypPnTqgULQT
X-Google-Smtp-Source: AGHT+IGvSFakl4jeNZ+X6KWbt0gAgsXdNHnC2SnATyth8Hmj8rDI9mE5sjRijGdYAWnBG/yWib163w==
X-Received: by 2002:a17:907:96a5:b0:abb:c647:a4bf with SMTP id
 a640c23a62f3a-abc09ab0c3cmr849771766b.23.1740311239561; 
 Sun, 23 Feb 2025 03:47:19 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:18 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/18] hw/usb/hcd-dwc3: Align global registers size with
 Linux
Date: Sun, 23 Feb 2025 12:46:51 +0100
Message-ID: <20250223114708.1780-2-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

While at it add missing GUSB2RHBCTL register as found in i.MX 8M Plus reference
manual.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/usb/hcd-dwc3.h | 2 +-
 hw/usb/hcd-dwc3.c         | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/usb/hcd-dwc3.h b/include/hw/usb/hcd-dwc3.h
index f752a27e94..dbdf12b21d 100644
--- a/include/hw/usb/hcd-dwc3.h
+++ b/include/hw/usb/hcd-dwc3.h
@@ -35,7 +35,7 @@
 #define USB_DWC3(obj) \
      OBJECT_CHECK(USBDWC3, (obj), TYPE_USB_DWC3)
 
-#define USB_DWC3_R_MAX ((0x530 / 4) + 1)
+#define USB_DWC3_R_MAX (0x600 / 4)
 #define DWC3_SIZE 0x10000
 
 typedef struct USBDWC3 {
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 9ce9ba0b04..0bceee2712 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -343,6 +343,8 @@ REG32(GFLADJ, 0x530)
     FIELD(GFLADJ, GFLADJ_REFCLK_FLADJ, 8, 14)
     FIELD(GFLADJ, GFLADJ_30MHZ_SDBND_SEL, 7, 1)
     FIELD(GFLADJ, GFLADJ_30MHZ, 0, 6)
+REG32(GUSB2RHBCTL, 0x540)
+    FIELD(GUSB2RHBCTL, OVRD_L1TIMEOUT, 0, 4)
 
 #define DWC3_GLOBAL_OFFSET 0xC100
 static void reset_csr(USBDWC3 * s)
@@ -560,6 +562,9 @@ static const RegisterAccessInfo usb_dwc3_regs_info[] = {
         .rsvd = 0x40,
         .ro = 0x400040,
         .unimp = 0xffffffff,
+    },{ .name = "GUSB2RHBCTL",  .addr = A_GUSB2RHBCTL,
+        .rsvd = 0xfffffff0,
+        .unimp = 0xffffffff,
     }
 };
 
-- 
2.48.1


