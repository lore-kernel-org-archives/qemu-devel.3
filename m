Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C104BC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6WY-0001KW-Cv; Wed, 29 Jul 2026 11:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6WW-0001JE-TB
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:48:48 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6WU-0003Nm-L5
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:48:48 -0400
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so754514f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340125; x=1785944925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7GAlPRK+FUlIvHrrHmY3hq8ta1s+tUUrFH5KYLEatV8=;
 b=csWm5D8PQDL9wW2q4tRWlKRdw1fmjgeUFKmqEL4mwxgP1rIfPZ+bqtEotk93O4aQiC
 FB27q6pi+2qhZw+5wCN7qAs8EL5lSjbHFB8gk+dtBpEwaAfIUcfx2xB60s9X0NJ9P3s/
 /9TgwN//wnxnAvpVGreCwiBCQQ2kYkB8SsOyImM9//RZacUDnn0qpbNqIJ/V9Xw0qzSx
 2wQETtcuHzXuII4HOnwTp3mrXVZ81v1JwP8w4OnxBTfwsUpXmgxIdZDsrEeKrAxUmBdo
 Z6L+ErCyOlKHi0JEdxvvHmeXrqb6Fls2OuCEFP3aiODZ4oG/vOoa2jOsHAmBwl8kNMs/
 VVgg==
X-Gm-Message-State: AOJu0YwYoalWODOwFoH/zr/jUw9wuSiCqRfmNebwp2Pp2NRcdzuZWWSj
 bupptRM8v0CAqy1wllqOrJaK6GEUor0Fbho5yyHK4Lm65louT8F8rXGg06eWBG4+
X-Gm-Gg: AR+sD13tjafipDHlGS89f+POZhmrByEn25cXRSc2tWyaQbzQ32IlNf2GqjXc24eeYQC
 twa292rZt7zLPnwZu/Z92jlx0b7YwOBT/QXeY7O2ybRgCEhA1+HENcnIF7XweN36bROYBXSLg1l
 2o4s1DnUy68ikH8lkV4XD11TLxwLjMRUeokLlGNVZaXOfwG5kvmFqbHXxQOgq0kC0FldpC+A2bp
 HtqiN/j1xbqbW0Y4bpEsgOMgakN7tSkPhnh6pVQRDumwPww6N08k8tYdqJu1For+iq/wg0lODtK
 DzXBKAKfMgXcczoj3WNeZOjA+LFaJvEWtgBA0h2EtfZzndBltZrM8p3Ke+QCPtBq4vt858m3+h2
 gR771mWHoB3GzYRqfaSJ/A41oPgPAaTzpv5/6fo/pmzPwBerJeNiH4YAkHVFN8U7zgfNEVoP4ET
 Bm35rZCXD93heFJHlND0n7MTkWHc2swjXeQ3kFDmvdEcoGJMmSDLu+7R9F8bpLhnRJAfl4d9oC3
 WCOh5i7D3k/D+Ak7bsnrIlIcmLSm8VxsZRF+V5AF9YCTKU=
X-Received: by 2002:a05:600c:468c:b0:495:4dea:f7f5 with SMTP id
 5b1f17b1804b1-496c6596732mr77723795e9.29.1785340125051; 
 Wed, 29 Jul 2026 08:48:45 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d70042sm62675855e9.1.2026.07.29.08.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:48:44 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:57 +0200
Subject: [PATCH 21/25] tests/functional/arm: sanmiguel: add BMC boot test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-21-c8f9a8d101f6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337965; l=4763;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=3rFxFx4Yry9jkNAk1yr11//RJi6X7ARRmYJTQcfmW/U=;
 b=KQtHSzxysOyeJ4kdFcQR4UiRWC94/4/00yygclSP5yjIKXD/qMKoZp54ixgMpqKhCbQw84d3C
 tctODHch6dzBPKGQQi0n3fIwsuFfaTfpzdIxqxn9vcuzcWKX5qJmZiM
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

Boot the SanMiguel BMC from its OpenBMC image and exercise its three
TMP75 sensors: inject a temperature into each over QOM and check the
guest hwmon interface reports it back.

Address the sensors through the device locator rather than hardcoded QOM
paths.

