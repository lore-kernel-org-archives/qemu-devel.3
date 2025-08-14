Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FE3CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXT-0001Nq-Gg; Thu, 14 Aug 2025 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXR-0001Na-Pm
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:37 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXP-0004DZ-FG
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:37 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so748293a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176310; x=1755781110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZyOZ5ibz8YB1lWsiaU/JxXFHwk/vo9PWaKWI3jDReA=;
 b=fY9w0w/6c0Zg4Nl6JXczKAeJmVctqb5A+j+YqpB95Dw6wpSPsyapRxSepzq6tQXc/6
 s5hc+mtyMHetjxnRbAfGi0i/GR8HKjd22RlDtGHmy0j6XfHD8XB99X1UCAtTLDQO0KRi
 pRZNToXQKktBy5lerYx8IlIj0C1KqClmOby+hmnvD1oLtU3TdKHdi5dZIywjsFOvLVZJ
 vPlaBZPh21SMJ5J2QUNW/XtXkZK0Vz2XImjnJTMci+WDNaNl3EsILJU6hO5Jbij6aGbx
 grMfEWttvPyK02zSYbxRBydvqx74mi9X2VPFZMa3fThhrYSIytNEC5iMEkQtfDvzDbXX
 L8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176310; x=1755781110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZyOZ5ibz8YB1lWsiaU/JxXFHwk/vo9PWaKWI3jDReA=;
 b=vw2i5EtlUyDlRR5WfPkVPoldEbdpP2T4PYscKtzOu7bAYdX2zDoPXDLjQe+ocOSmwL
 PoKSMUuq7T/KHtt2ky37zePkrPzWmsgZ8XKhiAg/qInbdjHyIUQzERE+jnE2BfqUa3UY
 enyLUGAPqJ0XbEuKEMd6XZ6h7tDgRmKiC5/4DME/jh7sFyvVQ2WG+/t0FqytwqC7joug
 y/9Sdgjoy4NS5IR9SDezjE9usN+7M7z03aH0qy6KO3zFL+p+I8xPiWstp1wy06Njn19e
 hXi9MASFt8vHmy6yqGur49AEKN8U0v9FKEbuS2fh2Q936Ju0jK9i6zIzWtgVqP5C2Vhn
 4wZg==
X-Gm-Message-State: AOJu0YyUjrFpLRbye/B2jtsC8GttZqsLzAYPmiCFk0k5ZI9Uxg1pCe/k
 NIcCJO/yXgxB2srb8VHhm0h049J64H4vRaYIVgj7lRW0GH0pe+LAdV8osOhKTpoPBrsR5F+JO6E
 m406tJU8=
X-Gm-Gg: ASbGncuE6Up2WJVAE+oFRLxlxtbw5Tchx1wTn/NcS0/hINZb/+AN8CZJjoDxXqxgKHk
 BHZ/Yfu824Kg93cZI9BJJsDe1459MMlYTTvag8RqNb+n/WR7bPSVSI2f9zHXJVyzDAP9ML2JBhG
 5s0zvP+Oyz9RvfBWKukOOcn73mon35aOywA8E/wE+HT1UJX9BvbSP/91g/xgksU3CkRKGiZK5tV
 O0FPa+LzMJrq8h6OVeIFC8QXzA7Z9Q//SqwiRlysez6H3MrY/zgoXM1cQ6UFwzmEdN7aOG3Ct3y
 qQfKSzaaEDAU6rzF+4dQ8JBK/ubAAgp12ml/4deMix6txgZY2G/9aG91incaum5mKDjgQoYfmLk
 toUzRHu8BoO3UpS/U2JGppuS6p2/uYkFlbnu1nhLDp6q+wTg=
X-Google-Smtp-Source: AGHT+IF4Y30jvP0HWnCtxUnYio+Q/TDeSeOEuvch3KUZ9tt/V+EakCJ9VOy0H9jIGqTD/saLIFPNzQ==
X-Received: by 2002:a17:90b:5630:b0:31f:ca:63cd with SMTP id
 98e67ed59e1d1-3232795b07fmr4581596a91.2.1755176310282; 
 Thu, 14 Aug 2025 05:58:30 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 09/85] target/arm: Add prot_check parameter to do_ats_write
Date: Thu, 14 Aug 2025 22:56:36 +1000
Message-ID: <20250814125752.164107-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Separate protection check from access type, in preparation
for skipping the protection check altogether.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpregs-at.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 2ff0b3e76f..bebf168997 100644
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


