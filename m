Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7EECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 01:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8qA8-0000Qv-FW; Tue, 14 Oct 2025 21:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bfbuaAkKCmQNKZKCQaCPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA5-0000PJ-Uc
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:42 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bfbuaAkKCmQNKZKCQaCPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--lixiaoyan.bounces.google.com>)
 id 1v8qA3-0003Cm-LX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 21:18:41 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b57cf8dba28so10333602a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760491117; x=1761095917; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=CPQs+PsbgO0P6AZuHEwWkT67RFWoD7TQs6ylOThGD/E=;
 b=Bn58UuaDYu/9ayiqy1eaqKB+QDYNrSeFfkWNC0/G0uG1usOCg2Z0Z2Y9qLPJf5JFme
 0ax7NjwMpfTwklQt4JrgxhFN07Yq2p8G3h2kl5Q1lcGfH5E7WDCEw3xq4OlegTUu8AEY
 57YAkBvO1qVghJVRV0bQQkcImv8rfKJk/jFRuJVXT1qsnqs7qZLMEFF4Z2Aj34iR3NNH
 2eyzb4650cuxq/M01jkhFNwyxM859CRGS/z9ZF9PjXcU2CuwR6VlxboMj1w/bmxFScHF
 D3iMx5sWUyyzQbsskXcfDi/NEVMytcfRMK8WTwmUllxSUT6itpBxioA58H0hWllZmpuy
 QWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760491117; x=1761095917;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CPQs+PsbgO0P6AZuHEwWkT67RFWoD7TQs6ylOThGD/E=;
 b=wo5SyS2EZiFZGXoJrMidj1BG0NcDcaR4fI3hy1Hd0SkCF09eF//MlzY0aWqfutwbqb
 0VEKAbRPdP3eVm4EyITRaTHn8lbzYENrAKSPVEMD51/QJhpuNGrH+DpGc84tGGFwmdpq
 7emsXWxMPhrFcPe9KTEpUJc+0rxyV97xNryRwrpAxBl133jT4TOGEgPknKiKgH5cpBwI
 CnJVLKgyuhbhZn/ZPhq4CFEymLeKEc6HB5BDc+hAueIWRu5Sp/GOb4qJVV9c0pgjuoBG
 hXqdN1DIZX0vED40PIDMITnd77/lvQ4IBNxcJ7oWUpK+EY57Ht9omq+IU//2Ab9cKNtx
 VXzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUELsowQLmJixNK6GmZt7D90cNknh69XM4QRpt8PkuCc7dF78+0NmLTqvGtLFZI2WrIsgspkgZs7yxD@nongnu.org
X-Gm-Message-State: AOJu0YybrUq/OxHVr/oZ8w9N0Vc6bOyW7WEy3N7aw7jlnSrUldj4J1+b
 b2GpPwMUwYQoECmsmDdi7JH/219N3MEo4gJd6SM7aLm4H8vUaqWuSx4s1BT/Ovz9rwBGxZLnhom
 XC09Huz9asZLgDAXNZA==
X-Google-Smtp-Source: AGHT+IFry+Tx4jNARET6jdIzh7caqsmh28sD+VHmqU3izgHWU3OMXaqVC4Lqukc/HZvWXUYV6Pdxseox259GEfQ=
X-Received: from plxd12.prod.google.com ([2002:a17:902:ef0c:b0:269:ab8c:6531])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2b03:b0:264:70e9:dcb8 with SMTP id
 d9443c01a7336-2902739f408mr327738495ad.55.1760491117364; 
 Tue, 14 Oct 2025 18:18:37 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:18:26 +0000
In-Reply-To: <20251015011830.1688468-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20251015011830.1688468-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251015011830.1688468-3-lixiaoyan@google.com>
Subject: [PATCH v2 2/5] tests/qtest: Add qtest for for ASPEED GPIO gpio-set
 property
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3bfbuaAkKCmQNKZKCQaCPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--lixiaoyan.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

From: Felix Wu <flwu@google.com>

 - Added qtests to test gpio-set property for ASPEED.
 - Added function to get uint in qdict.

Signed-off-by: Felix Wu <flwu@google.com>
---
 include/qobject/qdict.h        |   1 +
 qobject/qdict.c                |  13 ++++
 tests/qtest/aspeed_gpio-test.c | 105 ++++++++++++++++++++++++++++++---
 3 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/include/qobject/qdict.h b/include/qobject/qdict.h
index 903e6e5462..861996f08d 100644
--- a/include/qobject/qdict.h
+++ b/include/qobject/qdict.h
@@ -57,6 +57,7 @@ void qdict_put_str(QDict *qdict, const char *key, const char *value);
 
 double qdict_get_double(const QDict *qdict, const char *key);
 int64_t qdict_get_int(const QDict *qdict, const char *key);
