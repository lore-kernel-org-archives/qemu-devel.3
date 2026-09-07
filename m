Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D22BC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cXd-0007YG-Kf; Mon, 07 Sep 2026 12:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cXS-0007MV-7q
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:49:46 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cXO-0004CC-MO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:49:45 -0400
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4858595f997so2249081f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799781; x=1789404581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vlKqMzmrK40spXKv/yB5zNGWaGlUqMdf8882/o2C+B4=;
 b=gbZ6SS+RyATpeeQjbcT161/Nxt95NsoG1/Ywipwx7LAdYoZf/AM10hvxQLI1FLts8x
 +d+YTuNU9VYtKjD9JI9Skl85OgeGByPYGcrGkZMavsInuGpOx/JYOf8rdhp6EtMNEjlF
 R1tsLcihqTLka0cfxZ89L6amoTP0TnDvOWtkIWciZey6mle9zxKQ8B3qa5guGbbNC02c
 JpmdEygGhEm/14dAQbP4ZyLcvlPg3gJWqiArxElLw1ml2JERp66iyffc4a/CfzD8zvva
 Aq1uBQopeoAjqYpmCMlKf9TlSAxG9kFwcYyTAa6cM1+8cdYE8046SjU9caLCJYjqbgNk
 Cr/Q==
X-Gm-Message-State: AFuF++kMuthL9p5KZoWp9nDearWnv5r/vw+Fdo+w7R+eocCK9sLZIO/I
 GLJ+oasC9tBibo6hmUq6xn1fYS7kxB7o4hMX6lEVDJJpLKFTKxvqjFSVrjNAHFGb
X-Gm-Gg: AYBFou191nEs2d1uwIY92KxzpscWX3b+LSnxBU2t+xDJdAsnxNBqfSOi9vc51gVMeaD
 SeRkeSxB76PMW6bi0Q1emHaH1rVXisq56i6GtoyJSiN2a2XIHxUkr+HvVHObSN2AHUPc1JP4Wsh
 9gEYw0tiu1T+zNeNaJ0ESclabp5AgdIQrTw9coFI1RaOikbTKKTwhIxy/ItskQujuNYUSYrjitw
 Zu3W0RPBP2HJ4NyKVPYcU6RU4nYFbNUxK+2Y5kYxqT2QwvY0QzoV+yyT912Ya7NTiK5ehzAjkBC
 BfQbQZB3UA0QN5VH5oya5IpJzXEDmvGKb3uQkSDcWpwLTS3ahuQ74qwY/AsNYLa04EoBzrUavVR
 NyI9o7ArZqb11nAjOzh0VldhNz/7PWl4ZLM3MhuWay4fLXLPwcxlc5MSD/F4DIGHxj4hjILvYpu
 pzk2Ni9Aq5K0wGE4EFLtc6ophWR7EcD9KZ+iY/SCiSTs2V0P/Dv92HrNKwAk3gPvAFEma0Xz2iD
 OOymdrlxPAhNi3xxUCPYEZUqCdyeSbJ/xM=
X-Received: by 2002:a05:6000:420d:b0:485:8ebb:be1a with SMTP id
 ffacd0b85a97d-4858ebbbee4mr38457374f8f.4.1788799781076; 
 Mon, 07 Sep 2026 09:49:41 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bf3f0sm32571466f8f.33.2026.09.07.09.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:49:40 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:27 +0200
Subject: [PATCH 37/50] tests/qtest: ina230: cover operating modes and
 triggered conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-37-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799322; l=5271;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Mc0oCEh0KqXrK8lJcAnq4Li1G/vyttVEriaHtSwE3o8=;
 b=Yx/Z6BPfNgz8qAjgf1heLMVSxs0JUqEhTM9MeBEQi5Ax4rW9sNQ82bZ6nZak3Zsm2trWV6MTS
 Sa28skbvUiNDetNTEhv77D4b+W3yJmXTXk2hdW3rt6hOQURUyWEIlvz
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.44; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f44.google.com
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
index 36c899efee..f8b982686a 100644
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
+    qmp_ina230_set("shunt-voltage", 20000000); /* A */
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
2.50.1


