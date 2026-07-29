Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD17C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6WA-0001CI-M6; Wed, 29 Jul 2026 11:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6W9-0001CA-BJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:48:25 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6W7-0003ME-Rp
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:48:25 -0400
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso12548785e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340102; x=1785944902;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ltDudjYe8pxHl7XxlWpSMq7ZVdlJnNvkY4t3t1H/f4=;
 b=ohl82RqbmA0rf12xBOO/JZ8ad1SwZay65Ulp35oAfT9SIiOIVJJsxKJpKXFuI+HNfN
 mXSlgHHXjTNTHFwPCQ7qdfifrikknbkL0FOHHnD/A+JYq0SEoAMRT8aovsgIKWlwQftC
 gSiHc0GbCZFpkaFW31O792hPK3ppilyCMlw2RctRfThvjYwfjBOMZVYllJeA4GJwZz7E
 Km0c+G9+fM8iK24WAU+lu9PKUWNPwfxQIsfxImTaz6ZPQ+LvaTIbaF+IcXtorbNlcksR
 D7WkrL5YroHMwNOWIr9+So43OlBB3HWR+sd0n558+sMhalSBn2oJMEDvByezVhoINnM6
 43Sw==
X-Gm-Message-State: AOJu0Yx+6ahFUF+mahDexADzbyGj2KomC7o8NIkAUBi3DGO10GXeA6Uk
 oCJvAU4PPiB0YRb3CApCfSqCHFoY/GzaYkOPiuZu9454KXY+EDOlk20ZuTlaNTYN
X-Gm-Gg: AR+sD12na/kMlmOo+5JVPzJ83WLNq5o7jhwMrkvIfhwMchyPoHi0NZ75D+Q/16pG1IX
 MBq1ERDQu3VdjWdteHgcsvvntOaZaDEKve6N8nxnPSYN7oeqO4bFF1r/JuQnhYhNTm9UIfPzdA7
 u4V+gn+/KQsyRENT/iAMXmsmc4kjlb84l/IZHAtc3ufYd/r7h6/hVuPAtu7Lwbxn2g+ccpzSmPf
 8LOtqWMwLwttfNR29Va3Sxrw6YUh5IpYWqcVHIBFzDbzHYPLCg0rnrWvlovVrcG58EWN97LhR/W
 5x6raPEBMkCpLAO19uc17Vx8odAP3K4G0zDQqr6/fLY4QndFFrwRpCqt5ybviz2OXWTtsx+a9c9
 5fYjERf8BqS7aMHwvA9R9pC1HWqUX2sWT47cWpEYmF4wOH3t18lRo9AkHE8Wkn6+xZrh3o6vjqM
 1hShtoi1kHcDoa8owOIWIXIUSls88ZdHRIy6IccMTTrpUFGhS5nnQiEpb0FYOU8F0kI6flY0A58
 a3qnMswBrRxls06s9EqdmZjn53XfB0K6qsjk8Kwjd2Z2lg=
X-Received: by 2002:a05:600c:c162:b0:495:4589:cea6 with SMTP id
 5b1f17b1804b1-496c65c071cmr90396795e9.34.1785340102104; 
 Wed, 29 Jul 2026 08:48:22 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d8e826sm76409705e9.8.2026.07.29.08.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:48:21 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:56 +0200
Subject: [PATCH 20/25] tests/functional: aspeed: add hwmon sensor read helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-20-c8f9a8d101f6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337965; l=1618;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=OWHYGLs9Qe48IkzshR4rzRcrC9b6ZFXaLE+JZF/S+fM=;
 b=AWknD4yiasxBSfKYStR/C9DNNvTETapWBjxW+mYR/B1Of/Y2V7/3H2kcbUliBivT3zQl4W5rO
 yhVxaIaHHA4A75jbhq4X4Beov6AiCvkxixA4oix+g6i3Lwtqy/EpQrm
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.45; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f45.google.com
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

Add read_hwmon()/wait_hwmon_value() to AspeedTest so board tests can
read a sysfs hwmon attribute over the console and poll it until it
reaches an expected value, instead of each test carrying its own copy.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/aspeed.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 08af6b4839..84d40fc0e9 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -2,6 +2,9 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+import re
+import time
+
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import LinuxKernelTest
 
@@ -29,6 +32,19 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
     def wait_for_boot_complete(self):
         self.wait_for_console_pattern('login:')
 
+    def read_hwmon(self, hwmon, attr):
+        return exec_command_and_wait_for_pattern(
+            self, f'cat {hwmon}/{attr}', self.PROMPT)
+
+    def wait_hwmon_value(self, hwmon, attr, expected):
+        pattern = re.compile(rb'(?m)^%d\r*$' % expected)
+        if pattern.search(self.read_hwmon(hwmon, attr)):
+            return
+        time.sleep(2)
+        out = self.read_hwmon(hwmon, attr)
+        if not pattern.search(out):
+            self.fail(f'{attr} did not reach {expected}: {out!r}')
+
     def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
         self.require_netdev('user')
         self.vm.set_console()

-- 
2.50.1


