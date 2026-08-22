Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58A5C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxrdT-00022Y-8k; Sat, 22 Aug 2026 15:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wxrdR-00020W-Lp
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:44:09 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wxrdP-0007Bs-W4
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:44:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d0407aedd6so23854365ad.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787427846; x=1788032646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8WKVV9PziZHmSvQUMhJjnQhg2yjA+sQeyn79pi3JXQU=;
 b=IsLEHEH2am6CDiRK/Z6NOKqGDvYyn0npGlI1LrpjdgG1KxcLakp/6pWu1tchVtQ2qc
 NtfYQJAxEe6eas4TKKs3auRwBaxAESa52sQrNeS7PtKepVMAudBLVNjMextGFvz/GlrA
 dD29h9ZFRNwsYdiasWO8rq4vuVJl9BMf33O3InX1Tfanatxq3KHRzbPb5mof+NVyAqTl
 6bsQ/ZZSMcqjhwrt1T6EPtHkEYH3WoLCdD7g+3m5Ac7ptqWYfU/4J1Agu0RU/0DT/0YM
 wTbgWu+A7FZ+5b0fFbLqGcvmNSxdDuM9DTuuZ2+Wsr3o5FpfmNtbwvc9gnFK7COYUUlc
 /fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787427846; x=1788032646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8WKVV9PziZHmSvQUMhJjnQhg2yjA+sQeyn79pi3JXQU=;
 b=JRnb0vQq3bIRn0weRKxXJDnIuX1QAxqDpifPV8WJ63PpIyuDksTpO3sajOhrHNzRod
 f2PWDW6B2d3qVJV/XQ2VD6xEvJ+ydEFAkvwJlfT43LBJRcMQXJVWp2XjNCY1PQ4g9Oe8
 2ZVNCmVWaznFSNHNg4GJAQ1zPS8sz/xodgbhnVZIFGsys/urHQu+muUqhNQ73O9gdnj/
 L2Y3VilyAw9n3vj7FZUPsDgfwfv2fBWdNk2wAL/g7NKPaczc1vcrZfUGFi5Bi+6Jkex4
 +w1q30xVbT7Nk0+zSmYVhTBmo3HrIY2kYJ/fczEdWz7mdf6i8JBEvy0BLoF0xvJi6BtX
 TWig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrb9OHGTF2O/ObohSh+z8lGc1S3FVsSDVspHuCrVzRPs4c/1u17hJklBDbcGj86suk0pdU2PLQU4wSi@nongnu.org
X-Gm-Message-State: AFuF++nzul5iLRO0ovDAcMdXcRG5yJbnUo8KEgEsy7/X2CfbZ81Hzw4+
 xXXRwUiPqqZag3a9ORj7o0oBmDhoQ/DWg+Gjft5XiUssyq8t/ndWkuRj
X-Gm-Gg: AR+sD10h55+QlxfM8dI5NTSqPgU6/oOFGdkAPIm6aKS0W+08SfNSfIB0KbjbqO4AOXK
 idXGvxkZfIFs7BZ8reRVclxNZAShihAJFXOnivH5hX0u7WaWWh7/6NdDTj7BWgDL+XhOwgAF2hO
 Ro8/lukAG74DMH3BQLUbk8KeSp8ImxdSwyhJdzMw/m8XolCWc0LTG1aj2AV6CURgbLDSzrMmreM
 KmLwpHaFKbQFJ4vvpg+XfQ7Gr8bpbJf2t+ExBDOTmHvTMs3TZsxH6fRrRuSyNQhcSyNt/IkGsjO
 nV1mOPLvd8LCniiP82EZ9jLZCq1rOxiqbt41WsBbexn9qCZwcMgG/C+D0c7CClc/nLhm8k49z8I
 qsGGuHAH+4VpVC1S44yqBEoHzw8pgcNGRWdaUIfGVspw4KH2N8xVpZJZNUFPSJXnSJ6B2mkdLfX
 aJfsjEnWjwEnVevmVZMzELrwSJSTSmKy2ifWymsrCtrv1+/XZHATvhKDD3M0FrBvlEi4Pavo9UI
 Z8aGOXFlzfvx+aXIS939f4LPDkdOIbdivXru3Z4QQaJWf1M3k0a0TrgvJS3+dDAsfA0eWKFk3XI
