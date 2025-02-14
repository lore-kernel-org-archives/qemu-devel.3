Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F027C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixm3-0007Aq-9e; Fri, 14 Feb 2025 10:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1tixm0-0007Ai-OV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:38:36 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1tixlv-0002ww-II
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:38:36 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20250214153823epoutp037c13602dc8eb5544e0f0b92ddc696c61~kHTzPG5r61677716777epoutp03G
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 15:38:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20250214153823epoutp037c13602dc8eb5544e0f0b92ddc696c61~kHTzPG5r61677716777epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739547503;
 bh=E1aP9RKpBHNGwpMkk0EF5JxcX1s1gfUwARLKxmP4nxo=;
 h=From:To:Cc:Subject:Date:References:From;
 b=N4V4UqE4Pw1szV10FrqX3IzT8/c51ngoA0Xgt9/dVaySuLuysgUAWNCXYbxMHgf1Z
 0eDgtWq2gPa9EcTeunBy3LPoqMUW0zryEyYUbJkYGq1Uu9yMwfO2SjL2oSoYyQ3orr
 cPjEXLA6C5A8YMh+3Sby0tLqZmNnW2BffQTyPSKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20250214153822epcas5p1a22cc8fa4fe0014a305504dbb7ee2f77~kHTy60w2F2356723567epcas5p1P;
 Fri, 14 Feb 2025 15:38:22 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YvbmX4l4nz4x9Pr; Fri, 14 Feb
 2025 15:38:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0C.22.29212.C636FA76; Sat, 15 Feb 2025 00:38:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250214132317epcas5p3732f86a4aa3cee5c396e18c2bf98a82b~kFd2MO7nR2344923449epcas5p3Z;
 Fri, 14 Feb 2025 13:23:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250214132317epsmtrp167415ff88f8fbee2afc993a76db24d3c~kFd2IGKSG0681306813epsmtrp1h;
 Fri, 14 Feb 2025 13:23:17 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-19-67af636c8a8a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 08.78.18949.5C34FA76; Fri, 14 Feb 2025 22:23:17 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250214132315epsmtip2b28d51ba4e78bc3c1b5357d8f8d0b8ce~kFd0kiHky0884608846epsmtip2T;
 Fri, 14 Feb 2025 13:23:15 +0000 (GMT)
From: Sweta Kumari <s5.kumari@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Sweta Kumari
 <s5.kumari@samsung.com>
Subject: [PATCH v2] CXL CCI Get/Set Alert Configuration commands implmented
 as per CXL Specification 3.2 section 8.2.10.9.3
