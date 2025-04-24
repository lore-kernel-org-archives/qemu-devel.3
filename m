Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C0EC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 02:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7mkm-0000fT-KT; Wed, 23 Apr 2025 22:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7mkP-0000Zd-Ho
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7mkM-00005P-RG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axz3MfqAlopQbFAA--.63812S3;
 Thu, 24 Apr 2025 10:55:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhsVqAlogNaSAA--.53120S9;
 Thu, 24 Apr 2025 10:55:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org, richard.henderson@linaro.org,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/13] target/loongarch: Define function
 loongarch_get_addr_from_tlb() non-static
Date: Thu, 24 Apr 2025 10:33:11 +0800
Message-Id: <20250424023317.3980755-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250424023317.3980755-1-gaosong@loongson.cn>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhsVqAlogNaSAA--.53120S9
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

Define function loongarch_get_addr_from_tlb() non-static, and add its
definition in header file tcg/tcg_loongarch.h

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250423080417.3739809-7-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu_helper.c        | 10 ++--------
 target/loongarch/tcg/tcg_loongarch.h |  5 +++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 9a87cae358..97d9caa06e 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-csr.h"
+#include "tcg/tcg_loongarch.h"
 
 #ifdef CONFIG_TCG
 static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
@@ -142,7 +143,7 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
     return false;
 }
 
-static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
                                        int *prot, target_ulong address,
                                        MMUAccessType access_type, int mmu_idx)
 {
@@ -156,13 +157,6 @@ static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
 
     return TLBRET_NOMATCH;
 }
-#else
-static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                       int *prot, target_ulong address,
-                                       MMUAccessType access_type, int mmu_idx)
-{
-    return TLBRET_NOMATCH;
-}
 #endif
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index da2539e995..b29427d981 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -6,7 +6,12 @@
  */
 #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
 #define TARGET_LOONGARCH_TCG_LOONGARCH_H
+#include "cpu.h"
 
 void loongarch_csr_translate_init(void);
 
+int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+                                int *prot, target_ulong address,
+                                MMUAccessType access_type, int mmu_idx);
+
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
-- 
2.34.1


