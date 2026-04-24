Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556D5FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Cc-0007T4-MI; Fri, 24 Apr 2026 00:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CG-00070U-MP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:22 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CC-0002oL-Mx
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:18 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-42fbf95cca8so2177218fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005075; x=1777609875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7aV4/ccpJY3oIK25szkraYIxGpm+6Rk3RJv/5vVfmY=;
 b=BjO+oqXERvlhjfW+mcAvOl7lUVqm52O2LuM6pyGUT9PPdzKbKC1+FjdBjeiaxXs7M8
 T1rMEva5XvY2X/VX9hZMt5mezH/HKbI/1pvC/Z6T91l/my9s9PHkbNc7t7Tcr9DJmqlU
 /fxw/es7IVg/ub0HvmNTJrsgF14AzJsnyMuGd7lceSPnU15D5l/5EVjdIUzInJX2EZsr
 Ht3wP9rrLVbVbcN2B3AuNUMj01aBV4e3eXh8dV7bJhIW34gytPo8O/AHDfd/Wyh9NSB7
 Fi6iLWD5+eRmLhG/RP/C5WnQU6SgEGBTBzyvhm55bridIntcLAhmaEoKbLYY1EsoXRAy
 7OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005075; x=1777609875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V7aV4/ccpJY3oIK25szkraYIxGpm+6Rk3RJv/5vVfmY=;
 b=KvqovjOXsWq6jyJQCrzrf9C9BRnVenqbjsPHwBOgt7DTPFIoUKG978sUqHxi7RmB7a
 1tEpNKGd+vuyU9ZR61sD64slKS+IAUvUJFo4lCncUa7QFWVUVe2g/XoWHCN1IqdgCJM/
 kLCsPSRydutzf/klMP3gXTOsUAlIBgELNsGhYtMpsq9kN7fdu4rV0VdPRMBhqhxj6voz
 q3cn6pyjFuF7fRdyX8dHaoK80bMSzRhrVK+Zmp7Ep8gTvsUJpmkdWomH2BBwkCneVrwx
 rIgeg1ad9Nf7k4S+K6ig84u40BQGO9SAo2615iIMcbGBgDfs+SEtqSAE4Qy20jlhkuKT
 4XGQ==
X-Gm-Message-State: AOJu0Yzqeb/I8qUd8aQ5oZWYc0pJ1Qvky+TRyGJfXrdKKDKYuvIfklrB
 AwyuV3zLu224AHsXw9qRZMVbxp039SYdIalncDCDeE+c+uO2Tu7vFRqjIAWV66O3TOVemD47dlh
 lN0EUv24=
X-Gm-Gg: AeBDieuV5trQFtMMUvD6sqiFARyJEdW5h7c3le4V0W5ahm6C2IHqTRGt3M4qYQqZGVG
 oNB53FkxIjG8QStyfBN+GMf0bAKZ/9l6O0FspA3E7+/P/H1nY+xtt6YLLoBPQzpWUB7YJERgjx8
 tjMiQxKpHSkvzU2u80ZOtdos7sRoKxzvMxccTX7M0c9n2GTbfPVUJ3XlzCrrEdHpJOoskPtn0pQ
 n8xkvrv7a84uMGaTI3HloqnjFoQdI4dNnrzN9FA0qYl4DGFmHswBWVAEbQYuBbbQ44wAmvopjNn
 U7Nd02HtJmHx+G7V+SLpIpgFpvnmVcMHC2A14elaOvryS1zBbDRC4iElD898yB4un03nViHCCq5
 iOuifrWAagOtGNFK/vxnkhHFU1HZbW6ukg3nDBDRxFtl+2/srBbuNlQtbq01SRIHoz+xYI8VvHw
 sBNRMRe73K8CsWmeObj4PM9E+aSGrL4FPX4JIkNqD7Jug8UpiFBR5+YtGbI40Zxg==
X-Received: by 2002:a05:6870:9d88:b0:409:76e0:bd84 with SMTP id
 586e51a60fabf-42aded0b29emr19061002fac.24.1777005074979; 
 Thu, 23 Apr 2026 21:31:14 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 12/40] target/arm: Add FPMR_EL to TBFLAGS
Date: Fri, 24 Apr 2026 14:29:46 +1000
Message-ID: <20260424043014.46305-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prepare to perform access checks for direct and
indirect uses of FPMR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/hflags.c        | 41 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  1 +
 4 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index deab811ba4..e78bc1737d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2536,6 +2536,7 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
+FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463..4001f2fc36 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -199,6 +199,8 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
+    /* FMPR exception EL or 0 if enabled. */
+    uint8_t fpmr_el;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..6759b36f28 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -237,6 +237,43 @@ static int zt0_exception_el(CPUARMState *env, int el)
     return 0;
 }
 
+/*
+ * Return the exception level to which exceptions should be taken for FPMR.
+ * C.f. the ARM pseudocode function CheckFPMREnabled.
+ */
+static int fpmr_exception_el(CPUARMState *env, int el)
+{
+    switch (el) {
+    case 0:
+        if (el_is_in_host(env, el)) {
+            if (!(env->cp15.sctlr_el[2] & SCTLR_EnFPM)) {
+                return 2;
+            }
+            break;
+        }
+        if (!(env->cp15.sctlr_el[1] & SCTLR_EnFPM)) {
+            return 1;
+        }
+        /* fall through */
+    case 1:
+        if (!(arm_hcrx_el2_eff(env) & HCRX_ENFPM)) {
+            return 2;
+        }
+        break;
+    case 2:
+        break;
+    case 3:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ENFPM)) {
+        return 3;
+    }
+    return 0;
+}
+
 static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -500,6 +537,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+        DP_TBFLAG_A64(flags, FPMR_EL, fpmr_exception_el(env, el));
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9f375b05ca..ef6038e98b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10725,6 +10725,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
     dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
     dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
+    dc->fpmr_el = EX_TBFLAG_A64(tb_flags, FPMR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.43.0


