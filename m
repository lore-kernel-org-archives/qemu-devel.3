Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E7CCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHOA-00059N-3e; Mon, 12 Oct 2026 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHO7-00058H-Ul
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:52:28 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHO4-0004dV-Nx
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:52:27 -0400
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso26274905e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816743; x=1792421543;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lbXKonngT0t3634t834L2TNchi/eMcveydU410+nJEI=;
 b=UW0aZI3LIBdkRTTl/tgvelMVlyG208xeMsDziVdyWA2K05f8p5F6SzpG7VgwS/Ae6Z
 FI4BxHeI3l+BQyO72a/BqOoUIlDvbY4X+/aVKWuERra7VNK4yhl04DewP3LdzE1F/MHT
 Bm1GaDfkWyvtcIMHcpQG+wmA9TWWjgm8MNhxsaYF8pm16xzCZ0IElnzxW6dG1qn76qWi
 XcZJ6wseLYAI5cnQpMDbNUP1IGzIeY12AYUWNLptskPZdyVnFxtDAhGN4pd771+B1Ae+
 SZAdGipWSqktsyW6ko74tMmGqeSFwQynvJprvAsPzCKnq3aoZR+1kAVjHEc5SZqw3hPA
 5Y6w==
X-Gm-Message-State: AFq9FYIbT04pfE9N3hzAxaARnQvJVDVIO+J7c6zwVNkBmktwyzCbaLKh
 VoxuGVxyw49SbU7jCwHMrgs8M2/5K6kkn/o8I8cGJIz3P9bAWY1rc854tMpO1Tej
X-Gm-Gg: AYBFou3tYDfQ6Q7YZAP4jMKtJYWbpGggUNrFcLSIy4ZMKC5WoZ5jUo1ovCNrsXlD6DD
 di6GXbeukyl0JdFAqTfkARzy7FfODfNvUxg7nMN+oqIQgZU5m/WNhnd9QhItyX1VJD/CXs3cy5U
 ztx7gf1xkOmeeB4kkD19VdhaXjy4344kZc1sjnvgTDEaqMvnxdfWQyrwZ+dQ6r57nXXxyZK3Wit
 0ZZcW2vVYARqVaheuBJ6RamUEh4WAeeEKLNVgVIX3tTxrccxSeP7V55RnR0FHE5hS5F5UIrU9AZ
 99Mqt4fVEVTsjFW5nW94JZLB92mf+Y+49kMNgBO7pO/8gljhA2o/IGKoLvZbApZzhXRCY8VSmmO
 YOAA9VymiseV9zIQqzCkNXh5hJyKHdcJg0Wkrdwo1QRX3KFlTbxQ4szXuX+oWiJPH8JcaeZFR3o
 z6h3E4Wa7qVlU9swkWCeON5MI5vEfrIOkrz8ZuBL2wCXCVY9htLk0ugAgNr0T8nu2CQyG/tCJxX
 /lRedAGj52YgbqO3bSPjrRuUjsyzFvAxswUgqtwvFyNBhhRC6t69G3uIw==
X-Received: by 2002:a05:600c:8b02:b0:4a1:6d2d:d8bb with SMTP id
 5b1f17b1804b1-4a18e4a00dfmr198653135e9.12.1791816742420; 
 Mon, 12 Oct 2026 07:52:22 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm408862465e9.6.2026.10.12.07.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:52:21 -0700 (PDT)
Subject: [PATCH v2 00/50] Aspeed: I2C device models and the Minerva BMC machine
Date: Mon, 12 Oct 2026 16:31:53 +0200
Message-Id: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Oyw6CMBBFf4V0bc20JDxc+R+GRR+DjAmgU2g0h
 H+3oIkbl+fmvhYRkAmDOGWLYIwUaBwS6EMmXGeGK0ryiYUGXUANpbS9kz0NyNFI51VuSlW5Gqx
 IiTtjS8+97dJ8OMz2hm7aKr4OxsecZqafraMwjfzaP0S1qf/nopIgwVe58YUCl9tzy4jHlkWzr
 usb3dXvyMsAAAA=
