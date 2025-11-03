Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF079CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG0Aq-0001a3-Og; Mon, 03 Nov 2025 14:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vG0Ao-0001ZT-R2
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:25:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vG0Af-0001o3-Ua
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762197888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vqkKS9JGlo1RMbnwYGCV3TMVsvl0JFJzFF2uWZFBSuc=;
 b=FjzSpXF/TkiTLE6Cqy0Aucv9uE9MJrHTOQMfAgfXkAcc3uwIlrMVPNsgMF66+iiO4+39g9
 coU1NLpQ55beZuHEspp2PJLNV3UD3lohGXpyDHB++hq48YvwDWY6TFBWBYmCf0su3MZVxO
 lvhz9IykixItHLSRU9n5kWLN+vlnUF4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-N2hCKHLlMGKjrn542TD6Dg-1; Mon,
 03 Nov 2025 14:24:43 -0500
X-MC-Unique: N2hCKHLlMGKjrn542TD6Dg-1
X-Mimecast-MFC-AGG-ID: N2hCKHLlMGKjrn542TD6Dg_1762197882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06C4B1956066; Mon,  3 Nov 2025 19:24:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.94])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 783D018004D8; Mon,  3 Nov 2025 19:24:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional/mips64el: Silence issues reported by pylint
Date: Mon,  3 Nov 2025 20:24:30 +0100
Message-ID: <20251103192430.63278-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Drop unused imports, annotate imports that are not at the top, but done
on purpose in other locations, use f-strings where it makes sense, etc.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/mips64el/test_malta.py  | 15 ++++++++-------
 tests/functional/mips64el/test_replay.py |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
index e37463dc291..bc750cb7ad6 100755
--- a/tests/functional/mips64el/test_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -10,7 +10,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
-import logging
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
@@ -50,7 +49,7 @@ def test_mips64el_malta(self):
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        console_pattern = f'Kernel command line: {kernel_command_line}'
         self.wait_for_console_pattern(console_pattern)
 
     ASSET_KERNEL_3_19_3 = Asset(
@@ -66,7 +65,7 @@ def test_mips64el_malta(self):
         '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
 
     @skipUntrustedTest()
-    def test_mips64el_malta_5KEc_cpio(self):
+    def test_mips64el_malta_5kec_cpio(self):
         kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
         initrd_path = self.uncompress(self.ASSET_CPIO_R1)
 
@@ -134,8 +133,8 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         Boot Linux kernel and check Tux logo is displayed on the framebuffer.
         """
 
-        import numpy as np
-        import cv2
+        import numpy as np    # pylint: disable=import-outside-toplevel
+        import cv2            # pylint: disable=import-outside-toplevel
 
         screendump_path = self.scratch_file('screendump.pbm')
 
@@ -149,7 +148,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
                                'clocksource=GIC console=tty0 console=ttyS0')
         self.vm.add_args('-kernel', kernel_path,
                          '-cpu', 'I6400',
-                         '-smp', '%u' % cpu_cores_count,
+                         '-smp', str(cpu_cores_count),
                          '-vga', 'std',
                          '-append', kernel_command_line)
         self.vm.launch()
@@ -157,7 +156,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         self.wait_for_console_pattern(framebuffer_ready)
         self.vm.cmd('human-monitor-command', command_line='stop')
         res = self.vm.cmd('human-monitor-command',
-                          command_line='screendump %s' % screendump_path)
+                          command_line=f'screendump {screendump_path}')
         if 'unknown command' in res:
             self.skipTest('screendump not available')
 
@@ -191,6 +190,8 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         self.do_test_i6400_framebuffer_logo(8)
 
 
+# Add the tests from the 32-bit mipsel file here, too.
+# pylint: disable=unused-import,wrong-import-position
 from mipsel.test_malta import MaltaMachineYAMON
 
 if __name__ == '__main__':
diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/test_replay.py
index 05cc585f854..ce8dd28d722 100755
--- a/tests/functional/mips64el/test_replay.py
+++ b/tests/functional/mips64el/test_replay.py
@@ -23,7 +23,7 @@ def test_replay_mips64el_malta(self):
         kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
                                     member='boot/vmlinux-2.6.32-5-5kc-malta')
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        console_pattern = f'Kernel command line: {kernel_command_line}'
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
 
@@ -40,7 +40,7 @@ def test_replay_mips64el_malta(self):
         '75ba10cd35fb44e32948eeb26974f061b703c81c4ba2fab1ebcacf1d1bec3b61')
 
     @skipUntrustedTest()
-    def test_replay_mips64el_malta_5KEc_cpio(self):
+    def test_replay_mips64el_malta_5kec_cpio(self):
         self.set_machine('malta')
         self.cpu = '5KEc'
         kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
-- 
2.51.0


