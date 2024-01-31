Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E6AC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 00:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUyQ2-0002Kf-5i; Tue, 30 Jan 2024 19:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eJO5ZQwKCrkmZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com>)
 id 1rUyQ0-0002JX-CI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:25:32 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eJO5ZQwKCrkmZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com>)
 id 1rUyPy-0003so-J7
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:25:32 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6040a34c24bso4193587b3.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 16:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706660728; x=1707265528; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+4P83mYjYL0Kd0M/QZdVfGXCvzl3BzBTC85cdFIryk=;
 b=WLj4SM4SFUWkKLdoIXv7S//lBWmDirJNlsnmzrcstZqM6aR8eBW06asEkRhrkq+qEs
 JwhOZUGlFNdCIgzwrUxKB9eAoiYS+ymJKHuXkBy2pqaDYf4z4O8BBLLRPpTAyCocHwHD
 Nfwo/UsmM5od80sRi5K+wtRN7dqR2SOoVoui0kq16hKU6Nh7d4E+V3o2FzbGfG55m9kT
 SON3h5aNquWoqEoP/4RSJwJA2TKgM18wcBHIx87V3QJmUjY2G1O3bVW7nt7yiw0LZCjS
 TfkOS40+/OJwEY4gFHBLSko+yN7w0fe35U9E8gpXXolUB5IykvyL2Q4A/70y4QFjdJUU
 tEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706660728; x=1707265528;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+4P83mYjYL0Kd0M/QZdVfGXCvzl3BzBTC85cdFIryk=;
 b=O/NZDmXjYVLvVWynWiQQzPvUqEryUqbkhDeUDnYJN3B8u1/a7iDBpLDfVfzoD18x9G
 0otn+S5KtYsze6OdocYuGrKgCqhfkY9SnIqzqamr+bYDlKjX0N79AQU1eZ3At1c9DjNC
 H2CiZYYRM2fHyg8nSFCV++1+RY5i213OabfcI9NefMWYjQ734WOhSiF9Ra/EaxEtsT9o
 hx+MRvCbNcWcAlil6qxqjDAPCkkmIwpbIAJ6/G0T4YgHByjhbA64jVFB+JyNgf8eOswW
 X/77XF5AceYmYCx9oFhwkk0vVfok5C5BEVwfERvHe4woyoX8JvIOm08qbZjiOeMx8A/t
 i+ww==
X-Gm-Message-State: AOJu0YyDsXapx+q3plioS6ije/kWZz+3OQ7aXW1MNizaM/blZY9dNiLs
 hq4Ekf6XotakL5lJsvSdY7SN5Nv7BuEbgaNKAlrwSE7VRTioan4FkniMv0lCFXngj9S+lwglzZz
 +/KtuiAd/1dPMPLFhX6TUmtheLg==
X-Google-Smtp-Source: AGHT+IHmTJA87RXuSoq/vd9qAko62T0iHwzAhc0Yxh42UOEA95nS7jwpi7d/kdpIsWroJwefaT1S9KKYDhWIn6NcUHY=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:102:b0:604:4c5:7dc8 with
 SMTP id bd2-20020a05690c010200b0060404c57dc8mr195589ywb.8.1706660728495; Tue,
 30 Jan 2024 16:25:28 -0800 (PST)
Date: Wed, 31 Jan 2024 00:25:11 +0000
In-Reply-To: <20240131002511.986787-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240131002511.986787-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131002511.986787-7-nabihestefan@google.com>
Subject: [PATCH v16 6/6] tests/qtest: Adding PCS Module test to GMAC Qtest
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3eJO5ZQwKCrkmZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

 - Add PCS Register check to npcm_gmac-test

Change-Id: I34821beb5e0b1e89e2be576ab58eabe41545af12
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 tests/qtest/npcm_gmac-test.c | 132 +++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index 72c68874df..9e58b15ca1 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -23,6 +23,10 @@
 /* Name of the GMAC Device */
 #define TYPE_NPCM_GMAC "npcm-gmac"
 
