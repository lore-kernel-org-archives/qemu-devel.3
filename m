Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEE7C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cWM-0004jM-O2; Mon, 07 Sep 2026 12:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cWK-0004gB-OQ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:36 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cWI-00040b-NN
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:48:36 -0400
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495590dde14so54042635e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799713; x=1789404513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RnkBBeLG1eQDE9P6Yi95zQOq3H0LATrNJD3fWP7niYw=;
 b=TI+nDieLtpriHLmNQ84ay5eUREmHesXZjpt1S1U+3BEiRLSAD7uwo0lFADzg/D20Eq
 W23Q9QLs26Q483VS+fMCDLlpqgowNvtW7zMfRRBFbR1kdU1HidHZosBuY+aoFU5Ls6oP
 aAXiQ8SgzbFFpJ8aXTMtBUZqU2QW6IjhIZ+2rl3iP7Em2894znxvgMUqgU+HXGQMKwA6
 vWGStKjoKoNsDE/r+hs0tlvUK/s9H+iXt+hd7OeSG3ceY5xAmwPVoz+d8ngdC68k3AaY
 cGtqvSnuzhTK2O0zanGlQ1hREFk8u0WmMsW2RW1mpjFvP/JQ1r40ZVSxYNikaGNmFHg5
 FP5Q==
X-Gm-Message-State: AFuF++mInkfUcORRs5acfdni1+Vh4bWNEvlwR1Xk3PgV2H6k0kmUTCgx
 sUNKlSwvTcjaD8rNatYuxO1iUMZaAeUl6EI5ubXy7pwiZIt+3oSLw/E+3fVaq+I5
X-Gm-Gg: AYBFou3OtLGu2FLuTAwqwkz6d5iIfa1VQRTGubQ1fM2Kv+Dh3EmS7QJZNDJCBFGeOdr
 pzCYGV+Xk8hkbA3kx12mlQBG0sCg21GOmMySrt7IlXITINh6wy1LmmKMn9tDpnryRagqNkLYpmi
 7E5b+IOTJmh/daVGaTA3VRX74P+xkzJ4bffZNULjXbuQERT9lCNeJO778k+dInJtyjs3OWbizzs
 u4LEoQNfoQh/MJkwCZ1XR+nY6QE4TlAfnKsv6AB02DWxjaO4nKtbgAtV3Oi1GRZlkwONogWR0hQ
 +Ljh1NrmiiIf1leXnoUS2J8hkMSfkpj2Lfg0Fw2k/Iygv0SxrPrb3krWDvNVgFR4X2xb72UB9Je
 fH0Vadx2ePRWnL1U7mlPukWWvuwxHai81Mic+kYtwdVP9vT3I5BOapHiOpcvjFQqMEPR0R6xYzh
 8NHA6fA+mKxWfW6aSJ5WQa16qfI0JoPGcUAt0gS2YWpT0cJ66pwgm75OXo+BzHwhiZ2HfmhLNoT
 MifbCJWWqoDGWjM3lcn28a2j7Nqibz3JAIvR5mwJqi9ZXU=
X-Received: by 2002:a05:600c:468b:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49cf8214eaemr417058335e9.8.1788799712977; 
 Mon, 07 Sep 2026 09:48:32 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm22111509f8f.20.2026.09.07.09.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:48:32 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:21 +0200
Subject: [PATCH 31/50] tests/qtest: ds1339: cover the migration round trip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-31-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799321; l=3500;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=BGMUGmamSzCjRMfmtfuZ7L1tiySTP5BVtx1tPB5MRVw=;
 b=G4/lsIrREMbyh33JJLmAuv/nzTrFbZO/vkDL9IAKhpr2+RDXMANBzrHtccpEjfLG9cNlDvAZ5
 dI8W4bCUtMzAqSBCDddjRyWEw0AgnZz0unNUjly8dphi6Q0nh/EMZW4
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f43.google.com
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
2.50.1


