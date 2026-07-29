Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D790BC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6BM-0008SR-GD; Wed, 29 Jul 2026 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6BK-0008Rk-8W
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:26:54 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6BH-0007vm-V6
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:26:54 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so7655815e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338810; x=1785943610;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UT65JqqXMWe4/qK/5ftLxPo3hI40eeDx4IMRwjYgdTI=;
 b=tDntpgQ03IQmjfNAaWlVBWLAperFEXwuIM8lNJH6KRLt+z4x37rmD9RpYA4WPgZKSq
 VxL3VgXRmFPUqBl5kw+5h6Uvgt/Mm3S1FJXNWKIVoh5Maeun9cKqTk4gpA1+Ypz7JoJ4
 5jdZ9bZcCVFfudTui+IlKMWpDA1VnOxcYLT3Sh1bQqI/2CyEKEa6THGnu1RjMuBn5Hpr
 AxI9lUl86tSymJxafR3ybVkD3TYCjVzYT6xM1yU6k6nPkzjyGprH6OhrPWutphgtPiHa
 VtWkVkH2McpcRF5/cVAhgg7gF/RL7fqL1G3pAn9l+df0V/0jp9pLBtHhPgLvHTCznb60
 gyAg==
X-Gm-Message-State: AOJu0Yy8QxvkRJDCqp1zWvVxdFQJEZKa2rMmwODmE66bmxfIcOVEotmq
 dPSYNtHm8bCgqV4xpXRvld3K6ClALgmLLxVkPaCrmgFZP3rQUFZCFjzC8lxNDJbf
X-Gm-Gg: AR+sD118ZhX/A6r8N84yS/NvO92/cp2jUKdqFOmSvmyKhea5/O5nEZRxUuPmdUdz2cv
 hNCbbwpzsVe2bFjKAo/8NBqVbtvuPc9YDTDZwewJtQ6vyt5lviGGFx1Y0pZn8aRvxgdfHxFvwM2
 KqO9hg8p9o2IshJ+/0UhyHljIIkcseNaRlNbOcDdMSc9Nk/4uOq5BUFNtVFvrMwEAjJANBi04nE
 Q2of5FM0IbKHgimLogFMOheyZi7NnJ6VnEzIQs92xIgS9+enpa42dDDJDk2ytUhbDTzDxaOtWAW
 2o0/+P/4ct+ok0j2knnixkYz4jRdYOT2mjN2b0spWtOO6HpfF4rPnqpHhOWAqvYkPRkiWHSLIWl
 Uu+CzapZU3Rp7FOh7v2O14KZ15WAW9z6n+gf/guUsX/qlI10ZYPwzu3a/mMSP6CRQWVEqm8MTod
 xSpfpn1iB4jQbdUJacQwro5eexoPdQkYfPwGIR/xJSfWkMdF0Qy5JUkPi8/II3mNvw4ocprIksb
 YV03n9IrZ7kUXeZjlhv583R5pj5qyjMgnu2eqfouzfMp+g=
X-Received: by 2002:a05:600c:c16d:b0:493:c8a6:b517 with SMTP id
 5b1f17b1804b1-496c6588c3cmr77985135e9.38.1785338810006; 
 Wed, 29 Jul 2026 08:26:50 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd6e179sm71564555e9.9.2026.07.29.08.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:26:49 -0700 (PDT)
Subject: [PATCH 00/25] hw/arm: Facebook SanMiguel BMC and TMP75-family sensors
Date: Wed, 29 Jul 2026 17:12:36 +0200
Message-Id: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTvQRojoVcRFMv2tI20imbYIp
 Xc36vJbvLeRoSiMLs1GBaua5lTRHRqSR0gDWPtqcq3z7cmd2UKadFgwcpyExyxhzoX72B1FEOC
 9UG1fBXd9/77X29+2xCdk/s5o3z/q7r4ZeQAAAA==
X-Change-ID: 20260729-sanmiguel-bmc-locator-db13cceae66c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337963; l=6248;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=PlkjWdIRrG8gzC0wTRtdaD5kPU6CgbQT0mpFnaBbSio=;
 b=1BWHsZxjyC3uuM+EWgc/buNelXYzfL1is4vi7QynbvUkhicp9NtIKpQ5fujZfVUMccAk0j1Eb
 adg11x7iuPcDndozSqHLasskI7eY/A2AyXeqY91ReIFrQbxcGvwKVCA
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f52.google.com
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

This series adds the Facebook SanMiguel BMC, promotes the
TMP75/TMP175/LM75B sensors from generic TMP105 stand-ins to improved,
dedicated models, and introduces the test-side plumbing needed to
exercise real I2C devices from functional tests without hardcoding QOM
paths.

The work falls into four parts.

1. TMP* sensor models

The TMP105 model was the only stand-in for a whole family of pin- and
register-compatible parts, and several boards worked around the gap with
private TYPE_TMP75 / TYPE_LM75 aliases that resolved back to a plain
TMP105.

The model is first cleaned up for correctness and QEMU convention. One
of those changes touches migrated state, which gains an optional
subsection so existing streams stay compatible.

