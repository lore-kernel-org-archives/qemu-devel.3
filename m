Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE87C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwQD-0004dZ-KY; Sun, 27 Jul 2025 04:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPI-0000sa-1x
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPF-0004iX-PV
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-237311f5a54so28275045ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603612; x=1754208412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5KGw0rszlxfQOasp4Y8/ClM9+NCtEfoSabGbZCzMS4=;
 b=ktygabfN0hBV3mo5IC6pJIqD9oWdZrL3hZD6GvCddn2/9af12cFTxeZFWt9aWrj81/
 oG1Y6IVM47T4qoLUqQ2eFv87QfrjExjoAl9n2FKiSUBMCpB4Uf2fZ9KY2RfDkj1SPaAc
 o9ZgcIkGzS7Cn6ncupkG5DFI6LdvtQSm3tYMc6bhiI8pgGqibr4oPfhxTmBItbOHS4nq
 2oVuisTadsEQY9lGOOcszbnSYdkmMGDbv1/sk5SDVzeQBSMJlvtHfqZ+T2YCMx58tUGn
 CkuGRiOCJYjE7TshanQR/pIRNfoHZ58iU9k3SPxpqlfY7/+aI9jcus1MdgtQ3ySajDIA
 VTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603612; x=1754208412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5KGw0rszlxfQOasp4Y8/ClM9+NCtEfoSabGbZCzMS4=;
 b=tes+UJ4RfBAcwB3Jdhv4owoP1u30tbAD/9LMsjSL9PAn5Y6ip8RYgKclDFWMygdOG5
 NDtdcnxo8oBiNmQLj53ksFFag3fAAdVtmC9aGTbw91t3I52eFgRgbEuXDAo2RNQ/Bxbd
 5rgFrUiMxsgXGCsMpApnPOo3/HRFGL/SNjMzy5I0DnvpbDiRPLsmz0jNIJA1nIkBUc+4
 1h2zhtyHWV7jp8//5KbRlmDiR/8HT7vnWSizjkyRTQNeolf+WKLl+4h1dL9/xfKvlu5o
 +1LT9k/hx5ljrdz5GRcYZfriMO9+VNqvrtrHhhm8Ywth+RF36FJ7C3leVZoopSlaA0Wp
 hRjg==
X-Gm-Message-State: AOJu0Yx48/8TqU67MinT2YZWuzO/exIg6fpQVtUlTU+VTN0/njS2L7GL
 ZM3h567yvprXxPykTeF6x36vKiof81RYcCZb+3TOxjnSwfhlMePgx3PQCuPqIVwXnUhRHQwWeFf
 0JOpx
X-Gm-Gg: ASbGncs0bgNRNbNclKjsgrKdCQKqBks3p1LGmIuzb+3LUQ0uNN4sxQjbluUm6OSy7WR
 WCcHQgOBbDu/sQ2kfPFSGNnW8AuE6Z8oLH7P+jfey2z0NsFzhLzy/iIEiytNSg+flU/2p6sMvTO
 J4EkM0TIy/5iIlfjZCJNwuZhITsMbVSwlbYf5IQaeD1n8+pWHmDgwsaHNRBduK7VPr/i/ZCIYrd
 Jylrgez2vG/fTrHhwdOP3yOJT3auailO0Y+Qx2ids13fcYVdFIfyS+/aH9GvEYVT8V5QTP4W8o3
 JUxcjyJbE3NT1Gb76OlSayuz/Nc286suBKq9NQ2/aQzg/mn8/Yc6Jm0+u43y1AwsY0PX86M2x0U
 V/1r+HCROlbpRmlvrcAGzDMd4MVF6zrhcvjKPJdIoXfcR4xG6d2JxtlTLeuBxr46VGtaV7Hdkhd
 QuHtJsK3RV6g==
X-Google-Smtp-Source: AGHT+IH8McHdk+grdCjzVKen7FGqyuLTHeSkNtc79Qcv8+YVmp5fw0PC4BlSP+B5QC7uza4W+F/scw==
X-Received: by 2002:a17:902:f605:b0:23f:c945:6067 with SMTP id
 d9443c01a7336-23fc94568c5mr65886905ad.41.1753603612210; 
 Sun, 27 Jul 2025 01:06:52 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 45/82] target/arm: Add GCS enable and trap levels to
 DisasContext
Date: Sat, 26 Jul 2025 22:02:17 -1000
Message-ID: <20250727080254.83840-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Pipe GCSEnabled, GCSReturnValueCheckEnabled, and CheckGCSSTREnabled
through hflags to the translator.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  3 +++
 target/arm/tcg/translate.h     |  6 ++++++
 target/arm/tcg/hflags.c        | 38 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  3 +++
 4 files changed, 50 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1da73196f0..98360b70b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2918,6 +2918,9 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
 FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
+FIELD(TBFLAG_A64, GCS_EN, 41, 1)
+FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
+FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f974996f3f..3e63dad2b6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -164,6 +164,12 @@ typedef struct DisasContext {
     bool fpcr_ah;
     /* True if FPCR.NEP is 1 (FEAT_AFP scalar upper-element result handling) */
     bool fpcr_nep;
+    /* True if GCSEnabled. */
+    bool gcs_en;
+    /* True if GCSReturnValueCheckEnabled. */
+    bool gcs_rvcen;
+    /* GCSSTR exception EL or 0 if enabled */
+    uint8_t gcsstr_el;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 59ab526375..2e3a9cf0d3 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -449,6 +449,44 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
     }
 
+    if (cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
+        /* C.f. GCSEnabled */
+        if (env->cp15.gcscr_el[el] & GCSCR_PCRSEL) {
+            switch (el) {
+            default:
+                if (!el_is_in_host(env, el)
+                    && !(arm_hcrx_el2_eff(env) & HCRX_GCSEN)) {
+                    break;
+                }
+                /* fall through */
+            case 2:
+                if (arm_feature(env, ARM_FEATURE_EL3)
+                    && !(env->cp15.scr_el3 & SCR_GCSEN)) {
+                    break;
+                }
+                /* fall through */
+            case 3:
+                DP_TBFLAG_A64(flags, GCS_EN, 1);
+                break;
+            }
+        }
+
+        /* C.f. GCSReturnValueCheckEnabled */
+        if (env->cp15.gcscr_el[el] & GCSCR_RVCHKEN) {
+            DP_TBFLAG_A64(flags, GCS_RVCEN, 1);
+        }
+
+        /* C.f. CheckGCSSTREnabled */
+        if (!(env->cp15.gcscr_el[el] & GCSCR_STREN)) {
+            DP_TBFLAG_A64(flags, GCSSTR_EL, el ? el : 1);
+        } else if (el == 1
+                   && EX_TBFLAG_ANY(flags, FGT_ACTIVE)
+                   && !FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR],
+                                  HFGITR_EL2, NGCSSTR_EL1)) {
+            DP_TBFLAG_A64(flags, GCSSTR_EL, 2);
+        }
+    }
+
     if (env->vfp.fpcr & FPCR_AH) {
         DP_TBFLAG_A64(flags, AH, 1);
     }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dbf47595db..7831b3dab3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10162,6 +10162,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
     dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
+    dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
+    dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
+    dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.43.0


