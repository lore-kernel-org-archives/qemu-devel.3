Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B166BC79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cV2-0000ur-E4; Mon, 07 Sep 2026 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cUz-0000fp-Hv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:47:13 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cUx-0003ms-Le
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:47:13 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso16167755e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799630; x=1789404430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T0UIfa5fY9UvW53K8vxfMmiR1L171Gz3N0KwneftI8Y=;
 b=Gh3yGh2vp+H0r1gqP7rdsC8AeL3vx0YAAD0Xo2gyF2USQeBt9VcKEkgvuqR6E/fd8n
 YeWZyxRqfi1AbUrAPpMTwqWHXKeddhIIbAnAzQ97r0Zmky5L7C5w82JNKGQ8FPvwqbkQ
 fCtHZdG1GZkpq7Lk3KGumgCTzIiUNYg3kYKcJmy1C3NMpnX+htHPw1TDEgC6pGB3b46u
 HXUoI3478qdk25dshGb9Xh1AqQJixQmMCAadfGJYPVxHARRwHH1+tphHFiRVvnV8zNmi
 y60Zj78plbv942k/l8c93oUJC/1om37cuerztMHBeRcWAkI8fh75UzrvAXRi10PoLWgd
 HwHA==
X-Gm-Message-State: AFuF++nZxo+UhYx5/2N4W4FGgSIuL9mB/ckI6T6DESRvAxba2GOJCDuI
 2ArjIFnc/Ae2N8jDYkzIHc1taiovOqOM7DYMs4m2MwuyaJlFR9xCEKOU07CAhMHd
X-Gm-Gg: AYBFou2EfJf5GbFjhiX2aH6/nrV55Yk6LX4k310jFICgRfxaS/1tA/ntH3nb43SMEpM
 Kll8rvuJf0LmR26z48/qcDNjnquWpAiR/ojh2evi0KrEcPEFkquJCKQ2Ro3aELi2Hvi/Ex/PyHH
 Ol/t/bg+UU3EAyPDfBcdzrCnafTjnvlsV58liHD5RdS7PVJOddpOBkxqN6cf03HMag+yXc28ujB
 TF/jmDbCntJwY9DmmVo2unYzYQVh05NEzyMY8+QIi9OseV390WHQB3mn86mUTmVW/rLr1kuzPtM
 X9I21gU6vbu2YCNdTAhtB1ML8gD/5GC9/rCxK+W7dgm5HmiLgBsNO3JT/xC/5qNoeO1WVnjbjWu
 f+QvyC733Doxh/05kxqj46+Ap5OEVOOKgM4ZO3f3aTtxjzHw9uvcKVaJ4BTVWT7VKRGYsJ2wYtB
 UKJvkAz/E7YWW7JltxBuphn8Tlmprvh8zqKV7k6KgaP+59e7vIRQFnHVzWPkixyuhMfW110cQm+
 QlotvgsRmaWPm0rtnzkknogj0NoQ2prfQ7zplBueCvLog==
X-Received: by 2002:a05:600c:6383:b0:49c:f4ff:e872 with SMTP id
 5b1f17b1804b1-49cf820507cmr215989205e9.5.1788799630057; 
 Mon, 07 Sep 2026 09:47:10 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d00a5b19dsm256222355e9.2.2026.09.07.09.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:47:09 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:14 +0200
Subject: [PATCH 24/50] tests/qtest: ds1339: cover power-on defaults and
 reserved-bit masking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-24-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799321; l=3426;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=g7DB+ARtVObCPTzzGVKyyO/c/Gk+v4O2cZLGywD17yk=;
 b=vcswS77pIlQV6xFSH92vNxW0UN1CME1XB8GZiB7Jeo01zdFXBkJrP0Nw6t4Czzbynlpaaq9NA
 r+17S5SzciDAjAn6B7jwDTANIrHl0Er5FaTLKU6r+9PYR2mtwQx4CDR
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f52.google.com
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
2.50.1


