Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0667BC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmeD-0005vg-DR; Fri, 31 Jul 2026 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmeB-0005v9-3Q
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:47:31 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpme9-0002Qv-Ey
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:47:30 -0400
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso852677f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502048; x=1786106848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZUm9tfsjEjTtlnBZiVGDO9i7PQPNiLnEUF75edt6r8=;
 b=I9+pWcVHnGazWqxweaJxM4EfQWWAUTB0FsVHnhADVQ1CsiRcSAX0b+LaokAJks9Cpp
 R6vatFUYGYZmDGj6InbFqJUzK6oVddl3oLybNIhVhI9zFDLzF5MDLfxBYQ4CqTpkvmPI
 M7n+OKmQsORVQFrvrz8bn6+ly/yroryiI3Czv4ll9sBJVi/fRxfFq0NJ+oGxtjUENQhq
 UE9IwoJaJF+s4DVIzK0G1SQ+i2L8+JTb69wayECKbWJZOH3wJ+AdMKfPdOMIMraxPE0C
 sE+D1K46h8ZEL90XZmnlzwO1gZFNh6ZnvExcMhX5+p8l5Rc+bPMM6o98BZ6cNyrXJeHO
 G9cQ==
X-Gm-Message-State: AOJu0Yxm3Colva4ufwqUKI9qp4lw1WBZhwKfmd+PPifRAIWFvMVAjG5E
 FyCHCQMQr/+ndZSEXtpnZRlHrwIflNG0SVE/XYOm/EdBIj5K0xrSOtyGd7LS1LQD
X-Gm-Gg: AR+sD11f19fXAKxNvRXbKXoZqe0Awe3GY7KP8+pQ/k+F97VaGVjA+mhSXm2ojKH1SK3
 0kwMm9VPKHsVEZmLVlDlHgQUUfZjigcewSwIBlFf8468F8rUTbVG+HP5YjUfg/bEsnH/Wbce/09
 5m7w6wwtc7p09MaOi3Vc0tiLY8wpn3Fvh+7g1Jfj720eEqYssf20TG+6KTN5gVEq5/dMhAU0qTr
 Vi9OYJYjo4ZGWVygt2DhKgnDgJ+JlXLE5OTr3EWkQrL0ZJzY149BKpfHA25C7mE0ayML/ajlzOr
 YHWksj4eydkN0DNdJIJS49IKVI9CCMNh9wOex+R05gMVXw67GZIqGTprEHwc8i9BVSNgZpSS0gl
 UsEJVAxw2C/gkj9Oea0oRNtlLLgT1iGwwvlMrbvfh/ONv3BIzkzLlVzpXoe3tD/xtLf8LB4gP2p
 POUN+FLV/Gr6Fd6mIbvP8mAm5hB0g99FecFsYLaeCRVqDoQGjiN5Lg/lYB/hnAyNJyLWHr0JUaD
 CqfjrSEOUYW4NDUPDCmGmoX6fSk3yIVWXGN
X-Received: by 2002:a05:6000:26c6:b0:47f:8602:6887 with SMTP id
 ffacd0b85a97d-47fd2abbd22mr4396387f8f.11.1785502047747; 
 Fri, 31 Jul 2026 05:47:27 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41cfdc6sm4551569f8f.8.2026.07.31.05.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:47:26 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:22 +0200
Subject: [PATCH v2 23/25] tests/functional/arm: catalina: test PCA9555 IO
 expander via QOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-23-1266926ba769@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494709; l=4869;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=x+swaeJ/f66FZ473PfGW+ic8eASLYIskyDGJo0YAj4k=;
 b=0b2Wssm2cNo4eQUPjiEQSBC0k5BbJ9x4kQv3WSzBE/mJQe+0GcFP1mMIpeDix6eXvFcAATC70
 lDw7wWWBhD8ANZ2V/ToIS1O13tC6tk+VoRvRTbqlpvZ2wX1RFGp038K
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.45; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f45.google.com
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

Drive the io_expander0 (pca9555@20 on i2c2) input pins from the host
through the pin%d QOM properties and read each one back both via qom-get
and via the guest kernel gpiochip (libgpiod), spanning both 8-bit ports
and both ends, then check two pins on different ports are reported
independently.

