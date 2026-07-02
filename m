Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB25C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLO-0007Xb-4m; Thu, 02 Jul 2026 14:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLH-0007Bo-OK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLC-0005N1-An
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493be1b9682so16021035e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017628; x=1783622428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xz5r4w7ToHLKCkQsWo8WUGV6TiUt2Z8kqneHCC7F/q8=;
 b=MR7K09D213Km9CXtzIGQ8qSArBxiI//wv3QNWhIMZmTjqdptXi3A4nK8G4Mv6fmpT3
 jCk1Sm4Ie4bxIJAAhQzZO6vprqDzC2gjdHUoh4gs06UZENG82SXIldigvFUK9rpUM8BR
 69ESU6404Bo8kUj9BREBc4g8DnzKrT/DBztxSU8rGTZdiPYxSvaQw6V9YhhB9ll7u58Q
 vKHAPwikGXvJaAmu6nqsKToptcLmsXUALfR9wgKjNxLtGHUt0QE+cHw98pZLl1OT/f1T
 bzqFH3nOi96i/Ujh3/r+5rLq2WlXNUikwLJK/nta/NX7nhJA7EQCys4WMuYQChdDx2uM
 Dhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017628; x=1783622428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xz5r4w7ToHLKCkQsWo8WUGV6TiUt2Z8kqneHCC7F/q8=;
 b=oXP8VW46Z70bvw4r+WHFxIWLy225NxuhVJW96zqqyfVivgSY5nPJZt4x33+aVF8fg5
 ZPpgRIerKeLV5q3hYvkdPeDejOhCAybVMKDDu4t9tKb/a4qe1GWU73n12ubq7JYP+Uxr
 PPrlWcF1SmosCCdh1aCFHOHiySOZZIdcGIoNSOfVuiHKTv3Q97BR5+WHpo3o+sOJFud8
 g6ALswHAD/r5kf3rhc2ps6gJCseY3Ilc70J1fKZNGHI9QkGa6w5Ah/JRzjUVtnb9CKtX
 GBicIo1nQdGOOKtbBlfPiVgAnFretYqZK9sDzFUphswHoeuG1itDSkDG5AafgrmCgnh3
 AtnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/3ZCnZ0dz40nr6jNWKTLGPi1PdvcTE9NSrzqryj0NIk5MiXiQwVSungKtqAha4k4giQM3TZQsY03d@nongnu.org
X-Gm-Message-State: AOJu0YwDPXPsYNNAQTXBvtY/NqKbFRP3Q+yqTDryB3ChajhYAvNI9aIr
 M3yTodaBWp1iaeC1deAytCn52Sbj9jfj9S+I0tsTI742TjQjDXZUt4Qpr6915SCd1ww=
X-Gm-Gg: AfdE7cmSuF90rZ4bQA3xz3Y86bOAy4UWDalnGsXk7ewwM6ep638gb/66OkGdzEZQ9ve
 ZQmGyzJV+Ubs+iQH07sbJJ5ZK19IX1okQPoL2YxZFS1GBiuhVn6yFcYn0rv2ktO8rsMAYFItTwd
 5NvWowEtBLs0Pn4EjnfuWYbi8ab/b8jtdjSghixOjCefat06jR/qGNj2fCq607R8WjjUdZJZgJc
 a16nFacw4/WdlB2HWUqfXwgVnMtaCivIzQQ/qHoTvdeqPnqR5OQM8ykb2AD4uiHbJYHyK7nJAku
 j5vJlUFw96IovCQIRPB/luXaWdCwVPD3DMS/7NOHrLeI1F0bn9qrun0fo58MPYZpgUCH5GKy4R5
 Gt1wbsWvgSGk9caHfPuT9aj7Jy6cy2uSkSykHzi23TqXPp1TWbl2F4WRKJBMEqbzRJ1810oalTU
 5Ohb3nWRcDZ4m2nzBtYR5nFlwcPOIZfvU9pXfwzRTgnhWQQBSdHNwdM/YayR5YPTTE3UMwXcDf9
 Uq4kG8WdIJQGHNrLSIIj1CKWsnVHURN
