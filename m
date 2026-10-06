Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46B2CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMPe-0007y5-AK; Wed, 07 Oct 2026 03:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGqO-0007Lb-9n
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:53:26 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGq9-0002nH-0j
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:53:12 -0400
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6afa6bf3b45so1986535a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337837; x=1791942637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8gZfehfi1SGyoLFE26a+mlEe7gKv2x5zNTED0weiJs=;
 b=aq7x+YJjsRpS2UMiGGGawF8kPyAijID79fepFfjX18hSnbgR0XvZEHZLWrpTtOHusN
 G5KRIvcvZfKjykHc8bfoA8lcA5rf2HIsUvtrTjx4+Oy4/fhiwQ5tQQ80AqBc+Fn/gCe/
 9mH2ywEuT3UeSN6mgrRD6i1gIMvWMEZ3pvHcdsQqnWoFBfI+uF0rTJIf8b7liFhoTD7n
 Cqu0c+5C+/7q4vUJi84xRndUHNGortkP2oE059SvyIFesheXEG5Hz2BV/wuf0eKNkMav
 3TcRvTR/+eTyK32xi0kK+URPI40wcQtwdYtrWZQcwr1M2ZJA3hWyDxntvGZieiyGTDCY
 K2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337837; x=1791942637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j8gZfehfi1SGyoLFE26a+mlEe7gKv2x5zNTED0weiJs=;
 b=KxanWVcUm7JXue6eW4C7PnpHnSGXG29msrSGhP7TDJvdg+jRuZPj8SLzcd+a2lA+5A
 fF+kFjVEipY60k3QyhlNPPpZigxmhBFFf5oPrI20RIIPRPQHKhpbhX1mX+vb1XUfiPfp
 UpwqnAH9KcbqwLTR60vs2ibe81TJbEh4LJLfx9OTYbgxTRmjQlW0fwDOXShAeO0b0pz/
 b7erAuWMGKHlVPmVb9ee7vo5Hinbp3KNg3B5jrYP082osf5JXHKh3ZW+0Q6AYJyEHxkG
 DHntswUpXxtwsYTOV43j3eCNNzX0B1dchAj9sNf7o4fhdJTOSDDBBy/T0LHVdkFAXNEN
 SLDQ==
X-Gm-Message-State: AFq9FYInb4WajA5/TzgPduEosH4bE7MjUHxxN+POacXPOEuwFPBZ2rVi
 GHmAh5VJvx3QO9rMfqvVKPHM+4IqKmEoZVTV4e9ilxi+W1UEHYl6m/mnFFPT5A==
X-Gm-Gg: AYBFou3uvUqnlv8JxUdsscz4x+4W9J2xOcufh3yYpw7ELDzcKnP3obASaEsBaJKAWAt
 hEbK/789Ml3PASOpUcYaG8p8YI9Lrs/EPacvi2tZnvxmYMHbZCmtHQpan0mbFYFmpIgm+MgUvEx
 N+igb1jbV2i9puuG/pqTX/G3YSlOo4GMMI3kx81gyuxFl8mQsa2lapxCJAcuRJTZ8iFd87zCe+k
 +XzjHS22LpFL+pQY1ZFx1RiMCu6mOGu7JAzzGZPoEcSrNezcILdXF5UFoO9//x3zwP8bv7GvZcT
 PZ+qTShQypBYY9HDSE3NPFx2PiXRq5xdLC8OE46xFeguonq4yS4YgziUL7F13uLFW7tSVOHWHPg
 xe+z+rDlZYiweSioauKoT39GcR5/zLWdDgCeI8xS6NZUr56bl7ZQbIh3dWTXMAXhSxj9mbUcLyi
 WtY2UJOOmAcOurMJWBPKVAUsRd3TBIC6U1OkX1kCqltxNuIywb7tgvNmA6W/PsO50AyGxAmFfQh
 wNCmd4S/H8AWkfJNp0n+JBPsIdw9vn0AxwEeqShH3hugxjP
X-Received: by 2002:a05:6000:41c8:b0:48c:490a:3370 with SMTP id
 ffacd0b85a97d-48c6d10c775mr1313824f8f.8.1791275753021; 
 Tue, 06 Oct 2026 01:35:53 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:52 -0700 (PDT)
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
Subject: [PATCH v4 27/31] Kconfig: Extract config GPIO_IMX from config IMX
Date: Tue,  6 Oct 2026 10:34:39 +0200
Message-ID: <20261006083445.30362-28-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.49; envelope-from=shentey@gmail.com;
 helo=mail-ed1-f49.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config GPIO_IMX to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/gpio/Kconfig     | 3 +++
 hw/gpio/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1d3026dea9..c21ad260a1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,6 +480,7 @@ config FSL_IMX25
     depends on TCG && ARM
     imply I2C_DEVICES
     select FSL_IMX25_CCM
+    select GPIO_IMX
     select IMX
     select IMX_AVIC
     select IMX_EPIT
@@ -497,6 +498,7 @@ config FSL_IMX31
     depends on TCG && ARM
     imply I2C_DEVICES
     select FSL_IMX31_CCM
+    select GPIO_IMX
     select SERIAL_MM
     select IMX
     select IMX_AVIC
@@ -514,6 +516,7 @@ config FSL_IMX6
     select FSL_IMX6_CCM
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
+    select GPIO_IMX
     select IMX
     select IMX_EPIT
     select IMX_FEC
@@ -594,6 +597,7 @@ config FSL_IMX7
     select FSL_IMX7_GPR
     select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
+    select GPIO_IMX
     select PCI
     select IMX
     select IMX_FEC
@@ -616,6 +620,7 @@ config FSL_IMX8MP
     select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
+    select GPIO_IMX
     select IMX
     select IMX_FEC
     select IMX_GPT
@@ -643,6 +648,7 @@ config FSL_IMX8MM
     select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
+    select GPIO_IMX
     select IMX
     select IMX_FEC
     select IMX_GPT
@@ -683,6 +689,7 @@ config FSL_IMX6UL
     select FSL_IMX6_SRC
     select FSL_IMX6UL_CCM
     select FSL_IMX7_SNVS
+    select GPIO_IMX
     select IMX
     select IMX6UL_LCDIF
     select IMX_EPIT
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index ea0fb72b40..5ea2c5f427 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -1,6 +1,9 @@
 config PL061
     bool
 
+config GPIO_IMX
+    bool
+
 config GPIO_KEY
     bool
 
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 8ede5e88ae..d60dc42ab3 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -1,3 +1,4 @@
+system_ss.add(when: 'CONFIG_GPIO_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
 system_ss.add(when: 'CONFIG_GPIO_MPC8XXX', if_true: files('mpc8xxx.c'))
 system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
@@ -6,7 +7,6 @@ system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
 system_ss.add(when: 'CONFIG_ZAURUS_SCOOP', if_true: files('zaurus.c'))
 
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
-- 
2.56.0