Introduce a check_ioexp() helper doing that round-trip so further
expanders can reuse it. Address the expander through the device locator
rather than a hardcoded QOM path.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/test_aspeed_catalina.py | 64 +++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index b80b5fe92b..5624774891 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -2,6 +2,8 @@
 #
 # Functional test that boots the ASPEED machines
 #
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import sys
@@ -28,6 +30,10 @@ class CatalinaMachine(AspeedTest):
     TMP75_HWMON = "/sys/bus/i2c/devices/9-004b/hwmon/hwmon*"
     PROMPT = "root@catalina:~#"
 
+    # io_expander0: pca9555@20 on i2c2, a 16-bit expander directly on the bus.
+    IOEXP0_LOCATOR = "/machine/soc::aspeed.i2c-ast2600[0]~i2c[2]~pca9555@0x20"
+    IOEXP0_GPIODETECT = r"\[2-0020\]"
+
     def test_arm_ast2600_catalina_openbmc(self):
         image_path = self.uncompress(self.ASSET_CATALINA_FLASH)
 
@@ -45,7 +51,9 @@ def test_arm_ast2600_catalina_openbmc(self):
         if sys.version_info < (3, 10):
             return
 
-        tmp75 = DeviceLocator(self.vm.cmd).resolve(self.TMP75_LOCATOR, "tmp75")
+        locator = DeviceLocator(self.vm.cmd)
+        tmp75 = locator.resolve(self.TMP75_LOCATOR, "tmp75")
+        ioexp0 = locator.resolve(self.IOEXP0_LOCATOR, "pca9555")
 
         # temp1_input reports the temperature in millidegrees Celsius. Drive it
         # through QOM (units of 0.001 C) and check the kernel hwmon interface
@@ -55,6 +63,60 @@ def test_arm_ast2600_catalina_openbmc(self):
                         property="temperature", value=milli_c)
             self.wait_hwmon_value(self.TMP75_HWMON, "temp1_input", milli_c)
 
+        # pca9555@20 spans two 8-bit ports (pins 0-7 and 8-15).
+        self.check_ioexp(ioexp0, self.IOEXP0_GPIODETECT, (0, 7, 8, 15))
+
+    def check_ioexp(self, qom, gpiodetect, pins):
+        # The guest drives these lines as inputs: set_pin injects an external
+        # level, read back over QOM and gpioget. Outputs are covered by qtests.
+        chip = self.resolve_gpiochip(gpiodetect)
+        for pin in pins:
+            self.set_pin(qom, pin, "low")
+            self.assert_pin(qom, pin, "low")
+            self.assert_gpio_line(chip, pin, 0)
+            self.set_pin(qom, pin, "high")
+            self.assert_pin(qom, pin, "high")
+            self.assert_gpio_line(chip, pin, 1)
+
+        # Drive two pins to opposite levels at once to confirm they are
+        # reported back independently.
+        lo, hi = pins[0], pins[-1]
+        self.set_pin(qom, lo, "low")
+        self.set_pin(qom, hi, "high")
+        self.assert_pin(qom, lo, "low")
+        self.assert_pin(qom, hi, "high")
+        self.assert_gpio_line(chip, lo, 0)
+        self.assert_gpio_line(chip, hi, 1)
+
+    def read_catalina_console(self, command):
+        return exec_command_and_wait_for_pattern(self, command, self.PROMPT)
+
+    def resolve_gpiochip(self, gpiodetect):
+        # awk already prints the "gpiochipN" name; just pick it out of the
+        # console output (the command echo and prompt hold no such token).
+        out = self.read_catalina_console(
+            f"gpiodetect | awk '/{gpiodetect}/{{print $1}}'")
+        for token in out.split():
+            if token.startswith(b"gpiochip"):
+                return token.decode()
+        self.fail(f"could not resolve gpiochip {gpiodetect}")
+
+    def set_pin(self, qom, pin, level):
+        self.vm.cmd("qom-set", path=qom, property=f"pin{pin}", value=level)
+
+    def get_pin(self, qom, pin):
+        return self.vm.cmd("qom-get", path=qom, property=f"pin{pin}")
+
+    def assert_pin(self, qom, pin, expected):
+        level = self.get_pin(qom, pin)
+        self.assertEqual(level, expected,
+                         f"pin{pin} QOM read {level!r}, expected {expected!r}")
+
+    def assert_gpio_line(self, chip, pin, expected):
+        out = self.read_catalina_console(
+            f"echo LINE{pin}=$(gpioget {chip} {pin})")
+        self.assertIn(f"LINE{pin}={expected}".encode(), out)
+
 
 if __name__ == '__main__':
     AspeedTest.main()

-- 
2.50.1


