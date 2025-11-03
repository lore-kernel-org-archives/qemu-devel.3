Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108AECCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsH6-0003qc-DU; Mon, 03 Nov 2025 05:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsH5-0003qM-3y
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsH2-0004RF-Ta
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y61sGUQ8j9Y2GxmKZ9y4icSR+ggl2UPV90MqL5hxz7c=;
 b=gmsNTvum1xrSPlNhNwD/e3PlH1rdDcCxK/qjYi6Bq1FeEOfREB5c2d+bv90R08/AQ0SOJl
 CmzE9Xi6o2Ky3k0PK6t7nDhAkpKqV7+3WDrq23x+9SWRezrx1x9To0/muCJsdPkcOE/z2+
 /9bE+19IEQOCgnRVXpzKiPCxlsDDcNA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-iyisHhbyNa-sbqvVCDIfYA-1; Mon,
 03 Nov 2025 05:58:53 -0500
X-MC-Unique: iyisHhbyNa-sbqvVCDIfYA-1
X-Mimecast-MFC-AGG-ID: iyisHhbyNa-sbqvVCDIfYA_1762167533
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05B8F180136C; Mon,  3 Nov 2025 10:58:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 585D630001A1; Mon,  3 Nov 2025 10:58:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/22] tests/functional/rx/test_gdbsim: Remove unused variables
Date: Mon,  3 Nov 2025 11:58:09 +0100
Message-ID: <20251103105824.322039-13-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251029081805.63147-1-thuth@redhat.com>
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


