Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EB5C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDT4-0007Dk-Aa; Wed, 29 Jul 2026 19:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3IIlqagYKCjcmbmnlkZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--titusr.bounces.google.com>)
 id 1wpDT2-0007Cz-R7
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:40 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3IIlqagYKCjcmbmnlkZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--titusr.bounces.google.com>)
 id 1wpDT1-0007K1-5U
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:40 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso1861879a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366817; x=1785971617; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rj/PLz8usrH3OiKcLytTs4/lCfhHMIDEojECCw7hUKg=;
 b=wDep6C5Ryf1DQddqPsG8E4Q4e7keaKqYoIZYB4mZIqpO5Jzq83Uz0FHvsNZq57JL/Q
 8O/t9TNpHNXYfU03FDDvRFvGgzYlMHaQQdzZOiCvCYO2RqAU065JoViCT5U+SxxNV/wS
 t9Hm4bDsCwnkDiVTPxjIJki1IYVgwrAPTAlHk25wZi+Hd2/JVGxr1+FwwM+Jy5uoYCwA
 Fr8zKKYqLBP971bI58izy62JFuj2iX6QDiwoWjc4utKALo3L48q5YU/MiynESkiXDdfG
 kSK+VKL7wcx2y0PHhcdtcDQ4wsdNT0mLBu/8vKXMz9xF4mhwhDwaIxS82O6fS9iUgSyy
 bXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366817; x=1785971617;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rj/PLz8usrH3OiKcLytTs4/lCfhHMIDEojECCw7hUKg=;
 b=kTLQQY5UsLsOMUeyNOxq6hGSJpaJKkGewaVm49ecQgzwVBHzD4U3VX6OfTol3cpKnZ
 rYMKr8GUgJA1c8dEXzoGD/MGdWEd2JBnU8LQLBEXoVFtJP3ahTNC4Qi1TXW4Yrq9I/jN
 oK+OjSFqVRC7qphlyUn70KZLXZ/g1k5+vBaRDgk2OzLpnn+NIydjTxlbDHkUBLTzxbXL
 aNP/uONKCAoeMV/GQQqnABitlmSDcwZ6KkUVnwvd5jANb+Q63U4meTWNydQVzkVSCJ3A
 BzLbhf6yfO3MZO7scnkigaqH4yBAvFsPGyPyefYM4hQICAczwv/aBqWmG3rrT5THl6hm
 BpfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp61vRqrfU0l5/+IPkAzdTu1ID83hdkaNRXSOXSYRLteo7Dfcuxy6y6/8gnSQlrrMxD4we6rkCgLUla@nongnu.org
X-Gm-Message-State: AOJu0YwbJ9eA/ZXaGGSe+PMtPLuAI+3cdYDbKQAhH/2MXwRUmOcY72Bk
 CkUW2r7D9TdgWfNXYZyZlcAGbBtbCEUuCGA4T16Hu5+GUd0NDxADgP17K8luEZ3HDK8JH5/xqpE
 m/DF6dQ==
X-Received: from dydn10.prod.google.com ([2002:a05:7300:730a:b0:30f:3dee:fdfe])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3811:b0:37f:9cdf:f037
 with SMTP id 98e67ed59e1d1-38f9bece03bmr191237a91.26.1785366816532; Wed, 29
 Jul 2026 16:13:36 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:23 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-9-titusr@google.com>
Subject: [PATCH 8/8] hw/sensor: adm1266: set default VOUT mode
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=3IIlqagYKCjcmbmnlkZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--titusr.bounces.google.com;
 helo=mail-pj1-x1047.google.com
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

VOUT_MODE 0 represents linear mode, and the exponent is set to -10, to
allow us to fit 3.3V in the register.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c        | 17 ++++++++++++-----
 tests/qtest/adm1266-test.c |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 1464307971..c0c6341876 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -42,6 +42,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ADM1266State, ADM1266)
 #define ADM1266_MFR_LOCATION_DEFAULT            "0000"
 #define ADM1266_MFR_DATE_DEFAULT                "0000"
 #define ADM1266_MFR_SERIAL_DEFAULT              "0000"
+#define ADM1266_VOUT_MODE_EXP_DEFAULT           -10
+
 
 #define ADM1266_NUM_PAGES                       17
 #define ADM1266_READ_LENGTH_DEFAULT             48
@@ -85,6 +87,10 @@ static void adm1266_exit_reset(Object *obj, ResetType type)
 {
     ADM1266State *s = ADM1266(obj);
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    PMBusVoutMode m = {
+        .mode = 0,
+        .exp = ADM1266_VOUT_MODE_EXP_DEFAULT
+    };
 
     pmdev->page = 0;
     pmdev->capability = ADM1266_CAPABILITY_NO_PEC;
@@ -92,11 +98,12 @@ static void adm1266_exit_reset(Object *obj, ResetType type)
     for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
         pmdev->pages[i].operation = ADM1266_OPERATION_DEFAULT;
         pmdev->pages[i].revision = ADM1266_PMBUS_REVISION_DEFAULT;
-        pmdev->pages[i].vout_mode = 0;
-        pmdev->pages[i].read_vout = pmbus_data2linear_mode(12, 0);
-        pmdev->pages[i].vout_margin_high = pmbus_data2linear_mode(15, 0);
-        pmdev->pages[i].vout_margin_low = pmbus_data2linear_mode(3, 0);
-        pmdev->pages[i].vout_ov_fault_limit = pmbus_data2linear_mode(16, 0);
+
+        pmdev->pages[i].vout_mode = *(uint8_t *)&m;
+        pmdev->pages[i].read_vout = pmbus_data2linear_mode(12, m.exp);
+        pmdev->pages[i].vout_margin_high = pmbus_data2linear_mode(15, m.exp);
+        pmdev->pages[i].vout_margin_low = pmbus_data2linear_mode(3, m.exp);
+        pmdev->pages[i].vout_ov_fault_limit = pmbus_data2linear_mode(16, m.exp);
         pmdev->pages[i].revision = ADM1266_PMBUS_REVISION_DEFAULT;
     }
 
diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index 9cdd206c3f..6fcf2505cf 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -47,7 +47,7 @@
 #define TEST_STRING_C                           "rev c"
 
 #define ADM1266_NUM_PAGES                       17
-#define ADM1266_MAX_VALUE                       65535000
+#define ADM1266_MAX_VALUE                       63999  /* UINT16_MAX * 2^-10 */
 
 typedef union {
     uint8_t raw;
-- 
2.55.0.508.g3f0d502094-goog


