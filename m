Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A18C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3PJl-0002Oe-SB; Sun, 06 Sep 2026 22:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3PJj-0002OG-O9
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:42:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3PJh-0008KJ-Cq
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:42:43 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bx79KUJJ5qYksJAA--.26969S3;
 Mon, 07 Sep 2026 10:42:28 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxPs+TJJ5qET4cAA--.60089S2;
 Mon, 07 Sep 2026 10:42:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Remove CSR registers relative MERR
Date: Mon,  7 Sep 2026 10:43:46 +0800
Message-ID: <20260907024346.2992355-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs+TJJ5qET4cAA--.60089S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFyrtFWDGr4rWr1furWrCrX_yoW8KF1xpr
 ZrZrWDKF48WryDCw1rJas0934DXF4xK3y2qa1fC340vrZ8A3yjgr48tFyvgFyrJay5JrW0
 9F1kZrZ2vF4xJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=
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

Registers relative with MERR are used for HW error handling, such as CPU
cache etc now both KVM and TCG do not support MERR. Remove these CSR
registers, vmstate keeps unchanged for compatibility.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c   | 6 ------
 target/loongarch/csr.c   | 6 ------
 target/loongarch/disas.c | 6 ------
 3 files changed, 18 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 84a130956d..9d51a0297c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -140,12 +140,6 @@ static void loongarch_la464_init_csr(DeviceState *dev)
         }
         set_csr_flag(LOONGARCH_CSR_IMPCTL1, CSRFL_UNUSED);
         set_csr_flag(LOONGARCH_CSR_IMPCTL2, CSRFL_UNUSED);
-        set_csr_flag(LOONGARCH_CSR_MERRCTL, CSRFL_UNUSED);
-        set_csr_flag(LOONGARCH_CSR_MERRINFO1, CSRFL_UNUSED);
-        set_csr_flag(LOONGARCH_CSR_MERRINFO2, CSRFL_UNUSED);
-        set_csr_flag(LOONGARCH_CSR_MERRENTRY, CSRFL_UNUSED);
-        set_csr_flag(LOONGARCH_CSR_MERRERA, CSRFL_UNUSED);
-        set_csr_flag(LOONGARCH_CSR_MERRSAVE, CSRFL_UNUSED);
         set_csr_flag(LOONGARCH_CSR_CTAG, CSRFL_UNUSED);
 
         for (i = env->perf_event_num; i < MAX_PERF_EVENTS; i++) {
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 309b826ca9..d2ac39dee9 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -82,12 +82,6 @@ static CSRInfo csr_info[] = {
     CSR_OFF(TLBRELO1),
     CSR_OFF(TLBREHI),
     CSR_OFF(TLBRPRMD),
-    CSR_OFF(MERRCTL),
-    CSR_OFF(MERRINFO1),
-    CSR_OFF(MERRINFO2),
-    CSR_OFF(MERRENTRY),
-    CSR_OFF(MERRERA),
-    CSR_OFF(MERRSAVE),
     CSR_OFF(CTAG),
     CSR_OFF_ARRAY(DMW, 0),
     CSR_OFF_ARRAY(DMW, 1),
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3249ab7ac6..928b8b94c2 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -98,12 +98,6 @@ static const char * const csr_names[] = {
     CSR_NAME(TLBRELO1),
     CSR_NAME(TLBREHI),
     CSR_NAME(TLBRPRMD),
-    CSR_NAME(MERRCTL),
-    CSR_NAME(MERRINFO1),
-    CSR_NAME(MERRINFO2),
-    CSR_NAME(MERRENTRY),
-    CSR_NAME(MERRERA),
-    CSR_NAME(MERRSAVE),
     CSR_NAME(CTAG),
     CSR_NAME(DMW(0)),
     CSR_NAME(DMW(1)),

base-commit: eb710c255642cd7dc947f25c9a06c9fc8191e98d
-- 
2.54.0


