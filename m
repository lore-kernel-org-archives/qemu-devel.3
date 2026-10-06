Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EED6CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENGP-0003Gc-6t; Wed, 07 Oct 2026 04:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJBw-00033F-L6
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:24:07 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJBt-0000a9-L0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:23:44 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2e5e801487so193879766b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791347018; x=1791951818; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4JrZ7jM3Cirkz5k2sQscGnyc7KzNuKYfGRblsF+5rVQ=;
 b=l1giLQwpfuEB1zMcG+GHnS04zxFIwvg9hoUCfPyCzWr8SHQmgeHW8M/xdP49TMixpZ
 IRXUmXlHOJDPhyzepowKAYGM7iExacJuflAQDtoaxoHxm2L7fI/kuHQl4xlF0LqvOXKn
 /zEKQpZaGGw2RJ0YyQEx2UHJjZZBQk/oz/i82i6Wl/ZkaKeqSXxN0YctBXIXyFpL/FWn
 cGES5NJfE99o8xF78oKUBX6thVU0XjTqPZGtLvJVuUroQ+I1gKdUqoNIq5o7eKejynrh
 rJs/qp9aKO8TBM+MeWzt6nGUCfxo/YQdkfLFgPWxXaraVAHLg1CTufJAYmttsAkTlYKq
 w5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791347018; x=1791951818;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4JrZ7jM3Cirkz5k2sQscGnyc7KzNuKYfGRblsF+5rVQ=;
 b=eIs+POJ0DftMxmOC1I97X3Yd1754TqgaDd9TLdFydj4x3QhOetleDm+sEgNWaiXPT/
 1/ccM96Euz5pnkb5U3k+2wT0+zgKrIeO1ZpJNpRrmXcpccGO5YERhBtz8gl0ZV1rPfgZ
 UhH4EZfplJVNEz/uGtkbhjHT9CBtyG57U/JmTctHI/EGTm1qXcZC54kvoNs3b1Bod8Aq
 AP7f27BU6/GW8ck6RczhwgJBYNaWrYzLORgx5n13kXTvJJ1gwV8X4bAsvF1RiLYX+hxe
 3XY+xhtMtfDcWKNazdghr46Eh+RWlXjwzJJrQTBAdipwEFBXhUuIjbwJgPuw+v3gAnUj
 8e3Q==
X-Gm-Message-State: AFq9FYI9K5noypg/6Vu2dtd4Hah+SzvUKw8YxHfISKD/8t0PeKPBHB9D
 bGVR86yUb9V4FWULlPiqqUnrY3YOI9XTGpUpQEMQqJzKAZA/+iqA0nLUeNGyXg==
X-Gm-Gg: AYBFou3CV+KK5IxJoIkdOgCB4LathCKobw4JS/RNLwN8rPe119uEKBHA2knHXmaamqd
 O6f5poLrTVUOJNCSL+Yq1EjcNEfxmYVhgJso/uCalfc5pn0QQEI2j+FZG7y+6yqxDUxQp3PZBTU
 4VwpeyXRuJ/5Ex0LIvTU1tNOF0QX1ytjNY2R6PrqFy2aiJ/n01d36TSteHTAsSCwM08arOY2iPB
 0vkbOyFizMxrQgWgPSCLrbl1bHFwg2qdjqvgbWM/tHfUMBYYpflVumNUn6mCXT+5vRfKjWVhH7+
 51IClqM0O30xrebAi4BSjG6xxOUakg2gSQ/4w/S/a0HlmIUHrovDLZtJSJwed+ChlpKZlHPoj6G
 u0VJ82IZ8pkaIZNBzz4BrTTj+8P+GBsd+m2kkmszDQj3t+Gob93b9hwlnwQky+xOMwLDT29GMHn
 w9DPGLWiVZXmXZ4r9Zx5070rVoI6VAvrkXqQ2TVyC5XKO/qOmj3K8sVz9c8y91aNW7cyDNvYSua
 Rv49K3673ps6vvoveZxGKBnGZAF/l9tDNn1lHlFAF8+Xe/4
X-Received: by 2002:a05:6000:40df:b0:48c:527e:92e0 with SMTP id
 ffacd0b85a97d-48c6d0ec634mr1664814f8f.8.1791275742958; 
 Tue, 06 Oct 2026 01:35:42 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:42 -0700 (PDT)
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
Subject: [PATCH v4 19/31] Kconfig: Extract config IMX_GPCV2 from config IMX
Date: Tue,  6 Oct 2026 10:34:31 +0200
Message-ID: <20261006083445.30362-20-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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
config IMX_GPCV2 to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 030b218eb6..a33f5a46f9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -581,6 +581,7 @@ config FSL_IMX7
     select PCI
     select IMX
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -661,6 +662,7 @@ config FSL_IMX6UL
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 97355f9df7..98dba7efb8 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -8,6 +8,9 @@ config I8259
 config IMX_AVIC
     bool
 
+config IMX_GPCV2
+    bool
+
 config PL190
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 74d84b8ddc..2ac575095f 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -24,7 +24,7 @@ system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
 system_ss.add(when: 'CONFIG_IMX_AVIC', if_true: files('imx_avic.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpcv2.c'))
+system_ss.add(when: 'CONFIG_IMX_GPCV2', if_true: files('imx_gpcv2.c'))
 system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
-- 
2.56.0


