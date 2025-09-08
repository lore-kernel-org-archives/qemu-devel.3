Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42415CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvfTv-00057B-UO; Mon, 08 Sep 2025 13:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WA-_aAYKCr8ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1uvfTe-000514-Ck
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:16:29 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WA-_aAYKCr8ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com>)
 id 1uvfTW-0005OL-GJ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:16:25 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b4fbb90b453so7710007a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757351768; x=1757956568; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VNYIVDvtOTLoFw5kAwHYr05cuqE9shmn8ek3if2fSJw=;
 b=AofZUyYue+m7zumEUYreiesNNN+jI9M0OfQsjjAE5GgWMdbo6Pqi1qnGB4y5MM+P5f
 6JizubNw/xY2xo6cuYCbItxsek5dl0tqaLasVeolWfFdyLfGZHPrCEKUwtA7Vg0E3s5P
 2AaogEv2buh+jKTOfJFxJmPR14X+SPp9Rhu3dupT/8CQJMV70l76IrFHMpmtJ8LmbO8r
 qhigAbC3WNSgs5JjZE1wxOff2ePdHekDaghDcZPUm0TpGf/HXDEsXuohFTpvD5ZDTdtS
 ANhdF+zuauuIUeirPN8j4sxAJ7JK3XWafY7R0X93fQYaGc268QRkm/rr8+2vfnKiXpzI
 0Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757351768; x=1757956568;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNYIVDvtOTLoFw5kAwHYr05cuqE9shmn8ek3if2fSJw=;
 b=TyZirItVOimsMsLqhoyr89PZt58cXHmM9RWWwz4HTWI1YJnEQluDnyD7SXEMHsOQZj
 DJZgmjaky4U08uy/3lhC7fZaJCEW8dyNHMtJTV+Uj47QCoo5sFZpA5NZkCNbuANKC7z7
 8iSLhD7jc84bJCzh8C6EpVj/scXs0GQGnR3bTXDOYu1yfNGVtn/U9XVHePd5GRXVg6Lu
 AUNDHSvpKIzcposUlOKtK/SxLIxpY/5Aq3k560q86tUBAraYOQYWN4BINSLfTXtqYWoX
 WoN0eIA7eP6erlY0i6n443+RTWlim5ElAM3714928IijhRFPSoR5CVXOqFEtQr7Qgfrf
 pSDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNEGCm+iS3tnKAmNo8r9V/jqbVqf3RiQN/HLWlXiiMO8iCySrCITb3ZODAaJiCxry91U5UXv6Cy2ga@nongnu.org
X-Gm-Message-State: AOJu0Yx2peQcN3wu8+z591Ko3hB4ZTfKKsHyQBhZPLR4OspfnkKoO28w
 zKufhpEoJhHQCMIEckXB454P6Bw50lf/ZLSeVa4jBSgv+0n24xdWaR9FipvmUXUR14Z7ZKyzPuk
 FM/xX0A==
X-Google-Smtp-Source: AGHT+IHCL2kt1NdehIIvbR6ildnVbSPLw/OoGxZ1uu/4Evg91qWt67+wP9Kmhw8LcyE/d150jg8eJbD0rm8=
X-Received: from pjbpl13.prod.google.com ([2002:a17:90b:268d:b0:325:9fa7:5d07])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f78f:b0:249:17d2:ca04
 with SMTP id d9443c01a7336-2517057f887mr110471915ad.23.1757351768644; Mon, 08
 Sep 2025 10:16:08 -0700 (PDT)
