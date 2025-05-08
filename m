Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B39AC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9Ou-0007Sr-9B; Thu, 08 May 2025 18:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HSsdaAwKCjAZMNUTQefQRMZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--nabihestefan.bounces.google.com>)
 id 1uD9Os-0007NQ-4E
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:07:30 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HSsdaAwKCjAZMNUTQefQRMZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--nabihestefan.bounces.google.com>)
 id 1uD9Oq-0001h0-0w
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:07:29 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-22fb8cfff31so6353705ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746742046; x=1747346846; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fJU6UlRN3H7dSUUIlwcfvpO29WmnqKnNMBXNRLUsUNk=;
 b=wvw+eWJ8p8ynL/bCG/dZu6kil/5BvSTe+P2mAnJFog9uyMbTm2+Z03vRRyJT1TzUKp
 eezW9kYiFldiYd7qvHlNXr8XwGq7BmcsoOJy51qCSEaE77hWNKaOUbrdlAuNPrBDfRQo
 TXK9+9RXyevCC5DWbKrYPGeDWhenQyYDCdeGOxAFeJ3jJVeZKrxQDfzegE4Y/BYqCTZd
 mkDWGVmWi4h61Gc+SsgAzEtG1YP2SjjlY2NHCxAnRLj+lgTSTXCRcwpciRPDQa6ixOh5
 2NtXyhRC9zQOc+1s0cfi6GquTsJjlVbybZ2eH2kWgeOupUu6tDcsrVEv0o+eknPO/tu2
 mb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746742046; x=1747346846;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJU6UlRN3H7dSUUIlwcfvpO29WmnqKnNMBXNRLUsUNk=;
 b=iuGUWPto6vtqFAkr2jMrDdanblCeFXZJ4hmntXmfCHNm8vc8xEHjSZvwQ0Kltn94vH
 7XOUso70Lk/Y8r8D6n3JzVk11AbnFe+vrli4ROCO1WZbxwxZ4PSv9khgxVfVm0FKvzb3
 WoJ77quGPU/78CB4GozpyyA9L6oEX3ybiHz8qTf22vcd8Gj3XlGOUIdYeh4XpaSW+K6j
 qVqdRcnx/jPvjavT0GAYqEsD1FATvIC5DYbwG63EFam/Fffj20cNF+G3GgXMe0cc1iaj
 r0yjoJspijvG/0ZDT74EecSDY0R1Foy9MELQtPBaeN36mXXhA5D7LKUxUy341X64YAV9
 2qHA==
X-Gm-Message-State: AOJu0YyWkRmcKQ5OWrn5Nbfix1qzSb1Ooj/9hA47q3YfB7BGQTCMS6Pu
 yoJ3tTftXSc93vXjCMs/itTeaROCLSYOZccF6JCArjCqU218ODIQ9ug7O792fIwdhyJ/WTbIWn4
 hC4jVlhR1FXR1FzRKHmmKfWzMRB4cUsv2MPL3ckZlsobYy739MFg+HEz8YpRSpKPCoCWgEqgAi3
 3ENsjB0+PlpaULzYn/YhOq1CV4cQ+kgYGWP7dhfsl2K4CSCy/NJ/V/ecdHC6WoaG4=
X-Google-Smtp-Source: AGHT+IHegrkqn/KsXotRkXOWoiFRuWiZo0MUqAPEh+sCMXmxqvDJitICFqyt0CpxZMVhNSazfSpJ7yj6lDEjVtenYE4=
X-Received: from plez11.prod.google.com ([2002:a17:902:cccb:b0:223:f487:afc6])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea0b:b0:224:24d3:60f4 with SMTP id
 d9443c01a7336-22fc8b49391mr14117325ad.15.1746742045671; 
 Thu, 08 May 2025 15:07:25 -0700 (PDT)
Date: Thu,  8 May 2025 22:07:18 +0000
In-Reply-To: <20250508220718.735415-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250508220718.735415-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508220718.735415-3-nabihestefan@google.com>
Subject: [PATCH 2/2] tests/qtest: Migrate GMAC test from 7xx to 8xx
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: kfting@nuvoton.com, wuhaotsh@google.com, peter.maydell@linaro.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3HSsdaAwKCjAZMNUTQefQRMZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For upstreaming we migrated this test to 7xx (since that was already
upstream) move it back to 8xx where it can check the 4 GMACs since that
is the board this test was originally created for.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 tests/qtest/meson.build      |  6 ++-
 tests/qtest/npcm_gmac-test.c | 85 ++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3136d15e0f..ea9f8bc4b2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -207,9 +207,10 @@ qtests_npcm7xx = \
    'npcm7xx_sdhci-test',
    'npcm7xx_smbus-test',
    'npcm7xx_timer-test',
