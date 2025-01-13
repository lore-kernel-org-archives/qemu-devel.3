Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52541E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKtv-0005ab-QD; Mon, 13 Jan 2025 08:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKta-0005YM-J3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:26 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtY-0007fx-HN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:22 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so2073460f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776458; x=1737381258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yq7FotDJ+pRN0X+7tXxSyjuMyEGMsZuf5fWwzgYAvT8=;
 b=VX2mVerQ2+huqjn5KseqFljYibDjUMzdKINTlXKLKrvM7sg2C4xHpknt1Sh0YijWO6
 y6RR+cqvXMy/eZHBOEWV3L3AoBVYu7/zNnQoWkfHfEY1WlKnqxLYlOGGpsFGsF+r50Mc
 kb34higuA0Ta+bnWFr4oRQEbxtrDmGZVqbxRaayUavur0rg8ncycWaTUabiYkxkgttc2
 6GsqsAkxoq39pT0zb3LsWn4Daj5BzBJhJkdjHWMhtnlWlfbJprqPdcg4yLSpJ9pP99MO
 Mzbc5LldJAXJbHRiV76pjc7teN9KtAFw12Zoa3zNc7bXZU+AhX35gxjki6R6+IuYB9Sx
 H0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776458; x=1737381258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yq7FotDJ+pRN0X+7tXxSyjuMyEGMsZuf5fWwzgYAvT8=;
 b=BYKNd48vTEJ9Oo5BkIHh2W+tZaQwHwIXHSg3Rjyp4AItrT5sT9ii/8ulrKPUAi/jGL
 aQ6dmGoBr7jMyZQM5EVWW0DSdPDRFh62SSRpVWACcmyGvI9zZTZ1CjPLfzxvZrtmjbxm
 8HRD4nb/pYE+HUqt0NIXlkj7OpP/RBRr0GnigyRaevXIltleaBHEUAPea28TKsak6Srf
 sq4gXnuvXOJC+vqoRaVl/dyGphoUmVniuNANB2dOjjMb0kaUBHyRpQXxq+iuBam9+Z5c
 gY6TWBwBrj2VwOGGxajEZJKL6AUiSCDVwssD4bxnXxiHebOjdfLXuWdfcwJCwWK9W8D3
 oIsw==
X-Gm-Message-State: AOJu0YwgunbGRe7btoO8+fmJ7YPJqPQf+bySm+6e1QYpUQ1ARdHq05if
 NCaVOitljSpNbJHyUB87cxvyrbvSWfATdFi+chXpkLDjEZ5vFsyMw+AV1Mkzon6a7P543/aNJOz
 m
X-Gm-Gg: ASbGncs4yMI8wxNvJZRIqPCDt98a0foutKGTWOu+JnoOtykUKSmI0qd8RH6DQKWE2Fy
 Wh65edj4hpBzog+Og7H9Fs0+FPJ6pBo2M8IN1R+q/u8UHVRCoyvI+Wc7GYfibnGtILxk+CP5Jkt
 D36UQ0nDxDv6K7CA+6BMXS7m60a+Twic8NVnXVvFaWmKjALlasQRfR6bEUtMQKo0t8H+FHNSzQB
 ebIclrhel2s3iuwRLIn2hX2zuOddgm0v2++O5UrfPBwMmnCWBSyd8/i2o7I+7c=
X-Google-Smtp-Source: AGHT+IF+IL4AF87MrBIz8/7+WTFdr1GOWJ1JivUXn/oyx/WSAa8Gc8E5YUzmD7S82La/wtVJmY3kOQ==
X-Received: by 2002:a05:6000:1542:b0:38a:a047:6c0b with SMTP id
 ffacd0b85a97d-38aa0476d5amr8666527f8f.35.1736776458347; 
 Mon, 13 Jan 2025 05:54:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] target/arm: add new property to select pauth-qarma5
Date: Mon, 13 Jan 2025 13:54:05 +0000
Message-Id: <20250113135408.3164401-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Before changing default pauth algorithm, we need to make sure current
default one (QARMA5) can still be selected.

$ qemu-system-aarch64 -cpu max,pauth-qarma5=on ...

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241219183211.3493974-2-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst |  5 ++++-
 target/arm/cpu.h                 |  1 +
 target/arm/arm-qmp-cmds.c        |  2 +-
 target/arm/cpu64.c               | 20 ++++++++++++++------
 tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index a5fb929243c..d69ebc2b852 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -219,7 +219,10 @@ Below is the list of TCG VCPU features and their descriptions.
 ``pauth-qarma3``
   When ``pauth`` is enabled, select the architected QARMA3 algorithm.
 
