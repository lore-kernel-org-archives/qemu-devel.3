Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB7CCA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKP-0006vH-LK; Sun, 04 Oct 2026 08:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKA-0006i2-F1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:17 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLK7-0007DV-9o
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:14 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a1681949b8so5327265e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116890; x=1791721690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pKxfRgFun15MKUUFoia+Ctpcx5DOL/22/cmjmXsn+bI=;
 b=ffVWSNKmASuLY73+HO4g8/KoGpz/z2vByRudzPKm/D8MFi8w0IQYsXzW5mdaMApv1b
 PEQDzSRU9ifBhegKSjYeVrqt1LhTrRCRsdB8/l4uPSenbAktwa4KhixzgrWiw07r6nue
 ScYJYV7XyNj6vhwv7UVQHQBC7rK6YVwBi4HUnFZq5onZlODzw2qxR0dfErvsT1+oxK2u
 GZ0zg+hQ8+gWzy1nlbXxPrD6q1HS1VyFUAx/s+IJLCPiIm1T7b3tn3DH+o3D28A822IB
 fGYCMc/ZVVvcf+IbtAClU21DoPhmCYjPBWtNQyHvWl9Q8ipVHuu+Ebk/EtiixZA5MlHL
 OERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116890; x=1791721690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pKxfRgFun15MKUUFoia+Ctpcx5DOL/22/cmjmXsn+bI=;
 b=fdvfR3ztXjrJ2DbQqrF5i6HM/Sg34h7FrH5kT2VsY2X5IYc6RhKnwpTvxDOQR2D0lS
 1gUAVdo5PZk269QRxaUlbw5W5jpBlZX//6dY5XEfyNVoDiozr7WJcYNFDmHPRxrAv7GG
 WwKPxw0S0EgkVHmBHmkxQQ/iqYJ15GGmC+75wjuwiv41aECDhsqlpEb5bJcKs0VnzpZG
 5tFl463omWUsndWJINVr+Zv1qANor9VUdnZ9TwcI00WurSj7Gfi5UN8gE+BD2y0ShkwJ
 YSpSw0bZoNpJMwnhAW0xY/VM9umkGKqs2jLmg8Dc/ZMojxTiBSwaNA0RcVorU9EHLXxp
 nwlA==
X-Gm-Message-State: AFuF++kcq7P1V95NugktSE58RZWHr0Sfo8+QO39xdEprC7Wn6CAX+nEw
 ycDwUwUi46MqAB4Ae6q2FuPsgqtN1n2UsJEydirU+rXKNsGtlg+yZLBUZBCOkA==
X-Gm-Gg: AYBFou2LvLMCsTKxSUy6UomFiNvuTu1OJHKUkU3Qh265njzxNLTxF/+H4yW0GD8KP+E
 wATJRo4PIU7dWJ+vBVyIIRAhqg3PnGb5TWn8sliPwOOFj5tIhaZ+MOFKI+s1JlB4hZT8F82ujUg
 uEYhaDZpoY/Zzs8anbem14mpCxoCOctqHWSPtIkXZeuYUz2jr0Z/hBUWX0h/jYwJq0SNtt8vRC7
 2W1+K6+xlYR19WliZe+lbruzkRd4Kg7Uq049HjK+rYbb6TlwvUZYr1pV5lnB6eovp9w5einmpAR
 kVLTeZ43cVTo2y32BBXZ+JmrMHqR3SK+kvi2sKZm3mtxlpiOFREsEloVyS+52KslR2Gbftk9+2R
 9rNUwm/zKJQVNICnORIPsGUxaEaUCQKMI2WJ95NrCZKUTUEgy5hJzj995pvXpakFy4W0NypANar
 OtwULVfRAmPVkltAcWSl/TEFRFcdVf28WdT/i5EjZbw5xPbPWLtgrTYHB28/pXguuAnGk1CxPWp
 GzfgAW65v2+FbnegxnHSMGN+3wJR7IYgk83ag==
X-Received: by 2002:a05:600c:628c:b0:4a0:1b14:e846 with SMTP id
 5b1f17b1804b1-4a0274d1385mr135838795e9.4.1791116889842; 
 Sun, 04 Oct 2026 05:28:09 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:08 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 22/30] Kconfig: Extract config FSL_IMX7_SNVS from config IMX
Date: Sun,  4 Oct 2026 14:26:38 +0200
Message-ID: <20261004122647.3913-23-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
config FSL_IMX7_SNVS to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 5 +++++
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index edd3bf0dc9..8d857d8bd1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -506,6 +506,7 @@ config FSL_IMX6
     imply I2C_DEVICES
     select A9MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -581,6 +582,7 @@ config FSL_IMX7
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX7_GPR
+    select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
     select PCI
     select IMX
@@ -600,6 +602,7 @@ config FSL_IMX8MP
     imply PCI_DEVICES
     select ARM_GIC
     select CAN_FLEXCAN
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -625,6 +628,7 @@ config FSL_IMX8MM
     imply PCI_DEVICES
     imply I2C_DEVICES
     select ARM_GIC
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -664,6 +668,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 193a6b5f56..4d47de6a02 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -103,6 +103,9 @@ config FSL_IMX6_SRC
 config FSL_IMX7_GPR
     bool
 
+config FSL_IMX7_SNVS
+    bool
+
 config FSL_IMX7_SRC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 477fbd60fa..48c5c20455 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_SNVS', if_true: files('imx7_snvs.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
@@ -72,7 +73,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6_ccm.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
-  'imx7_snvs.c',
   'imx_ccm.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
-- 
2.56.0


