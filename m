Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3246BCAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4V-00034G-5G; Tue, 16 Sep 2025 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4R-00030F-ID
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4P-0001aB-NY
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45f31adf368so12705325e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045984; x=1758650784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2jY99sznuAdHkjwdN7SRLmA+n/jUeQ2zxUjbOwbHyAU=;
 b=kYlf8WCHb3KpkrT0X7cFidAsyOHXLc8ITYDgjsIAwDJvsQ2yARtJjAPAOiul5IsXnC
 1LmcihtUgK8dQ8fsScAF0OmNhVHyecSKGBDDulwqfihk7/LE0dav7FgpbzSyTaoHuij8
 2PAHiD18WE6MNKjnqJsISOM0iNPLSo30AAYZSjT+VFXGjN7aCvzpXNxgsIL+gIywRi9G
 o3JPCu9rmSJFXCGn8cuhkaUnIZs+kecZM6k9Y0t+kwDY02lR8TWvVUULXEyJ93QFHUIc
 801Qj0/wEYaQmXHPBwQ4MHWvelw4H36CPFqLK6l132OHjS7cln1SUTs6GrrobNhqLKk0
 HQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045984; x=1758650784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jY99sznuAdHkjwdN7SRLmA+n/jUeQ2zxUjbOwbHyAU=;
 b=fBMz1PDnb5t8e73mDo5wFTyxC8zdAwo/DBL7gxi7K5Q+CbifWuhzaXen5HLveWydsQ
 5vsHt3PIQAiOiyezKh5Jq1oFZ59oMLhgpw/7apcBkzl7mRrIhNBW5e/tAidDK1PV7FmG
 G/7ef5/T5Wg6AwSXTZ+FXa8A/5tQVAEg1V+IsS4kWQbbYOBTpVVBJDbacH9YSBKd4rm2
 bA+4kxzjtgbAFrHaN9/duu6Hk1hRhOVRLP39WA8yAC406VZHFaEEM0CA5EIE3E4aryyl
 DSFiYBDkwFwcIJrreP5Yi5IbdG/6XfeR5mANvD00rZyO2KfwoTuxVe8xLe/fu8eBDvNl
 9wpw==
X-Gm-Message-State: AOJu0YyjJWXJOQtZNo5uSA+LN58BGbjKDWqb7+i9Ja8nAjTJBF7qEux3
 s/U4p0JDDMZ7BDDjVocfIe31COVfEtBakves4ZQmbDGMRKHccEMSnGpBN393d7hn2vjoPIo0sth
 P+dnu
X-Gm-Gg: ASbGncuQrpX5qkcuqHiJs8E1CaYVL4ZcgWxsWxdvHykk2ApOR86fM2YHTAhmlErIx7E
 wtc32N5ViMAHRkX1J03qhIQRiscToJ0AroOqhoxIlJfBfQUFQcaO46OQ9gnhCmT2rPkoKdYe3gS
 7v5+cckFLUU2ge7cMZcV5jTdRKxTgqbQtp+mIi7N/bK1N7JK88mEqaOLFN+BKHGGxL4Ky87y09t
 wWXi+6CMF6AyCS6nxHiJS11CjBMBZfrl1SuyWEKzxnJwagvh7SEN89XEY9L07hXM6aGE9HQ+Wa0
 /aCxDMuF6j8FLcbOx+dSNSEOj3BkYGoVinO1yAHoCz5fmDIIyVxPq4rGKsgZpMtalyTcykVdVAT
 pYJSyp0WWH70O2lWKyImbngmJbkgv
X-Google-Smtp-Source: AGHT+IGIiQzM3MEcLTPK1QcUscwu4wnT5ho7kLIFRtXE8WbBDU9xnKjuYghFvVDDQnOkXeN44G4IKg==
X-Received: by 2002:a5d:5886:0:b0:3e4:64b0:a776 with SMTP id
 ffacd0b85a97d-3e7659fcbc7mr19051832f8f.52.1758045983714; 
 Tue, 16 Sep 2025 11:06:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/36] target/arm: Add prot_check parameter to do_ats_write
Date: Tue, 16 Sep 2025 19:05:44 +0100
Message-ID: <20250916180611.1481266-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Separate protection check from access type, in preparation
for skipping the protection check altogether.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpregs-at.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 2ff0b3e76f7..bebf1689970 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -24,14 +24,14 @@ static int par_el1_shareability(GetPhysAddrResult *res)
 }
 
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
-                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                             unsigned prot_check, ARMMMUIdx mmu_idx,
                              ARMSecuritySpace ss)
 {
     uint64_t par64;
     bool format64 = false;
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
-    bool ret = get_phys_addr_for_at(env, value, 1 << access_type,
+    bool ret = get_phys_addr_for_at(env, value, prot_check,
                                     mmu_idx, ss, &res, &fi);
 
     /*
@@ -191,7 +191,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 
 static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     uint64_t par64;
     ARMMMUIdx mmu_idx;
     int el = arm_current_el(env);
@@ -253,7 +253,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         g_assert_not_reached();
     }
 
-    par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
+    par64 = do_ats_write(env, value, access_perm, mmu_idx, ss);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -261,11 +261,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     uint64_t par64;
 
     /* There is no SecureEL2 for AArch32. */
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2,
+    par64 = do_ats_write(env, value, access_perm, ARMMMUIdx_E2,
                          ARMSS_NonSecure);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
@@ -309,7 +309,7 @@ static CPAccessResult at_s1e01_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     ARMMMUIdx mmu_idx;
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
@@ -352,7 +352,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
+    env->cp15.par_el[1] = do_ats_write(env, value, access_perm, mmu_idx, ss);
 }
 
 static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


