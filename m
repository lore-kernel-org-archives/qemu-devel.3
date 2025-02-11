Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D27C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6P-00075D-Eg; Tue, 11 Feb 2025 11:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5K-0006OJ-7L
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5I-00032k-BA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4395578be70so6995695e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291163; x=1739895963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X2anKa/lVPzxWCwUeQXfcN+aqjVixE/9zH1oGnHUOpE=;
 b=VTlmcWUMpg6pcZmjHxwWR6EXxexZ9m5VS+gARbXw8sOJiLw98v3Y9KAguB12XaEswh
 TP7m5raod/TeHGnSfawPaYzPI+eO4JPrbrlB2SyMAOrvLdztfAshZrRqfV1KqxMF4+Im
 tZh2I/gKViz3DWqhqAjMePGIhk1ZVroUrR8KGNCcEcp4mjQRrJ+vhnqg/3uzPHBG2HFH
 Nqh4PikzaEkYzQtAaOd8Q6y+kfjcH5p9KnxZTMZxRCJzzdjGEcm/bHzzlTjIAFSX2VCe
 bgWnmGYgcx+RZzPVCF9p4dtAai0xkyezZHL+tDYBTTuI4IJTIT1QCjy9GLija+oIdyKR
 MS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291163; x=1739895963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2anKa/lVPzxWCwUeQXfcN+aqjVixE/9zH1oGnHUOpE=;
 b=AOyNKthOgIuoJssmXkYCeIx/agpNI34UPtPDwnyvA1MrqCiH0PMOna83RHR2+0w6wJ
 ZndxHutwU1gLIBRzSkOH9yYLaPks9YGC+mLOp7/+deduPHQiA/joPVXV8LA6rzofa6bZ
 nNZQJYIXYF0RNEjFNlNcRtmi5U4A3DmarUhxF+RvC47/lE8ux8lBpY6qGX5big4V6twE
 Hgvi9aPUhHxpgr5ROJkvPUnuRyNhP9gQNGEwwk4xSLzTItt3jN+ui/PN2qfi1+jST7w8
 70VC/OcFihorJbz9yLmT2C7moXlYG9mTKdihYH0FMSIZfhy9iZj5v/tzEpRU2oBHQtVw
 smeQ==
X-Gm-Message-State: AOJu0Yw8q9p1rZFdEnDosT6fhZP5HqfgRWXHccRs0X9T46+yC3wJstIY
 LNuCAwS7SlVkO/qVR7RT2sthuNuQk6nSqQl6SplFFm5+ZA40lixtqpoP1BW38qfTi3DyXd2tfRM
 P
X-Gm-Gg: ASbGncvtf5v2RcUxYgiuE/oM5nqrlWeCA0GsB/lxKaG/rdVxFpim8j9LXoiLvSksXQe
 y9Ww+fyo1Rahu0qkXHHHqbVeuRFu4cIa2LdR4QVyJY/mzF4rCpibWh5SvH2OB77S6siVjpi2Iyh
 9TU27TNb7B25O4QZyl4PS9DzuTHyWKysbnlNoK0zYKgeAW9ZO2+0fRWNhWZjc1C9LPIQAIT0STe
 drkW6UOX6JOkw/4jXLcAl1/Ef4ZwqdsAnEm2PJu5JVByH+xFS9xiUs4PJ2VEeX20IjPhmSg0b62
 E/iqpyAXkjCkFuCjK97G
X-Google-Smtp-Source: AGHT+IGLad8mm1Aqox2Wpvumd4jySl47qqAxXJYixSDpusGnVX+fbB6bHFsQ64pG+7T1zEVCRpdPEQ==
X-Received: by 2002:a05:600c:3c84:b0:435:32e:8270 with SMTP id
 5b1f17b1804b1-43924991e0cmr159333135e9.14.1739291162699; 
 Tue, 11 Feb 2025 08:26:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/68] target/arm: Define FPCR AH, FIZ, NEP bits
Date: Tue, 11 Feb 2025 16:24:51 +0000
Message-Id: <20250211162554.4135349-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The Armv8.7 FEAT_AFP feature defines three new control bits in
the FPCR:
 * FPCR.AH: "alternate floating point mode"; this changes floating
   point behaviour in a variety of ways, including:
    - the sign of a default NaN is 1, not 0
    - if FPCR.FZ is also 1, denormals detected after rounding
      with an unbounded exponent has been applied are flushed to zero
    - FPCR.FZ does not cause denormalized inputs to be flushed to zero
    - miscellaneous other corner-case behaviour changes
 * FPCR.FIZ: flush denormalized numbers to zero on input for
   most instructions
 * FPCR.NEP: makes scalar SIMD operations merge the result with
   higher vector elements in one of the source registers, instead
   of zeroing the higher elements of the destination

This commit defines the new bits in the FPCR, and allows them to be
read or written when FEAT_AFP is implemented.  Actual behaviour
changes will be implemented in subsequent commits.

Note that these are the first FPCR bits which don't appear in the
AArch32 FPSCR view of the register, and which share bit positions
with FPSR bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  3 +++
 target/arm/vfp_helper.c   | 11 ++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 30302d6c5b4..7bf24c506b3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
 }
 
+static inline bool isar_feature_aa64_afp(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, AFP) != 0;
+}
+
 static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c2d2d99b462..1c91b1f50f2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1714,6 +1714,9 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
  */
 
 /* FPCR bits */
+#define FPCR_FIZ    (1 << 0)    /* Flush Inputs to Zero (FEAT_AFP) */
+#define FPCR_AH     (1 << 1)    /* Alternate Handling (FEAT_AFP) */
+#define FPCR_NEP    (1 << 2)    /* SIMD scalar ops preserve elts (FEAT_AFP) */
 #define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
 #define FPCR_DZE    (1 << 9)    /* Divide by Zero exception trap enable */
 #define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 3c8f3e65887..8c79ab4fc8a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -242,6 +242,9 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
     if (!cpu_isar_feature(any_fp16, cpu)) {
         val &= ~FPCR_FZ16;
     }
+    if (!cpu_isar_feature(aa64_afp, cpu)) {
+        val &= ~(FPCR_FIZ | FPCR_AH | FPCR_NEP);
+    }
 
     if (!cpu_isar_feature(aa64_ebf16, cpu)) {
         val &= ~FPCR_EBF;
@@ -271,12 +274,14 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode, EBF
-     * and FZ16. Len, Stride and LTPSIZE we just handled. Store those bits
+     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode, EBF, FZ16,
+     * FIZ, AH, and NEP.
+     * Len, Stride and LTPSIZE we just handled. Store those bits
      * there, and zero any of the other FPCR bits and the RES0 and RAZ/WI
      * bits.
      */
-    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16 | FPCR_EBF;
+    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16 |
+        FPCR_EBF | FPCR_FIZ | FPCR_AH | FPCR_NEP;
     env->vfp.fpcr &= ~mask;
     env->vfp.fpcr |= val;
 }
-- 
2.34.1


