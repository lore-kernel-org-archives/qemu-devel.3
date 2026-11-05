Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE537606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrKy-0006zJ-0y; Thu, 05 Nov 2026 01:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrKw-0006yI-92
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:38 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xOrKs-0000nV-Hd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:38 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bxb9OwJ+xqZ48cAA--.17016S3;
 Thu, 05 Nov 2026 14:52:32 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxnM6wJ+xq+4EyAA--.17799S3;
 Thu, 05 Nov 2026 14:52:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 09/13] target/loongarch: Check CPU msgint feature with
 cpu_has_msgint()
Date: Thu,  5 Nov 2026 14:53:41 +0800
Message-ID: <20261105065345.966691-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
References: <20261105065345.966691-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxnM6wJ+xq+4EyAA--.17799S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW3tFykKF45Jr4rGF48uFX_yoW8tFW7pr
 y7ZFZF9FyUKFZIvanaqa4Yqr1DGr17GF42qayqyry8CF43Jr1fXw1xA3yqgFn0k3y8Xryx
 XF1ruFn5ZF4UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
 CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84xRDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are two ways to check the CPU msgint feature. One is to call
cpu_has_msgint(); the other is to check CPULoongArchState::msgint, which
has type OnOffAuto. A problem arises if msgint is set to ON_OFF_AUTO_AUTO
in KVM mode: QEMU checks the host feature and sets its actual value in
cpucfg1, which is read by cpu_has_msgint(). However, the msgint field
remains ON_OFF_AUTO_AUTO.

Therefore, in KVM mode cpu_has_msgint() is more accurate than checking
the OnOffAuto-typed msgint field.

A problem occurs when booting a VM with the max CPU type on an LA464 host
that does not support msgint. cpu_has_msgint() returns false, but the
msgint field remains ON_OFF_AUTO_AUTO, so the expression
cpu->msgint != ON_OFF_AUTO_OFF evaluates to true.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
---
 hw/loongarch/virt.c    | 4 ++--
 target/loongarch/cpu.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 33bd89be89..c67dad095a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -901,12 +901,12 @@ static void virt_check_dmsi(MachineState *machine)
 
     cpu = LOONGARCH_CPU(first_cpu);
     if (lvms->dmsi == ON_OFF_AUTO_AUTO) {
-        if (cpu->msgint != ON_OFF_AUTO_OFF) {
+        if (cpu_has_msgint(&cpu->env)) {
             lvms->misc_feature = BIT(IOCSRF_DMSI);
         }
     }
 
-    if (lvms->dmsi == ON_OFF_AUTO_ON && cpu->msgint == ON_OFF_AUTO_OFF) {
+    if (lvms->dmsi == ON_OFF_AUTO_ON && !cpu_has_msgint(&cpu->env)) {
         error_report("Fail to enable dmsi , cpu msgint is off "
                      "pleass add cpu feature mesgint=on.");
         exit(EXIT_FAILURE);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index dd70beca18..1f3022265a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -232,7 +232,9 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
 
 static bool loongarch_get_msgint(Object *obj, Error **errp)
 {
-    return LOONGARCH_CPU(obj)->msgint != ON_OFF_AUTO_OFF;
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    return cpu_has_msgint(&cpu->env);
 }
 
 static void loongarch_set_msgint(Object *obj, bool value, Error **errp)
-- 
2.54.0


