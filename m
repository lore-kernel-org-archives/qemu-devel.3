Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA84C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUnG-0002Cg-2z; Tue, 06 Feb 2024 18:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3f7_CZQwKCj4sfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1rXUn6-0002AF-Bo
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:23:48 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3f7_CZQwKCj4sfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1rXUn3-0006Wa-ND
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:23:48 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5ee22efe5eeso639487b3.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707261823; x=1707866623; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3/7wq4rDW0adpnVVVOuyGh9CpM8L7rZHr/Fp+pYK5Z0=;
 b=R4xZeBghsTMCtq4jECASj1dsynqch+Pm0oVmM4mNg+cpPO+uWouvomT+3kvo8Qka0B
 cmq6pKZ9ojSNJrco2+bgrO5vNXqKs8/9ZbiEYXYcSgYqHFJymjsI/tNDT0aLNwbA9jy6
 OnGto4qd8F5HHLhyzYa+8wyxqwSKUsVIcb9qR3qhJ4u0jfz9EYTlUT+dl4/JCjUc8V6R
 8AQVSvjnewq1cL9zxDAXytc1jxTX4KcOCFD+bmbahcj3C4k+aqyMzgLQM7L5KSTVQswF
 MxAS7EYn41Aevgr8932O7MiLSiZxtw7K98NX2Pg4BDLmPm8wVN4wQKHnusL0i58n/Y0g
 i49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261823; x=1707866623;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/7wq4rDW0adpnVVVOuyGh9CpM8L7rZHr/Fp+pYK5Z0=;
 b=PpLy+THJuGOc0XQzmqlVWLl4tJeDt2bGvJB3JJdY6ZSG65cr4fbOyZOqfMNR3ZOrDQ
 B5xnp+fQ7MlQzeq/5W+cwRSG9jy+SU0p0QxBeW4+WGcO6xgkJ7QLPa2bEcKgOo1/rhh5
 gQbDy/Wp01vXUiT+FXCsjy/Jc9b0N0LYw/Q519TatP5yB/tMzMAzw9UHyZqcHiTBL3UY
 j/dYmhsGdCqZNC3KbAggLN0TZRyJ19rOE9i22Ay7SCYSNTwkjEMb9UewqE2Fuljs/M9z
 AHmJILAH6LkYddLpD1roxwMPpZXlrzkqyn5dStVli8XvOb4+m1Qou2AWfrbAlmXw03tj
 gFXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhD8+eSG3iDbUTEQ8nCa3bAW2KkmpRQMvrca8aZo41IdVg6Y9n1lZa51Ne4Vm9moJpbWh3/fgWa+9gf8hSvKL+N9HBREo=
X-Gm-Message-State: AOJu0YzB77BkRFxdVxWhrO4ZnKuuwtv1sPZqoeKIKi443RJl+zD9nR+8
 JWReNBD5x7FJfpR6QSsetGq5x9EbhYURaJ+KA0ieEoTAJfi7FMEFdai3/voJRGuUWOAYITVbltg
 Xcmi9bIqsQ9uA6+s0nkBsDVsg6Q==
X-Google-Smtp-Source: AGHT+IEnLijRM1Cw64MY0m2ygMs7GhSw1WvuyaQNA9rDhpiowewljMxzh0I+B5XgE9GcDFUS9/KDY0l1ZZBuMTOpFVY=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:86:b0:604:b83:9cad with SMTP
 id be6-20020a05690c008600b006040b839cadmr559647ywb.5.1707261823646; Tue, 06
 Feb 2024 15:23:43 -0800 (PST)
Date: Tue,  6 Feb 2024 23:23:37 +0000
In-Reply-To: <20240206232337.1043760-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240206232337.1043760-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206232337.1043760-2-nabihestefan@google.com>
Subject: [PATCH 1/1] tests/qtest: Fixing GMAC test to run in 7xx
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3f7_CZQwKCj4sfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

Fixing the nocm_gmac-test.c file to run on a nuvoton 7xx machine instead
of 8xx. Also fixing comments referencing this and values expecting 8xx.

Change-Id: I07b91e8be473e6a1ece65a2202608b52ed4025b8
Signed-Off-By: Nabih Estefan <nabihestefan@google.com>
---
 tests/qtest/meson.build      |  4 ++--
 tests/qtest/npcm_gmac-test.c | 12 ++----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 39557d5ecb..2b89e8634b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -192,7 +192,8 @@ qtests_npcm7xx = \
    'npcm7xx_sdhci-test',
    'npcm7xx_smbus-test',
    'npcm7xx_timer-test',
-   'npcm7xx_watchdog_timer-test'] + \
+   'npcm7xx_watchdog_timer-test',
+   'npcm_gmac-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
 qtests_aspeed = \
   ['aspeed_hace-test',
@@ -231,7 +232,6 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index 9e58b15ca1..0d1bc8107b 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -36,7 +36,7 @@ typedef struct TestData {
     const GMACModule *module;
 } TestData;
 
-/* Values extracted from hw/arm/npcm8xx.c */
+/* Values extracted from hw/arm/npcm7xx.c */
 static const GMACModule gmac_module_list[] = {
     {
         .irq        = 14,
@@ -46,14 +46,6 @@ static const GMACModule gmac_module_list[] = {
         .irq        = 15,
         .base_addr  = 0xf0804000
     },
-    {
-        .irq        = 16,
-        .base_addr  = 0xf0806000
-    },
-    {
-        .irq        = 17,
-        .base_addr  = 0xf0808000
-    }
 };
 
 /* Returns the index of the GMAC module. */
@@ -196,7 +188,7 @@ static void test_init(gconstpointer test_data)
 {
     const TestData *td = test_data;
     const GMACModule *mod = td->module;
-    QTestState *qts = qtest_init("-machine npcm845-evb");
+    QTestState *qts = qtest_init("-machine npcm750-evb");
 
 #define CHECK_REG32(regno, value) \
     do { \
-- 
2.43.0.594.gd9cf4e227d-goog


