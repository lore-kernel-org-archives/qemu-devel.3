Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6949DC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmgC-0007AZ-QI; Fri, 31 Jul 2026 08:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmgA-00079j-JS
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:49:34 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmg9-0002hp-6L
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:49:34 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so478530f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502172; x=1786106972;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AD/ctxxaJ0c1UGixC9zPix/cWBFWLdoXJO6RiTcZO2E=;
 b=aH68PdNJkUn0A9APOYRfMvCrLwcBbz9YkMRTCK6yJsISkfcVdTUS0VvmoyQLazlaOX
 Z83IJLtoxa5vWyrOXuoMwgTiIYNBUZ7hS3dCYYQV2M1gE5V2Kl3j8Ac06m1akZEpPNT3
 ZDTbloMfIMme9eCu4se2os3tzKZp950poSYvHGLAZQnCspixClEQg+AaD9hnpiJehLm6
 kMTeCMb9Vs0oIJRJlc+gR1SgDlc3AFTIq4bTIn/UCPsMri4GcN4wfzs10lO5/DpAGUyT
 EB6fOpTpFv/a3e6rUozKMUWE5RRvT47lswXnzhpKSLA4I3IHg9F8UWnHPJNcCYC/DnFO
 6R6g==
X-Gm-Message-State: AOJu0YwUNlnxj3i0JyaRmQm/e9BlAjaORhnGzc/TzZKHKJzAXDiQOQMT
 IzfmQmeGamRylTUj1fO/bgfYL86jJIwHvJfIkszXBSGggjPQGkRzhBu+TaiTKnFd
X-Gm-Gg: AR+sD12cbK2x3t6THBd9t9u+OXmnH6degdrz/U2+z8DCK3K2DxpLq0ATGEJd/CyRUW5
 r9btz0uNIjDDlzGu6iWfPenkM+Tr5vWqCMhXI/337d7RJAO99M3QeUm6s9ZWrz9PhSv/5cNeSi/
 zm0MGu5V1Z4TmIR1OKDaP5dyrUIwqXOJYmkaIC55DgrdSUtRsPFeAVDN+wPuTYzJE9Kr1vQxzaf
 1hDaddXQ/Gzu9s79LYi/myQLNhIxLqmKhLvM+vWjeYE5A4YViruLtge+wZ6bm78Z9oxyt/9IGVJ
 7m16geoK/ubnx/VoMxb5vkRtrnIvPoyTYDZg6hE96yldfPADaW98SyLoDBD0/CwZp9dk6iMtZ9K
 09/1DzzkKpwKCwlQ5t7yctDGmutgfgIJz0Pvg/2JQcoICn9JTRrZkx5lWGZ2q4sy69S/pFaWaCO
 QnOQmjXLqNTwTDKCSfpwiSVk2Ep4WM52mdY+HV9lLZsOgtaFS1EGqUvYKtBw9JqYrP7Pn4/0GZb
 cZ3uQQLQ3wf8KNZpUUZOODU82QAn5qNA39c
X-Received: by 2002:a05:6000:41f2:b0:47f:81fe:12f8 with SMTP id
 ffacd0b85a97d-47fd2ababd7mr4509615f8f.1.1785502171339; 
 Fri, 31 Jul 2026 05:49:31 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562a38sm4287639f8f.21.2026.07.31.05.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:49:30 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:24 +0200
Subject: [PATCH v2 25/25] tests/functional/arm: catalina: test PCA9554 IO
 expander via QOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-25-1266926ba769@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494709; l=2183;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=8aTFJBX4+2Zfb9dvqeKFk8XY5h03hnbOmzH0dpRmEzQ=;
 b=sxASZf/orReLgvIfnA0D0nVO733hUkUx7XzpQ1f1JTllPMuobgPTDxSRDpwp9zwTOzjoZvrAx
 /pnDcsHJZs6BdXFaKvfkL2A+QTQqYTP30I90MEIZ2xxT0bwsNfOou5E
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

Cover io_expander5 (pca9554@27, behind pca9548@70 channel 6 on i2c1), an
8-bit expander reached through the pca9548 mux.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/test_aspeed_catalina.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index 5624774891..f9ee62260b 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -33,6 +33,11 @@ class CatalinaMachine(AspeedTest):
     # io_expander0: pca9555@20 on i2c2, a 16-bit expander directly on the bus.
     IOEXP0_LOCATOR = "/machine/soc::aspeed.i2c-ast2600[0]~i2c[2]~pca9555@0x20"
     IOEXP0_GPIODETECT = r"\[2-0020\]"
+    # io_expander5: pca9554@27 behind pca9548@70 channel 6 on i2c1, an 8-bit
+    # expander reached through the mux; gpiodetect confirms its 8 lines.
+    IOEXP5_LOCATOR = ("/machine/soc::aspeed.i2c-ast2600[0]"
+                      "~i2c[1]~pca9548@0x70~i2c[6]~pca9554@0x27")
+    IOEXP5_GPIODETECT = r"-0027] \(8 lines\)"
 
     def test_arm_ast2600_catalina_openbmc(self):
         image_path = self.uncompress(self.ASSET_CATALINA_FLASH)
@@ -54,6 +59,7 @@ def test_arm_ast2600_catalina_openbmc(self):
         locator = DeviceLocator(self.vm.cmd)
         tmp75 = locator.resolve(self.TMP75_LOCATOR, "tmp75")
         ioexp0 = locator.resolve(self.IOEXP0_LOCATOR, "pca9555")
+        ioexp5 = locator.resolve(self.IOEXP5_LOCATOR, "pca9554")
 
         # temp1_input reports the temperature in millidegrees Celsius. Drive it
         # through QOM (units of 0.001 C) and check the kernel hwmon interface
@@ -65,6 +71,8 @@ def test_arm_ast2600_catalina_openbmc(self):
 
         # pca9555@20 spans two 8-bit ports (pins 0-7 and 8-15).
         self.check_ioexp(ioexp0, self.IOEXP0_GPIODETECT, (0, 7, 8, 15))
+        # pca9554@27 is a single 8-bit port.
+        self.check_ioexp(ioexp5, self.IOEXP5_GPIODETECT, (0, 3, 7))
 
     def check_ioexp(self, qom, gpiodetect, pins):
         # The guest drives these lines as inputs: set_pin injects an external

-- 
2.50.1


