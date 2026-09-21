Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEA0C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrv-0006Uh-Sx; Mon, 21 Sep 2026 17:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrt-0006SV-0Y
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:09 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrr-0000K2-Cv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:08 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so20229605e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027276; x=1790632076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WmE6TLG9vhIpxo0BssqqWARLSj0eo/b/3Tf9ddxcf4g=;
 b=DDAEm7ZJnXQbIesz+v4BerVB1wwKIU20XMmDH4jq6WCbdUXbu8SyB20u1MqCmxnMTn
 FLu0NOyqPctzTvR8xTR7spjCrSc7FQqw4qLTRUu+UirMMf5mwd/wtoCHGPSsAX0UB58g
 bnau6W5fItvVUOGkUTLzA1cA5hPCEeTUFrIHbNTRH3zFLXYJCqvjwt1JUZ36XpryVWWp
 Q7JPf0gmAAUeBqB2QckAHxFrX+NBqRoLTN7srKJYCuUzrs0kW1X97XUE5fvI6YrRwXzu
 TzNg+MtGFHt5E5r0IczoaiWRgEEmfT5OdgWs1cCERYeEA+ywKBER6mNaXNyKCGpPLLxy
 9qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027276; x=1790632076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WmE6TLG9vhIpxo0BssqqWARLSj0eo/b/3Tf9ddxcf4g=;
 b=D4hBSexaYBRn1uDkW573Eweei2anY2xv3ibbKNMyd8Ee5MYnR7XULIhseJGvLVmTAC
 yaEYf1YFwrMUp1T1tWc+JRGfUMEYgpVrV5Tg2Usnh1jLI3qsQvesKPebb6qPp1/aWAva
 oQ4a5Op/V4GoSTLTcczgw3RPsYMc1CXY0+3gM4IS2l2MhLP8NMT6bWr1tkVpaWGX0utG
 5TFagIy944KT4m6Um56n2tQ89CanGBGExoA0zBCZPqs9NdErwV6zFo0TzGFqRlrpedtS
 iNz6oJ6xFbir6tA4MiiLKUsK0+xJrpm6FP4wCgs0/LWD5wyTfqNeCX8UJYs2Yj63MPAR
 KlfA==
X-Gm-Message-State: AFuF++nPsVztM2I0WpNQCZgwy0Z6ktKQTd0XDlT/9RcyW8Gfz8yS3538
 Q4h8QAZzHjZmCtYpwUPHR1vy65FD6whEKWMF/glTcWwcHThKNeB9NDrm8Ozpow==
X-Gm-Gg: AYBFou14dqsgXRcjSrubQ1xu//+UBTtPhZtEiTE1JTHwhd2ylhciq3x810g9D1RQS/9
 UkyZvKOl8ThiDNemgYJCVOdYbBOtLjr5CQ7X3ZNrXBdwtV3HyKEze5UDh+g3Lf3YhUcO2jrqgTe
 b0vJj5q4oRg1bJZjTap0hdD38oNrowDO9prP3tzEnpu+M2NPnuRBpJr7XgozzOYk5qhSxFfwfwE
 SW9V0ocqBIyd4IQKPlyOYKKGH1TonrLAy2jINHaNv7lFHoWwudzUZybfI3iPJ183dpLS0yPK+El
 KmXPDxMMDXswkPKYFKta0WwH8pnNRz5AMJXbFLDuYik0ycbnaCrbVL1+O3rInN4ghwfPSABZ+eP
 rw6BC5J6RLRBrVMAC5VFEL/hSvMsivp/f6arPiJ1zzU7+gADUaLUhRKWg9tllk6/3E1CcfECoXD
 OQYhJkXaIo3fVByb0md8JFaBhK0YpACI+7vlJvFWxWeoD9J60Wbuxng4DoTNpHQU0iGSn5UMJ2Y
 BHwaXqtYPvFimZLe6ZNnKgTr8j9saCjmMZSVnPx5F7tnFSxhqeSvM8TkCdekrgyJdgTzVxWhsDJ
 9a9w3fm1j/giqg==
X-Received: by 2002:a05:600c:314a:b0:49f:ce73:7aa with SMTP id
 5b1f17b1804b1-49fce730865mr114031595e9.35.1790027275859; 
 Mon, 21 Sep 2026 14:47:55 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:55 -0700 (PDT)
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
Subject: [PATCH 22/42] Kconfig: Extract config IMX_RNG from config IMX
Date: Mon, 21 Sep 2026 23:46:50 +0200
Message-ID: <20260921214710.29422-23-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
config IMX_RNG to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ea4210ccb..1436c05c98 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,6 +482,7 @@ config FSL_IMX25
     select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
+    select IMX_RNG
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d1711433ef..3f17d29053 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -94,6 +94,9 @@ config IMX
     select PTIMER
     select SSI
 
+config IMX_RNG
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9790afa104..61e128ab7a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
+system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
@@ -73,7 +74,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
-  'imx_rngc.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
-- 
2.55.0


