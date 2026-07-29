Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E0DC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6Xm-00024N-93; Wed, 29 Jul 2026 11:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Xl-00023v-8V
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:50:05 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Xj-0003TI-JR
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:50:05 -0400
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so1121682f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340202; x=1785945002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=74jbyL6fPJ4k+KuBJbacmztdNW2KvwZdLLnAZhfQEFc=;
 b=g/GWUErr/eXhN/qUBH5wdrFF0xHJKgFEv+Xq5C1j82H3TfYP8YcA4yi2DVkJpDt6pE
 vu4g81egF75pTKUO26ikkJNunjK72QEUBLJ7a+XDo16npFnQW0hFMMc5bC/YteMqbgAt
 ee5Sc3LhjOg2h5Bmmnqh1hbzBmXS1RaCxb+Dz6bgrcsfufo53wkNaDcZX4E5xY3TN81E
 U3drxAk+Fwgrf0cZhy7yoowPPUUHlMKgNUbIAQTjeRUb+zxAZTL75GaUdVLskpWwBc9P
 nrWh/MUekk8gYslIXcJCLR6k9D0lptA8quWaPhcHAMfbwNsveoVxM/aeMCG5/NXNrSv8
 wCqg==
X-Gm-Message-State: AOJu0YwwPKzEK737um+FlJDmCE4Nb8aogUxE0A9+nva/DO8HgBBLuaT6
 b1oXiSBycP8qJamA2d1TWKE/yZJkFeifbaGuWl3OTiyPkgG8VSQAbQKZVcamLFhW
X-Gm-Gg: AR+sD10R6ZkcqNDQYVeICFPKzm9JfBm6nBWFHugfTjs/Ydb6SrBrBTs+YqENX/9aC2H
 b95ezSk234XromYqIdSnTHtnHSw5dOcOrsE9lEYsZVJiFoMTsGMsHok8/rufe5JBGfQMLdeUcuQ
 t9PPWaj3MDG9Sxh064l2uXnZtykeyr2z4TqPdisunpsojpbVR5Rtw4RUxFJ7wZYXi8/cmQfCDaa
 zbHwlOaDW/YDl1LXzU4emsmuqtLC8GW9RDZ+V1eZ1mujKYeZXewbWUrpxQb/fO8SOMQpXXRhP0b
 TI6iOkk7yHgCKBZ2Ebl7Y5oBOkmoY/vkAgFYQD8JtSfqbooaDIfcFhV9lke5MGEQtwpL5gcOw3Z
 6WPsO88TtcSe65AxaErf1IfGo7bbWGtY3nEUEabiQh0oRtKk0FPOq6h3btMfFYqh0/wGPN7ItFs
 3enctlrCVEPEOVB2mS7jyNHMAs+yBxdw+7mRImxzjI8iLRNSPYkR2b9jvxbwHxQzYdmbPEXeZ0z
 fvhI/SwUFWC3vQEYLd0zEq/+qaVNdJW3Mvl
X-Received: by 2002:a05:6000:2903:b0:47f:703b:1851 with SMTP id
 ffacd0b85a97d-47fb1ebc30bmr9494680f8f.59.1785340201799; 
 Wed, 29 Jul 2026 08:50:01 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0ef25sm8802118f8f.24.2026.07.29.08.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:50:01 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:58 +0200
Subject: [PATCH 22/25] tests/functional/arm: catalina: test TMP75
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-22-c8f9a8d101f6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337965; l=3329;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=ltFXNfKtRdSz7pZKawpvHBeNBUB93gRly05M45TjzOE=;
 b=b96I6KvOhE3yNyfiSzW/G2sSbG45qrIKXE/XqtrNTS4RqZuGWlJt39quP9qgp1GVT/Vwww5Eh
 jpLgJNM/0/5DQmGoKEdvfwlOVXlKLsAJIjMftfiTqJYAup5ai4XYfBZ
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f48.google.com
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

Extend the Catalina boot test to exercise the TMP75 sensor on i2c9:
confirm the guest exposes it through hwmon, then drive the temperature
over QOM and check hwmon reports the injected value back.

Address the sensor through the device locator rather than a hardcoded
QOM path.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/test_aspeed_catalina.py | 37 +++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index dc2f24e7b43..b80b5fe92b7 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -4,16 +4,30 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+import sys
+
 from qemu_test import Asset
+from qemu_test import exec_command_and_wait_for_pattern
 from aspeed import AspeedTest
 
+# DeviceLocator's type hints require Python 3.10+; import it only when
+# available. On the 3.9 baseline the module still loads and the boot
+# test still runs; only the locator-based device checks are skipped.
+if sys.version_info >= (3, 10):
+    from qemu_test.locator import DeviceLocator
+
 
 class CatalinaMachine(AspeedTest):
 
     ASSET_CATALINA_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
+        'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/'
+            'catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
         '287402e1ba021991e06be1d098f509444a02a3d81a73a932f66528b159e864f9')
 
+    TMP75_LOCATOR = "/machine/soc::aspeed.i2c-ast2600[0]~i2c[9]~tmp75@0x4b"
+    TMP75_HWMON = "/sys/bus/i2c/devices/9-004b/hwmon/hwmon*"
+    PROMPT = "root@catalina:~#"
+
     def test_arm_ast2600_catalina_openbmc(self):
         image_path = self.uncompress(self.ASSET_CATALINA_FLASH)
 
@@ -21,5 +35,26 @@ def test_arm_ast2600_catalina_openbmc(self):
                                         uboot='2019.04', cpu_id='0xf00',
                                         soc='AST2600 rev A3')
 
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc', self.PROMPT)
+
+        self.assertIn(b"tmp75", self.read_hwmon(self.TMP75_HWMON, "name"))
+
+        # The QOM round-trips below resolve devices with DeviceLocator, which
+        # require Python 3.10+; skip just those on older interpreters.
+        if sys.version_info < (3, 10):
+            return
+
+        tmp75 = DeviceLocator(self.vm.cmd).resolve(self.TMP75_LOCATOR, "tmp75")
+
+        # temp1_input reports the temperature in millidegrees Celsius. Drive it
+        # through QOM (units of 0.001 C) and check the kernel hwmon interface
+        # reports the injected value back.
+        for milli_c in (55000, 30000):
+            self.vm.cmd("qom-set", path=tmp75,
+                        property="temperature", value=milli_c)
+            self.wait_hwmon_value(self.TMP75_HWMON, "temp1_input", milli_c)
+
+
 if __name__ == '__main__':
     AspeedTest.main()

-- 
2.50.1


