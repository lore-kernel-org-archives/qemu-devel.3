Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA48CCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIh4-0007Fd-C6; Thu, 15 Oct 2026 06:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIfs-0003Bp-9a
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:27:01 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIfp-000408-Ov
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:26:59 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so49417765e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060016; x=1792664816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=56pPJS+C8la1MYmTdNNflpT7tU5QoCQdslzftdKxEFk=;
 b=pEqVQlaW60Iqdll2yX26ljhpYwWDS9c0U1QFDm1I6cwqAlLA0gPTcBPCq/SZtmhgYd
 FUDTYENkmVMhuTH3+MjbEooaChmSkJb4l4F8y3RqGRYTyK/gskLXzc2W9EO5A8XEZ4aw
 t0EyH3Z3rHuTEC4HIsKY6wBMO42qMvYKOMQd6gpae3MuaXGDaaZ3YEAW6rivq7tkF79a
 UrcHiF8sRfssbdwA2hhr87c4gsndehewdAREnkiaHxvhhlJJNOwJZ7CXj7Cah2SQEfcI
 C5NEf1Uc3fcOR+YbYU7ZE9Rwh9Of99tKr8wfPFnfC51uqI06nbbK1oORhahJfbc9sIEF
 1Lqg==
X-Gm-Message-State: AFq9FYItYjEBaAhq9DOn/+SOhkDiGo64CKDV6RmgFi5dcZmLnoR0lX/5
 z6SAS5hxz5ca26KZsF6rglrnKS66OF7vtsyv0oxjsB9E1WnS+OLfGcXMOdZEAQ==
X-Gm-Gg: AYBFou2DAfmpDBZQmZE+mcHzVpzqsVBVoC4wH1zC7uBhN4jayAQbFKSaFCJk46GQq03
 miLEA2zu4nL5MKtUBXhy254MRUiLTvvLBPJJ5ma2czZY+n314cH9PkbXiC22KiOcb0yEsAr2OYp
 obSucOUpZOurOgcQYUELbsM0doFD20JIOxNc7QGru5HQQA70MCySKQ/ZlbLlziZ4t7UfGhSu4OS
 MmKwCnx/Z4QLWjMjnmElIewJfNc4qLCldCxSM/Y1qLhGNQs8QlWIG6TD2+elWJbl3DuqJchyjpT
 C1LtXM+rmqsqcuMaANXXEr5S4tr1sIzxurltZ7BkIv/QSjKsXFQ9LLmK3F3PlU0qi8GRxcrLZpg
 1nKl3jBvfoOUwG7KTBkL6pmWMh8/xGSeiKO/ts6P2r01xCOoEQer9Pt3t4Kh0Fx33+QqVATO9hK
 A8FizkRymq95Q9SL4i5pTdYB7Lz2GcXNBRLAZFAW6zAKmeS/wILao64lcY9RGn9uYCgBt6JRCMR
 55oAwFt/MJ4F2awyFeC74b/OwJCatmOhcsGxjFcBw216w==
X-Received: by 2002:a05:600c:8b78:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4a18e47acf5mr423689705e9.11.1792060016020; 
 Thu, 15 Oct 2026 03:26:56 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd640be0sm46359345e9.1.2026.10.15.03.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:26:55 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:12 +0200
Subject: [PATCH v3 25/50] tests/qtest: ds1339: cover oscillator
 stop/restart and time programming
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-25-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056476; l=3347;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=/xAI0glxvoShi8yf2NDQf97RUj4tlRYLrP33FMRgSlE=;
 b=zr3AKn9i6hoq3w9SttatANgLcuIh3yUjZ9ACrp8U08HFQ/ENL5LS7oUvHjkwblJre3dKMHPy6
 zLunB35kHWKBAvipJUkz7mlJA99ecM5iaDU4JdKNOtMYidCoKfW5lk6
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f49.google.com
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

Stopping and restarting the oscillator had no coverage, nor did the
time the clock resumes from.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index e9dcdc36da..ac19ebd71d 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -121,6 +121,54 @@ static void test_stopped_reserved_bits(void *obj, void *data,
     g_assert_cmphex(resp[6], ==, 0xff);
 }
 
+/* Setting EOSC stops the oscillator and sets OSF; OSF outlives the restart. */
+static void test_eosc(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+}
+
+/* A stopped clock resumes from the time it was programmed with. */
+static void test_eosc_restart(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    /* 10:20:30 on the 12th of July 2031, the day counter reading 2. */
+    const uint8_t tod[7] = { 0x30, 0x20, 0x10, 0x02, 0x12, 0x07, 0x31 };
+    uint8_t resp[7];
+    unsigned idx;
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmpmem(resp, sizeof(resp), tod, sizeof(tod));
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18);
+    /* The seconds counter steps within a second of the restart. */
+    for (idx = 0; idx < 15 && i2c_get8(i2cdev, DS1339_SECONDS) == 0x30; idx++) {
+        g_usleep(100 * 1000);
+    }
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmpuint(from_bcd(resp[0]), >, 30);
+    g_assert_cmphex(resp[2], ==, 0x10);
+    g_assert_cmphex(resp[4], ==, 0x12);
+    g_assert_cmphex(resp[5] & 0x1f, ==, 0x07);
+    g_assert_cmphex(resp[6], ==, 0x31);
+}
+
 /* The register pointer wraps at the end of the map. */
 static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -206,6 +254,8 @@ static void ds1339_register_nodes(void)
     qos_add_test("control-register", "ds1339", test_control_register, NULL);
     qos_add_test("status-register", "ds1339", test_status_register, NULL);
     qos_add_test("osf-write-protect", "ds1339", test_osf_write_protect, NULL);
+    qos_add_test("eosc", "ds1339", test_eosc, NULL);
+    qos_add_test("eosc-restart", "ds1339", test_eosc_restart, NULL);
     qos_add_test("stopped-reserved-bits", "ds1339",
                  test_stopped_reserved_bits, NULL);
     qos_add_test("address-wrap", "ds1339", test_address_wrap, NULL);

-- 
2.53.0-Meta


