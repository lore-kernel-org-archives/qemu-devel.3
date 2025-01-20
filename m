Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA593C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXE-0003sq-6E; Mon, 20 Jan 2025 15:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXA-0003s5-MP; Mon, 20 Jan 2025 15:38:09 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyX9-0002V7-71; Mon, 20 Jan 2025 15:38:08 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso6166361a12.1; 
 Mon, 20 Jan 2025 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405484; x=1738010284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jOntk8sOg2ChUg1XvLiX/w4GfZevL898ZnOuL011M4=;
 b=LPDS1a48foHZvFvdC4jZOF0SOgD4Ebmb6zyqWSD2SqGHuITvV/yss4eh/iLADQVTqc
 7sE1NG+QB+4Lqd5fWyUbWFDxC5KvnkjgbGjlaSyQhJCqPDd5Zj1bnqVKK2o9kYRRs5PI
 hsPn33KJAHYiekIGmm/cLVmv4nmFtjWhY3i7G7VusmmcwmJqLHit0MAZ1u0R27BtPnZl
 aX+VEl9pHM5tJMvsNwZIL1tvrdCQhT8s/1OBxXJ47XbUaO20+pQuaMVmCMoVd/XijBDz
 juQUvSDS7l+cRfmXNYE5M4tyoV+eRgsv0IEwao6ByHPnmqQc9A6m7j8e7c38ToBXi/fh
 DxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405484; x=1738010284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jOntk8sOg2ChUg1XvLiX/w4GfZevL898ZnOuL011M4=;
 b=lljys2F0QOWPflNnlla5DZagTJX+ILgNhK0HwQViYSl347bYv9Um1qCu9DE1NHuQuX
 V8gWyCMSTGiXH4jREk44817PeYpxNzrAajymWFN3JVs+2aYpen+7pIJtcLeV7q0Ihsy4
 nK73lcdsXSEvNnwJDFnMDcIYlKxYqrTNaAfg9AGQywNJXC882EU5WokGDXz1HnOT/A1D
 13ctx7vPBdTRk9CFW2BFw7Qw5wS2TLy/OudTZslqKjbLMGh9EDZ2gyAVG4mGg/6NC2f5
 rX7DBwf6ziMVMUIxw+LtN6sYoDhY0fbM4i3FAm+rL0pJfK1FEIoc7k/g5Yryu1t5ACA3
 ACrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW74Trm8HvSnIFpfUtTg7QmXKNDEFAQLsGnU/gh5vu9qwUpTHlDRko9oAyMwVy9APhFvicBwYktNw==@nongnu.org
X-Gm-Message-State: AOJu0Yw6+fpEhUSdyBXLY04QVe3tsD0OA2q9oTGflJsRdAX2cUMh3ZSA
 0zKPvh9nQXYZwZOrqTWeg2t5vPIIkdkQGRHdm1YZB1Wd6miunTVU5SWVUtTH
X-Gm-Gg: ASbGncuPmX3AuAWsCnu+YpS4C/hX2Ww3Nu9LUxGYlFo9sQBylxg97/ibeRA13cwhg4m
 HjEIJUEmsLawLwRQufTY19QJQ7mDdVM3PaNOHh0Kln0LlfT0lR4WGYbuOSUj8B8O39TcDUxCA3t
 zjx9cuUtJUIGPfK1ScmDmzFhwmOb1tcsSTjGeWfic6EecCtS0wqxTLzaLqcu3oSlS0Rp/B8hMxI
 PRjDPjuFd5p+llpB8FeEB52dQr7WlbzBW8mdKZBnfjnWX1kfyUKwjwGZEhEfgLSH8dSKjjcxWbV
 MWi1dTwvBRI/JXR3gGrrDpYsjHTPB4MccsKOk1l5h0fQr9Z7McsJso072zQT
X-Google-Smtp-Source: AGHT+IHS2HxGT21qGUyd5/VQBAVrySU/uNxFhNcgh0t9HT0fmX0uzdZF8DxtfNXfrkOL68XUAUrw1w==
X-Received: by 2002:a05:6402:2105:b0:5d8:8292:5674 with SMTP id
 4fb4d7f45d1cf-5db7dc69528mr12754971a12.7.1737405483878; 
 Mon, 20 Jan 2025 12:38:03 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:02 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 04/21] hw/usb/hcd-dwc3: Align global registers size with Linux
Date: Mon, 20 Jan 2025 21:37:31 +0100
Message-ID: <20250120203748.4687-5-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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


