Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558D7CD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUEK-0002UA-MP; Thu, 13 Nov 2025 05:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJUDm-0002Pi-C9
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJUDX-0007U7-2O
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763028373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=L2VzrA+im5lU8SyI/wwytZm7oAxotbKtb1vkC1NuCIU=;
 b=MdQo2GH87UcX3XYYohTrZXaJUqlsftQprdd4+u3WCdhhKM1DYPlZZGE+veVYOiX5yUCJ+b
 ZfG4KPlZvMx3fQX8z7Wh1CyO7CL9/vGd2AEA9krC6yBTOXfN8tUuavf1MAOlCaD6wmdZdE
 MQBWiMfR0VFiaOqwwX84bFy6vcJNdWw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107--1zOWuHgNfSBV82ddD-_zQ-1; Thu,
 13 Nov 2025 05:06:10 -0500
X-MC-Unique: -1zOWuHgNfSBV82ddD-_zQ-1
X-Mimecast-MFC-AGG-ID: -1zOWuHgNfSBV82ddD-_zQ_1763028368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A8771955F54; Thu, 13 Nov 2025 10:06:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.127])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20EB2180094B; Thu, 13 Nov 2025 10:06:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Subject: [PATCH] tests/functional/arm/test_aspeed_ast2600_buildroot: Fix
 pylint warnings
Date: Thu, 13 Nov 2025 11:06:01 +0100
Message-ID: <20251113100601.476900-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Pylint recommends to use a "with" context for tempfile.TemporaryDirectory()
to make sure that the directory is deleted once it is not needed anymore,
and it recommends to use the "check" parameter for subprocess.run().
For style reasons, the imports at the beginning of the file should be
grouped by module.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../arm/test_aspeed_ast2600_buildroot.py      | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600_buildroot.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
index 51f2676c906..575a5f64143 100755
--- a/tests/functional/arm/test_aspeed_ast2600_buildroot.py
+++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
@@ -9,8 +9,8 @@
 import tempfile
 import subprocess
 
-from qemu_test import Asset
 from aspeed import AspeedTest
+from qemu_test import Asset
 from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
 
 
@@ -66,21 +66,18 @@ def test_arm_ast2600_evb_buildroot(self):
          'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
         'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
 
-    @skipIfMissingCommands('swtpm')
-    def test_arm_ast2600_evb_buildroot_tpm(self):
-        self.set_machine('ast2600-evb')
-
+    def _test_arm_ast2600_evb_buildroot_tpm(self, tpmstate_dir):
         image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
 
-        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
-        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
+        socket = os.path.join(tpmstate_dir, 'swtpm-socket')
 
         # We must put the TPM state dir in /tmp/, not the build dir,
         # because some distros use AppArmor to lock down swtpm and
         # restrict the set of locations it can access files in.
         subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
-                        '--tpmstate', f'dir={tpmstate_dir.name}',
-                        '--ctrl', f'type=unixio,path={socket}'])
+                        '--tpmstate', f'dir={tpmstate_dir}',
+                        '--ctrl', f'type=unixio,path={socket}'],
+                       check=True)
 
         self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
         self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
@@ -97,6 +94,12 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
+    @skipIfMissingCommands('swtpm')
+    def test_arm_ast2600_evb_buildroot_tpm(self):
+        self.set_machine('ast2600-evb')
+        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
+            self._test_arm_ast2600_evb_buildroot_tpm(tpmstate_dir)
+
 
 if __name__ == '__main__':
     AspeedTest.main()
-- 
2.51.1


