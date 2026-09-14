Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D545C88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5wC4-0001Dc-Py; Sun, 13 Sep 2026 22:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x5wC1-0001CJ-At
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x5wBw-0007CA-Oq
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:11 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Cx+9EwWKdqhaULAA--.34000S3;
 Mon, 14 Sep 2026 10:13:04 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxTs8rWKdqC2ggAA--.4739S5;
 Mon, 14 Sep 2026 10:13:04 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/6] target/loongarch: Enable LoongArch Instruction Set
 version 1.1
Date: Mon, 14 Sep 2026 10:14:17 +0800
Message-ID: <20260914021420.4065683-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914021420.4065683-1-maobibo@loongson.cn>
References: <20260914021420.4065683-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs8rWKdqC2ggAA--.4739S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry7Wr4DArW8Cr1DGF4xKrX_yoW8uF18pr
 ZrArsIg39rtFs7AwnrJayYqrn5XF4xGw42yF4xtrW7Zw4DJFn7Xa4kJa18AF9Fy3s5AF1I
 9FW8AFZxGFs8AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
 0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbCzuJUUUUU==
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

Now LoongArch Instruction Set version 1.1 is enabled in TCG mode,
disabled in KVM mode. After LoongArch Instruction Set version 1.1
detection is added in KVM mode, it can be enabled with max cpu type.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 18d73ebc1b..50fcbabc71 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -460,6 +460,8 @@ static void loongarch_la132_initfn(Object *obj)
 static void loongarch_max_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    uint32_t data;
+
     /* '-cpu max': use it for max supported CPU features */
     loongarch_la464_initfn(obj);
 
@@ -467,20 +469,25 @@ static void loongarch_max_initfn(Object *obj)
     if (kvm_enabled()){
         cpu->msgint=ON_OFF_AUTO_OFF;
     }
+
+    /* Enable LA v1.1 instructions */
+    data = cpu->env.cpucfg[2];
+    data = FIELD_DP32(data, CPUCFG2, FRECIPE, 1);
+    data = FIELD_DP32(data, CPUCFG2, LAM_BH, 1);
+    data = FIELD_DP32(data, CPUCFG2, LAMCAS, 1);
+    data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
+    data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
+    cpu->env.cpucfg[2] = data;
+
+    data = cpu->env.cpucfg[3];
+    data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
+    cpu->env.cpucfg[3] = data;
+
     if (tcg_enabled()) {
-        uint32_t data = cpu->env.cpucfg[2];
+        data = cpu->env.cpucfg[2];
         data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
-        /* Enable LA v1.1 instructions */
-        data = FIELD_DP32(data, CPUCFG2, FRECIPE, 1);
-        data = FIELD_DP32(data, CPUCFG2, LAM_BH, 1);
-        data = FIELD_DP32(data, CPUCFG2, LAMCAS, 1);
-        data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
-        data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
         cpu->env.cpucfg[2] = data;
 
-        data = cpu->env.cpucfg[3];
-        data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
-        cpu->env.cpucfg[3] = data;
 	 cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
         cpu->msgint = ON_OFF_AUTO_AUTO;
     }
-- 
2.54.0