Date: Mon,  8 Sep 2025 17:15:57 +0000
In-Reply-To: <20250908171557.1510538-1-titusr@google.com>
Mime-Version: 1.0
References: <20250908171557.1510538-1-titusr@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908171557.1510538-2-titusr@google.com>
Subject: [PATCH 2/2] hw/sensor: adm1266: add blackbox read and clear support
From: Titus Rwantare <titusr@google.com>
To: philmd@linaro.org, wuhaotsh@google.com, bhillier@google.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3WA-_aAYKCr8ynyzxwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--titusr.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This commit adds some support for blackbox reads and clearing,
triggering writes to the blackbox based on the sensor status is not yet
implemented.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c         | 139 ++++++++++++++++++++----------------
 include/hw/sensor/adm1266.h | 102 ++++++++++++++++++++++++++
 tests/qtest/adm1266-test.c  |  90 +++++++++++++++++------
 3 files changed, 247 insertions(+), 84 deletions(-)
 create mode 100644 include/hw/sensor/adm1266.h

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 1112f78d19..e259bb4d67 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -10,77 +10,31 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i2c/pmbus_device.h"
+#include "hw/sensor/adm1266.h"
+
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/timer.h"
 
-#define TYPE_ADM1266 "adm1266"
-OBJECT_DECLARE_SIMPLE_TYPE(ADM1266State, ADM1266)
-
-#define ADM1266_BLACKBOX_CONFIG                 0xD3
-#define ADM1266_PDIO_CONFIG                     0xD4
-#define ADM1266_READ_STATE                      0xD9
-#define ADM1266_READ_BLACKBOX                   0xDE
-#define ADM1266_SET_RTC                         0xDF
-#define ADM1266_GPIO_SYNC_CONFIGURATION         0xE1
-#define ADM1266_BLACKBOX_INFORMATION            0xE6
-#define ADM1266_PDIO_STATUS                     0xE9
-#define ADM1266_GPIO_STATUS                     0xEA
-
-/* Defaults */
-#define ADM1266_OPERATION_DEFAULT               0x80
-#define ADM1266_CAPABILITY_DEFAULT              0xA0
-#define ADM1266_CAPABILITY_NO_PEC               0x20
-#define ADM1266_PMBUS_REVISION_DEFAULT          0x22
-#define ADM1266_MFR_ID_DEFAULT                  "ADI"
-#define ADM1266_MFR_ID_DEFAULT_LEN              32
-#define ADM1266_MFR_MODEL_DEFAULT               "ADM1266-A1"
-#define ADM1266_MFR_MODEL_DEFAULT_LEN           32
-#define ADM1266_MFR_REVISION_DEFAULT            "25"
-#define ADM1266_MFR_REVISION_DEFAULT_LEN        8
-
-#define ADM1266_NUM_PAGES               17
-/**
- * PAGE Index
- * Page 0 VH1.
- * Page 1 VH2.
- * Page 2 VH3.
- * Page 3 VH4.
- * Page 4 VP1.
- * Page 5 VP2.
- * Page 6 VP3.
- * Page 7 VP4.
- * Page 8 VP5.
- * Page 9 VP6.
- * Page 10 VP7.
- * Page 11 VP8.
- * Page 12 VP9.
- * Page 13 VP10.
- * Page 14 VP11.
- * Page 15 VP12.
- * Page 16 VP13.
- */
-typedef struct ADM1266State {
-    PMBusDevice parent;
-
-    char mfr_id[32];
-    char mfr_model[32];
-    char mfr_rev[8];
-} ADM1266State;
 
 static const uint8_t adm1266_ic_device_id[] = {0x03, 0x41, 0x12, 0x66};
 static const uint8_t adm1266_ic_device_rev[] = {0x08, 0x01, 0x08, 0x07, 0x0,
                                                 0x0, 0x07, 0x41, 0x30};
-static const uint8_t adm1266_blackbox_info[] = {
-    0x04,       /* length */
-    0x00, 0x00, /* latest ID */
-    0x00,       /* latest record index */
-    0x00        /* latest record count */
-};
+
+static void adm1266_clear_blackbox(ADM1266State *s)
+{
+    memset(s->blackbox_records, 0, sizeof(s->blackbox_records));
+    for (int i = 0; i < ADM1266_BLACKBOX_RECORD_NUM_MAX; i++) {
+        s->blackbox_records[i].flags = ADM1266_RECORD_EMPTY;
+    }
+    s->blackbox_info.record_count = 0;
+    s->blackbox_info.logic_index = 0;
+}
 
 static void adm1266_exit_reset(Object *obj, ResetType type)
 {
@@ -101,6 +55,18 @@ static void adm1266_exit_reset(Object *obj, ResetType type)
         pmdev->pages[i].revision = ADM1266_PMBUS_REVISION_DEFAULT;
     }
 
