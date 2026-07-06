Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67060C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgsJG-0001Rf-N3; Mon, 06 Jul 2026 19:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rTNMagYKCp4RGRSQPEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--titusr.bounces.google.com>)
 id 1wgsJF-0001Ph-5q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:05 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rTNMagYKCp4RGRSQPEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--titusr.bounces.google.com>)
 id 1wgsJD-00073a-9m
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:04 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c88da04b719so2819398a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783378862; x=1783983662; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m/PAM6KHxAEnovgWt0N1vdKaX4s46SRBVL3bS+2xlns=;
 b=JEpexdLTMkjmI5n6r+gYDB+r2I7PC+tZzis/chga2Z0GlNM1yxj8MRjD6R5OKDM99s
 lpMPzKfEAPynuRiQKbXclAK7Rd0ACIyTDXhM5Rz77nZPwmd2B7aF1AGBQEIIN+EGzdry
 ZZIH81ISCwm2+hANOLtqqsW3m+U0sOmhrfQM3n1eNkQYlYUAe2xFYtPtKZAKXAUCyCpP
 IIrxBlEtSa9a95IyKQBMar6adb2KYw04UuKScmIMqS132eOK0+k4ooRo6nF9pkUqjFCl
 bYkRFWiPGl/IRpjGp5WCn88V16GEXZOok6eMQ0YByzpZd0d6FpDczaqDsTOZEJn8FP1r
 VZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783378862; x=1783983662;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m/PAM6KHxAEnovgWt0N1vdKaX4s46SRBVL3bS+2xlns=;
 b=jXddYRFbxzoBfbJuO9Gs91OdL2roqOZrQDqxizsb5HAylDpb3/F37V/pjZMFqemi+8
 b3MGk7CNEk/heRcw+UEzLNfHVRdPAFJm+rlM+4N8nzeuC/lgJlk/Tqt8kiBvbC+lrA+L
 VcM3YtTkj0wDu6wZT6l/kaF6Pf8kHw0n0M0dRjqfL2aAqfJ0UPmpYW0e9dU6LL/gBI0b
 2FYPTS20R+nSKFoCLn8Kn1pCzfeaZyyitOvwi4paeX/gxMQ7DqMlMZ13qSXJbJFxI7e6
 gtZnLAi/eE3X9YyjY1dXDJZsOWVRe6Bor6UHX5a1EIe8YERXZa+RUQv5coKINs1H1stu
 amKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDidOlXSBGaikNNPiyDtopZrWzjbp4C5YS5NYj4B2UQmYTIRoU4llDIzUO+BMf3POKjbQ7cK6J9SnN@nongnu.org
X-Gm-Message-State: AOJu0YwSG16vdFIGPTEmPjswT4ICnl7tFeRiFNZyxM9NWG8+GhaLhvLq
 RHNWklLvyVEs//JpgwZqTp3Pen+eN3ImQ/rfAl3yLjMufdcPu0kWxdsqPZQj63p6S/TBykPieFy
 /fxpsvw==
X-Received: from dyaz13-n2.prod.google.com
 ([2002:a05:693c:638d:20b0:30f:1818:9ce5])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:b94:b0:3c0:9c19:b272
 with SMTP id adf61e73a8af0-3c09c19b393mr159280637.64.1783378861604; Mon, 06
 Jul 2026 16:01:01 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:00:51 +0000
In-Reply-To: <20260706230056.1888992-1-titusr@google.com>
Mime-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230056.1888992-3-titusr@google.com>
Subject: [PATCH 2/5] hw/i2c: pmbus: add milliunits linear mode functions
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3rTNMagYKCp4RGRSQPEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--titusr.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FUZZY_MILLION=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Because we are limited by unsigned ints, we need to be able to provide
inputs in milliunits which can get scaled up to fit in the linear mode
registers.

For example: 3.4 is a valid input, and now we can provide 3400 and scale
it into the register without losing the 0.4

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/pmbus_device.c         | 39 +++++++++++++++++++++++++++++++++++
 include/hw/i2c/pmbus_device.h | 18 ++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index b1f9843f52..e2e1e0e945 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include <math.h>
+#include <stdint.h>
 #include "hw/i2c/pmbus_device.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -38,6 +39,25 @@ uint16_t pmbus_data2linear_mode(uint16_t value, int exp)
     return value >> exp;
 }
 
+uint16_t pmbus_milliunits2linear_mode(uint32_t value, int exp)
+{
+    uint32_t ret;
+
+    /* L = D * 2^(-e) */
+    if (exp < 0) {
+        ret = DIV_ROUND_CLOSEST((value << (-exp)), 1000);
+    } else {
+        ret = DIV_ROUND_CLOSEST((value >> exp), 1000);
+    }
+
+    /* clamp value to maximum if it exceeds representable value*/
+    if (ret > UINT16_MAX) {
+        return UINT16_MAX;
+    }
+
+    return ret;
+}
+
 uint16_t pmbus_linear_mode2data(uint16_t value, int exp)
 {
     /* D = L * 2^e */
@@ -47,6 +67,25 @@ uint16_t pmbus_linear_mode2data(uint16_t value, int exp)
     return value << exp;
 }
 
+uint32_t pmbus_linear_mode2milliunits(uint16_t value, int exp)
+{
+    /* D = L * 2^e */
+    uint64_t v = (uint64_t)value;
+    uint64_t ret;
+
+    if (exp < 0) {
+        ret = (v * 1000) >> (-exp);
+    } else {
+        ret = (v << exp) * 1000;
+    }
+
+    if (ret > UINT32_MAX) {
+        return UINT32_MAX;
+    }
+
+    return (uint32_t)ret;
+}
+
 void pmbus_send(PMBusDevice *pmdev, const uint8_t *data, uint16_t len)
 {
     if (pmdev->out_buf_len + len > SMBUS_DATA_MAX_LEN) {
diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index f195c11384..9f3569e997 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -481,6 +481,15 @@ uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value);
  */
 uint16_t pmbus_data2linear_mode(uint16_t value, int exp);
 
+/**
+ * Convert milliunit sensor value to linear mode format
+ *
+ * L = D * 2^(-e)
+ *
+ * @return uint16
+ */
+uint16_t pmbus_milliunits2linear_mode(uint32_t value, int exp);
+
 /**
  * Convert linear mode formatted data into sensor reading
  *
@@ -490,6 +499,15 @@ uint16_t pmbus_data2linear_mode(uint16_t value, int exp);
  */
 uint16_t pmbus_linear_mode2data(uint16_t value, int exp);
 
+/**
+ * Convert linear mode formatted data into sensor reading in milliunits
+ *
+ * D = L * 2^e
+ *
+ * @return uint32 value in milliunits
+ */
+uint32_t pmbus_linear_mode2milliunits(uint16_t value, int exp);
+
 /**
  * @brief Send a block of data over PMBus
  * Assumes that the bytes in the block are already ordered correctly,
-- 
2.55.0.rc2.803.g1fd1e6609c-goog


