Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A3606A33C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtob-0005Qy-TP; Thu, 05 Nov 2026 04:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtoa-0005Mw-3b
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:24 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtoX-0007PP-WE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:23 -0500
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso248653a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793871080; x=1794475880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MoxM5c4druc6hrP13chgHZYE5IKLOb3cz4rjvIwFDIY=;
 b=A7Qda6TYi/Y0DyADe9frKWjKF8AgblJZr3x4B2x1ICVQ1OWoajm/ih54uSgf6YIqOS
 MuRcERVmuJ1M+//amoRTqpjygC5Fh01tgm6A3jjcOSIss4FLQGaRsEesXUzapAxwlV2e
 r+5OcbL0DlUfky60dx5kWBuuTIh7gfTHjoILB785N7H0LQQGo+xhOEOOFXyxlMRs5TxX
 +Q+xym7+0vOP2+KQE13enIj2cXa71okQiYOTK5+YpfIF1dSAl108F3Ni367dTctV7oI7
 hRs33KB9ILQGOkmXws/fgf0vurtdH4yVtMs6cUJGss1SjPKYHHdjzT5Kl0zzWhU80g6i
 vxZQ==
X-Gm-Message-State: APuU4Z+uKehWBu1Xp38cLgkf36Mqt2qufwkLv5pkGrv/FpHtElL5B1gT
 b9mxdGw3lfBWONYrdyhLqdtAqfG87SrlJJqn6proENj9Mw21rImpNoTJBuHK18BDXAo=
X-Gm-Gg: AYBFou0H9dOTYKrltQpHm0M/SrcSC5YCl+4LK0D0q+bXyZDJSqjLq1VQ7iTHKShqBUt
 qKoFY96DIFJ/mU0RXIA19rFM27MyYKI63maqzYlaec+uZOxknOWXDbm+ZaURNu/4cDalGOwNRn3
 STyCuUk/azxzDupiDVk9FCII0QHhC0k4EmJRkxk1wKZeGHe0x1xASpFj7xZHp4g7kwiTeD25sIa
 xeOGYei4Oxi54wlwWKg4atFrYuakXM1STuuZxht8Irun4jcn8XfHCGebq/J3mZw60lD4PCYpL2t
 VcauTevsjWDRlKsLnhCRzGH0NAmXjfqfzU/FpsBV+pg9wZks8ztldoMEwwMMhmwgrRGKd/GNdV6
 yZGL26QnOeOz/wGMdZf4c/jbGAYjCMAj/NSSsh/wgiSW2CLMndRKXxT6yQ4mJU69OnjXvMa3aOX
 DS3RJZPcmvEQagjXZr8JKP8vhbNJ4M7OttqAQEF9aVlHD0PgEMh+8w/wqfXtNi56fa9XgSj1hvB
 FA7lbx/8H87V0oOcZf2RwJkh+9o+b1mwYNGY4DF+p4r1ryB7CLYdDCjBJlvdouYiR5Oc1y9+eLz
 HHjeiVuaivpqeDqz84H5ttNrp+HubZgxKSc/Wo63u2ZNaPus5aIvcVoxYm2FnWqTqZTksA2CdGo
 l
X-Received: by 2002:a17:90b:2649:b0:3ab:d26b:c2df with SMTP id
 98e67ed59e1d1-3b0afc5e2a6mr1219290a91.27.1793871080197; 
 Thu, 05 Nov 2026 01:31:20 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b323c18fsm2915320a91.4.2026.11.05.01.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:31:19 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:54 +0800
Subject: [PATCH 2/4] tests/qtest: tmp105: cover the TMP1075 device ID and
 reset defaults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp1075-v1-2-d2ee5da0b880@free.fr>
References: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
In-Reply-To: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870754; l=2634;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=C0jpl30ify3Wt49PXTihQ8qoGkN1Yk7KjYV9D5fof48=;
 b=plW/zXfTNole/MHxymlspKKJXWVd6fUuUcvZroQaP92M8BoTcOTSEj9r1VqBP7uf48uqGOu0e
 zlnSg0WjJGPChnJDmiDPZv4+sCLPg/cjl+cy/RiwzVAFuSCjswGSZaP
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f54.google.com
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

Add a TMP1075 node and check its power-on Config, limit and Device ID
register values, including that the Device ID register is read-only.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp105-test.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 504f6b7202..426c4f9ae7 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -28,6 +28,8 @@
 #define LM75B_TEST_ID    "lm75b-test"
 #define LM75B_TEST_PATH  "/machine/peripheral/" LM75B_TEST_ID
 
+#define TMP1075_TEST_ID  "tmp1075-test"
+
 #define TMP105_CONFIG_POL   (1 << 2)   /* ALERT active-high when set */
 #define TMP105_CONFIG_TM    (1 << 1)   /* interrupt (thermostat) mode */
 #define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
@@ -419,6 +421,26 @@ static void test_lm75b_shutdown_clears_alert(void *obj, void *data,
     g_assert_false(get_irq(0));
 }
 
+/*
+ * The TMP1075 answers a read-only Device ID register and powers up with the
+ * modern reset defaults.
+ */
+static void test_tmp1075_device_id(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_CONFIG), ==, 0x00ff);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x4b00);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x5000);
+
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_DIE_ID), ==,
+                    TMP1075_DEVICE_ID);
+    i2c_set16(i2cdev, TMP105_REG_DIE_ID, 0x1234);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_DIE_ID), ==,
+                    TMP1075_DEVICE_ID);
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -475,5 +497,16 @@ static void tmp105_register_nodes(void)
     qos_add_test("limits", "lm75b", test_lm75b_limits, NULL);
     qos_add_test("shutdown-clears-alert", "lm75b",
                  test_lm75b_shutdown_clears_alert, NULL);
+
+    /* TMP1075: 16-bit Config register and a Device ID register. */
+    QOSGraphEdgeOptions tmp1075_opts = {
+        .extra_device_opts = "id=" TMP1075_TEST_ID ",address=0x4d"
+    };
+    add_qi2c_address(&tmp1075_opts, &(QI2CAddress) { 0x4d });
+
+    qos_node_create_driver("tmp1075", i2c_device_create);
+    qos_node_consumes("tmp1075", "i2c-bus", &tmp1075_opts);
+
+    qos_add_test("device-id", "tmp1075", test_tmp1075_device_id, NULL);
 }
 libqos_init(tmp105_register_nodes);

-- 
2.53.0-Meta


