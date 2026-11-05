Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF4606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtIo-0004gn-OS; Thu, 05 Nov 2026 03:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIe-0004Qy-8d
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:26 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIc-0003mg-3t
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:23 -0500
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3b08a162d4bso1144823a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869100; x=1794473900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T+aQuOytqkO9L6viQdmuDORw5uxFjnolQFIJ54bA1P8=;
 b=KoCapjSv+NLQUrsm6LWu5Uj5l68i57NraYQRfv4PLf2WwMpOsGoxtXdxHC1UHLA80W
 L/ORItlayP7cNcqHsYo+c148ErU8KL7LIPPiIw2JDowjroYbKA+UnrH+gpSbyrlcjCdO
 kI6FnmQaWWerheE+Jh6K82x+fS/AO04dQkZdd6ITIEBUbdDrn5lL+ZXmTMP1DWg0/CXC
 9ZmBPoycx+86Xh6NF0eWGjAghcjpzJV9jAT8kKWCdW+uU1nsnqI9gMJ5lDa4WHpib9fY
 eIa3L4l6D2qOKx7+BVHSj2as4tykWzncFGUq/Jiui2/86MrfrV5KqvZ9N1veJzouE1Vw
 4YUg==
X-Gm-Message-State: APuU4Z/iMlnzCrLyU0H7MaZ0qmOqjurrRI0ujlxIlpH3zBGnUiLEKaYm
 2GNPckE/DHkLOoR8aPE7OOKOYTf7JtA7VHYse+I1PD4HZt7gkJ082SgGRw082gUp1zc=
X-Gm-Gg: AYBFou3W6T/I5Jn0O4JyRIFo7rWHF/rn60Kb8h0flWxj5i/ut+6bFAkNYocpfXJzMpy
 YChhhE0wVou1L8gk8o6JJT1sFpHTvH8IXMp6I+T7BsFbJGzTVtZOEaE35ocOHD7u119HFEq2110
 AWrvDnqBgPVT6Fenn4MI3QQVbyq2Dxr6j1DHUc6ABJuYdI4eEq09wEHiO8xAY/FLYyoeiCgpgPG
 7Dxc8CAdbd3IfBOgoYJcabfofZhcYtlxwDbAVHlSTq4m04KbYJS/Rzo3LVNjvUW36xF3x0Lf61v
 lCx3UDsVKjPYHv7FU7MLMB2lTnkhcNYuU0ZSn+NKVuzMIk1GJ9s7ACpsa2pOYzxyPR8agMeKtve
 9MVwPe0mmNfYnDEiLZ6ExywZOySTlVVQyv/PAV8daCo+XtyTSm6q/llvaaSTpWCBr/qTgE+/TAx
 2VTNkRtFJ1zgKvU1TgR9AihfhJZOrFXvViRwlCeBU5xGxcm7v8aJFZS/dAXuhPV3CmAyWRTXV9T
 KMPiveCQm05qGzQ6IxCnvuX8hb7bewnqGsrcf2/mBNyLAatkjh4PdU556eMhFlUtmmcMCGbIYLE
 cgVTDVhMeV5n0NVtA4Q7U8r3+qqXBUTl6tWUzF4EN5OsyR+k81LYTjN6vdZr/BoCoG19PShFXm3
 sDDq7eVAbQP7ZWfJKaGONSKxesNU=
X-Received: by 2002:a17:90b:440d:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3ae897f8c6fmr14253255a91.30.1793869100051; 
 Thu, 05 Nov 2026 00:58:20 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b3131f8csm3122209a91.2.2026.11.05.00.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:19 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:48 +0800
Subject: [PATCH 12/19] tests/qtest: ds1339: cover power-on defaults and
 reserved-bit masking
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-12-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=3431;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=4kpdPaxvZVkT90Xwee/1AVTNKhV96yGus/onpPPZ95Q=;
 b=cAyl8nSVGv4OeaAiHI5rybYAtkTOV3dIMJX45zJGqhhwnk5B5h8UrhOKDnXFliuWT0NqiRUry
 Nbrd3sGjDiJC1YWInMSEGas/OUwCVgaPh116S4bbKhY7E7X3fjYK8Wa
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f41.google.com
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

Neither the power-on defaults nor the reserved bits of the register
file were pinned.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index 08fc16acda..e9dcdc36da 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -74,6 +74,53 @@ static void test_osf_write_protect(void *obj, void *data,
     g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
 }
 
+/* The control and status registers come up in their power-on state. */
+static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_CONTROL), ==, 0x18);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+}
+
+/* Neither the reserved status bits nor the alarm flags are guest-writable. */
+static void test_status_register(void *obj, void *data,
+                                 QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_STATUS, 0x7c);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==, 0x00);
+
+    i2c_set8(i2cdev, DS1339_STATUS, 0x03);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==, 0x00);
+
+    i2c_set8(i2cdev, DS1339_STATUS, 0xff);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS), ==, 0x00);
+}
+
+/* Reserved time-register bits read back zero even with the clock stopped. */
+static void test_stopped_reserved_bits(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    const uint8_t all_ones[7] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+    uint8_t resp[7];
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    i2c_write_block(i2cdev, DS1339_SECONDS, all_ones, sizeof(all_ones));
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmphex(resp[0], ==, 0x7f);
+    g_assert_cmphex(resp[1], ==, 0x7f);
+    g_assert_cmphex(resp[2], ==, 0x7f);
+    g_assert_cmphex(resp[3], ==, 0x07);
+    g_assert_cmphex(resp[4], ==, 0x3f);
+    g_assert_cmphex(resp[5], ==, 0x9f);
+    g_assert_cmphex(resp[6], ==, 0xff);
+}
+
 /* The register pointer wraps at the end of the map. */
 static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -155,8 +202,12 @@ static void ds1339_register_nodes(void)
     qos_node_consumes("ds1339", "i2c-bus", &opts);
 
     qos_add_test("time", "ds1339", test_time, NULL);
+    qos_add_test("reset-defaults", "ds1339", test_reset_defaults, NULL);
     qos_add_test("control-register", "ds1339", test_control_register, NULL);
+    qos_add_test("status-register", "ds1339", test_status_register, NULL);
     qos_add_test("osf-write-protect", "ds1339", test_osf_write_protect, NULL);
+    qos_add_test("stopped-reserved-bits", "ds1339",
+                 test_stopped_reserved_bits, NULL);
     qos_add_test("address-wrap", "ds1339", test_address_wrap, NULL);
     qos_add_test("block-wrap", "ds1339", test_block_wrap, NULL);
     qos_add_test("alarm-registers", "ds1339", test_alarm_registers,

-- 
2.53.0-Meta


