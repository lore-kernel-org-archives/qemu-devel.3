Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AA0C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmaP-0003NH-LG; Fri, 31 Jul 2026 08:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmaF-0003MV-1r
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:43:27 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmaB-0001qN-SR
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:43:25 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso987129f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501801; x=1786106601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l2SVqIwGhCh0aGG62l0hZRpsX29ER4xON3j7toIj5yE=;
 b=IPPxow9IxJgusitdGmr0Xr1c3NbanfKwCycI8BoTWjqumq52pc/KG2TI6TXPTIMF3j
 +owfl/5PHqYg3psHgbfyiaBPv/OEKVc3ideCHewaQFDA6TppKC1mBLvobggw8CxgA1Vu
 TdAI9Nh8P0Sjz5w1QOSG3sb/F95W6fM22hx9F/4AYbhx8iG8Iv/N9dmB+KUaWMVn2wPt
 hEedoEDg/OK2IC0wjPOFY3KlThktoqgV4aFdpKq/Y1Vbq4ZsbcOYaxF/uKyBbuW3pA4y
 gSN7qmOI5x0ZsCJETXZyCnqd0nnaedCYRONkXimZl2L4gWkfDX7riPgEOruTlKHw2QJI
 gW/Q==
X-Gm-Message-State: AOJu0YxnkgQaQD3AcJWCbwi0fNAriHE18WcNWCi3dE7BtVfjy1YpTmxr
 sZkI/HsLj5scDMUwXBClMIlC7gCurUKqE3hcpon1O/H7DOt3RPbWtUWukjfIqE6h
X-Gm-Gg: AR+sD12cRuQmDj1jnZIRfAj7dAIKyNaOoNagDktkG536xbI7kbhii1VBsBpNU3C+zIB
 EYDqRwHOshu/vcgEsZEmRk2V+EAdcg5cP/MMG5Ops7v8lLciTA+1slcSzeME9DP44dI65wKa6w0
 775fT8GLWeZhzL0+aNC/VjrXUxark7vbm3gEH5lTlssJVEHg+P/f4H7r4X7PDeplm4gQQnj2FWs
 GMHAhL0pYsTO6et6RpLaXKa7m3/RY9OtDvfguz1sagpl0aiR+vcaOA8tPUZmkqGAv2VjcO9gZP9
 zxCxs1fGhTDbM3hc12LTgVJZXCeqd0G8mpaJ1mEzr0ItSkjiwEs0jT9DfYiDSaK5tTp0EKjhQrg
 oknstxd2ZUNbTW6msvMZLxTJO2fNJTftGY1oBLy8EefnpG0BhR9J6xgxdUucR1gdEoN7LoHSdF/
 DopORBmxgGYi5WQAH7DnwJNlbq0eZ4VmJ/2j4tIqEvuQz1dOLD3S8ZhvRioLWj8WEmPYENF7UIS
 QWBXKhzpxlbQiYntsyc2DVFMfNuvue6+BkA
X-Received: by 2002:a05:6000:98c:b0:47e:81aa:3822 with SMTP id
 ffacd0b85a97d-47fd2b55d4bmr4499175f8f.42.1785501801126; 
 Fri, 31 Jul 2026 05:43:21 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562667sm4789106f8f.24.2026.07.31.05.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:43:20 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:18 +0200
Subject: [PATCH v2 19/25] tests/functional: add a device-locator self-check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-19-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494709; l=6877;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=8djowPyyHWeRrKEsZJKnuEQSt7974+p7xfk0OhdHwns=;
 b=U2tx5gorde8hrfpMa4EKyeWT8dHMHkEDQz2x4gGHn3gwx2aMnKTuUPPm8La5W8YWm6U0lJO7k
 O7JAJ1uhgJRAFwLihUuWmsoikTM6Y0r/dK/m/NzV+jFx3diBmiYfIaA
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f49.google.com
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

Launch the SanMiguel BMC paused (-S) and resolve its I2C temperature
sensors and SPI flashes by position over QMP, exercising the
DeviceLocator grammar: controller/bus hops, the
address/type/on-bus-index selectors, the leaf type assertion and the
ambiguous/unknown/out-of-range error paths.

The test needs no disk image and completes in about a second, so it
joins the quick arm test set.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/meson.build            |   1 +
 tests/functional/arm/test_device_locator.py | 120 ++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..bb78dcf3e4 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -29,6 +29,7 @@ test_arm_timeouts = {
 }
 
 tests_arm_system_quick = [
+  'device_locator',
   'migration',
 ]
 
