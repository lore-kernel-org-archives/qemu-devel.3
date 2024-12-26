Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676CBE7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj91-0007E1-Oc; Thu, 26 Dec 2024 03:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XBJtZwgKCncrpcVjoncbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--wuhaotsh.bounces.google.com>)
 id 1tQj90-0007DS-QS
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:22:58 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XBJtZwgKCncrpcVjoncbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--wuhaotsh.bounces.google.com>)
 id 1tQj8y-0000VI-AW
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:22:58 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2163c2f32fdso125114625ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201373; x=1735806173; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=F8RiAlCHl+1NqI9Hasi2td6dnDjrsz5BjuPhZ1v7pKk=;
 b=ok/qIcwFhWSbgCVsl5FOjkAQqwIvEFePYkj/+ccpRgbIRUI4keCsWTwXaKwnzpQp88
 AECzYVsb8kV5HG28G9Zkg0f7h8h93Pvta25zqHXXVuPE3Hh5eeLnrb+8cYOz84IdyP3E
 O6DNhSQtSefc3OfaOTm8jYcitYrhk3n9+Bxv/FWA1NFqILAQ6RbiJFsMZ+iuaINXQO5Y
 Mk66lE7RAHl1YgZFRtWp6HRy1CWzCLW5UwtOLXA67DDOIFc9+UQIBfEdLYlM1ylWa9e0
 Hah9hAY2yv7J0IFw8rjMhcTz/DH6FF+Z/MZD3q+RdvOGnSHuJVvBjPpavpXOLwZJ0hCv
 +soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201373; x=1735806173;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8RiAlCHl+1NqI9Hasi2td6dnDjrsz5BjuPhZ1v7pKk=;
 b=wbHhWGHCaPGxJJtFyeRq/w/e5P+FJuFIJtNhAtArf4kfXZaIJmvr3GSGY6rkYm9XWp
 4Zfsh69CKGBpG+3jPRL4Id1JrwrDzwf7tD8Y3Mfj5pBcCC+trYCrenf1mqTukX6Ll8DB
 NZfa+7ntzVA+BnAeW5wc38J2GlpjpMDpOZvVPLfQJL9Dp1AY007WHapQo8xKfp+czvK2
 a1PUZGF2D1QRmdeEau8fAaUBo6Fw1EUJwrYcqo/Q4Sv3pM1MbVs4aAceh0j9QAzFpyoS
 O1n58zZjMUFfHnhA0/hzCaM0HvyEbKEnfdWdnaTfBond9n99+WqFqNU9mDe9ndKVLDxk
 j+Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV92bAZlAefGx0zVBea943ZbGjpYsA+JtH8tdU0pYqbpIvZTtpL6nOgcnP7eCMuJbtqTERF9EdGioES@nongnu.org
X-Gm-Message-State: AOJu0Yz/HJmSjAHKJHmlldGyLVs+smZY9pJBW/7JJaT9x/2MTFPhDjaC
 MQU38ZM+WP1HQFCSZZ0uF7Yi+i7weiHIT/olLNzfJZ0b4NWYg2gUjQbOTEb9hdVTEZuUGWiDJfe
 Ke6OyONU1Rg==
X-Google-Smtp-Source: AGHT+IHlzMk/wMahh2Arq+d4lLHpDt1muYa+6Z9UUUfCIvGkHw3kXXzG37dyhHpFVwblDZa0imQ5eVNwUMga3w==
X-Received: from pgbcq8.prod.google.com ([2002:a05:6a02:4088:b0:801:9268:c344])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f682:b0:216:6f1e:5799 with SMTP id
 d9443c01a7336-219e6f14829mr246488525ad.35.1735201372788; 
 Thu, 26 Dec 2024 00:22:52 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:20 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-2-wuhaotsh@google.com>
Subject: [PATCH 01/17] docs/system/arm: Add Description for NPCM8XX SoC
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3XBJtZwgKCncrpcVjoncbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 docs/system/arm/nuvoton.rst | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 05059378e5..0a1916fb99 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -1,12 +1,13 @@
 Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
 =====================================================================================================
 
-The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
+The `Nuvoton iBMC`_ chips are a family of ARM-based SoCs that are
 designed to be used as Baseboard Management Controllers (BMCs) in various
-servers. They all feature one or two ARM Cortex-A9 CPU cores, as well as an
-assortment of peripherals targeted for either Enterprise or Data Center /
-Hyperscale applications. The former is a superset of the latter, so NPCM750 has
-all the peripherals of NPCM730 and more.
+servers. Currently there are two families: NPCM7XX series and
+NPCM8XX series. NPCM7XX series feature one or two ARM Cortex-A9 CPU cores,
+while NPCM8XX feature 4 ARM Cortex-A35 CPU cores. Both series contain a
+different assortment of peripherals targeted for either Enterprise or Data
+Center / Hyperscale applications.
 
 .. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
 
@@ -27,6 +28,8 @@ There are also two more SoCs, NPCM710 and NPCM705, which are single-core
 variants of NPCM750 and NPCM730, respectively. These are currently not
 supported by QEMU.
 
+The NPCM8xx SoC is the successor of the NPCM7xx SoC.
+
 Supported devices
 -----------------
 
@@ -62,6 +65,8 @@ Missing devices
    * System Wake-up Control (SWC)
    * Shared memory (SHM)
    * eSPI slave interface
+   * Block-tranfer interface (8XX only)
+   * Virtual UART (8XX only)
 
  * Ethernet controller (GMAC)
  * USB device (USBD)
@@ -76,6 +81,11 @@ Missing devices
  * Video capture
  * Encoding compression engine
  * Security features
+ * I3C buses (8XX only)
+ * Temperator sensor interface (8XX only)
+ * Virtual UART (8XX only)
+ * Flash monitor (8XX only)
+ * JTAG master (8XX only)
 
 Boot options
 ------------
-- 
2.47.1.613.gc27f4b7a9f-goog


