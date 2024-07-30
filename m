Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEF9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJi-00039e-Mz; Tue, 30 Jul 2024 12:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJh-000346-EF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJe-0000Fc-MD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so27917225e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355389; x=1722960189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MzA6yndkssVsonTKDMnjVcpdRFu5VtP6syrp6zmpq4E=;
 b=ir9dZ3YJPUo/CIDm54tqFp1AasR6mmctWCOwGZ4khO5oLWMSW77KRSNOp0vQX10kdX
 fKJ0AyQqP1trHICdwJ/xa3hobpseOgGYlRDVR2gXxUtQYXcCNfbS3SCreusKmZtpBEr/
 R4h7fg3fLLEdh0mB+DQhuUg4QvI4w8b7MlJh4x4JXnCTULieClDeHFk0RWD1cBTtKVYs
 PSgzmSUCUdCuZnZdIqwc1JvYVNsI8+9HW18+HGMq+82W65AUOLUyNZUJqKJTQ965mU9m
 8KZWpyer3DUiA259xhAdu4N+GCan/rrCA7jPZfOMko5Ejsr7fxUuH01BbuMFwTs7UQZL
 marQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355389; x=1722960189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzA6yndkssVsonTKDMnjVcpdRFu5VtP6syrp6zmpq4E=;
 b=gd7QLuPRy99YWVHOMOqWKv1PolF9Fm4/6j4iG/jMP3wyHCLpoqaDt7T+4fyHMz46yg
 U0kiRef5cGYqpfLBeQT5C9UGqKlnrbJtmULZBafe6js+kymEZHm0nFckUzXGvj32qkId
 OBWUnfquaQf5dxxLXodHqzXPlWi1dJkxICpfEcwMWNOIRSN61AC4LrUQI7Yu+MZhq85J
 MC5cFF6jQZ8mHOrsnAMNdjY3GXYauXsSxjNvTIum6zR0kziOxZGFzrwpS13BERAkT30I
 1dIUuj3pxRDz1Om3F74b9EgOOS3lyg6BN3T1QO2xNUyJHrPZ+KEbWZlrOekuO6/vHWom
 t4sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjJxoRy+4BDej80BmLLu8mDypu5ehD8p8H4bVtNee27su4W2exPutpJvlK7ASSNn44rn5u+zFnSzO0xeoJ3HcJWhvvv6M=
X-Gm-Message-State: AOJu0YwI5QOnIF9jL6n7sSdjHs8UfoD9tkvfF4PWq1n3jw7e+jlXZ8zT
 AHDwfsq7c+5++YFiytZon82sdoYDtY9sbPTKYEN++PQYW4okvdsf6GmlHtesrVkdqoLoPccg5o+
 n
X-Google-Smtp-Source: AGHT+IE+yXJxpolR06rGC1+uZtIYYRn9kaSlm//LYMQyZQ6nvbdGrkjwW0AWIRewFbgjZ0Bz4odOuQ==
X-Received: by 2002:adf:fc0c:0:b0:366:e7aa:7fa5 with SMTP id
 ffacd0b85a97d-36b5d0b094cmr7074359f8f.1.1722355388644; 
 Tue, 30 Jul 2024 09:03:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/8] target/arm: Allow setting the FPCR.EBF bit for FEAT_EBF16
Date: Tue, 30 Jul 2024 17:02:59 +0100
Message-Id: <20240730160306.2959745-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

FEAT_EBF16 adds one new bit to the FPCR floating point control
register.  Allow this bit to be read and written when the ID
registers indicate the presence of the feature.

Note that because this new bit is not in FPSCR_FPCR_MASK the bit is
not visible in the AArch32 FPSCR, and FPSCR writes do not affect it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/cpu.h          | 1 +
 target/arm/vfp_helper.c   | 8 ++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c59ca104fe1..cfb82c23cad 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -556,6 +556,11 @@ static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
 }
 
+static inline bool isar_feature_aa64_ebf16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) > 1;
+}
+
 static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a12859fc533..34df9d7e39b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1707,6 +1707,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
 #define FPCR_UFE    (1 << 11)   /* Underflow exception trap enable */
 #define FPCR_IXE    (1 << 12)   /* Inexact exception trap enable */
+#define FPCR_EBF    (1 << 13)   /* Extended BFloat16 behaviors */
 #define FPCR_IDE    (1 << 15)   /* Input Denormal exception trap enable */
 #define FPCR_LEN_MASK (7 << 16) /* LEN, A-profile only */
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index b3698da8ca7..203d37303bd 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -254,6 +254,10 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
         val &= ~FPCR_FZ16;
     }
 
+    if (!cpu_isar_feature(aa64_ebf16, cpu)) {
+        val &= ~FPCR_EBF;
+    }
+
     vfp_set_fpcr_to_host(env, val, mask);
 
     if (mask & (FPCR_LEN_MASK | FPCR_STRIDE_MASK)) {
@@ -278,12 +282,12 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode
+     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode, EBF
      * and FZ16. Len, Stride and LTPSIZE we just handled. Store those bits
      * there, and zero any of the other FPCR bits and the RES0 and RAZ/WI
      * bits.
      */
-    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16;
+    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16 | FPCR_EBF;
     env->vfp.fpcr &= ~mask;
     env->vfp.fpcr |= val;
 }
-- 
2.34.1