diff --git a/tests/functional/arm/test_device_locator.py b/tests/functional/arm/test_device_locator.py
new file mode 100644
index 0000000000..3807a49361
--- /dev/null
+++ b/tests/functional/arm/test_device_locator.py
@@ -0,0 +1,120 @@
+#!/usr/bin/env python3
+#
+# Functional self-check for the pure-Python DeviceLocator helper.
+#
+# It launches the SanMiguel BMC paused (-S) and resolves its I2C sensors and
+# SPI flashes by position over QMP, so it needs no disk image and runs in
+# about a second.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+
+from unittest import skipIf
+
+from qemu_test import QemuSystemTest
+
+# DeviceLocator's type hints require Python 3.10+; import it only when
+# available so this module still loads (and skips) on the 3.9 baseline.
+if sys.version_info >= (3, 10):
+    from qemu_test.locator import DeviceLocator, LocatorError
+
+
+@skipIf(sys.version_info < (3, 10), 'DeviceLocator requires Python 3.10+')
+class DeviceLocatorTest(QemuSystemTest):
+
+    def setUp(self):
+        super().setUp()
+        self.set_machine('sanmiguel-bmc')
+        # Launch paused with defaults enabled so the aspeed board instantiates
+        # its SPI flashes (created only under defaults_enabled()); still no
+        # disk image is needed.
+        self.vm.add_args('-S', '-display', 'none')
+        self.vm.launch()
+        self.locator = DeviceLocator(self.vm.cmd)
+
+    def _address(self, path):
+        return self.vm.cmd('qom-get', path=path, property='address')
+
+    def _cs(self, path):
+        return self.vm.cmd('qom-get', path=path, property='cs')
+
+    def test_resolve_tmp75_sensors(self):
+        # The SanMiguel board wires ti,tmp75 sensors on I2C buses 5, 9 and 10
+        # behind the aspeed.i2c-ast2600 controller.
+        ctrl = '/machine/soc::aspeed.i2c-ast2600[0]'
+        for locator, addr in ((f'{ctrl}~i2c[5]~@0x48', 0x48),
+                              (f'{ctrl}~i2c[9]~@0x4e', 0x4e),
+                              (f'{ctrl}~i2c[10]~@0x48', 0x48)):
+            path = self.locator.resolve(locator, 'tmp75')
+            self.assertEqual(self._address(path), addr)
+
+    def test_device_selectors(self):
+        bus = '/machine/soc::aspeed.i2c-ast2600[0]~i2c[5]'
+        by_addr = self.locator.resolve(f'{bus}~@0x48')
+        # A type selector combined with the address must reach the same device.
+        self.assertEqual(self.locator.resolve(f'{bus}~tmp75@0x48'), by_addr)
+        # The on-bus (BusChild) index selector addresses a device positionally.
+        by_index = self.locator.resolve(f'{bus}~#0')
+        self.assertTrue(by_index.startswith('/machine'))
+        # A bus hop also accepts the raw bus QOM type in place of the keyword.
+        raw = '/machine/soc::aspeed.i2c-ast2600[0]~i2c-bus[5]~@0x48'
+        self.assertEqual(self.locator.resolve(raw), by_addr)
+
+    def test_type_assertion(self):
+        # The leaf type is validated when a type argument is passed.
+        self.assertRaises(LocatorError, self.locator.resolve,
+                          '/machine/soc::aspeed.i2c-ast2600[0]~i2c[5]~@0x48',
+                          'ds1338')
+
+    def test_resolution_errors(self):
+        ctrl = '/machine/soc::aspeed.i2c-ast2600[0]'
+        # No device sits at that address on the bus.
+        self.assertRaises(LocatorError, self.locator.resolve,
+                          f'{ctrl}~i2c[5]~@0x99')
+        # A bare bus hop under /machine/soc spans every i2c bus on both the
+        # i2c and i3c controllers, so it is ambiguous without a controller hop.
+        self.assertRaises(LocatorError, self.locator.resolve,
+                          '/machine/soc::i2c')
+        # Unknown object type in a controller hop.
+        self.assertRaises(LocatorError, self.locator.resolve,
+                          '/machine/soc::nope')
+        # Out-of-range bus index.
+        self.assertRaises(LocatorError, self.locator.resolve,
+                          f'{ctrl}~i2c[99]~@0x48')
+        # A stray or doubled '~' yields an empty hop, which is malformed.
+        self.assertRaises(LocatorError, self.locator.resolve,
+                          f'{ctrl}~~i2c[5]~@0x48')
+        # A repeated or empty device selector is malformed, not last-wins.
+        for bad in (f'{ctrl}~i2c[5]~@0x48@0x4e',
+                    f'{ctrl}~i2c[5]~#0#1',
+                    f'{ctrl}~i2c[5]~tmp75=a=b',
+                    f'{ctrl}~i2c[5]~tmp75='):
+            self.assertRaises(LocatorError, self.locator.resolve, bad)
+
+    def test_resolve_spi_flashes(self):
+        # The FMC controller carries two flashes on chip-selects 0 and 1; the
+        # first SPI controller carries one on chip-select 0.
+        for locator, cs in (
+                ('/machine/soc::aspeed.fmc-ast2600[0]~spi[0]~@0', 0),
+                ('/machine/soc::aspeed.fmc-ast2600[0]~spi[0]~@1', 1),
+                ('/machine/soc::aspeed.spi1-ast2600[0]~spi[0]~@0', 0)):
+            path = self.locator.resolve(locator, 'ssi-peripheral')
+            self.assertEqual(self._cs(path), cs)
+
+    def test_spi_selectors(self):
+        bus = '/machine/soc::aspeed.fmc-ast2600[0]~spi[0]'
+        by_cs = self.locator.resolve(f'{bus}~@0')
+        # A type selector plus the chip-select reaches the same flash.
+        self.assertEqual(
+            self.locator.resolve(f'{bus}~ssi-peripheral@0'), by_cs)
+        # The on-bus index selector resolves positionally.
+        self.assertTrue(
+            self.locator.resolve(f'{bus}~#1').startswith('/machine'))
+        # A wrong-type assertion on an SPI leaf is rejected.
+        self.assertRaises(LocatorError, self.locator.resolve,
+                          f'{bus}~@0', 'tmp75')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()

-- 
2.50.1


