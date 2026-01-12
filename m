Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88396C9EC86
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHme-0001y9-52; Mon, 12 Jan 2026 08:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlN-0001Mv-FH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlL-0002WN-OQ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPtgGIP/wuubytcrixEAHq8wAU0Nauyq+QdHtcvOLUw=;
 b=eKsM7aaDrOQzrX0uS/Rk1+HxN3Whwq9QmeMfabDXOkIWuMo7EoEzGdaJZsuP+gXBLRetJu
 F4GX5RuIaOz821Tklg4Gn3IufwhPW6O0HlKgSxOenPsaU3G5E2WY1+XIfoYVkaxOqN4zUp
 8hhjvrrx7Kuv+Uz41lpYewB6eqxIu7Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-QRg5Y23bMbuBhQ5zsKlErw-1; Mon,
 12 Jan 2026 08:15:11 -0500
X-MC-Unique: QRg5Y23bMbuBhQ5zsKlErw-1
X-Mimecast-MFC-AGG-ID: QRg5Y23bMbuBhQ5zsKlErw_1768223710
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BEA9195605B; Mon, 12 Jan 2026 13:15:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3931E30001A2; Mon, 12 Jan 2026 13:15:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/15] tests/functional/aarch64/test_virt_gpu: Fix style issues
Date: Mon, 12 Jan 2026 14:14:46 +0100
Message-ID: <20260112131457.67128-5-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Reshuffle the import statements according to the suggestions from pylint,
use lowercase letters for variable names, and drop some spaces that flake8
did not like.

Message-Id: <20251119082636.43286-12-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/aarch64/test_virt_gpu.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/functional/aarch64/test_virt_gpu.py b/tests/functional/aarch64/test_virt_gpu.py
index c26a1f20c65..6ed0e0fc1a9 100755
--- a/tests/functional/aarch64/test_virt_gpu.py
+++ b/tests/functional/aarch64/test_virt_gpu.py
@@ -9,16 +9,16 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu.machine.machine import VMLaunchFailure
+from re import search
+from subprocess import check_output, CalledProcessError
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfMissingCommands
 from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
-from qemu_test import skipIfMissingCommands
 
 from qemu_test.linuxkernel import LinuxKernelTest
 
-from re import search
-from subprocess import check_output, CalledProcessError
+from qemu.machine.machine import VMLaunchFailure
+
 
 class Aarch64VirtGPUMachine(LinuxKernelTest):
 
@@ -81,16 +81,16 @@ def _launch_virt_gpu(self, gpu_device):
         self.wait_for_console_pattern('buildroot login:')
         ec_and_wait(self, 'root', '#')
 
-    def _run_virt_weston_test(self, cmd, fail = None):
+    def _run_virt_weston_test(self, cmd, fail=None):
 
         # make it easier to detect successful return to shell
-        PS1 = 'RES=[$?] # '
-        OK_CMD = 'RES=[0] # '
+        ps1 = 'RES=[$?] # '
+        ok_cmd = 'RES=[0] # '
 
         ec_and_wait(self, 'export XDG_RUNTIME_DIR=/tmp', '#')
-        ec_and_wait(self, f"export PS1='{PS1}'", OK_CMD)
+        ec_and_wait(self, f"export PS1='{ps1}'", ok_cmd)
         full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {cmd}"
-        ec_and_wait(self, full_cmd, OK_CMD, fail)
+        ec_and_wait(self, full_cmd, ok_cmd, fail)
 
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_virgl_gpu(self):
-- 
2.52.0


