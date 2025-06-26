Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DADC7EE33
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 23:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUwN8-00061T-0a; Thu, 26 Jun 2025 19:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUwN5-000615-Sr
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 19:51:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUwN2-0002IC-Qs
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 19:51:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2349f096605so24869055ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750981867; x=1751586667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+mRXGA+oZiP4fjp2MK0XrnzBc/2v3Dfz4xLuPxj0Xk=;
 b=Veu43iHY/JL0ifEPBdGNvL+WO97QmBQzPMachvS0dVGqke5VgR3Tnt5GwSJBlfPvmB
 bhm4AFKyvDddRZISzCuhHWKs+g/wQTEwDgWalj2Kh49fa5op93eR6whZGkRVN+r37KzC
 My5z/aHDPTIiORknirwnDKm0pprNFF4S5swkDo79r0fZ7ScIk+PZRq73ZRAT/e5xJn3B
 +7S22nQpku+q6OiQagwzn1XY+iG7rysZ6ZNeC67x4WiF66LhwnqPfai9vL7ZM7qoE8h2
 OlBNiVUXIJB0I7EBJkmUnWdP9lU6/76KN39fJHPDOzCFSlurq8l4N+/9K7uYFFqkYI4v
 28lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750981867; x=1751586667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+mRXGA+oZiP4fjp2MK0XrnzBc/2v3Dfz4xLuPxj0Xk=;
 b=hpr5k7UjydWZHBoZQUjp5ACnWrIz/1xYaxzMO0MNrv69yRD5lWxckM6JeZmAzz7HTS
 z/U9ESC3p0/Xt+Us/avp/ehTfuhrT1ivOTPugUZhyhwT+AVseXkhoQmnZ6hIDlgV7F+q
 qkFYKLMqLNRlLfmgyWTDywqNi3bo3Ftwg+lBn9nr3j3iLh/cEDcf8V1KxRM0aEMFiu/b
 gYbHjx8P2FVIjQKRxOE3Mmb3rn8h29mj+FG2ygGYGi1bZTQuc/JDwkfBx5BFNP3xMvu4
 KcToVlDfjmntUF9ohkFv6zi/2R8t1xZFnAo51A+BagQL0seXpqpugzX3JWL6x0eRWCnj
 imOw==
X-Gm-Message-State: AOJu0Yzx0fjNOE0D1oqwufJICauEB7vsiKz8cYtYMz3j7910Zzz2Hahq
 nQhoNF/nDe7fu6ww5qsnSNvg3NfwKHP3K53I/98iP9Yc75GF9Nark7Vo9Wj2jw==
X-Gm-Gg: ASbGnctCPxk4U20kjpxc6vBy0I7IBBw1NO29RpoeIVUXOeCdfkZf//qjaR5lMZjdw2C
 8qHzsYrJNiMnR6H3NAC/HXO9oE+v0geaE6M+iDvK9TCjkN8ck14U6XksoEIRRPcFbrEE6A7A98o
 0B2XZEfCbahVkRvHlrbqiYy6wYdZMtFtaPPycvnLrrnm3/scjQlHL2RJroctpCXHqcP8jWrPjEZ
 DhUDu+L5g7wikPoUdsapL/R5DmDcwcTQUAnXvgmEcFiJYV2+KtqAL52vkqdNoyuDCawYZMZfOZ7
 C0pO6CFTNyY824V4s13+Aus34maTSN+PxxIvoG1YcZdiS5Z8OmvaOZeG1LdaunrgYFOY4oZJ1p0
 pRGL+c5U=
X-Google-Smtp-Source: AGHT+IFk1j3vtXbBWNlT2vcqJ5ZknXNg0xSy5kSmp6B//qv1X7OMGPGbO60HZ9QiizvCOo2uKxsY4w==
X-Received: by 2002:a17:903:1aac:b0:234:db06:ac0 with SMTP id
 d9443c01a7336-23ac46835b6mr15381595ad.45.1750981867096; 
 Thu, 26 Jun 2025 16:51:07 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f1845sm2081055ad.70.2025.06.26.16.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 16:51:06 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [HACK QEMU PATCH v1 1/1] hw/cxl: Fix MCTP Binding Check
Date: Thu, 26 Jun 2025 23:41:15 +0000
Message-ID: <20250626235102.1902427-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626235102.1902427-1-anisa.su887@gmail.com>
References: <20250626235102.1902427-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anisa Su <anisa.su@samsung.com>

Per the spec, FMAPI commands (0x51-0x59) must be bound with
MCTP_MT_CXL_FMAPI. Fix the conditions ensuring this in i2c_mctp_cxl.c
and dev-mctp.c

