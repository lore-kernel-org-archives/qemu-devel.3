Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6C8C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1qr-0005MD-D2; Sat, 08 Mar 2025 16:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qi-0005Hj-GU
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:36:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qf-0003qm-Cx
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:36:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bc6a6aaf7so23175135e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469803; x=1742074603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/soGLRQmXWup4QpXCq2XeRqXX9zhByFKSEzr8WVVrIo=;
 b=QE34q27XtNWlIYph9hN1Z/Pobcz1wC/w7nLTdcuWvsIjvaSP4vff48o/EPragrrRQ7
 t8fN22fGi/nf+tQ8dNEL7MKTEL9Qc5hzyFG6jh9zWJscXE+mXihGXhHrZZ7OPxFWvHyH
 SFC+bEMJvMz2ScijTKnXZguJBjBnZUuPTCxxuOrNiw14APewCGC31YdarnNS38cBnjuv
 /T97wFGQ15UPznur18kVyqyBj+QObXltbz0RoXHBLb8t8EDCqvLYnl49/99dYvSd1OlK
 vBSlJN3klilXIsjMOIqQGulphH/m8yPaxmMNwxgt0xELuk235VQ8Ls1VUS7+IOIvqDQk
 BeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469803; x=1742074603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/soGLRQmXWup4QpXCq2XeRqXX9zhByFKSEzr8WVVrIo=;
 b=XjUgrRGeAAjAQYoG0OaKCOoI/T2FM7E6ICj/tb1e79+otOC8bqliN/b/UqxRVuYjNj
 Aip2E0yCkr/PrNekQrejlhn4FxJISLs9nh1osmAaDYHZUtzYPzZUzh/hgLw6aaM3WoK6
 1lcDZHl0vwoKlr2JsJSzWQqoGYgX2OSt1p7K4/8JpMUvDRYtshzsPxA+Gt/+tDT3H5P+
 kDXGfCvPbdYH77yNSDhPTaSo5sVSy2EpGj1Dpgl1+f7a21XmvSGy2TIRfwSDA/wpGccA
 iyvZOOH4XkBVfKzhHb/rUwcDg3ZDT6TYogzgz/8rb1EECj5L0o2GV9NW6cgTHnOqYq8j
 I0yQ==
X-Gm-Message-State: AOJu0YzbLGVW4zbDSCRAVIuWMTDKthkGwa8f6dRYHagfoNkMI2p2aHj2
 yVNr+mnsQLl6FBdfnupRPHxE9BpOyPaxiD0x5mrjMMqOuVeaQfZr32isB4UJooZuIWD4OPBaz1y
 yo/Q=
X-Gm-Gg: ASbGncu+fzOLaBoyEZ0hSYQSgTH9T5gDvCWW04BfaXND4+IJjVKXgyfc0Gr28L8rI64
 e/SrKh/DvLUCBClGcN7znScG5dYmBJc7OP0SF2n79qKVJE+sJ35VyTERNq34yVFULv+kpcOKEgE
 DQoWPevnaUvK2EkRpYw9ugOuUcAM0VuCdmeD7GF6zrGOjtp1NTLLPiAK2+LpM+McKMqnqzwc66B
 LM1WnOrK3xemCk6CyWohouEgyMCvv71KrDlc/KhVyXou2YZ7YYwmBNg4d7o1ZfhKzhGFDOqCRg8
 9L3jr+a1twyqqSE6d1UA7q84rwaTxSWoGpfKlnaVATafDOtMPMrqeiJT5ZTztsNObAix4oEORgB
 KXWG6FrNgHO1Icz88cAI=
X-Google-Smtp-Source: AGHT+IFkI/L6bXegO7OxRer8O1eAq2mQGAvZexq1x3JIhBw+l0Je8DJRe+PK0Q0iultJnOIfn43wkg==
X-Received: by 2002:a05:600c:358f:b0:43b:cbe2:ec08 with SMTP id
 5b1f17b1804b1-43c5a630919mr45955905e9.24.1741469803413; 
 Sat, 08 Mar 2025 13:36:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2eecsm9836336f8f.79.2025.03.08.13.36.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:36:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 00/14] hw/sd/sdhci: Set reset value of interrupt registers
Date: Sat,  8 Mar 2025 22:36:26 +0100
Message-ID: <20250308213640.13138-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Since v3:
- Fix "hw/qdev-properties-system.h" (first patch)
- Convert to EndianMode (patch #10)

Rainy saturday, time for some hobbyist contributions :)

In this series we try to address the issue Zoltan reported
and try to fix in [*], but using a more generic approach.
The SDHCI code ends up better consolidated and ready to
scale for more vendor implementations.

I expect (with few QOM knowledge) this to be trivial to review.

- Remove SDHCIState::vendor field
- Convert state fields to class ones
- Simplify endianness handling
- Add default reset values as class fields

[*] https://lore.kernel.org/qemu-devel/20250210160329.DDA7F4E600E@zero.eik.bme.hu/

Philippe Mathieu-Daudé (14):
  hw/qdev-properties-system: Include missing 'qapi/qapi-types-common.h'
  hw/sd/sdhci: Remove need for SDHCIState::vendor field
  hw/sd/sdhci: Introduce SDHCIClass stub
  hw/sd/sdhci: Make quirks a class property
  hw/sd/sdhci: Make I/O region size a class property
  hw/sd/sdhci: Enforce little endianness on PCI devices
  hw/sd/sdhci: Allow SDHCI classes to register their own MemoryRegionOps
  hw/sd/sdhci: Simplify MemoryRegionOps endianness check
  hw/sd/sdhci: Unify default MemoryRegionOps
  hw/sd/sdhci: Convert SDHCIState::endianness to EndianMode
  hw/sd/sdhci: Add SDHCIClass::ro::capareg field
  hw/sd/sdhci: Allow SDHCI classes to have different register reset
    values
  hw/sd/sdhci: Implement Freescale eSDHC as TYPE_FSL_ESDHC
  hw/ppc/e500: Replace generic SDHCI by Freescale eSDHC

 hw/sd/sdhci-internal.h              |  28 ++---
 include/hw/qdev-properties-system.h |   1 +
 include/hw/sd/sdhci.h               |  46 +++++++-
 hw/arm/fsl-imx25.c                  |   2 -
 hw/arm/fsl-imx6.c                   |   2 -
 hw/arm/fsl-imx6ul.c                 |   2 -
 hw/arm/fsl-imx7.c                   |   2 -
 hw/arm/fsl-imx8mp.c                 |   2 -
 hw/ppc/e500.c                       |  12 +-
 hw/sd/sdhci-pci.c                   |   1 +
 hw/sd/sdhci.c                       | 172 ++++++++++++++++++----------
 11 files changed, 170 insertions(+), 100 deletions(-)

-- 
2.47.1


