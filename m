Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E8FD78783
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9Kk-0008TJ-9b; Thu, 21 Nov 2024 10:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Kh-0008Sp-PR
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Kg-0000jz-90
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yj5+vx0K0OlA1WTlyKTZ9b/IpvJBZdLUFFn25VVcPtE=;
 b=RwMzZ9BqTtjquco7IRv3rIuX1Ur243cemNPOPpj9FUPHddvgC2dqbdjV8ApAg12MtRLQBZ
 TJiVjFoyMepImeHKPIVlNqGDg0h87a0M29f/ZfkHBjvGUV5D6bQcKfO0Lp0cR2wdQtg7nA
 yD0NEHYmVXiubXQixgojkYMi3AUinXU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-4EqBEcFjN0imH1vHQ11iwQ-1; Thu,
 21 Nov 2024 10:42:58 -0500
X-MC-Unique: 4EqBEcFjN0imH1vHQ11iwQ-1
X-Mimecast-MFC-AGG-ID: 4EqBEcFjN0imH1vHQ11iwQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00991954128; Thu, 21 Nov 2024 15:42:56 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16E4E1956086; Thu, 21 Nov 2024 15:42:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/18] tests/functional: remove leftover :avocado: tags
Date: Thu, 21 Nov 2024 15:42:05 +0000
Message-ID: <20241121154218.1423005-6-berrange@redhat.com>
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com>
References: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These tags are not honoured under the new functional test harness.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_arm_bpim2u.py   | 20 --------------------
 tests/functional/test_arm_orangepi.py | 27 ---------------------------
 2 files changed, 47 deletions(-)

diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 2f9fa145e3..35ea58d46c 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -37,11 +37,6 @@ class BananaPiMachine(LinuxKernelTest):
         '5b41b4e11423e562c6011640f9a7cd3bdd0a3d42b83430f7caa70a432e6cd82c')
 
     def test_arm_bpim2u(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=accel:tcg
-        """
         self.set_machine('bpim2u')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -64,11 +59,6 @@ def test_arm_bpim2u(self):
         os.remove(dtb_path)
 
     def test_arm_bpim2u_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:bpim2u
-        """
         self.set_machine('bpim2u')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -105,11 +95,6 @@ def test_arm_bpim2u_initrd(self):
         os.remove(initrd_path)
 
     def test_arm_bpim2u_gmac(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=device:sd
-        """
         self.set_machine('bpim2u')
         self.require_netdev('user')
 
@@ -160,11 +145,6 @@ def test_arm_bpim2u_gmac(self):
 
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_bpim2u_openwrt_22_03_3(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=device:sd
-        """
         self.set_machine('bpim2u')
         # This test download a 8.9 MiB compressed image and expand it
         # to 127 MiB.
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index d2ed5fcc82..6d57223a03 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -49,11 +49,6 @@ class BananaPiMachine(LinuxKernelTest):
         '20d3e07dc057e15c12452620e90ecab2047f0f7940d9cba8182ebc795927177f')
 
     def test_arm_orangepi(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=accel:tcg
-        """
         self.set_machine('orangepi-pc')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -75,11 +70,6 @@ def test_arm_orangepi(self):
         os.remove(dtb_path)
 
     def test_arm_orangepi_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:orangepi-pc
-        """
         self.set_machine('orangepi-pc')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -115,12 +105,6 @@ def test_arm_orangepi_initrd(self):
         os.remove(initrd_path)
 
     def test_arm_orangepi_sd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        """
         self.set_machine('orangepi-pc')
         self.require_netdev('user')
         deb_path = self.ASSET_DEB.fetch()
@@ -167,11 +151,6 @@ def test_arm_orangepi_sd(self):
 
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_orangepi_armbian(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        """
         self.set_machine('orangepi-pc')
         # This test download a 275 MiB compressed image and expand it
         # to 1036 MiB, but the underlying filesystem is 1552 MiB...
@@ -208,12 +187,6 @@ def test_arm_orangepi_armbian(self):
 
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_orangepi_uboot_netbsd9(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        :avocado: tags=os:netbsd
-        """
         self.set_machine('orangepi-pc')
         # This test download a 304MB compressed image and expand it to 2GB
         deb_path = self.ASSET_UBOOT.fetch()
-- 
2.46.0


