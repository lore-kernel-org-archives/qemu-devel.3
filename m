Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BBFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GQT-00051z-Fu; Tue, 07 May 2024 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPe-0003o1-Ep; Tue, 07 May 2024 04:43:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPb-0003Fg-32; Tue, 07 May 2024 04:43:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2BBBB64BCE;
 Tue,  7 May 2024 11:42:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 193DAC85B7;
 Tue,  7 May 2024 11:42:30 +0300 (MSK)
Received: (nullmailer pid 1026542 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 10/16] tests/avocado: update sunxi kernel from armbian
 to 6.6.16
Date: Tue,  7 May 2024 11:42:09 +0300
Message-Id: <20240507084226.1026455-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

The Linux kernel 5.10.16 binary for sunxi has been removed from
apt.armbian.com. This means that the avocado tests for these machines
will be skipped (status CANCEL) if the old binary isn't present in
the avocado cache.

Update to 6.6.16, in the same way we did in commit e384db41d8661
when we moved to 5.10.16 in 2021.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2284
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20240415151845.1564201-1-peter.maydell@linaro.org
(cherry picked from commit dcc5c018c7e6acddf81951bcbdf1019b9ab45f56)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 3f0180e1f8..b132b4f8f3 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -549,12 +549,12 @@ def test_arm_cubieboard_initrd(self):
         :avocado: tags=accel:tcg
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
@@ -593,12 +593,12 @@ def test_arm_cubieboard_sata(self):
         :avocado: tags=accel:tcg
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
@@ -775,13 +775,13 @@ def test_arm_bpim2u(self):
         :avocado: tags=machine:bpim2u
         :avocado: tags=accel:tcg
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
-                   'linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
 
@@ -802,13 +802,13 @@ def test_arm_bpim2u_initrd(self):
         :avocado: tags=accel:tcg
         :avocado: tags=machine:bpim2u
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
-                   'linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
@@ -849,13 +849,13 @@ def test_arm_bpim2u_gmac(self):
         """
         self.require_netdev('user')
 
-        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
-                   'linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
@@ -952,12 +952,12 @@ def test_arm_orangepi(self):
         :avocado: tags=accel:tcg
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
 
         self.vm.set_console()
@@ -978,12 +978,12 @@ def test_arm_orangepi_initrd(self):
         :avocado: tags=machine:orangepi-pc
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
@@ -1024,12 +1024,12 @@ def test_arm_orangepi_sd(self):
         self.require_netdev('user')
 
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
                       'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index c37afa662c..4a0201e344 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -193,12 +193,12 @@ def test_arm_cubieboard_initrd(self):
         :avocado: tags=flaky
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
-- 
2.39.2


