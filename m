Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAA0CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEThg-0004C0-Ul; Thu, 30 Oct 2025 10:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEThX-0004Aq-2b
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEThP-0007UL-5r
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761834733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+NrDvS6Aotp/xW8hVc1NW6LHl5SmyHTm1TR8vdFNRDg=;
 b=D/W4XAIQ9w/Vc1Plu120XzEu2KYEk0Rr1LV5pEB5+C+jhwC8grjXlUMMHSPx4JQs07KQqL
 PpWx2HO4ZMdg2SpOF4NpButWYlLOtaxUiBw+9AEMR6z/YmyB1UOcyPFcS8x2al/DjkdVCE
 kaBzvcBtWYbMvLdLUJ2lzyYnUpB30vY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-LMV_zpjcME60hm6UU_ZlcQ-1; Thu,
 30 Oct 2025 10:32:08 -0400
X-MC-Unique: LMV_zpjcME60hm6UU_ZlcQ-1
X-Mimecast-MFC-AGG-ID: LMV_zpjcME60hm6UU_ZlcQ_1761834727
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25CFA1955E95; Thu, 30 Oct 2025 14:32:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.122])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F328180057C; Thu, 30 Oct 2025 14:32:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] tests/functional/aarch64/test_device_passthrough: Fix
 warnings from pylint
Date: Thu, 30 Oct 2025 15:32:03 +0100
Message-ID: <20251030143203.297692-1-thuth@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Remove unused imports, write constants with capital letters and make
sure that the code uses the right indentation / formatting.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../aarch64/test_device_passthrough.py        | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tests/functional/aarch64/test_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
index 05a3f52d5e2..10c73728f36 100755
--- a/tests/functional/aarch64/test_device_passthrough.py
+++ b/tests/functional/aarch64/test_device_passthrough.py
@@ -10,13 +10,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from os.path import join
+from random import randbytes
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command, wait_for_console_pattern
-from qemu_test import exec_command_and_wait_for_pattern
-from random import randbytes
+from qemu_test import wait_for_console_pattern
+
 
-guest_script = '''
+GUEST_SCRIPT = '''
 #!/usr/bin/env bash
 
 set -euo pipefail
@@ -56,7 +56,7 @@
 -device vfio-pci,host=$pci_iommufd,iommufd=iommufd0
 '''
 
-nested_guest_script = '''
+NESTED_GUEST_SCRIPT = '''
 #!/usr/bin/env bash
 
 set -euo pipefail
@@ -75,6 +75,7 @@
 echo device_passthrough_test_ok
 '''
 
+
 class Aarch64DevicePassthrough(QemuSystemTest):
 
     # https://github.com/pbo-linaro/qemu-linux-stack/tree/device_passthrough
@@ -86,7 +87,7 @@ class Aarch64DevicePassthrough(QemuSystemTest):
     ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
         ('https://github.com/pbo-linaro/qemu-linux-stack/'
          'releases/download/build/device_passthrough-a9612a2.tar.xz'),
-         'f7d2f70912e7231986e6e293e1a2c4786dd02bec113a7acb6bfc619e96155455')
+        'f7d2f70912e7231986e6e293e1a2c4786dd02bec113a7acb6bfc619e96155455')
 
     # This tests the device passthrough implementation, by booting a VM
     # supporting it with two nvme disks attached, and launching a nested VM
@@ -108,10 +109,14 @@ def test_aarch64_device_passthrough(self):
         guest_cmd = join(stack, 'guest.sh')
         nested_guest_cmd = join(stack, 'nested_guest.sh')
         # we generate two random disks
-        with open(disk_vfio, "wb") as d: d.write(randbytes(512))
-        with open(disk_iommufd, "wb") as d: d.write(randbytes(1024))
-        with open(guest_cmd, 'w') as s: s.write(guest_script)
-        with open(nested_guest_cmd, 'w') as s: s.write(nested_guest_script)
+        with open(disk_vfio, "wb") as d:
+            d.write(randbytes(512))
+        with open(disk_iommufd, "wb") as d:
+            d.write(randbytes(1024))
+        with open(guest_cmd, 'w', encoding='utf-8') as s:
+            s.write(GUEST_SCRIPT)
+        with open(nested_guest_cmd, 'w', encoding='utf-8') as s:
+            s.write(NESTED_GUEST_SCRIPT)
 
         self.vm.add_args('-cpu', 'max')
         self.vm.add_args('-m', '2G')
@@ -139,5 +144,6 @@ def test_aarch64_device_passthrough(self):
         wait_for_console_pattern(self, 'device_passthrough_test_ok',
                                  failure_message='Kernel panic')
 
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.0


