Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313C606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGU6-0000xb-W7; Sat, 14 Nov 2026 11:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTT-0000NN-Kx; Sat, 14 Nov 2026 11:19:33 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGTS-0005gY-6i; Sat, 14 Nov 2026 11:19:31 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwD3_8MMivhqhGAqBg--.63128S2; 
 Sun, 15 Nov 2026 00:19:24 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwjHUKivhq9Nv6AA--.29618S3;
 Sun, 15 Nov 2026 00:19:23 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 21/35] hw/arm/smmuv3: Make GERROR_IRQ_CFG registers RES0
 without MSI
Date: Sun, 15 Nov 2026 00:19:22 +0800
Message-Id: <20261114161922.3647707-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwjHUKivhq9Nv6AA--.29618S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBhgAAsj
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAry5Jw1kuFy8CFykGw4UArb_yoW5GFWxpr
 93Awn0gw10ya1Igr9rAwn8Jw18ur93JFy3Kry5G3sxZw409rW5tF1jqFWSg34DWFykGw4D
 KF43urn7XrnYyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SMMUv3 model does not advertise MSI support, but writes to
GERROR_IRQ_CFG0/1/2 were stored and could be read back. These registers
must be RES0 when SMMU_IDR0.MSI is zero.

Make the Non-secure and Secure GERROR_IRQ_CFG0/1/2 registers read as
zero and ignore writes. This includes both 64-bit accesses to
GERROR_IRQ_CFG0 and accesses to its individual 32-bit halves.

Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 716520d5eb8..144993243eb 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1744,7 +1744,6 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
-        bank->gerror_irq_cfg0 = data;
         return MEMTX_OK;
     case A_STRTAB_BASE:
         bank->strtab_base = data;
@@ -1811,18 +1810,11 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
          */
         smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         break;
-    case A_GERROR_IRQ_CFG0: /* 64b */
-        bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
-        break;
+    case A_GERROR_IRQ_CFG0:
     case A_GERROR_IRQ_CFG0 + 4:
-        bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 32, 32, data);
-        break;
     case A_GERROR_IRQ_CFG1:
-        bank->gerror_irq_cfg1 = data;
-        break;
     case A_GERROR_IRQ_CFG2:
-        bank->gerror_irq_cfg2 = data;
-        break;
+        return MEMTX_OK;
     case A_GBPA:
         /*
          * If UPDATE is not set, the write is ignored. This is the only
@@ -1947,7 +1939,7 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 
     switch (offset) {
     case A_GERROR_IRQ_CFG0:
-        *data = bank->gerror_irq_cfg0;
+        *data = 0;
         return MEMTX_OK;
     case A_STRTAB_BASE:
         *data = bank->strtab_base;
@@ -2014,17 +2006,11 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     case A_GERRORN:
         *data = bank->gerrorn;
         return MEMTX_OK;
-    case A_GERROR_IRQ_CFG0: /* 64b */
-        *data = extract64(bank->gerror_irq_cfg0, 0, 32);
-        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG0:
     case A_GERROR_IRQ_CFG0 + 4:
-        *data = extract64(bank->gerror_irq_cfg0, 32, 32);
-        return MEMTX_OK;
     case A_GERROR_IRQ_CFG1:
-        *data = bank->gerror_irq_cfg1;
-        return MEMTX_OK;
     case A_GERROR_IRQ_CFG2:
-        *data = bank->gerror_irq_cfg2;
+        *data = 0;
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
         *data = extract64(bank->strtab_base, 0, 32);
-- 
2.34.1


