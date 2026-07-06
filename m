Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AA6C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgsJK-0001Uo-F0; Mon, 06 Jul 2026 19:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3sDNMagYKCqEUJUVTSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--titusr.bounces.google.com>)
 id 1wgsJI-0001Sr-Fu
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:08 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3sDNMagYKCqEUJUVTSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--titusr.bounces.google.com>)
 id 1wgsJG-00074Z-V8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:08 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c891ed872ddso5608860a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783378865; x=1783983665; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OLTxskLBXDENLFyN1dtTBrLCPkP5BiKim3I9wu6aM8I=;
 b=eK8IDoXn2tYfArPwudUQm3xcm2eekmsquiVXnBrkHpbk2+sMQ3OxOEVs2saQXHzg7y
 PO88NxajZYJ1idE6tslnBd/26k3UmKMH6XXiGGwuDe11V6raPTRCuiJPv+dFmRr1z7cn
 xCCjXBDIlnqgVW3mIg6Pm2YqdRc0vdUyWIuC+jZk+PXCwOpeOjc2L3Him7+5P112vf6+
 N9KH6Mg2ZWnpWJoSER6bqKBvyOs2MX1LkcUeWlRGfpJHtUS33mk8J3dFP9xsELe9doNw
 Vepofy11j899W9Vo2Ya43OdArXOx9Mhk9xdAlwGrpHw6RR9QobMI/ImPEj29n54DFzsn
 kx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783378865; x=1783983665;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLTxskLBXDENLFyN1dtTBrLCPkP5BiKim3I9wu6aM8I=;
 b=XU1r7LppgxgaTc+lGULBU8C0u/UBSG/xbtSeVI0YMu9wGZhMSM/O5WfjObwo/WEliU
 jJ6D4pM9cEfp8vm7stIXINNfVa2+MTcrS+WYmN2GoPzkQtFNmEtXnpJyOPjafstbaET/
 eT3CcDEYhmfGdb/wEwlGHekBL1OWG779paZepbeUTXCOl5SJ5As35c7KwWa3mpkl9fQM
 xrLxsn4VXLmSjyYK+RoCxvo0MVTlxY9sgcUmK8IEwyQBNuvkKPa5IM08W/BGxh+Z5dL+
 J30+AKXtwenvxOySYgpG7KTESlLiXfLhlOjSxtkrs6NuJM9KRNVPlbSHc6V/cSuB4ew+
 seyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGIB7Ydp2pqRuUPXg6ySYorsXZ5y/zhCIleL1DztjUkI4mPKUaFxd52wu335PZCzfhmzPi9vmFAysR@nongnu.org
X-Gm-Message-State: AOJu0YwzoGfyfNkyj9cIQtU1bkSD6tI/H+rfQZibyWxjphUQEMRugJPJ
 06dVNJm8nGkD1jQLlKseKifWEAf5VZTSVmScJZn1LstV48qBZU2XHWvOF/9waMb14Vt5DpWXhhJ
 oGRROhA==
X-Received: from dlea16-n1.prod.google.com
 ([2002:a05:701b:4210:10b0:13b:3fa1:5d80])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7116:b0:3bf:e291:496c
 with SMTP id adf61e73a8af0-3c08edb1d45mr3167471637.17.1783378864356; Mon, 06
 Jul 2026 16:01:04 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:00:54 +0000
In-Reply-To: <20260706230056.1888992-1-titusr@google.com>
Mime-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230056.1888992-6-titusr@google.com>
Subject: [PATCH 5/5] hw/i2c: pmbus: add Linear11 format helpers
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3sDNMagYKCqEUJUVTSHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--titusr.bounces.google.com;
 helo=mail-pg1-x549.google.com
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

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/pmbus_device.c         | 12 +++++++++
 include/hw/i2c/pmbus_device.h | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 8befc27895..5039975520 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -39,6 +39,12 @@ uint16_t pmbus_data2linear_mode(uint16_t value, int exp)
     return value >> exp;
 }
 
+uint16_t pmbus_data2linear11(uint16_t value, int exp)
+{
+    return (uint16_t)((exp & 0x1F) << 11 |
+        (pmbus_data2linear_mode(value, exp) & 0x7FF));
+}
+
 uint16_t pmbus_milliunits2linear_mode(uint32_t value, int exp)
 {
     uint32_t ret;
@@ -58,6 +64,12 @@ uint16_t pmbus_milliunits2linear_mode(uint32_t value, int exp)
     return ret;
 }
 
+uint16_t pmbus_milliunits2linear11(uint32_t value, int exp)
+{
+    return (uint16_t)((exp & 0x1F) << 11 |
+        (pmbus_milliunits2linear_mode(value, exp) & 0x7FF));
+}
+
 uint16_t pmbus_linear_mode2data(uint16_t value, int exp)
 {
     /* D = L * 2^e */
diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index 9f3569e997..44cd908fe7 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -477,10 +477,56 @@ uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value);
  *
  * L = D * 2^(-e)
  *
+ * Exponent is retrieved from VOUT_MODE register
+ *
+ *   7   6   5   4   3   2   1   0
+ * +---+---+---+---+---+---+---+---+
+ * | 0 | 0 | 0 |       N           |
+ * +---+---+---+---+---+---+---+---+
+ *   |_______|   |_______________|
+ *     Mode          Exponent (N)
+ *    = 000b
+ *
  * @return uint16
  */
 uint16_t pmbus_data2linear_mode(uint16_t value, int exp);
 
+/**
+ * Convert sensor values to linear11 format
+ *
+ *   L = e << 11 | D * 2^(-e)
+ *
+ *  |        Data Byte High             |        Data Byte Low          |
+ *  +---+---+---+---+---+   +---+---+---+---+---+---+---+---+---+---+---+
+ *  | 7 | 6 | 5 | 4 | 3 |   | 2 | 1 | 0 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
+ *  +---+---+---+---+---+   +---+---+---+---+---+---+---+---+---+---+---+
+ *  | MSB               |   | MSB                                       |
+ *  |_________ _________|   |_____________________ _____________________|
+ *            N                                   Y
+ *         Exponent                            Mantissa
+ *
+ * @return uint16
+ */
+uint16_t pmbus_data2linear11(uint16_t value, int exp);
+
+/**
+ * Convert sensor values in milliunits to linear11 format
+ *
+ *   L = e << 11 | D * 2^(-e)
+ *
+ *  |        Data Byte High             |        Data Byte Low          |
+ *  +---+---+---+---+---+   +---+---+---+---+---+---+---+---+---+---+---+
+ *  | 7 | 6 | 5 | 4 | 3 |   | 2 | 1 | 0 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
+ *  +---+---+---+---+---+   +---+---+---+---+---+---+---+---+---+---+---+
+ *  | MSB               |   | MSB                                       |
+ *  |_________ _________|   |_____________________ _____________________|
+ *            N                                   Y
+ *         Exponent                            Mantissa
+ *
+ * @return uint16
+ */
+uint16_t pmbus_milliunits2linear11(uint32_t value, int exp);
+
 /**
  * Convert milliunit sensor value to linear mode format
  *
-- 
2.55.0.rc2.803.g1fd1e6609c-goog


