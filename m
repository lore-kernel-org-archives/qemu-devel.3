Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CE0CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIZ-0007QY-8X; Wed, 07 Oct 2026 04:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJbI-0006u3-4G
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:50:07 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJb8-0003SF-5G
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:49:49 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so6087013a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791348584; x=1791953384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nGNaHiuVZw/GFpL6l92yCqZ5RO3VTuRx3fxc/U2AHTU=;
 b=MfAyYF/1oUmsdlj3p0hC5/3CxZ6B6I6Aq8k82E35G+S0oifuT2fS4P+nT9tApsWzu/
 Ch3HxT0s7qCMv3IXiDn2ccDwFKexlajAxe8dFgOV/yf4muVoLLTUDj81gvF2ldCdH5Qa
 mzxe1jwSV6irPcdLdtTEzMZh4NhHQwVwiPApeD69mX9h45rUExfqJUUvlwxRwsuSbI+c
 xCwoW/uPbNHeWdYg+tl/aCLfwd0aRQaVgZMKWnxBP5c4Xmgfxpe1mgzGlEEGcpn719++
 WJlzEUVa7bpuSJdDYuCHEVRSANfj+zeutqa4+HrTg20l8Ip5EMtI8ZZjDnm0odT28vbx
 3p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791348584; x=1791953384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGNaHiuVZw/GFpL6l92yCqZ5RO3VTuRx3fxc/U2AHTU=;
 b=12Ph22C+W+8oOoVo1KEeUp0BTurBAfWno3iwGQ+MSk6R5/j6UKOTIdATR3D4vQ7bFO
 v3O4y40LL9jvfVLAi1DgRJIJlBArApfHf8aGr1HGRbtEq9X95TnxYCujpOaZcl+AvN2a
 ZnKx0DKmqKs+lp1nP2oExJK+a4nPuN4nxFnZWMod/FCrSp+YuqY/LAZnJlZORVkOz/iX
 wbuZW7tWIEV4JlaGGJrVLbemFes130Ci0KoHyyGObnka4o1LX5lMBhK4W4bCdPqfrRoV
 6EjFwB6L1xjtZ/hPnU0c22VNcV+BwXdh7T04kT2Ttmt1Fws28DUz84C/P+yAg9ejVeAu
 qkAw==
X-Gm-Message-State: AFq9FYK8Z8kscbBjrmiE+Pttxt+cz0HoD8U3ppg1P7HJRfaYfYSRYCqM
 yXoiIYh2D7izSlpJ7ocbT+3gETzXWLKpasJy9ikFCakI+ePMNdDszNh4jYVtHA==
X-Gm-Gg: AYBFou3tTa0PTC5iTtYXN5lnKKFj3Kwnhcx49ADTz3f3DeCcHOOo4uw9Jd656KF5FQJ
 EvgT7oBc0zmpXlkdE/wK+px5mDJhQimykzLjGCG2kowVg+IfyvyfQN9IeAxH+OCwptvb/1j55Ot
 WkXL4tVprgbzmvMZzaNlxuUWyydPz+JsJKsyfSixacwnwU/jf57FcQkbP2PgTz/DfjiHDhJ7vQ/
 42P0vZxajdDJwSRkXWwSFSjDA07mYicE2lbxsqMzPvut/4T4bwG6DjdbydT7FDA/VATCfRIAjU3
 wR6EivHURb3r4UYcP/fdRitRAvN/MPLxI/vdcFx2TQY9DY+FOQDHsJa/Ve59yZIJ49OQWM66hBO
 yCGQkr1kZUg7EhUmMweIlndGjvMjCuIob4JZlBZGCnS4PzVUKsdMA1JLonG/KqTc9f/FvOxr1rN
 4vQJ6TGPLm5iYKGsQ1+lqAEOTvaFnbQ6Cht+IHEWYSmq87WqP5ORM8npfPGpIUb3eHa0gg2lcAF
 sTCNQdOiDDnN9MXLgmLK8h6vBYiXLp5nyZsAA==
X-Received: by 2002:a05:600c:4fcb:b0:4a1:7703:b0e with SMTP id
 5b1f17b1804b1-4a1788ec7c0mr32481015e9.34.1791275729496; 
 Tue, 06 Oct 2026 01:35:29 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 08/31] tests/functional/arm: Add console test for
 `sabrelite` machine
Date: Tue,  6 Oct 2026 10:34:20 +0200
Message-ID: <20261006083445.30362-9-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The test currently exercises the Linux kernel and waits for the first
daemons to be started. At this point, basic hardware is initialized and
if the log message is reached, no driver ended up in an endless loop,
thus the system should be usable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                            |  1 +
 tests/functional/arm/meson.build       |  2 ++
 tests/functional/arm/test_sabrelite.py | 46 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tests/functional/arm/test_sabrelite.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..f31245716a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1054,6 +1054,7 @@ F: include/hw/usb/imx-usb-phy.h
 F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
+F: tests/functional/arm/test_sabrelite.py
 
 SBSA-REF
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..989b841555 100644
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
@@ -65,6 +66,7 @@ tests_arm_system_thorough = [
   'raspi2',
   'realview',
   'replay',
+  'sabrelite',
   'smdkc210',
   'stellaris',
   'sx1',
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
2.56.0


