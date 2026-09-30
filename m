Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C7CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoJn-0001Sy-Vh; Wed, 30 Sep 2026 03:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xBoJl-0001H8-DV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:01:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xBoJj-0006bI-CD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:01:29 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxX9O8s7xqq0IRAA--.50384S3;
 Wed, 30 Sep 2026 15:01:16 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxOs6ws7xqq+MmAA--.53251S5;
 Wed, 30 Sep 2026 15:01:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>,
 xiaoqiang zhao <zxq_yx_007@163.com>
Subject: [PULL 3/4] tests/acpi: Update SPCR loongarch64 test data
Date: Wed, 30 Sep 2026 15:02:26 +0800
Message-ID: <20260930070227.1079521-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930070227.1079521-1-maobibo@loongson.cn>
References: <20260930070227.1079521-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxOs6ws7xqq+MmAA--.53251S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1fGF4kGw4DXFWrCFW5twc_yoW8Crykp3
 47AwsF9rs7JasrCrn5GFZ7tF1rJFZxCFnFkFyxAryj9wnxurn8ZrnIq34jga43Jw4rur4f
 Zw18Kr10vw1rWwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7MmhUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>

diffs from "iasl -d":

  * ACPI Data Table [SPCR]
  *
@@ -13,7 +13,7 @@
 [000h 0000 004h]                   Signature : "SPCR"    [Serial Port
Console Redirection Table]
 [004h 0004 004h]                Table Length : 00000050
 [008h 0008 001h]                    Revision : 02
-[009h 0009 001h]                    Checksum : C1
+[009h 0009 001h]                    Checksum : D9
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
@@ -25,7 +25,7 @@

 [028h 0040 00Ch]        Serial Port Register : [Generic Address
Structure]
 [028h 0040 001h]                    Space ID : 00 [SystemMemory]
-[029h 0041 001h]                   Bit Width : 20
+[029h 0041 001h]                   Bit Width : 08
 [02Ah 0042 001h]                  Bit Offset : 00
 [02Bh 0043 001h]        Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044 008h]                     Address : 000000001FE001E0

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/data/acpi/loongarch64/virt/SPCR       | Bin 80 -> 80 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 7bb819cd0d2ad20269e40e4a738709a45260cbb2..773433f240eced67530109035ef78a99945472d2 100644
GIT binary patch
delta 21
ccmWFt;0g|K4hmpkU|_mAkxQPDW1^NC05!G*vH$=8

delta 21
ccmWFt;0g|K4hmpkU|>2pkxQOYVWO5A05v`YvH$=8

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 53702282e5..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-tests/data/acpi/loongarch64/virt/SPCR
-- 
2.54.0