The boot image is currently hosted in a personal fork
(github.com/eblot/qemu-aspeed-boot); the asset URL will be updated to
the Aspeed maintainer repository (github.com/legoater/qemu-aspeed-boot)
once the machine image is accepted there.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/meson.build              |  2 +
 tests/functional/arm/test_aspeed_sanmiguel.py | 72 +++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index bb78dcf3e4..4b263dd3e0 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -17,6 +17,7 @@ test_arm_timeouts = {
   'aspeed_catalina' : 480,
   'aspeed_gb200nvl_bmc' : 480,
   'aspeed_rainier' : 480,
+  'aspeed_sanmiguel' : 480,
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
@@ -53,6 +54,7 @@ tests_arm_system_thorough = [
   'aspeed_catalina',
   'aspeed_gb200nvl_bmc',
   'aspeed_rainier',
+  'aspeed_sanmiguel',
   'bpim2u',
   'canona1100',
   'collie',
diff --git a/tests/functional/arm/test_aspeed_sanmiguel.py b/tests/functional/arm/test_aspeed_sanmiguel.py
new file mode 100644
index 0000000000..3d35e4aa86
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_sanmiguel.py
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the Facebook SanMiguel BMC machine
+#
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+
+from qemu_test import Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from aspeed import AspeedTest
+
+# DeviceLocator's type hints require Python 3.10+; import it only when
+# available. On the 3.9 baseline the module still loads and the boot
+# test still runs; only the locator-based sensor checks are skipped.
+if sys.version_info >= (3, 10):
+    from qemu_test.locator import DeviceLocator
+
+
+class SanMiguelMachine(AspeedTest):
+
+    ASSET_SANMIGUEL_FLASH = Asset(
+        'https://github.com/eblot/qemu-aspeed-boot/raw/5a972e968856bdf0493e4040ccc70455d1879511/images/'
+            'sanmiguel-bmc/openbmc-20260616025450/obmc-phosphor-image-sanmiguel-20260616025450.static.mtd.xz',
+        'f0b79a09cd861d79919facc16af1dbdc85a3df55b06dd62ba0318a01580d447b')
+
+    TMP75_SENSORS = (
+        ('/machine/soc::aspeed.i2c-ast2600[0]~i2c[5]~tmp75@0x48',
+         '/sys/bus/i2c/devices/5-0048/hwmon/hwmon*'),
+        ('/machine/soc::aspeed.i2c-ast2600[0]~i2c[9]~tmp75@0x4e',
+         '/sys/bus/i2c/devices/9-004e/hwmon/hwmon*'),
+        ('/machine/soc::aspeed.i2c-ast2600[0]~i2c[10]~tmp75@0x48',
+         '/sys/bus/i2c/devices/10-0048/hwmon/hwmon*'),
+    )
+    PROMPT = 'root@sanmiguel:~#'
+
+    def test_arm_ast2600_sanmiguel_openbmc(self):
+        image_path = self.uncompress(self.ASSET_SANMIGUEL_FLASH)
+
+        self.do_test_arm_aspeed_openbmc('sanmiguel-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3',
+                                        dt_model='Facebook SanMiguel BMC')
+
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc', self.PROMPT)
+
+        # The sensor round-trip below resolves devices with DeviceLocator, which
+        # requires Python 3.10+; skip just that part on older interpreters.
+        if sys.version_info < (3, 10):
+            return
+
+        locator = DeviceLocator(self.vm.cmd)
+
+        # Drive each sensor through QOM and check the kernel hwmon interface
+        # reports it back; a distinct 0.5 C per-sensor step (the finest the
+        # TMP75 register round-trips at any resolution) catches a mis-resolved
+        # locator hitting the wrong sensor.
+        for idx, (sensor, hwmon) in enumerate(self.TMP75_SENSORS):
+            path = locator.resolve(sensor, 'tmp75')
+            self.assertIn(b'lm75', self.read_hwmon(hwmon, 'name'))
+            offset = idx * 500
+            for milli_c in (55000 + offset, 30000 + offset):
+                self.vm.cmd('qom-set', path=path,
+                            property='temperature', value=milli_c)
+                self.wait_hwmon_value(hwmon, 'temp1_input', milli_c)
+
+
+if __name__ == '__main__':
+    AspeedTest.main()

-- 
2.50.1


