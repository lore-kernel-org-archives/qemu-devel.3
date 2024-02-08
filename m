Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC87C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8uL-0005fh-BK; Thu, 08 Feb 2024 13:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8u6-0005Tx-4E
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:46 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8u3-0006qv-DL
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:41 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so264889a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707416017; x=1708020817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt8SkwfuTwRhmfpWk+aV3Q70u7eITNuY2Qk9HyWSpOY=;
 b=GkEu/7x+LhvgzxvFrsBqg7xz3XLOIbH/ygPjY28GJMXoLCQh6bO52acPOf9bL0yyKj
 vJZauE2fIz6VOSkuwgU65o6cn61M2FZ3yZu/OPfKoRd8Onh4W3rVR0D1Fxo+wIQ72Lsl
 iPNtLBgZkGJrJjElyLNAzXAtJTwXvJCBqkZntuVrlThXccdh5ETmm0mvvP3BANvcj+jL
 kqbKpE7ri3CVm/pvZCj2Hl5OKA9Bvg1WcMS6aN5M1UXDE/5vZrkaHF8lmNrdCAiY9xBy
 gp7yN8dsYZheUaZvw1QOFSFW3xSef9M4B6zxGN/1z+nyOn948Lz82q5X8UyHCSPu2riG
 muTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416017; x=1708020817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bt8SkwfuTwRhmfpWk+aV3Q70u7eITNuY2Qk9HyWSpOY=;
 b=qWm7hbts1FCW7pEWzTyemdtbfikb+hWCdGlcf7HpCr1vl/MaVnGADBAhhOKE4MCNos
 5sRsZ142XjwOZaOcQJjK8ZEQypoK0W5Yt62Ta1eSfG1f0X8UeA8qXyD6PNdMGHBqcM8H
 xM96EdRP/yGjLedY5/uCFLVppAk/cH+U9teJrF0p9zsL4JkchKmWT556YYZgyplYdIUq
 FA5FoJPjY2GUVVXXq2n52azG6iSCzBhtHRMeUBdEfstmft/dpQn+b1il6fsxT5S4SEqh
 LWbgeaG8R3jJyrCoUsEopWqqT/UdyEzapDsWFpEoMenj+6inwywcYrxreDxEAe8yXQmu
 WqIQ==
X-Gm-Message-State: AOJu0Yz/qXQLzLReTvMUOXAKdutknuT+cloQxMFhz7sarIKVFJ38a+0I
 pOwqpJEbYyjOv8tWRpmVwT2CxU3IveW359o3KsRzPZklDNIc1BRWkVcJb/GqUfl1nipeyekFcJT
 G2SU=
X-Google-Smtp-Source: AGHT+IEO9hvP8BoYbCyHzDXzQraYCBWkEIwgd3aORT/MjaRQ6yDlfWlwQOA1/E+meaN/XOHZ1OSlyQ==
X-Received: by 2002:aa7:d8d9:0:b0:55f:6b8:b2fb with SMTP id
 k25-20020aa7d8d9000000b0055f06b8b2fbmr37282eds.1.1707416017744; 
 Thu, 08 Feb 2024 10:13:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUpB0LftIgS+0pSlh5T06px9JNZoGmicjknWgOUCNyXDg3pA9Cl5j1vOEGW0J0cCxOWON2wrXxumcpuuJlDciXXTO17pbGNqwun1BY+A3KhPilgtsdTOSmnpJ/2NwvB90kZ4LnWogY0Mfz1PlLcXc2gz8YN/4pLIZnvq2AD6XXnb7eEoj4Y+FoB+AncOnWHNRhGIEUz1vTejgWw0K89MX9Oz2E/VZkafWyt4e9CNNUzqDt1JO1QEbafSZHyjM2mQiafWzcFIQs5iwa8EPCW8CCZ7MSCciBnca1vQhiGPUwXHJRTVMMS8AHYmizeUJE8rK7SjdhoFqL3EYk1L8C4ykwr9/+0cWrzYuWA9A==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a056402091300b00560dbcd61a8sm1059949edz.94.2024.02.08.10.13.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 08/11] hw/sparc/sun4m: Realize DMA controller before
 accessing it
Date: Thu,  8 Feb 2024 19:12:41 +0100
Message-ID: <20240208181245.96617-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
---
 hw/sparc/sun4m.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e782c8ec7a..d52e6a7213 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -312,13 +312,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     dma = qdev_new(TYPE_SPARC32_DMA);
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
                                    OBJECT(dma), "espdma"));
-    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
 
     esp = SYSBUS_ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
 
     ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
                                  OBJECT(dma), "ledma"));
-    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
 
     lance = SYSBUS_PCNET(object_resolve_path_component(
                          OBJECT(ledma), "lance"));
@@ -332,6 +330,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     }
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
-- 
2.41.0


