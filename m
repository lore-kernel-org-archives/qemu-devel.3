Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132D606A331
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGHz-0001Fb-Bk; Sat, 14 Nov 2026 11:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGHx-00019g-RX; Sat, 14 Nov 2026 11:07:37 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGHv-0001uJ-SV; Sat, 14 Nov 2026 11:07:37 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAnL6dFh_hqAjIqBg--.61123S2; 
 Sun, 15 Nov 2026 00:07:33 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dwe3VDh_hqmNv6AA--.30678S3;
 Sun, 15 Nov 2026 00:07:31 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 34/35] hw/arm/smmuv3: Add the secure-impl property
Date: Sun, 15 Nov 2026 00:07:31 +0800
Message-Id: <20261114160731.3629605-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dwe3VDh_hqmNv6AA--.30678S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBWgAAs-
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrW5tw17Jr4rWr48Ww4DArb_yoW7Xr1DpF
 4UCwn8KFWfC3WfZrsIq3WxuF15Ww4kWa15CrWxG395Za1DAr15Jw1qkryYkFWkJr4kJayS
 vF1xuFW8Cr48XrJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the secure-impl property and advertise the resolved value through
S_IDR1.SECURE_IMPL. The default auto mode follows the availability of
the Secure memory address space, allowing the SMMU to follow the
machine's Secure configuration without a separate global override.

Resolve auto and validate the result in smmu_validate_property(). Reject
secure-impl=on without Secure memory or stage-1 translation support.
Select the available IRQ outputs after resolving the property.

Document the relationship to virt Secure configuration and explicit
arm-smmuv3 device creation.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 docs/system/arm/virt.rst | 11 +++++++++++
 include/hw/arm/smmuv3.h  |  2 ++
 hw/arm/smmuv3.c          | 37 ++++++++++++++++++++++++++++++++++++-
 hw/core/machine.c        |  1 +
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd179786..1876fb02e88 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -289,6 +289,17 @@ User-creatable SMMUv3 devices
       -device pxb-pcie,id=pcie.1,numa_node=1
       -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
 
+  ``secure-impl`` accepts ``on``, ``off``, or the default ``auto``. In
+  ``auto`` mode, the ``secure-memory`` link determines whether the Secure
+  programming interface is enabled. On virt, this link is controlled by the
+  machine's ``secure`` option. Secure support requires Secure memory and
+  Stage 1 support. Secure Stage 2 is not supported.
+
+  This property also applies to user-created devices, for example::
+
+      -M virt,secure=on
+      -device arm-smmuv3,primary-bus=pcie.0,secure-impl=on
+
   *Accelerated SMMUv3 (nested translation)*
 
   The ``accel=on`` option enables hardware-accelerated nested translation
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index cb05cb19e32..b7574107038 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -89,6 +89,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+    OnOffAuto secure_impl;
+
     /* SMMU CMDQV extension */
     OnOffAuto cmdqv;
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b37b388c75e..6a00f6b99fa 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -354,6 +354,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
 
     sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, S_SIDSIZE,
                                SMMU_IDR1_SIDSIZE);
+    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, SECURE_IMPL,
+                               s->secure_impl == ON_OFF_AUTO_ON);
     smmuv3_accel_idr_override(s);
 }
 
@@ -2409,7 +2411,7 @@ static const MemoryRegionOps smmu_mem_ops = {
 
 int smmuv3_get_num_irqs(SMMUv3State *s)
 {
-    return SMMU_IRQ_NUM;
+    return s->secure_impl == ON_OFF_AUTO_ON ? SMMU_IRQ_NUM : SMMU_IRQ_NUM_NS;
 }
 
 static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
@@ -2442,6 +2444,32 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
+    SMMUState *bs = ARM_SMMU(s);
+    bool secure_as_available = bs->secure_memory != NULL;
+
+    if (s->secure_impl == ON_OFF_AUTO_AUTO) {
+        s->secure_impl = secure_as_available ? ON_OFF_AUTO_ON
+                                             : ON_OFF_AUTO_OFF;
+    }
+
+    if (s->secure_impl == ON_OFF_AUTO_ON && !secure_as_available) {
+        error_setg(errp,
+                   "secure-impl=on requires a secure-memory address space");
+        return false;
+    }
+
+    /*
+     * When SECURE_IMPL == 1, stage 1 must be supported according to
+     * (IHI 0070G.b) 6.3.53 SMMU_S_IDR1, Page 442.
+     */
+    if (s->secure_impl == ON_OFF_AUTO_ON &&
+        s->stage && !strcmp(s->stage, "2")) {
+        error_setg(errp,
+                    "secure-impl=on requires stage=1 or stage=nested");
+        return false;
+    }
+
+
     if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
         s->oas != OAS_MODE_AUTO) {
         error_setg(errp, "QEMU SMMUv3 model only implements auto, "
@@ -2626,6 +2654,13 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
+    /*
+     * SECURE_IMPL field in S_IDR1 register.
+     * Indicates whether Secure state is implemented.
+     * Defaults to auto.
+     */
+    DEFINE_PROP_ON_OFF_AUTO("secure-impl", SMMUv3State, secure_impl,
+                            ON_OFF_AUTO_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed9bf8f5008..cd69f1d9159 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -46,6 +46,7 @@ GlobalProperty hw_compat_11_1[] = {
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pcie-root-port", "speed", "16" },
     { "virtio-blk-device", "fua", "off" },
+    { TYPE_ARM_SMMUV3, "secure-impl", "off" },
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
-- 
2.34.1


