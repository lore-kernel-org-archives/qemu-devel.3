Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B720ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlVv-0000kf-6M; Tue, 11 Nov 2025 05:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVs-0000ei-HS
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVq-0007Yn-3y
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762856529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7C1BnT8JW6Zr7bjqu9ZGmvofo/njKkMypzcW1Zj2PEo=;
 b=DAfIp0K8DEenFnuDZjSCUwS2VRNfDK8ISxP/jBA7b1B8AJJeAkm3I4JgVO7xFmWP5wGFgd
 TX+9BPdJpBcralGBR8IieTMtWcPioaeopWrXKnL6Fm26ElcfpOf78JVfo0LwB/m2AkjSAM
 0HcJXit5tOqhPwO5clhostsyJA8D/uk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-H4atruf4PJq_2crab3SMqg-1; Tue,
 11 Nov 2025 05:22:07 -0500
X-MC-Unique: H4atruf4PJq_2crab3SMqg-1
X-Mimecast-MFC-AGG-ID: H4atruf4PJq_2crab3SMqg_1762856527
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D98CE1955F38; Tue, 11 Nov 2025 10:22:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.97])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96FE430044E0; Tue, 11 Nov 2025 10:22:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/4] tests/functional/mips64el: Silence issues reported by
 pylint
Date: Tue, 11 Nov 2025 11:21:57 +0100
Message-ID: <20251111102158.92091-4-thuth@redhat.com>
In-Reply-To: <20251111102158.92091-1-thuth@redhat.com>
References: <20251111102158.92091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251103192430.63278-1-thuth@redhat.com>
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
index e9318448fa7..9a432be5ce0 100755
--- a/tests/functional/mips64el/test_replay.py
+++ b/tests/functional/mips64el/test_replay.py
@@ -23,7 +23,7 @@ def test_replay_mips64el_malta(self):
         kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
                                     member='boot/vmlinux-2.6.32-5-5kc-malta')
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        console_pattern = f'Kernel command line: {kernel_command_line}'
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
 
@@ -41,7 +41,7 @@ def test_replay_mips64el_malta(self):
 
     @skipUntrustedTest()
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
-    def test_replay_mips64el_malta_5KEc_cpio(self):
+    def test_replay_mips64el_malta_5kec_cpio(self):
         self.set_machine('malta')
         self.cpu = '5KEc'
         kernel_path = self.ASSET_KERNEL_3_19_3.fetch()
-- 
2.51.1


