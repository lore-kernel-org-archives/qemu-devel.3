Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958AAC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7V63-0002CU-AV; Wed, 23 Apr 2025 04:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u7V5w-00028i-Jn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:04:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u7V5t-000646-AJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:04:36 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeEOnwhoXoTEAA--.19942S3;
 Wed, 23 Apr 2025 16:04:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn8UCnwhofGaRAA--.35702S10;
 Wed, 23 Apr 2025 16:04:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v4 8/9] target/loongarch: Add static definition with function
 loongarch_tlb_search()
Date: Wed, 23 Apr 2025 16:04:16 +0800
Message-Id: <20250423080417.3739809-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250423080417.3739809-1-maobibo@loongson.cn>
References: <20250423080417.3739809-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8UCnwhofGaRAA--.35702S10
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

Function loongarch_tlb_search() is only referenced in file tcg/tlb_helper.c,
define this function with static attribution.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/internals.h      | 2 --
 target/loongarch/tcg/tlb_helper.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 9fdc3059d8..3a079feb1d 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -54,8 +54,6 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
-                          int *index);
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
                          MMUAccessType access_type, int mmu_idx, int is_debug);
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8509aa99cf..2fdd10022b 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -209,8 +209,8 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  * field in tlb entry contains bit[47:13], so need adjust.
  * virt_vpn = vaddr[47:13]
  */
-bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
-                          int *index)
+static bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
+                                 int *index)
 {
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, stlb_idx;
-- 
2.39.3


