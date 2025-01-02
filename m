Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CBAE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIV5-0003wk-N4; Thu, 02 Jan 2025 05:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIV0-0003vn-P6
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUx-0005sB-RC
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735813935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FsBQh+sZn2UqlJIcJFsyt2FwXIRTLK+SOb4qwdhihE=;
 b=INqDpWvNkd0mIjO5KwwDewyjdTJB96X37l22j3ZG4CnWR2peclNFtm+yjI0nkDegnQAUz/
 cpyZWbdE4OgVHfpdX2HDQhU72gecgsx9xV+oRtr3wc4pjwWWxB652+OSQFfqNYc6a+68hW
 TjRl+QQDTYfGVED2UGMSD6C03Y+0wOk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-6qXwaS_QOE2NoIbpXbNr7w-1; Thu,
 02 Jan 2025 05:32:11 -0500
X-MC-Unique: 6qXwaS_QOE2NoIbpXbNr7w-1
X-Mimecast-MFC-AGG-ID: 6qXwaS_QOE2NoIbpXbNr7w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 830D619560A3; Thu,  2 Jan 2025 10:32:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62D651956052; Thu,  2 Jan 2025 10:32:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/10] tests/functional/test_rx_gdbsim: Use stable URL for
 test_linux_sash
Date: Thu,  2 Jan 2025 11:31:37 +0100
Message-ID: <20250102103138.354618-10-thuth@redhat.com>
In-Reply-To: <20250102103138.354618-1-thuth@redhat.com>
References: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Yoshinori said [*] URL references on OSDN were stable, but they
appear not to be. Mirror the artifacts on GitHub to avoid failures
while testing on CI.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg686487.html

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-ID: <20200630202631.7345-1-f4bug@amsat.org>
[huth: Adapt the patch to the new version in the functional framework]
Message-ID: <20241229083419.180423-1-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_rx_gdbsim.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
index 20623aa51c..49245793e1 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -21,13 +21,16 @@ class RxGdbSimMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
     ASSET_UBOOT = Asset(
-        'https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz',
-        '7146567d669e91dbac166384b29aeba1715beb844c8551e904b86831bfd9d046')
+        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/'
+         'u-boot.bin'),
+        'dd7dd4220cccf7aeb32227b26233bf39600db05c3f8e26005bcc2bf6c927207d')
     ASSET_DTB = Asset(
-        'https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb',
+        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/'
+         'rx-gdbsim.dtb'),
         'aa278d9c1907a4501741d7ee57e7f65c02dd1b3e0323b33c6d4247f1b32cf29a')
     ASSET_KERNEL = Asset(
-        'http://acc.dl.osdn.jp/users/23/23845/zImage',
+        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/'
+         'zImage'),
         'baa43205e74a7220ed8482188c5e9ce497226712abb7f4e7e4f825ce19ff9656')
 
     def test_uboot(self):
@@ -36,7 +39,7 @@ def test_uboot(self):
         """
         self.set_machine('gdbsim-r5f562n8')
 
-        uboot_path = self.uncompress(self.ASSET_UBOOT)
+        uboot_path = self.ASSET_UBOOT.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-bios', uboot_path,
-- 
2.47.1