Move the opcode enum from cxl-mailbox-utils.c to cxl_mailbox.h to
allow i2c_mctp_cxl.c and dev-mctp.c to use the enum instead of
hardcoding the values.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
 hw/cxl/i2c_mctp_cxl.c        |  6 ++-
 hw/usb/dev-mctp.c            |  6 ++-
 include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 77 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4c01b25110..7f84e147f7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -37,7 +37,7 @@
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
- *  1. Add the command set and cmd to the enum.
+ *  1. Add the command set and cmd to the enum in cxl_mailbox.h.
  *     FOO    = 0x7f,
  *          #define BAR 0
  *  2. Implement the handler
@@ -60,78 +60,6 @@
  *  a register interface that already deals with it.
  */
 
-enum {
-    INFOSTAT    = 0x00,
-        #define IS_IDENTIFY   0x1
-        #define BACKGROUND_OPERATION_STATUS    0x2
-        #define GET_RESPONSE_MSG_LIMIT         0x3
-        #define SET_RESPONSE_MSG_LIMIT         0x4
-        #define BACKGROUND_OPERATION_ABORT     0x5
-    EVENTS      = 0x01,
-        #define GET_RECORDS   0x0
-        #define CLEAR_RECORDS   0x1
-        #define GET_INTERRUPT_POLICY   0x2
-        #define SET_INTERRUPT_POLICY   0x3
-    FIRMWARE_UPDATE = 0x02,
-        #define GET_INFO      0x0
-        #define TRANSFER      0x1
-        #define ACTIVATE      0x2
-    TIMESTAMP   = 0x03,
-        #define GET           0x0
-        #define SET           0x1
-    LOGS        = 0x04,
-        #define GET_SUPPORTED 0x0
-        #define GET_LOG       0x1
-        #define GET_LOG_CAPABILITIES   0x2
-        #define CLEAR_LOG     0x3
-        #define POPULATE_LOG  0x4
-    FEATURES    = 0x05,
-        #define GET_SUPPORTED 0x0
-        #define GET_FEATURE   0x1
-        #define SET_FEATURE   0x2
-    IDENTIFY    = 0x40,
-        #define MEMORY_DEVICE 0x0
-    CCLS        = 0x41,
-        #define GET_PARTITION_INFO     0x0
-        #define GET_LSA       0x2
-        #define SET_LSA       0x3
-    HEALTH_INFO_ALERTS = 0x42,
-        #define GET_ALERT_CONFIG 0x1
-        #define SET_ALERT_CONFIG 0x2
-    SANITIZE    = 0x44,
-        #define OVERWRITE     0x0
-        #define SECURE_ERASE  0x1
-        #define MEDIA_OPERATIONS 0x2
-    PERSISTENT_MEM = 0x45,
-        #define GET_SECURITY_STATE     0x0
-    MEDIA_AND_POISON = 0x43,
-        #define GET_POISON_LIST        0x0
-        #define INJECT_POISON          0x1
-        #define CLEAR_POISON           0x2
-        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
-        #define SCAN_MEDIA             0x4
-        #define GET_SCAN_MEDIA_RESULTS 0x5
-    DCD_CONFIG  = 0x48,
-        #define GET_DC_CONFIG          0x0
-        #define GET_DYN_CAP_EXT_LIST   0x1
-        #define ADD_DYN_CAP_RSP        0x2
-        #define RELEASE_DYN_CAP        0x3
-    PHYSICAL_SWITCH = 0x51,
-        #define IDENTIFY_SWITCH_DEVICE      0x0
-        #define GET_PHYSICAL_PORT_STATE     0x1
-    TUNNEL = 0x53,
-        #define MANAGEMENT_COMMAND     0x0
-    MHD = 0x55,
-        #define GET_MHD_INFO 0x0
-    FMAPI_DCD_MGMT = 0x56,
-        #define GET_DCD_INFO    0x0
-        #define GET_HOST_DC_REGION_CONFIG   0x1
-        #define SET_DC_REGION_CONFIG        0x2
-        #define GET_DC_REGION_EXTENT_LIST   0x3
-        #define INITIATE_DC_ADD             0x4
-        #define INITIATE_DC_RELEASE         0x5
-};
-
 /* CCI Message Format CXL r3.1 Figure 7-19 */
 typedef struct CXLCCIMessage {
     uint8_t category;
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
index 1714f36e8e..3f17779562 100644
--- a/hw/cxl/i2c_mctp_cxl.c
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
+#include "hw/cxl/cxl_mailbox.h"
 
 #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
 
@@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
          */
 
         if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
-              msg->command_set < 0x51) &&
+              msg->command_set < PHYSICAL_SWITCH) &&
             !(msg->message_type == MCTP_MT_CXL_FMAPI &&
-              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+              msg->command_set >= PHYSICAL_SWITCH &&
+              msg->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
             buf->rc = CXL_MBOX_UNSUPPORTED;
             st24_le_p(buf->pl_length, len_out);
             s->len = s->pos;
diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
index aafb9e7e96..b82a269561 100644
--- a/hw/usb/dev-mctp.c
+++ b/hw/usb/dev-mctp.c
@@ -25,6 +25,7 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "net/mctp.h"
+#include "hw/cxl/cxl_mailbox.h"
 
 /* TODO: Move to header */
 
@@ -504,9 +505,10 @@ static void usb_cxl_mctp_handle_data(USBDevice *dev, USBPacket *p)
          * onwards.
          */
         if (!(req->message_type == MCTP_MT_CXL_TYPE3 &&
-              req->command_set < 0x51) &&
+              req->command_set < PHYSICAL_SWITCH) &&
             !(req->message_type == MCTP_MT_CXL_FMAPI &&
-              req->command_set >= 0x51 && req->command_set < 0x56)) {
+              req->command_set >= PHYSICAL_SWITCH &&
+              req->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
             len_out = 0;
             usb_pkt_len = sizeof(MCTPUSBPacket) + sizeof(CXLMCTPMessage) +
                 len_out;
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 820c411cbb..209a11ecbc 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -27,4 +27,77 @@
 #define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
 #define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
 
+enum {
+    INFOSTAT    = 0x00,
+        #define IS_IDENTIFY   0x1
+        #define BACKGROUND_OPERATION_STATUS    0x2
+        #define GET_RESPONSE_MSG_LIMIT         0x3
+        #define SET_RESPONSE_MSG_LIMIT         0x4
+        #define BACKGROUND_OPERATION_ABORT     0x5
+    EVENTS      = 0x01,
+        #define GET_RECORDS   0x0
+        #define CLEAR_RECORDS   0x1
+        #define GET_INTERRUPT_POLICY   0x2
+        #define SET_INTERRUPT_POLICY   0x3
+    FIRMWARE_UPDATE = 0x02,
+        #define GET_INFO      0x0
+        #define TRANSFER      0x1
+        #define ACTIVATE      0x2
+    TIMESTAMP   = 0x03,
+        #define GET           0x0
+        #define SET           0x1
+    LOGS        = 0x04,
+        #define GET_SUPPORTED 0x0
+        #define GET_LOG       0x1
+        #define GET_LOG_CAPABILITIES   0x2
+        #define CLEAR_LOG     0x3
+        #define POPULATE_LOG  0x4
+    FEATURES    = 0x05,
+        #define GET_SUPPORTED 0x0
+        #define GET_FEATURE   0x1
+        #define SET_FEATURE   0x2
+    IDENTIFY    = 0x40,
+        #define MEMORY_DEVICE 0x0
+    CCLS        = 0x41,
+        #define GET_PARTITION_INFO     0x0
+        #define GET_LSA       0x2
+        #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_ALERT_CONFIG 0x1
+        #define SET_ALERT_CONFIG 0x2
+    SANITIZE    = 0x44,
+        #define OVERWRITE     0x0
+        #define SECURE_ERASE  0x1
+        #define MEDIA_OPERATIONS 0x2
+    PERSISTENT_MEM = 0x45,
+        #define GET_SECURITY_STATE     0x0
+    MEDIA_AND_POISON = 0x43,
+        #define GET_POISON_LIST        0x0
+        #define INJECT_POISON          0x1
+        #define CLEAR_POISON           0x2
+        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
+        #define SCAN_MEDIA             0x4
+        #define GET_SCAN_MEDIA_RESULTS 0x5
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
+        #define ADD_DYN_CAP_RSP        0x2
+        #define RELEASE_DYN_CAP        0x3
+    PHYSICAL_SWITCH = 0x51,
+        #define IDENTIFY_SWITCH_DEVICE      0x0
+        #define GET_PHYSICAL_PORT_STATE     0x1
+    TUNNEL = 0x53,
+        #define MANAGEMENT_COMMAND     0x0
+    MHD = 0x55,
+        #define GET_MHD_INFO 0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO    0x0
+        #define GET_HOST_DC_REGION_CONFIG   0x1
+        #define SET_DC_REGION_CONFIG        0x2
+        #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
+    GLOBAL_MEM_ACCESS_EP_MGMT = 0X59,
+};
+
 #endif
-- 
2.47.2


