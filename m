Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CE7C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmHQ-000856-JC; Fri, 31 Jul 2026 08:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmHN-00084a-9p
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:23:58 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmHJ-0006JA-G4
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:23:57 -0400
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f81a3ccf9so830493f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500631; x=1786105431;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eOoGRyHrO9cFf4sS9SjdV6hFE7ech7NtIIc2u170zA0=;
 b=PUCsuDGVQ4BReZvKuIxc930bcTl8rQPXNbWjQmM5DrfL5aXB20dn91S6MAGFpoVyHj
 FUR9fNeGORky9DsZPDNaHPIljA148helQrQK09tlsJ2jYO6d2IAHNJ4H6NrwqrJ1nXx0
 HmHLWiQtc1RA9PHEWhdd4vP5PLDayx6Fwx3whdxcoaEMQ/jPClpG2Bix2IdS2gAHncAo
 PJyz51FHbrOP/88wXm6r9YbF2OCujwbxn2mwPxuhex7oj5Aqbn9GqatYgj6BGbuT90Gp
 pUDQwX4AuBCbDqSYBb962tNfxc9NsKhGuoee/qlX2/d3M0RbvWGH2fTZHHKesR91tQC+
 mddQ==
X-Gm-Message-State: AOJu0YzcTrYyg2mQBt7kmOpJZX2iTvyb1QAokKwpI97U77W1lIjWLUc6
 3EFc+JTx0yT4iwne0g4uHgKq4h43EDb+8xJNNjapG3pjNS1YSU7KaWCfImw7YJH9
X-Gm-Gg: AR+sD12v9eo20CgcLavu07JH+BerhyQT7hC+6NCXmDw3MIX0hv8Ri3eeY9j3KawzssT
 uO0Pcl8x1qTTQh1jyEyUNuhVPOAaUtLDZRA2ZmcM2q2ejkoP5TJji1SP5lT4pN6YiY2+hHIikFU
 xCRpx4FwYV6weIeHO3OipC7ZnmTGZDTQm1DdjmhNiDp45NPy27Wg79hmV5HqZs01ZoVxKj1Mnrs
 rooCqduLi4ginBA9P6TTCIc3x8PWPoYHN4xvEVl4wtmf24a/0rY6USkhdNkldqYLIrigFKsaI/F
 8wcxl88MzPABF5rIceMATAkHrAcUa37hud4PntQlOaKMpeEKIh1C/acFpTTFmOZ+g6AbblUVoDF
 WZ9nPsKdfPI66VY34dHUokn+5qJjX3SPjVwh3UEDKstTB5mVH8vhGbmhyKVGldX9eKQ0EmH6gkt
 WdM00efrIuTXRHdbYoSmjWJJb7rcEJn3UxhSMHU6Jlnp5Xu6UXfab1iTvmyLIcDz/qOHedTY8tM
 WcOxuFGIkRxHVFpxMwDsRU70+YI2wixIx+z
X-Received: by 2002:a05:6000:41f7:b0:47f:6f89:7dae with SMTP id
 ffacd0b85a97d-47fd2abbe13mr4527356f8f.6.1785500630960; 
 Fri, 31 Jul 2026 05:23:50 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1956sm5021147f8f.6.2026.07.31.05.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:23:50 -0700 (PDT)
Subject: [PATCH v2 00/25] hw/arm: Facebook SanMiguel BMC and TMP75-family
 sensors
Date: Fri, 31 Jul 2026 12:44:59 +0200
Message-Id: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0Jm7Zi2JhVceQ/DogxTGMOPaYFoC
 He34AFcvuR731shchCOcMtWCLxIlHFIYE4ZUOuGhlHqxGCUsepqCoxu6KWZucOqJ+xGctMYsK7
 0hYgdW0uQ3FdgL+/j91H+OM7Vk2naz/ZFKzGJnyO86H33r7FoVEi5L1xea6W9vfvAfPYBym3bv
 mM13wrKAAAA
X-Change-ID: 20260729-sanmiguel-bmc-locator-db13cceae66c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494706; l=7224;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=7HOkm3CMt7gGysjP5DCQnPMccdlemAantNAgZ3eFvPE=;
 b=NBsFPZyJQ9JyCoMXNjrBZWdRkXDO/w1LDFb2SCeETglDRGb427zwF62Qwno5p+vD4QN6nsjAO
 IANVYTSpy8gAgw9BTUjsFR2bNzhN+ForkLltF7dvJwAB9p5yyuD7b+o
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f54.google.com
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
---
Changes in v2:
- Simplify TMP105 multiple variant initialization
- Improve reliability against malformed device locator strings
- Remove an obsolete reference to INA23x devices from a commit log message
- Rebase patch series on aspeed-next branch
- Fix invalid JSON syntax in SanMiguel FRU descriptions
- Link to v1: https://lore.kernel.org/qemu-devel/20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr

To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Kane Chen <kane_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <th.huth+qemu@posteo.eu>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>

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
 hw/sensor/tmp105.c                            | 304 ++++++++++---
 include/hw/sensor/tmp105.h                    |  46 +-
 tests/functional/arm/meson.build              |   3 +
 tests/functional/arm/test_aspeed_catalina.py  | 107 ++++-
 tests/functional/arm/test_aspeed_sanmiguel.py |  72 ++++
 tests/functional/arm/test_device_locator.py   | 120 ++++++
 tests/functional/aspeed.py                    |  21 +-
 tests/functional/qemu_test/locator.py         | 586 ++++++++++++++++++++++++++
 tests/functional/qemu_test/testcase.py        |   2 +-
 tests/qtest/tmp105-test.c                     | 359 ++++++++++++++++
 14 files changed, 1934 insertions(+), 122 deletions(-)
---
base-commit: e5d3f5ac8633de310066f14862b17e4cac8ef8a5
change-id: 20260729-sanmiguel-bmc-locator-db13cceae66c

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


