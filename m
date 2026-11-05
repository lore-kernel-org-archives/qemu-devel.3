Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E61606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtZF-0006wK-SD; Thu, 05 Nov 2026 04:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtY1-00059m-9X
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:18 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtXz-0005Rj-AL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:14:17 -0500
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so798571a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870053; x=1794474853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AHne2JcHx+O7G4KfyAccP7ggw7u1GmKaKZ5l2ViY6Cs=;
 b=qDqR42YAELBg4oQAqBVmungSDGrZ4ix7yppMHEENx3OwNEy4zmEnA2TXm5EB0AfQWD
 ZkQE724+rzVakF8gKiClBJJ2/vx5/66jBjK8n56wHRVOp6qMCTvO9+sAciavW4XFJrYA
 MDu1XONVyZScIhsjqV4VKzyigR1pxTiNpsuwRBdbNQvWTzMbUtVAz8oCsccWUFMVxxFW
 Q66PoyzkNbOq7qZNYyS7Te+ot+EaoOYxAg3hzeYQV5pHxQ61xpkMi1tWtAJyDa67rGlz
 h2EN4NR66H2gIzdHPJ6ibpUqfjqdjEGKAHkvqBDQKm5Ysd9Nmvum0xyDdkobVw7AESA1
 37EA==
X-Gm-Message-State: APuU4Z/ntLg+TtqOQuufwntebTm96MwBvZW72PpyfuP3TcbZz6O84y4H
 328qA3IvIWzG77RrgRq6guZUfctf7gFfqU0rplywhJfd2MalhX2sLUcd95LGqaxO2hY=
X-Gm-Gg: AYBFou1HzN72vuTgwhn1/juNbqIvrSu2YsPId/WMqYlOr881o0jYMK5om/pdjZQbDaQ
 oh7xMrUtvxIQ1/klAbuxDua9IEEg5p6L5OkS4XAte6iRqSHRsK5blVuUXfB/H3fq1pBamChqc+t
 YGd4s6iWcsD9FRnuLRjD+ckdEVHobCf2Rl4qkhR8Y+7kh7QuoRr+hIIi5uldz4gtXbppRXun1Fg
 pzvzOGyZRETMgyeRKfAGyfZ/6lcn2XqsTRINXORZ1gNicKo3KthI44ZzzPIVccF+QPM/ACPBpaZ
 vPp1LJrcAUB54X9J/fLBoXu0UVZS+QakhlgdyAMH+cGqAR30eZr993Pi5Lm5XDrQ0tyNU8f4ZY0
 8txfL7uLRdYQupR6U2RsE10/fMPJ3popvYXDMXBOS6VaEZf5TrI63FRc55fdn1MmpczXWz/RXdB
 M4M/XMioLQrxZ49dd/b2lgoOW6T+0yL709eDZ8iLp047UXJFIyB/0jk+dRDxqAvYaXbzh1Id/Ve
 3yCSdGU2HY5kYOSnilbGZUtcuCYaDOJB9nVIiqeLRxFRfvIyqze0Terws83YMmqDT9gj0OzUj5L
 XH1njLwrW3qCETaLifugkiFVNzkbSOYKHNp8DAk9RtwGHy2bw0mWtYs8KECkwiOIVHZuV83aa/0
 tLJJHzw==
X-Received: by 2002:a17:90b:2fd0:b0:3ac:af8b:6f3 with SMTP id
 98e67ed59e1d1-3ae898149e2mr13957413a91.52.1793870053310; 
 Thu, 05 Nov 2026 01:14:13 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0991c13dcsm3789814a91.3.2026.11.05.01.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:14:12 -0800 (PST)