X-Change-ID: 20260907-bmc-minerva-cd13a718c90b
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815519; l=7329;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=eKLk7Anu7khQUJCnvSrXzq7ZSIw+R76Y3qrKE+DevKA=;
 b=vxvrBiYKLFYC/H5CgWwLvAvkWM7BYGRZ423fNF8r8LgByxPDEKBNPXiQ4niKOtB6m9SYuiU/E
 bVwE5dwop2RC1Jckwp/a00pGtXDH9/u6KdtBefsOCzqMWqYJErc8VI6
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.47; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f47.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the minerva-bmc machine and the I2C device models it needs.

Based on master, at:
  615ece3c40 ("Merge tag 'for-upstream' of
  https://gitlab.com/bonzini/qemu into staging")

New models:

  INA230   TI 36V current-shunt and power monitor
  INA238   TI 85V current-shunt, power and temperature monitor
  DS1339   RTC, a DS1338 variant
  PCA9545  4-channel I2C mux with per-channel interrupt inputs

The INA devices derive current and power from the shunt voltage and
their calibration registers. ALERT output is supported. Measurements
come in through QOM properties; however, conversion delay is not
modelled.

Introduce a device class to manage different variants of the DS1338
register map, such as the DS1339. Improve the DS1338 implementation
with a Resettable reset, support for the clock-halt bit, and a
"persist-on-reset" property keeping the registers across a reset.

The minerva-bmc machine is derived from the platform device tree and
instantiates every device that is supported in QEMU. FRU EEPROMs are
sanitised images taken from real hardware.

New qtests for the DS1339, INA230, INA238 and PCA9545, plus DS1338
cases for the register map, and a functional test booting OpenBMC on
minerva-bmc.

The docs now mention the previously missing catalina-bmc and
sanmiguel-bmc machines, and the title has been simplified.

One thing worth a second opinion: the PCA954x muxes now have a
VMStateDescription, which changes the migration stream for the
existing PCA9546 and PCA9548. The DS1338 vmstate also goes from
version 2 to 3, but older streams still load fine.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Changes in v2:
- Rebase onto master, which now contains the v1 base.
- minerva: drop ASPEED_RAM_SIZE, removed upstream.
- No other changes; v1 received no review comments.
- Link to v1: https://lore.kernel.org/qemu-devel/20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr

---
Emmanuel Blot (50):
      docs/system/arm/aspeed: add the catalina-bmc machine
      docs/system/arm/aspeed: add the sanmiguel-bmc machine
      hw/arm: sanmiguel: remove the second SPI flash controller
      hw/i2c: pca954x: drop unused header inclusions
      hw/i2c: pca954x: add PCA9545 4-channel mux model
      hw/i2c: pca954x: migrate mux state
      tests/qtest: pca9545: add mux test
      hw/rtc: ds1338: move TYPE_DS1338 to a public header
      hw: ds1338: use the TYPE_DS1338 constant instead of the "ds1338" string
      hw/rtc: ds1338: implement Resettable reset
      hw/rtc: ds1338: prefix the file-local helpers with ds1338_
      hw/rtc: ds1338: parameterise the register map via a device class
      hw/rtc: ds1338: program the clock from the time registers
      hw/rtc: ds1338: implement the DS1338 clock-halt bit
      hw/rtc: ds1338: refresh the user registers on a read rollover only
      hw/rtc: ds1338: add a persist-on-reset property
      tests/qtest: ds1338: cover the DS1338-specific register map
      tests/qtest: ds1338: cover the power-on register defaults
      tests/qtest: ds1338: cover the clock-halt bit
      tests/qtest: ds1338: cover persist-on-reset
      tests/qtest: ds1338: cover the reserved bits of the time registers
      hw/rtc: ds1338: add DS1339 variant
      tests/qtest: ds1339: add RTC test
      tests/qtest: ds1339: cover power-on defaults and reserved-bit masking
      tests/qtest: ds1339: cover oscillator stop/restart and time programming
      tests/qtest: ds1339: cover the Century bit
      tests/qtest: ds1339: cover the end-of-month rollover
      tests/qtest: ds1339: cover the 12-hour format
      tests/qtest: ds1339: cover the day-of-week counter
      tests/qtest: ds1339: cover persist-on-reset
      tests/qtest: ds1339: cover the migration round trip
      hw/sensor: ina230: add current/voltage/power monitor
      tests/qtest: ina230: add current/voltage/power monitor test
      tests/qtest: ina230: cover voltage injection and power derivation
      tests/qtest: ina230: cover the ALERT limit functions and CVRF
      tests/qtest: ina230: cover the injection-property limits
      tests/qtest: ina230: cover operating modes and triggered conversions
      tests/qtest: ina230: cover ALERT latch persistence
      tests/qtest: ina230: cover a cleared calibration per channel
      hw/sensor: ina238: add current/voltage/power monitor
      tests/qtest: ina238: add current/voltage/power monitor test
      tests/qtest: ina238: cover voltage/temperature injection and derivation
      tests/qtest: ina238: cover the ALERT path and conversion-ready flag
      tests/qtest: ina238: cover the injection-property limits
      tests/qtest: ina238: cover the operating modes
      tests/qtest: ina238: cover conversion-ready and alert-latch semantics
      tests/qtest: ina238: cover a cleared calibration per channel
      hw/arm: minerva: add Facebook BMC machine
      hw/arm: minerva: populate EEPROM data
      tests/functional/arm: minerva: add BMC boot test

 docs/system/arm/aspeed.rst                  |   7 +-
 hw/arm/Kconfig                              |   2 +
 hw/arm/aspeed_ast2400_palmetto.c            |   4 +-
 hw/arm/aspeed_ast2400_supermicrox11.c       |   4 +-
 hw/arm/aspeed_ast2500_romulus.c             |   4 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c   |   4 +-
 hw/arm/aspeed_ast2500_witherspoon.c         |   4 +-
 hw/arm/aspeed_ast2600_bletchley.c           |   3 +-
 hw/arm/aspeed_ast2600_catalina.c            |   2 +-
 hw/arm/aspeed_ast2600_minerva.c             | 856 ++++++++++++++++++++++++++++
 hw/arm/aspeed_ast2600_sanmiguel.c           |   7 +-
 hw/arm/meson.build                          |   1 +
 hw/arm/realview.c                           |   3 +-
 hw/arm/versatilepb.c                        |   3 +-
 hw/i2c/i2c_mux_pca954x.c                    |  98 +++-
 hw/ppc/e500.c                               |   3 +-
 hw/riscv/tt_atlantis.c                      |   3 +-
 hw/rtc/ds1338.c                             | 427 +++++++++++---
 hw/sensor/Kconfig                           |   8 +
 hw/sensor/ina230.c                          | 597 +++++++++++++++++++
 hw/sensor/ina238.c                          | 802 ++++++++++++++++++++++++++
 hw/sensor/meson.build                       |   2 +
 hw/sensor/trace-events                      |  14 +
 include/hw/i2c/i2c_mux_pca954x.h            |   1 +
 include/hw/rtc/ds1338.h                     |  21 +
 include/hw/sensor/ina230.h                  |  14 +
 include/hw/sensor/ina238.h                  |  14 +
 tests/functional/arm/meson.build            |   2 +
 tests/functional/arm/test_aspeed_minerva.py |  30 +
 tests/qtest/ds1338-test.c                   | 191 ++++++-
 tests/qtest/ds1339-test.c                   | 581 +++++++++++++++++++
 tests/qtest/ina230-test.c                   | 602 +++++++++++++++++++
 tests/qtest/ina238-test.c                   | 806 ++++++++++++++++++++++++++
 tests/qtest/meson.build                     |   4 +
 tests/qtest/pca9545-test.c                  | 116 ++++
 35 files changed, 5125 insertions(+), 115 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20260907-bmc-minerva-cd13a718c90b

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


