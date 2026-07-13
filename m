Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6089AC44508
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIee-0000TC-KM; Mon, 13 Jul 2026 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeI-0008S5-7O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeE-00017t-AZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso23018175e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956763; x=1784561563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VC8sQ+SMCrEOYxrNAc0ev6zmslc6XhHuNvrX81rsigU=;
 b=Cu7Bl50+Iaqbk4ko1wBLntj5No8NLRIPaAJSel38kEmbTJoKw7pxhpqhg+9yDpDOUX
 B8QrJxT6krbqPgJ9i1MZ/3reOq3PkafQzcOey8PJgFShlW3NimJHK375RsDUycrnjebD
 AGa0YFwL/xRDHQmJEqj5yRqMFwssKyWok5oZIBN6t2TBjXmKklNxXrksWbNsYRfL0RxB
 guClMt5iFdf7EJSOghUZ7C8OwTxtalgNbiro1g6G3k+UjScysx5LPD9SWevLgroU1EAT
 px7P6+aMtQJkGoyNtU5amRdJ+unJYh0pQ70Thn/wls02VDDAr0AvLS16WlaeE58VsHt+
 NWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956763; x=1784561563;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VC8sQ+SMCrEOYxrNAc0ev6zmslc6XhHuNvrX81rsigU=;
 b=HEvvv8L28iRADrOmzZrEcdirErWbI6GFnVxJcyVeRrbRwQxgxorK7UdDQG0VsmaoG1
 YRCUy1V884fL4qvWEl9jFYJHK0YrG0DGdPsnM6VLocWpuiwESDVTzJlk2O7I0zhDQVdN
 lPSyGvkhpS7tWbCePHj+/UQyIk1CayvdB0ctTgXkz/lMQLLA/0Hyw8uROIeZx4ISri/D
 IKk+7jYdH6MMcWXLG3wmub5gFE2J77gdXiMzTIrREalaYtJY/V8ODqx/Nd/m0+H6/M3/
 esBZwYSkYofZhqE5HHekKh3k+9eNElqOQi8Hbr2hbxoWxF9cL3ILT3Fu8w+UQzhhb/NN
 8pxg==
X-Gm-Message-State: AOJu0YxNmRs3T3ziT6fF21bXUwj2KQlPtModAQnCvScZH44jN+Qh2RJk
 gu4ZW93btdeJr7SVmzKcY6Y7Q1za1x1NftGgl3O/qEmIzT0GDbDoZ+XD0jAn/AwqDwChIyLzrK6
 jZgdG2zK3cA==
X-Gm-Gg: AfdE7cl29xpvEzKVhwtMfqrxmKngGqDL3k9JlsLRsQ5oCtXKR4/3iL0WOjscxVSlk2q
 UfCs+FrPnTUmIH9lL29OpMobEjlHnStO3uvmxkIpvzDK7iVW4ZYDFpslSex+6bbWv3xIcRK3WuU
 rYA+6l+jHzK302EFelrzGBpXzJ0OZ0clPoCkdufEavNrp3p0olHS9NIptgGr9pZEOuiZnd1MmCr
 HZQckbq1jsp5SnxyEYBKvCYqtsaLiydSvscL0RrWW1xX9AZ53Elr80Klwge3toTkJdnVuFoVN2V
 uSyvtW4AwAfpzMX9l23al8Z29puOSxcBG607vGSpnhf2uSTEeETn9hoX19K23owOt6mKQiLdpWy
 7UO9xO/2hHzeORk714UxeIWxdf8twm8iWmyBFfDh4fqdAQ3WH4zsrjrjjsIbSdm+xf7zvCPiIiw
 fpRz0ODi0B26GdGQ4+iTn4yHK50sI1lXWvgUsVmDLUwlIJO9xZymExyPTtKRiQOPFOq07xsp9F8
 /p+cq+N8ZoIaA95y1EmIQ==
X-Received: by 2002:a05:600c:2d56:b0:493:f639:9b2f with SMTP id
 5b1f17b1804b1-493f8834f8amr63655375e9.39.1783956762785; 
 Mon, 13 Jul 2026 08:32:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/26] hw/i2c: pmbus: clear output buffer on write
Date: Mon, 13 Jul 2026 16:32:15 +0100
Message-ID: <20260713153233.3391818-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260706230056.1888992-4-titusr@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/pmbus_device.c      | 10 ++++++++++
 tests/qtest/adm1266-test.c | 10 ++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index b1f9843f52e..1ca117bd3c1 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1245,6 +1245,16 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
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
index 5ae82062342..726e4759380 100644
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
2.43.0


