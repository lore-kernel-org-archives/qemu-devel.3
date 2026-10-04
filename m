Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958B7CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKJ-0006os-3v; Sun, 04 Oct 2026 08:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKA-0006i1-CV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:17 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLK4-0007Cu-OV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:13 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so6610375e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116887; x=1791721687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dpeBBEaIpLpaS4+X/utnrrcEJhOGtEKxyNyaVPPXqLg=;
 b=IeWzepzgVGfpc2SqBQgGUxYbmbmS6ikuxnnNmA2laVxHNqwNMnZ0o1o2wNq/TnugbH
 NNUaJ39rfkAKRxPF/9H8Zu+GPv9CVeKMV/OdZB6qcW5UncYeBGLjDp2OGrVDkG8L9Kyd
 HSvBN4wOJyw3CtCc3brUedPOe4aLK55eKEOK3FS5mCzMaF8J2W63I7J5/AgcZ+RgvhFL
 lM2O4xErx3wHlhYzMtwlm38E7KDNsHQwmrprV2neQ2IcEtzKJa4Dj/2S1ErQ7HdOzeB2
 mBu/UVtu8jVCszEk6M+HNiOKTi29ak55dc0+JOijDulOk7hxy7acRlVwl2IRzoPOQr02
 XWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116887; x=1791721687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dpeBBEaIpLpaS4+X/utnrrcEJhOGtEKxyNyaVPPXqLg=;
 b=NQykjL/MKi8zCuBpBAgZT2K0xPN3BZeM5+sK1l9dji0eybU6MmJyM+po4rAoYpLQE9
 Vx9hM5LCHMaXz+ZS7ntS5COKUZqzeNgyUSuSRMNH3rIQM68VKA/T7HG6D4Z81JiSHyAv
 K23IejrThAnD57Rnr1nnzaMFOHNEqt4I/WY8IWHU/xEzWYehQUBnOnivy28TD0RTO0ul
 ttVxvG7/SykIkQuk8Yrw132k2P0J2PZEaH7GM9QDaX77PgQwwy516dXPDDNswVRK7jwt
 /+2K4TOktgKVE76XloJVFMh6XIZM9FRcwdTfFZoVrlv7S6n0TsZd5IhXfR/Z19bLcJ8J
 D/5g==
X-Gm-Message-State: AFuF++nIraTft6F/nEJSBuSt0DLnYC9+WjOFjaVBoTZjVsMHnRZdou+G
 maC0qy5ifXDY4ZDQTQrSOUakHlIyTD+f/cxb8cpfRjmYvmiXDSCaiPp4ZtPTzg==
X-Gm-Gg: AYBFou2cH+IBwkht71WMgK2qJ4TOugTlYfDK79eIbmV7k0yNF6AtSIAHPsSQdqx5XRh
 5IN5OroTkg97FXPAgeACYzZc55AgC+MRMzXoEOhhA5CLbowgGJ9YdH67iW2tH4/7R987mA+CpAa
 qrf62ywXBYGt0JXthSHqRIpgpd/37eFGAwM08tJ5Ysv4NEbBQ6rpEO+3l1ied8SBKKPGtmKuKcg
 ppLFlJ9WXt67oo35p2PjTQrTchxKhX8OHNPzrKlBM5lMOl2zpiChOffOfU4PvkQB56da2LRvCXr
 uQu93wihSBXhugwlVT+u+2j9Z5IOtylTkO86S4JtMYcEKUiSVGH57630/5bX5kxA8lXclfMcm2O
 8zRw4xkVTN1DljeTu0/DvJq7Nx31EH5mahNw5FTLUk3Yuj//YTfrfjlRVFnDHPD+L9kLej9YfH5
 dWUbmXbzmygRZ7RdsBY1GKXP2h7sVAFwrrfGdI/sRDJPJKlyqPT/Npb9Dt0ojsqTOPhj34goz2t
 G09eX7jzzzU6VpJ5Vp9HIDOG/K8buGaQ5jvmQ==
X-Received: by 2002:a05:600c:3e14:b0:49c:fa20:cc00 with SMTP id
 5b1f17b1804b1-4a027585559mr137697865e9.23.1791116887341; 
 Sun, 04 Oct 2026 05:28:07 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:05 -0700 (PDT)
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
Subject: [PATCH v2 21/30] Kconfig: Extract config FSL_IMX{6,
 7}_SRC from config IMX
Date: Sun,  4 Oct 2026 14:26:37 +0200
Message-ID: <20261004122647.3913-22-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


