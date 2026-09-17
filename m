Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E9AC982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7299-0006N5-Pi; Wed, 16 Sep 2026 22:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x7294-0006Le-C8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x728y-00058h-ND
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:42 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxLNKIVKtqCOEMAA--.37639S3;
 Thu, 17 Sep 2026 10:46:32 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCx+c18VKtqA60hAA--.39456S4;
 Thu, 17 Sep 2026 10:46:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 02/11] target/loongarch: Remove CSR registers relative MERR
Date: Thu, 17 Sep 2026 10:47:33 +0800
Message-ID: <20260917024742.200257-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917024742.200257-1-maobibo@loongson.cn>
References: <20260917024742.200257-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c18VKtqA60hAA--.39456S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryftryUAFy8tr48AFy5GFX_yoW8KrWkpr
 ZrZrWDKF48XryDCw15Jas0v34DXF47G3y2qa1fC340vrZ8A3yjgr4rtFyvgFyrJay5Jry0
 9F1kZr92vF4xJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UUUUU==
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
Reviewed-by:   Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/cpu.c   | 6 ------
 target/loongarch/csr.c   | 6 ------
 target/loongarch/disas.c | 6 ------
 3 files changed, 18 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index cd39572b5c..614d6a9542 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -153,12 +153,6 @@ static void loongarch_la464_init_csr(DeviceState *dev)
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
-- 
2.54.0


