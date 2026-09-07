Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7226C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3PGH-0000ed-LM; Sun, 06 Sep 2026 22:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3PGF-0000dZ-Gs
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:39:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3PGD-0007vO-5G
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:39:07 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxYdHCI55qAUsJAA--.27087S3;
 Mon, 07 Sep 2026 10:38:58 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBxpMy8I55qtj0cAA--.33287S4;
 Mon, 07 Sep 2026 10:38:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/loongarch: Rename filename constant_timer.c with
 timer.c
Date: Mon,  7 Sep 2026 10:40:11 +0800
Message-ID: <20260907024012.2992255-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907024012.2992255-1-maobibo@loongson.cn>
References: <20260907024012.2992255-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMy8I55qtj0cAA--.33287S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruw4rGw47JF1UAFW3Gr4fCrX_yoWDXrX_WF
 4xJF1kCrsrW3WIq3yYv3y5Jws8Jr18KFnakFWUWF4xGas8Ka1YkrWDK3WkCFyYyr45ZFs8
 A39aqryruF1YyosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
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

For simplity rename filename constant_timer.c with timer.c on LoongArch.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/meson.build                   | 2 +-
 target/loongarch/tcg/{constant_timer.c => timer.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename target/loongarch/tcg/{constant_timer.c => timer.c} (100%)

diff --git a/target/loongarch/tcg/meson.build b/target/loongarch/tcg/meson.build
index b7adfe46f1..0b013875cc 100644
--- a/target/loongarch/tcg/meson.build
+++ b/target/loongarch/tcg/meson.build
@@ -13,7 +13,7 @@ loongarch_ss.add(files(
 ))
 
 loongarch_system_ss.add(files(
-  'constant_timer.c',
+  'timer.c',
   'csr_helper.c',
   'iocsr_helper.c',
   'tlb_helper.c',
diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/timer.c
similarity index 100%
rename from target/loongarch/tcg/constant_timer.c
rename to target/loongarch/tcg/timer.c
-- 
2.54.0


