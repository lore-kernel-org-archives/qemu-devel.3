Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6A0CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfR-0001eG-Jz; Sun, 12 Oct 2025 11:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfP-0001ch-J0; Sun, 12 Oct 2025 11:07:23 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfK-0001cv-Uc; Sun, 12 Oct 2025 11:07:23 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHj5saxOtohE6gAA--.38S2;
 Sun, 12 Oct 2025 23:07:06 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S5;
 Sun, 12 Oct 2025 23:07:05 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 02/21] hw/arm/smmuv3: Correct SMMUEN field name in CR0
Date: Sun, 12 Oct 2025 23:06:42 +0800
Message-Id: <20251012150701.4127034-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBVwAAsm
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Jr47Xr1xXw4furyxury7GFg_yoW8Jry8pF
 4kGF1rGrWUAa4S9ryxGay7AF15Wayktr1UKr97G3sxJ3WavFZxAryvkF1DWFykuryUXF4r
 u3Z2ya409a1IyrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The FIELD macro for the SMMU enable bit in the CR0 register was
incorrectly named SMMU_ENABLE.

The ARM SMMUv3 Architecture Specification (both older IHI 0070.E.a and
newer IHI 0070.G.b) consistently refers to the SMMU enable bit as SMMUEN.

This change makes our implementation consistent with the manual.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01270.html
---
 hw/arm/smmuv3-internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 42ac77e654..8d631ecf27 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -116,7 +116,7 @@ REG32(IDR5,                0x14)
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
 REG32(CR0,                 0x20)
-    FIELD(CR0, SMMU_ENABLE,   0, 1)
+    FIELD(CR0, SMMUEN,   0, 1)
     FIELD(CR0, EVENTQEN,      2, 1)
     FIELD(CR0, CMDQEN,        3, 1)
 
@@ -181,7 +181,7 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
 
 static inline int smmu_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
+    return FIELD_EX32(s->cr[0], CR0, SMMUEN);
 }
 
 /* Command Queue Entry */
-- 
2.34.1


