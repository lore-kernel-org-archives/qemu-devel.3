Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6ECC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6U1-0000i8-PP; Wed, 29 Jul 2026 11:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Ti-0000fI-UU
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:45:55 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Tf-0003C1-M0
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:45:53 -0400
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47640541585so873680f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339950; x=1785944750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OAjwt6a8vdNB+oG797ToKY41wPbzvFgL3YkCXxogL1g=;
 b=CO8u9fms3sWFETqCu0JFlpMWFQvjmOx7px/VPYikhz6E4N4TJikaH8YZvlXzMS6llS
 r93H8T3aWHUjZLmG7sj092OD+b7CXvNkEU+cf+j3ARuUMFnij7YkZq1YAqq8XuqMY0PD
 H4tGA6LSQ74CNJHmP2f/fDuEdfLgRMJmLMEZkXRTl1Nbsent7Bnt/d9lkHvnBLVW9RyQ
 IxT/JeGefITEz1ngYLwrlsKUBvijIVbp9FI/R2PyPZw4gmV9kK5Cw6sNIaqBQHSHzB5P
 EFfRFw7FKS63ZHHFWatpQ7/+fG2Jn72Wia74r6jP7ZoAffWozRSUwI2thMGuL2I/KNhx
 TQgQ==
X-Gm-Message-State: AOJu0YynxEH0x0FazGxEtnRvVlxV6v0dID+g1ERuDwcUO0Rt/qvmP0V5
 HJJCGzTDVR92kSLUWgjt/wIRd5F/ao3ItCeod8fH4eOJrvCQwXFXq2ebumS5dmVR
X-Gm-Gg: AR+sD11yWaIip7TCUIc7zNYPk0GVg+ElnGPHY2z+yQZkC7HL30jR5RMKvR+am/zfaU5
 6L8F1WUwDxEO+i2BM3+urAygo/QK3YlltHrSJW0Pqp8UlVJRC2SWYSG0OHa+tVh7dfizmYQYSe9
 JPuL9JQzz5GgKHqt1MSWX+i6Zn7w8z5uA2sZ2nMjTPYx3PFYvZT7YWXF3mMmbufHbqkXdQn/VEE
 aAxlpn2Smq47mRR6fkWwfBkWqVw7z/K7CnL+hWfVON2XR/Ew/ZqpITe4n7ye2Q28x1n74547LoK
 EaqRF4+gPnrj8Ix2XXlLQhVai3Pm3lz0j7uLlWISWG7XWSw009jHsdc/jUUJOFi1VBGX5rZdRCt
 IEfTs67bJqwkPfAB+F633mUQvq8pmnIq4Jo5jM4/pgBq9kCOQM7DZckMeT3wB+VjEon9WdozkCz
 AF8q0MbLyR9F/5z0QshdQyTpQXHi23TwDWLqvL+kkbyjYxu2aVTzHBIw5a5IMCsfoJHmA7YTZq7
 P51mzrxb1Rz4acZld06mc6mNYW6rDuJeiQy
X-Received: by 2002:a05:6000:430c:b0:47f:9201:6409 with SMTP id
 ffacd0b85a97d-47fb1f17008mr8304563f8f.40.1785339949822; 
 Wed, 29 Jul 2026 08:45:49 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa392asm8506629f8f.5.2026.07.29.08.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:45:49 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:55 +0200
Subject: [PATCH 19/25] tests/functional: add a device-locator self-check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-19-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337965; l=6533;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=jqZZfMhZoTV1zdg+ZdDlImYNATVoR6jePLxXWf0xlWU=;
 b=HYfooY7CInYj++mKmoH/0/6rc3MAbtUIUtmjuPYaLYJLZERco/dEhFEX22LL8T3UzJlOtyq9J
 fdzxwclRiVUB5VMaeyUIn3Ef5dfsTLakVvyH6k8ld4VjqANIZjiSEU3
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f51.google.com
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
 tests/functional/arm/test_device_locator.py | 114 ++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

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
index 0000000000..eea88f4fb0
--- /dev/null
+++ b/tests/functional/arm/test_device_locator.py
@@ -0,0 +1,114 @@
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


