Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D04CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAt-0005mt-UL; Wed, 07 Oct 2026 04:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIUd-0004Wz-FD
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:39:14 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIUX-0000eF-KA
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:38:55 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5ba7ed32ccdso4019205e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791344331; x=1791949131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A5T0Q4tG1KFl/zAm+FMtUPPeNHZC6qNa+VYuFXQeTT8=;
 b=LtNNMJ9NkYOUyDDwflGbEA0eZVVliIo+ra7tSmKXUhj0K3ijb7+xvnhvsTlwfDdgIc
 Say3gk72lPuPYXeXlfXV4nqZweXvShmv8JQXXHOxECUULlYdJltsl1zfWxcnI4ms62Sh
 ZRHVkzfj8uVce4n54+KK8Eh917UfdpqkIwVsI4ya73wRHUT7WrBG6WRd4z+A5H5FcBDh
 JKFZbwgoOR4j/Yvs6So6LS/q1u9bDXEVd9qc7sxUsxZn4DSoKBtoZj/P8WC7L9XFg3a/
 1Mgm78WEL2w57wvGlEqSPr02jpBBeSPnu/TrqOIH+IVldCjuNQgfqpNNwgIh7f8vSE0B
 Zglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344331; x=1791949131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A5T0Q4tG1KFl/zAm+FMtUPPeNHZC6qNa+VYuFXQeTT8=;
 b=osOcsY9J6U89E/A5POa0kwpi7taoTeJ/7pC/9059G+EQBJweOR1OBiN3mIW3wQS/je
 1fRTHKCgm49N76Aue2pn+ozh1PpMhG/IfcyMaOlv/fXnBEQni3yzZKI3X78LQVEy+Sa2
 2w23dZnG53yUCrmwvkdnXiJmZtrXwqRo21Jpf9ckj+7lCGq+RNpmj3XAB0UiMJhM18ey
 9Pff8iIoitBMhvtBL9O/Z6jigPg4KDpdAm2qn1ukhHLuXVuXPnXK6M6wQ2Rs3ChkShYy
 lkVi3XutkqszJ158l0ogCLn2SkAIKD+Esm2DnM8G8iBSHjtXNXghk6zrAPzDN8AWwpHZ
 uv0Q==
X-Gm-Message-State: AFq9FYKXu99oNq3wFTfDaqYMod3Oy/6JwMhmuompk0mgahh8/M1SRp4R
 70j8nqD7QIGlm7TMiL2QqtRX5CXGwmWZQhKf8a5PErakryFDidmehrVvYN2M5A==
X-Gm-Gg: AYBFou2mY6sZsfYkTbke3YjDNH3RdFrPFxnTRoSTjbkMg1o/TJoH5hwgdHbhHwift+T
 3ekblVtOYtniKlubucHDhI8E1r3ZcGKrV58BnFR6Ml8ZxxFJHgEcoVpLeaw/GwQ6LfidkQJDETA
 /dVhyMICT0Nd1Z1cf5Us6UtQAmXt2J7XqKVmWFmVByaMosJjW+Kk//KZdGuoGK78CzX9i0Eww+G
 K4GP3SVpf/QWjP80OTOmVYlHiuMDihGhdHOwwimLuxRltG4FTRI8BTPVK1NlTuX6gvDrNnlAH5m
 mxkdDkEmowSPe7wVG6NEb0tsZ1DNlN4pGTTWpmdGVFflabovLhfwkgjZglIZQQ2pFrVyjh6IHEm
 7fx6RH1PtUg9y8R+FMwsPDOHwZ408l1n/Yb7N1LsNMdCApArUEmSIGtSioKTHHlogFJfTNktLXG
 XA6jxfvoCgsnlPbn+HuGo2QqZ9IwHYwiFnWfNC5GeCcYR5vKgUW4djKz09imJWqBuW8+OhKYlTP
 otNxJA4qqdQZQ8+XcN2LYsPBJJfILQBXfIr7ZRwqxfbefjw
X-Received: by 2002:a05:6000:288f:b0:48b:5e2:52c7 with SMTP id
 ffacd0b85a97d-48c47c66e8amr17784318f8f.8.1791275750847; 
 Tue, 06 Oct 2026 01:35:50 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:50 -0700 (PDT)
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
Subject: [PATCH v4 25/31] Kconfig: Extract config IMX_GPT from config IMX
Date: Tue,  6 Oct 2026 10:34:37 +0200
Message-ID: <20261006083445.30362-26-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x134.google.com
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
config IMX_GPT to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
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


