Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E3FC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjx-0003Sc-6e; Sun, 21 Jul 2024 20:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjv-0003KR-29
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjs-0005kM-RL
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CYkvuehHMuB8FFNUkACRvfP0TVqplBGSaMD83Q0lWBg=;
 b=OqYYV1rf7a3YwmHjudzZ6kCUNBVGAWZAXziGq7j9IytzpHRqLJOZ/CEh7v8+gy2BFp0/mW
 9cR2Y4TuZsJhCHbUQmGKi5oaM1syISeGfFrk3KR7JhBupqSIdcc062YIndUi4jMnSPkw/6
 WV0yXcfaJ3z14GWVnflcf77EiLcz8ng=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-9DsFoTTsMLqPzCgW_HgPQA-1; Sun, 21 Jul 2024 20:17:14 -0400
X-MC-Unique: 9DsFoTTsMLqPzCgW_HgPQA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426d316a96cso26613315e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607432; x=1722212232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYkvuehHMuB8FFNUkACRvfP0TVqplBGSaMD83Q0lWBg=;
 b=pMmCWIMLyNa48yLAH53zODqHbFaAM8kZm8Shf7Y7f5/i4eS9yzlcYMoAJXLU041dWK
 +oikNhWzd0RtvY52fRbV0C1T9VV4yt1kKG+utju3CSjyqAQ9Gd5ZmL29+S5QBLk2ukR2
 0arfreDoi6gerGrjjdw3ymoSS+LJUHyhEWx7albEtqYdjctQddKjW9bJ1gtEWd4hg43O
 i/eaLhFviOvYk6tksaaD6Q+ha+ynALMriFcc3oaoGTIKjJ3gytpUCs9YA89K1/Sxvs5I
 Zuzc2iZEa4qYsov+C6Fdwhn7LqynzYjlkW4mwfjLR0Nv+9Dpq2X4RVzvOa6jih9eYMe+
 3J4w==
X-Gm-Message-State: AOJu0Yx5xwgSirDhFTDMxQDKS3qpYVvCG+D9jAj23EQUAqvdKwGVkbof
 5FYLIvV4Ptrt1UvIovM3eqpGcjoopIK5bh88qj8ZBFjQ/jkca/+SbnoZSbWS1VNHSXqVimxr5TZ
 NNUUSIt83+S55KJanW1itHqwiuQ1MwlVoYxo6gKZLtWz7uoP6M3F3M2W1Y4joJWDTX41ViExlzU
 ER3JZzB/JDamdIz8c8ZkefHH9uz0iVTw==
X-Received: by 2002:a05:600c:3b23:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-427dc4ce7b4mr41789355e9.0.1721607432482; 
 Sun, 21 Jul 2024 17:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtVb8sDZfpVROb/qgYFPEqNvG4gBNRZpDKPCdJeXjnwQqUkexsWbERyI3WUdWU/FdtPZGlfw==
X-Received: by 2002:a05:600c:3b23:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-427dc4ce7b4mr41789165e9.0.1721607431908; 
 Sun, 21 Jul 2024 17:17:11 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8d930sm133892055e9.32.2024.07.21.17.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:11 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 10/63] cxl/mailbox: move mailbox effect definitions to a header
Message-ID: <25da36d5d04deb8869bd6ad1223832f09f3efe79.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Gregory Price <gourry.memverge@gmail.com>

Preparation for allowing devices to define their own CCI commands

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Link: https://lore.kernel.org/r/20230906001517.324380-2-gregory.price@memverge.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705123039.963781-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c   | 34 +++++++++++++++-------------------
 2 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 include/hw/cxl/cxl_mailbox.h

diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
new file mode 100644
index 0000000000..beb048052e
--- /dev/null
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU CXL Mailbox
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_MAILBOX_H
+#define CXL_MAILBOX_H
+
+#define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
+#define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
+#define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
+#define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
+#define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+
+#endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 82120a6e7b..dbaa83a110 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -12,6 +12,7 @@
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
+#include "hw/cxl/cxl_mailbox.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
@@ -2095,28 +2096,21 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
-#define IMMEDIATE_DATA_CHANGE (1 << 2)
-#define IMMEDIATE_POLICY_CHANGE (1 << 3)
-#define IMMEDIATE_LOG_CHANGE (1 << 4)
-#define SECURITY_STATE_CHANGE (1 << 5)
-#define BACKGROUND_OPERATION (1 << 6)
-
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
-        cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
+        cmd_events_clear_records, ~0, CXL_MBOX_IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
                                       cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
                                       cmd_events_set_interrupt_policy,
-                                      ~0, IMMEDIATE_CONFIG_CHANGE },
+                                      ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
-                         8, IMMEDIATE_POLICY_CHANGE },
+                         8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -2126,9 +2120,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_ccls_get_partition_info, 0, 0 },
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
-        ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
-        IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_SECURITY_STATE_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -2141,7 +2137,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
-        cmd_media_scan_media, 17, BACKGROUND_OPERATION },
+        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
     [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
         cmd_media_get_scan_media_results, 0, 0 },
@@ -2155,10 +2151,10 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
         8, 0 },
     [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
         "DCD_ADD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [DCD_CONFIG][RELEASE_DYN_CAP] = {
         "DCD_RELEASE_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
@@ -2166,8 +2162,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
         cmd_infostat_bg_op_sts, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
-    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 0,
-                         IMMEDIATE_POLICY_CHANGE },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -2210,7 +2206,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     /* Only one bg command at a time */
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         cci->bg.runtime > 0) {
         return CXL_MBOX_BUSY;
     }
@@ -2235,7 +2231,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         ret == CXL_MBOX_BG_STARTED) {
         *bg_started = true;
     } else {
-- 
MST


