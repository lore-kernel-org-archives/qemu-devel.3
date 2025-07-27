Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661A8C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwLb-0004pt-45; Sun, 27 Jul 2025 04:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLX-0004aQ-A4
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLV-0003zw-Lh
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23636167b30so31230575ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603380; x=1754208180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usHSMIsiz9y48acSDTuSuakYJz8ebYKYrU7jsQN2xLc=;
 b=b0DlaMGaQYnBjS6gKu44Zc6gHeA2KZROiOupr8qGHqHR5OJ9lQaZDngQd8GS6S2jyB
 hhpHUWqQaiOEj9RKctpoDekLLaMrzpmPl8aEiwCLh2lIhYTqXPximfzin1C7opJC1U58
 YlefQQXFrsmVxAQh6nYZN3x39vXq5pCz3bNofvO+U8MYG6cWlrsKU0fA/zbA0pBCZCiH
 zkvh+7CrVvhZjLGHQOV71YqbEXewm26Tiy4+e3h9SMyRgVyZ0HehPufjA7BJyDALrMSg
 WHGD/PNThUejimBn9mm65kauP/ub4+yhreuNHsoRLQFGRl3AKgrRYqwIUloA3541dus4
 WODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603380; x=1754208180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usHSMIsiz9y48acSDTuSuakYJz8ebYKYrU7jsQN2xLc=;
 b=LdK9506B0Do1K4rAcjGfmWHvgYYOYlwAvrRrEl4gTLpOv+rYKuE0EOSlfXbg/DzonN
 DU2ppKZ5MX3k7mQ4tZHvye2z3VIXzXx8J30UxLDpqoZISLUMXDx5owR2fTOthiX/lt6N
 t7CfId4TVIdaHBrevYmqw3ZH08vttOYArrPA74Du/lDKcNjf+PzxFzqhQsrzWcoKvlm0
 GvNdiCtG9M/XbbMrOMyNzgP71FBqrQaPjVQdQt14vj70h/3tiTg8Q72aBtf/yTABYO3e
 NFDE7xfgRCR+Udtuf986TT2C7fKt/zY9/4ZuMHyD7x/xVBwOE90mvSSQnGRsujCcSt+k
 d3Zw==
X-Gm-Message-State: AOJu0YwZCcD5NCom+4k7ZRBgp//zZxRIvH5WTQ/emxISv0gujCePLPed
 W5CRpcQrtdt3Ms/MNWzYmsldqO3r33s402VJ4MXIeWLiT9eQjY5k/zDh0BWJDDKjrcbPRWWCcc7
 2VD4R
X-Gm-Gg: ASbGnct2Wn8n5L6Jf2XITzUdZM4XMBcEH75lyhAn+wdBd4DCF/CpMYtSlPrHWvuEP8b
 460Ouyjr/C4F3QkTU+tJslhZ16L6FdSnnMspXiFHoqmFzE0BXHT/uDruoXWic3ltCRNzf1x+HjI
 so0ctdd5cuVsRUUhdzeNeeERNQakV3XKb61JJyc+yRodbrZH8nglyVIwqda1xqeNpX+M76Ll7cn
 GJfTxO8a24DBjXfFhYN4LtCohXwR2yumm90iRm1KTuco+++D6gVVjlY2VHlS253qg9IHylQ8Y1O
 4fd0dfxxUvkqhCyPnTg1DiNsy8wlkHOle3COJGGqxrqXIPE83MYig6r2WM5aXPIymrUgb6KdgdM
 YiJ9BahELCj8o4Hs5x+eEH0+ofxb2uqISltf6qs5AC94o8XQhhEvIY5i/mdzYMM2bSc2fV7P1Os
 Ck3P9VEN7n3FI4xQA4QmgY
X-Google-Smtp-Source: AGHT+IFJzDtcQ+pettaj7X1WjMGuF+CataC0LXZ3wWyG3zpvbK0AJMBtTAFmX9i2NgegI8Y49mFnWA==
X-Received: by 2002:a17:902:e891:b0:237:d25b:8f07 with SMTP id
 d9443c01a7336-23fb30f3711mr115297705ad.44.1753603379095; 
 Sun, 27 Jul 2025 01:02:59 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:02:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/82] target/arm: Add prot_check parameter to
 pmsav8_mpu_lookup
Date: Sat, 26 Jul 2025 22:01:33 -1000
Message-ID: <20250727080254.83840-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Separate the access_type from the protection check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h    |  5 +++--
 target/arm/ptw.c          | 11 ++++++-----
 target/arm/tcg/m_helper.c |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 118659815f..326b5a73cf 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1626,8 +1626,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool is_secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool is_secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion);
 
 void arm_log_exception(CPUState *cs);
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 561bf2678e..a914e7e23c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2561,8 +2561,9 @@ static uint32_t *regime_rlar(CPUARMState *env, ARMMMUIdx mmu_idx,
 }
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
     /*
@@ -2750,7 +2751,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     if (arm_feature(env, ARM_FEATURE_M)) {
         fi->level = 1;
     }
-    return !(result->f.prot & (1 << access_type));
+    return (prot_check & ~result->f.prot) != 0;
 }
 
 static bool v8m_is_sau_exempt(CPUARMState *env,
@@ -2952,8 +2953,8 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, secure,
-                            result, fi, NULL);
+    ret = pmsav8_mpu_lookup(env, address, access_type, 1 << access_type,
+                            mmu_idx, secure, result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
     }
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 28307b5615..d856e3bc8e 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2829,8 +2829,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
         ARMMMUFaultInfo fi = {};
 
         /* We can ignore the return value as prot is always set */
-        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, targetsec,
-                          &res, &fi, &mregion);
+        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, PAGE_READ, mmu_idx,
+                          targetsec, &res, &fi, &mregion);
         if (mregion == -1) {
             mrvalid = false;
             mregion = 0;
-- 
2.43.0


