Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352E2CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfpH-0005Lf-A3; Mon, 05 Oct 2026 06:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfma-0002Jc-Is
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:59 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmY-00011Q-PD
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:56 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so813404f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195533; x=1791800333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5OCQgpKOCMZqorLrJ22HODBlNjDochoy+w5/IJQGaY=;
 b=TcEpnM+HjHUFNWUBJvjAtJA51ho9kkCAGKjye2c+JWHHBRUyb3TkoOWMo6qPbDsSDQ
 4E4VF6W/WrAZORNpZKFQqg4d0pRofdUX0L7QaULVdCkIbx75+eqKFPiFM+9vWF8Kkait
 dTxtOJOQL4r1ROXvN0nDVZl57kYFnBHUfTWchLQMXKXyn+DauYUT0UWMoJkv7dM5NNLk
 7Gm1/E+2nS6qZrhAGdTCjvBDQywdW81JPH3EHySUv7dp9BX3j1SsLFJfZXYW2PyqLVzN
 ABKZHPzQcgDSShhCF64LLgE7WxZGsWEPzwhfFI+0eYo0x+3CYOxK1164QDrCDIXvLTM6
 NjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195533; x=1791800333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5OCQgpKOCMZqorLrJ22HODBlNjDochoy+w5/IJQGaY=;
 b=Zrs2fN8AgFdyAtzb0jPb0VsmF8xAZ1Hl4R7iU/lCQCBEa2zbL/6roGPlx+ymvtTmjr
 U7iGEedrvdQav2psdDSKG78vNj6i3kgJt9LY3lPbmVhmb5ipq2JRlv77qby/tzHGwAil
 cb0tE7Vn1DMK9a+XfiinUniz41pK+01o4JL0dRXUdBdBA/X/cYTP/1cze8jJzAjNIr3l
 b7DYKLdeg3t1690Yr7Px/xAyCJ+sqgRziLcxzb2gjZfnqEr3haWi1fhigpYxhvDYNPJ/
 tAe1jXk0g2iiFqSxyyumuouQQmY7LsAoAV7JsFhpAI2ipQ/1e1zPfWcWiooV8ZZsBYUE
 t6lw==
X-Gm-Message-State: AFq9FYIkfuztN9q6fuu9LJYC+05Eyzc3op+smLODuGqFC5b2eg8OtISu
 +2CpzcIXU5K+rIHZ+T38jHHSB/TZxBJFCY6z90FODGPp5T+xdk9upMdPmT1AIQ==
X-Gm-Gg: AYBFou15Mtz2GYO1Z5Q8S1E2+zBtMmsj0wt4AMiyTbm2+ByO38/jf2tlXRAgh4oSP2V
 sMEIcR5E0Ll+2mlq+2ciH6WAZZSX1PhvMfKCatAprVzOFm1dl7L1FTb93QZBp+CuROE95578ZIP
 bUkW7jdh2FOZVVRSdxSmk8PTkQH834psPcox/jd5qxMCq5DnDzl7SJCS/0FeXyvZFjqbMZnW7xY
 UYESnKLZhIZvlTZ3oeveH6IdZGIYAReLWnM/tuF0tuvpLu9Be7pnaSpd4mov5drm1tqUXpE9eIW
 k4qhDEfojDYVIaw01qtkJbVUXAE38mZKJgetk9sgOUBIWktPTY+sTMDjYmgrbQ/aE9OWRiwQqyx
 7OGsI/JrkMSiRpV/FZIVxo0g3H4OB75EeFjwIg519Y/1Jh+GT78MelvQE0zxWTD0DGIox89U5OJ
 0yCKGJcfedyP5vSQpWB7MhgxCOElWk1sJdQtfDvVL/2JCC6whwsdusvVXYIEZifYhDUx6LqxQER
 Rg1fMDuQ0VmVuv4c4DB0P8Vh3ROJoI8/6dwcA==
X-Received: by 2002:a05:6000:41d2:b0:48c:4ca2:6218 with SMTP id
 ffacd0b85a97d-48c4ca264c9mr9966386f8f.27.1791195532821; 
 Mon, 05 Oct 2026 03:18:52 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 22/31] Kconfig: Extract config FSL_IMX{6,
 7}_SRC from config IMX
Date: Mon,  5 Oct 2026 12:17:49 +0200
Message-ID: <20261005101800.10821-23-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
SoC-specific config FSL_IMX{6,7}_SRC to eventually eliminate config
IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 3 +++
 hw/misc/Kconfig     | 6 ++++++
 hw/misc/meson.build | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 51fa2e2ee4..edd3bf0dc9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -505,6 +505,7 @@ config FSL_IMX6
     imply PCIE_DEVICES
     imply I2C_DEVICES
     select A9MPCORE
+    select FSL_IMX6_SRC
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -580,6 +581,7 @@ config FSL_IMX7
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX7_GPR
+    select FSL_IMX7_SRC
     select PCI
     select IMX
     select IMX_FEC
@@ -661,6 +663,7 @@ config FSL_IMX6UL
     depends on TCG && ARM
     imply I2C_DEVICES
     select A15MPCORE
+    select FSL_IMX6_SRC
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cf9ea68219..193a6b5f56 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,9 +97,15 @@ config IMX
 config IMX_RNG
     bool
 
+config FSL_IMX6_SRC
+    bool
+
 config FSL_IMX7_GPR
     bool
 
+config FSL_IMX7_SRC
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c31c173e5a..477fbd60fa 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -60,7 +60,9 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
@@ -68,10 +70,8 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
   'imx6_ccm.c',
-  'imx6_src.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
-  'imx7_src.c',
   'imx7_snvs.c',
   'imx_ccm.c',
 ))
-- 
2.56.0


