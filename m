Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72337C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 18:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYqvR-0002Pf-Ih; Mon, 07 Jul 2025 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uYqsm-0000sv-2a
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 14:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uYqsk-0007q9-0e
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 14:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751914079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ozEiUuyCK4fR5f3322lMca9jf6cA7QKPbytM8gfMs2I=;
 b=NwQ+kA4x8MTkcOGGgL62jZcCzgBgH9xwV194VHkuh65V8LpEaT3hyjP0IDJW30Y+mTbekn
 MM03zorcGV+h/JZUgo/GyBRfTj/jv8xcaHwfbS7J8eXnAOFybAlrKhWNmyDo8Z5A3EAQw8
 1ZcJ7Yre+hdXAtiLByRDZNJJLsmU+Oo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203--INLPmInO_uVvGCe9-UXUA-1; Mon,
 07 Jul 2025 14:47:56 -0400
X-MC-Unique: -INLPmInO_uVvGCe9-UXUA-1
X-Mimecast-MFC-AGG-ID: -INLPmInO_uVvGCe9-UXUA_1751914075
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED0E9188EA63; Mon,  7 Jul 2025 18:47:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A5FB195608F; Mon,  7 Jul 2025 18:47:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: qemu-ppc@nongnu.org
Subject: [PATCH] tests/functional/test_ppc_bamboo: Replace broken link with
 working assets
Date: Mon,  7 Jul 2025 20:47:36 +0200
Message-ID: <20250707184736.88660-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The old image that we used for testing the bamboo machine has disappeared
from the internet. Fortunately there is another kernel + initrd provided
by Cédric that can be used for testing this machine, too.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc_bamboo.py | 34 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/test_ppc_bamboo.py
index fddcc24d0da..c634ae7b4a7 100755
--- a/tests/functional/test_ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -16,28 +16,32 @@ class BambooMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
-        ('http://landley.net/aboriginal/downloads/binaries/'
-         'system-image-powerpc-440fp.tar.gz'),
-        'c12b58f841c775a0e6df4832a55afe6b74814d1565d08ddeafc1fb949a075c5e')
+    ASSET_KERNEL = Asset(
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc_bamboo-2023.11-8-gdcd9f0f6eb-20240105/vmlinux'),
+        'a2e12eb45b73491ac62fc0bbeb68dead0dc5c0f22cf83146558389209b420ad1')
+    ASSET_INITRD = Asset(
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc_bamboo-2023.11-8-gdcd9f0f6eb-20240105/rootfs.cpio'),
+        'd2a36bdb8763b389765dc8c29d4904cec2bd001c587f92e85ab9eb10d5ddda54')
 
     def test_ppc_bamboo(self):
         self.set_machine('bamboo')
         self.require_accelerator("tcg")
         self.require_netdev('user')
-        self.archive_extract(self.ASSET_IMAGE)
+
+        kernel = self.ASSET_KERNEL.fetch()
+        initrd = self.ASSET_INITRD.fetch()
+
         self.vm.set_console()
-        self.vm.add_args('-kernel',
-                         self.scratch_file('system-image-powerpc-440fp',
-                                           'linux'),
-                         '-initrd',
-                         self.scratch_file('system-image-powerpc-440fp',
-                                           'rootfs.cpio.gz'),
-                         '-nic', 'user,model=rtl8139,restrict=on')
+        self.vm.add_args('-kernel', kernel,
+                         '-initrd', initrd,
+                         '-nic', 'user,model=virtio-net-pci,restrict=on')
         self.vm.launch()
-        wait_for_console_pattern(self, 'Type exit when done')
-        exec_command_and_wait_for_pattern(self, 'ping 10.0.2.2',
-                                          '10.0.2.2 is alive!')
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self, 'ping -c1 10.0.2.2',
+                '1 packets transmitted, 1 packets received, 0% packet loss')
         exec_command_and_wait_for_pattern(self, 'halt', 'System Halted')
 
 if __name__ == '__main__':
-- 
2.50.0