+uint64_t qdict_get_uint(const QDict *qdict, const char *key);
 bool qdict_get_bool(const QDict *qdict, const char *key);
 QList *qdict_get_qlist(const QDict *qdict, const char *key);
 QDict *qdict_get_qdict(const QDict *qdict, const char *key);
diff --git a/qobject/qdict.c b/qobject/qdict.c
index a90ac9ae2f..0dafe6d421 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -209,6 +209,19 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
     return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
 }
 
+/**
+ * qdict_get_uint(): Get an unsigned integer mapped by 'key'
+ *
+ * This function assumes that 'key' exists and it stores a
+ * QNum representable as uint.
+ *
+ * Return unsigned integer mapped by 'key'.
+ */
+uint64_t qdict_get_uint(const QDict *qdict, const char *key)
+{
+    return qnum_get_uint(qobject_to(QNum, qdict_get(qdict, key)));
+}
+
 /**
  * qdict_get_bool(): Get a bool mapped by 'key'
  *
diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index 12675d4cbb..c2f9ca2298 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -27,28 +27,115 @@
 #include "qemu/timer.h"
 #include "qobject/qdict.h"
 #include "libqtest-single.h"
+#include "qemu/typedefs.h"
 
 #define AST2600_GPIO_BASE 0x1E780000
 
 #define GPIO_ABCD_DATA_VALUE 0x000
 #define GPIO_ABCD_DIRECTION  0x004
 
+static uint32_t qtest_qom_get_uint32(QTestState *s, const char *path,
+                                     const char *property)
+{
+    QDict *r;
+
+    uint32_t res;
+    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
+                     "{ 'path': %s, 'property': %s } }", path, property);
+    res = qdict_get_uint(r, "return");
+    qobject_unref(r);
+
+    return res;
+}
+
+static void qtest_qom_set_uint32(QTestState *s, const char *path,
+                                 const char *property, uint32_t value)
+{
+    QDict *r;
+
+    r = qtest_qmp(s, "{ 'execute': 'qom-set', 'arguments': "
+                     "{ 'path': %s, 'property': %s, 'value': %" PRIu32 " } }",
+                     path, property, value);
+    qobject_unref(r);
+}
+
+static const char *resp_get_error(QDict *r, const char* error_key)
+{
+    QDict *qdict;
+
+    g_assert(r);
+
+    qdict = qdict_get_qdict(r, "error");
+    if (qdict) {
+        return qdict_get_str(qdict, error_key);
+    }
+
+    return NULL;
+}
+
+static bool qtest_qom_check_error(QTestState *s, const char *path,
+                                  const char *property, const char *error_msg,
+                                  const char *error_msg_key)
+{
+    QDict *r;
+    bool b;
+
+    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
+                     "{ 'path': %s, 'property': %s } }", path, property);
+    b = g_str_equal(resp_get_error(r, error_msg_key), error_msg);
+    qobject_unref(r);
+
+    return b;
+}
+
 static void test_set_colocated_pins(const void *data)
 {
     QTestState *s = (QTestState *)data;
-
+    const char path[] = "/machine/soc/gpio";
     /*
      * gpioV4-7 occupy bits within a single 32-bit value, so we want to make
      * sure that modifying one doesn't affect the other.
      */
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV4", true);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV5", false);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV6", true);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV7", false);
-    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV4"));
-    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV5"));
-    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV6"));
-    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV7"));
+    qtest_qom_set_bool(s, path, "gpioV4", true);
+    qtest_qom_set_bool(s, path, "gpioV5", false);
+    qtest_qom_set_bool(s, path, "gpioV6", true);
+    qtest_qom_set_bool(s, path, "gpioV7", false);
+    g_assert(qtest_qom_get_bool(s, path, "gpioV4"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioV5"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioV6"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioV7"));
+
+    /*
+     * Testing the gpio-set[%d] properties, using individual gpio boolean
+     * properties to do cross check.
+     * We use gpioR4-7 for test, Setting them to be 0b1010.
+     */
+    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0x0);
+    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0x0);
+    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0xa000);
+    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0xa000);
+
+    g_assert(!qtest_qom_get_bool(s, path, "gpioR4"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioR5"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioR6"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioR7"));
+
+    /*
+     * Testing the invalid indexing, the response info should contain following
+     * info:
+     * {key: "class", value: "GenericError"}
+     *
+     * For pins, it should follow "gpio%2[A-Z]%1d" or "gpio%3[18A-E]%1d" format.
+     */
+    const char error_msg[] = "GenericError";
+    const char error_msg_key[] = "class";
+
+    g_assert(qtest_qom_check_error(s, path, "gpioR+1", error_msg,
+                                   error_msg_key));
+    g_assert(qtest_qom_check_error(s, path, "gpio-set[99]", error_msg,
+                                   error_msg_key));
+    g_assert(qtest_qom_check_error(s, path, "gpio-set[-3]", error_msg,
+                                   error_msg_key));
 }
 
 static void test_set_input_pins(const void *data)
-- 
2.51.0.788.g6d19910ace-goog


