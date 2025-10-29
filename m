Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519CBCCF9F2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1Nt-0002id-U3; Wed, 29 Oct 2025 04:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1Nr-0002gt-GO
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1Nm-0005WW-Hj
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761725891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vWrz578tR/y3O/TjyQLpq8CCH/LHW4S33X7haTf8RSQ=;
 b=Lq60uXItjrac0vsJBus30cr/OFiPdoDU08TQGnYY6MausHvuO/swLgS+GyXrfK0pUypAIO
 ZFgkzvPhd1w9wtKC20fsqLSTKiR0oIm8+jlCMI/9Dw2hitOwAOQrVrtoKsgBuRaMNZ2eVw
 WYHDCaswPgL+djvrz/LQ3KiLjNzOPzY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-C95YMVVSNxaJrBF2tpuslA-1; Wed,
 29 Oct 2025 04:18:09 -0400
X-MC-Unique: C95YMVVSNxaJrBF2tpuslA-1
X-Mimecast-MFC-AGG-ID: C95YMVVSNxaJrBF2tpuslA_1761725888
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E679180121E; Wed, 29 Oct 2025 08:18:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.98])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A520B1800579; Wed, 29 Oct 2025 08:18:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH] tests/functional/rx/test_gdbsim: Remove unused variables
Date: Wed, 29 Oct 2025 09:18:05 +0100
Message-ID: <20251029081805.63147-1-thuth@redhat.com>
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

Remove/comment some unused variables to make pylint happy.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/rx/test_gdbsim.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/functional/rx/test_gdbsim.py b/tests/functional/rx/test_gdbsim.py
index 49245793e17..d31f9a42d67 100755
--- a/tests/functional/rx/test_gdbsim.py
+++ b/tests/functional/rx/test_gdbsim.py
@@ -17,9 +17,6 @@
 
 class RxGdbSimMachine(QemuSystemTest):
 
-    timeout = 30
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
-
     ASSET_UBOOT = Asset(
         ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/'
          'u-boot.bin'),
@@ -47,7 +44,7 @@ def test_uboot(self):
         self.vm.launch()
         uboot_version = 'U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty'
         wait_for_console_pattern(self, uboot_version)
-        gcc_version = 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (experimental)'
+        #gcc_version = 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (experimental)'
         # FIXME limit baudrate on chardev, else we type too fast
         #  https://gitlab.com/qemu-project/qemu/-/issues/2691
         #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
@@ -63,7 +60,6 @@ def test_linux_sash(self):
         kernel_path = self.ASSET_KERNEL.fetch()
 
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon'
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
                          '-no-reboot')
-- 
2.51.0


