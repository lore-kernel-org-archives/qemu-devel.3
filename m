Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E248CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjW-0004k4-Js; Thu, 23 Oct 2025 10:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjV-0004iV-5I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjT-0005YB-Dn
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475c696ab23so5526635e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231362; x=1761836162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5ZE51+CptGkbAysQdRrFoTua3i+r2jS6tpy1vaV+RQ8=;
 b=aqaUjHyUUyqrhTNASXYUN1rzGSbrCBM6ozioV7w08WPT6s5eeVbYudHMVNOmq1cBP9
 6EIDyUe12W/5zpqJTvODyx1z9oS57EpPV0RT3XwoDgcsr4gCIWI6kwgHA1F2ArqjNAi+
 oPQxvZHM3jKBFH0M4bxa0+oXhD1ZeXVTzhHY0r/geaS6jqE2MSrONDiid6lNXeax1i4R
 pWEsE+ln0svwT8ryTANRc7+PKrvKcrLwb5eF+iY7KZQCsG7Gi22KP8k7l5GPB0qYuT4a
 YmbQlh6i5P/678FKAu8JrV4VEfcn4XpfSpB2Mx7G8i9isWbB7s5cz6tgn+YQ7w4QkCIy
 eayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231362; x=1761836162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZE51+CptGkbAysQdRrFoTua3i+r2jS6tpy1vaV+RQ8=;
 b=KEe8bucOaHWmndujgmVz2pqo8y9PwUU9CtWI2gPzVN6HnnGW5/9sEo/Tq3j9juZC0q
 9UuK1+OV1JXyU3HeVwCN8yGrNTrROlGDyffes/JAJ/WGOXfTYTLuAhXZ1uMw4Ifv5x1z
 hbAzpawmhO9q/UV8JJKI3vAI2tnJM+QVpEZDdlWsHBOvoOHuKNbddn+hF5YxhJfHI413
 x3d2Ucd25DMvOwOCYvWksf8JCZQlER/vOqy51WmZGdeOAzrHMQeJFIV8krS76+QImcVy
 L1odLtatVrg/Bbv8B0YNlDzOJ965am+Gym278XC7jT8O4za2BxzusEo9b0hM05+50qPs
 TOxw==
X-Gm-Message-State: AOJu0YzrOiSKSsR2QTEz4tBh/Ww8MNEMDcuSVataq3d6qfYteVsi8lzY
 NNCh3K1E3YgKni8US729gxfJCE1kdqeDHy4QRR7tIN+G0uF8dMBdeihW8IsNUD9duNfoZCTmu34
 0YOVw
X-Gm-Gg: ASbGnctcyxaV7EUmOy38vS1kcSX59XLdlKK91FhEXdVLqbUfhma9PyIak/J5rW1G525
 N7ox8hxm7UgWi57gK0LN3ftS1yQ993CupzxgODSkgjjdDMqhYPSNHoVuVMkY4r39vH+Eew4DwAd
 Hb215pSkT8RXM9BosuT8A4CVr2IDmhRE4SilELzynt9bdZrN6LQDaC7wjSXCPmWs6sNCXjsBP+v
 gJ8WPnLSdNdo8s+X8XL0iAWm5Lt3JDXeB4vUgAMbwjFvtyWLw0Q6BLbZs9bRQdBJ5fcRhqHtWxv
 ZqJSxYDTNpFB9n4Jp13FTqZpF+KtzCHRtdMrX+S5zmNcFga1hGeK/l7pcmg1ACwbuWMtfCEGGUs
 S5qjvmXPbqDBATTSBr/1SK2npMTavEWY6zfIHCuurbkq+wm4UgLa/pk53CuHKEBdXJh3nifHWYe
 OS9Jewgw==
X-Google-Smtp-Source: AGHT+IER9vjIsQ8hv55dr0iFGxPrUdqNL5GEppSzkCxmg1m71WQXV7Pix3ucPQ3OS5BpAGTA9hvPVg==
X-Received: by 2002:a05:600c:8b03:b0:46e:41b0:f0cb with SMTP id
 5b1f17b1804b1-4711790c57amr189440285e9.25.1761231361736; 
 Thu, 23 Oct 2025 07:56:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] target/arm: Add AIE to ARMVAParameters
Date: Thu, 23 Oct 2025 15:55:43 +0100
Message-ID: <20251023145554.2062752-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Allow the bit to be set in TCR2;
extract the bit in aa64_va_parameters.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251014195017.421681-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/helper.c    | 30 +++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f539bbe58e1..a65386aaed3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1391,6 +1391,7 @@ typedef struct ARMVAParameters {
     bool hd         : 1;
     ARMGranuleSize gran : 2;
     bool pie        : 1;
+    bool aie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4d16514409..8c0b8889dbf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6098,6 +6098,9 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_s1pie, cpu)) {
         valid_mask |= TCR2_PIE;
     }
+    if (cpu_isar_feature(aa64_aie, cpu)) {
+        valid_mask |= TCR2_AIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6111,7 +6114,10 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_s1pie, cpu)) {
         valid_mask |= TCR2_PIE;
     }
-    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_aie, cpu)) {
+        valid_mask |= TCR2_AIE;
+    }
+    if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
     value &= valid_mask;
@@ -9666,6 +9672,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
     bool epd, hpd, tsz_oob, ds, ha, hd, pie = false;
+    bool aie = false;
     int select, tsz, tbi, max_tsz, min_tsz, ps, sh;
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
@@ -9688,10 +9695,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             if (r_el == 3) {
                 pie = (extract64(tcr, 35, 1)
                        && cpu_isar_feature(aa64_s1pie, cpu));
-            } else {
-                pie = ((env->cp15.tcr2_el[2] & TCR2_PIE)
-                       && (!arm_feature(env, ARM_FEATURE_EL3)
-                           || (env->cp15.scr_el3 & SCR_TCR2EN)));
+                aie = (extract64(tcr, 37, 1)
+                       && cpu_isar_feature(aa64_aie, cpu));
+            } else if (!arm_feature(env, ARM_FEATURE_EL3)
+                       || (env->cp15.scr_el3 & SCR_TCR2EN)) {
+                pie = env->cp15.tcr2_el[2] & TCR2_PIE;
+                aie = env->cp15.tcr2_el[2] & TCR2_AIE;
             }
         }
         epd = false;
@@ -9733,10 +9742,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             epd = true;
         }
 
-        pie = ((env->cp15.tcr2_el[r_el] & TCR2_PIE)
-               && (!arm_feature(env, ARM_FEATURE_EL3)
-                   || (env->cp15.scr_el3 & SCR_TCR2EN))
-               && (r_el == 2 || (arm_hcrx_el2_eff(env) & HCRX_TCR2EN)));
+        if ((!arm_feature(env, ARM_FEATURE_EL3)
+             || (env->cp15.scr_el3 & SCR_TCR2EN))
+            && (r_el == 2 || (arm_hcrx_el2_eff(env) & HCRX_TCR2EN))) {
+            pie = env->cp15.tcr2_el[r_el] & TCR2_PIE;
+            aie = env->cp15.tcr2_el[r_el] & TCR2_AIE;
+        }
     }
     hpd |= pie;
 
@@ -9818,6 +9829,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .hd = ha && hd,
         .gran = gran,
         .pie = pie,
+        .aie = aie,
     };
 }
 
-- 
2.43.0


