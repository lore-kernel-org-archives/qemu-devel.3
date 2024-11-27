Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8481AD66BA3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 01:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG7FF-0001XN-3M; Tue, 26 Nov 2024 20:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1tG7FB-0001V4-Ek
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 20:53:29 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1tG7F8-0004ZI-K7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 20:53:29 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxGeCIe0Zn14FJAA--.12093S3;
 Wed, 27 Nov 2024 09:53:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCx70eFe0ZneE5pAA--.45011S2;
 Wed, 27 Nov 2024 09:53:10 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Song Gao <gaosong@loongson.cn>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 peter.maydell@linaro.org
Subject: [PATCH] tests/functional: Fix the running test case causes
 loongarch64 to hang
Date: Wed, 27 Nov 2024 09:34:38 +0800
Message-Id: <20241127013438.2206426-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx70eFe0ZneE5pAA--.45011S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

There is a bug in the process of resolving the serial port base address
in the fdt of the loongarch VM UEFI. When both serial port information
and rng-seed information are chosen in the fdt, there is a probability
that the serial port base address cannot be resolved correctly.
This problem can be fixed by updating UEFI.

issue link:
https://gitlab.com/qemu-project/qemu/-/issues/2686

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: <peter.maydell@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>

 tests/functional/test_loongarch64_virt.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/test_loongarch64_virt.py
index 2b8baa2c2a..b7d9abf933 100755
--- a/tests/functional/test_loongarch64_virt.py
+++ b/tests/functional/test_loongarch64_virt.py
@@ -18,16 +18,16 @@ class LoongArchMachine(QemuSystemTest):
 
     ASSET_KERNEL = Asset(
         ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-         'releases/download/2024-05-30/vmlinuz.efi'),
+         'releases/download/2024-11-26/vmlinuz.efi'),
         '08b88a45f48a5fd92260bae895be4e5175be2397481a6f7821b9f39b2965b79e')
     ASSET_INITRD = Asset(
         ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-         'releases/download/2024-05-30/ramdisk'),
+         'releases/download/2024-11-26/ramdisk'),
         '03d6fb6f8ee64ecac961120a0bdacf741f17b3bee2141f17fa01908c8baf176a')
     ASSET_BIOS = Asset(
         ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-         'releases/download/2024-05-30/QEMU_EFI.fd'),
-        '937c1e7815e2340150c194a9f8f0474259038a3d7b8845ed62cc08163c46bea1')
+         'releases/download/2024-11-26/QEMU_EFI.fd'),
+        'f55fbf5d92e885844631ae9bfa8887f659bbb4f6ef2beea9e9ff8bc0603b6697')
 
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(self, success_message,
-- 
2.39.1


