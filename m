Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FCECC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIkd-0001u0-Ov; Thu, 15 Oct 2026 06:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIgX-0004jM-I9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:27:44 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIgU-0004AD-Jj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:27:41 -0400
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso36389675e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060057; x=1792664857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j+gXiFsnHI5EyngmwOix3lm5w1ZzHauKps/Zt2m/+e8=;
 b=EE7RJSCeuwIs1SFXW5khBUdynG2C5q2HY8msZnWpcx3/ZVzFwA1C1AW1dP6wPetAbN
 YjqE2WvvywtWYvfYCXRh3nF+r+m6LrNaufPYlTJFHbbHR6c+oRiF7K1WjffyUa1h0y8d
 hirX+RmcTRzLA9xRbifw0IhJPdo7AzC2/KSBzTuyrBlSYgej3YmxylqRA/BLu+0FpJA4
 4B4Y9ucHYeTBV14lvjcZxks7ofW1K8rpkt/hzExuYgV3KFsi0tNwqIpbuQU+uWYccvqP
 7r1FhvI+8b+q/DwODl9WWKHtjElmw2PSNLPuiHYIqOf2RdPLI1QhDfYWGEpHJzfjtGDL
 2jBg==
X-Gm-Message-State: AFq9FYJQxHFcRpOWP1WmJKBZas6G75uW4qasE29Nm1cTniKivs6TUjfe
 LnlNin3IISYNw429sBtM7+xZZsboq+ALIuxZTDOBQiqZAdgdA4kKAhNylx7iQA==
X-Gm-Gg: AYBFou0dk3OKQStsKSBs+iQMQzzeSNXPf8APrA5ZoxSim7p1aD1tYyFQ22O8Y+hUdmR
 ReMjyXfCjaL1O5DFwiH1S0djE5djVoS54JLEuzFTdjkJSqb5IaJXlnJ8mcYkNBHMIDplErX2Pyj
 IsuHoBfWm7O4WWaISWkcXbM56WRZZFM1gLoz9KITURZbZqpq1DqK3imZ0g+9txJrGdLkbpFbnb2
 7A+/LXzjIjfc7VD6InECWQYDSIkgaXQLKZtygjF3B/jZbuWHb1/SGiciTPiROBK2i22YRnZArKq
 Suho2MF/lH3yL+ulqOnWaC524Bo/2ue8gARBMMoNMgwEDNrieBuW49Vl9xoWUIuCSyqCYuQ0wBT
 6mT2v/J0AGEJ4mm3h7CEw0dW0FsVkQaMUefLRwt3klGuXUeTwdwiUqCuAYZixITrb2op7aPgnT8
 7l0zY5sc6pR2G7hwump4KGyLc8k8V0tKTJ/YnZ+TnpV4EF0uPFro4+g2qqsQyy3ace4o+OlYCgi
 IcbF2g80FlnPfkWg72JF2mPThgy4miGvGdThiFIm7HfXPD2Wk2PWb7Z
X-Received: by 2002:a05:600c:4fc1:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-4a19a9cf1e6mr263903215e9.30.1792060056679; 
 Thu, 15 Oct 2026 03:27:36 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df8316eeesm1568782f8f.7.2026.10.15.03.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:27:36 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:18 +0200
Subject: [PATCH v3 31/50] tests/qtest: ds1339: cover the migration round trip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-31-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056476; l=3505;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=EVk3l6BltgZHiZGej4u7LBFepngMOkTM/mSpC5HjJ9U=;
 b=LZZuXY0lVtEZGbFEiBFwSZZ42yaNS/YjEYhlpQZ0fmcnAhmyG7k0sEja/N99iBNQiDAU5Qojw
 /BqRDS+TUJuCAI4V6OrWMTLEQ4wyCB82cYFrJuQerOeHJc9WIK2TAbG
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.42; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f42.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
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

Nothing covered the migration of the register file or the oscillator
state, so a dropped field or a wrong version gate would have gone
unnoticed.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index a1b5afb331..ca2378aa34 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -7,9 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+
+#include <glib/gstdio.h>
+
 #include "qemu/bcd.h"
 #include "libqtest.h"
 #include "libqtest-single.h"
+#include "libqos/qgraph.h"
 #include "libqos/i2c.h"
 #include "qobject/qdict.h"
 
@@ -475,6 +479,62 @@ static void test_reset_persists(void *obj, void *data, QGuestAllocator *alloc)
     check_reset((QI2CDevice *)obj, true);
 }
 
+/* The register file, the Century bit and a stopped clock all migrate. */
+static void test_migration(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    /* 23:59:59 on the last day of 2099, Century set. */
+    const uint8_t tod[7] = { 0x59, 0x59, 0x23, 0x03, 0x31, 0x8c, 0x99 };
+    g_autofree char *tmpfs = NULL;
+    g_autofree char *mig_path = NULL;
+    g_autofree char *uri = NULL;
+    GString *dest_cmdline;
+    GError *err = NULL;
+    QTestState *from, *to;
+    uint8_t resp[7];
+    QDict *rsp;
+
+    tmpfs = g_dir_make_tmp("ds1339-test-XXXXXX", &err);
+    g_assert_no_error(err);
+    g_assert(tmpfs);
+
+    mig_path = g_strdup_printf("%s/socket.mig", tmpfs);
+    uri = g_strdup_printf("unix:%s", mig_path);
+
+    /* Stop the clock first, so both sides have the same time to compare. */
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+    i2c_set8(i2cdev, DS1339_ALARM1, 0xa5);
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
+    from = i2cdev->bus->qts;
+    i2cdev->bus->qts = to;
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmpmem(resp, sizeof(resp), tod, sizeof(tod));
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_ALARM1), ==, 0xa5);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL), ==, 0x18 | 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+
+    i2cdev->bus->qts = from;
+
+    qtest_quit(to);
+    g_unlink(mig_path);
+    g_rmdir(tmpfs);
+    g_string_free(dest_cmdline, true);
+}
+
 static void ds1339_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -509,6 +569,7 @@ static void ds1339_register_nodes(void)
     qos_add_test("alarm-registers", "ds1339", test_alarm_registers,
                  NULL);
     qos_add_test("reset-clears", "ds1339", test_reset_clears, NULL);
+    qos_add_test("migration", "ds1339", test_migration, NULL);
 
     opts.extra_device_opts = "address=0x68,persist-on-reset=on";
     qos_node_create_driver_named("ds1339-persist", "ds1339", i2c_device_create);

-- 
2.53.0-Meta


