Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DD8D6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 17:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWI3h-0005wE-L3; Thu, 18 Dec 2025 12:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWI3g-0005vK-72
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:45:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWI3e-0002aY-Ob
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:44:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso10659025e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766079897; x=1766684697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tctWGQftDCd4SRsokna4tQvQ0aCHU55DsJ38Y3PUBsk=;
 b=lmZrvaNaVCGeOMdTZ/yIJRmZh5pHTBDqZ1gRpXEJI7jtQTDoWO0UPhxxnSHfwfl999
 YCZyvxsiqntmknvexKour10zBOd2JXfyPyRyFiKQNRctypaYs9Q90Jbgwa3Hdxkj+41r
 4l50b6YowFrupLbaLWzbh72pLFgVCmsPHyNkQtm6+aGHn4V1k/va84Y9I55K0VlpHMxP
 Ot1dz8bOwHXTFY5mIm+O83sHzHzVrmHjHoZnDlY8adHZLMSHVNWFIHKgDzwfRjTUNfCt
 yDgiuCLtdN3cnDHUcTmlJlzFMlgoVLacykESo3kd9Zs33GRNTO9wkytLCceIVyGj0aaZ
 Eoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766079897; x=1766684697;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tctWGQftDCd4SRsokna4tQvQ0aCHU55DsJ38Y3PUBsk=;
 b=TIxc9xsqJNYV9YUX7sPMtU5zbVL5UHT1zydDfBEA9ZNh5OkOYO/5fJCNKQ9Xxiw9Od
 p52eo8QMGxqvX8qgtH5Wmi7PnqyHCtzERVwHHVIyng/pBXZcd5QHgPRPaG+IJmAMOQwV
 KWYjxh3qgEsR7OTBV72Mc8Ox93T7aumfUXh2aQLH+AKLoSfZXM/syaxnDGEXLHgyv6mN
 0hrtQVP7HIv4ad865rWbKDXiXBdBvfKWvHy0i7Khm5kzZ4mOgMzXFDPOAu1h5ygx4m7D
 dKqlPNVepikLl8X+cgD5xm57+PsPqUunBOr1qwpPCyu8mj1qqUeNHX+/4TDTsemho+m2
 8HAQ==
X-Gm-Message-State: AOJu0Yy/MHwgB+INPfcmAEODn/VoQdpipdf0MfhXF6m3dZME6f6FvnYz
 4N5oB4eJOIjuNsb/UttvpjOWw4C7j54IYjDF+0ioC7Bx2b1HJnDk5SK/l0XRM9l08pB8DfgzTDN
 VFqxsz1o=
X-Gm-Gg: AY/fxX58XvKbiBnlUlpePGy06J0vPBgS5pb3dFfAQ3EeIebOD6dwQgguNpAqyRcHJkQ
 u/EOzOMH9+Z66dVT3Xq5BBdGUi6vRb/KiOQb8H3u6f2wmanQPq7JL6rIf34P23NZLD+oi26+mvj
 ykppafDUf2XQJux3hRLqKCPTLUEByMbFH0nxUHffUEWwXgPYsYDGPp2UH/Czf9hgGo70yv9kvOQ
 W+vfzS7ytwyr5qC9kxe/nQ9W/C6TRPxW70fak2zHgl0l2OTp7RisXyxVKymYIRuznieDgRBV6z0
 TBZjURy3TVkgScEDJ8dQ8D9prjLvb0deUrYWeo/sI3VSYqGqdb8WxA2rw7ZIQi6SUqCZGV3efyE
 /2e7EWEr9CxK5qAkHnWNu/MOaqxEJol99RyOxkE8/TuJIARKO1RPomAWr+1s9qA6jy25XHfOdAH
 pEyAULU7ZZpNJVfgyz2qd+ifiRQHbNLZzWAYzq4gOHvR5WXGKRiR+U7KX6f+gI
X-Google-Smtp-Source: AGHT+IHOlFYrVOivb/bqfcGgycqDIu22QHDitbIKgm9W+w47o1zst/eAV4uv5NwHOlO7FwIKABUhFw==
X-Received: by 2002:a05:600c:5307:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-47d18bd546amr4905105e9.10.1766079896898; 
 Thu, 18 Dec 2025 09:44:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2724fe8sm71067265e9.1.2025.12.18.09.44.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 09:44:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm/Kconfig: Have FSL_IMX6UL SoC select IMX_USBPHY
Date: Thu, 18 Dec 2025 18:44:55 +0100
Message-ID: <20251218174455.57451-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 17372bd812d, the SoC used by the mcimx6ul-evk
machine requires the IMX USB PHY component.
As this component is only used by 2 machines, do not select
it by default (it will be automatically  selected when
necessary).

Fixes: 17372bd812d ("hw/arm/fsl-imx6ul: Wire up USB controllers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/Kconfig | 1 +
 hw/usb/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 78775063840..97d747e2062 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -638,6 +638,7 @@ config FSL_IMX6UL
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select IMX_USBPHY
     select WDT_IMX2
     select SDHCI
     select USB_CHIPIDEA
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 69c663be52f..de95686720c 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -132,7 +132,6 @@ config USB_CANOKEY
 
 config IMX_USBPHY
     bool
-    default y
     depends on USB
 
 config USB_DWC3
-- 
2.52.0


