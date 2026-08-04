Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261FAC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrEzp-0004wg-6A; Tue, 04 Aug 2026 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qiandongyan@loongson.cn>)
 id 1wr5sY-0008Al-IF
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 23:31:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qiandongyan@loongson.cn>) id 1wr5sW-0002VQ-B8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 23:31:45 -0400
Received: from loongson.cn (unknown [10.2.9.245])
 by gateway (Coremail) with SMTP id _____8CxJOoYXXFqIigKAA--.31981S3;
 Tue, 04 Aug 2026 11:31:36 +0800 (CST)
Received: from code-server.gen (unknown [10.2.9.245])
 by front1 (Coremail) with SMTP id qMiowJCxLcUXXXFq7fEiAA--.44786S5;
 Tue, 04 Aug 2026 11:31:36 +0800 (CST)
From: Dongyan Qian <qiandongyan@loongson.cn>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com
Subject: [PATCH 3/3] tests/acpi: Update LoongArch virt MADT
Date: Tue,  4 Aug 2026 11:30:36 +0800
Message-Id: <20260804033036.2614008-4-qiandongyan@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260804033036.2614008-1-qiandongyan@loongson.cn>
References: <20260804033036.2614008-1-qiandongyan@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxLcUXXXFq7fEiAA--.44786S5
X-CM-SenderInfo: htld0v5rqj5t3q6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=qiandongyan@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Aug 2026 09:15:48 -0400
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

Regenerate the APIC and APIC.topology test data after correcting the
LoongArch virt MADT revision.

The generated tables change only Header.Revision from 1 to 6 and the
corresponding checksum. Their lengths and interrupt controller
subtables remain unchanged.

Signed-off-by: Dongyan Qian <qiandongyan@loongson.cn>
---
 tests/data/acpi/loongarch64/virt/APIC          | Bin 108 -> 108 bytes
 tests/data/acpi/loongarch64/virt/APIC.topology | Bin 153 -> 153 bytes
 tests/qtest/bios-tables-test-allowed-diff.h    |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
index 3477789f422cad54f16734b3ec9ad1ff5135165d..e90c267e1fdd83143edc732df41ca5659415090d 100644
GIT binary patch
delta 16
Xcmd1F;c^V{bk1R5U|{<&kt+!RBvAxk

delta 16
Xcmd1F;c^V{bk1R5U|{?@kt+!RBuoTf

diff --git a/tests/data/acpi/loongarch64/virt/APIC.topology b/tests/data/acpi/loongarch64/virt/APIC.topology
index da0089d57f608aca230a76b67e72f9f0ad8e71f2..d00b7241c7ad76867781d5649e2de5fb6a5f45bc 100644
GIT binary patch
delta 18
ZcmbQqIFpgfF~HM#CIbTlTi`^legG=>1a<%b

delta 18
ZcmbQqIFpgfF~HM#CIbTlW7tHlegG=+1a<%b

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 0e18673fcd..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/APIC",
-"tests/data/acpi/loongarch64/virt/APIC.topology",
-- 
2.43.0