On that base, TMP75/TMP175/LM75B become variants selected by a small
per-type class descriptor. The variant is class data, so the wire format
is unchanged and all variants share the existing vmstate. qtest coverage
is added for the per-variant behaviour. The existing BMC boards then
drop their local aliases and instantiate the real models.

2. SanMiguel BMC

A new AST2600-based machine for the Facebook SanMiguel BMC, derived from
its device tree. It wires up three TMP75 sensors, IO expanders, FRU
EEPROMs, an I2C mux and an RTC across its I2C buses, and provides its
RAM, flash and networking; the FRU EEPROMs are populated with data read
from physical hardware. A functional test boots the OpenBMC image and
drives each sensor over QOM, checking the guest hwmon interface reports
the injected value back.

3. Python device locator

A QOM path names a device by its position under the object that owns it,
in enumeration order — it says nothing about where the device sits in
the bus topology. From a QOM path alone it is impossible to tell where a
device is actually connected or what purpose it serves.

DeviceLocator is a pure-Python helper that resolves a device from a
string descriptor of its position — bus, address, type, on-bus index —
by walking the bus/device hierarchy. It uses only standard QOM queries
over QMP: no new QEMU commands, no model changes. A self-check exercises
the grammar and its error paths against a paused SanMiguel BMC; it needs
no disk image and runs in about a second.

Note: the helper adopts the 3.10 type-hint syntax rather than the 3.9
equivalents; 3.9 reached end of life on 2025-10-31. The import is
guarded so the module still loads on 3.9 and dependent tests skip there.

Two small test-framework fixes ride along: the set_machine probe VM now
gets the per-test workdir instead of the hardcoded /var/tmp default, and
the Aspeed OpenBMC helper can optionally assert the booted device-tree
model.

4. Catalina follow-ups

The final three commits are the tail of the earlier "hw/arm: improve
Aspeed Catalina BMC emulation" series: functional tests for the PCA9555
and PCA9554 IO expanders, plus the PCA9554 change that drives its input
pins externally. They were held back because reaching such devices from
a test needs a stable way to reference them by bus position — the QOM
re-parenting patch tried then was rejected, and the device locator now
unblocks them.

Based on:

  repo:   https://github.com/legoater/qemu.git
  branch: aspeed-11.1
  commit: 04d27371e3 ("hw/arm: catalina: add NIC and FIO temperature sensors")

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Emmanuel Blot (25):
      hw/sensor: tmp105: make device state private to the implementation
      hw/sensor: tmp105: name the parent object field parent_obj
      hw/sensor: tmp105: implement Resettable reset
      hw/sensor: tmp105: enforce the configurable fault queue
      hw/sensor: tmp105: describe the temperature property
      hw/arm: aspeed: guard board-local temperature-sensor aliases
      hw/sensor: tmp105: add TMP75, TMP175 and LM75B variants
      tests/qtest: tmp105: cover the ALERT fault queue
      tests/qtest: tmp105: cover the TMP75, TMP175 and LM75B variants
      tests/qtest: tmp105: cover one-shot and fault-queue write immunity
      tests/qtest: tmp105: cover shutdown clearing the ALERT across variants
      hw/arm: sanmiguel: add Facebook SanMiguel BMC machine
      hw/arm: sanmiguel: populate EEPROM data
      hw/arm: catalina: use the real TMP75 model
      hw/arm: fuji: use the real TMP75 and LM75B temperature sensors
      tests/functional: aspeed: optionally check the device tree model on boot
      tests/functional: give the set_machine probe VM the test workdir
      tests/functional: add a pure-Python device-locator resolver
      tests/functional: add a device-locator self-check
      tests/functional: aspeed: add hwmon sensor read helpers
      tests/functional/arm: sanmiguel: add BMC boot test
      tests/functional/arm: catalina: test TMP75
      tests/functional/arm: catalina: test PCA9555 IO expander via QOM
      hw/arm: catalina: drive pca9554 io expander input pins externally
      tests/functional/arm: catalina: test PCA9554 IO expander via QOM

 hw/arm/aspeed_ast2600_catalina.c              |  14 +-
 hw/arm/aspeed_ast2600_fuji.c                  |  16 +-
 hw/arm/aspeed_ast2600_sanmiguel.c             | 405 ++++++++++++++++++
 hw/arm/meson.build                            |   1 +
 hw/sensor/tmp105.c                            | 305 +++++++++++---
 include/hw/sensor/tmp105.h                    |  46 +-
 tests/functional/arm/meson.build              |   3 +
 tests/functional/arm/test_aspeed_catalina.py  | 107 ++++-
 tests/functional/arm/test_aspeed_sanmiguel.py |  72 ++++
 tests/functional/arm/test_device_locator.py   | 114 +++++
 tests/functional/aspeed.py                    |  21 +-
 tests/functional/qemu_test/locator.py         | 578 ++++++++++++++++++++++++++
 tests/functional/qemu_test/testcase.py        |   2 +-
 tests/qtest/tmp105-test.c                     | 359 ++++++++++++++++
 14 files changed, 1922 insertions(+), 121 deletions(-)
---
base-commit: 1dad7db18669f337ca0ddefa97906cd5acfed1b7
change-id: 20260729-sanmiguel-bmc-locator-db13cceae66c

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