X-Received: by 2002:a17:903:350f:b0:2ca:e9dc:7357 with SMTP id
 d9443c01a7336-2d670d1ff53mr134958015ad.9.1787427846439; 
 Sat, 22 Aug 2026 12:44:06 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676895799sm5892715ad.38.2026.08.22.12.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:44:05 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, almer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw, marscheng@google.com,
 eleanor15x@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 6/7] tests/functional/riscv64: Add boot test for Milk-V Duo
 board
Date: Sat, 22 Aug 2026 19:43:13 +0000
Message-ID: <20260822194315.2550260-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <20260822194315.2550260-1-visitorckw@gmail.com>
References: <20260822194315.2550260-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a functional boot test for the Milk-V Duo board to validate the
end-to-end boot flow.

$ ./build/run ./tests/functional/riscv64/test_milkv_duo.py
TAP version 13
ok 1 test_milkv_duo.MilkvDuoMachine.test_riscv64_milkv_duo
1..1

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                                |  1 +
 tests/functional/riscv64/meson.build       |  1 +
 tests/functional/riscv64/test_milkv_duo.py | 50 ++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100755 tests/functional/riscv64/test_milkv_duo.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 245eb7bb58..3f79334c59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1861,6 +1861,7 @@ F: hw/riscv/milkv_duo.c
 F: include/hw/char/dw8250.h
 F: include/hw/misc/cv1800b_clk.h
 F: include/hw/riscv/cv1800b.h
+F: tests/functional/riscv64/test_milkv_duo.py
 F: tests/qtest/milkv-duo-test.c
 
 RX Machines
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index d1a3e6c2bf..8a4f1d00f9 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -18,4 +18,5 @@ tests_riscv64_system_thorough = [
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
+  'milkv_duo',
 ]
diff --git a/tests/functional/riscv64/test_milkv_duo.py b/tests/functional/riscv64/test_milkv_duo.py
new file mode 100755
index 0000000000..aff247e61f
--- /dev/null
+++ b/tests/functional/riscv64/test_milkv_duo.py
@@ -0,0 +1,50 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Milk-V Duo machine
+#
+# Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import wait_for_console_pattern
+
+class MilkvDuoMachine(LinuxKernelTest):
+
+    timeout = 120
+
+    ASSET_KERNEL = Asset(
+        'https://github.com/visitorckw/milkv-duo-qemu-assets/releases/download/v1.0/Image',
+        '3f157ecfcb86d28bfcff9fd3c1a43f60a8513b1919739fdc9a4d946aba35b2af'
+    )
+    ASSET_DTB = Asset(
+        'https://github.com/visitorckw/milkv-duo-qemu-assets/releases/download/v1.0/cv1800b-milkv-duo.dtb',
+        '2a5d165f64c4b2d55bba282b2974941ab223f6f5220c2e7721e35ab81311c098'
+    )
+    ASSET_ROOTFS = Asset(
+        'https://github.com/visitorckw/milkv-duo-qemu-assets/releases/download/v1.0/rootfs.ext4',
+        '9e7de9222ab4a79d1291866453aa47cd67a543216df6159bf9b42d055240a676'
+    )
+
+    def test_riscv64_milkv_duo(self):
+        self.set_machine('milkv-duo')
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', 'default',
+                         '-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', f'file={rootfs_path},format=raw,id=sd-card,snapshot=on',
+                         '-device', 'sd-card,drive=sd-card',
+                         '-append', 'console=ttyS0,115200 root=/dev/mmcblk0 rootwait earlycon')
+
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'Booting Linux on hartid')
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.55.0.766.g2966f0265a-goog


