Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7535C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsUy-0005NM-GL; Tue, 13 Feb 2024 08:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSv-0002A9-Vp
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:53 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSt-0006AI-Af
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:49 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-411d01eb13cso1266395e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829485; x=1708434285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EBc8uaZJKAVMJ0YtC4KyzGDaHMLrSoGEeS2FgFf5YI=;
 b=fH8206m8iLuD4hO9dwpbnjx6tMSfQ1i2HD7xCRbERlqPrEfnLEiRLKyCmDmLVlJ5sO
 yghOEgpYrW/7jTgWj0tvN1mXnTfrjQYyy/nCF21rGwkg+gN7/Jr50wRx2QbyKAxG6B7B
 1qEr4YmP/36CAWCGmNbMtwGwS4RsTN3I2PJzMfP54zVTTRZG2+w6gs+Eir74yLEzkxrW
 t9T9T5qJ7Y7iRzVdP35bQzKwHvqgOUjWB5WGBmdamnp5QdNg4zTjRsNOtfGNdnjqWXUg
 wgqGIhpyOp+wgMFnkfXq+MGJmNTSc8Os6RYfCozzRtPXca0+uNlez2QI6opMz+c+Djhr
 +iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829485; x=1708434285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EBc8uaZJKAVMJ0YtC4KyzGDaHMLrSoGEeS2FgFf5YI=;
 b=s9zxtFWTQLzYeMDC3c/2sj1JzMbHHpmSvpfgSEVdejd2fr1JX5w+kF/D7rYp+JvE5j
 U+6aHR5z2UdWDkk6vutllBw6LBmd7JpoEH5GeiJSP16dCzQEo/kvdLZZ6UO8gZ9aBqIL
 NxqTF1VWq7Fh01cLpCov/wmLYHikWX8eldpsr/Dfu49i0OkGFsG2VcwIrg34xNEaL833
 WBn1p2i8mOFknZPKgh6XKuDL5qMWDGTPU1rf2JATLB9dNQJU9iqm6RsLubtGaW7Qe65w
 +kW9ihducYUaDpMueWp8Ix9ElpFUe8Z1CFPepGXW52ulenP7Z+57GE1qFD8hXoGU7lbM
 57zg==
X-Gm-Message-State: AOJu0YwNLWY+7ttS8G40FBoKwQSzTgwx2d5eFLxQd676uy0nvHh5FjFM
 3alWzKMcBxHD+zprCfI3kqDRRd1wOVZFG/Zv3jEKn/AQEpUfD24QTsLG7qGfXcLG9FURRXovFhh
 z
X-Google-Smtp-Source: AGHT+IFwOiew8TRbbPp78GfrHSHdtr9Mh3ZPSn5mQE0cluQ/J/TOByYxJbzb/cI9R4v3iIqS74XQmQ==
X-Received: by 2002:a05:600c:4f11:b0:40f:ddbb:73ae with SMTP id
 l17-20020a05600c4f1100b0040fddbb73aemr8528462wmq.27.1707829485359; 
 Tue, 13 Feb 2024 05:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXB4Lp6f8xGZoVGZ979xI98mQcdBsW0FVpGL9G6CGGimOTiIwitn5/ww/VWJ1cVnS3DOTx/ienY2QTK7OSFPIjrmgb8KxQobJS8ZbVHDkTXH0CUOIBTwMt1OxK9X6iMyqpaRAfnAEQpYPE25lBdZduB33hotDMfGjeVrSsfDrBE/5nfRrqY7umc72rVSGliocZIdlcjcS3dR/B9pw7yZCSnPhBTvKcBN7vRQKbt7va1J5knyc4k5EykAcrkR37vd880b4M/y9VTz4Zzr6cCjKWsaH/XHdi+t21HFIu0ZVcj9F4rrWPGlIOX107TjXL9O7C/jUaT46FcNTgNswa3ByjoB8y/Svtskn6j9OWKHlM9NvkP4OYJz9WET8poz51UuldTJVFaVi0XiPP5LMTA6lnPw2JPPeUwmjIKMG40cTaO1rNDova/5lwBMgfXKR2S2vdmeFJl2A==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 z15-20020adff1cf000000b0033b44a349e1sm9507995wro.38.2024.02.13.05.04.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v4 09/12] hw/sparc/leon3: Realize GRLIB IRQ controller before
 accessing it
Date: Tue, 13 Feb 2024 14:03:38 +0100
Message-ID: <20240213130341.1793-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/leon3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 2dfb742566..0df5fc949d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -263,10 +263,10 @@ static void leon3_generic_hw_init(MachineState *machine)
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
     qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
                                         env, "pil", 1);
-    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
+    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
+                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
     env->irq_manager = irqmpdev;
     env->qemu_irq_ack = leon3_irq_manager;
     grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
-- 
2.41.0


