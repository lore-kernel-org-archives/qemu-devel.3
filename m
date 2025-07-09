Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A29C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 00:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZIww-0003qa-Ni; Tue, 08 Jul 2025 20:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZIwf-0003j6-VX
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:45:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZIwb-0004Ls-Dx
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:45:57 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Ax3eK7u21oGOgkAQ--.40989S3;
 Wed, 09 Jul 2025 08:45:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+S6u21o0TEPAA--.22142S3;
 Wed, 09 Jul 2025 08:45:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/loongarch: Move some function definition to kvm
 directory
Date: Wed,  9 Jul 2025 08:45:41 +0800
Message-Id: <20250709004546.3005275-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250709004546.3005275-1-maobibo@loongson.cn>
References: <20250709004546.3005275-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+S6u21o0TEPAA--.22142S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move function definition specified with kvm to the corresponding
directory. Also remove header file "cpu.h" including outside of
macro QEMU_KVM_LOONGARCH_H.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c                  | 1 +
 target/loongarch/cpu.h               | 9 ---------
 target/loongarch/kvm/kvm_loongarch.h | 4 ++--
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b15ada2078..31215b7785 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -46,6 +46,7 @@
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
+#include "kvm/kvm_loongarch.h"
 
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 9538e8d61d..bbe6db33f1 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -496,13 +496,4 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 
 void loongarch_cpu_post_init(Object *obj);
 
-#ifdef CONFIG_KVM
-void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu);
-#else
-static inline void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
-{
-}
-#endif
-void kvm_loongarch_init_irq_routing(void);
-
 #endif /* LOONGARCH_CPU_H */
diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
index 1051a341ec..51475675d6 100644
--- a/target/loongarch/kvm/kvm_loongarch.h
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -5,11 +5,11 @@
  * Copyright (c) 2023 Loongson Technology Corporation Limited
  */
 
-#include "cpu.h"
-
 #ifndef QEMU_KVM_LOONGARCH_H
 #define QEMU_KVM_LOONGARCH_H
 
+void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu);
+void kvm_loongarch_init_irq_routing(void);
 int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
 void kvm_arch_reset_vcpu(CPUState *cs);
 
-- 
2.39.3


