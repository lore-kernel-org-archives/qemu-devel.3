Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A302CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKP-0006vS-NP; Sun, 04 Oct 2026 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKD-0006iI-GG
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKA-0007Dt-0P
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso4678595e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116892; x=1791721692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNfGPgzLrT7RWuT4ZW4d+re5o2OQueGyUin4Nv63jyg=;
 b=R7E1owzFE1Qr8Upm5fdYzuYloTsyk59qKoGVZlTJVeW7YlyFVsmOT2sXyLLPyFRD5H
 MOpcW6v+S97QbyKrajjMS0DZAP9kZrJHV5xQi1rnayF3NW6O6FTP8S1gafTnmbrC2iHc
 7vtpC0MVnWFQe+1rX6cIfRjhfVnxY1zXuQOZAfasFm7F/9xUYpByUpj/fYLw0wxs5DNm
 +54SKjVBR9OW82LKbxxps9r0oGUJqQK9igZxnLd46Oushn2LzkfEjebg7qRiIFrxNjiw
 JKQxTwQoB8sqlZPzHByvd1IQBR7Pvr6ZL8BspzyCSh/LuII+YtaIZTljOJnueTSfAW14
 BjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116892; x=1791721692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YNfGPgzLrT7RWuT4ZW4d+re5o2OQueGyUin4Nv63jyg=;
 b=gahcfiF+n2zg7LiAcIP554PtEQBA9BPLz9cgG4cEVG6OGGpp8sLAGYQWX882eI++VO
 wagxmbWiTDcRBc9jtVxaF9z/BUA+QHyh/1wS6xBZPE1s80r9aVDnCmdwP/qJiO19bGHW
 z0QG/Wh1eEQta/9wvtpRq3Oi9UiW8/PhIq3jC6u2ZMATZmOEtWK3Pg5LB9ohKSE2A7r0
 7cscDmb/pX0Z3HCIw8slagSI58TQYWHh+XzAxoTBe1GEuuYkYdlXbWnHXUcihSFoSSf/
 zLqZj1+guZFcZiG0lw3QAvHYs/ZR8eKwd0oaZ2IAxfcWlm/QYkJCcEAzb1iIeOa5aiSY
 Gi/A==
X-Gm-Message-State: AFuF++kHw0cCdBDn48b2Q1mDExcbJX2xwZm+SIJ2Jvkp8FbNrQD2G6dO
 07iGLzlYXzU1J/vc5N6sLIHJb5DsNLvsntLc3yHv+QbVN3DGL8plgSDGbfLhLg==
X-Gm-Gg: AYBFou04FtwvJ45enVm84N06Quzzd57XpQVHZsKFA2eEkABCVts6wpPti3gZavZtG48
 XISiCzb6JccADlh2euoA42k9S+TmCLNXEIayt0cax1fDyRqNd6YvPk18H9CUh4pXrQi7KOtkQFX
 O4j00nzu5QVz07zkdf/Zo91OzeaW3vfRvfduYXuBD2tqdE0ZrNV9ryG0WTMjgo3EqjH1zh8MygU
 xqRTBNTuRqfTTzhRYFYQtF7pSH31D5625WvaOeiAgkRq+FE0vyzBUIpM6Qjplw+zJVVhGrn4yJp
 G2NmYCYR85bl3YGLlqvY+gqzqQtMZ5MK0qIZJNTviyBXx7ugFRklAPSgyx2bazoFE0dde1gY/nO
 SMA4WfMUNFiRs4EgPqBNf+LI7r2y7/yKSK9HhdsSLYQF+DE9h8Vc8Nk2O/lVRu3CU8bpU2V+BXW
 CEPzK1xswM8biOdTD56LxMr7vQSvsFqilr00A1jl0vHQB5enUf0X55+xHAz3ofBF2GYkIyEfiWU
 6ESVX/AqQCjFvrggwppCUHTRikLWyidrXsd+w==
X-Received: by 2002:a05:600c:5883:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a168101d97mr50310065e9.30.1791116892057; 
 Sun, 04 Oct 2026 05:28:12 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:11 -0700 (PDT)
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
Subject: [PATCH v2 24/30] Kconfig: Extract config IMX_GPT from config IMX
Date: Sun,  4 Oct 2026 14:26:40 +0200
Message-ID: <20261004122647.3913-25-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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
config IMX_GPT to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig       | 7 +++++++
 hw/timer/Kconfig     | 5 +++++
 hw/timer/meson.build | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index dada9f57a7..cb6e7056a5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -483,6 +483,7 @@ config FSL_IMX25
     select IMX
     select IMX_AVIC
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select IMX_RNG
     select USB_CHIPIDEA
@@ -498,6 +499,7 @@ config FSL_IMX31
     select SERIAL_MM
     select IMX
     select IMX_AVIC
+    select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
     select LAN9118
@@ -512,6 +514,7 @@ config FSL_IMX6
     select FSL_IMX7_SNVS
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -592,6 +595,7 @@ config FSL_IMX7
     select IMX
     select IMX_FEC
     select IMX_GPCV2
+    select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -611,6 +615,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -637,6 +642,7 @@ config FSL_IMX8MM
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select OR_IRQ
     select SDHCI
@@ -678,6 +684,7 @@ config FSL_IMX6UL
     select IMX6UL_LCDIF
     select IMX_FEC
     select IMX_GPCV2
+    select IMX_GPT
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1b751a54a..49a4d20e55 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -23,6 +23,11 @@ config I8254
     bool
     depends on ISA_BUS
 
+config IMX_GPT
+    bool
+    depends on IMX_CCM
+    select PTIMER
+
 config ALLWINNER_A10_PIT
     bool
     select PTIMER
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 8323efaf46..477dd47486 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -16,7 +16,7 @@ system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
 system_ss.add(when: 'CONFIG_HPET_C', if_true: files('hpet.c'))
 system_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpt.c'))
+system_ss.add(when: 'CONFIG_IMX_GPT', if_true: files('imx_gpt.c'))
 system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_timer.c'))
-- 
2.56.0


