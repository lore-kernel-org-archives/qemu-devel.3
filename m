Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED3606A332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtp5-0005y9-M0; Thu, 05 Nov 2026 04:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtoo-0005lQ-Vu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:39 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOton-0007QH-8g
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:38 -0500
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3b0bbdeae06so214455a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793871096; x=1794475896;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6k06hv6TlsIcMhbYVsrL8kcfuMSG0eFTZp4YScCwOos=;
 b=XiR9IBuWWfY7jdbJHYl9iyVHN9TN6gdiDWy4d5tVpMUIzp6XVbk9xeviu96SbJYKA3
 hC0vyK01+uiahGmqKFlHKbWQCerzs/agYekw/zgrQ7YDmLjEHFsOGGUgWevL7V20fkYI
 q3Ls1eelSNmtujnBSafEsKRhVmLaCyzGoTyDtQheq9BqLCmOzRm4g3nJJf/ZzDznf9zd
 DXnuViO+nd3nEwu+jQjl0Y9FqW6AWr+XGjZMeN9Avd3FFQWeCSrwNDghMzLahDgSoZM2
 WvJWG3doyYlM1QifWdeIpzsjjuvQl/4HMSQTTdcevolv96JQge5Zdbgkuk+7hKDFcxLi
 +AwA==
X-Gm-Message-State: APuU4Z+xcxKtVFaeoLtluiZermxA9PbBuuEr4YqhkcY5hkBl66JWlUY7
 s62Nr45gFIaBs6Tt8oCJPW3BL5jhxrUJZU170LLfde5US2iW54S80VFAIs1JlQ==
X-Gm-Gg: AYBFou2luTZHd1wMcoC70u7qyf/knFYpvxqHy+G9ZZF95YxgBI2V6jnp6m56QhkQ6dk
 JSnEakvLVaTrpw6ocaXld3d83zINI0fEmwF2ur+WbYTGeaai+wo9TH+++yU7Ectwzu+SYf326Zx
 Y+XkHWTDAyXuFpkoP2rCFT6vwu7fxOHEXqyTtLyEwl8xWgYLebzmKJwm/W/9HHAEiM/lj9qA8ut
 nBTN+RBGlQlPngrUMTSzF/+4Ar9UUs6C90oS9I+T0vFWp/HIZy9NhdeczPBsxxdEDPOTmagzPPT
 Qp1FXmlgLy4pmb1m+//JJeWtQ8qVEg2awRX+zmjqt6EaTGxvV3bt00gXcTpllSzDNRjVTM/+eHw
 hSrf/ia41eA2oPCznkcuDogbAml+J9dwYuLPdN7CsZkvAAF4EJmUtTHiJtdx1oya8ruSKUgqHRW
 wEpa7rjsdoAnPFxgELV2I3efUZon2edplVkutzD3b4Cg1SYU7PZZ2YZdnYF5TBz/BOnZoM9XtaG
 1lP00VZjgz0u462NV/vjNm+39Fmp5RSJThcrpIP5tVfT09/hD2Q4wLPIHxZwoECChnVY3nyyaD4
 YBpI5A0auSO7mY1LJLKo4ojmqunhPUt9zpP46JnZlmynAVr9aTRS7JLBtzoTH9O7JZbf1TbTHwP
 /
X-Received: by 2002:a17:90b:3b51:b0:3ac:d19e:85f1 with SMTP id
 98e67ed59e1d1-3ae897dc967mr15460486a91.53.1793871095779; 
 Thu, 05 Nov 2026 01:31:35 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b32b6507sm3379586a91.16.2026.11.05.01.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:31:35 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:56 +0800
Subject: [PATCH 4/4] tests/qtest: tmp105: cover the Config low byte across
 a migration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp1075-v1-4-d2ee5da0b880@free.fr>
References: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
In-Reply-To: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870754; l=2836;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=/7gRDZ/TdLiUJ6z39Z25ycHPu6U7M4Ou+l3WbL5867o=;
 b=IETrN1sTGvhuYagfjsUO99jc1TbJd+8JfuCPkKmTXcc3op7xubi7uccNuaMM46tEdgUDMW3yh
 NpIWMdXhPICBF1XyUq3AC0ugB8BScf29d03rrRcQoSmSXr5UjCHL3mM
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f50.google.com
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

The byte rides in an optional subsection, so a dropped field or a wrong
needed() gate would have gone unnoticed.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp105-test.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index b21deb1128..1bb7dcc265 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -9,6 +9,9 @@
 
 #include "qemu/osdep.h"
 
+#include <glib/gstdio.h>
+
+#include "libqtest.h"
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
@@ -468,6 +471,52 @@ static void test_tmp1075_config_width(void *obj, void *data,
     g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x00);
 }
 
+/* The low byte of the Config register rides in an optional subsection. */
+static void test_tmp1075_migration(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    g_autofree char *tmpfs = NULL;
+    g_autofree char *mig_path = NULL;
+    g_autofree char *uri = NULL;
+    GString *dest_cmdline;
+    GError *err = NULL;
+    QTestState *from, *to;
+    QDict *rsp;
+
+    tmpfs = g_dir_make_tmp("tmp1075-test-XXXXXX", &err);
+    g_assert_no_error(err);
+    g_assert(tmpfs);
+
+    mig_path = g_strdup_printf("%s/socket.mig", tmpfs);
+    uri = g_strdup_printf("unix:%s", mig_path);
+
+    /* A low byte away from its reset value, so the subsection is emitted. */
+    i2c_set16(i2cdev, TMP105_REG_CONFIG, 0x605a);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_CONFIG), ==, 0x605a);
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
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_CONFIG), ==, 0x605a);
+    i2cdev->bus->qts = from;
+
+    qtest_quit(to);
+    g_unlink(mig_path);
+    g_rmdir(tmpfs);
+    g_string_free(dest_cmdline, true);
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -536,5 +585,6 @@ static void tmp105_register_nodes(void)
 
     qos_add_test("device-id", "tmp1075", test_tmp1075_device_id, NULL);
     qos_add_test("config-width", "tmp1075", test_tmp1075_config_width, NULL);
+    qos_add_test("migration", "tmp1075", test_tmp1075_migration, NULL);
 }
 libqos_init(tmp105_register_nodes);

-- 
2.53.0-Meta


