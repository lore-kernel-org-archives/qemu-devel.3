Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D42CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWMw-0001N8-SS; Thu, 15 Oct 2026 21:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM7-0000QG-Nv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM5-0004HI-95
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso19136975ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112607; x=1792717407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/rlpFAak32uoOOtxAQra1BEtEJ7canSowT2OeXPKEk=;
 b=sFMgYcFGlnNLtA5NS1tJ5Z+SCc1jnKe8XyHENWe1LScUeWBEe+lscqAxD4UPzk5cz1
 KRiUEA2xI545tWZgjJlbu43PyyEdnWeoupb2lhDuBkt/M/VfC/DshdlOUft5mCGHUM6P
 IhNR0N3BR+zgMfbYw96pE6IF/6BsqwweLiuw2iVdSQ4/YF489dgqmLAPiT6bjuKG9E8s
 GNeYR2mvUC+uKP3MI5SW6487k4cgkNpSd+Tzw/TDciM3jKIgIwOhapDLcVkaXATUD0LU
 v0HESZS8kV4Y1TGFbAWylkAQ9ftgPVLmLK/Fqdi07sxn3lM6dLzMpA/9/YrXL1oQfIY4
 xS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112607; x=1792717407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/rlpFAak32uoOOtxAQra1BEtEJ7canSowT2OeXPKEk=;
 b=1hV0L3PZpU+MvzpyD30EpWkVe6ptN7hpPbmdfkbXcNMKCh26s4WuXzQ93IJF6Yr0qE
 Ee1wlOd4awRinaC+qlqPHyUaI3ebUcInoOVYGo5xp3YHUQPTKgvckDey1/kuiZxVWse6
 vKogF+keW1VPRpZexeolrbez9ucm3lMBC+exDubHRsYW7hXnQpdGjURGE6hJkb+A0jh1
 dnSZHETP5qOHZcZQDxbo65rMcBOl//TL9fb1I6joCkaExYYaJj3ce40VqpWJtpejB0HG
 ySrpKKVoZTq22g/92oFuTnO+RT2xdi51W1rHlHkvMnkooTw4zw2cHbH0L5kliHgTC7qS
 xxqw==
X-Gm-Message-State: AFq9FYK1BEexAAecKBDaW0fSz0Ev2CaWS7bXiAaBcYq+wGkWhJj7kUSR
 1uey6lB9MGc3R4c7aK5mD5XfdVPJiUCD9qq2pXwDoRu+8szr9cxFp4wT8hpjqQ==
X-Gm-Gg: AYBFou0gqADNy4Pr/7TeJcsqNFTiW+PpRpud2B0+GpG+WUuSyXDUcvB8mzmKHKgug0j
 uoXH6nhebN3+/a9ik3zBtXKcr90n+YkijwBCZivKGVd1cPPo4ogJUOS8KrmYWuwkqk4qwlnvDX1
 lPjX6j0kDVlv19Bz60KlUVZIN2qLitI/vntbCkUfyWNi6SRAIb/uCc3J06Jjb8sfGIlTyJH2qGh
 UhMdhuXvAMzVirYaSVs3X+0qfOwGvdc/UUh2qf1+mtRhnYSKY6Udsm+o7bxhDOtS2W5RdS9V6wB
 XhKEpEV//uQZZ8kjJp4W/qwG0AyTK0JVqypSsPnXNxuvTEpwuzJRM0I+/OY5aeVS3zm/q7JY5VF
 RT5KoyNNTP107vBLe4plIyJIsG4hhC4QLhL5L7k8enn4bA9sObEQv9CRj0VDlpz18Ym8Kj7nIOQ
 NB3v/uSlSxMqvItGS2aAcThy8HVMd0N/Rb2U8A2WhtDhQUW2jE36yvmmfHNegAnL1QFE1t9N3ht
 nJf0JEU5W0hvtOaI1BtuZfkdCM=
X-Received: by 2002:a17:903:19e8:b0:2dd:ad74:ac2e with SMTP id
 d9443c01a7336-2e842bc70femr184207005ad.23.1792112606795; 
 Thu, 15 Oct 2026 18:03:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 14/50] tests/functional/riscv64: Add boot test for Milk-V
 Duo board
Date: Fri, 16 Oct 2026 11:02:01 +1000
Message-ID: <20261016010237.1102834-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add a functional boot test for the Milk-V Duo board to validate the
end-to-end boot flow.

$ ./build/run ./tests/functional/riscv64/test_milkv_duo.py
TAP version 13
ok 1 test_milkv_duo.MilkvDuoMachine.test_riscv64_milkv_duo
1..1

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Message-ID: <20260927201326.650943-7-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                |  1 +
 tests/functional/riscv64/meson.build       |  1 +
 tests/functional/riscv64/test_milkv_duo.py | 53 ++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100755 tests/functional/riscv64/test_milkv_duo.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 8de16c1959..a8751210ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1879,6 +1879,7 @@ F: hw/riscv/cv1800b.c
 F: hw/riscv/milkv_duo.c
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
index 0000000000..6a7e2a5d19
--- /dev/null
+++ b/tests/functional/riscv64/test_milkv_duo.py
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Milk-V Duo machine
+#
+# Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import skipIfMissingCommands, wait_for_console_pattern
+
+class MilkvDuoMachine(LinuxKernelTest):
+
+    timeout = 120
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0'
+    )
+    ASSET_DTBS = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/dtbs.tar.xz',
+        '97e5e65a7e6c68303e53486af120c0846ee8df572e9c15f0c4dccb831d0cef4b'
+    )
+    ASSET_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
+        'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004'
+    )
+
+    @skipIfMissingCommands('zstd')
+    def test_riscv64_milkv_duo(self):
+        self.set_machine('milkv-duo')
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.archive_extract(
+            self.ASSET_DTBS, member='dtbs/sophgo/cv1800b-milkv-duo.dtb')
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
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
+        wait_for_console_pattern(self, 'Machine model: Milk-V Duo')
+        wait_for_console_pattern(self, 'Welcome to TuxTest')
+        wait_for_console_pattern(self, 'tuxtest login:')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.55.0


