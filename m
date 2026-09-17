Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B52C982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x729Y-0006PK-Et; Wed, 16 Sep 2026 22:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x7299-0006Mj-57
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x7297-0005AA-0F
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:46 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxQNGTVKtqGOEMAA--.37954S3;
 Thu, 17 Sep 2026 10:46:43 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxe86QVKtqDK0hAA--.39741S4;
 Thu, 17 Sep 2026 10:46:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>
Subject: [PULL 10/11] target/loongarch: Enable HW PTW feature by default
Date: Thu, 17 Sep 2026 10:47:41 +0800
Message-ID: <20260917024742.200257-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917024742.200257-1-maobibo@loongson.cn>
References: <20260917024742.200257-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxe86QVKtqDK0hAA--.39741S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWrXF4kJr47ZFyxZF4kKrX_yoW8CF1Dpr
 ZxZw12grW3trZrAw1kJa90qrs8Xr47Gr42va4ftrW7Aan8XF17uFyktan3tF9rA3s5AFyI
 qFW0yrs8WF4DJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=
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

With max CPU type, PTW feature is enabled in TCG mode and auto detected
in KVM mode. Enable this feature in both TCG and KVM mode in the
beginning, and detect it in late with KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:   Song Gao <17746591750@163.com>
---
 target/loongarch/cpu.c     | 7 +------
 target/loongarch/kvm/kvm.c | 1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 99499034ed..4a75d53f7e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -472,6 +472,7 @@ static void loongarch_max_initfn(Object *obj)
     /* '-cpu max': use it for max supported CPU features */
     loongarch_la464_initfn(obj);
 
+    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, 1);
     cpu->ptw = ON_OFF_AUTO_AUTO;
     cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
     cpu->msgint = ON_OFF_AUTO_AUTO;
@@ -488,12 +489,6 @@ static void loongarch_max_initfn(Object *obj)
     data = cpu->env.cpucfg[3];
     data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
     cpu->env.cpucfg[3] = data;
-
-    if (tcg_enabled()) {
-        data = cpu->env.cpucfg[2];
-        data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
-        cpu->env.cpucfg[2] = data;
-    }
 }
 
 #if defined(CONFIG_KVM)
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 0626c553d5..941142305e 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1150,6 +1150,7 @@ static int kvm_cpu_check_ptw(CPUState *cs, Error **errp)
     CPULoongArchState *env = cpu_env(cs);
     bool kvm_supported;
 
+    env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, HPTW, 0);
     kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PTW);
     if (cpu->ptw == ON_OFF_AUTO_ON) {
         if (!kvm_supported) {
-- 
2.54.0


