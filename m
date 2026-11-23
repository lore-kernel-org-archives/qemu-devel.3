Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnsW581O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXPs-0004jg-4s; Mon, 23 Nov 2026 12:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPk-0004hP-Ek
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPh-0007Xn-Vc
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795453267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psqzwbEp2vqXVyA0ej0vUS85zshzUGGJpP8mFFv62dU=;
 b=OnsW581OFwOXmbW2LwblfzEmB7vLa5xqnTYXozsdNWXGyVgQ+zmEw5NZFIJBaLiSgWlhR+
 cZoeGLsE5OVCwTfGTbL4RKhnS+GGTSssSHsapJrsyfsEkfntAdeKHzDL3cHRN9taq9A1MT
 EMkiuoB/p2HYivkWg1CaCWtxKs+pch0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-e8EDjf_hMvGz5omuE7015w-1; Mon,
 23 Nov 2026 17:00:58 +0000
X-MC-Unique: e8EDjf_hMvGz5omuE7015w-1
X-Mimecast-MFC-AGG-ID: e8EDjf_hMvGz5omuE7015w_1795453258
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02B6F195DB9B
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:00:58 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E296818004FC; Mon, 23 Nov 2026 17:00:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/6] tests/functional: update to newer sunxi kernel package
Date: Mon, 23 Nov 2026 17:00:47 +0000
Message-ID: <20261123170050.4166517-4-berrange@redhat.com>
In-Reply-To: <20261123170050.4166517-1-berrange@redhat.com>
References: <20261123170050.4166517-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The version we currently reference has been deleted from the
the apt.armbian.com host. 6.6.44 is the next oldest build
that is available.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/arm/test_bpim2u.py     | 19 ++++++++++---------
 tests/functional/arm/test_cubieboard.py | 15 ++++++++-------
 tests/functional/arm/test_orangepi.py   | 19 ++++++++++---------
 tests/functional/arm/test_replay.py     | 12 ++++++------
 4 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/tests/functional/arm/test_bpim2u.py b/tests/functional/arm/test_bpim2u.py
