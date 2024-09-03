Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D00ACD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4k-0005M0-3I; Tue, 03 Sep 2024 12:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4i-0005HF-LU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4g-0002ik-OR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8abeso44412905e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379689; x=1725984489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=//18DX/tJu3GZ+9rNZdx8aIF+3uXMvFlCeIlcm3UhX0=;
 b=PSdEA8RA3LImBJX/jC1fHZ0i6jkngFOvM4WNeLCylbzpit7WQZ+XpMd1R7kVd4Jr/j
 n749+1c1qnLgzBWM5fgCj10nJoML+/anzmon1nQqArlvYhAdDNhTnQPhSRtjMdxqQz9c
 XiFRn+8OA5Qw0XvRArHTy4d1hL0avN7pI36zjbW0vFV/QguwV2Zsu3qUBy48YbbX8B79
 U8UyNrlDpVTWystXVk+2iuGk2gs6HO7qY4BjFvH5edgi7/rgZ0fmnA10ZpWBxnmDiVTE
 E/W0oGQyU8myrUC4dTX93/EleO/oUFrF/b3Pr2MyBIW8rEnOkj0ZzTNfhaCA6lhRJMYR
 DgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379689; x=1725984489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//18DX/tJu3GZ+9rNZdx8aIF+3uXMvFlCeIlcm3UhX0=;
 b=nfTvIZzg86OY4p5JxXdEqVqnGQR+JDH6Sjm+xBp6H2Ujrd+GIMKdO7YVCIslEQnWhS
 InTR6DF71L+61P/+rR9lNw7NZpOHDuDwSQvQtsWwtlUS2X/7LSvPNEXQaOy5vnioad48
 6b8ngsvjY4LdCDf69P0BZzSko/x3yoqLr7G2rKgl4R0nPl1Lh7Smv8Zs5FiA+jITpxii
 +Ad1U7Nmo4ro/avPqVxdrcH1PC/DmeEwEq02Cxmx6qn7o43ei3RYklybLvjTa9wmLB+G
 yAGDRjImnyej/zXT6gV5v1Xz3LTg6PKzCMbwa3XGnrpaJMYv583nme5K2gjeo45cAqGS
 qnEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXucuthyBIVa4c8glAkrhdLeJu0cT7/Ar6o9BHFySSAv++rSUZIaAojN+guGLabzkiuT3WBEijVo3+@nongnu.org
X-Gm-Message-State: AOJu0YyJ6XQ1Mo8seSCncZkl4d1mtSuS89l4riAIaKWRVeyJlbOnP61o
 9d7eDbC+zRyxZfmC2iFlonsXJZ4qxd+UyQl8rGP0Lf1tEPi8fUxaVbXcyEMdH3Y=
X-Google-Smtp-Source: AGHT+IFqMio9qStJkNAv9aud9cywxY9GKDwez84n4M/w7xiCB2tc65poFQivjpjJwL2zgNdAVq/SzQ==
X-Received: by 2002:a05:600c:4d97:b0:426:6320:7ddf with SMTP id
 5b1f17b1804b1-42c8dea6913mr8609635e9.35.1725379689187; 
 Tue, 03 Sep 2024 09:08:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:07:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 07/53] hw/arm/KConfig: Replace ZAURUS with ZAURUS_SCOOP
Date: Tue,  3 Sep 2024 17:07:05 +0100
Message-Id: <20240903160751.4100218-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The ZAURUS KConfig symbol used to do multiple things:
 * pull in the tc6393xb display device
 * pull in the Zaurus SCOOP GPIO device
 * pull in hw/block/nand.c code
 * pull in hw/block/ecc.c code
and was used by multiple machine types in the Zaurus family.

Now that we've removed all the Zaurus machine types except
"collie" (which is not currently deprecated), we can simplify
this. "collie" doesn't need any of the above things except
for the SCOOP GPIO device.

Remove the does-lots-of-things ZAURUS KConfig symbol and instead have
collie pull in ZAURUS_SCOOP, a new KConfig symbol which exists only
to control the presence of the SCOOP GPIO device.  Move the
associated source file lines in MAINTAINERS into the Collie
subsection, since this is now its only user.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS         | 4 ++--
 hw/arm/Kconfig      | 7 +------
 hw/gpio/Kconfig     | 3 +++
 hw/gpio/meson.build | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c40f4f91e9c..52bf3a22e01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -926,10 +926,8 @@ S: Odd Fixes
 F: hw/arm/mainstone.c
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
-F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
-F: include/hw/arm/sharpsl.h
 F: docs/system/arm/mainstone.rst
 
 SABRELITE / i.MX6
@@ -968,6 +966,8 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/collie.c
 F: hw/arm/strongarm*
+F: hw/gpio/zaurus.c
+F: include/hw/arm/sharpsl.h
 F: docs/system/arm/collie.rst
 
 Stellaris
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 32c5e601d1c..c8c57497c5b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -300,7 +300,7 @@ config COLLIE
     default y
     depends on TCG && ARM
     select PFLASH_CFI01
-    select ZAURUS  # scoop
+    select ZAURUS_SCOOP
     select STRONGARM
 
 config SX1
@@ -662,11 +662,6 @@ config MSF2
     select SSI
     select UNIMP
 
-config ZAURUS
-    bool
-    select NAND
-    select ECC
-
 config ARMSSE
     bool
     select ARM_V7M
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index c9c340f6eb4..c423e10f59f 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -19,3 +19,6 @@ config STM32L4X5_GPIO
 config PCF8574
     bool
     depends on I2C
+
+config ZAURUS_SCOOP
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 010ad3bf5a7..74840619c01 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -4,7 +4,7 @@ system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
 system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
-system_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
+system_ss.add(when: 'CONFIG_ZAURUS_SCOOP', if_true: files('zaurus.c'))
 
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
-- 
2.34.1


