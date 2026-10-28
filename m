Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC6606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuGL-0001aC-IJ; Tue, 27 Oct 2026 23:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xLuGI-0001ZI-VD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:23:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xLuGF-00047J-MU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:23:38 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxbdKwauFqxgEaAA--.11620S3;
 Wed, 28 Oct 2026 11:23:28 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxBc2vauFqFtQwAA--.8447S2;
 Wed, 28 Oct 2026 11:23:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] target/loongarch: Replace sys_state with vm_level
Date: Wed, 28 Oct 2026 11:24:56 +0800
Message-ID: <20261028032456.12884-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxBc2vauFqFtQwAA--.8447S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFW8Xw18GryUXw1fWry5ZFc_yoW8WrW7pr
 ZrZw4agr48GFZ2yanrJ3s8WFn8WrsrC3429a9Ikr9YyFs8Jry5WFnYy3yDCF4UJaykWFyf
 Xa10yr1UJa12gacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
 0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUUU
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Int type vm_level is more meaningful than pointer type sys_state,
and it is easy to get current mode from value of vm_level.

Here replace sys_state with vm_level, and use vm_level directly.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/loongarch/cpu.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5cc2370da2..277fc4f475 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -429,7 +429,7 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPUSysState sys_states[1];
+    CPUSysState sys_states[VM_LEVELS];
     uint32_t cpucfg[21];
     uint32_t pv_features;
     uint64_t vendor_id;
@@ -440,7 +440,7 @@ typedef struct CPUArchState {
     AddressSpace *address_space_iocsr;
     uint32_t mp_state;
 #endif
-    CPUSysState *sys_state;
+    int vm_level;
     unsigned int irq_nr;
 } CPULoongArchState;
 
@@ -510,12 +510,14 @@ struct LoongArchCPUClass {
 
 static inline CPUSysState *env_sys(CPULoongArchState *env)
 {
-    return env->sys_state;
+    return &env->sys_states[env->vm_level];
 }
 
 static inline void set_sys(CPULoongArchState *env, int vm_level)
 {
-    env->sys_state = &env->sys_states[vm_level];
+    if (vm_level >= 0 && vm_level <  VM_LEVELS) {
+        env->vm_level = vm_level;
+    }
 }
 
 static inline CPUTimerState *env_timer(CPULoongArchState *env)

base-commit: d29412cca54899ba87d5ea5d61e8bad7643b15f0
-- 
2.54.0


