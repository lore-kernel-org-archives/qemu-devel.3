Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F043CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMPI-0000F6-Li; Mon, 27 Oct 2025 08:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDMOm-0008Jp-U3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:32:36 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDMOg-0005Qk-6Z
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=th+wdmi7NGFG7aD8VQN9evtAT3+C+6eCcEbIMbhmlvE=; b=lDN+oCLM5/2IOkY
 MuLigZjR82m/tatVK8lJfDPWkBHOxKy2Hs7HWZO9WZpRHzyC+J6ab254aTcSOaI3d7ztA29tjntaj
 Omuee11gWa7tmjtGevTvlH1ufh3LYOIcLJAdW/BibrjC1GNYoOQAiMFxKNaefOmC5PHCaIBfeJ55l
 3U=;
Date: Mon, 27 Oct 2025 13:35:11 +0100
Subject: [PATCH v2 2/3] hw/riscv: Replace target_ulong uses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
In-Reply-To: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/riscv-iommu.c | 6 ++++--
 hw/riscv/riscv_hart.c  | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b33c7fe325..f8656ec04b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -26,6 +26,8 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "qemu/target-info.h"
+#include "qemu/bitops.h"
 
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
@@ -391,9 +393,9 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             const uint64_t va_mask = (1ULL << va_len) - 1;
 
             if (pass == S_STAGE && va_len > 32) {
-                target_ulong mask, masked_msbs;
+                uint64_t mask, masked_msbs;
 
-                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
+                mask = MAKE_64BIT_MASK(0, target_long_bits() - va_len + 1);
                 masked_msbs = (addr >> (va_len - 1)) & mask;
 
                 if (masked_msbs != 0 && masked_msbs != mask) {
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index c7e98a4308..65d2c92018 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -93,7 +93,7 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
         g_assert(rc == 0);
         csr_call(words[1], cpu, csr, &val);
 
-        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
+        qtest_sendf(chr, "OK 0 %"PRIx64"\n", val);
 
         return true;
     }

-- 
2.51.0


