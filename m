Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF3CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 03:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1z4W-0002jo-Cc; Thu, 25 Sep 2025 23:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1z4T-0002jP-Cw; Thu, 25 Sep 2025 23:24:33 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1z4C-0005Tl-T9; Thu, 25 Sep 2025 23:24:33 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnvWBNB9Zo9lt8Bw--.5833S2;
 Fri, 26 Sep 2025 11:23:57 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHa+hBB9Zoe_wgAA--.9731S3;
 Fri, 26 Sep 2025 11:23:45 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 13/14] hw/arm/smmuv3: Add property to enable Secure SMMU
 support
Date: Fri, 26 Sep 2025 11:23:39 +0800
Message-Id: <20250926032339.1089647-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHa+hBB9Zoe_wgAA--.9731S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWjVmkcBvQAAsd
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KrWktFyDKr15WFyDGFyDKFg_yoW5JFy5pF
 s3Ar1rKr45u3WfJay7Za18Zay2v3yvq3ZxurW8C3Wru3WDAryDXr4vkr48Ga98Xw1Yya1x
 WF48uF48CF42vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

My apologies, resending patches 13-14/14 to fix a threading mistake from
my previous attempt.

This commit completes the initial implementation of the Secure SMMUv3
model by making the feature user-configurable.

A new boolean property, "secure-impl", is introduced to the device.
This property defaults to false, ensuring backward compatibility for
existing machine types that do not expect the secure programming
interface.

When "secure-impl" is set to true, the smmuv3_init_regs function now
initializes the secure register bank (bank[SMMU_SEC_IDX_S]). Crucially,
the S_IDR1.SECURE_IMPL bit is set according to this property,
correctly advertising the presence of the secure functionality to the
guest.

This patch ties together all the previous refactoring work. With this
property enabled, the banked registers, security-aware queues, and
other secure features become active, allowing a guest to probe and
configure the Secure SMMU.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c92cc0f06a..80fbc25cf5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -351,6 +351,16 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->statusr = 0;
     s->bank[SMMU_SEC_IDX_NS].gbpa = SMMU_GBPA_RESET_VAL;

+    /* Initialize Secure bank (SMMU_SEC_IDX_S) */
+    memset(s->bank[SMMU_SEC_IDX_S].idr, 0, sizeof(s->bank[SMMU_SEC_IDX_S].idr));
+    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(s->bank[SMMU_SEC_IDX_S].idr[1],
+                                                S_IDR1, SECURE_IMPL,
+                                                s->secure_impl);
+    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_S].idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
+    s->bank[SMMU_SEC_IDX_S].gbpa = SMMU_GBPA_RESET_VAL;
+    s->bank[SMMU_SEC_IDX_S].cmdq.entry_size = sizeof(struct Cmd);
+    s->bank[SMMU_SEC_IDX_S].eventq.entry_size = sizeof(struct Evt);
 }

 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
@@ -2505,6 +2515,12 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /*
+     * SECURE_IMPL field in S_IDR1 register.
+     * Indicates whether secure state is implemented.
+     * Defaults to false (0)
+     */
+    DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
 };

 static void smmuv3_instance_init(Object *obj)
--
2.34.1


