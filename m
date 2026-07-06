Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642C9C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgsJH-0001SN-Ie; Mon, 06 Jul 2026 19:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rjNMagYKCp8SHSTRQFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--titusr.bounces.google.com>)
 id 1wgsJG-0001RL-HA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:06 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rjNMagYKCp8SHSTRQFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--titusr.bounces.google.com>)
 id 1wgsJF-00073l-0o
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:06 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-38108fb9d83so2366332a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783378863; x=1783983663; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hW0rGKNwKHNOYrweI11OJbXK2kFKxm3bSkURBVVUrfQ=;
 b=TDf4fBvJPbNsq8fotjUQp+M93mQTBSurmNbQniiyX0Z3U+KJ5ib+hcWUO1z9iauRjh
 nLTq7UV0ZgBr7qJBI1JhJUkW75jd4R3X22BeJe1TRhKH9bddU99RnDHL49NM+MEv7NRR
 cUiMe5H/K1hYzRnrYPsMCqA7OaRxB4aRyxepYZPOh06eCxMf6oDOSdPIlAWssCQcSuy3
 hL4V5FPUxQdZD6ol4zpJKNm4LYK++CqF+TJt5YeuDEKIa//CwxGG9Ar+w6p6wG8p4dOX
 nsvVSXS21zxX5rnYjEBYQeVpGhPRzps7C68CODaIYGpg0mMtVhznR4uFl07QFID1qRcG
 DGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783378863; x=1783983663;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hW0rGKNwKHNOYrweI11OJbXK2kFKxm3bSkURBVVUrfQ=;
 b=sA5O7jV4ICO0Ufb62JUK2EL0kOU6UwsJZW3KowRUqSohi3oVIY2RXXpTCtfJjX/XOb
 TS+PAjVsSmlZeCWzYCQV3NFS8HAWGrCi+dWjgAcY95poZLcl6YXpAh/1+8K8z4OfqqqD
 8YceArUUnKVFjfmcbHtN7v3lqxztdD+8pdGA3K9pnWvwgCpTvxBv1BjTV4gvtoVcsbV3
 i7izor3s1fs6K65PgOHwEB4j99NNoj9YyIPJN2XWi5C/nIKuhJ/TXgfw9G6foUx8jmaj
 tURRmP0GSbOnomh7W8x+/tWSP9Ls8AYAWNv4Hv20yVJT3Lq5xTb2ZzH2oA1bm3KgJKfk
 nUJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rom0+yBXgObb2jUk/QhTx7nHjhmsjT+qKF5JY0UpGTmqIKYJdJ5nKMZ6EaOFEpmbXK6fqU/uw8h3YYA@nongnu.org
X-Gm-Message-State: AOJu0Yx3HtUrfgT+zdI6CeIDF+FFieI67cdUfZCYaTn+a0ymiNfSJLuT
 5+PYtVWSnp9wm0TAfnz5vDFxqFr9Pw0PiJcipP1UtgkLio7KeMZAsbzdcusGdC17kIEg/MVc74N
 4N7A0lA==
X-Received: from dycui10.prod.google.com
 ([2002:a05:693c:600a:b0:311:525b:8fc9])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:562c:b0:37e:2005:6507
 with SMTP id 98e67ed59e1d1-38755d3f07bmr2642826a91.15.1783378862518; Mon, 06
 Jul 2026 16:01:02 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:00:52 +0000
In-Reply-To: <20260706230056.1888992-1-titusr@google.com>
Mime-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230056.1888992-4-titusr@google.com>
Subject: [PATCH 3/5] hw/i2c: pmbus: clear output buffer on write
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 titusr <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3rjNMagYKCp8SHSTRQFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--titusr.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: titusr <titusr@google.com>

Generally we expect a PMBus sensor to issue writes after all pending
reads have completed. If a data read needs to be resumed, this state can
be tracked in the device model and the pending data placed in the output
buffer.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/pmbus_device.c      | 10 ++++++++++
 tests/qtest/adm1266-test.c | 10 ++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index e2e1e0e945..8befc27895 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1284,6 +1284,16 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
     pmdev->in_buf_len = len;
     pmdev->in_buf = buf;
 
+    /* clear the output buffer on any new write transaction */
+    if (pmdev->out_buf_len != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: previous read was not completed, %d bytes dropped\n",
+                      __func__, pmdev->out_buf_len);
+
+        pmdev->out_buf_len = 0;
+        memset(pmdev->out_buf, 0, sizeof(pmdev->out_buf));
+    }
+
     pmdev->code = buf[0]; /* PMBus command code */
 
     if (pmdev->code == PMBUS_CLEAR_FAULTS) {
diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index 5ae8206234..726e475938 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -48,11 +48,13 @@
 static void compare_string(QI2CDevice *i2cdev, uint8_t reg,
                            const char *test_str)
 {
-    uint8_t len = i2c_get8(i2cdev, reg);
-    char i2c_str[SMBUS_DATA_MAX_LEN] = {0};
+    uint8_t expected_len = strlen(test_str);
+    uint8_t resp[SMBUS_DATA_MAX_LEN] = {0};
 
-    i2c_read_block(i2cdev, reg, (uint8_t *)i2c_str, len);
-    g_assert_cmpstr(i2c_str, ==, test_str);
+    g_assert(expected_len + 1 < SMBUS_DATA_MAX_LEN);
+    i2c_read_block(i2cdev, reg, resp, expected_len + 1);
+    g_assert_cmpint(resp[0], ==, expected_len);
+    g_assert_cmpstr((char *)resp + 1, ==, test_str);
 }
 
 static void write_and_compare_string(QI2CDevice *i2cdev, uint8_t reg,
-- 
2.55.0.rc2.803.g1fd1e6609c-goog


