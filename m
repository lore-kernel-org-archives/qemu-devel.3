Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90322C982FC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ls6-0006aW-1b; Mon, 21 Sep 2026 17:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrz-0006Wz-P0
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:15 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrx-0000Lp-Rt
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:15 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso30463325e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027282; x=1790632082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q0D0SdBAUTLEiSi+vwFGwaQwd1A8lOO+KCQvwLvtc3s=;
 b=WvM6l4t8ZaTtkUNbJtvUnteS8E/jwYvQsPZGZhTz8qjDDElWR8lgRSvG4R7Gc1Ckwo
 Bbk355cvR+naq/lAqgAC4Bgfw+6w9LoDYSQG7lz5qR6nm5JG2nhJw0/kb9z2HNBzLKj3
 DvABm8dee3BtEAH14vYCflQRD57OL/nDVfJJSa2lprKCZWSKgGlsls8UEpVQcM8xXDXQ
 4ss1861pCALubyDEGpMPsKn2ShyFMZwHh1w74SO5o4Skc1mSV0jMKZ48kLEzQCT00DNQ
 6nb7ejXiRIqSL2kBTD3PQDJSIa0QykRvsj+Ci9Q/ucp1mLylHwg5L1+bg9yFpPmpI371
 b5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027282; x=1790632082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q0D0SdBAUTLEiSi+vwFGwaQwd1A8lOO+KCQvwLvtc3s=;
 b=s/2awxzA7vKadC8bIj7upLjGiv9FoT0gxJvtvxfgxI6WfcAAstjcNPCif8sy8Iqiwy
 XleXgojMrqdTBDuUvkLSDRTUeIKA4TI9whgroPRZLJ1Ltca7PyLpIvxUYCPoo2iOE1cY
 WCF/lRSRj8SVLdrNWzmnVe/Odb51f0VVRSptuQF3UkpBgvvr8e3EUmw6HvpqAuqCUZXk
 yaqj5ZCVHNb9ABWdTRkPsToE9xwM27FPzxKlB2EQJiC8PlWbUmeQ7a80Tx7+1lxf/Pmu
 BwLyq0Sh8D+BGI6iRU2mzi99u/I2evpDIo1BbZlWAYwLWpk27PwTIspFvlTbyCBBjude
 Sy7A==
X-Gm-Message-State: AFuF++nAnjmhLZ7ND8eNm/v/uckPLHBRsvDAxTbUIAXhdQJCElrXJwTO
 Rq98ynT05xy1PxmC3f9+/HcuUhxm99P1bhz8zeUYqDw7xakMgYdZWgqIjt9knQ==
X-Gm-Gg: AYBFou1udemuzvbaQiYBzIPhfC1Y6AF4lZPt2wCbSh4wxtw8cofTSD4iSJ6EanWCZz+
 mG741k0u4ZVrYLws6e5CDIP96Vfb4SkPHcR20Zy7nlFzANErUYshLeIL2xWIapHmaH9b+F6Lgvv
 UaGRL2tXJTTINVxTqI4UgIXOsc6b/crkJo6sZgDNp9npgmadB6uqyG9pN9SW2LTwqem94Hrxqn8
 +UnHZIWDDWgWEynMopdcJcjg2x+7wZ71taayZ3SqxG2Bwc+hNwrHKVNMVRNcZoiGmtXIJWw9Uou
 lGCrPfFi4mMdPDHlBSDcbBfm1y/qpprDHrlEHuiKUpi6QPWdrE1esdWoLpGJ1/CoZoLzMyTb218
 DbBle96Uu16dfKywRCIMogQxknAPWkjqmzTbjCjCyeKdvt7hX84kRyiACzV9BRA1rh9oz+Orzt2
 dlIMeCpy7HV5cw9JsMILQFw0ZT6faEE1JOhAdS0OTjClHE0cBacu292ZVyw6Bqp5B1DYV4BuSeo
 dz5/RsIHMI0UbMs3SP2iF67gCGFyZ5GB/kpqkX0xgsWcjpnN5zBt0kyHrUJSPQSoIxWjDi6t1k3
 paY=
X-Received: by 2002:a05:600c:6088:b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49fd6f0406cmr36419195e9.19.1790027282211; 
 Mon, 21 Sep 2026 14:48:02 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:01 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 27/42] Kconfig: Extract config IMX_GPT from config IMX
Date: Mon, 21 Sep 2026 23:46:55 +0200
Message-ID: <20260921214710.29422-28-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
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
index 0649417305..e7ed5ea680 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,6 +482,7 @@ config FSL_IMX25
     select IMX
     select IMX_AVIC
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select IMX_RNG
     select USB_CHIPIDEA
@@ -497,6 +498,7 @@ config FSL_IMX31
     select SERIAL_MM
     select IMX
     select IMX_AVIC
+    select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
     select LAN9118
@@ -511,6 +513,7 @@ config FSL_IMX6
     select FSL_IMX7_SNVS
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -591,6 +594,7 @@ config FSL_IMX7
     select IMX
     select IMX_FEC
     select IMX_GPCV2
+    select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -610,6 +614,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -636,6 +641,7 @@ config FSL_IMX8MM
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
2.55.0


