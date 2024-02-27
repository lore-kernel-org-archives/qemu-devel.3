Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CAEC54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret1L-0007HX-US; Tue, 27 Feb 2024 03:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1K-0007FD-KQ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:02 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1I-0007vr-19
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:02 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3e7f7b3d95so447511466b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023258; x=1709628058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZ6f3MtsvPODeQCNs+mWuntTgICcd/owb4II9I6fwgI=;
 b=a8fqtYMqZils9PEkchOrB5mu/ZWfMsy4xsh2wj3HSERIyYi12J+jt2rle2RrNoEhIy
 eDG0/TxObkCvlaaB9h4VgyTOHvgPGe3Ml+s91PyKNfOh05bfOrWbBp/DExiTIhfbqUYH
 WKz8OQ63Ie6OXJiCTp58IuRCb6J4hoxQl1YOeUyxPr0vXZRAkt0p0Eo31MyqTMqy79Ej
 9wf6IIet7J0T8Bewt3DTHFXDi1/2Txtxr79BueKBY9D+b6o0oBr3M0prBC9UwD9vNQVs
 ueI/LJWZA4sORB0U4x/XIP44f0180iRDA1JUUHackNDnLj55/ALdr+vUTPa0a909CEzl
 fQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023258; x=1709628058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZ6f3MtsvPODeQCNs+mWuntTgICcd/owb4II9I6fwgI=;
 b=AHFRwpAoVptSaa4rkCvdPYPm4BPnKYSoiJtFFeBfF36A+he/O6nJ5u3jFCtsoFKasb
 g2yXNCuS651hSLg9u6/QQRKH5oYDAl0gos8diaxBW3x13oUEXEBMcEZuhszweuhQse8r
 PQ8qbmk+aUkqzHwn83/Inj3imiU5TN/Taakl8MrBhuX0rdajswpP2pLOg+NVXrGObGkH
 QRo/3aFQg365W33ZhkVXX/rBD5v+a9sMakF2trDrvRNf7+KEIIk+nUAIcEN3ktCjIdOF
 3MfgfYKjoFV8W5DLLL14TGs6vvYBv+9cTE6tDmc9bqOATBSoM5EE6TmLfOiQ6ebxiwKk
 6XFg==
X-Gm-Message-State: AOJu0YyAdBabvCzXjNZlGuXeIYQoqgI5xEsHqHtFDOKo8IyzJDffX2eB
 pH304qkKXkYlp5u7Ux7mz71lr6Sy/6Z2lFRZu36mYe6ZtcAEymTYuSsTa7mWq11H1pjkURUZXDH
 d
X-Google-Smtp-Source: AGHT+IFFM8SM3fW0I3GKRBmlwgZ3Qzdxdyjlv9vG3FxOdWLCg9KqaWDo1yE3op+x5xE1oXXCw8yYGw==
X-Received: by 2002:a17:906:54b:b0:a43:77c6:e3f3 with SMTP id
 k11-20020a170906054b00b00a4377c6e3f3mr2397043eja.17.1709023258286; 
 Tue, 27 Feb 2024 00:40:58 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 st14-20020a170907c08e00b00a3f5c39bf2asm545546ejc.0.2024.02.27.00.40.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:40:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 11/30] hw/ppc/sam460ex: do not use usb_bus_find()
Date: Tue, 27 Feb 2024 09:39:27 +0100
Message-ID: <20240227083948.5427-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

usb_bus_find() is always used with argument -1; it can be replaced with
a search of the single USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240223124406.234509-3-pbonzini@redhat.com>
[PMD: Fixed style]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/sam460ex.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index a28498f39c..7e34b6c5e0 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -274,6 +274,7 @@ static void sam460ex_init(MachineState *machine)
     DeviceState *uic[4];
     int i;
     PCIBus *pci_bus;
+    USBBus *usb_bus;
     PowerPCCPU *cpu;
     CPUPPCState *env;
     I2CBus *i2c;
@@ -421,8 +422,10 @@ static void sam460ex_init(MachineState *machine)
     sysbus_realize_and_unref(sbdev, &error_fatal);
     sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
     sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(uic[2], 30));
-    usb_create_simple(usb_bus_find(-1), "usb-kbd");
-    usb_create_simple(usb_bus_find(-1), "usb-mouse");
+    usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
+                                                      &error_abort));
+    usb_create_simple(usb_bus, "usb-kbd");
+    usb_create_simple(usb_bus, "usb-mouse");
 
     /* PCIe buses */
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
-- 
2.41.0


