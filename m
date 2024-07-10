Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC1C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 11:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRVKq-0003Lx-Kw; Wed, 10 Jul 2024 07:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRVKo-0003Ky-F3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 07:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRVKm-0004bp-Pe
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 07:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720610283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7abA/sUs4O+FT1rN7yDGBje1HYkj85kkJXZndgMyMog=;
 b=LvhKwrvWMm/RhsFpQOGVwl+YQ9sen+Tk85ZFoP6hmxecXJdrwh788NVCQx2f7glugGq9ON
 Tv2/PmiXo4Ozp3jDUSEmIAmEngNvgzx/qE9PrFa1Tc9O6e3vEz51YsGjkpL5HebYXAX82E
 LsaVe8I7kAYiWg4Gseo812cYA36xeLQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-tbtBlsTFOPGWD960Y2XDbA-1; Wed,
 10 Jul 2024 07:18:00 -0400
X-MC-Unique: tbtBlsTFOPGWD960Y2XDbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 112D7196CDF1; Wed, 10 Jul 2024 11:17:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C37D01955E76; Wed, 10 Jul 2024 11:17:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] tests/avocado: Remove non-working sparc leon3 test
Date: Wed, 10 Jul 2024 13:17:49 +0200
Message-ID: <20240710111755.60584-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The test has been marked as broken more than 4 years ago, and
so far nobody ever cared to fix it. Thus let's simply remove it
now ... if somebody ever needs it again, they can restore the
file from an older version of QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/machine_sparc_leon3.py | 37 ----------------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 tests/avocado/machine_sparc_leon3.py

diff --git a/tests/avocado/machine_sparc_leon3.py b/tests/avocado/machine_sparc_leon3.py
deleted file mode 100644
index e61b223185..0000000000
--- a/tests/avocado/machine_sparc_leon3.py
+++ /dev/null
@@ -1,37 +0,0 @@
-# Functional test that boots a Leon3 machine and checks its serial console.
-#
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado import skip
-
-
-class Leon3Machine(QemuSystemTest):
-
-    timeout = 60
-
-    @skip("Test currently broken")
-    # A Window Underflow exception occurs before booting the kernel,
-    # and QEMU exit calling cpu_abort(), which makes this test to fail.
-    def test_leon3_helenos_uimage(self):
-        """
-        :avocado: tags=arch:sparc
-        :avocado: tags=machine:leon3_generic
-        :avocado: tags=binfmt:uimage
-        """
-        kernel_url = ('http://www.helenos.org/releases/'
-                      'HelenOS-0.6.0-sparc32-leon3.bin')
-        kernel_hash = 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_path)
-
-        self.vm.launch()
-
-        wait_for_console_pattern(self, 'Copyright (c) 2001-2014 HelenOS project')
-        wait_for_console_pattern(self, 'Booting the kernel ...')
-- 
2.45.2


