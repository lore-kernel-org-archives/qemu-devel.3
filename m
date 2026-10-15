Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2E8CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIlS-00042C-SN; Thu, 15 Oct 2026 06:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIhF-0007eN-Em
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:29 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIhB-0004KP-UP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:25 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so41128845e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060100; x=1792664900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OOFmzhwngATj5QXbK6+ilaV21N6JVdHVnASw6Lr12jc=;
 b=TaB3DHUit8S2l7kZI4p5BN+QV6KdPAkewDVbXrRDZJxXT4FIP0eslODNd4PUZ+1dUr
 02JHpOvyg4xW3MaQX2jga/qTfoCMpTWBuf+hjcWzOH8w0A6c45dN3/FHR22FIgf2sVcb
 HkXwkGgsURyTzfrDcM/HDF4Vwxkd0gllVkilCSGxztktkzKQiMzR1/dH+qLsazf0UESN
 PsNzoExi9L0QRGgVSlNkLEgZf7hl5qwgLeaf1w9xEm84ow9/iPvxKiTAfkySpCsygPF8
 X2RW/WJipj6IhyUoohwVFzdhZbVFiVTk/zN+FaV4xPkflaRugTWmiTCdHEbt88m9N5Tf
 gKPw==
X-Gm-Message-State: AFq9FYIwwjyHWIOvxfQHU+FfKOI5phL3K1RFD/a9hGTHo4+Oh1Z64xMJ
 S3k8mRjUCFNDtw02s8iBOnmcH3E8viAH3g31HwO+2uVbNYa+boMpsopLjH11GA==
X-Gm-Gg: AYBFou319nvbTkEyH/P15wPEV94ug4i96VrHzyVNEzE2mOYhSHIyVLm5jO2lSmEjAZu
 QwcEZidKzMyPZh33VA/2Kj8FnXKARVshvszkf1fEMO1FCRYfn7GrGe3El/2lJkvr2yufbWRV+Ma
 A8RC81AXKUxCDzR9ooWQpPQ2pnPrBQg4G3sWi1qgFQKdU4gzv5VixCgAqqKTHUWaTILsZInSf8V
 +3q2DKFdLEu+4JsuIgBR5/gQwq51GlZgm+pK/7tncXxsTnjcfavVEXByo33PKIgwMLL/MFTPXx/
 wqj/FBdiN9HOPqeTeKWfJKoFZDq4kA0brLwe6D5Yc3mSw8z9tL7X8GjXNSL2RdpQVUgpJFJwiqJ
 Cm64P5rAwfNm42t8+Ls06T02Wqlma/M2e19lZYsOsvPYID/qbSr0W83gRfK6e1Orr6EV3xj8FVf
 X+2wWq2iIJYs+aHVvfhd59NKzNkrl2i16QnaPLlfROp6qp40HRcsguNtIEwrAl1hPcVqJR79Mj0
 TtwbJAVsExWAWYgWwhCSFMvqEyZvfbrRRhyQKwFO5lf1Qo=
X-Received: by 2002:a05:600d:1b:b0:4a1:9661:14b7 with SMTP id
 5b1f17b1804b1-4a196611b9amr267914405e9.32.1792060100051; 
 Thu, 15 Oct 2026 03:28:20 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd66c5e6sm40366255e9.2.2026.10.15.03.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:28:19 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:24 +0200
Subject: [PATCH v3 37/50] tests/qtest: ina230: cover operating modes and
 triggered conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-37-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056476; l=5268;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=M/AP87tzHPyKIB2/isqSVgsUBIucUWr9P38+NmmmCT4=;
 b=Yg5mzoaTRKUYOwLQCo+DrFpSzZQ/xsxjaSNkp9VVBeOdH8mjTi6omkFfwMDnOncs48DVluoXG
 7BNCbFgGVXOAb22pR0PGra4CZsXz52fJQINZOtClEjyUXgkAKe3SUGH
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
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

