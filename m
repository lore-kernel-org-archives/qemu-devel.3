Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD90C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6ZB-0002eW-Cb; Wed, 29 Jul 2026 11:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Z9-0002dv-KI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:51:31 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Z7-0003ib-Dd
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:51:31 -0400
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso180295e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340288; x=1785945088;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZUm9tfsjEjTtlnBZiVGDO9i7PQPNiLnEUF75edt6r8=;
 b=Vi1y2WPI9LuhddbhgYkTya+12etVvU9aBjutSdp1wRADAbzOZz0KmlltKLio1JwXP/
 Sln6FPQWLCqA1uJlCLRxiL+MyBnNww4lmNEjVyk+3FS19jnnGcWXPrrpcn7IVwhZAR2S
 wRtixuFsxAU6LonRv4XM2FIkG+4gaQC9fzwGatSJsU+UmyuD41S4Sy4qMs1yeXUHzKPy
 BERUcyEAeN1S2neKKEEO+Uam5BI/0NHLivkVfvJvs8vDOwRpxzYVa+DSLqQLw2GTti6z
 lzOffKt8BTb7Yc9c5LtU0uQkRYG50zyULlN8z9U2pdgaFyCPO/jlVfb8ZuKPtD5OxXdJ
 oa5w==
X-Gm-Message-State: AOJu0Yzu4gM3ax/5aXB1FQrTKVYHZ+ewnsvShEeQwmyAJv04rhWc0fL4
 pU47ltuiegRn60LOvN/S8k68khcd8E9Bf5KoEEmHwnkXm6+6kpRftu9KH4HT30ZZ
X-Gm-Gg: AR+sD102IupzSR4GE7jkNGH7WkvQShdjhyLjmK3Dl4Wf3Upw6RC1AmBcmWgp73YuaT9
 2BOdXHMohHPiSCt9+iWkdsI+sGyX9UL+sSEPWERY8dDL4T4OQGpcdmaTYco6xHsz/j8zmJGy2hM
 KLgMaXDGxMGyMwPApfQQRnfubnwoXACFstGK9xtwtvB2avCJjgA0cO3tugGfR4c+cj/P2YYP74F
 s7j4Nj6WeuT7fM47sj49KEJt6P19d4SpSfb1toTNy2fufcYrTcJVgCTxjW0D0YAspf20avqatSF
 T/VEVbmMraHW/qWwyv8NosO6/8tt+gIS2EINipJsaxWeWmpiSPq02XqbTROOXiuNgnDydbxN3aC
 y8b5a9A3RzYPHwUhhb5pouICjtuv6uMEIs7v/DTkslZx5xo+nZw/8708k2tNPiztlVY6GGXp3WD
 rWHqn3sePJWu1uQP6iJMN5ldSl4Z9+XhH8JSNHnrp0aqj90eZj3oK3Bj09sOlk0+DGz56Fua/mC
 Q4/kUF/ZEWJ8U57pY4BR6lLPfsu4yj7qm/n
X-Received: by 2002:a05:600c:4746:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-497fd2f50bbmr29949825e9.3.1785340287675; 
 Wed, 29 Jul 2026 08:51:27 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd83fabsm67580295e9.15.2026.07.29.08.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:51:27 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:59 +0200
Subject: [PATCH 23/25] tests/functional/arm: catalina: test PCA9555 IO
 expander via QOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-23-c8f9a8d101f6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337965; l=4869;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=x+swaeJ/f66FZ473PfGW+ic8eASLYIskyDGJo0YAj4k=;
 b=L2VjD8kMI40onDaVTPP/4MaReFi085o/rT1wZ2U7xAYYJ/98Vm7oKDkvClup9EVTwfq7WB5Bm
 VqGK1rrbdd6DI7w3UrzkqIT/QJ3C2ofhun0yaZ47z7+3bEyvOJPr0X5
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.42; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f42.google.com
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