-Without either ``pauth-impdef`` or ``pauth-qarma3`` enabled,
+``pauth-qarma5``
+  When ``pauth`` is enabled, select the architected QARMA5 algorithm.
+
+Without ``pauth-impdef``, ``pauth-qarma3`` or ``pauth-qarma5`` enabled,
 the architected QARMA5 algorithm is used.  The architected QARMA5
 and QARMA3 algorithms have good cryptographic properties, but can
 be quite slow to emulate.  The impdef algorithm used by QEMU is
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 12b84665427..01d9ff1781a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1062,6 +1062,7 @@ struct ArchCPU {
     bool prop_pauth;
     bool prop_pauth_impdef;
     bool prop_pauth_qarma3;
+    bool prop_pauth_qarma5;
     bool prop_lpa2;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738bb..33cea080d11 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -94,7 +94,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
-    "pauth", "pauth-impdef", "pauth-qarma3",
+    "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
     NULL
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dca83e45181..6ee0af69121 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -520,9 +520,12 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
         }
 
         if (cpu->prop_pauth) {
-            if (cpu->prop_pauth_impdef && cpu->prop_pauth_qarma3) {
+            if ((cpu->prop_pauth_impdef && cpu->prop_pauth_qarma3) ||
+                (cpu->prop_pauth_impdef && cpu->prop_pauth_qarma5) ||
+                (cpu->prop_pauth_qarma3 && cpu->prop_pauth_qarma5)) {
                 error_setg(errp,
-                           "cannot enable both pauth-impdef and pauth-qarma3");
+                           "cannot enable pauth-impdef, pauth-qarma3 and "
+                           "pauth-qarma5 at the same time");
                 return;
             }
 
@@ -532,13 +535,15 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
             } else if (cpu->prop_pauth_qarma3) {
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, features);
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 1);
-            } else {
+            } else { /* default is pauth-qarma5 */
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
             }
-        } else if (cpu->prop_pauth_impdef || cpu->prop_pauth_qarma3) {
-            error_setg(errp, "cannot enable pauth-impdef or "
-                       "pauth-qarma3 without pauth");
+        } else if (cpu->prop_pauth_impdef ||
+                   cpu->prop_pauth_qarma3 ||
+                   cpu->prop_pauth_qarma5) {
+            error_setg(errp, "cannot enable pauth-impdef, pauth-qarma3 or "
+                       "pauth-qarma5 without pauth");
             error_append_hint(errp, "Add pauth=on to the CPU property list.\n");
         }
     }
@@ -553,6 +558,8 @@ static const Property arm_cpu_pauth_impdef_property =
     DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
 static const Property arm_cpu_pauth_qarma3_property =
     DEFINE_PROP_BOOL("pauth-qarma3", ARMCPU, prop_pauth_qarma3, false);
+static Property arm_cpu_pauth_qarma5_property =
+    DEFINE_PROP_BOOL("pauth-qarma5", ARMCPU, prop_pauth_qarma5, false);
 
 void aarch64_add_pauth_properties(Object *obj)
 {
@@ -573,6 +580,7 @@ void aarch64_add_pauth_properties(Object *obj)
     } else {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_impdef_property);
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma3_property);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma5_property);
     }
 }
 
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index cfd6f773535..98d6c970ea5 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -419,21 +419,28 @@ static void pauth_tests_default(QTestState *qts, const char *cpu_type)
     assert_has_feature_enabled(qts, cpu_type, "pauth");
     assert_has_feature_disabled(qts, cpu_type, "pauth-impdef");
     assert_has_feature_disabled(qts, cpu_type, "pauth-qarma3");
+    assert_has_feature_disabled(qts, cpu_type, "pauth-qarma5");
     assert_set_feature(qts, cpu_type, "pauth", false);
     assert_set_feature(qts, cpu_type, "pauth", true);
     assert_set_feature(qts, cpu_type, "pauth-impdef", true);
     assert_set_feature(qts, cpu_type, "pauth-impdef", false);
     assert_set_feature(qts, cpu_type, "pauth-qarma3", true);
     assert_set_feature(qts, cpu_type, "pauth-qarma3", false);
+    assert_set_feature(qts, cpu_type, "pauth-qarma5", true);
+    assert_set_feature(qts, cpu_type, "pauth-qarma5", false);
     assert_error(qts, cpu_type,
-                 "cannot enable pauth-impdef or pauth-qarma3 without pauth",
+                 "cannot enable pauth-impdef, pauth-qarma3 or pauth-qarma5 without pauth",
                  "{ 'pauth': false, 'pauth-impdef': true }");
     assert_error(qts, cpu_type,
-                 "cannot enable pauth-impdef or pauth-qarma3 without pauth",
+                 "cannot enable pauth-impdef, pauth-qarma3 or pauth-qarma5 without pauth",
                  "{ 'pauth': false, 'pauth-qarma3': true }");
     assert_error(qts, cpu_type,
-                 "cannot enable both pauth-impdef and pauth-qarma3",
-                 "{ 'pauth': true, 'pauth-impdef': true, 'pauth-qarma3': true }");
+                 "cannot enable pauth-impdef, pauth-qarma3 or pauth-qarma5 without pauth",
+                 "{ 'pauth': false, 'pauth-qarma5': true }");
+    assert_error(qts, cpu_type,
+                 "cannot enable pauth-impdef, pauth-qarma3 and pauth-qarma5 at the same time",
+                 "{ 'pauth': true, 'pauth-impdef': true, 'pauth-qarma3': true,"
+                 "  'pauth-qarma5': true }");
 }
 
 static void test_query_cpu_model_expansion(const void *data)
-- 
2.34.1


