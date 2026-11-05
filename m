Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5340606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtJl-0008GW-QI; Thu, 05 Nov 2026 03:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJZ-0007yp-CB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:59:23 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtJU-0003tf-D2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:59:19 -0500
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so691921a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869155; x=1794473955;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j+gXiFsnHI5EyngmwOix3lm5w1ZzHauKps/Zt2m/+e8=;
 b=aAxDGpwq8nsAuagFHAom3Y3r3GRRnMvwNjFfcrBGOQ24ZDRhTKUhRhvjQwYw/xFhTm
 /Vh3vMLfmBFgf5cLwJmNMtGkVhQVrGrQBM+0UmvceDvtMBRDivJRTuiEdmBsLBU3bOW3
 6VEiP2ws4PPHm9P97u7lLcGuoOplzN0baPb1ypCsPmxe+ImdvaNdYKE0wbYwpCwJSgth
 bagV+oQXNa4ll+qg9wZjuQglVI81xPHuVaegX8Qkz0LgSe60VHrRvFSUsexx2MAKP59O
 2Oa2AlM6jC5YqoSS0eSENjN3h50/qk8hPkHrZrF/pwpELFSfziZiCC9YgWajDUnpeEX+
 TiKw==
X-Gm-Message-State: APuU4Z98CVySiMjjzESeQySp5HxN/T6cj4NmtebB0Huy8YhFbI5h2qj+
 m4jlc4X7tMa28TyBtbIhv/353cRjspp+/V4wHbTzrXc8OjNA12qSmP0VDh9vIbzmLic=
X-Gm-Gg: AYBFou2SSI8jL/LXGFuxks80Lba1RIii8TlMiP4IDHAN9e287cM0fkKW/dGjs6WkAhu
 l34W89NtKUQ9llZGrvV0ZAu14u5jGINfhnPWHoACDAttfUe2Yb8jP5xB1+xi2hvW5Yp3tECmUcU
 FI8CFXq81ArnK9nO9VlXbXIOzGGTKiT2wEdMzZKXO/FclEhICyTZoyEyCxq638C7+t9RGFIQLq2
 wBgV5dvDlYecF/gtfdBMBVvz28uPaKy10m1P2+RSCqVwcIrCX1lKqeF8gGA39fBd+PfmHY97W8x
 Fx9Gki9T+PZ/aBpqO8JIcFrHJHVB+ykeAwuxkEYknsUM+Hswowywku/w6BmeQV/rb3HmdSsXwOo
 ZRac4wji+IeRWQOV0Qv+4bYvff2gKg7SRE5UJTKHyvWRdB5i4c/1Zc9UBr2R1etdXzbdbWGh7+P
 MWrJhUjPzinYonqxoXj0CtiwvRY45y4Be1nTKR0iGhsfx/wyxknwK4sDbeEG4GBdA5TI+yF8fBf
 mAMKLqB3osOJd+KCOYfzw4prH8/ughoi5vxR3hwhHXId8DxwNLrNRpg1hesu/+PJd7Se3xlLaEz
 MEkWj9xV3ed6nlvjaiW2zY3TB+Zs51ieXCoKzUOG2QA4l5iv5Y6/g1yMal5NVKU/x5AXA9uWl4/
 MNgdqLQ==
X-Received: by 2002:a17:90b:2711:b0:3ac:7449:40b4 with SMTP id
 98e67ed59e1d1-3ae8981bdebmr13627664a91.45.1793869154888; 
 Thu, 05 Nov 2026 00:59:14 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b313c0dcsm2904124a91.1.2026.11.05.00.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:59:14 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:55 +0800
Subject: [PATCH 19/19] tests/qtest: ds1339: cover the migration round trip
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-19-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868641; l=3505;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=EVk3l6BltgZHiZGej4u7LBFepngMOkTM/mSpC5HjJ9U=;
 b=3m41MzT78EtX/lzWApcElgYPcba0rBS/xcTaPu3c32CRiVNhVpsX3oPZKq8qwHO2fDaoP1r9c
 eSBlAsEJHHVDsxShGGHlBiMebK0KfU6M+aKV4JAGUdK0+9ZNxZonQzQ
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.182; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f182.google.com
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