+    adm1266_clear_blackbox(s);
+    for (int i = 0; i < ADM1266_RECORD_COUNT_DEFAULT; i++) {
+        s->blackbox_records[i].id = cpu_to_le16(i);
+        s->blackbox_records[i].flags = ADM1266_RECORD_USED;
+        s->blackbox_records[i].powerup_counter = cpu_to_le16(i);
+        s->blackbox_records[i].timestamp =
+            cpu_to_le64((qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000) << 8);
+        s->blackbox_info.logic_index = i;
+    }
+    s->partial_read = false;
+    s->blackbox_info.record_count = ADM1266_RECORD_COUNT_DEFAULT;
+
     strncpy(s->mfr_id, ADM1266_MFR_ID_DEFAULT, 4);
     strncpy(s->mfr_model, ADM1266_MFR_MODEL_DEFAULT, 11);
     strncpy(s->mfr_rev, ADM1266_MFR_REVISION_DEFAULT, 3);
@@ -109,6 +75,7 @@ static void adm1266_exit_reset(Object *obj, ResetType type)
 static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
 {
     ADM1266State *s = ADM1266(pmdev);
+    uint8_t *raw_record;
 
     switch (pmdev->code) {
     case PMBUS_MFR_ID:                    /* R/W block */
@@ -132,14 +99,29 @@ static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
         break;
 
     case ADM1266_BLACKBOX_CONFIG:
+        pmbus_send16(pmdev, s->blackbox_config &
+                     ADM1266_BLACKBOX_CONFIG_CYCLIC);
         break;
 
     case ADM1266_READ_BLACKBOX:
+        raw_record =
+                (uint8_t *)&s->blackbox_records[s->blackbox_info.logic_index];
+        /* The full black box record exceeds SMBUS_DATA_MAX_LEN */
+        if (!s->partial_read) {
+            s->partial_read = true;
+        } else {
+            raw_record += sizeof(ADM1266BlackboxRecord) / 2;
+            s->partial_read = false;
+        }
+        pmbus_send(pmdev, raw_record,
+                   sizeof(ADM1266BlackboxRecord) / 2);         /* data */
+        pmbus_send8(pmdev, sizeof(ADM1266BlackboxRecord) / 2); /* len */
         break;
 
     case ADM1266_BLACKBOX_INFORMATION:
-        pmbus_send(pmdev, adm1266_blackbox_info,
-                   sizeof(adm1266_blackbox_info));
+        pmbus_send(pmdev, (const uint8_t *)&s->blackbox_info,
+                   sizeof(s->blackbox_info));            /* data */
+        pmbus_send8(pmdev, sizeof(ADM1266BlackboxInfo)); /* len */
         break;
 
     default:
@@ -156,6 +138,7 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
                               uint8_t len)
 {
     ADM1266State *s = ADM1266(pmdev);
+    uint8_t blackbox_request[2];
 
     switch (pmdev->code) {
     case PMBUS_MFR_ID:                    /* R/W block */
@@ -172,8 +155,40 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
         break;
 
     case ADM1266_BLACKBOX_CONFIG:
+        s->blackbox_config = pmbus_receive16(pmdev) &
+                                ADM1266_BLACKBOX_CONFIG_CYCLIC;
+        break;
+
+    /*
+     * Writes to READ_BLACKBOX come in two forms.
+     * Read requests are a two byte block write, {0x1, record_index}
+     * Clearing records is a three byte block write, {0x2, 0xFE, 0x00}
+     */
     case ADM1266_READ_BLACKBOX:
+        blackbox_request[0] = pmbus_receive_block(pmdev,
+                                (uint8_t *)&blackbox_request[1],
+                                sizeof(blackbox_request));
+        if (blackbox_request[0] == 1) {
+            s->blackbox_info.logic_index = blackbox_request[1];
+            s->partial_read = false;
+            break;
+        }
+        /* erase blackbox records */
+        if (blackbox_request[0] == 2 && blackbox_request[1] == 0xFE) {
+            adm1266_clear_blackbox(s);
+            break;
+        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid write to READ_BLACKBOX: 0x%02x%02x",
+                      __func__, blackbox_request[0], blackbox_request[1]);
+        break;
+
     case ADM1266_BLACKBOX_INFORMATION:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only register",
+                      __func__);
+        break;
+
     case ADM1266_SET_RTC:   /* do nothing */
         break;
 
diff --git a/include/hw/sensor/adm1266.h b/include/hw/sensor/adm1266.h
new file mode 100644
index 0000000000..67b78e6ffe
--- /dev/null
+++ b/include/hw/sensor/adm1266.h
@@ -0,0 +1,102 @@
+/*
+ * Analog Devices ADM1266 Cascadable Super Sequencer with Margin Control and
+ * Fault Recording with PMBus
+ *
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/adm1266.pdf
+ *
+ * Copyright 2023 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SENSOR_ADM1266_H
+#define HW_SENSOR_ADM1266_H
+
+#include "hw/i2c/pmbus_device.h"
+
+#define TYPE_ADM1266 "adm1266"
+OBJECT_DECLARE_SIMPLE_TYPE(ADM1266State, ADM1266)
+
+#define ADM1266_BLACKBOX_CONFIG                 0xD3
+#define     ADM1266_BLACKBOX_CONFIG_CYCLIC      0x01
+#define ADM1266_PDIO_CONFIG                     0xD4
+#define ADM1266_READ_STATE                      0xD9
+#define ADM1266_READ_BLACKBOX                   0xDE
+#define ADM1266_SET_RTC                         0xDF
+#define ADM1266_GPIO_SYNC_CONFIGURATION         0xE1
+#define ADM1266_BLACKBOX_INFORMATION            0xE6
+#define ADM1266_PDIO_STATUS                     0xE9
+#define ADM1266_GPIO_STATUS                     0xEA
+
+/* Defaults */
+#define ADM1266_OPERATION_DEFAULT               0x80
+#define ADM1266_CAPABILITY_DEFAULT              0xA0
+#define ADM1266_CAPABILITY_NO_PEC               0x20
+#define ADM1266_PMBUS_REVISION_DEFAULT          0x22
+#define ADM1266_MFR_ID_DEFAULT                  "ADI"
+#define ADM1266_MFR_ID_DEFAULT_LEN              32
+#define ADM1266_MFR_MODEL_DEFAULT               "ADM1266-A1"
+#define ADM1266_MFR_MODEL_DEFAULT_LEN           32
+#define ADM1266_MFR_REVISION_DEFAULT            "25"
+#define ADM1266_MFR_REVISION_DEFAULT_LEN        8
+#define ADM1266_RECORD_COUNT_DEFAULT            8
+
+#define ADM1266_NUM_PAGES                       17
+
+typedef struct ADM1266BlackboxInfo {
+#define ADM1266_BLACKBOX_INFO_LEN         4
+    uint8_t id;
+    uint8_t reserved;
+    uint8_t logic_index; /* Index of the last record read/written */
+    uint8_t record_count;
+} QEMU_PACKED ADM1266BlackboxInfo;
+QEMU_BUILD_BUG_ON(sizeof(ADM1266BlackboxInfo) != ADM1266_BLACKBOX_INFO_LEN);
+
+/* All the entries in the blackbox record are little-endian */
+typedef struct ADM1266BlackboxRecord {
+#define ADM1266_BLACKBOX_RECORD_LEN             64
+#define ADM1266_BLACKBOX_RECORD_NUM_MAX         32
+    uint16_t id;
+#define ADM1266_RECORD_USED     0
+#define ADM1266_RECORD_EMPTY    1
+    uint8_t flags;
+    uint8_t action_index;
+    uint8_t rule_index;
+    uint8_t voltage_status;     /* Undervoltage or overvoltage status */
+    uint16_t current_state;
+    uint16_t last_state;
+    uint16_t vp_ov_status;      /* Overvoltage status of the VPx pins */
+    uint16_t vp_uv_status;      /* Undervoltage status of the VPx pins */
+    uint16_t gpio_in_status;
+    uint16_t gpio_out_status;
+    uint16_t pdio_in_status;
+    uint16_t pdio_out_status;
+    uint16_t powerup_counter;
+    uint64_t timestamp;
+    uint8_t reserved[31];
+    uint8_t crc;
+} QEMU_PACKED ADM1266BlackboxRecord;
+QEMU_BUILD_BUG_ON(sizeof(ADM1266BlackboxRecord) != ADM1266_BLACKBOX_RECORD_LEN);
+
+typedef struct ADM1266State {
+    PMBusDevice parent;
+
+    char mfr_id[32];
+    char mfr_model[32];
+    char mfr_rev[8];
+
+    /* Blackbox state */
+    bool partial_read;
+    uint8_t record_index;
+    uint16_t blackbox_config;
+    ADM1266BlackboxInfo blackbox_info;
+    /*
+     * In single mode, the black box can store up to 32 fault records. When
+     * full,no writes are accepted until the records are erased.
+     * In cyclic mode, we still have 32 records, but they are overwritten in a
+     * circular buffer.
+     */
+    ADM1266BlackboxRecord blackbox_records[ADM1266_BLACKBOX_RECORD_NUM_MAX];
+} ADM1266State;
+
+#endif /* HW_SENSOR_ADM1266_H */
diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index 5ae8206234..04b74b0ccb 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -8,11 +8,13 @@
  */
 
 #include "qemu/osdep.h"
-#include <math.h>
+#include "hw/sensor/adm1266.h"
+
 #include "hw/i2c/pmbus_device.h"
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
+#include "qemu/bswap.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
 #include "qemu/bitops.h"
@@ -20,27 +22,6 @@
 #define TEST_ID "adm1266-test"
 #define TEST_ADDR (0x12)
 
-#define ADM1266_BLACKBOX_CONFIG                 0xD3
-#define ADM1266_PDIO_CONFIG                     0xD4
-#define ADM1266_READ_STATE                      0xD9
-#define ADM1266_READ_BLACKBOX                   0xDE
-#define ADM1266_SET_RTC                         0xDF
-#define ADM1266_GPIO_SYNC_CONFIGURATION         0xE1
-#define ADM1266_BLACKBOX_INFORMATION            0xE6
-#define ADM1266_PDIO_STATUS                     0xE9
-#define ADM1266_GPIO_STATUS                     0xEA
-
-/* Defaults */
-#define ADM1266_OPERATION_DEFAULT               0x80
-#define ADM1266_CAPABILITY_DEFAULT              0xA0
-#define ADM1266_CAPABILITY_NO_PEC               0x20
-#define ADM1266_PMBUS_REVISION_DEFAULT          0x22
-#define ADM1266_MFR_ID_DEFAULT                  "ADI"
-#define ADM1266_MFR_ID_DEFAULT_LEN              32
-#define ADM1266_MFR_MODEL_DEFAULT               "ADM1266-A1"
-#define ADM1266_MFR_MODEL_DEFAULT_LEN           32
-#define ADM1266_MFR_REVISION_DEFAULT            "25"
-#define ADM1266_MFR_REVISION_DEFAULT_LEN        8
 #define TEST_STRING_A                           "a sample"
 #define TEST_STRING_B                           "b sample"
 #define TEST_STRING_C                           "rev c"
@@ -105,6 +86,70 @@ static void test_rw_regs(void *obj, void *data, QGuestAllocator *alloc)
                              sizeof(TEST_STRING_C));
 }
 
