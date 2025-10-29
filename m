Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D8DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE72I-0004jW-5p; Wed, 29 Oct 2025 10:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE72E-0004Qp-UY
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE720-0007g3-9w
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761747599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JBiBPLoIzqLkUEZ894NYeeJibtODPnN1r8S6jr9Pl5c=;
 b=GuVg3kPuOGG+XzDsTCIl5hz8IlhqNF0X7+5sDXxrze3XFXCWEli8CKxqfPXua3WXzY6Vw9
 5MEGwws4BxkyDRDM5mUL54bVM3aGV8LlCxCXd8WAEWloRBNl305LQpqydeiYBmj2KRNPtV
 9A4P7+icwF9fZFN0nR0sswmi5/5I7uM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-ssX4cHDkOYSGoYYcUUZLBw-1; Wed,
 29 Oct 2025 10:19:54 -0400
X-MC-Unique: ssX4cHDkOYSGoYYcUUZLBw-1
X-Mimecast-MFC-AGG-ID: ssX4cHDkOYSGoYYcUUZLBw_1761747592
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4BC1956050; Wed, 29 Oct 2025 14:19:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55B2430001A2; Wed, 29 Oct 2025 14:19:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-ppc@nongnu.org,
	Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/functional/ppc64: Fix class names to silence pylint
 warnings
Date: Wed, 29 Oct 2025 15:19:46 +0100
Message-ID: <20251029141946.86110-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Pylint complains about inconsistent CamelCase names here, so let's
slightly change the names to make pylint happy again.

In the sam460ex test, also split a line where pylint was complaining
about it being too long.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/ppc/test_74xx.py            | 2 +-
 tests/functional/ppc/test_sam460ex.py        | 5 +++--
 tests/functional/ppc64/test_powernv.py       | 2 +-
 tests/functional/ppc64/test_pseries.py       | 2 +-
 tests/functional/ppc64/test_reverse_debug.py | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/functional/ppc/test_74xx.py b/tests/functional/ppc/test_74xx.py
index 5386016f261..219c7991aca 100755
--- a/tests/functional/ppc/test_74xx.py
+++ b/tests/functional/ppc/test_74xx.py
@@ -10,7 +10,7 @@
 from qemu_test import QemuSystemTest
 from qemu_test import wait_for_console_pattern
 
-class ppc74xxCpu(QemuSystemTest):
+class Ppc74xxCpu(QemuSystemTest):
 
     timeout = 5
 
diff --git a/tests/functional/ppc/test_sam460ex.py b/tests/functional/ppc/test_sam460ex.py
index 31cf9dd6de8..024406d155c 100755
--- a/tests/functional/ppc/test_sam460ex.py
+++ b/tests/functional/ppc/test_sam460ex.py
@@ -8,10 +8,11 @@
 from qemu_test import exec_command_and_wait_for_pattern
 
 
-class sam460exTest(LinuxKernelTest):
+class Sam460exTest(LinuxKernelTest):
 
     ASSET_BR2_SAM460EX_LINUX = Asset(
-        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc_sam460ex-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main'
+         '/buildroot/qemu_ppc_sam460ex-2023.11-8-gdcd9f0f6eb-20240105/vmlinux'),
         '6f46346f3e20e8b5fc050ff363f350f8b9d76a051b9e0bd7ea470cc680c14df2')
 
     def test_ppc_sam460ex_buildroot(self):
diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 9ada832b781..0ea6c93e428 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -10,7 +10,7 @@
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
 
-class powernvMachine(LinuxKernelTest):
+class PowernvMachine(LinuxKernelTest):
 
     timeout = 90
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
index 67057934e8d..7840c4e3ff8 100755
--- a/tests/functional/ppc64/test_pseries.py
+++ b/tests/functional/ppc64/test_pseries.py
@@ -10,7 +10,7 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
-class pseriesMachine(QemuSystemTest):
+class PseriesMachine(QemuSystemTest):
 
     timeout = 90
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
index 69551fb84df..4eef779936d 100755
--- a/tests/functional/ppc64/test_reverse_debug.py
+++ b/tests/functional/ppc64/test_reverse_debug.py
@@ -18,7 +18,7 @@
 from reverse_debugging import ReverseDebugging
 
 
-class ReverseDebugging_ppc64(ReverseDebugging):
+class ReverseDebuggingPpc64(ReverseDebugging):
 
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
     def test_ppc64_pseries(self):
-- 
2.51.0