Date: Fri, 14 Feb 2025 18:52:11 +0530
Message-Id: <20250214132211.528019-1-s5.kumari@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhm5O8vp0gxs/lCymH1a0+HJ6D5vF
 6ptrGC1uHtjJZLFw4zImi/OzTrFY/N22l9HieO8OFos15z6zAMXmsDtweeycdZfd48m1zUwe
 fVtWMXpMnV3v8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
 qq2Si0+ArltmDtBNSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
 dL281BIrQwMDI1OgwoTsjOtrp7AUNPlVfFnTwd7AuN66i5GTQ0LARGLz/elMXYxcHEICexgl
 ujb/hnI+MUp8mrcPyvnGKLH4xBl2mJaL3Q/AbCGBvYwSC7eEQBQ1MEncvnyXBSTBJqAl8ePz
 A2YQW0RAUuJ312lmkCJmgVeMEhs3tLKBJIQFaiUa9j9hArFZBFQlvnw8B2bzClhLdJxsZ4PY
 Ji+x/+BZZoi4oMTJmU/AFjADxZu3zgYbKiFwi12iYfUBoGYOIMdF4vu7UIheYYlXx7dAXS0l
 8bK/DcrOlri7tRNqfonEh9u7mSBse4nWU/3MIGOYBTQl1u/ShwjLSkw9tY4JYi2fRO/vJ1Dl
 vBI75sHYyhJb/i1nhbAlJVZ8XgJle0hc/7iMBRJYsRJNJxvZJjDKz0LyzSwk38xC2LyAkXkV
 o1RqQXFuemqyaYGhbl5qOTxmk/NzNzGC06ZWwA7G1Rv+6h1iZOJgPMQowcGsJMIrMW1NuhBv
 SmJlVWpRfnxRaU5q8SFGU2AYT2SWEk3OBybuvJJ4QxNLAxMzMzMTS2MzQyVx3uadLelCAumJ
 JanZqakFqUUwfUwcnFINTM3Ou3uUw3ndJyhI+nHO/Ca3Zx7rz5iS3IuH5/jtMeqP570kXD7x
 wtlJXVZ56vM1p5pMenD9e86sBz63SqecvbDvpZHaL3Wd6eWNASazytbOZOpWart9qyzhlqyK
 Utams4dfT36qKnfHbuarwk717blnTkR8FeHe88Pu3wYmVc+fNxnnNzfvKb8l6NzVqbrp19G8
 v7e7rvce1A7Y95i7I3zKmet+3rZKt4schXcImDveZ1j2tTRY8Lnoz7v/86fGSqdOCdm9+03n
 lGU39+ybmj+9NK5q0ZvcuZaLe3yMPVWuOb5kNb1wsCzznk6/aPW/B/O0Kqtbluqpulw/UFEh
 L31j0zI2NYezEaXbH66IXanEUpyRaKjFXFScCAAGuUlNJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvO5R5/XpBj8fcltMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBZrzn1mAYrNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6M62unsBQ0+VV8WdPB3sC43rqLkZNDQsBE
 4mL3A/YuRi4OIYHdjBJtP3rYIRKSEm/PXGKEsIUlVv57DlX0j1Hi9a9eZpAEm4CWxI/PD8Bs
 EaCG312nmUGKmAW+MEpMafjKBJIQFqiWuL+8BWwqi4CqxJeP58DivALWEh0n29kgNshL7D94
 lhkiLihxcuYTFhCbGSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDKSy3XK07MLS7N
 S9dLzs/dxAgOYS2tHYx7Vn3QO8TIxMF4iFGCg1lJhFdi2pp0Id6UxMqq1KL8+KLSnNTiQ4zS
 HCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGpjqA3e/NtHg8lS8K9MdJX/qytKXHJzfjHe1
 J/1NfML+ms1o9qfPSlE+kUH2y5M/BTowTym/vWJXuymjRI9tg19M1qoChXNrFvM+jri/UKkn
 6fSWZzNiRPeejCi/Y58++fs9l0XGlgHbeKYn6epbpfKsOyC+UtxqT9W0u2sCY7/pP9lT2lBu
 H3Fwxwy5xbtXFHpUX8xmtXDh/mq1w1IoJ0IgNbzjuruuYdG3268b/OK9Jsmn342a+lnPrvFW
 jm+iwQ3+i7r6dufO5ir7KmatLRMqlRMr8LKSUPx0JfNctOpEWeXJeuU+XLcmn/Jau+X/zFeb
 +V69umQ3df+LuIm/sxXOfpjWPEFz8gdZtmTveUosxRmJhlrMRcWJAE/TDIXQAgAA
X-CMS-MailID: 20250214132317epcas5p3732f86a4aa3cee5c396e18c2bf98a82b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214132317epcas5p3732f86a4aa3cee5c396e18c2bf98a82b
References: <CGME20250214132317epcas5p3732f86a4aa3cee5c396e18c2bf98a82b@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=s5.kumari@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

1)get alert configuration(Opcode 4201h)
2)set alert configuration(Opcode 4202h)

This v2 patch addresses the feedback from the v1 patch and include some minor new changes.

Changes in V2:
- Removed cover letter as it's a single patch
- Added latest spec reference
- Fixed alignment issues
- Updated shorter variable names to be more descriptive
- Replaced field-by-field initialization in 'init_alert_config' with structured initialization for improved readability.
- Replaced bit fields with 'uint8_t' and added defines for individual bits.

The patch is generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 116 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  16 +++++
 include/hw/cxl/cxl_device.h |  15 +++++
 3 files changed, 147 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..105c63fdec 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -28,6 +28,11 @@
 #define CXL_DC_EVENT_LOG_SIZE 8
 #define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
