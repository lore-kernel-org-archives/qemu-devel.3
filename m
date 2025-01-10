Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32160E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFq6-0002ru-LT; Fri, 10 Jan 2025 09:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFq4-0002rJ-Rh
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFq3-000592-89
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yOPMrtd2CeouWijdYu9RCahU09JP6pmvqj4w20TNWk=;
 b=Algkr3ESydnfu8XO1HGGRlHqzWJ0M0gtZBE+S++Sjn6R5Mv/ECdJ941AiXXrU0hC42xPaZ
 9ILDAPvOeyAuU0mHzG4izCVr350PMXrUmE9AQM/QOIKPM5SIyU/PDGWfllInGQkyUcSjny
 AvS06C/O53ALxbuwmGGgNpqxt5UOQTo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-WtOlo-NoN_mFzMHt31GrrA-1; Fri,
 10 Jan 2025 09:18:10 -0500
X-MC-Unique: WtOlo-NoN_mFzMHt31GrrA-1
X-Mimecast-MFC-AGG-ID: WtOlo-NoN_mFzMHt31GrrA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAD6119560AA; Fri, 10 Jan 2025 14:18:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EED0C195E3D9; Fri, 10 Jan 2025 14:18:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/9] ppc/ppc405: Remove tests
Date: Fri, 10 Jan 2025 15:17:52 +0100
Message-ID: <20250110141800.1587589-2-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Since we are about to remove all support for PPC 405, start by
removing the tests referring to the ref405ep machine.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/m48t59-test.c        |  5 -----
 tests/functional/meson.build     |  1 -
 tests/functional/test_ppc_405.py | 37 --------------------------------
 tests/qtest/meson.build          |  1 -
 4 files changed, 44 deletions(-)
 delete mode 100755 tests/functional/test_ppc_405.py

diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index 605797ab785d..1e39a0e8f07a 100644
--- a/tests/qtest/m48t59-test.c
+++ b/tests/qtest/m48t59-test.c
@@ -247,11 +247,6 @@ static void base_setup(void)
         base_year = 1968;
         base_machine = "SS-5";
         use_mmio = true;
-    } else if (g_str_equal(arch, "ppc") || g_str_equal(arch, "ppc64")) {
-        base = 0xF0000000;
-        base_year = 1968;
-        base_machine = "ref405ep";
-        use_mmio = true;
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a5087fcb34fc..9dd26d0ee8c4 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -156,7 +156,6 @@ tests_ppc_system_quick = [
 ]
 
 tests_ppc_system_thorough = [
-  'ppc_405',
   'ppc_40p',
   'ppc_amiga',
   'ppc_bamboo',
diff --git a/tests/functional/test_ppc_405.py b/tests/functional/test_ppc_405.py
deleted file mode 100755
index 9851c03ee998..000000000000
--- a/tests/functional/test_ppc_405.py
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/usr/bin/env python3
-#
-# Test that the U-Boot firmware boots on ppc 405 machines and check the console
-#
-# Copyright (c) 2021 Red Hat, Inc.
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import exec_command_and_wait_for_pattern
-
-class Ppc405Machine(QemuSystemTest):
-
-    timeout = 90
-
-    ASSET_UBOOT = Asset(
-        ('https://gitlab.com/huth/u-boot/-/raw/taihu-2021-10-09/'
-         'u-boot-taihu.bin'),
-        'a076bb6cdeaafa406330e51e074b66d8878d9036d67d4caa0137be03ee4c112c')
-
-    def do_test_ppc405(self):
-        file_path = self.ASSET_UBOOT.fetch()
-        self.vm.set_console(console_index=1)
-        self.vm.add_args('-bios', file_path)
-        self.vm.launch()
-        wait_for_console_pattern(self, 'AMCC PPC405EP Evaluation Board')
-        exec_command_and_wait_for_pattern(self, 'reset', 'AMCC PowerPC 405EP')
-
-    def test_ppc_ref405ep(self):
-        self.require_accelerator("tcg")
-        self.set_machine('ref405ep')
-        self.do_test_ppc405()
-
-if __name__ == '__main__':
-    QemuSystemTest.main()
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c50c..48885917d279 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -168,7 +168,6 @@ qtests_mips64el = qtests_mips
 qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
-  (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
   (config_all_accel.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
   (config_all_accel.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
-- 
2.47.1