+/* Address of the PCS Module */
+#define PCS_BASE_ADDRESS 0xf0780000
+#define NPCM_PCS_IND_AC_BA 0x1fe
+
 typedef struct GMACModule {
     int irq;
     uint64_t base_addr;
@@ -114,6 +118,62 @@ typedef enum NPCMRegister {
     NPCM_GMAC_PTP_STNSUR = 0x714,
     NPCM_GMAC_PTP_TAR = 0x718,
     NPCM_GMAC_PTP_TTSR = 0x71c,
+
+    /* PCS Registers */
+    NPCM_PCS_SR_CTL_ID1 = 0x3c0008,
+    NPCM_PCS_SR_CTL_ID2 = 0x3c000a,
+    NPCM_PCS_SR_CTL_STS = 0x3c0010,
+
+    NPCM_PCS_SR_MII_CTRL = 0x3e0000,
+    NPCM_PCS_SR_MII_STS = 0x3e0002,
+    NPCM_PCS_SR_MII_DEV_ID1 = 0x3e0004,
+    NPCM_PCS_SR_MII_DEV_ID2 = 0x3e0006,
+    NPCM_PCS_SR_MII_AN_ADV = 0x3e0008,
+    NPCM_PCS_SR_MII_LP_BABL = 0x3e000a,
+    NPCM_PCS_SR_MII_AN_EXPN = 0x3e000c,
+    NPCM_PCS_SR_MII_EXT_STS = 0x3e001e,
+
+    NPCM_PCS_SR_TIM_SYNC_ABL = 0x3e0e10,
+    NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR = 0x3e0e12,
+    NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR = 0x3e0e14,
+    NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR = 0x3e0e16,
+    NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR = 0x3e0e18,
+    NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR = 0x3e0e1a,
+    NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR = 0x3e0e1c,
+    NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR = 0x3e0e1e,
+    NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR = 0x3e0e20,
+
+    NPCM_PCS_VR_MII_MMD_DIG_CTRL1 = 0x3f0000,
+    NPCM_PCS_VR_MII_AN_CTRL = 0x3f0002,
+    NPCM_PCS_VR_MII_AN_INTR_STS = 0x3f0004,
+    NPCM_PCS_VR_MII_TC = 0x3f0006,
+    NPCM_PCS_VR_MII_DBG_CTRL = 0x3f000a,
+    NPCM_PCS_VR_MII_EEE_MCTRL0 = 0x3f000c,
+    NPCM_PCS_VR_MII_EEE_TXTIMER = 0x3f0010,
+    NPCM_PCS_VR_MII_EEE_RXTIMER = 0x3f0012,
+    NPCM_PCS_VR_MII_LINK_TIMER_CTRL = 0x3f0014,
+    NPCM_PCS_VR_MII_EEE_MCTRL1 = 0x3f0016,
+    NPCM_PCS_VR_MII_DIG_STS = 0x3f0020,
+    NPCM_PCS_VR_MII_ICG_ERRCNT1 = 0x3f0022,
+    NPCM_PCS_VR_MII_MISC_STS = 0x3f0030,
+    NPCM_PCS_VR_MII_RX_LSTS = 0x3f0040,
+    NPCM_PCS_VR_MII_MP_TX_BSTCTRL0 = 0x3f0070,
+    NPCM_PCS_VR_MII_MP_TX_LVLCTRL0 = 0x3f0074,
+    NPCM_PCS_VR_MII_MP_TX_GENCTRL0 = 0x3f007a,
+    NPCM_PCS_VR_MII_MP_TX_GENCTRL1 = 0x3f007c,
+    NPCM_PCS_VR_MII_MP_TX_STS = 0x3f0090,
+    NPCM_PCS_VR_MII_MP_RX_GENCTRL0 = 0x3f00b0,
+    NPCM_PCS_VR_MII_MP_RX_GENCTRL1 = 0x3f00b2,
+    NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0 = 0x3f00ba,
+    NPCM_PCS_VR_MII_MP_MPLL_CTRL0 = 0x3f00f0,
+    NPCM_PCS_VR_MII_MP_MPLL_CTRL1 = 0x3f00f2,
+    NPCM_PCS_VR_MII_MP_MPLL_STS = 0x3f0110,
+    NPCM_PCS_VR_MII_MP_MISC_CTRL2 = 0x3f0126,
+    NPCM_PCS_VR_MII_MP_LVL_CTRL = 0x3f0130,
+    NPCM_PCS_VR_MII_MP_MISC_CTRL0 = 0x3f0132,
+    NPCM_PCS_VR_MII_MP_MISC_CTRL1 = 0x3f0134,
+    NPCM_PCS_VR_MII_DIG_CTRL2 = 0x3f01c2,
+    NPCM_PCS_VR_MII_DIG_ERRCNT_SEL = 0x3f01c4,
 } NPCMRegister;
 
 static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
@@ -122,6 +182,15 @@ static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
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
@@ -134,6 +203,11 @@ static void test_init(gconstpointer test_data)
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
@@ -183,6 +257,64 @@ static void test_init(gconstpointer test_data)
     CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
     CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
 
+    /* TODO Add registers PCS */
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
 
-- 
2.43.0.429.g432eaa2c6b-goog


