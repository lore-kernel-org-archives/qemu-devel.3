Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCBACAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 07:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0b49-0005yK-AR; Mon, 22 Sep 2025 03:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v0b47-0005xI-A4
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:34:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v0b3w-0007NU-3L
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:34:27 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxaNHu+9BoDhwNAA--.28344S3;
 Mon, 22 Sep 2025 15:34:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocLo+9Bo5wulAA--.64540S4;
 Mon, 22 Sep 2025 15:34:05 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/loongarch: Set function loongarch_cpu_has_work()
 as public
Date: Mon, 22 Sep 2025 15:33:57 +0800
Message-Id: <20250922073400.1308169-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250922073400.1308169-1-maobibo@loongson.cn>
References: <20250922073400.1308169-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocLo+9Bo5wulAA--.64540S4
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Function loongarch_cpu_has_work() is defined as static, it is used
by files target/loongarch/cpu.c and target/loongarch/tcg/tcg_cpu.c,
set it as public and declare it in header file target/loongarch/cpu.h

The same with function cpu_loongarch_hw_interrupts_pending().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 4 ++--
 target/loongarch/cpu.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 20ef221fb2..6eb8c3214a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -141,7 +141,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 }
 
 /* Check if there is pending and not masked out interrupt */
-static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
@@ -154,7 +154,7 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-static bool loongarch_cpu_has_work(CPUState *cs)
+bool loongarch_cpu_has_work(CPUState *cs)
 {
     bool has_work = false;
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c8b96f74dc..5475b6e44f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -478,6 +478,9 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
     }
 }
 
+bool loongarch_cpu_has_work(CPUState *cs);
+bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+
 /*
  * LoongArch CPUs hardware flags.
  */
-- 
2.39.3