-   'npcm7xx_watchdog_timer-test',
-   'npcm_gmac-test'] + \
+   'npcm7xx_watchdog_timer-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
+qtests_npcm8xx = \
+  ['npcm_gmac-test']
 qtests_aspeed = \
   ['aspeed_hace-test',
    'aspeed_smc-test',
@@ -257,6 +258,7 @@ qtests_aarch64 = \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
+  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index c28b471ab2..1317da2cd7 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -36,7 +36,7 @@ typedef struct TestData {
     const GMACModule *module;
 } TestData;
 
-/* Values extracted from hw/arm/npcm7xx.c */
+/* Values extracted from hw/arm/npcm8xx.c */
 static const GMACModule gmac_module_list[] = {
     {
         .irq        = 14,
@@ -46,6 +46,14 @@ static const GMACModule gmac_module_list[] = {
         .irq        = 15,
         .base_addr  = 0xf0804000
     },
+    {
+        .irq        = 16,
+        .base_addr  = 0xf0806000
+    },
+    {
+        .irq        = 17,
+        .base_addr  = 0xf0808000
+    }
 };
 
 /* Returns the index of the GMAC module. */
@@ -174,18 +182,32 @@ static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
     return qtest_readl(qts, mod->base_addr + regno);
 }
 
+static uint16_t pcs_read(QTestState *qts, const GMACModule *mod,
+                          NPCMRegister regno)
+{
+    uint32_t write_value = (regno & 0x3ffe00) >> 9;
+    qtest_writel(qts, PCS_BASE_ADDRESS + NPCM_PCS_IND_AC_BA, write_value);
+    uint32_t read_offset = regno & 0x1ff;
+    return qtest_readl(qts, PCS_BASE_ADDRESS + read_offset);
+}
+
 /* Check that GMAC registers are reset to default value */
 static void test_init(gconstpointer test_data)
 {
     const TestData *td = test_data;
     const GMACModule *mod = td->module;
-    QTestState *qts = qtest_init("-machine npcm750-evb");
+    QTestState *qts = qtest_init("-machine npcm845-evb");
 
 #define CHECK_REG32(regno, value) \
     do { \
         g_assert_cmphex(gmac_read(qts, mod, (regno)), ==, (value)); \
     } while (0)
 
+#define CHECK_REG_PCS(regno, value) \
+    do { \
+        g_assert_cmphex(pcs_read(qts, mod, (regno)), ==, (value)); \
+    } while (0)
+
     CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
     CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
     CHECK_REG32(NPCM_DMA_RCV_POLL_DEMAND, 0);
@@ -235,6 +257,63 @@ static void test_init(gconstpointer test_data)
     CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
     CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
 
+    if (mod->base_addr == 0xf0802000) {
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID1, 0x699e);
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID2, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_CTL_STS, 0x8000);
+
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_CTRL, 0x1140);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_STS, 0x0109);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID1, 0x699e);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID2, 0x0ced0);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_ADV, 0x0020);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_LP_BABL, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_EXPN, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_MII_EXT_STS, 0xc000);
+
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_ABL, 0x0003);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR, 0x0038);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR, 0x0038);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR, 0x0058);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR, 0);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR, 0x0048);
+        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR, 0);
+
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MMD_DIG_CTRL1, 0x2400);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_CTRL, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_INTR_STS, 0x000a);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_TC, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DBG_CTRL, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL0, 0x899c);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_TXTIMER, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_RXTIMER, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_LINK_TIMER_CTRL, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_STS, 0x0010);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_ICG_ERRCNT1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MISC_STS, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_RX_LSTS, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_BSTCTRL0, 0x00a);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_LVLCTRL0, 0x007f);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL0, 0x0001);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_STS, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL0, 0x0100);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL1, 0x1100);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0, 0x000e);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL0, 0x0100);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL1, 0x0032);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_STS, 0x0001);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL2, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_LVL_CTRL, 0x0019);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL0, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL1, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_CTRL2, 0);
+        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_ERRCNT_SEL, 0);
+    }
+
     qtest_quit(qts);
 }
 
@@ -242,7 +321,7 @@ static void gmac_add_test(const char *name, const TestData* td,
                           GTestDataFunc fn)
 {
     g_autofree char *full_name = g_strdup_printf(
-            "npcm7xx_gmac/gmac[%d]/%s", gmac_module_index(td->module), name);
+            "npcm8xx_gmac/gmac[%d]/%s", gmac_module_index(td->module), name);
     qtest_add_data_func(full_name, td, fn);
 }
 
-- 
2.49.0.1015.ga840276032-goog


