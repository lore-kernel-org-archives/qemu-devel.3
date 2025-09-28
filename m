Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF051CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 09:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2o0s-0001dp-Kj; Sun, 28 Sep 2025 05:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v2o0q-0001dH-Hn
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v2o0i-0006Qc-24
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxvdJKBNlofc4PAA--.32827S3;
 Sun, 28 Sep 2025 17:47:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDx_8NCBNloMpa5AA--.63673S3;
 Sun, 28 Sep 2025 17:47:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 01/11] target/loongarch: move some machine define to virt.h
Date: Sun, 28 Sep 2025 17:23:58 +0800
Message-Id: <20250928092408.948035-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250928092408.948035-1-gaosong@loongson.cn>
References: <20250928092408.948035-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8NCBNloMpa5AA--.63673S3
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

move some machine define to virt.h

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250916122109.749813-2-gaosong@loongson.cn>
---
 include/hw/loongarch/virt.h | 19 +++++++++++++++++++
 target/loongarch/cpu.h      | 21 ---------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 602feab0f0..7120b46714 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -13,6 +13,25 @@
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
+#define IOCSRF_TEMP             0
+#define IOCSRF_NODECNT          1
+#define IOCSRF_MSI              2
+#define IOCSRF_EXTIOI           3
+#define IOCSRF_CSRIPI           4
+#define IOCSRF_FREQCSR          5
+#define IOCSRF_FREQSCALE        6
+#define IOCSRF_DVFSV1           7
+#define IOCSRF_GMOD             9
+#define IOCSRF_VM               11
+
+#define VERSION_REG             0x0
+#define FEATURE_REG             0x8
+#define VENDOR_REG              0x10
+#define CPUNAME_REG             0x20
+#define MISC_FUNC_REG           0x420
+#define IOCSRM_EXTIOI_EN        48
+#define IOCSRM_EXTIOI_INT_ENCODE 49
+
 #define LOONGARCH_MAX_CPUS      256
 
 #define VIRT_FWCFG_BASE         0x1e020000UL
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c8b96f74dc..8c35bf120a 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -21,27 +21,6 @@
 #include "cpu-csr.h"
 #include "cpu-qom.h"
 
-#define IOCSRF_TEMP             0
-#define IOCSRF_NODECNT          1
-#define IOCSRF_MSI              2
-#define IOCSRF_EXTIOI           3
-#define IOCSRF_CSRIPI           4
-#define IOCSRF_FREQCSR          5
-#define IOCSRF_FREQSCALE        6
-#define IOCSRF_DVFSV1           7
-#define IOCSRF_GMOD             9
-#define IOCSRF_VM               11
-
-#define VERSION_REG             0x0
-#define FEATURE_REG             0x8
-#define VENDOR_REG              0x10
-#define CPUNAME_REG             0x20
-#define MISC_FUNC_REG           0x420
-#define IOCSRM_EXTIOI_EN        48
-#define IOCSRM_EXTIOI_INT_ENCODE 49
-
-#define IOCSR_MEM_SIZE          0x428
-
 #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
 #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
 #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
-- 
2.47.0


