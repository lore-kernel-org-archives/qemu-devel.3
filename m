Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943B8CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwL-0005Ap-4H; Wed, 07 Oct 2026 04:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHkd-0006Ps-CW
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:51:47 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHkP-0004rw-PT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:51:21 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3a20dec69f9so9910731fa.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791341443; x=1791946243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Bx/gBQbJwyEOeNleYcut8SB9gX8DfSUE1/YplwZCUY=;
 b=XBxediMEIS5uyNDdtg0ZgDf9YSkSHoKEqi3niVw0i57R97LU7//iUxK2TWIVayBpGf
 NVI7IhfmZqZ8NJcmCl+0Oxi1Jculugq4o75MJI57y878tGKQ8dYVkd8peJe+uN4WAG1a
 oS2OSw4rHBpUOjmtqS0i2uI+PiUKAQ2NFg3o/HGcvFgUKXVaTFiIEgYlqMrzOe7dFEPI
 mDoQhhluePYuvhwEJLB+xkHBluDp4358LECeSegH0JUtZoISyt4HlBW/8NLfppqPbzEo
 j3cK2JSoVgKDi1AKuUpQQP+U/5k3W68dMctYpgnZNy5wQYVGlHkZ+oeM/jIPCLNYj1FC
 5CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791341443; x=1791946243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Bx/gBQbJwyEOeNleYcut8SB9gX8DfSUE1/YplwZCUY=;
 b=f2nZfgmewUxP+3TFwQPwsdR8M4iWKCwnAz7Q90ntxZG4OhtfA0VkSDFoNz4CygPNPX
 XgMlJpG1qcETMQqgisnhVDgiRHQt4W/LkeRJKXL6Qy8d5QD4mYax8TubRYpPhRhf/VaW
 nKyj9xG82HGkXUg3oqoN5tKbchnt2OFgGtRNbMaa2ajDS2oAKbdxK5KSleqbpV02WSgz
 xIB3iNhrTtR1nBabiT8WI2OapTXfYTywMurO43A4lE45aNq/u6LSQcMFBzwk1N0p087X
 EjhrEZv+rGh3F0GuJaYdVwnfEIoKuBHZXruh4sAL7JOysRVsXt1FYrAK1pBC9GY5jrpg
 ZyXw==
X-Gm-Message-State: AFq9FYKUUSSCX2dM3/KUba31TcL5ijzikqXAPFhOhs1DQaVSknhQ8TOw
 aKLzaMXc2nZDbbaa9O3XQAACFFzjWiP9eI6o4P4eCvxL6RnF/wMos9i2J3OTgw==
X-Gm-Gg: AYBFou03/QkF8QyVCD8U62ED/aVB/qw5VuebBmZo2nVMWK/CnFLPUrC6HI8Cl1UZTHb
 4Jw5dO3lb5+3xfXT2vJ86j9cPeNqTQMzsWrM2HlNfhp0dpVIX4ze7PAa/WJjXmHOCw/lwVlTupS
 x/bkOet/k9a3nlj54RtUOoVCSOB9YqAyvukS8EGQ8uAOLZg4SnnhU7L9Gqfs1vZlvNSEj/+AJUK
 cm9jNEOM/YxUO/8Q9EpbmYTM2TC87s70hPks0a4y5F405pdCKj7PfEFYGWMTd/L5xUR0nOawqHG
 p08oqKvgSYX+Nf5+0lY+/EiWEVNXietX0+k4ElI1mTx449V9RazUeVc9pJ8ZETIs+WsjIarRp4m
 gpWbo00Djg7V+otbaPmgEYpYrOYg9AXdYTVMFQgnVJ3eDRbZBafNdHPExqApsD/Op6JW43ZLS2o
 c9OtRyJv0r66UAczcVZebbhnVXviC9C9pCAoqyapjzLhXBEQxD9c6BhNEMsL3+smtMyuArfgLcq
 MLIP3m7yffx5hxZcZkMPWlcjSVtg0Afz53hdg==
X-Received: by 2002:a5d:5f55:0:b0:48b:5e5:664f with SMTP id
 ffacd0b85a97d-48c6d1a0fcdmr1228114f8f.18.1791275755775; 
 Tue, 06 Oct 2026 01:35:55 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:55 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 29/31] Kconfig: Extract config IMX_SERIAL from config IMX
Date: Tue,  6 Oct 2026 10:34:41 +0200
Message-ID: <20261006083445.30362-30-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_SERIAL to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/char/Kconfig     | 3 +++
 hw/char/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3f502685f4..543220be6b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -488,6 +488,7 @@ config FSL_IMX25
     select IMX_GPT
     select IMX_I2C
     select IMX_RNG
+    select IMX_SERIAL
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
@@ -505,6 +506,7 @@ config FSL_IMX31
     select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select WDT_IMX2
     select LAN9118
 
@@ -522,6 +524,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -605,6 +608,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -627,6 +631,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -656,6 +661,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select SDHCI
@@ -701,6 +707,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..54f9936534 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config IMX_SERIAL
+    bool
+
 config MAX78000_UART
     bool
 
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..65351c39de 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -3,7 +3,7 @@ system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
+system_ss.add(when: 'CONFIG_IMX_SERIAL', if_true: files('imx_serial.c'))
 system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
-- 
2.56.0


