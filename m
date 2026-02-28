Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52A6FEE4EF
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 14:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwL6h-0001BC-LD; Sat, 28 Feb 2026 09:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <johnny1001s000602@gmail.com>)
 id 1vwEPL-0003UM-Sc
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 02:06:36 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <johnny1001s000602@gmail.com>)
 id 1vwEPK-0000Fo-GD
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 02:06:35 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2adc1d9ec56so19461035ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 23:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772262392; x=1772867192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=94kto/7UUYI3pBlCDfVKlf4esEqVWPdkqS7EK14PXXE=;
 b=nSo4CrobpXCdwpRi485UZLVvf8BlTfShp05B5QBR1mxa4INGBHyFOIwvjd1XrR3ckP
 8fs34Dd0XmuSJ4ODyvdRQYWkZyqhU/Umhx9tJg2hz0zOSAFlR9QsM6foM9rS5bJa23jI
 OPtNuYRoF4zo3vcQ6vRD72/gjWex9lbuiBdhJRibI1fkY+od1iSw/2AAlxXFSZkRhRgG
 0Y97j0lb5yeqmprVfr79l/RK8gqY53amObg2YB+64dbGh9z6ePXsAVfb1w0Tmmygy6eN
 kVlUEP/79A0YbZPsYfYSqUNkPl/5yp/k4UQikuZ0d50LSc9MIKAxHrV+KYzBPxB1e4E3
 78NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772262392; x=1772867192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94kto/7UUYI3pBlCDfVKlf4esEqVWPdkqS7EK14PXXE=;
 b=gN6w2Un99DVgbxwi7CjfboVHGTyzjfr4AMbPBionqVo7ExvDxgrsBiCeFLb7/Wg19U
 VXLtbaeOIf/4/Zs3TEHq2soXLKCR3WC8cyEfPOou0UpmIguTi6JjP8U7T46oYaaV949A
 Pn5GJmfEFahJQEhZGN1RYhMqG3h0Y6us32csmVm8FFlUiyflUB44ICrG+b99/X4NRP1J
 lo/UWBX5TIAqp/WZNNacAK5vKekSZKDTD1ysqUg9oUBLsiTlPjfswgll/7tdU6/Wb/NE
 YHG/HmmOb6RpLGfmhbtxhHW/3yyJEhiGFXheNrvLmMQp1uAT7CsASpy6sbeIqbEmcClD
 e9ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbVUx6xLZ+wYfDMsCm9uoAzTN7IUdPwp/YradF2vJFsXoP/11FDrfxIo0m0GcgHpmmKlWsAd4iJPiY@nongnu.org
X-Gm-Message-State: AOJu0Yz3gemKvU4L3pgh5kpwR/GGFmdXsW4BG25ZiNmLhzPd+ZONyCfH
 Hv29E5sj70l/dZ8PHLoFoxijdP/4/jxKKbKLiNc5SFpPxn9x74mhf428
X-Gm-Gg: ATEYQzw6kU5rx5gi/lyLsJKtT/pbt4sgVzenJ7ZbK3z48dD31TLBoUfrLYhGUFJpZdD
 wY6Z6EifTbXMDk9cNqXCzCJR0kSQ8Z9ZArToL3scIE6nkUHK81yWzJgwEIM06lklcdaI8qoqCte
 ZgK8pQ7dagUIbd/5fgQWu1b5RkQsdUEfQLYdOV/jKdhkDEveanoljGDU+weSFDEmwnrekPxwSZ0
 VApiiz5iLBC6A+d7+fewJWLROzbs8NBmOmsn1+4vm3TLGSLH/I1AooG7XAjeXPyoWiazMANL/pJ
 YK9X9MkPhOeb2fRZwdAogYq8U5N7WxRVIDmUTCuf2rNza1+vbEaYaBk4+R5syKABGlFR9t6uM/i
 ump+IJ+hMj5jtUP6lMVCFe735c4lDYa6L/GTQpUnqKfY0rv1IVWIDpu7dHzIHfyhdSRKdAB8AkK
 851dxZF6hdigQuDOFsW6B1fD+Tbxv6C9J4Z4cLnHuGkYb5/wydoHcnBdHaAIjsseImrs37VuNBG
 iA43ljryhNg/dfd8pwcaa1AVVz0AFtSV0YWFIvXRQ==
X-Received: by 2002:a17:902:f689:b0:2ad:ba80:df62 with SMTP id
 d9443c01a7336-2ae2e480d5cmr61816305ad.37.1772262392367; 
 Fri, 27 Feb 2026 23:06:32 -0800 (PST)
Received: from localhost.localdomain (1-174-203-116.dynamic-ip.hinet.net.
 [1.174.203.116]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5dbaafsm106134035ad.36.2026.02.27.23.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 23:06:31 -0800 (PST)
From: Chisheng Chen <johnny1001s000602@gmail.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Chisheng Chen <johnny1001s000602@gmail.com>
Subject: [PATCH] hw/arm: Add missing dependencies for STM32F405 SoC
Date: Sat, 28 Feb 2026 15:06:22 +0800
Message-ID: <20260228070622.2195836-1-johnny1001s000602@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=johnny1001s000602@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 28 Feb 2026 09:15:46 -0500
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

The STM32F405 SoC relies on STM32F2xx peripherals (ADC, SPI, TIMER,
USART) and the unimplemented device (UNIMP). However, they are not
selected in Kconfig. This added these dependencies.

Signed-off-by: Chisheng Chen <johnny1001s000602@gmail.com>
---
When using the following command to configure it and 
enabling `CONFIG_OLIMEX_STM32_H405` in `configs/devices/arm-softmmu/default.mak`,
this problem can be found:
```
$ ./configure --target-list=arm-softmmu --without-default-devices
$ ninja -C build
qemu-system-arm: unknown type 'stm32f2xx-usart'
```

This is because the dependencies were not selected in Kconfig.
---
 hw/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..65fd8607c8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -403,8 +403,13 @@ config STM32F405_SOC
     select ARM_V7M
     select OR_IRQ
     select STM32_RCC
+    select STM32F2XX_ADC
+    select STM32F2XX_SPI
+    select STM32F2XX_TIMER
+    select STM32F2XX_USART
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
+    select UNIMP
 
 config B_L475E_IOT01A
     bool
-- 
2.43.0


