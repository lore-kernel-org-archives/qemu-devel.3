Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3882CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLD-0003bE-D7; Tue, 25 Feb 2025 13:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJj-0000JW-U0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJc-0002JI-Is
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43994ef3872so36686995e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506745; x=1741111545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sV2RVYTZrKxLr5vgnAv5zKHjTU7M6/iZgvefjw3/nVQ=;
 b=CFhOXD06aRa6AfeciWsr73HaOEPdKM+Ikkn2p2m7fyYBQFCvRZwo1Dd6Y+AaUGTXj7
 ktX4HSPVyJMW8tdQ8TVS7Izk0tA5DkKRmW7xf9kSS0nOx6lgKkl86nf1zwN2/UaBfV8F
 R7HmTLipBx1Bs/u2mypIuj5/gznsPDL2BJW5BEo80tIkz0FvjKgLO7sbkwjw2MpFy7aI
 C18kxeFhjeIw15xy2wd3kWd1/iCc03ohi7qjUyfAAVeuFugmebk59laE7FQxCHbKP86T
 c4yhor8WvFNbFjeAAjAOEo7gtmFS3WT/0xKWdqN4uefPjSH8z52C9cfKLR+QBXZXF4+u
 cX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506745; x=1741111545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sV2RVYTZrKxLr5vgnAv5zKHjTU7M6/iZgvefjw3/nVQ=;
 b=Sy8nE29EDtCKIZsMo8oJZnz+d7QWbCNnmj5ExHTYe3eKsGR/+KQAYR+t9YaYCQbqCw
 k+s0Hkx7ebvRynNjcFFJpJJ075x+PMBphIwYlY0I8rMf1I0TdLQ5ZXTzjCDKjp7PMEkg
 63yYMYeTEN0dTmqG7X44W4Bes7XhOCFx0bO8itYul/hc85qD9TJE4Lpw6ZFPSnLMQnDz
 m3zpSScCrDGGLsuRER3B2UAvH9WkEybvdwPE7RSPRvqbfD6/s5zJn1zCSKprQEvbv6ry
 2woA4WKQg5oWcFhUWXLfjcwQOci9futmc8FmOO7KylvGyjFyi7HfV2tQFVyaOzyLaqUs
 RSlA==
X-Gm-Message-State: AOJu0YxI4TmA+YK+DeXqmgkY8bUxhNMBl2FM7eu1MeXUQoy0bxaYsnm4
 uXBOvudFYd3qn87rlv1+E8Z9Vexhd26gxvuNtGmtk3kUaIbmt9pDVndkd4zFfNhCTy0dQIUUgTE
 4
X-Gm-Gg: ASbGncuQchkb5EVuQRhTvid5NG04DxweDcObeqrB33f2yuWvvZxan1vAith3Y4Ss60f
 zGwJCCBO4r7973QcqEJi8R5tUoYdi06K1CODIXnLOmheG6YN1hlrgRb2NJzuti1bkDd0PzhAklV
 RfQUAmTMlz+zc/VLhiyfpR0pLBfoQ6nQJS2sIEfxWDd5v2jXSyRK2oF2zQZY13LGFRgdf8wdxgS
 YsorLBSmKi3dC4QoUwmElN6bog7T5NpRiXPGpTCTWGHx5PtkqfzRKcrz6iSvAL5oDjbPrQfN6+L
 7rEfOm8wRJbljnj3dehIGhabgwWZ2AaP
X-Google-Smtp-Source: AGHT+IFglQVxn+M9QFJOtIWr1dMGvGKYgdgf7XQGNEh285aniiz5bGrR3V2AoBtbel5KGKj8TNTMxw==
X-Received: by 2002:a05:600c:3c87:b0:439:930a:58aa with SMTP id
 5b1f17b1804b1-43ab0ecc2f2mr44083615e9.0.1740506745237; 
 Tue, 25 Feb 2025 10:05:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/43] hw/usb/hcd-dwc3: Align global registers size with Linux
Date: Tue, 25 Feb 2025 18:04:54 +0000
Message-ID: <20250225180510.1318207-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

While at it add missing GUSB2RHBCTL register as found in i.MX 8M Plus reference
manual.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-2-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/usb/hcd-dwc3.h | 2 +-
 hw/usb/hcd-dwc3.c         | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/usb/hcd-dwc3.h b/include/hw/usb/hcd-dwc3.h
index f752a27e940..dbdf12b21d7 100644
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
index 9ce9ba0b046..0bceee27128 100644
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
2.43.0