index 9192a2fbec4..e6fd80ae9d0 100755
--- a/tests/functional/arm/test_bpim2u.py
+++ b/tests/functional/arm/test_bpim2u.py
@@ -14,9 +14,10 @@
 class BananaPiMachine(LinuxKernelTest):
 
     ASSET_DEB = Asset(
-        ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
-         'linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb'),
-        '3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22')
+        ('https://apt.armbian.com/pool/main/l/linux-6.6.44/'
+         'linux-image-current-sunxi_24.8.2_armhf__6.6.44-'
+         'S7213-D53de-P4ceb-C697eH5c21-HK01ba-V014b-B58e9-R448a.deb'),
+        'd960131bed01a8bf48882ff133a37826dfdce84138f9a82e0bea331ba795fe78')
 
     ASSET_INITRD = Asset(
         ('https://github.com/groeck/linux-build-test/raw/'
@@ -37,8 +38,8 @@ class BananaPiMachine(LinuxKernelTest):
     def test_arm_bpim2u(self):
         self.set_machine('bpim2u')
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
@@ -56,8 +57,8 @@ def test_arm_bpim2u(self):
     def test_arm_bpim2u_initrd(self):
         self.set_machine('bpim2u')
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         initrd_path = self.uncompress(self.ASSET_INITRD)
@@ -89,8 +90,8 @@ def test_arm_bpim2u_gmac(self):
 
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/'
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         rootfs_path = self.uncompress(self.ASSET_ROOTFS)
diff --git a/tests/functional/arm/test_cubieboard.py b/tests/functional/arm/test_cubieboard.py
index b536c2f77a0..eeafc26f90d 100755
--- a/tests/functional/arm/test_cubieboard.py
+++ b/tests/functional/arm/test_cubieboard.py
@@ -13,9 +13,10 @@
 class CubieboardMachine(LinuxKernelTest):
 
     ASSET_DEB = Asset(
-        ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
-         'linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb'),
-        '3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22')
+        ('https://apt.armbian.com/pool/main/l/linux-6.6.44/'
+         'linux-image-current-sunxi_24.8.2_armhf__6.6.44-'
+         'S7213-D53de-P4ceb-C697eH5c21-HK01ba-V014b-B58e9-R448a.deb'),
+        'd960131bed01a8bf48882ff133a37826dfdce84138f9a82e0bea331ba795fe78')
 
     ASSET_INITRD = Asset(
         ('https://github.com/groeck/linux-build-test/raw/'
@@ -37,8 +38,8 @@ class CubieboardMachine(LinuxKernelTest):
     def test_arm_cubieboard_initrd(self):
         self.set_machine('cubieboard')
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/' +
                     'sun4i-a10-cubieboard.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         initrd_path = self.uncompress(self.ASSET_INITRD)
@@ -68,8 +69,8 @@ def test_arm_cubieboard_initrd(self):
     def test_arm_cubieboard_sata(self):
         self.set_machine('cubieboard')
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/' +
                     'sun4i-a10-cubieboard.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
diff --git a/tests/functional/arm/test_orangepi.py b/tests/functional/arm/test_orangepi.py
index 09780236553..c9cfdbd67aa 100755
--- a/tests/functional/arm/test_orangepi.py
+++ b/tests/functional/arm/test_orangepi.py
@@ -16,9 +16,10 @@
 class OrangePiMachine(LinuxKernelTest):
 
     ASSET_DEB = Asset(
-        ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
-         'linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb'),
-        '3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22')
+        ('https://apt.armbian.com/pool/main/l/linux-6.6.44/'
+         'linux-image-current-sunxi_24.8.2_armhf__6.6.44-'
+         'S7213-D53de-P4ceb-C697eH5c21-HK01ba-V014b-B58e9-R448a.deb'),
+        'd960131bed01a8bf48882ff133a37826dfdce84138f9a82e0bea331ba795fe78')
 
     ASSET_INITRD = Asset(
         ('https://github.com/groeck/linux-build-test/raw/'
@@ -49,8 +50,8 @@ class OrangePiMachine(LinuxKernelTest):
     def test_arm_orangepi(self):
         self.set_machine('orangepi-pc')
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/' +
                     'sun8i-h3-orangepi-pc.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
 
@@ -68,8 +69,8 @@ def test_arm_orangepi(self):
     def test_arm_orangepi_initrd(self):
         self.set_machine('orangepi-pc')
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/' +
                     'sun8i-h3-orangepi-pc.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         initrd_path = self.uncompress(self.ASSET_INITRD)
@@ -99,8 +100,8 @@ def test_arm_orangepi_sd(self):
         self.set_machine('orangepi-pc')
         self.require_netdev('user')
         kernel_path = self.archive_extract(
-            self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = ('usr/lib/linux-image-6.6.16-current-sunxi/' +
+            self.ASSET_DEB, member='boot/vmlinuz-6.6.44-current-sunxi')
+        dtb_path = ('usr/lib/linux-image-6.6.44-current-sunxi/' +
                     'sun8i-h3-orangepi-pc.dtb')
         dtb_path = self.archive_extract(self.ASSET_DEB, member=dtb_path)
         rootfs_path = self.uncompress(self.ASSET_ROOTFS)
diff --git a/tests/functional/arm/test_replay.py b/tests/functional/arm/test_replay.py
index e002e6a2647..ee61f475930 100755
--- a/tests/functional/arm/test_replay.py
+++ b/tests/functional/arm/test_replay.py
@@ -24,10 +24,10 @@ def test_virt(self):
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
     ASSET_CUBIE_KERNEL = Asset(
-        ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
-         'linux-image-current-sunxi_24.2.1_armhf_'
-         '_6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb'),
-        '3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22')
+        ('https://apt.armbian.com/pool/main/l/linux-6.6.44/'
+         'linux-image-current-sunxi_24.8.2_armhf__6.6.44-'
+         'S7213-D53de-P4ceb-C697eH5c21-HK01ba-V014b-B58e9-R448a.deb'),
+        'd960131bed01a8bf48882ff133a37826dfdce84138f9a82e0bea331ba795fe78')
 
     ASSET_CUBIE_INITRD = Asset(
         ('https://github.com/groeck/linux-build-test/raw/'
@@ -37,9 +37,9 @@ def test_virt(self):
     def test_cubieboard(self):
         self.set_machine('cubieboard')
         kernel_path = self.archive_extract(self.ASSET_CUBIE_KERNEL,
-            member='boot/vmlinuz-6.6.16-current-sunxi')
+            member='boot/vmlinuz-6.6.44-current-sunxi')
         dtb_path = self.archive_extract(self.ASSET_CUBIE_KERNEL,
-            member='usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb')
+            member='usr/lib/linux-image-6.6.44-current-sunxi/sun4i-a10-cubieboard.dtb')
         initrd_path = self.uncompress(self.ASSET_CUBIE_INITRD)
 
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-- 
2.56.1


