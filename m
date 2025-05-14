Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D841C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdH-0005rq-KK; Wed, 14 May 2025 07:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdF-0005rD-Nf
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdC-00065l-93
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qyLQmrtd4FJpGU+6njcciX6Un/5UyHexyk6THOUGTQI=;
 b=iCkAS79AxlmZXKKSALvTNyLkLc3wAEbsdSZFdfZNNb57zqyb2fEH5jIMR9cOB7NJ6SCzuq
 CVAP2J7Z/OYaFne8dmSDZ0hHfeO3TxhzWtCBILGqYVTydGgg8jaW5+zErA4I2/oe4Vrs0R
 OMsQ92rkKZ30YUeluY79VpWh+6y8TE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-rEX3CRJ5O_CBdb2dtu-ptg-1; Wed, 14 May 2025 07:50:35 -0400
X-MC-Unique: rEX3CRJ5O_CBdb2dtu-ptg-1
X-Mimecast-MFC-AGG-ID: rEX3CRJ5O_CBdb2dtu-ptg_1747223434
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0ba24d233so2322583f8f.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223433; x=1747828233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyLQmrtd4FJpGU+6njcciX6Un/5UyHexyk6THOUGTQI=;
 b=lloj1M97RQn+7BI7yx7RuCiGi0zHyUuezq90tHVO+iBykdEtDfe27Brzvns6w+e47Y
 tf/FRNveNcjUXpe6SSIK1g8as/m14AwlDhXhspKZdVoSp0B8P9mSbAC+mKynBbX+lkEH
 3epxOC6OO32NScJdpVq/Xj4gLwZ+5T9PwPWMd+VX5tT8l8PH7T2V8+ZCTU814gh9+ccy
 VGXHfjGDokRs+ya/zA/1pV8HqGSZqCMcVRJyS4oKwPE8wdfytqmHTWuVl6eHC06vd4kA
 TjHrmoqu5LpJVvdufHGhdKOrBRW8cy11+aGRtFVM8vIDerca3pMI0PDl5O9X3zhv+Fw4
 AG1Q==
X-Gm-Message-State: AOJu0Yx7yxwibR5DeRPWaTZ8f+xMtrYiWBAn6I9SM75LCC9QVvbdaRDq
 LO6Jb7w9HXvIkceYQh9mnpDpDncSXo56TVh9E/n4ULxveI7u7fEALhlpY0O7ozw9b3KDG+dygEw
 2Wv2yRrm1fwh13grhRmpIeZ8X7yVcrv3rUZbWEC/M6UlzDx3/CsUyP/DRsTrvBIEwKGOm/2hb8e
 g/zUssJnPmNGvj618v/AUMfP6v3aH8HA==
X-Gm-Gg: ASbGncsnFqvmsQIYrKx+X/VIV5RVc7ttr8410qz2xympnWIZi1HP/xkVfz2ZK8vpuZA
 Q/hyD5GzdEK2krlRkIaAfe5sKUSPnbqk1sZee4q5ugxcb/7x1iR9yXRTaHmSb76YTb3T7qN4Xk1
 y/yrPWSp4iwtSnx+qsSuY9P/vSCOv6z5Qvc4jfAnQBhDbXZFmZonmwdzpR5qM6XBW9tSyAhn0u9
 0w4mnlTPgYxp955y17BkOCwJ4MpUWxE/4Rm0OQ8K7E3AgNUrMOGkHDaYhq3nw6vxUSqYzPrW5JQ
 sWG5cQ==
X-Received: by 2002:a5d:64e7:0:b0:3a0:b8b0:4418 with SMTP id
 ffacd0b85a97d-3a34994e42cmr2405804f8f.50.1747223433054; 
 Wed, 14 May 2025 04:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt0xZtaX+HoQWSONvM7R8loNJmejnr3JjrjuZbbSrtpXK9rfolChhw+fJllGoiN3eihu2dmw==
X-Received: by 2002:a5d:64e7:0:b0:3a0:b8b0:4418 with SMTP id
 ffacd0b85a97d-3a34994e42cmr2405780f8f.50.1747223432621; 
 Wed, 14 May 2025 04:50:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58eb91bsm19865181f8f.33.2025.05.14.04.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:32 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sweta Kumari <s5.kumari@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 06/27] hw/cxl/cxl-mailbox-utils: CXL CCI Get/Set alert config
 commands
Message-ID: <a3e0b1ff37e930095a417666ab3e12715394fb9b.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sweta Kumari <s5.kumari@samsung.com>

