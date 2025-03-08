Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B58C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzS8-0007GP-9l; Sat, 08 Mar 2025 14:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzS1-000788-VT
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRz-0003ar-Rs
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bd5644de8so31823975e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460586; x=1742065386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74sWG9go8/U3pCHdLat3DJreQSt1Fc2X0U97u54k3uc=;
 b=gkeA2RAP1Be6Z5+Y1egFLwYOde6qzbPy1UJKtM0F7K8Qd0iReidEANQMMyQlwSKEX5
 hQCUmVczZPu9XqeWb4vTZvXCl1AYVdUhJhzPKT8/2Ug4CUjahddCosY6sUsrqTknslud
 u/NjvNCUioyAuenkcWSUTT/v0y0Z9O1ohBFgmK0u3m+875OiaDYWX46UQOMD0zRsoj+N
 9DXfwWvOCleWwS46x+AsWhJRkMIoOTTaVKtDfIT3Lk2uuGO6Q4CYQgk0VcsOpVEx1lYw
 /Sfb5FZmcVpCq7q6yuB0vcG0tqRl5ZN5/P1+hX+EavqZgix28Sle+BOCxlFtkpwfN2A5
 LHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460586; x=1742065386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74sWG9go8/U3pCHdLat3DJreQSt1Fc2X0U97u54k3uc=;
 b=cLH2qnAWdtufu4x6/WkqspIqUqDSPCLr0CcKPTyukCvlRyFllLS4zRQuUNyewv9CK7
 vIGxavPMxhIqxBJ6qBOtovYGAYOClYR1+mpb2ViWBe8ICdr7lnBHZHLszRXi99Gjfpw1
 OugRHzeTF5Aqk5rhDFOYzNzTG3+N0VYua+RY8J7B8BOtXxT8gbmelEJy/LuIh384yRwK
 sY/NhRXvGkwaDVCBejnl7FhVkCouV3SS/fbyxpz/bcMj3EHKXtiXq6qLNp6UuRHYMh7q
 aL6nlBln0U8KTQuF586rxy0QcFMJoQXcZzJAofh5NDxpaJaWCpnrHUTZp1kUVXoaJWRV
 XmDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo724xjw+lU+js8iokyFc0V5dGLo1CQPn2yS79RcJxsnnC1xs79aJOPZ1aQOz4XgMCPsLJBjSZjWCy@nongnu.org
X-Gm-Message-State: AOJu0YyRLvS19sQCTji/I8AMvl4hMt/gX9nH0GLpPei7fgKG+jz2Sh6i
 7/ZBtzvjSckFrPKn3bN5wat909lbaa8FFc1tTPo410n4ggitYV9k31itzRt6yE0=
X-Gm-Gg: ASbGnct59PE2Y8kGsajxmKhQx65Gf3IoroOMvL+iqfYEMuQD2T9fGHp+dSb0GK1mcjd
 M4p0nDhuDY2+LZpKJkZwUbg8QVa8yygJKFN6P/fZ1pBUrs+ZU6V1lnZH/4ydgf+NCjvYQXdTiz6
 K4Lf9sCiJU2nLACDjmgsWbW30skueusCMmRKSusci6hqgFk4MNRb/aM++0QLN51f0TmOWIZxYGU
 wnBMpNcMka+CIS0LwcgrH68BG/TAzYWkuJIFUNgnZjBJY7MdvL0k5vvPf3En/81ruObTQOUJQ/a
 mtpcs+sA+WubSYIoDLe7WciS6FX+b+NqT7Dss29DMU+qo17Z4m34EdNhZ55JILI001/J438WTDC
 g4ujUkKquDiAMhfQ6Eno=
X-Google-Smtp-Source: AGHT+IFOi81II2YxY7SDRztPqxmgtCilTx+dPRaviIBhfB7iXhMcCrE/Afa3y5Pl9MP2HqBQ1cIM4g==
X-Received: by 2002:a05:600c:3544:b0:43b:d6ec:3d57 with SMTP id
 5b1f17b1804b1-43c601cfe21mr66427045e9.15.1741460586266; 
 Sat, 08 Mar 2025 11:03:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cec8e1596sm17687745e9.31.2025.03.08.11.03.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:03:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/12] hw/sd/sdhci: Simplify MemoryRegionOps endianness
 check
Date: Sat,  8 Mar 2025 20:02:25 +0100
Message-ID: <20250308190230.7508-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

While little endianness is the default, ome controllers
might be only implemented in big endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d87a7bb45a4..d115e88c4b9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1443,20 +1443,10 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     ERRP_GUARD();
     SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
 
-    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
-    switch (s->endianness) {
-    case DEVICE_LITTLE_ENDIAN:
-        /* s->io_ops is little endian by default */
-        break;
-    case DEVICE_BIG_ENDIAN:
-        if (s->io_ops != &sdhci_mmio_le_ops) {
-            error_setg(errp, "SD controller doesn't support big endianness");
-            return;
-        }
-        s->io_ops = &sdhci_mmio_be_ops;
-        break;
-    default:
-        error_setg(errp, "Incorrect endianness");
+    s->io_ops = sc->io_ops ?: (s->endianness == DEVICE_BIG_ENDIAN ?
+                               &sdhci_mmio_be_ops : &sdhci_mmio_le_ops);
+    if (s->io_ops->endianness != s->endianness) {
+        error_setg(errp, "Invalid endianness for SD controller");
         return;
     }
 
-- 
2.47.1


