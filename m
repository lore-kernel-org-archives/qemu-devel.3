Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7942AC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrX-0006CZ-H2; Mon, 21 Sep 2026 17:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrQ-00066u-HY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:40 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrO-00008v-6G
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:39 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso25996725e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027257; x=1790632057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VBH9E99MFnB3gX4SExb6p8NPz5EDIV6xjZ4ICVmDV88=;
 b=G7HdjaUEGFn/IyNcffjrDSfAVHn5Ck1B9PMMXuWbGsbfTsQh4nBQuBGZwjB1Yr/RPb
 Kl3y83Hb3t+FVXb0XUx7eq8NUHkrZeX6VEfwM0mOGBMhy3ODdhXTzKfmmrbQCwAI5uVG
 H/mprn2KK3jPmkYX6bKnP7iI/MaArXdnI0zz5e4/DhELRt7lsF3cBhAo1h4qa1zIbATn
 W0JdIkwJW3iDGyUiVI5GIQtItHC9vikR9YnaNSsYTco4+emGfW/S2iZUqY437DL6sMGE
 DMPh/BHBCmPA+zFsfS9q7sY/U15HRybJi75RpCZa7d8TN1JU/R0lnBTN4yZ0nEO7UJJm
 GuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027257; x=1790632057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VBH9E99MFnB3gX4SExb6p8NPz5EDIV6xjZ4ICVmDV88=;
 b=js9tI+HagV+jOmZZC3v4L4XGtPXTqfhUW2DbWvTvoC8mwzl+KiPi+UdHOac1faLQm+
 CiToK1TuInqZ+7RtLpXqPeS+cKtfDBAN2En4J+2Z/mwFUhPFAZriCdy4+s7ZqeECCa+Y
 4Mfi/XmqDo3zg1XKcdkPnLlqhFhrbxsZCBaYCcWWtclR6VAlg6b8krX+P4mSZNRahE9n
 5rZCn9AMJ9AOTXzF5CA47Bn5oxTyb1q5bHEUmq935M51WUON/8U+lM+ZXwE4AuhXBkRg
 niYMpJ4rQUYqCR+XXRMVjENZHZv2hOrusdiJtc1H3q/Ebj48Hq40CMfXNnc39EJAE6W8
 3ngQ==
X-Gm-Message-State: AFuF++mXhU/PEzGbCWcWlq368JkiynThsN+Ld6CecbUSHaZb0M4U+hwr
 YZxVjV4tAQpDhF676vUe5zpXCB7zXaxzasY0am463hpkUkfq6rC+TOhyD3uZ3Q==
X-Gm-Gg: AYBFou3gPClkHM/fI+kzbK48QC5UY58Geh5rIO/apFHfu1LwH5+dt1J2Zy0ATtMhHbi
 bCbWm5XPPl6mVUJDF40PEtq+WN4Ha0f+l/MIP3v2aTjNh/hCVuo5a+TAt21NA/YNHR/WMLxFCNA
 DE5HXpenRflVIYD5F6TRbmv3ozJCpH1sovnXMTMm8/yOquA6f0y9comDSwv8is9E1cq8mI+VwHt
 5ywPVdFBT1fr6FGx4wHis+B+wv6venhsEkIINQV5sYNboZp+dr/yx+JTHmdqiq8TMrYzxfTWTNi
 v+2Y+7h16OTZE3qRQvxiFlIdCX0zbH4KW84cdyuRdZTebtnQyaEF+yvoVbR3RlF8MUjRIX7Yp1/
 klcj8h1GN6SUFu/0OS8na9PcAuoe2BnuLav+bOiL0uLvxuBq+JC6plm7Td7xDzwrFV6zvbUMOKf
 dX1LHEf00MF3p/hm0wuKSzZTb3G3OSfpLYIRet13WHNK5J449aXUIuAjSXH5Enwe8GqrskqLJ5x
 flFk53iHDN4aQtHKpW+KheUU7Q0A/z8BzWU32dvRJxBGnj5K7+3VyqeThMN5J7loumXP4nymgVJ
 Q3ek
X-Received: by 2002:a05:600c:a42:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-49fc5594deemr167296465e9.0.1790027256415; 
 Mon, 21 Sep 2026 14:47:36 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:35 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 07/42] tests/functional/arm: Add console test for `sabrelite`
 machine
Date: Mon, 21 Sep 2026 23:46:35 +0200
Message-ID: <20260921214710.29422-8-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                            |  1 +
 tests/functional/arm/meson.build       |  1 +
 tests/functional/arm/test_sabrelite.py | 46 ++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100755 tests/functional/arm/test_sabrelite.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 6be9c5725b..7cc9e558f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1051,6 +1051,7 @@ F: include/hw/usb/imx-usb-phy.h
 F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
+F: tests/functional/arm/test_sabrelite.py
 
 SBSA-REF
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..761b371a8d 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -24,6 +24,7 @@ test_arm_timeouts = {
   'quanta_gsj' : 240,
   'raspi2' : 120,
   'replay' : 240,
+  'sabrelite' : 240,
   'tuxrun' : 240,
   'sx1' : 360,
 }
diff --git a/tests/functional/arm/test_sabrelite.py b/tests/functional/arm/test_sabrelite.py
new file mode 100755
index 0000000000..31a0a49eac
--- /dev/null
+++ b/tests/functional/arm/test_sabrelite.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+
+class SabreliteMachine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/vmlinuz'),
+        '5851e9c61465a26db810796db671c4729e66e81c365b3ebb1a4b7f772737605b')
+
+    ASSET_INITRD = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/initrd.gz'),
+        'fe33f836232a9107716d34dc56d36dea81bab039243a2a42ea6583a50c9b92ca')
+
+    ASSET_DTB = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/device-tree/imx6q-sabrelite.dtb'),
+        '3ad637c8ea55ebd058a67f686e050b82ccb0d1327bc283623c133c48ad87db44')
+
+    def setUp(self):
+        super().setUp()
+
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.initrd_path = self.ASSET_INITRD.fetch()
+        self.dtb_path = self.ASSET_DTB.fetch()
+
+    def test_console(self):
+        self.require_accelerator("tcg")
+        self.set_machine('sabrelite')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path)
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Starting system log daemon:')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.55.0


