Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EE2CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzWt-0008Vp-6e; Fri, 12 Sep 2025 04:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwzWr-0008V8-3Y
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwzWl-0007J8-QN
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757667184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qPHTsCYruq+c3C77uD41+qG3MHwIcaAWRy9sFRVBY24=;
 b=XO/ZDQ10ZVb5+JfFXrpLmZIlRMjZ/nv8PbZEkKXJEnX3sflbRZiSAf5I/BlUmWFHbIEqIV
 /q98L9RY8DLvTLcjEjiHbc4YMLx2jE9PaGPWKgS/S5IXjrOeaNzt8Zann7d93//FFB3xG4
 ovDI6TBl/Zt9+INN7fSxVHvZqE0e5kY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-PqpE9FnEMqqAJpHCq4ppEA-1; Fri,
 12 Sep 2025 04:52:58 -0400
X-MC-Unique: PqpE9FnEMqqAJpHCq4ppEA-1
X-Mimecast-MFC-AGG-ID: PqpE9FnEMqqAJpHCq4ppEA_1757667177
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D341B180057A; Fri, 12 Sep 2025 08:52:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A41D41800447; Fri, 12 Sep 2025 08:52:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH] tests/functional/s390x/test_pxelinux: Fix warnings from pylint
Date: Fri, 12 Sep 2025 10:52:51 +0200
Message-ID: <20250912085251.274294-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

pylint complains about wrong identation in one of the lines and
that the pxelinux_cfg_contents is a constant that should be written
with capital letters. While we're at it, also add the missing doc
strings.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/s390x/test_pxelinux.py | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tests/functional/s390x/test_pxelinux.py b/tests/functional/s390x/test_pxelinux.py
index 4fc33b8c46d..c00cce6a5a4 100755
--- a/tests/functional/s390x/test_pxelinux.py
+++ b/tests/functional/s390x/test_pxelinux.py
@@ -1,10 +1,11 @@
 #!/usr/bin/env python3
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
-#
-# Functional test that checks the pxelinux.cfg network booting of a s390x VM
-# (TFTP booting without config file is already tested by the pxe qtest, so
-#  we don't repeat that here).
+'''
+Functional test that checks the pxelinux.cfg network booting of a s390x VM
+(TFTP booting without config file is already tested by the pxe qtest, so
+we don't repeat that here).
+'''
 
 import os
 import shutil
@@ -12,7 +13,7 @@
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 
-pxelinux_cfg_contents='''# pxelinux.cfg style config file
+PXELINUX_CFG_CONTENTS='''# pxelinux.cfg style config file
 default Debian
 label Nonexisting
 kernel kernel.notavailable
@@ -26,6 +27,10 @@
 '''
 
 class S390PxeLinux(QemuSystemTest):
+    '''
+    Test various ways of booting via a pxelinux.cfg file, for details see:
+    https://wiki.syslinux.org/wiki/index.php?title=PXELINUX#Configuration
+    '''
 
     ASSET_DEBIAN_KERNEL = Asset(
         ('https://snapshot.debian.org/archive/debian/'
@@ -46,6 +51,7 @@ class S390PxeLinux(QemuSystemTest):
         '480859574f3f44caa6cd35c62d70e1ac0609134e22ce2a954bbed9b110c06e0b')
 
     def pxelinux_launch(self, pl_name='default', extra_opts=None):
+        '''Create a pxelinux.cfg file in the right location and launch QEMU'''
         self.require_netdev('user')
         self.set_machine('s390-ccw-virtio')
 
@@ -66,11 +72,11 @@ def pxelinux_launch(self, pl_name='default', extra_opts=None):
 
         cfg_fname = self.scratch_file('tftp', 'pxelinux.cfg', pl_name)
         with open(cfg_fname, 'w', encoding='utf-8') as f:
-            f.write(pxelinux_cfg_contents)
+            f.write(PXELINUX_CFG_CONTENTS)
 
         virtio_net_dev = 'virtio-net-ccw,netdev=n1,bootindex=1'
         if extra_opts:
-                virtio_net_dev += ',' + extra_opts
+            virtio_net_dev += ',' + extra_opts
 
         self.vm.add_args('-m', '384',
                          '-netdev', f'user,id=n1,tftp={tftpdir}',
@@ -80,6 +86,7 @@ def pxelinux_launch(self, pl_name='default', extra_opts=None):
 
 
     def test_default(self):
+        '''Check whether the guest uses the "default" file name'''
         self.pxelinux_launch()
         # The kernel prints its arguments to the console, so we can use
         # this to check whether the kernel parameters are correctly handled:
@@ -89,11 +96,13 @@ def test_default(self):
         wait_for_console_pattern(self, 'Run /init as init process')
 
     def test_mac(self):
+        '''Check whether the guest uses file name based on its MAC address'''
         self.pxelinux_launch(pl_name='01-02-ca-fe-ba-be-42',
                              extra_opts='mac=02:ca:fe:ba:be:42,loadparm=3')
         wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
 
     def test_uuid(self):
+        '''Check whether the guest uses file name based on its UUID'''
         # Also add a non-bootable disk to check the fallback to network boot:
         self.vm.add_args('-blockdev', 'null-co,size=65536,node-name=d1',
                          '-device', 'virtio-blk,drive=d1,bootindex=0,loadparm=1',
@@ -102,11 +111,13 @@ def test_uuid(self):
         wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
 
     def test_ip(self):
+        '''Check whether the guest uses file name based on its IP address'''
         self.vm.add_args('-M', 'loadparm=3')
         self.pxelinux_launch(pl_name='0A00020F')
         wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
 
     def test_menu(self):
+        '''Check whether the boot menu works for pxelinux.cfg booting'''
         self.vm.add_args('-boot', 'menu=on,splash-time=10')
         self.pxelinux_launch(pl_name='0A00')
         wait_for_console_pattern(self, '[1] Nonexisting')
-- 
2.51.0


