Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E4E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSK9-0003vW-TU; Wed, 08 Jan 2025 04:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK3-0003uW-9Y; Wed, 08 Jan 2025 04:25:56 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK1-0004la-5G; Wed, 08 Jan 2025 04:25:54 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so4485218a12.1; 
 Wed, 08 Jan 2025 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328350; x=1736933150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EbJAmmOYxoc1nbf2SceZRGqKmTWWmiM1s08mEm2FVGw=;
 b=Po1Idh/WIe8hYog05Yuppf8iBeYyktoWEn1TRehlWDL1ZlvH+O0Pbn0ISgG9XHgD5j
 f5HzvmbwkhxUU8MFplmxJlsD09l12YOoLm2z4KxSv48v3+D/ax+M1LOTYbQ51+WGR91e
 SljDo+OKFzeRxa3GzKF+vrThvXavxlwRHL6O0rVv4EhyK8E6BrUhWpweGOIwfxGlmkfY
 NJtCF1e9IPaLA+Bc+2KCZU1O0AHRLE9lwTcKzkzqpLrvYJ7CzC/y2oMY14GEV8HO6c+D
 8TpOBWwAEQfCbPQdwShXWc/u/ZPM+OKba87AproRUjtVqc2nqpdOc+La6BtZeRbSE8ZQ
 ebxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328350; x=1736933150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbJAmmOYxoc1nbf2SceZRGqKmTWWmiM1s08mEm2FVGw=;
 b=kA8T/Y/caOQkhnVb/thyn376C0YXunUAaO1bXRux2FhxkKDXFFJBKVZXh2GhpiXMXG
 8+DgtAp+QneHrSqkkrH5tMpNvqzxHEZhpLmGZr6kDpQhsxq80248zcg5Pp8crIGVHJSx
 qV2dzsJ/l7GU2EfBl1vR0JogSXU8WOXw0zF0Ivm/06CGuYzjg2rbrVzUQAu4Sbf1QAIZ
 /RvV8SgdYbj5KisbQcHVo53/cTDtDvKLGjNY1n37g0LT62yeL3L1ssEYDmC56WgkTAnm
 HQJj2eQrfBp4vV2GAJyVhg/9H0T6BPJwoPyt6wugxxu4ou2KFeMOj9VBZ04kP8xNqMs+
 MczQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuUP6q/WKxIYtgzTzuGgtJ/514Slehnz/UOvLkladlksBkqO9aShW0iJb0/MQNJgif/mQIsXZWglNqYA==@nongnu.org,
 AJvYcCXrZThTowNU4KhEJinghhISSgCG/qFpu1/OE5WpBiao26VAs3ROlxk+kJW1L8g0WGxG1dUX+OARGg==@nongnu.org
X-Gm-Message-State: AOJu0YzuvxM8DiT3Ynzcgs8vSkvPOkNg53YWyNS3XjacEEIAeh964tf7
 bLzu1txX52u+jLBsaKvAF34T5lB95FJywzCm1sc+s9X060F3++BNFwW/9A==
X-Gm-Gg: ASbGncs66Eag4FKgtPgBTA7gj50aJ/sNnoIMLgeIeNtsDOyyXi7ujn7fgbqfqDnoNdp
 VTS/gHYMzILVnsrrwkGxjftDnZTqlTB3MZZEGZ8pHc+jTau2WkmEe3y25bneuQpUTrLEzC9aS91
 LBGjQJafOwV7CSRWwf727fnlWxp55CdG9O0b6S1SSE2tw/Eg8Xve6zSx0245g2trbTfpamtoRWn
 PyzoNW/KKqMwjtgMnVsqjl0sYoHMbCU7M/tLcBQPlelYJts9UKUj12qcC9SGJ5jPV/oIX04GUNE
 VKUy56ngC3AzvqJugrRnfBtPDjIkLfZLsDf8nc+xwFEYtWY=
X-Google-Smtp-Source: AGHT+IGTbZr+IbP61YM4f1x96qu4P9YeHhDisb6evnoIlZfXLwBOc8JM2qJamkx+uesAgnsnYp+IrA==
X-Received: by 2002:a05:6402:518f:b0:5d0:abb8:79d with SMTP id
 4fb4d7f45d1cf-5d972e083f8mr1631901a12.14.1736328349533; 
 Wed, 08 Jan 2025 01:25:49 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:49 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 00/14] i.MX and SDHCI improvements
