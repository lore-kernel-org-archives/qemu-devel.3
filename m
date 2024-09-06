Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03311CE7AB9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 06:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSsr-0000Bs-EM; Fri, 06 Sep 2024 02:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSsQ-00070k-RT; Fri, 06 Sep 2024 02:55:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSsN-0003HW-BN; Fri, 06 Sep 2024 02:55:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7EA898C243;
 Fri,  6 Sep 2024 09:53:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4422A1333FB;
 Fri,  6 Sep 2024 09:54:30 +0300 (MSK)
Received: (nullmailer pid 43405 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 14/53] hw/intc/loongson_ipi: Access memory in little
 endian
Date: Fri,  6 Sep 2024 09:53:44 +0300
Message-Id: <20240906065429.42415-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Loongson IPI is only available in little-endian,
so use that to access the guest memory (in case
we run on a big-endian host).

Cc: qemu-stable@nongnu.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Fixes: f6783e3438 ("hw/loongarch: Add LoongArch ipi interrupt support")
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-3-philmd@linaro.org>
(cherry picked from commit 2465c89fb983eed670007742bd68c7d91b6d6f85)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixups for 8.2, for lack of:
 v9.0.0-583-g91d0b151de4c "hw/intc/loongson_ipi: Implement IOCSR address space for MIPS"
 v9.0.0-582-gb4a12dfc2132 "hw/intc/loongarch_ipi: Rename as loongson_ipi"
 v8.2.0-545-gfdd6ee0b7653 "hw/intc/loongarch_ipi: Use MemTxAttrs interface for ipi ops")

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 67858b521c..55da9ca7f9 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
+#include "exec/memory.h"
 #include "hw/loongarch/virt.h"
 #include "migration/vmstate.h"
 #include "target/loongarch/internals.h"
@@ -61,8 +62,8 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
      * if the mask is 0, we need not to do anything.
      */
     if ((val >> 27) & 0xf) {
-        data = address_space_ldl(&env->address_space_iocsr, addr,
-                                 MEMTXATTRS_UNSPECIFIED, NULL);
+        data = address_space_ldl_le(&env->address_space_iocsr, addr,
+                                    MEMTXATTRS_UNSPECIFIED, NULL);
         for (i = 0; i < 4; i++) {
             /* get mask for byte writing */
             if (val & (0x1 << (27 + i))) {
@@ -73,8 +74,8 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
 
     data &= mask;
     data |= (val >> 32) & ~mask;
-    address_space_stl(&env->address_space_iocsr, addr,
-                      data, MEMTXATTRS_UNSPECIFIED, NULL);
+    address_space_stl_le(&env->address_space_iocsr, addr,
+                         data, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static int archid_cmp(const void *a, const void *b)
-- 
2.39.2


