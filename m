Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC4CCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfpl-0006DB-Ar; Mon, 05 Oct 2026 06:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmb-0002Jv-QB
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:59 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmZ-00011a-J3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:57 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b059eae96so1359785f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195534; x=1791800334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v1hlWCjEXq2Rpv8CcWewbOeohwMMSFMs5Fi76JDaHOM=;
 b=rL58JzC+A3wcMNlZDabksD+IcFFj08ElLCgk4JBW04G9afLIS7JPqXwPyrbAN3/BKo
 mc6BtsWKNk0PHyhOgWyudeKKSy72QzIWXnI8r5+RrXuL1MYcbkX/Ys4ic60SrEzxdwwi
 ZPbZksbdPvH3JG37Pu2VIA3RsSqyT4a8jgFjGJe2mMZQ/bOJ7vKJpuc+FnFJL6nPzpIp
 d+pQi87o+rDPdezCAtISD1DrHuB7xJOSiR3IKg9Is9Z6die7vs5b+jphwYpQhcalLEgQ
 vpJ9k9RLiuZRclYT72qC4W1elpYjb+JHTDDe4pWqFTCWUHPlunJFaKqEWuRB4xF+NGnX
 Jgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195534; x=1791800334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v1hlWCjEXq2Rpv8CcWewbOeohwMMSFMs5Fi76JDaHOM=;
 b=VPaaMdr0ZYLlKnAMCt2tHsmZqsyPRPCMdWqyIWPkveXXgHursrK27QigS57zIP1Ero
 2MXZVagzVtfDRKRnRjXHOzspQPE0bmwi1LEoCUC3EMcoU3sXgZU8UiaYF04LQfkCF5hI
 ONBiPUOE3MC12hVDt+9ckJXE14J4kCnroUSPKgRL/KS+h6bO6OZfcCs/rj1W8pCzGq1c
 LZ9PdWAHtlIC7cQObTyTH8+hz/zbnJNH7iGVZFEUr4F+zKaUh/JmnMuZ6DWNsg52cFzI
 NazMgbUScMDfWIP53ZtZB/r82nv+NuvrrICgy7Ia+rAroHeOoeNPbUOFvqndmgOOytJ4
 DVNA==
X-Gm-Message-State: AFq9FYKxa16qVaD0F/8b7l9PC3AHVSav4AA7Ha1cI7osgRRVFMvkh/GY
 1XPXLbJp2LZUpkEWbyi9aR28laiY8azns4B/jOPa5O7AI4G1Yg6jW+/XwluIWw==
X-Gm-Gg: AYBFou2fVDOpStDR4wz3Oq1TeqbBzNUH/+zYvMeUttvzfajCuKjkxtqAlC2NLv4W21O
 Z7uHUrOydCi/jIzAEAPq1kP+hHAcyIm3xNdm02WNDojXTYpT5eqxE8Rbvh1DeQ3o0u/10CNjIif
 VESM67bdG9RpgNsarPpXmx+zV6usWhFd6RjC0GWJunAtOeWn9XZO5aolvzjacEAE91ILYt+RF++
 l7ax6dry8rBGo5av1AkfnT5jV3Qm80K8xIbTbuaRKd1F9sxriJ6XNObkrsxjJL6ixqZx6m0hEGX
 42uoItO3GkL4nYDe1QRNas3SC+JtmRhU1iKWs60DYUzMrBknAYtfeosXz61mEGBXqHjPUDVCMji
 CRwkk8ZBP8A03kIVwr6K59EJAdil78IybLKc7WgAUGOBo5zPQ28X3MNLsnU20dB7ljnTKBPJxvH
 svvDIrqdi7M664/aWxakk1p5grh/KzGwbgbI7rIEEjRcLMVA73NrzhKgMEuKROlQv2Bd5xIf9Un
 uh7u52oKPx/6uNsbSS/96NFaKdTdXIAdMXTvQ==
X-Received: by 2002:a05:6000:2f89:b0:48b:3f2:2ecf with SMTP id
 ffacd0b85a97d-48b127473bdmr17300717f8f.55.1791195534198; 
 Mon, 05 Oct 2026 03:18:54 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:53 -0700 (PDT)
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
Subject: [PATCH v3 23/31] Kconfig: Extract config FSL_IMX7_SNVS from config IMX
Date: Mon,  5 Oct 2026 12:17:50 +0200
Message-ID: <20261005101800.10821-24-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0f.google.com
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
config FSL_IMX7_SNVS to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
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


