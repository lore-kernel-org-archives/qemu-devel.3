Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE53C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrEzu-0004yZ-Lw; Tue, 04 Aug 2026 09:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qiandongyan@loongson.cn>)
 id 1wr5sY-0008An-JY
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 23:31:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qiandongyan@loongson.cn>) id 1wr5sV-0002VS-Rn
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 23:31:45 -0400
Received: from loongson.cn (unknown [10.2.9.245])
 by gateway (Coremail) with SMTP id _____8CxKqgXXXFqHCgKAA--.10056S3;
 Tue, 04 Aug 2026 11:31:35 +0800 (CST)
Received: from code-server.gen (unknown [10.2.9.245])
 by front1 (Coremail) with SMTP id qMiowJCxLcUXXXFq7fEiAA--.44786S3;
 Tue, 04 Aug 2026 11:31:35 +0800 (CST)
From: Dongyan Qian <qiandongyan@loongson.cn>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com
Subject: [PATCH 1/3] tests/acpi: Allow LoongArch virt MADT changes
Date: Tue,  4 Aug 2026 11:30:34 +0800
Message-Id: <20260804033036.2614008-2-qiandongyan@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260804033036.2614008-1-qiandongyan@loongson.cn>
References: <20260804033036.2614008-1-qiandongyan@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxLcUXXXFq7fEiAA--.44786S3
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

The LoongArch virt MADT revision will be corrected to match the
interrupt controller structures it contains.

Allow the APIC and APIC.topology test data to change so that the source
change can be reviewed separately from the regenerated binary tables.

Signed-off-by: Dongyan Qian <qiandongyan@loongson.cn>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..0e18673fcd 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/loongarch64/virt/APIC",
+"tests/data/acpi/loongarch64/virt/APIC.topology",
-- 
2.43.0