Add coverage for the MODE field: power-down retains the last results,
the shunt/bus channel-enable bits gate which registers track new inputs,
triggered modes convert once per Config write, and bus-only mode still
derives power from the retained current.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina230-test.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
index 36c899efee..4d601c74b5 100644
--- a/tests/qtest/ina230-test.c
+++ b/tests/qtest/ina230-test.c
@@ -142,7 +142,97 @@ static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x7FFF);
 }
 
-/* Shunt voltage register, including two's-complement negatives */
+/* Operating modes */
+static void test_modes(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    static const struct {
+        uint8_t mode;
+        uint16_t shunt, bus, current, power;
+    } cases[] = {
+        /* Power-down: no conversion, every register retains the baseline */
+        { 0x0, 0x1F40, 0x2570, 0x2710, 0x12B8 },
+        { 0x4, 0x1F40, 0x2570, 0x2710, 0x12B8 },
+        /* Shunt only (continuous): shunt and current track the probe */
+        { 0x5, 0x0FA0, 0x2570, 0x1388, 0x12B8 },
+        /* Shunt and bus (continuous): every register tracks the probe */
+        { 0x7, 0x0FA0, 0x12C0, 0x1388, 0x04B0 },
+    };
+    size_t idx;
+
+    for (idx = 0; idx < ARRAY_SIZE(cases); idx++) {
+        i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+        i2c_set16(dev, REG_CALIBRATION, 0x0A00);
+        qmp_ina230_set("shunt-voltage", 20000000);
+        qmp_ina230_set("bus-voltage", 11980000);
+
+        i2c_set16(dev, REG_CONFIG, cases[idx].mode);
+        qmp_ina230_set("shunt-voltage", 10000000);
+        qmp_ina230_set("bus-voltage", 6000000);
+
+        g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, cases[idx].shunt);
+        g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, cases[idx].bus);
+        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, cases[idx].current);
+        g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, cases[idx].power);
+    }
+}
+
+/*
+ * Triggered modes perform exactly one conversion per trigger, where the
+ * trigger is a Configuration-register write. Injected input changes
+ * between triggers are ignored until the next write.
+ */
+static void test_triggered(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
+
+    qmp_ina230_set("shunt-voltage", 20000000);
+    qmp_ina230_set("bus-voltage", 11980000);
+
+    i2c_set16(dev, REG_CONFIG, 0x03);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
+
+    qmp_ina230_set("shunt-voltage", 10000000);
+    qmp_ina230_set("bus-voltage", 6000000);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
+
+    i2c_set16(dev, REG_CONFIG, 0x03);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x0FA0);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x12C0);
+
+    i2c_set16(dev, REG_CONFIG, 0x07);
+    qmp_ina230_set("shunt-voltage", 20000000);
+    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
+}
+
+/*
+ * In a bus-only mode the current register is retained, but the power register
+ * is still refreshed on each bus conversion from that retained current.
+ */
+static void test_bus_only_power(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
+    qmp_ina230_set("shunt-voltage", 20000000);
+    qmp_ina230_set("bus-voltage", 11980000);
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
+
+    i2c_set16(dev, REG_CONFIG, 0x06);
+    qmp_ina230_set("bus-voltage", 6000000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
+    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x12C0);
+    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0960);
+}
+
+/* Shunt voltage register */
 static void test_shunt_injection(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *dev = (QI2CDevice *)obj;
@@ -377,6 +467,9 @@ static void ina230_register_nodes(void)
     qos_add_test("defaults", "ina230", test_defaults, NULL);
     qos_add_test("soft-reset", "ina230", test_soft_reset, NULL);
     qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
+    qos_add_test("modes", "ina230", test_modes, NULL);
+    qos_add_test("triggered", "ina230", test_triggered, NULL);
+    qos_add_test("bus-only-power", "ina230", test_bus_only_power, NULL);
     qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
     qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
     qos_add_test("shunt-limits", "ina230", test_shunt_limits, NULL);

-- 
2.53.0-Meta


