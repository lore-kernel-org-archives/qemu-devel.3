Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE0ECD37A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4U-0004Nn-OK; Tue, 03 Sep 2024 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4T-0004MJ-Ce
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:07:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4R-0002e1-4w
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:07:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so46210615e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379673; x=1725984473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5xJGOULLxbVBooTuu6NWNSsaVwfIMBQ4uajQRXbH12o=;
 b=bKluGKA0+hhNU61fWukYE2DhMwoaK8dqL0URwGMYZUrOjYrvkl6VQ65VZ8mf+B1ba+
 028vG6L36M7GkCYYIQhP9k6JEhupvG370pUaK4cn0vRCZf4+BQpSie6ANx+RMqxCM1vR
 6LvJnGXJMwgxyxkj8Cxpmv6aryHts02PHmwdUJa0dOYZfWSsq3171phkGltVJtXoT1Jz
 qsIx8emx9PDPPWIjJnDVUi0kBNI7vn51lbdssypA4M4FVg4Oi4pmDzuDsoibLrRF6MMq
 lccFzsMVg5Rl8w6Aqb1xvk8bwKDIZREG6JyL9fHXiDj3nB8XJwax7XgwxTqDjbaO5tmJ
 jdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379673; x=1725984473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5xJGOULLxbVBooTuu6NWNSsaVwfIMBQ4uajQRXbH12o=;
 b=hwiQAMXikvWgJgsCuefdr8zkGtrsOYByZDySKWCvc8hNYCLN69NGuUakHCE7e+4MHx
 U2Z9QX6ACECod2kweR0VrBzXVIt/2yGNrUnh29m2npZeWH6wFhN85DF4HoBQEN1C4VBC
 jyTcJubcw4NDs30lh+Snn6xnECbJt4LmzgElvkzWXrFX7IlccW9ck6JWTDwzbvhAol3N
 q9vG+zgpaF5JxP4Tc0vqJUpZTBvGuYRBcpfJ23wPt3PVoNV9CGwANhyABHp7vXPYjt6Q
 QH9H8dDBS4jqjC3G8KEMTaQV8Kqrv9gEm28xK+LVMoranK9L92JfF1na/Y/LVRnw7TVQ
 BVcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh5WRaIJwfo3erJmPtya36U+4ZmOm4gSnt96IF50mmzJWzpWjC0GeF0VLZon48FafdvXWfex0hyd0q@nongnu.org
X-Gm-Message-State: AOJu0YwV4fyRWgBJ/XkSo3fCXhW9zqFVJEcWZelfsARjYwz/hZNPbKmL
 5qTMVVNho+RkGVPRAxbKMP68sfGn+Gq0zD3rpmexS4L4uUpW4SjJo3/yhUGcI5c=
X-Google-Smtp-Source: AGHT+IH1Ds0SX1JC/lPD6pPgp8um2H1Sl+ZHCJ/wc9Y+dBQtxW9/NCdxl5qJefTZTqDrViM+zwjkww==
X-Received: by 2002:adf:9c8b:0:b0:36c:ff0c:36d7 with SMTP id
 ffacd0b85a97d-374bef3a257mr9043183f8f.2.1725379673162; 
 Tue, 03 Sep 2024 09:07:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:07:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 00/53] arm: Drop deprecated boards
Date: Tue,  3 Sep 2024 17:06:58 +0100
Message-Id: <20240903160751.4100218-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset removes the various Arm machines which we deprecated
for the 9.0 release and are therefore allowed to remove for the 9.2
release:
 akita, borzoi, cheetah, connex, mainstone, n800, n810,
 spitz, terrier, tosa, verdex, z2
We get to drop over 30,000 lines of unmaintained code. So it's
a big patchset but it's almost all deletions.

We have some command line options which were documented as only used
by the pxa2xx LCD display driver: -portrait and -rotate.  These
allowed the user to tell the display device to rotate its output by
90/180/270 degrees (and the ui input layer to correspondingly rotate
mouse event coordinates to match).  I didn't realize these existed
when we deprecated the pxa2xx machines -- do we need a separate
deprecate-and-drop period to remove the command line options?  (If
so, I can drop the relevant patch from this series.)