1) get alert configuration(Opcode 4201h)
2) set alert configuration(Opcode 4202h)

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250305092501.191929-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  15 ++++++
 hw/cxl/cxl-mailbox-utils.c  | 105 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  14 +++++
 3 files changed, 134 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3ec7be3809..ed6cd50c67 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -542,6 +542,19 @@ typedef struct CXLSetFeatureInfo {
 
 struct CXLSanitizeInfo;
 
+typedef struct CXLAlertConfig {
+    uint8_t valid_alerts;
+    uint8_t enable_alerts;
+    uint8_t life_used_crit_alert_thresh;
+    uint8_t life_used_warn_thresh;
+    uint16_t over_temp_crit_alert_thresh;
+    uint16_t under_temp_crit_alert_thresh;
+    uint16_t over_temp_warn_thresh;
+    uint16_t under_temp_warn_thresh;
+    uint16_t cor_vmem_err_warn_thresh;
+    uint16_t cor_pmem_err_warn_thresh;
+} QEMU_PACKED CXLAlertConfig;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -563,6 +576,8 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    CXLAlertConfig alert_config;
+
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2c6db70e5f..299f232f26 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -28,6 +28,11 @@
 #define CXL_DC_EVENT_LOG_SIZE 8
 #define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
+#define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
+#define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
+#define CXL_ALERTS_UNDER_TEMP_WARN_THRESH (1 << 2)
+#define CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH (1 << 3)
+#define CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH (1 << 4)
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -86,6 +91,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_ALERT_CONFIG 0x1
+        #define SET_ALERT_CONFIG 0x2
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
@@ -1610,6 +1618,97 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
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
+    CXLAlertConfig *out = (CXLAlertConfig *)payload_out;
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
+        uint8_t life_used_warn_thresh;
+        uint8_t rsvd;
+        uint16_t over_temp_warn_thresh;
+        uint16_t under_temp_warn_thresh;
+        uint16_t cor_vmem_err_warn_thresh;
+        uint16_t cor_pmem_err_warn_thresh;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (in->valid_alert_actions & CXL_ALERTS_LIFE_USED_WARN_THRESH) {
+        /*
+         * CXL r3.2 Table 8-149 The life used warning threshold shall be
+         * less than the life used critical alert value.
+         */
+        if (in->life_used_warn_thresh >=
+            alert_config->life_used_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->life_used_warn_thresh = in->life_used_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_LIFE_USED_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_OVER_TEMP_WARN_THRESH) {
+        /*
+         * CXL r3.2 Table 8-149 The Device Over-Temperature Warning Threshold
+         * shall be less than the the Device Over-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->over_temp_warn_thresh >=
+            alert_config->over_temp_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->over_temp_warn_thresh = in->over_temp_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_OVER_TEMP_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_UNDER_TEMP_WARN_THRESH) {
+        /*
+         * CXL r3.2 Table 8-149 The Device Under-Temperature Warning Threshold
+         * shall be higher than the the Device Under-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->under_temp_warn_thresh <=
+            alert_config->under_temp_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->under_temp_warn_thresh = in->under_temp_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_UNDER_TEMP_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH) {
+        alert_config->cor_vmem_err_warn_thresh = in->cor_vmem_err_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH) {
+        alert_config->cor_pmem_err_warn_thresh = in->cor_pmem_err_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitization(CXLType3Dev *ct3d)
 {
@@ -3173,6 +3272,12 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
+    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIG] = {
+        "HEALTH_INFO_ALERTS_GET_ALERT_CONFIG",
+        cmd_get_alert_config, 0, 0 },
+    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIG] = {
+        "HEALTH_INFO_ALERTS_SET_ALERT_CONFIG",
+        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index aacd078118..94e7274912 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,6 +843,19 @@ static DOEProtocol doe_cdat_prot[] = {
     { }
 };
 
+/* Initialize CXL device alerts with default threshold values. */
+static void init_alert_config(CXLType3Dev *ct3d)
+{
+    ct3d->alert_config = (CXLAlertConfig) {
+        .life_used_crit_alert_thresh = 75,
+        .life_used_warn_thresh = 40,
+        .over_temp_crit_alert_thresh = 35,
+        .under_temp_crit_alert_thresh = 10,
+        .over_temp_warn_thresh = 25,
+        .under_temp_warn_thresh = 20
+    };
+}
+
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -910,6 +923,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_msix_uninit;
     }
 
+    init_alert_config(ct3d);
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
     rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
-- 
MST


