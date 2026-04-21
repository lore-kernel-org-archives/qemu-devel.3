Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46459F5A8D2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3kQ-00015C-BO; Tue, 21 Apr 2026 01:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3kF-0000fv-C9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:34:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3kA-0004ZW-PB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:56 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso2714258a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749633; x=1777354433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tY/qxLv+6MgU0IiIphGv/gCJH4XtLm4qBwv2FYa1ikg=;
 b=KC9B504NeP7bQ+fPiKMlGkbxnz6hOc9rcyAHg5d8f1VM+8/ikBUt1oDiugBCQtvZwu
 nV1jWjCowd3/FStva8VbNPB9Vna6kd7oBtykNYcAqaLja7dyTjn6LUUv/1cHTyEvePhF
 z6lA5Szu6Y+Ecvw7cic9IsDIlcFf3G7VLRb+zIbf1sLdLmoed4VxW5B5sK0Q3AAKnUNF
 em/+zXNgIk4tiiFYkTTg0ml8mVE6L474u4gf77qSTz7piuA3vEZ9KiCOIlxqLoZiyU4k
 xbgX+CeOByHkobbpgZeffgMDrw6AbDrMinQeHCZRjClqrwlndwHB5d5Jmyb05yHQ1ocg
 S9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749633; x=1777354433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tY/qxLv+6MgU0IiIphGv/gCJH4XtLm4qBwv2FYa1ikg=;
 b=FlaeGbZ/1Wg81hVzpoLAMh8++YO7vRLFoAhc4a7qChE7b8jmARN/NAv29mQ81ttRay
 M3Jl+EGwB1IbEp3+T/agKFpmUcAXggjqe7wDMsMEgfsMrgqGxjxhaIBtFJffG7CcY+wv
 3lTYzqCGBKyqUGLOmtI8MGhB0zbzn0bXFFkuxCYCRN7/hNbcn98IhvaAn9R4rm1fdH4M
 HnktSn2LZa9WbzBJbWfyBMmxL9s9ljRW1JwR5EVnVwdOG+t53Lhx5LrKrf5OxW1b4hLB
 vJOpR5a2jYz6BYQi4L6ngSAnmM9gVZLozK2BBrkDi24UKPB+q/Z2C6MU4yNPsKEM9J0O
 yarw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lhFL/W4PQiQwhgU3RvcalqoncCuBWtRY69YHk+dVMNHzzPNi81GulRfHeRFF6XFEhgesDcnUog8K4@nongnu.org
X-Gm-Message-State: AOJu0Yz9gPNv7oYkPvkW2CBLbF4ss/R+bVlYwHfGxBauegiTaTfiEyyZ
 gY1y2vHXE7tTDALSurin/92X5O3ZDdfzM6wvwdtn/bAnfiabn2HPAu25
X-Gm-Gg: AeBDietWQf6b0zLQmN0tiY2/X1v4RFK8S/UH6v7QQGEFOZQxIo35GDoPhGZU8CqT6EC
 9OMgv12tMgLdeq9hmsD/6d6d75XsUvv8koDMe8KD8Rh8e/lDx900vwERLo2D0zN8Eg7IKOKWt8s
 3plkWZGmjwTmbJJdNU+igH53FfuhIXUDmYXNg2SfpYEBe03AM6jgJQO/ZUWYFkU2g3n6A8AR7FJ
 aOuURuPXAYkxqgt5YubaYKKdWGdshU+64LITnfSFu1LvWd99Q8xqRLzEsPERTZOBzSdj57j5pNR
 w1WJOSkQ6IEEDjKvisBP/qnLBk0YosKil/qskJ1ii9I1ZLx7vAqFsm3m4mAZLtiYLhbCcI1CQ5a
 cGSNQK83nd/Eguu4BroT/7/9hIrb9JaGtlKfhjZ62xzGfIY+ZUxb3ydm+jkEV1i8JIrmeCMyMN4
 4+UKKHrv1Jp9aMcMtKTSjqsYn+2D0WDdhDN/KGbogo4M98fKTmCMeJyK8sa4v+tuGnLf+sTMfSQ
 tb5JSmWozfDRCzY72NYr+J1VjMF3I0oFUY3mQ==
X-Received: by 2002:a17:90a:f16:b0:361:4521:d311 with SMTP id
 98e67ed59e1d1-36145221bbfmr10637957a91.18.1776749633493; 
 Mon, 20 Apr 2026 22:33:53 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:52 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 11/13] tests/functional/riscv64: Add tt-atlantis tests
Date: Tue, 21 Apr 2026 15:31:36 +1000
Message-ID: <20260421053140.752059-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
tests/functional/riscv64/test_sifive_u.py.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
 - Fix path to test files
 - Dedupe command line root argument
 - Remove unused import
---
 MAINTAINERS                                  |  1 +
 tests/functional/riscv64/meson.build         |  1 +
 tests/functional/riscv64/test_opensbi.py     |  4 ++
 tests/functional/riscv64/test_tt_atlantis.py | 63 ++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 635a380945fd..9622ffc9edb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1770,6 +1770,7 @@ F: docs/system/riscv/tt_*.rst
 F: hw/riscv/tt_*.c
 F: hw/riscv/aia.[ch]
 F: include/hw/riscv/tt_*.h
+F: tests/functional/riscv64/test_tt_*.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7df9..c4456fabd757 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -13,5 +13,6 @@ tests_riscv64_system_quick = [
 tests_riscv64_system_thorough = [
   'boston',
   'sifive_u',
+  'tt_atlantis',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index d077e40f4278..0f8beb7e7a8c 100755
--- a/tests/functional/riscv64/test_opensbi.py
+++ b/tests/functional/riscv64/test_opensbi.py
@@ -28,6 +28,10 @@ def test_riscv_sifive_u(self):
         self.set_machine('sifive_u')
         self.boot_opensbi()
 
+    def test_riscv_tt_atlantis(self):
+        self.set_machine('tt-atlantis')
+        self.boot_opensbi()
+
     def test_riscv_virt(self):
         self.set_machine('virt')
         self.boot_opensbi()
diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
new file mode 100755
index 000000000000..f6f4b7ceec34
--- /dev/null
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -0,0 +1,63 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Tenstorrent Atlantis machine
+# and checks the console
+#
+# Copyright (c) Linaro Ltd.
+# Copyright 2026 Tenstorrent
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import Asset, LinuxKernelTest
+
+
+class TTAtlantis(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
+         'rootfs.ext2.gz'),
+        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
+
+    def do_test_riscv64_tt_atlantis(self, connect_disk):
+        self.set_machine('tt-atlantis')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon=sbi '
+
+        if connect_disk:
+            kernel_command_line += 'root=/dev/vda panic=-1 noreboot rootwait '
+            self.vm.add_args('-device',
+                             'virtio-blk,drive=drive0,serial=0x1234,bus=pcie.0')
+            self.vm.add_args('-drive',
+                             f'file={rootfs_path},if=none,id=drive0,format=raw')
+            pattern = 'Boot successful.'
+        else:
+            kernel_command_line += 'panic=0 noreboot '
+            pattern = 'Cannot open root device'
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+
+        self.vm.launch()
+        self.wait_for_console_pattern(pattern)
+
+        os.remove(rootfs_path)
+
+    def test_riscv64_tt_atlantis(self):
+        self.do_test_riscv64_tt_atlantis(False)
+
+    def test_riscv64_tt_atlantis_disk(self):
+        self.do_test_riscv64_tt_atlantis(True)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.3


