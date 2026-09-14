Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E78C88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5wCA-0001G6-2E; Sun, 13 Sep 2026 22:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x5wC2-0001D0-7U
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x5wBx-0007FV-Gc
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 22:13:13 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxHNIzWKdqkqULAA--.33726S3;
 Mon, 14 Sep 2026 10:13:07 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBx5cwyWKdqDmggAA--.43217S4;
 Mon, 14 Sep 2026 10:13:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/loongarch: Add la664 CPU type
Date: Mon, 14 Sep 2026 10:14:20 +0800
Message-ID: <20260914021420.4065683-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914021420.4065683-1-maobibo@loongson.cn>
References: <20260914021420.4065683-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx5cwyWKdqDmggAA--.43217S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrW8Kr1xJF4UuF4rWw1DCFX_yoW8Ww4DpF
 9xZw42gFWxJFZrAa4DAa98Wrs8Jrs3W3y2vFy3tw4kArs3Xry7X3W8J398ZF1Dt3y8WF1I
 vr40y3WY9F4UJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l3
 8UUUUUU==
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

Most features about LA664 CPU hardware is finished in TCG and KVM mode,
add la664 CPU type and it is similar with max CPU type.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f4d3d75e16..759fee0b26 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -457,12 +457,11 @@ static void loongarch_la132_initfn(Object *obj)
     cpu->ptw = ON_OFF_AUTO_OFF;
 }
 
-static void loongarch_max_initfn(Object *obj)
+static void loongarch_la664_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     uint32_t data;
 
-    /* '-cpu max': use it for max supported CPU features */
     loongarch_la464_initfn(obj);
 
     cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, 1);
@@ -484,6 +483,12 @@ static void loongarch_max_initfn(Object *obj)
     cpu->env.cpucfg[3] = data;
 }
 
+static void loongarch_max_initfn(Object *obj)
+{
+    /* '-cpu max': use it for max supported CPU features */
+    loongarch_la664_initfn(obj);
+}
+
 #if defined(CONFIG_KVM)
 static int read_cpuinfo(const char *field, char *value, int len)
 {
@@ -940,6 +945,8 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .abstract = true,
         .class_init = loongarch64_cpu_class_init,
     },
+
+    DEFINE_LOONGARCH_CPU_TYPE(64, "la664", loongarch_la664_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
-- 
2.54.0


