Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A350C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAd8-0005pF-5P; Wed, 14 May 2025 07:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAd5-0005ol-57
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAd2-00062K-1n
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o3VTGXmHpKQX+xxI8x7d0AGiDNhIqUOHSWtPCL/LLDE=;
 b=MuFG+r3Y2+kKDnQnsZ9C0m0E5wf71ppSyEio9j62wd9kwBFcgFzD2lBaGV5URAUnuchZrd
 WPPh7b3rc8qKjU5h9UVLR9e3SSHFWVI0k+vLscQo/gt1AFfbhNOtFDOh2CGv9pizSLX8te
 EVWIV+HC4+lsp5QkABkALuB9Ng1mq1g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-GDDmSUsoPj6v1J6Yprl72Q-1; Wed, 14 May 2025 07:50:24 -0400
X-MC-Unique: GDDmSUsoPj6v1J6Yprl72Q-1
X-Mimecast-MFC-AGG-ID: GDDmSUsoPj6v1J6Yprl72Q_1747223424
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so39046575e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223423; x=1747828223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3VTGXmHpKQX+xxI8x7d0AGiDNhIqUOHSWtPCL/LLDE=;
 b=mHh6dsLPmeGY6qTpxGXE28NRR6MFVxV3oqZHv3o/UI25YQc9jUYO61HerAOaDkpcKS
 vrxRuAujdY3vPDUibDm7Pg0ndkdYATlx3881xsmfv4vfBYo7+8pn07E2SKuFgavcX2EH
 O6dnl/Pl1Isq2GOzXF8SiORxtXojHObEDMhKntt84SG7QFd9Qw+LO9iz9joQITP4+Xae
 pWrvvKLceFXW9qeol1+J1DQHuzC7wUUthKX5rD80h6D3CGIo3FpUaZPZx2yQ9K568y5t
 zSATVJUeKhCyBm3KeToDHAJSxHfapAkTcwAktTkOpbFqZfxT7qjnxvn05ffavFq42Gkc
 c/Gg==
X-Gm-Message-State: AOJu0Yz3flsGhCq8UujW+oCOg2knfoU1AXiIX7GyLfAA1Jti9q+3M3bi
 StIlUijRDKNcCbYA5JKz/tt9EEvRItqFErfevxxwqKTzhhhrFaN4sgkXWHEUIzmRaAlGO4BlqLa
 IRe9XQvYx3/KqeZ8y+vcvs9XPRkfZIFoCs+43FD8xxc/pPFks2rfVF0PD+7czChj4NDmLKL1RCY
 cLu871GV6ED7RnGgbV4qd8KUAjsE7EeQ==
X-Gm-Gg: ASbGncvvLW8Ef9svUj+/dVETJvYsE+kGGh600Rpf5ZArE7o/Or5uXl1tQJv2nENa8d7
 dVSjWPXPBmqailo6wgqW4sihxSS4sdcBczoEZcQmjcg6nlZQhzgLOgMUUp8c+T9scjocx+pGEgu
 JlmLnaqppWBb7/02T7ao2gWDQ/v8dZJNnml4B42rgOtcCitoxwBWHRd+rJs7mYwiAe9iXXyL9g7
 LKjjLAVhgjdO6SCwkW7vYyRNvSGL9Gz280BHwSKo0jvLyHBMTOh+rTIvEmPGsVql4ia5IH1/gFT
 Ts9HOw==
X-Received: by 2002:a05:600c:3b02:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-442f20bb658mr29380905e9.5.1747223423117; 
 Wed, 14 May 2025 04:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9OtKNXwEwIwOe42LtWVOzShCbOdu1QuoGq1FdmQpKQxfmA/JJfwXM9mHoFwLYp9tl2KXb7Q==
X-Received: by 2002:a05:600c:3b02:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-442f20bb658mr29380655e9.5.1747223422736; 
 Wed, 14 May 2025 04:50:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebda7d2csm34609005e9.3.2025.05.14.04.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:22 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 02/27] hw/cxl: Support get/set mctp response payload size
Message-ID: <1000158f031818bf286454c8691da9b4f33c4d02.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Davidlohr Bueso <dave@stgolabs.net>

Add Get/Set Response Message Limit commands.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250305092501.191929-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 58 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4401f446d9..bd25df033a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
 
+#include <math.h>
+
 #include "qemu/osdep.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
@@ -56,6 +58,8 @@ enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
         #define BACKGROUND_OPERATION_STATUS    0x2
+        #define GET_RESPONSE_MSG_LIMIT         0x3
+        #define SET_RESPONSE_MSG_LIMIT         0x4
         #define BACKGROUND_OPERATION_ABORT     0x5
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
@@ -413,12 +417,58 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
         is_identify->component_type = 0x3; /* Type 3 */
     }
 
-    /* TODO: Allow this to vary across different CCIs */
-    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
+    is_identify->max_message_size = (uint8_t)log2(cci->payload_max);
     *len_out = sizeof(*is_identify);
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.1.3: Get Response Message Limit (Opcode 0003h) */
+static CXLRetCode cmd_get_response_msg_limit(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *get_rsp_msg_limit = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*get_rsp_msg_limit) != 1);
+
+    get_rsp_msg_limit->rsp_limit = (uint8_t)log2(cci->payload_max);
+
+    *len_out = sizeof(*get_rsp_msg_limit);
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.1.4: Set Response Message Limit (Opcode 0004h) */
+static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *in = (void *)payload_in;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 1);
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*out) != 1);
+
+    if (in->rsp_limit < 8 || in->rsp_limit > 10) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    cci->payload_max = 1 << in->rsp_limit;
+    out->rsp_limit = in->rsp_limit;
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
                                   void *private)
 {
@@ -3105,6 +3155,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 
 static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
-- 
MST


