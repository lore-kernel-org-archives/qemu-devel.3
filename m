Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D7BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyD-0005w0-C1; Wed, 07 May 2025 20:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyA-0005vL-A0
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoy8-0006u7-EE
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-739be717eddso393677b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663511; x=1747268311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtEEVlKYAZUHq7Shr6BrNfaI6Zksrz2ZJCjIoSnfhyM=;
 b=ChlX7b5xEoWqkRRbcNSIRvpW/YlRiQvJZq56V+fOMG4kbAHrB9Tv6KJZCyPyJJgfYO
 XhJNtwKZqA+aXi1FWF299iKPIFbs/E8OAGQQal8Jer22Dtbqr51aNnbAPMg6Sez6M/CU
 dUB4IxRr54PYcVEcCn0o2P8FW+NDcka7YwtgwVW7mryD2Mwzr3GNLNJj1KweoSOXLc+W
 opgc5K+h1ZmZdRE4XlYxC308TPOg+d7R30v6FIfSr9JVRZZ4KolUlbGMnW9iFjuDJFHS
 KrUg8mVE7r2WZxL6DRfKGXjNdLho4tSvAGTCri2EG6GH5zcuE6kgy8ZTQqQfXhgi4S48
 GLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663511; x=1747268311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtEEVlKYAZUHq7Shr6BrNfaI6Zksrz2ZJCjIoSnfhyM=;
 b=vqSxgB0DICqG/VugoRqr1PSorayUE5U/IDOrb0U4fbau/Tvtg5YHkmy/j0dyLTC1P1
 q3RJhryZpthY+2suo0rtSll9stUCNUw1GYxBJCV4CnmZjfMyQLbCkoQ5QJBx2qVIJMnD
 1PXRIVW3Iyy+Em5ELQhfM/xh5FJXGUyeaH/K5PF0nNup+89h/3rdzG3lImsgPZA/pnRI
 r+U+Y8Q5y2eeI8Nd3gZX6y3ft4k/2hVl3pLD0WzaVPeYfTm31eM/HRepnwV/+Lb+0Mbx
 dgmiyFU3+zBBAdcbvQK+FzzEX/cc4Gm8GHtAaTyKP/pZcVbnsYzpq+Hf9ihpNOZb0xUv
 lkNg==
X-Gm-Message-State: AOJu0YxzUSoMrPxmbO7u7/RpWbtT54AWWuJGj+/LE+uPLdlhKE1AWtX8
 TM5ko/nRe/yxFHLkmRmSRrtsRpmXhZ+3zQmpjrJfRvmiMOQUBCDtrZqpMQ==
X-Gm-Gg: ASbGncvSXMb/KmbW8aLz6nsR1WeBbNw5iZf6BIO8wZo/FPOWkJotGl2uIUQvQBvvnoQ
 O/eFxheGVSHJ95YU2Kse9fdHDTRpKoxYGYR9FuCDkg2Ktdd1XLLn++dLgToVk0Bjh/c5FP8+fZ1
 wA/S4xVM5NocbvvUQEzFqNss73dm8RtLgVT5NVmwBbHPNRo5GDIXgXF3uHvVhayKqSqFivH4m65
 NRHzC2V/wP5CGVf2YvvqtEiX6Re0ZJYw31TlELNEZ8L0PmJ0Hv/p42fZAB73AVMCRXRJzXT/XRO
 PGzkdaROs532FxFDCapayBbs9PU6p932tDX03sfN9zIy0rgbYTctE62hgpitRQ==
X-Google-Smtp-Source: AGHT+IEW+VcDLQ+BTFni2xASg6piEcd9nEWvsN+hdF4hLFkmHHJBC95JTvHPmo5Nv1xuzxcW6oC33A==
X-Received: by 2002:a05:6a00:3927:b0:740:9d5f:f542 with SMTP id
 d2e1a72fcca58-7409d5ff567mr6956625b3a.10.1746663510741; 
 Wed, 07 May 2025 17:18:30 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:30 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new header
 file
Date: Thu,  8 May 2025 00:00:57 +0000
Message-ID: <20250508001754.122180-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42d.google.com
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

In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
certain command sets are bound with the correct MCTP binding.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
 include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 66 deletions(-)
 create mode 100644 include/hw/cxl/cxl_opcodes.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a02d130926..ed3294530f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -23,6 +23,7 @@
 #include "qemu/uuid.h"
 #include "system/hostmem.h"
 #include "qemu/range.h"
+#include "hw/cxl/cxl_opcodes.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -36,7 +37,7 @@
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
- *  1. Add the command set and cmd to the enum.
+ *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
  *     FOO    = 0x7f,
  *          #define BAR 0
  *  2. Implement the handler
@@ -59,71 +60,6 @@
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
-};
-
 /* CCI Message Format CXL r3.1 Figure 7-19 */
 typedef struct CXLCCIMessage {
     uint8_t category;
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
new file mode 100644
index 0000000000..26d3a99e8a
--- /dev/null
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -0,0 +1,64 @@
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
+};
-- 
2.47.2