+#define CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD (1 << 0)
+#define CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD (1 << 1)
+#define CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD (1 << 2)
+#define CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD (1 << 3)
+#define CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD (1 << 4)
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -86,6 +91,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_ALERT_CONFIGURATION 0x1
+        #define SET_ALERT_CONFIGURATION 0x2
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
@@ -1625,6 +1633,110 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 Section 8.2.10.9.3.2 Get Alert Configuration (Opcode 4201h) */
+static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *out = (void *)payload_out;
+
+    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
+    *len_out = sizeof(ct3d->alert_config);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.2 Section 8.2.10.9.3.3 Set Alert Configuration (Opcode 4202h) */
+static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *alert_config = &ct3d->alert_config;
+    struct {
+        uint8_t valid_alert_actions;
+        uint8_t enable_alert_actions;
+        uint8_t life_used_warning_threshold;
+        uint8_t rsvd;
+        uint16_t device_over_temperature_warning_threshold;
+        uint16_t device_under_temperature_warning_threshold;
+        uint16_t Corrected_volatile_memory_error_warning_threshold;
+        uint16_t Corrected_persistent_memory_error_warning_threshold;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (in->valid_alert_actions & CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD) {
+        /*
+         * CXL 3.2 Table 8-149 The life used warning threshold shall be
+         * less than the life used critical alert value.
+         */
+        if (in->life_used_warning_threshold >=
+            alert_config->life_used_critical_alert_threshold) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->life_used_warning_threshold =
+            in->life_used_warning_threshold;
+        alert_config->enable_alerts |= CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD;
+    }
+
+    if (in->valid_alert_actions &
+        CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD) {
+        /*
+         * CXL 3.2 Table 8-149 The Device Over-Temperature Warning Threshold
+         * shall be less than the the Device Over-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->device_over_temperature_warning_threshold >=
+            alert_config->device_over_temperature_critical_alert_threshold) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->device_over_temperature_warning_threshold =
+            in->device_over_temperature_warning_threshold;
+        alert_config->enable_alerts |=
+            CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD;
+    }
+
+    if (in->valid_alert_actions &
+        CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD) {
+        /*
+         * CXL 3.2 Table 8-149 The Device Under-Temperature Warning Threshold
+         * shall be higher than the the Device Under-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->device_under_temperature_warning_threshold <=
+            alert_config->device_under_temperature_critical_alert_threshold) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->device_under_temperature_warning_threshold =
+            in->device_under_temperature_warning_threshold;
+        alert_config->enable_alerts |=
+            CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD;
+    }
+
+    if (in->valid_alert_actions &
+        CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD) {
+        alert_config->Corrected_volatile_memory_error_warning_threshold =
+            in->Corrected_volatile_memory_error_warning_threshold;
+        alert_config->enable_alerts |=
+            CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD;
+    }
+
+    if (in->valid_alert_actions &
+        CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD) {
+        alert_config->Corrected_persistent_memory_error_warning_threshold =
+            in->Corrected_persistent_memory_error_warning_threshold;
+        alert_config->enable_alerts |=
+            CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitization(CXLType3Dev *ct3d)
 {
@@ -2859,6 +2971,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
+    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",
+        cmd_get_alert_config, 0, 0 },
+    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
+        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5f365afb4d..5f01684ffc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -956,6 +956,21 @@ static DOEProtocol doe_comp_prot[] = {
     { }
 };
 
+/*
+ * Initialize CXL device alerts with default threshold values.
+ */
+static void init_alert_config(CXLType3Dev *ct3d)
+{
+    ct3d->alert_config = (CXLAlertConfig) {
+        .life_used_critical_alert_threshold = 75,
+        .life_used_warning_threshold = 40,
+        .device_over_temperature_critical_alert_threshold = 35,
+        .device_under_temperature_critical_alert_threshold = 10,
+        .device_over_temperature_warning_threshold = 25,
+        .device_under_temperature_warning_threshold = 20
+    };
+}
+
 void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -1030,6 +1045,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_free_special_ops;
     }
 
+    init_alert_config(ct3d);
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
     rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25..1da23bf553 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -581,6 +581,19 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+typedef struct CXLAlertConfig {
+    uint8_t valid_alerts;
+    uint8_t enable_alerts;
+    uint8_t life_used_critical_alert_threshold;
+    uint8_t life_used_warning_threshold;
+    uint16_t device_over_temperature_critical_alert_threshold;
+    uint16_t device_under_temperature_critical_alert_threshold;
+    uint16_t device_over_temperature_warning_threshold;
+    uint16_t device_under_temperature_warning_threshold;
+    uint16_t Corrected_volatile_memory_error_warning_threshold;
+    uint16_t Corrected_persistent_memory_error_warning_threshold;
+} QEMU_PACKED CXLAlertConfig;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -605,6 +618,8 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    CXLAlertConfig alert_config;
+
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-- 
2.34.1