Date: Wed,  8 Jan 2025 10:25:24 +0100
Message-ID: <20250108092538.11474-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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

This series fixes some details in i.MX platform devices, improves SDHCI=0D
compatibility with U-Boot and modernizes some code.=0D
=0D
The first 6 patches are bugfixes 1/ resolving infinite loop in U-Boot esdhc=
=0D
driver, 2/ fixing a character echoing issue in imx-serial, 3/ fixing IRQ sh=
aring=0D
issue in Designware PCIe emulation, and 4/ fixing GPIO level preservation a=
cross=0D
resets in imx-gpio. The IRQ sharing issue is fixed using a new device type=
=0D
"TYPE_SHARED_IRQ" which is inspired by TYPE_SPLIT_IRQ.=0D
=0D
Patches 7 and 8 modernize SD card emulation by turning presence and=0D
write-protect GPIOs into qdev GPIOs and then further allowing the GPIOs to =
be=0D
inverted, just like device tree allows.=0D
=0D
The rest of the series is cosmetics including turning DPRINTF() into trace=
=0D
events which eases debugging.=0D
=0D
Bernhard Beschow (14):=0D
  hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate=0D
  hw/char/imx_serial: Fix reset value of UFCR register=0D
  hw/char/imx_serial: Update all state before restarting ageing timer=0D
  hw/core: Introduce TYPE_SHARED_IRQ=0D
  hw/pci-host/designware: Expose MSI IRQ=0D
  hw/gpio/imx_gpio: Don't clear input GPIO values upon reset=0D
  hw/sd/sd: Remove legacy sd_set_cb() in favor of GPIOs=0D
  hw/sd/sd: Allow for inverting polarities of presence and write-protect=0D
    GPIOs=0D
  hw/char/imx_serial: Turn some DPRINTF() statements into trace events=0D
  hw/timer/imx_gpt: Remove unused define=0D
  tests/qtest/libqos: Reuse TYPE_IMX_I2C define=0D
  hw/i2c/imx_i2c: Convert DPRINTF() to trace events=0D
  hw/misc/imx6_src: Convert DPRINTF() to trace events=0D
  hw/gpio/imx_gpio: Turn DPRINTF() into trace events=0D
=0D
 include/hw/arm/fsl-imx6.h                  |  4 +-=0D
 include/hw/arm/fsl-imx7.h                  |  4 +-=0D
 include/hw/char/imx_serial.h               |  2 +-=0D
 include/hw/core/shared-irq.h               | 39 ++++++++++=0D
 include/hw/pci-host/designware.h           |  1 +=0D
 include/hw/sd/sdcard_legacy.h              |  1 -=0D
 hw/arm/fsl-imx6.c                          | 13 +++-=0D
 hw/arm/fsl-imx7.c                          | 13 +++-=0D
 hw/char/imx_serial.c                       | 65 ++++++++++------=0D
 hw/core/shared-irq.c                       | 88 ++++++++++++++++++++++=0D
 hw/gpio/imx_gpio.c                         | 17 ++---=0D
 hw/i2c/imx_i2c.c                           | 21 ++----=0D
 hw/misc/imx6_src.c                         | 23 ++----=0D
 hw/pci-host/designware.c                   |  7 +-=0D
 hw/sd/sd.c                                 | 39 +++++-----=0D
 hw/sd/sdhci.c                              | 11 ++-=0D
 hw/timer/imx_gpt.c                         |  4 -=0D
 tests/qtest/libqos/arm-imx25-pdk-machine.c |  5 +-=0D
 tests/qtest/libqos/i2c-imx.c               |  4 +-=0D
 hw/arm/Kconfig                             |  2 +=0D
 hw/char/trace-events                       |  5 ++=0D
 hw/core/Kconfig                            |  3 +=0D
 hw/core/meson.build                        |  1 +=0D
 hw/gpio/trace-events                       |  5 ++=0D
 hw/i2c/trace-events                        |  5 ++=0D
 hw/misc/trace-events                       |  6 ++=0D
 26 files changed, 280 insertions(+), 108 deletions(-)=0D
 create mode 100644 include/hw/core/shared-irq.h=0D
 create mode 100644 hw/core/shared-irq.c=0D
=0D
-- =0D
2.47.1=0D
=0D