The series includes removal of some code which while not strictly
specific to these machines was in practice used only by them:
 * the OneNAND flash memory device
 * the PCMCIA subsystem
 * the MUSB USB2.0 OTG USB controller chip (hcd-musb)

Removing these machines hopefully will make it easier to complete
some API transitions (e.g.  there is only one caller of the
ui/input-legacy.c function qemu_add_kbd_event_handler() left, and
five of qemu_add_mouse_event_handler(); a lot of
qemu_register_reset() calls have gone; and so on).

(There will be a trivial conflict with my reset patch that gets rid
of direct setting of DeviceClass::reset in some places, but I'll fix
that up when merging.)

thanks
-- PMM

Peter Maydell (53):
  hw/arm: Remove deprecated akita, borzoi, spitz, terrier, tosa boards
  hw/input: Drop ADS7846 device
  hw/adc: Remove MAX111X device
  hw/gpio: Remove MAX7310 device
  hw/ide: Remove DSCM-1XXXX microdrive device model
  hw/display: Remove tc6393xb device
  hw/arm/KConfig: Replace ZAURUS with ZAURUS_SCOOP
  hw/arm: Remove 'cheetah' machine
  hw/arm: Remove 'connex' and 'verdex' machines
  hw/arm: Remove 'mainstone' machine
  hw/misc: Remove MAINSTONE_FPGA device
  hw/arm: Remove 'z2' machine
  hw/arm: Remove STRONGARM->PXA2XX dependency
  hw/timer/pxa2xx_timer: Remove use of pxa.h header
  hw/arm: Remove pxa2xx.c
  hw/sd: Remove pxa2xx_mmci.c
  hw/input: Remove pxa2xx_keypad
  hw/display: Remove pxa2xx_lcd.c
  hw/dma: Remove pxa2xx_dma
  hw/pcmcia: Remove pxa2xx pcmcia device
  hw/arm: Remove pxa2xx_gpio
  hw/arm: Remove pxa2xx_pic
  hw/timer: Remove pxa27x-timer
  vl.c: Remove pxa2xx-specific -portrait and -rotate options
  hw/arm: Remove 'n800' and 'n810' machines
  hw/misc: Remove cbus
  hw/display: Remove Blizzard display device
  hw/input: Remove tsc2005 touchscreen controller
  hw/input: Remove tsc210x device
  hw/rtc: Remove twl92230 device
  hw/input: Remove lm832x device
  hw/block: Remove OneNAND device
  hw/usb: Remove tusb6010 USB controller
  hw/usb: Remove MUSB USB host controller
  hw: Remove PCMCIA subsystem
  docs: Document removal of old Arm boards
  hw/arm: Remove omap2.c
  hw/gpio: Remove TYPE_OMAP2_GPIO
  hw/char: Remove omap2_uart
  hw/intc: Remove omap2-intc device
  hw/sd: Remove omap2_mmc device
  hw/misc: Remove omap_sdrc device
  hw/misc: Remove omap_gpmc
  hw/timer: Remove omap_gptimer
  hw/timer: Remove omap_synctimer
  hw/block: Remove ecc
  hw/ssi: Remove omap_mcspi
  hw/misc: Remove omap_tap device
  hw/display: Remove omap_dss
  hw/misc: Remove omap_l4 device
  hw/misc/omap_clk: Remove OMAP2-specifics
  hw/dma: Remove omap_dma4 device
  hw: Remove omap2 specific defines and enums

 MAINTAINERS                             |   58 +-
 docs/about/deprecated.rst               |   15 -
 docs/about/removed-features.rst         |   15 +
 docs/system/arm/gumstix.rst             |   21 -
 docs/system/arm/mainstone.rst           |   25 -
 docs/system/arm/nseries.rst             |   33 -
 docs/system/arm/palm.rst                |   23 -
 docs/system/arm/xscale.rst              |   35 -
 docs/system/target-arm.rst              |    5 -
 configs/devices/arm-softmmu/default.mak |    7 -
 include/hw/adc/max111x.h                |   56 -
 include/hw/arm/omap.h                   |  350 +--
 include/hw/arm/pxa.h                    |  197 --
 include/hw/block/flash.h                |   14 -
 include/hw/display/blizzard.h           |   21 -
 include/hw/display/tc6393xb.h           |   21 -
 include/hw/input/lm832x.h               |   28 -
 include/hw/input/tsc2xxx.h              |   41 -
 include/hw/misc/cbus.h                  |   31 -
 include/hw/pcmcia.h                     |   66 -
 include/hw/usb/hcd-musb.h               |   49 -
 include/sysemu/sysemu.h                 |    1 -
 hw/adc/max111x.c                        |  236 --
 hw/arm/gumstix.c                        |  141 --
 hw/arm/mainstone.c                      |  175 --
 hw/arm/nseries.c                        | 1473 ------------
 hw/arm/omap2.c                          | 2715 -----------------------
 hw/arm/palm.c                           |  324 ---
 hw/arm/pxa2xx.c                         | 2393 --------------------
 hw/arm/pxa2xx_gpio.c                    |  365 ---
 hw/arm/pxa2xx_pic.c                     |  359 ---
 hw/arm/spitz.c                          | 1284 -----------
 hw/arm/tosa.c                           |  327 ---
 hw/arm/z2.c                             |  355 ---
 hw/block/ecc.c                          |   91 -
 hw/block/onenand.c                      |  872 --------
 hw/char/omap_uart.c                     |  113 -
 hw/display/blizzard.c                   | 1026 ---------
 hw/display/omap_dss.c                   | 1093 ---------
 hw/display/pxa2xx_lcd.c                 | 1451 ------------
 hw/display/tc6393xb.c                   |  568 -----
 hw/dma/omap_dma.c                       |  451 +---
 hw/dma/pxa2xx_dma.c                     |  591 -----
 hw/gpio/max7310.c                       |  217 --
 hw/gpio/omap_gpio.c                     |  557 -----
 hw/ide/microdrive.c                     |  644 ------
 hw/input/ads7846.c                      |  186 --
 hw/input/lm832x.c                       |  528 -----
 hw/input/pxa2xx_keypad.c                |  331 ---
 hw/input/tsc2005.c                      |  571 -----
 hw/input/tsc210x.c                      | 1241 -----------
 hw/intc/omap_intc.c                     |  276 ---
 hw/misc/cbus.c                          |  619 ------
 hw/misc/mst_fpga.c                      |  269 ---
 hw/misc/omap_clk.c                      |  527 +----
 hw/misc/omap_gpmc.c                     |  898 --------
 hw/misc/omap_l4.c                       |  162 --
 hw/misc/omap_sdrc.c                     |  167 --
 hw/misc/omap_tap.c                      |  117 -
 hw/pcmcia/pcmcia.c                      |   24 -
 hw/pcmcia/pxa2xx.c                      |  248 ---
 hw/rtc/twl92230.c                       |  882 --------
 hw/sd/omap_mmc.c                        |   63 -
 hw/sd/pxa2xx_mmci.c                     |  594 -----
 hw/ssi/omap_spi.c                       |  380 ----
 hw/timer/omap_gptimer.c                 |  512 -----
 hw/timer/omap_synctimer.c               |  110 -
 hw/timer/pxa2xx_timer.c                 |   25 -
 hw/usb/hcd-musb.c                       | 1553 -------------
 hw/usb/tusb6010.c                       |  850 -------
 system/globals.c                        |    1 -
 system/vl.c                             |   11 -
 ui/input.c                              |   36 -
 hw/Kconfig                              |    1 -
 hw/adc/Kconfig                          |    3 -
 hw/adc/meson.build                      |    1 -
 hw/arm/Kconfig                          |   90 +-
 hw/arm/meson.build                      |    9 -
 hw/block/Kconfig                        |    6 -
 hw/block/meson.build                    |    2 -
 hw/display/Kconfig                      |    3 -
 hw/display/meson.build                  |    4 -
 hw/dma/meson.build                      |    1 -
 hw/gpio/Kconfig                         |    7 +-
 hw/gpio/meson.build                     |    3 +-
 hw/ide/Kconfig                          |    6 -
 hw/ide/meson.build                      |    1 -
 hw/input/Kconfig                        |   13 -
 hw/input/meson.build                    |    5 -
 hw/input/trace-events                   |    3 -
 hw/meson.build                          |    1 -
 hw/misc/Kconfig                         |    1 -
 hw/misc/meson.build                     |    6 -
 hw/pcmcia/Kconfig                       |    2 -
 hw/pcmcia/meson.build                   |    2 -
 hw/rtc/Kconfig                          |    4 -
 hw/rtc/meson.build                      |    1 -
 hw/sd/meson.build                       |    1 -
 hw/sd/trace-events                      |    4 -
 hw/ssi/meson.build                      |    1 -
 hw/timer/Kconfig                        |    3 +
 hw/timer/meson.build                    |    4 +-
 hw/usb/Kconfig                          |    8 -
 hw/usb/meson.build                      |    2 -
 qemu-options.hx                         |   16 -
 tests/avocado/machine_arm_n8x0.py       |   49 -
 106 files changed, 39 insertions(+), 30338 deletions(-)
 delete mode 100644 docs/system/arm/gumstix.rst
 delete mode 100644 docs/system/arm/mainstone.rst
 delete mode 100644 docs/system/arm/nseries.rst
 delete mode 100644 docs/system/arm/palm.rst
 delete mode 100644 docs/system/arm/xscale.rst
 delete mode 100644 include/hw/adc/max111x.h
 delete mode 100644 include/hw/arm/pxa.h
 delete mode 100644 include/hw/display/blizzard.h
 delete mode 100644 include/hw/display/tc6393xb.h
 delete mode 100644 include/hw/input/lm832x.h
 delete mode 100644 include/hw/input/tsc2xxx.h
 delete mode 100644 include/hw/misc/cbus.h
 delete mode 100644 include/hw/pcmcia.h
 delete mode 100644 include/hw/usb/hcd-musb.h
 delete mode 100644 hw/adc/max111x.c
 delete mode 100644 hw/arm/gumstix.c
 delete mode 100644 hw/arm/mainstone.c
 delete mode 100644 hw/arm/nseries.c
 delete mode 100644 hw/arm/omap2.c
 delete mode 100644 hw/arm/palm.c
 delete mode 100644 hw/arm/pxa2xx.c
 delete mode 100644 hw/arm/pxa2xx_gpio.c
 delete mode 100644 hw/arm/pxa2xx_pic.c
 delete mode 100644 hw/arm/spitz.c
 delete mode 100644 hw/arm/tosa.c
 delete mode 100644 hw/arm/z2.c
 delete mode 100644 hw/block/ecc.c
 delete mode 100644 hw/block/onenand.c
 delete mode 100644 hw/display/blizzard.c
 delete mode 100644 hw/display/omap_dss.c
 delete mode 100644 hw/display/pxa2xx_lcd.c
 delete mode 100644 hw/display/tc6393xb.c
 delete mode 100644 hw/dma/pxa2xx_dma.c
 delete mode 100644 hw/gpio/max7310.c
 delete mode 100644 hw/ide/microdrive.c
 delete mode 100644 hw/input/ads7846.c
 delete mode 100644 hw/input/lm832x.c
 delete mode 100644 hw/input/pxa2xx_keypad.c
 delete mode 100644 hw/input/tsc2005.c
 delete mode 100644 hw/input/tsc210x.c
 delete mode 100644 hw/misc/cbus.c
 delete mode 100644 hw/misc/mst_fpga.c
 delete mode 100644 hw/misc/omap_gpmc.c
 delete mode 100644 hw/misc/omap_l4.c
 delete mode 100644 hw/misc/omap_sdrc.c
 delete mode 100644 hw/misc/omap_tap.c
 delete mode 100644 hw/pcmcia/pcmcia.c
 delete mode 100644 hw/pcmcia/pxa2xx.c
 delete mode 100644 hw/rtc/twl92230.c
 delete mode 100644 hw/sd/pxa2xx_mmci.c
 delete mode 100644 hw/ssi/omap_spi.c
 delete mode 100644 hw/timer/omap_gptimer.c
 delete mode 100644 hw/timer/omap_synctimer.c
 delete mode 100644 hw/usb/hcd-musb.c
 delete mode 100644 hw/usb/tusb6010.c
 delete mode 100644 hw/pcmcia/Kconfig
 delete mode 100644 hw/pcmcia/meson.build
 delete mode 100644 tests/avocado/machine_arm_n8x0.py

-- 
2.34.1


