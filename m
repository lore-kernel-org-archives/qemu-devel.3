Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19142CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN7y-0000mz-E5; Thu, 15 Oct 2026 11:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN7v-0000eQ-NR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:12:15 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN7t-0001y6-Rx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:12:15 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso25056245e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077132; x=1792681932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hRQau7jFOLMcW9cDld4PZy7QHA0r3DkmWSHU69Dv0ic=;
 b=sEAeF8fmNFaPzYJqN25wifIt0/4xXbWkAEk7IAUosQjw8eoB9NyGAf4cuPLNtAzXLd
 XBk6BCYeAtRqQbP4Jw0wpKB0RCVjJseIdA1BYA+CLD49bCmhnkpsqXLztPof4p17FGDg
 ZJiVgk0R0qptfj3dKRhYmls9UauZr4L4AOeo3ltIuhOXmtInrCotawhgfwD7+IJ7F9wT
 V8fEgcrSA61toYl9vobu3nAWdfcXL555xJptIDPGaFbVrNsjvWmj2ULfJwcwsBCvwvE2
 JsJph8+DhUKkjwRa8BuAN9/92ruKcZ7ZYZz9/m478SuCcqzUkqE7UOkzSIk3b5IRigqp
 adzw==
X-Gm-Message-State: AFq9FYI6NM8HD3eYDPoXkcx2UYGH3Ozo4D/8o+AlGKvcX8lUFQMI4wfi
 WMdJxoJcNfB9LwveHmeAVQSDM9suE2sdZF6WNh5+HVkO49DNEnDL5vCkQ/68lA==
X-Gm-Gg: AYBFou0FSTrsqhCwu5Ydsh+m3lV4qGOyzpR+1zxWqquIrfHqERzwi8TGqcB5ncdohW0
 eWupKpucAj9ap1zMwM55k+yazbRJuOh7V0i4/KC81FxuzkZM499Q3IZV9zzgQfXVjkTlZEVFNgs
 ImO9q5q1+MnYYIWw45adjtWC8+toFBxIkdbIWhNhT4SOEJooOdpoz74upx4lY63UC3PJj4oRAnr
 5UbKwwAD9u42HpYibmYP/T5GaDMGilZlJNwbXpUwFddUjd23hlmIYRzzfbH7bJREIpQl97WSo9y
 k8qKjIEPWCoMAWBRAkpOI+vD+C0QR5HqHTE5mzpXQjWVDeGS6+dPVZ1vLWoDsC+CW4uM3vxNyjH
 fbevMndrqTddOEK579W8Bhu99gt6xmgN8iF716kWKHuRgTbwXAz7Kwdzx68jZK9m8cTevcKhDih
 AHStUt0ySZGj4r/rWvNpA2yvj7pEO0gdLNUeM/fPCS68Whod6FfIVrQyWpaf5qY5g2XWQpH0Qlh
 Dfuu1U9CAU5EiZbw1ynLICUIwS0gpJaq6dzJuNQz4jlGBw=
X-Received: by 2002:a05:600c:4e89:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a18e4ac77amr434246385e9.30.1792077132261; 
 Thu, 15 Oct 2026 08:12:12 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd64b5e7sm77275735e9.2.2026.10.15.08.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:12:11 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:54 +0200
Subject: [PATCH 16/22] tests/qtest: tmp421: cover the register form of the
 migration stream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-16-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=3815;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=KCKssRn/w/mRE8Rh274RLtAfGbpNnr2ePuT78VSY79A=;
 b=Px6Rno0FU9aNGFRQDDqZEW7yiUg/GPF11gsY4AdAEFz9J6+BMnEu32N755/95aExgtsl5nHL2
 7iX3si4AryyBgt6jBkA5QExdH963O4CoSMQ/cDBusoVseVD6i+dk7fG
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f49.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A stream with no measurement subsection has the shape of every stream
written before that subsection existed; loading one exercises the
conversion back from the register form. The temperature is picked so
that form reproduces it exactly, and picked in the extended range,
where the top register bit is part of the value rather than a sign.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp421-test.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/qtest/tmp421-test.c b/tests/qtest/tmp421-test.c
index 6c5332211b..5be2abc822 100644
--- a/tests/qtest/tmp421-test.c
+++ b/tests/qtest/tmp421-test.c
@@ -8,6 +8,8 @@
 
 #include "qemu/osdep.h"
 
+#include <glib/gstdio.h>
+#include "libqtest.h"
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
@@ -224,6 +226,69 @@ static void test_n_correct(void *obj, void *data, QGuestAllocator *alloc)
     }
 }
 
+static int qtest_get_temperature(QTestState *qts, const char *id,
+                                 unsigned channel)
+{
+    g_autofree char *prop = g_strdup_printf("temperature%u", channel);
+    QDict *response;
+    int ret;
+
+    response = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments': "
+                         "{ 'path': %s, 'property': %s } }", id, prop);
+    g_assert(qdict_haskey(response, "return"));
+    ret = qdict_get_int(response, "return");
+    qobject_unref(response);
+    return ret;
+}
+
+/*
+ * A stream written before the measurement was held in millidegrees carries
+ * only the register form. The subsection holding the measurement is left out
+ * whenever that form can reproduce it, so an exactly representable extended
+ * range temperature -- whose register value has its top bit set, and is not
+ * a negative number -- travels the same path such a stream takes.
+ */
+static void test_migration(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = obj;
+    g_autofree char *tmpfs = NULL;
+    g_autofree char *mig_path = NULL;
+    g_autofree char *uri = NULL;
+    GString *dest_cmdline;
+    GError *err = NULL;
+    QTestState *to;
+    QDict *rsp;
+
+    tmpfs = g_dir_make_tmp("tmp421-test-XXXXXX", &err);
+    g_assert_no_error(err);
+    g_assert(tmpfs);
+
+    mig_path = g_strdup_printf("%s/socket.mig", tmpfs);
+    uri = g_strdup_printf("unix:%s", mig_path);
+
+    i2c_set8(i2cdev, TMP421_CONFIG_REG_1, TMP421_CONFIG_RANGE);
+    set_temperature(TMP421_TEST_ID, 0, 100000);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP421_TEMP_MSB0), ==, 0xA400);
+
+    dest_cmdline = g_string_new(qos_get_current_command_line());
+    g_string_append_printf(dest_cmdline, " -incoming %s", uri);
+    to = qtest_init(dest_cmdline->str);
+
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+
+    qmp_eventwait("STOP");
+    qtest_qmp_eventwait(to, "RESUME");
+
+    g_assert_cmpint(qtest_get_temperature(to, TMP421_TEST_ID, 0), ==, 100000);
+
+    qtest_quit(to);
+    g_unlink(mig_path);
+    g_rmdir(tmpfs);
+    g_string_free(dest_cmdline, true);
+}
+
 static void tmp421_register_node(const TMP421Variant *var, const char *type,
                                  uint8_t addr)
 {
@@ -255,6 +320,7 @@ static void tmp421_register_nodes(void)
     /* Temperature encoding is variant-independent; exercise it once. */
     qos_add_test("temperature", "tmp421", test_temperature, NULL);
     qos_add_test("range-saturation", "tmp421", test_range_saturation, NULL);
+    qos_add_test("migration", "tmp421", test_migration, NULL);
 }
 
 libqos_init(tmp421_register_nodes);

-- 
2.53.0-Meta


