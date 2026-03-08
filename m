Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F63EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMlm-0001qm-E6; Sun, 08 Mar 2026 18:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlW-0000zF-CP
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlS-0003ce-Eh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c4a93841so3617255f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009501; x=1773614301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XEPh2xTN7YPEj7nIs4tW6xzkgeZmWy42bG++Vd7IoLs=;
 b=sJS4gWjURQh9tEVLLcJR5lY5w224xRQrEn0+8tWL3kEEYI6utxdUf08dY5MHxh9/Vv
 cmt0QnRUjE0d0ayfuipKO7gMt7hUneu2fNKujxjmQRJ7YqY6o5+QRfvhxa+ajWz/O2o+
 5twUE0tdYsiywFj2kQn1HfoWARih4ZCSsyR3EpNvmNi3e78TtnYP8K59s+10WHGKQlQ8
 KZrAPQzKR1P6KI1tlWSI965OJ8JK30Zhha9M7TuVFK/+xvOCcyzVSlOV1a3xVUfKIYGq
 xRfuJ3L45BXokEsW79n90fGZHI5t/0ROJyTDtjENSSpT5I04zGvJgAmbldIvTVEOSf0X
 W+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009501; x=1773614301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XEPh2xTN7YPEj7nIs4tW6xzkgeZmWy42bG++Vd7IoLs=;
 b=SpsYGGE9D7voHlhrtvSS0Bbs9Egm0+Kdpg+imEBefrelvPXZt64Szxr40vAW6EqAQD
 1mPFFCaIsXexaxc5mvwGSW8rnnBBwFDgh3wvefHpnGxYjlm1lRhSaQ+y/VlgMRRPMnkG
 Q/LZMGw5Z5pCYMW9Gk8nug73unRiE1jLhc7r6/Qn3ek8Fvuw09uuAgzqVN2lMYEi3coj
 hky/7z7zSNY095wFSwHJmXu0blNWk6PNICkwLur5sy+Q6LE2x8YTgrZsOKMD2ubVaLg0
 NAKnyM4cTM6sjqqzE16KPVR5fy9B08PQp7c6n4BBb9zSy4J/tMvX4RGAGBHvYnsRIAIL
 Ir1Q==
X-Gm-Message-State: AOJu0YwdmdNP4vdh9kkuA/k+Q5uQVV015g8CTGPmNkhdLO7043d/b1BG
 ikC55krpEyiKRRNoIttDRHaGEkG//n9lJt6Vu1hCLPtGRRULvg5/IvkJikNu0NqhEuK8nD/ONkC
 brYDbg1I=
X-Gm-Gg: ATEYQzzc5NdybYDaJhVMKmSZNFOEVzEf3dD/i3dOVHRYh+8IN9zIPaYH+QuyuYzSvai
 49SUyHjDfjXo6tz61VMHTvP/QWMdXlLrlPihcWt0FTIXQkLK3G5Oh7E3zxZMXBHHr6aG0gaCICn
 nNAF/AVKV3L6hEsjmA9pV3CmgVVqMkPjflLbtxEbdyP1ajcmxHQpw/XW/Ije8pKd3qonmK2dHPs
 fdbzYruGwwYMxrVXCNA3jIeMCFHRZEuzT4GbB+jHuoPccCLWs+QGb00E2pKeCBZnQw+kjGhCfGn
 BwJgmGnzC3wTziopZP20uphOWLMNS4r/Zxuexgc7wJKi7UjuExp8gAeWv6OIQJQj5Q7MaBUnfKW
 /Teq7XQTwmkRT00tQ2lZZ4GVHlrNuy9DVDg0HTRr/doI533r+zwH5IUVCSf4r/TEsnrQLdD/CvY
 s6IQk+EDMPnhK1LsIIDg+fqX9i4WLczEnEvMjIJeU6uCSZJFxZlnpohEK2EHFroPh39xNlHBcpj
 sTC1A==
X-Received: by 2002:a05:6000:310b:b0:439:bc2b:cb50 with SMTP id
 ffacd0b85a97d-439da348173mr17325899f8f.4.1773009500709; 
 Sun, 08 Mar 2026 15:38:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae57401sm17679188f8f.38.2026.03.08.15.38.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/49] hw/arm/aspeed_ast27x0-{ssp,
 tsp}: Do not access SerialMM internals directly
Date: Sun,  8 Mar 2026 23:34:17 +0100
Message-ID: <20260308223433.25503-34-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

SerialMM inherits from SysBusDevice and exposes the memory region by
means of sysbus_mmio_get_region(). Use that in order to avoid accessing
implementation details of SerialMM.

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260305220911.131508-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_ast27x0-ssp.c | 7 ++++---
 hw/arm/aspeed_ast27x0-tsp.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 9b12ba67430..8b84300e0f6 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
+    MemoryRegion *mr;
     g_autofree char *sdram_name = NULL;
     int i;
 
@@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* UART */
-    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
-                             &s->uart->serial.io, 0,
-                             memory_region_size(&s->uart->serial.io));
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr, 0,
+                             memory_region_size(mr));
     memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
                                 &s->uart_alias);
     /*
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index e39d1dc1712..e7c7b744919 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
+    MemoryRegion *mr;
     g_autofree char *sdram_name = NULL;
     int i;
 
@@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* UART */
-    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
-                             &s->uart->serial.io, 0,
-                             memory_region_size(&s->uart->serial.io));
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr, 0,
+                             memory_region_size(mr));
     memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
                                 &s->uart_alias);
     /*
-- 
2.53.0