+static void read_blackbox(QI2CDevice *i2cdev, ADM1266BlackboxRecord *record,
+                          uint8_t index)
+{
+    /* record is sent in two halves + len */
+    uint8_t buf[2][(sizeof(ADM1266BlackboxRecord) / 2) + 1];
+    uint8_t read_request[] = {0x1, index};
+
+    i2c_write_block(i2cdev, ADM1266_READ_BLACKBOX, read_request,
+                    sizeof(read_request));
+    i2c_read_block(i2cdev, ADM1266_READ_BLACKBOX, buf[0], sizeof(buf[0]));
+    i2c_read_block(i2cdev, ADM1266_READ_BLACKBOX, buf[1], sizeof(buf[1]));
+    /* verify lengths */
+    g_assert_cmpuint(buf[0][0] + buf[1][0], ==, sizeof(ADM1266BlackboxRecord));
+
+    memcpy(record, &buf[0][1], sizeof(buf[0]) - 1);
+    /* all the bytes in the second half are unused except the last one */
+    record->crc = buf[1][sizeof(buf[1]) - 1];
+}
+
+/* test blackbox records */
+static void test_blackbox(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    uint8_t bb_info_buf[5];
+    ADM1266BlackboxRecord blackbox_record;
+    ADM1266BlackboxInfo *blackbox_info =
+        (ADM1266BlackboxInfo *)(bb_info_buf + 1);
+    uint8_t clear_request[] = {0x2, 0xFE, 0x00};
+    uint8_t final_record;
+
+    /* First, the blackbox shouldn't be empty, read blackbox information */
+    i2c_read_block(i2cdev, ADM1266_BLACKBOX_INFORMATION, bb_info_buf,
+                   sizeof(bb_info_buf));
+    g_assert_cmpuint(bb_info_buf[0], ==, ADM1266_BLACKBOX_INFO_LEN);
+    g_assert_cmpuint(blackbox_info->record_count, >, 0);
+    g_assert_cmpuint(blackbox_info->logic_index, <,
+                     blackbox_info->record_count);
+
+    /* Get one of the records and check its index */
+    /* Read final record */
+    final_record = blackbox_info->record_count - 1;
+    read_blackbox(i2cdev, &blackbox_record, final_record);
+
+    /* Verify record ID matches what we expect */
+    g_assert_cmpuint(le16_to_cpu(blackbox_record.id), ==, final_record);
+
+    /* flags should be USED initially */
+    g_assert_cmpuint(blackbox_record.flags, ==, ADM1266_RECORD_USED);
+
+    /* Test clearing blackbox records */
+    i2c_write_block(i2cdev, ADM1266_READ_BLACKBOX, clear_request,
+                    sizeof(clear_request));
+
+    /* Check info, record count should now be zero */
+    i2c_read_block(i2cdev, ADM1266_BLACKBOX_INFORMATION, bb_info_buf,
+                   sizeof(bb_info_buf));
+    g_assert_cmpuint(bb_info_buf[0], ==, ADM1266_BLACKBOX_INFO_LEN);
+    g_assert_cmpuint(blackbox_info->record_count, ==, 0);
+
+    /* Read the same record again to verify the record is flagged as empty */
+    read_blackbox(i2cdev, &blackbox_record, final_record);
+    g_assert_cmpuint(blackbox_record.flags, ==, ADM1266_RECORD_EMPTY);
+}
+
 static void adm1266_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -117,6 +162,7 @@ static void adm1266_register_nodes(void)
 
     qos_add_test("test_defaults", "adm1266", test_defaults, NULL);
     qos_add_test("test_rw_regs", "adm1266", test_rw_regs, NULL);
+    qos_add_test("test_blackbox", "adm1266", test_blackbox, NULL);
 }
 
 libqos_init(adm1266_register_nodes);
-- 
2.51.0.384.g4c02a37b29-goog


