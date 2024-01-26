Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B70C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTL9J-0004pE-Bs; Fri, 26 Jan 2024 07:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTL8v-0004fv-Eo
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:17:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTL8s-00058D-TU
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:17:08 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLxSR47RFz6J9tX;
 Fri, 26 Jan 2024 20:13:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 21E04140D1A;
 Fri, 26 Jan 2024 20:17:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:17:04 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] hw/cxl: Update HDM Decoder capability to version 3
Date: Fri, 26 Jan 2024 12:16:32 +0000
Message-ID: <20240126121636.24611-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126121636.24611-1-Jonathan.Cameron@huawei.com>
References: <20240126121636.24611-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Part of standardizing the QEMU code on CXL r3.1.
No fuctional changes as everything added is optional and
it is set as not implemented.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
 include/hw/cxl/cxl_component.h | 16 ++++++++++++++--
 hw/cxl/cxl-component-utils.c   | 10 +++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 5227a8e833..7d3edef1bf 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -109,8 +109,9 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
     (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
 #define CXL_LINK_REGISTERS_SIZE   0x38
 
-/* 8.2.5.12 - CXL HDM Decoder Capability Structure */
-#define HDM_DECODE_MAX 10 /* 8.2.5.12.1 */
+/* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
+#define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
+#define CXL_HDM_CAPABILITY_VERSION 3
 #define CXL_HDM_REGISTERS_OFFSET \
     (CXL_LINK_REGISTERS_OFFSET + CXL_LINK_REGISTERS_SIZE)
 #define CXL_HDM_REGISTERS_SIZE (0x10 + 0x20 * HDM_DECODE_MAX)
@@ -133,6 +134,11 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
             FIELD(CXL_HDM_DECODER##n##_CTRL, COMMITTED, 10, 1)                 \
             FIELD(CXL_HDM_DECODER##n##_CTRL, ERR, 11, 1)                       \
             FIELD(CXL_HDM_DECODER##n##_CTRL, TYPE, 12, 1)                      \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, BI, 13, 1)                        \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIO, 14, 1)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIG, 16, 4)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIW, 20, 4)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, ISP, 24, 4)                       \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
         CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
@@ -148,6 +154,12 @@ REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 9, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 11, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, 16_WAY, 12, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO, 13, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO_DECODER_COUNT, 16, 4)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 20, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, SUPPORTED_COHERENCY_MODEL, 21, 2)
 REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 5ddd47ed8d..a55cf5a036 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -243,6 +243,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      POISON_ON_ERR_CAP, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
+                     UIO_DECODER_COUNT, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
+                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
@@ -326,7 +334,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         return;
     }
 
-    init_cap_reg(HDM, 5, 1);
+    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
     hdm_init_common(reg_state, write_msk, type);
 
     if (caps < 5) {
-- 
2.39.2


