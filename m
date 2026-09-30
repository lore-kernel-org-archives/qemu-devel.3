Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C63CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoJh-0000t8-3L; Wed, 30 Sep 2026 03:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xBoJc-0000pO-9Y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:01:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xBoJZ-0006Zu-Gw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:01:19 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxX9O4s7xqpEIRAA--.50382S3;
 Wed, 30 Sep 2026 15:01:12 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxOs6ws7xqq+MmAA--.53251S4;
 Wed, 30 Sep 2026 15:01:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>,
 xiaoqiang zhao <zxq_yx_007@163.com>
Subject: [PULL 2/4] hw/loongarch/virt: Fix SPCR bitwidth value
Date: Wed, 30 Sep 2026 15:02:25 +0800
Message-ID: <20260930070227.1079521-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930070227.1079521-1-maobibo@loongson.cn>
References: <20260930070227.1079521-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxOs6ws7xqq+MmAA--.53251S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruryfAFyrCFyUXFWxWF45Jwc_yoWDCwb_W3
 Z3GF1UXw18XF9rtw18ua1rAr17Xw18ZFs3uFnrZr1kJas0qr43KFZF9anFvF9FyrWUu393
 XanFqr1fCr9xGosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=
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

Serial base_addr.width should be 8 instead of 32.
The wrong reported data will cause ADE in FreeBSD console initialize
process and trigger a reset loop.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 600ef60fc5..54965f011d 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -268,7 +268,7 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     AcpiSpcrData serial = {
         .interface_type = 0,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
-        .base_addr.width = 32,
+        .base_addr.width = 8,
         .base_addr.offset = 0,
         .base_addr.size = 1,
         .base_addr.addr = VIRT_UART_BASE,
-- 
2.54.0


