Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014CCCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIln-0005mu-JK; Thu, 15 Oct 2026 06:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIiA-0008GS-IA
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:25 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIi7-0004Ya-3F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:21 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so44243915e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060157; x=1792664957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tktjGaYiiPphflc+jwBY/yh3JfaTUnJhW1nAnyAEoO4=;
 b=rZHvvjv1/RIk6SfGGxkYHoiLMdRLeaY2pkZEFYu/AGY98lItINFhQXfDj48/yTFdho
 CYVdFQrn0KXLEV1Xa3fxSz+6GX4P/Ku4mRv+FCDcuTFV9hBG5rvsathS89rnJXI7OqY9
 RYVdW/9wCjp+3/2pErNEZJa518Efwjl2kUcfssNvOrgZCf00rvJKupPnz+rb7H1yFKyo
 8cEzRFYk/qk6IDsWc9GyIquflkp75G123QhXg4+LKtweK3GOmGfS3HGUQiLzuwFjLPpy
 5ccAdsGkAmUMfbNZO1UAit6o9oB2gsoTllYpMtorDXuw5yWRLp80298NBgq95j3zApsK
 OjPA==
X-Gm-Message-State: AFq9FYJwfuGDrI7AV0tAUWlFVOWNutZMOlpRZRwieCJZh8Wdtx0R1GM0
 WwLj4sv+AsvixH+cWkUSi5fhfm5VQUh33x+GhUx2UM6LbHti1vgOwY06jdF7zA==
X-Gm-Gg: AYBFou1NI6n6OEy1aZLISy/6TtSyeAFX9SttwPK1k6HIN6H0KC6mtYWrOmA4dq4sLr2
 4usmIaOPGw5Pur1hAHkkFX0kf6bNr88rur6cyV80lP+CWnBlepegs9q4Rx4UvKpl9zGMr9rE0LN
 1LvEewM7Qle51+jABNaDY7SP5tNA/PA6i2vF/msZNOwfTENYFDlnaQLLaguINZ2J0eTSSWqEiYn
 bC/L0fISpbtulEFfLg8mvftgzmgd8NdVLQc6LfD7ehh7jsdgSdFafwVPy/FANMetQFSG9RKgjGh
 rJw+A8NQ4fF3W+vBH1rabuH17HtjB0YOxGQ2UX8Lhky15YHFsN5LgZsFXG6ubsnmHNQYEzKHeqg
 XGNOdw64D1I84oYHk2DTMvAMM08BTtAro7mVtwOgSuLXwUzVsw4bD2i2Avx0xqrcx9B4eP0USI7
 OhZu24LCwCXoDYcM0gqR81oDmHWa0v9CEfS3mEDCivZ4NrArnLf+CT/Ll/knfG7BWXarMPp+4N4
 CvbdQUCUzdCE53Hj6epjDE1AVe4UIfdtB/BxaME1n4GLQ==
X-Received: by 2002:a05:600c:4747:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4a18e49d65dmr368156415e9.5.1792060157390; 
 Thu, 15 Oct 2026 03:29:17 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a8a22sm67881385e9.5.2026.10.15.03.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:29:16 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:32 +0200
Subject: [PATCH v3 45/50] tests/qtest: ina238: cover the operating modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-45-7d50c8a108e5@free.fr>
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
 Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056477; l=4362;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=hpkKt0gJgZXEPALCwyXp/2SRP8/YiYX8+r6RcSGYDn4=;
 b=/UFllWcjbet2SJFXyHjRNf5XETBgpowehkf3+3AO4Zo75Xw2tM3S8oAMp5BjPJJaYQpWn7fZH
 NyVbSXGjV7gDEB4ngs+MjCKonznMFpf6NWaNUc9Gl8QyhzqhAcymf8r
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

Add coverage for the ADC_CONFIG MODE field: shutdown modes perform no
conversion and leave the measurement registers and CNVRF untouched,
triggered modes convert once per ADC_CONFIG write, and continuous
channel-select modes refresh only the enabled measurement registers.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ina238-test.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tests/qtest/ina238-test.c b/tests/qtest/ina238-test.c
index 74912424c0..fb7bcc265c 100644
--- a/tests/qtest/ina238-test.c
+++ b/tests/qtest/ina238-test.c
@@ -304,6 +304,73 @@ static void test_adcrange(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x1F40);
 }
 
+/* Shutdown converts nothing: registers are held, CNVRF stays clear. */
+static void test_mode_shutdown(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    qmp_ina238_set("bus-voltage", 12000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
+
+    /* Clear CNVRF, then enter shutdown (MODE = 0). */
+    (void)i2c_get16(dev, REG_DIAG_ALRT);
+    i2c_set16(dev, REG_ADC_CONFIG, 0x0000);
+
+    /* Injecting while shut down performs no conversion: registers are held. */
+    qmp_ina238_set("shunt-voltage", 40000000);
+    qmp_ina238_set("bus-voltage", 24000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x0F00);
+
+    /* No conversion completed, so CNVRF stays clear. */
+    g_assert_cmphex(i2c_get16(dev, REG_DIAG_ALRT) & DIAG_CNVRF, ==, 0);
+}
+
+/* Triggered modes convert once per ADC_CONFIG write. */
+static void test_mode_triggered(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
+    qmp_ina238_set("shunt-voltage", 20000000);
+
+    /* Enter triggered bus+shunt+temp mode: one conversion. */
+    i2c_set16(dev, REG_ADC_CONFIG, 0x7000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+
+    /* A new input does not convert until the next trigger. */
+    qmp_ina238_set("shunt-voltage", 40000000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+
+    /* Re-triggering with another ADC_CONFIG write samples the new input. */
+    i2c_set16(dev, REG_ADC_CONFIG, 0x7000);
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x1F40);
+}
+
+/* A bus-only mode refreshes the bus register alone; the rest are held. */
+static void test_mode_channels(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
+    i2c_set16(dev, REG_SHUNT_CAL, 0x1000);
+    qmp_ina238_set("shunt-voltage", 20000000);
+    qmp_ina238_set("bus-voltage", 12000000);
+
+    /* Continuous bus-only mode. */
+    i2c_set16(dev, REG_ADC_CONFIG, 0x9000);
+    qmp_ina238_set("shunt-voltage", 40000000);
+    qmp_ina238_set("bus-voltage", 24000000);
+
+    g_assert_cmphex(i2c_get16(dev, REG_VSHUNT), ==, 0x0FA0);
+    g_assert_cmphex(i2c_get16(dev, REG_VBUS), ==, 0x1E00);
+}
+
 /* Clamping at full scale and the MATHOF flag */
 static void test_overflow(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -548,6 +615,9 @@ static void ina238_register_nodes(void)
     qos_add_test("power", "ina238", test_power, NULL);
     qos_add_test("zero-cal", "ina238", test_zero_cal, NULL);
     qos_add_test("adcrange", "ina238", test_adcrange, NULL);
+    qos_add_test("mode-shutdown", "ina238", test_mode_shutdown, NULL);
+    qos_add_test("mode-triggered", "ina238", test_mode_triggered, NULL);
+    qos_add_test("mode-channels", "ina238", test_mode_channels, NULL);
     qos_add_test("overflow", "ina238", test_overflow, NULL);
     qos_add_test("alert-shunt", "ina238", test_alert_shunt, NULL);
     qos_add_test("alert-bus", "ina238", test_alert_bus, NULL);

-- 
2.53.0-Meta