X-Received: by 2002:a05:600c:6d9a:b0:493:bfad:9d99 with SMTP id
 5b1f17b1804b1-493c2b4bfaemr66707435e9.13.1783017628247; 
 Thu, 02 Jul 2026 11:40:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/11] target/arm: Add new feature ARM_FEATURE_NO_NEON_TRAPS
Date: Thu,  2 Jul 2026 19:40:16 +0100
Message-ID: <20260702184019.3431139-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The traps configurable via CPACR.ASEDIS and HCPTR.TASE that trap only
Neon instructions are unfortunately IMPDEF about whether they are
implemented or not, and there is no ID register field that identifies
whether they are present.  In practice, they are present on every
implementation I have checked except for the Cortex-A8 (which was the
first CPU with Neon).

Add a new feature ARM_FEATURE_NO_NEON_TRAPS which we set on the
Cortex-A8, and make the CPACR.ASEDIS and HCPTR.TASE bits RAZ/WI
unless the CPU has ARM_FEATURE_NEON and not
ARM_FEATURE_NO_NEON_TRAPS.

The negative sense of the feature bit is a little awkward, but
this lets us set it only on the single odd-one-out CPU rather
than having to set it on every other CPU we implement.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h              |  6 ++++++
 target/arm/helper.c           | 17 +++++++++++++++--
 target/arm/tcg/cpu32-system.c |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 31a5567c95..9985f661f8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2171,6 +2171,12 @@ enum arm_features {
      * CPU types added in future.
      */
     ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
+    /*
+     * ARM_FEATURE_NO_NEON_TRAPS should be set if the CPU does *not*
+     * implement the CPACR.ASEDIS and HCPTR.TASE bits for trapping
+     * Neon but not VFP. This seems to be true only for Cortex-A8.
+     */
+    ARM_FEATURE_NO_NEON_TRAPS,
 };
 
 static inline int arm_feature(const CPUARMState *env, int feature)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 342d05e4d8..8ff7aa9c87 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -570,14 +570,20 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          */
         if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
             /* VFP coprocessor: cp10 & cp11 [23:20] */
-            mask |= R_CPACR_ASEDIS_MASK |
-                    R_CPACR_D32DIS_MASK |
+            mask |= R_CPACR_D32DIS_MASK |
                     R_CPACR_CP11_MASK |
                     R_CPACR_CP10_MASK;
 
             if (!arm_feature(env, ARM_FEATURE_NEON)) {
                 /* ASEDIS [31] bit is RAO/WI */
                 value |= R_CPACR_ASEDIS_MASK;
+                mask |= R_CPACR_ASEDIS_MASK;
+            } else if (!arm_feature(env, ARM_FEATURE_NO_NEON_TRAPS)) {
+                /*
+                 * bit is present unless CPU doesn't implement ASEDIS
+                 * (in which case it is RAZ/WI; this is the Cortex-A8)
+                 */
+                mask |= R_CPACR_ASEDIS_MASK;
             }
 
             /*
@@ -4101,6 +4107,13 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
 static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    if (arm_feature(env, ARM_FEATURE_NO_NEON_TRAPS)) {
+        /*
+         * If CPU doesn't implement HCPTR.TASE it's RAZ/WI.  Note that
+         * NSACR.NSASEDIS being 1 overrides this.
+         */
+        value &= ~R_HCPTR_TASE_MASK;
+    }
     /*
      * For A-profile AArch32 EL3, if NSACR.CP10
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
diff --git a/target/arm/tcg/cpu32-system.c b/target/arm/tcg/cpu32-system.c
index 6e98390089..b7aebd05d0 100644
--- a/target/arm/tcg/cpu32-system.c
+++ b/target/arm/tcg/cpu32-system.c
@@ -245,6 +245,8 @@ static void cortex_a8_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a8";
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    /* The Cortex-A8 doesn't have CPACR.ASEDIS and HCPTR.TASE */
+    set_feature(&cpu->env, ARM_FEATURE_NO_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
-- 
2.43.0