Date: Thu, 05 Nov 2026 17:12:57 +0800
Subject: [PATCH 05/16] tests/qtest: ina230: cover the injection-property limits
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-ina23x-v1-5-5433ed104990@free.fr>
References: <20261105-sensor-ina23x-v1-0-5433ed104990@free.fr>
In-Reply-To: <20261105-sensor-ina23x-v1-0-5433ed104990@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Emmanuel Blot <emmanuel.blot@free.fr>, 
 Glenn Miles <milesg@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793869975; l=4069;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=3UD9l/AEvavR8S7pGFg9evzwIlCmssJcXuU0S21eH1k=;
 b=vR+gD93r/yoe2J8+z6SuJuPnXXYk+GoOx9si90ZxklZZz/X3rkosbw4/iVcmbUUjNFcKjoEBL
 ZXyniqx/zsiDLX5yxTorBhHkZEhp6ReIvo6DW4gdEd3Gh9yHv2YXPiu
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.179; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f179.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Verify that the extremes of the shunt- and bus-voltage injection ranges
round-trip through the QOM property without truncation or wraparound,
and that values just outside are rejected rather than silently wrapped.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index 1c55028fcb..36c899efee 100644
--- a/tests/qtest/ina230-test.c
+++ b/tests/qtest/ina230-test.c
@@ -47,6 +47,11 @@
 #define SHUNT_LSB_NV        2500
 #define BUS_LSB_UV          1250
 
+/* Injection-property limits (see ina230.c) */
+#define SHUNT_MIN_NV        (-81920000)
+#define SHUNT_MAX_NV        81917500
+#define BUS_MAX_UV          36000000
+
 #define DIE_ID_VAL          0x2310
 
 /* QMP helpers for injecting the physical inputs */
@@ -76,6 +81,18 @@ static int qmp_ina230_get(const char *property)
     return ret;
 }
 
+/* A qom-set expected to be rejected (value outside the supported range) */
+static void qmp_ina230_set_fail(const char *property, int64_t value)
+{
+    QDict *resp;
+
+    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
+               " { 'path': %s, 'property': %s, 'value': %lld } }",
+               INA230_TEST_ID, property, (long long)value);
+    g_assert(qdict_haskey(resp, "error"));
+    qobject_unref(resp);
+}
+
 /* Power-on-reset default values and the Die ID */
 static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -307,6 +324,46 @@ static void test_cvrf(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_CVRF, ==, 0);
 }
 
+/* Shunt-voltage injection limits */
+static void test_shunt_limits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("shunt-voltage", SHUNT_MAX_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x7FFF);
+    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MAX_NV);
+
+    qmp_ina230_set("shunt-voltage", SHUNT_MIN_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
+    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MIN_NV);
+
+    qmp_ina230_set_fail("shunt-voltage", (int64_t)SHUNT_MAX_NV + 1);
+    qmp_ina230_set_fail("shunt-voltage", (int64_t)SHUNT_MIN_NV - 1);
+    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, SHUNT_MIN_NV);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
+}
+
+/* Bus-voltage injection limits. */
+static void test_bus_limits(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+
+    qmp_ina230_set("bus-voltage", 0);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x0000);
+
+    qmp_ina230_set("bus-voltage", BUS_MAX_UV);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x7080);
+    g_assert_cmpint(qmp_ina230_get("bus-voltage"), ==, BUS_MAX_UV);
+
+    qmp_ina230_set_fail("bus-voltage", (int64_t)BUS_MAX_UV + 1);
+    qmp_ina230_set_fail("bus-voltage", -1);
+    g_assert_cmpint(qmp_ina230_get("bus-voltage"), ==, BUS_MAX_UV);
+}
+
 static void ina230_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -322,6 +379,8 @@ static void ina230_register_nodes(void)
     qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
     qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
     qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
+    qos_add_test("shunt-limits", "ina230", test_shunt_limits, NULL);
+    qos_add_test("bus-limits", "ina230", test_bus_limits, NULL);
     qos_add_test("calibration-current", "ina230", test_calibration_current,
                  NULL);
     qos_add_test("power", "ina230", test_power, NULL);

-- 
2.53.0-Meta


