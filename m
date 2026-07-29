Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0004C55164
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDT0-0007Ac-98; Wed, 29 Jul 2026 19:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HIlqagYKCjMiXijhgVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--titusr.bounces.google.com>)
 id 1wpDSy-00079f-LN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:36 -0400
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HIlqagYKCjMiXijhgVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--titusr.bounces.google.com>)
 id 1wpDSw-0007Hx-LD
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:36 -0400
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cb733fc5024so2081528a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366813; x=1785971613; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FvLCWTuldONgyeVgmj2EEz4jl/z9eb7Nj+jYEh6a67k=;
 b=F5R/C50n8RUGLEYCaDK58duNGo0moYEiNJH3lPFSoJwba08tcUs/WAG4/1sVK55B2m
 1esdw3sejFyhLJPzQ6o3T3dC0kWBttDKqoUp+Gv+vu0/CnVcqjo9HDKFWcP8agYywohb
 rJIu4D6GqK+OPzZ0wANmJy4AsKco5bAudx7t/kq9Nv2JRzkUGJrOZr2I2reL3ZEDbLVd
 FnCVklkO9OtIuL44SflSYaCqSP0LPBmedSqJuftWPbWoFKBJAp7un/z6F8Po5jFGwAKQ
 qRsK6o+/8p38++lhg2wAPpJHyMj5fW1maZAMsiXxgwQSrzQSFazVqittSnqEimP3o2vP
 EC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366813; x=1785971613;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FvLCWTuldONgyeVgmj2EEz4jl/z9eb7Nj+jYEh6a67k=;
 b=C9KDvOQ8RIZli5QuAt3qAK1H/LXXKIPhv/cqT9N+HhuZBuXQFREVT/dhIB81f3bHA+
 QBF4IV4z01mLpGBOelW/Nwkej6XtHLVkr1MZGhq8f8mj9apHzShWKaUYsQIAYMREOCeu
 KcDUH/TVcxStmF6HhivJ2RiD3E8YEWwBF4WE8ZrXGUrHuGNSMogALnxBL4D6rrxf8PCt
 aOzuvOzvx/ivGalN20Mpg9od7QB6R3gDHrovATn2/UGy1D4AxExziDC2DRftfSaiAzWn
 6sp8ec1zGloCHoEbzSSeYTW2uXX4U0b+lb0NXBTR0m8dI0EoXTO3OuYAqUR0VrpvgxrP
 Nqsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjHA4wurlLIm/BSqLju7uxggqVMcJojJ3IvJX8YIg4tQWE9recdFNc/MPbu7RkoBJASpb9sQTEB65l@nongnu.org
X-Gm-Message-State: AOJu0YyIr22VXG60AWNAN+77yGdRwx2AjhZOb+CbMyAtJ5fwRLQ5Z0Tq
 +9UFHDyWOfnQM068As9mQiFvcWCiw+Zf66lWQOB0oTvzpGX2p4aCbFo3IiLXRSv1j6fa2uJRBNs
 2BeaQVA==
X-Received: from dlbur8-n1.prod.google.com
 ([2002:a05:7022:ea48:10b0:139:fea6:ad4])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da9:b0:3c3:8d86:9856
 with SMTP id adf61e73a8af0-3c900478aaamr104040637.14.1785366812756; Wed, 29
 Jul 2026 16:13:32 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:19 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-5-titusr@google.com>
Subject: [PATCH 4/8] hw/sensor: update adm1266 block transfers
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::546;
 envelope-from=3HIlqagYKCjMiXijhgVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--titusr.bounces.google.com;
 helo=mail-pg1-x546.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fixes an issue with reading the MFR_* registers on the ADM1266, this
device has an unconventional access pattern where a block write of
length 1 is written to the MFR_* register with the length of the data
to be read back. Simultaneously, it is possible to write to the contents
of these registers so long as the block write is longer than 1.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c        | 124 ++++++++++++++++++++++++++++++++-----
 tests/qtest/adm1266-test.c |  25 +++++---
 2 files changed, 126 insertions(+), 23 deletions(-)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 37d1cffd57..2979557309 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -37,13 +37,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(ADM1266State, ADM1266)
 #define ADM1266_CAPABILITY_NO_PEC               0x20
 #define ADM1266_PMBUS_REVISION_DEFAULT          0x22
 #define ADM1266_MFR_ID_DEFAULT                  "ADI"
-#define ADM1266_MFR_ID_DEFAULT_LEN              32
 #define ADM1266_MFR_MODEL_DEFAULT               "ADM1266-A1"
-#define ADM1266_MFR_MODEL_DEFAULT_LEN           32
 #define ADM1266_MFR_REVISION_DEFAULT            "25"
