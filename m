Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7332C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tEZ-0000FA-Pn; Thu, 24 Apr 2025 05:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7tEW-0000DF-8w
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7tET-0002wL-Jv
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:03 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxaWp8CQpoVjzFAA--.1182S3;
 Thu, 24 Apr 2025 17:50:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCx_cZ8CQpoIFeTAA--.43713S2;
 Thu, 24 Apr 2025 17:50:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org,
 --cc=richard.henderson@linaro.org, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/13] target/loongarch: Move definition of TCG specified
 function to tcg directory
Date: Thu, 24 Apr 2025 17:28:46 +0800
Message-Id: <20250424092849.3985437-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250424023317.3980755-1-gaosong@loongson.cn>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZ8CQpoIFeTAA--.43713S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

Function loongarch_cpu_tlb_fill() only works in TCG mode, move its
definition from header file internals.h to file tcg/tcg_loongarch.h

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250423080417.3739809-10-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c               | 1 +
 target/loongarch/internals.h         | 5 -----
 target/loongarch/tcg/tcg_loongarch.h | 4 ++++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea1665e270..bf3d592574 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -32,6 +32,7 @@
 #include "exec/cpu_ldst.h"
 #include "tcg/tcg.h"
 #endif
+#include "tcg/tcg_loongarch.h"
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 3a079feb1d..a7384b0d31 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -61,11 +61,6 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
-#ifdef CONFIG_TCG
-bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                            MMUAccessType access_type, int mmu_idx,
-                            bool probe, uintptr_t retaddr);
-#endif
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index b29427d981..fd4e116022 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -10,6 +10,10 @@
 
 void loongarch_csr_translate_init(void);
 
+bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                            MMUAccessType access_type, int mmu_idx,
+                            bool probe, uintptr_t retaddr);
+
 int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx);
-- 
2.34.1


