Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF59C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfM6-000829-Ma; Thu, 30 May 2024 08:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sCfM4-00081m-Iz
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:58:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sCfM1-0003lL-5l
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:58:04 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxe+rPd1hm5KUBAA--.7010S3;
 Thu, 30 May 2024 20:57:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPMfMd1hmUTgOAA--.37533S2; 
 Thu, 30 May 2024 20:57:49 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	clg@redhat.com,
	maobibo@loongson.cn
Subject: [PATCH] tests/avocado: Update LoongArch bios file
Date: Thu, 30 May 2024 20:57:44 +0800
Message-Id: <20240530125744.1985487-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPMfMd1hmUTgOAA--.37533S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The VM uses old bios to boot up only 1 cpu, causing the test case to fail.
Update the bios to solve this problem.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 tests/avocado/machine_loongarch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/machine_loongarch.py b/tests/avocado/machine_loongarch.py
index 7d8a3c1fa5..12cc5ed814 100644
--- a/tests/avocado/machine_loongarch.py
+++ b/tests/avocado/machine_loongarch.py
@@ -38,7 +38,7 @@ def test_loongarch64_devices(self):
 
         bios_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
                     'releases/download/binary-files/QEMU_EFI.fd')
-        bios_hash = ('dfc1bfba4853cd763b9d392d0031827e8addbca8')
+        bios_hash = ('f4d0966b5117d4cd82327c050dd668741046be69')
         bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
 
         self.vm.set_console()
-- 
2.34.1