-#define ADM1266_MFR_REVISION_DEFAULT_LEN        8
+#define ADM1266_MFR_LOCATION_DEFAULT            "0000"
+#define ADM1266_MFR_DATE_DEFAULT                "0000"
+#define ADM1266_MFR_SERIAL_DEFAULT              "0000"
 
-#define ADM1266_NUM_PAGES               17
+#define ADM1266_NUM_PAGES                       17
+#define ADM1266_READ_LENGTH_DEFAULT             48
 /**
  * PAGE Index
  * Page 0 VH1.
@@ -66,10 +67,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(ADM1266State, ADM1266)
  */
 typedef struct ADM1266State {
     PMBusDevice parent;
+    uint8_t read_length;
 
     char mfr_id[32];
     char mfr_model[32];
     char mfr_rev[8];
+    char mfr_location[48];
+    char mfr_date[16];
+    char mfr_serial[32];
 } ADM1266State;
 
 static const uint8_t adm1266_ic_device_id[] = {0x03, 0x41, 0x12, 0x66};
@@ -95,9 +100,34 @@ static void adm1266_exit_reset(Object *obj, ResetType type)
         pmdev->pages[i].revision = ADM1266_PMBUS_REVISION_DEFAULT;
     }
 
-    strncpy(s->mfr_id, ADM1266_MFR_ID_DEFAULT, 4);
-    strncpy(s->mfr_model, ADM1266_MFR_MODEL_DEFAULT, 11);
-    strncpy(s->mfr_rev, ADM1266_MFR_REVISION_DEFAULT, 3);
+    memcpy(s->mfr_id, ADM1266_MFR_ID_DEFAULT, 4);
+    memcpy(s->mfr_model, ADM1266_MFR_MODEL_DEFAULT, 11);
+    memcpy(s->mfr_rev, ADM1266_MFR_REVISION_DEFAULT, 3);
+    memcpy(s->mfr_location, ADM1266_MFR_LOCATION_DEFAULT, 5);
+    memcpy(s->mfr_date, ADM1266_MFR_DATE_DEFAULT, 5);
+    memcpy(s->mfr_serial, ADM1266_MFR_SERIAL_DEFAULT, 5);
+    s->read_length = ADM1266_READ_LENGTH_DEFAULT;
+}
+
+static void adm1266_send_string(PMBusDevice *pmdev, const char *str)
+{
+    ADM1266State *s = ADM1266(pmdev);
+    size_t len = strlen(str);
+
+    if (s->read_length < len) {
+        len = s->read_length;
+    }
+
+    g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
+    pmdev->out_buf[len + pmdev->out_buf_len] = len;
+
+    for (int i = len - 1; i >= 0; i--) {
+        pmdev->out_buf[i + pmdev->out_buf_len] = str[len - 1 - i];
+    }
+    pmdev->out_buf_len += len + 1;
+
+    /* reset read length */
+    s->read_length = ADM1266_READ_LENGTH_DEFAULT;
 }
 
 static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
@@ -106,15 +136,27 @@ static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
 
     switch (pmdev->code) {
     case PMBUS_MFR_ID:                    /* R/W block */
-        pmbus_send_string(pmdev, s->mfr_id);
+        adm1266_send_string(pmdev, s->mfr_id);
         break;
 
     case PMBUS_MFR_MODEL:                 /* R/W block */
-        pmbus_send_string(pmdev, s->mfr_model);
+        adm1266_send_string(pmdev, s->mfr_model);
         break;
 
     case PMBUS_MFR_REVISION:              /* R/W block */
-        pmbus_send_string(pmdev, s->mfr_rev);
+        adm1266_send_string(pmdev, s->mfr_rev);
+        break;
+
+    case PMBUS_MFR_LOCATION:              /* R/W block */
+        adm1266_send_string(pmdev, s->mfr_location);
+        break;
+
+    case PMBUS_MFR_DATE:                  /* R/W block */
+        adm1266_send_string(pmdev, s->mfr_date);
+        break;
+
+    case PMBUS_MFR_SERIAL:                /* R/W block */
+        adm1266_send_string(pmdev, s->mfr_serial);
         break;
 
     case PMBUS_IC_DEVICE_ID:
@@ -135,6 +177,43 @@ static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
     return 0;
 }
 
