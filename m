Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E41C54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDSy-00079R-Ab; Wed, 29 Jul 2026 19:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GolqagYKCjEgVghfeTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--titusr.bounces.google.com>)
 id 1wpDSw-00077Z-Mh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:34 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GolqagYKCjEgVghfeTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--titusr.bounces.google.com>)
 id 1wpDSu-0007HG-Vo
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:34 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so1678248b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366811; x=1785971611; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a7KMZQX7WKu7NK26d8sCHa90LZGnlaTr77TpG29ztMM=;
 b=sUy9TdguDW9WEqVCs4j5w9qWE7HF5eE0sDa/a19w+5xEFNoSum6asmc0xa4eLLE0mW
 mG0poJUqJ+Yh5zhG8wD1qXf6rjk6LwGYKibOTK6RbyTJ8uCasg35PNXyX4SCOTjFoipD
 usx/0ov9D/4QMtf+hSzXJFW9NnAZ6KQv+LuKmj/Yd0I8mAKbPP5k7BQ2pZB+gHzie6CH
 tSdhMzQFS2pmVjHz8my4vW/xBtWShhpCyZjYxVtwEc5vyLTyd4vtfiGlMfPMHvDAdB3W
 AwdrianZh6GCgnC2qH+q4ail25HcQ59qpRj79/cNwM1fC6Xc8G+x7mjpi68wAITLdtTI
 6FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366811; x=1785971611;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a7KMZQX7WKu7NK26d8sCHa90LZGnlaTr77TpG29ztMM=;
 b=rIBXPNPLiMr9ZOqiKWsJgHekQAI4zT+FWlfxckHF3+pJk5RdBB4faDTIG24/WAbxVf
 rnwU0LBH2DCk98esS+0liVt7kypjuYJy7B1dbERUqcdCkV2d9Q6JaRWgZEOhhNv36W9G
 z2c8h/hjNV9ItcDPD3CyzuwYmLGpytyMtSS95/VtUEEv+X7zGG3Y5ufdCnZhJBrWEk4K
 cbH9AhHHha6scCNkzS6LhNWaRIu4P0NjSD3HJn8/RamkG4JAJpAx1GSGkcBnyE2jYXlz
 2rSblSrfGAx633K2Ix77OpQe2h1U6vLn8nPM0YDSLR8iF+KeUf+ld5Bl5XeWcEKnC0fw
 rE4A==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc42sJBE/Kk8xUqgrcpdZlc7QwY4iMRGAlaT0e1lPKgHsAQMeJsM9a2o7yLbzhGZzyLk0Ixr4TSD5M@nongnu.org
X-Gm-Message-State: AOJu0YxRuerOle2dImWmS1YslzRfj2z4nuAQh7BznNZsSdqqDd4CeXTm
 Ie5fhOBYSNadJxNglbjdtGRXIk7l3TlVYIrEsyku/51J6iDxNhMHirKRNA5idFU6L3zPbIhOif9
 IFTABog==
X-Received: from dlbuu4.prod.google.com ([2002:a05:7022:7e84:b0:13d:6291:7191])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a109:b0:3c3:b656:4f5b
 with SMTP id adf61e73a8af0-3c9008e68ddmr53041637.56.1785366810640; Wed, 29
 Jul 2026 16:13:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:17 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-3-titusr@google.com>
Subject: [PATCH 2/8] hw/i2c: pmbus: add milliunits linear mode functions
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=3GolqagYKCjEgVghfeTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--titusr.bounces.google.com;
 helo=mail-pf1-x447.google.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FUZZY_MILLION=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
index 1ca117bd3c..6e477fd6cf 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -38,6 +38,26 @@ uint16_t pmbus_data2linear_mode(uint16_t value, int exp)
     return value >> exp;
 }
 
+uint16_t pmbus_milliunits2linear_mode(uint32_t value, int exp)
+{
+    uint64_t ret;
+    uint64_t val = value;
+
+    /* L = D * 2^(-e) */
+    if (exp < 0) {
+        ret = DIV_ROUND_CLOSEST((val << (-exp)), 1000);
+    } else {
+        ret = DIV_ROUND_CLOSEST((val >> exp), 1000);
+    }
+
+    /* clamp value to maximum if it exceeds representable value*/
+    if (ret > UINT16_MAX) {
+        return UINT16_MAX;
+    }
+
+    return (uint16_t)ret;
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
+    uint64_t val = value;
+    uint64_t ret;
+
+    if (exp < 0) {
+        ret = DIV_ROUND_CLOSEST((val * 1000), 1ULL << (-exp));
+    } else {
+        ret = (val << exp) * 1000;
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
2.55.0.508.g3f0d502094-goog


