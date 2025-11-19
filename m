Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE52CF259E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdY6-0004VI-8g; Wed, 19 Nov 2025 03:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdXm-0003nT-Dt
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdXk-0000wj-8X
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763540879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GgSYuz7W+zTsurBR74ACOTCdfc+7nF80rcsqhxkObw=;
 b=Q84LDj6tAVjmd9cwxHgUEEPth5L59JNioGNBSsKJ4sPR+Kp6y9bepLd9KDTpdFZkyxHxLo
 9gAOB0Qwm+pP0L5xmO+FpSAuex24B1FA9Qks5ApozRp4Pt2lzFp8r55fAXnMsdtJGWQdfP
 sD31xMHLl5GSjAY7weT9QOfHWQX2PpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-s6XwD0YBO4uz9SQRcVJiqw-1; Wed,
 19 Nov 2025 03:27:55 -0500
X-MC-Unique: s6XwD0YBO4uz9SQRcVJiqw-1
X-Mimecast-MFC-AGG-ID: s6XwD0YBO4uz9SQRcVJiqw_1763540873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A02E118D95D1; Wed, 19 Nov 2025 08:27:52 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71271180047F; Wed, 19 Nov 2025 08:27:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-11.0 11/15] tests/functional/aarch64/test_virt_gpu: Fix
 style issues
Date: Wed, 19 Nov 2025 09:26:32 +0100
Message-ID: <20251119082636.43286-12-thuth@redhat.com>
In-Reply-To: <20251119082636.43286-1-thuth@redhat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Reshuffle the import statements according to the suggestions from pylint,
use lowercase letters for variable names, and drop some spaces that flake8
did not like.

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
2.51.1


