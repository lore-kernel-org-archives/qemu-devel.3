Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDECFD3770
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHbE-0005a9-V4; Wed, 25 Feb 2026 11:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHb8-0005ZF-Ok
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHb5-0005YA-QU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772036326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kMCpKa6E3whzwhZXFGsoThzRuxM/9yjPJs+xWo9Cq4=;
 b=NQTVKIPHaExEpD+EU9Y44jYvegc7rpL7zxoeswNx5oojTwtjKNgYFeKJ+iTKovSC266/js
 exXDcu8jTPC52uA5QoOTbzp46G1xPZstpi99cqAvOlOsJMd8LmTsU3XzPtewpWYgd1GF3b
 +dSUgCjlAbohE8345EdBn1TDwYRDS3g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-PHqz4MaoMVOIXkezlAzHlg-1; Wed,
 25 Feb 2026 11:18:40 -0500
X-MC-Unique: PHqz4MaoMVOIXkezlAzHlg-1
X-Mimecast-MFC-AGG-ID: PHqz4MaoMVOIXkezlAzHlg_1772036318
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A0E1180025C; Wed, 25 Feb 2026 16:18:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ECC21800465; Wed, 25 Feb 2026 16:18:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 1/4] tests/functional: Remove the microblazeel test
Date: Wed, 25 Feb 2026 17:18:18 +0100
Message-ID: <20260225161823.1438850-2-thuth@redhat.com>
In-Reply-To: <20260225161823.1438850-1-thuth@redhat.com>
References: <20260225161823.1438850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

We are going to remove the microblazeel target, so the test is not
required anymore. The little endian mode is tested already via the
"microblaze" target, so we don't lose any test coverage here.

While we're at it, simplify the "microblaze" target test now (in the
file tests/functional/microblaze/test_s3adsp1800.py) since we don't
need the separate super-class here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  1 -
 .../functional/microblaze/test_s3adsp1800.py  | 23 +++-------------
 tests/functional/microblazeel/meson.build     |  5 ----
 .../microblazeel/test_s3adsp1800.py           | 26 -------------------
 4 files changed, 3 insertions(+), 52 deletions(-)
 delete mode 100644 tests/functional/microblazeel/meson.build
 delete mode 100755 tests/functional/microblazeel/test_s3adsp1800.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e1f5c0e7678..b979cff2b97 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -18,7 +18,6 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('microblaze')
-subdir('microblazeel')
 subdir('mips')
 subdir('mipsel')
 subdir('mips64')
diff --git a/tests/functional/microblaze/test_s3adsp1800.py b/tests/functional/microblaze/test_s3adsp1800.py
index f093b162c0a..be78c208e3b 100755
--- a/tests/functional/microblaze/test_s3adsp1800.py
+++ b/tests/functional/microblaze/test_s3adsp1800.py
@@ -14,8 +14,6 @@
 
 class MicroblazeMachine(QemuSystemTest):
 
-    timeout = 90
-
     ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
@@ -25,14 +23,12 @@ class MicroblazeMachine(QemuSystemTest):
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def do_ballerina_be_test(self, force_endianness=False):
+    def test_microblaze_s3adsp1800_big_endian(self):
         self.set_machine('petalogix-s3adsp1800')
         self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day17', 'ballerina.bin'))
-        if force_endianness:
-            self.vm.add_args('-M', 'endianness=big')
         self.vm.launch()
         wait_for_console_pattern(self, 'This architecture does not have '
                                        'kernel memory protection')
@@ -41,14 +37,13 @@ def do_ballerina_be_test(self, force_endianness=False):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
-    def do_xmaton_le_test(self, force_endianness=False):
+    def test_microblaze_s3adsp1800_little_endian(self):
         self.require_netdev('user')
         self.set_machine('petalogix-s3adsp1800')
         self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
-        if force_endianness:
-            self.vm.add_args('-M', 'endianness=little')
+        self.vm.add_args('-M', 'endianness=little')
         tftproot = self.scratch_file('day13')
         self.vm.add_args('-nic', f'user,tftp={tftproot}')
         self.vm.launch()
@@ -60,17 +55,5 @@ def do_xmaton_le_test(self, force_endianness=False):
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
 
-class MicroblazeBigEndianMachine(MicroblazeMachine):
-
-    ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE
-    ASSET_IMAGE_LE = MicroblazeMachine.ASSET_IMAGE_LE
-
-    def test_microblaze_s3adsp1800_legacy_be(self):
-        self.do_ballerina_be_test()
-
-    def test_microblaze_s3adsp1800_legacy_le(self):
-        self.do_xmaton_le_test(force_endianness=True)
-
-
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/microblazeel/meson.build b/tests/functional/microblazeel/meson.build
deleted file mode 100644
index 27619dc5a9a..00000000000
--- a/tests/functional/microblazeel/meson.build
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-tests_microblazeel_system_thorough = [
-  's3adsp1800'
-]
diff --git a/tests/functional/microblazeel/test_s3adsp1800.py b/tests/functional/microblazeel/test_s3adsp1800.py
deleted file mode 100755
index 75ce8856ed1..00000000000
--- a/tests/functional/microblazeel/test_s3adsp1800.py
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/usr/bin/env python3
-#
-# Functional test that boots a microblaze Linux kernel and checks the console
-#
-# Copyright (c) 2018, 2021 Red Hat, Inc.
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-from microblaze.test_s3adsp1800 import MicroblazeMachine
-
-
-class MicroblazeLittleEndianMachine(MicroblazeMachine):
-
-    ASSET_IMAGE_LE = MicroblazeMachine.ASSET_IMAGE_LE
-    ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE
-
-    def test_microblaze_s3adsp1800_legacy_le(self):
-        self.do_xmaton_le_test()
-
-    def test_microblaze_s3adsp1800_legacy_be(self):
-        self.do_ballerina_be_test(force_endianness=True)
-
-
-if __name__ == '__main__':
-    MicroblazeMachine.main()
-- 
2.53.0


