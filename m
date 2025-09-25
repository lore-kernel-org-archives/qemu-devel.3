Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7379CAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aK4-0001m2-DG; Wed, 24 Sep 2025 20:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3v5PUaAkKCoYvs7sky8kxqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--lixiaoyan.bounces.google.com>)
 id 1v1aJz-0001kP-0b
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:58:55 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3v5PUaAkKCoYvs7sky8kxqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--lixiaoyan.bounces.google.com>)
 id 1v1aJp-0004md-EO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:58:54 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2681642efd9so2940835ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758761919; x=1759366719; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lga1qICQBDebNyrMenzq4J/gBbkdWk9MbgAOL5tW2hc=;
 b=YbRxg5kSyUrH76H+HSLLJPw6Umg2RAcyS0KGCU1Gya33/RjuI4aRr0nLi8OVuN47NF
 2CggQTUqxoG3igoGOLl3K6oVLGm/q+2c/ma9pnVMji5idQmP9P1ZdsJQLgnZmg8OOXvh
 zNxKDTllamBJV1TWc+dlIGOwUHSPYK5SGbiTt9DSTqEKkfo5Wvm+xMP/DRrTeaI9ooxB
 IDd5KbZAmRJMrifmb5PaVXz/i/7JvEy7YTzfElJpGiWyjc+AQVcgXIt8xJKHgRQjdbHo
 gFIuFZvP/y/eWXwVQYS90HqHnUOIoVFk0XnJ+j1hp6PnJG6hMz0F6/0/VdfitwsesUme
 RFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758761919; x=1759366719;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lga1qICQBDebNyrMenzq4J/gBbkdWk9MbgAOL5tW2hc=;
 b=h0VqK7O3QjJNYJTWsyF/rew7KdPLSOSdmbMRvuJlhVmIUkWWfuH22U93Sj1OT9bRzS
 Sl+ZlNHom8qhirlTThRwk2Hb1hcEHH3CZ3PW/VV9oAHJVDQbmzCNKGg0zfB9XgtthpL9
 aQ3zExY03W2Z9iIEUCuOi1o9DbjOh9CxRHxgAr98zrWE4Kma0pR8NkZh+12qctjbCX5K
 Di1isnMQ37tqp3VRr+qNEjtEsqMXeecyGG2Rk4jrRBuEwiWv9jWP7X2Vv+ntkgygJVEn
 dxVN+fZGZ1iYkBEzmIKtCReJO7XMtzy90o8CKvEMtHKkmxv4qE4at75ltTppDhgcXopD
 oA5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgPvQdqmAeOZEA6i/RtmYHoROdW7jxox85ogN+0JUOrDERM+uut6RGXyLGAiGTxgPdulGYFFEWmRyA@nongnu.org
X-Gm-Message-State: AOJu0YxFs0y90EuUUig31d27ruQHqQRAQv0tCceOgHxZ2rI7kfSYLKTz
 uZz+8QN+FlvwKXFnWBt6pIYC6wx633BA/vPj4oWr9CW2DW/XtP4/7ESAajrPNedqFEPJ6ZqcpL2
 fj6QYG+ONqfSL/+ivlw==
X-Google-Smtp-Source: AGHT+IHPvj8Ik2PkoH5xfsw+BrdiJR0kI8M82wKzRnXn0UXvZIb5008FnsBov2Zx7ruYAuJLueRK/TwDBbUSbNE=
X-Received: from plq1.prod.google.com ([2002:a17:903:2f81:b0:260:6fd2:4165])
 (user=lixiaoyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:110e:b0:271:b6b3:71ef with SMTP id
 d9443c01a7336-27ed4a471b4mr18227265ad.43.1758761919306; 
 Wed, 24 Sep 2025 17:58:39 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:58:29 +0000
In-Reply-To: <20250925005832.3708492-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20250925005832.3708492-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925005832.3708492-3-lixiaoyan@google.com>
Subject: [PATCH v1 2/5] tests/qtest: Add qtest for for ASPEED GPIO gpio-set
 property
From: Coco Li <lixiaoyan@google.com>
To: peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, lixiaoyan@google.com, 
 flwu@google.com, andrew@codeconstruct.com.au
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3v5PUaAkKCoYvs7sky8kxqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--lixiaoyan.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
2.51.0.536.g15c5d4f767-goog


