Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79855C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5UD-0002yo-Ty; Thu, 11 Jul 2024 21:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sS5UB-0002nM-8M
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sS5U4-0007Eo-G5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:11 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxVuq6jJBmk4QDAA--.1083S3;
 Fri, 12 Jul 2024 09:54:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnsezjJBmVSdFAA--.27574S5; 
 Fri, 12 Jul 2024 09:54:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 3/8] hw/loongarch/virt: Remove unused assignment
Date: Fri, 12 Jul 2024 09:36:27 +0800
Message-Id: <20240712013632.3464731-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240712013632.3464731-1-gaosong@loongson.cn>
References: <20240712013632.3464731-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnsezjJBmVSdFAA--.27574S5
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

There is abuse usage about local variable gap. Remove
duplicated assignment and solve Coverity reported error.

Resolves: Coverity CID 1546441
Fixes: 3cc451cbce ("hw/loongarch: Refine fwcfg memory map")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240612033637.167787-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 8be2d2ff6a..e592b1b6b7 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1054,7 +1054,6 @@ static void fw_cfg_add_memory(MachineState *ms)
         memmap_add_entry(base, gap, 1);
         size -= gap;
         base = VIRT_HIGHMEM_BASE;
-        gap = ram_size - VIRT_LOWMEM_SIZE;
     }
 
     if (size) {
@@ -1067,17 +1066,17 @@ static void fw_cfg_add_memory(MachineState *ms)
     }
 
     /* add fw_cfg memory map of other nodes */
-    size = ram_size - numa_info[0].node_mem;
-    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;
-    if (base < gap && (base + size) > gap) {
+    if (numa_info[0].node_mem < gap && ram_size > gap) {
         /*
          * memory map for the maining nodes splited into two part
-         *   lowram:  [base, +(gap - base))
-         *   highram: [VIRT_HIGHMEM_BASE, +(size - (gap - base)))
+         * lowram:  [base, +(gap - numa_info[0].node_mem))
+         * highram: [VIRT_HIGHMEM_BASE, +(ram_size - gap))
          */
-        memmap_add_entry(base, gap - base, 1);
-        size -= gap - base;
+        memmap_add_entry(base, gap - numa_info[0].node_mem, 1);
+        size = ram_size - gap;
         base = VIRT_HIGHMEM_BASE;
+    } else {
+        size = ram_size - numa_info[0].node_mem;
     }
 
    if (size)
-- 
2.34.1