+static uint8_t adm1266_receive_block(PMBusDevice *pmdev, uint8_t *dest,
+                                     size_t len)
+{
+    ADM1266State *s = ADM1266(pmdev);
+    uint8_t sent_len;
+
+    /* Exclude command code from return value */
+    pmdev->in_buf++;
+    pmdev->in_buf_len--;
+
+    /* The byte after the command code denotes the length */
+    sent_len = pmdev->in_buf[0];
+
+    /* Block writes with length 1 are read requests */
+    if (sent_len == 1) {
+        s->read_length = pmdev->in_buf[1];
+        return 0;
+    }
+
+    /* exclude length byte */
+    pmdev->in_buf++;
+    pmdev->in_buf_len--;
+
+    /* Be as conservative as possible on how much data to receive */
+    if (pmdev->in_buf_len < len) {
+        len = pmdev->in_buf_len;
+    }
+    if (sent_len < len) {
+        len = sent_len;
+    }
+
+    /* dest may contain data from previous writes */
+    memset(dest, 0, len);
+    memcpy(dest, pmdev->in_buf, len);
+    return len;
+}
+
 static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
                               uint8_t len)
 {
@@ -142,16 +221,31 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
 
     switch (pmdev->code) {
     case PMBUS_MFR_ID:                    /* R/W block */
-        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_id, sizeof(s->mfr_id));
+        adm1266_receive_block(pmdev, (uint8_t *)s->mfr_id, sizeof(s->mfr_id));
         break;
 
     case PMBUS_MFR_MODEL:                 /* R/W block */
-        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_model,
-                            sizeof(s->mfr_model));
+        adm1266_receive_block(pmdev, (uint8_t *)s->mfr_model,
+                              sizeof(s->mfr_model));
         break;
 
     case PMBUS_MFR_REVISION:               /* R/W block*/
-        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_rev, sizeof(s->mfr_rev));
+        adm1266_receive_block(pmdev, (uint8_t *)s->mfr_rev, sizeof(s->mfr_rev));
+        break;
+
+    case PMBUS_MFR_LOCATION:               /* R/W block*/
+        adm1266_receive_block(pmdev, (uint8_t *)s->mfr_location,
+                              sizeof(s->mfr_location));
+        break;
+
+    case PMBUS_MFR_DATE:                   /* R/W block*/
+        adm1266_receive_block(pmdev, (uint8_t *)s->mfr_date,
+                              sizeof(s->mfr_date));
+        break;
+
+    case PMBUS_MFR_SERIAL:                 /* R/W block*/
+        adm1266_receive_block(pmdev, (uint8_t *)s->mfr_serial,
+                              sizeof(s->mfr_serial));
         break;
 
     case ADM1266_SET_RTC:   /* do nothing */
@@ -212,7 +306,7 @@ static void adm1266_init(Object *obj)
 {
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
     uint64_t flags = PB_HAS_VOUT_MODE | PB_HAS_VOUT | PB_HAS_VOUT_MARGIN |
-                     PB_HAS_VOUT_RATING | PB_HAS_STATUS_MFR_SPECIFIC;
+                     PB_HAS_VOUT_RATING;
 
     for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
         pmbus_page_config(pmdev, i, flags);
diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index 726e475938..fa8bbc5795 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -83,20 +83,28 @@ static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
     compare_string(i2cdev, PMBUS_MFR_REVISION, ADM1266_MFR_REVISION_DEFAULT);
 }
 
-/* test r/w registers */
-static void test_rw_regs(void *obj, void *data, QGuestAllocator *alloc)
+static void test_partial_reads(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    /* 1 byte block write requesting 7 byte response */
+    uint8_t req_len[] = {0x01, 0x7};
 
-    /* empty strings */
-    i2c_set8(i2cdev, PMBUS_MFR_ID, 0);
-    compare_string(i2cdev, PMBUS_MFR_ID, "");
+    i2c_write_block(i2cdev, PMBUS_MFR_MODEL, req_len, sizeof(req_len));
+    compare_string(i2cdev, PMBUS_MFR_MODEL, "ADM1266");
 
-    i2c_set8(i2cdev, PMBUS_MFR_MODEL, 0);
+    req_len[1] = 0;
+    i2c_write_block(i2cdev, PMBUS_MFR_MODEL, req_len, sizeof(req_len));
     compare_string(i2cdev, PMBUS_MFR_MODEL, "");
 
-    i2c_set8(i2cdev, PMBUS_MFR_REVISION, 0);
-    compare_string(i2cdev, PMBUS_MFR_REVISION, "");
+    req_len[1] = 100;
+    i2c_write_block(i2cdev, PMBUS_MFR_MODEL, req_len, sizeof(req_len));
+    compare_string(i2cdev, PMBUS_MFR_MODEL, ADM1266_MFR_MODEL_DEFAULT);
+}
+
+/* test r/w registers */
+static void test_rw_regs(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
 
     /* test strings */
     write_and_compare_string(i2cdev, PMBUS_MFR_ID, TEST_STRING_A,
@@ -118,6 +126,7 @@ static void adm1266_register_nodes(void)
     qos_node_consumes("adm1266", "i2c-bus", &opts);
 
     qos_add_test("test_defaults", "adm1266", test_defaults, NULL);
+    qos_add_test("test_partial_reads", "adm1266", test_partial_reads, NULL);
     qos_add_test("test_rw_regs", "adm1266", test_rw_regs, NULL);
 }
 
-- 
2.55.0.508.g3f0d502094-goog


