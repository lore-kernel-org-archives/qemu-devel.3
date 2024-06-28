Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2891C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWn-0002kJ-VP; Fri, 28 Jun 2024 10:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWW-0002as-Hj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWA-0004WR-C8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4248ea53493so4679265e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584637; x=1720189437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qFKbjEQVvGqbAWXZ08SAtjIV2lRpxC1k2dabDVF9NgU=;
 b=jMyR9njlQHt5OafUUxiWqfRAIlBgz89X5vrys98gxbDogYG65uOv1ThaZC4cOgujun
 Oe0A+0OXnhEZhAvGzga5AYTv4TKGE+79+LcSsBq37lTNly6f0WFc3HgtBr51br6Va0ng
 SQ8s4u2m7BvKxWELlPtQyCZD1y3qvk1OT3d4dM5GTw5dnY5jQv+p6uvApDWzfKx/MvCf
 lCy++1F/HEeToRMToX5CAMOg1M5GLcBMDEcyKFqIzQ0o1gpEQOVFDSCHOVP9WnwL0uLr
 tNjwI2/u4BMASJCNHJjdVCYmAHlsw9RTHcpQ4XWbh7qe1LL71RxGXyH/3t9MDzd+vCEL
 MMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584637; x=1720189437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFKbjEQVvGqbAWXZ08SAtjIV2lRpxC1k2dabDVF9NgU=;
 b=tuUKot8swhKvGt9Rp0EXpV00X5sI2GsT6+2sFW3llkxAQfnOFywt4pl2iIuEeL0VUx
 2ymBxzQJZeWmaYs7F75YHRAEY6j+i3T7aXJjfzjPSoSaixmC3mkj6heQwTcfjbx1gTwz
 nk3N0NpXkIicuE8DEkpbH1HoFrbvHosbDk2xN87A4nZLkUbtQjNMMGNii3qoMEzBY8RI
 9MT2aFdYHF2huQegf3HY8oWPhUxephSpI/NwlYNsiP7o7ylnlYVOa7QCubde2mTlHeBJ
 Fo9eYHYfo7Jvq+jeWlmzhaN4ASE8h6OAEIHnc96se4zcthIKaTIKOhaJLu29Em+rtx4e
 mcTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdnExHk9rdSsJ9XotaX52jSglwwISbLUyxSFq1/MGK1qQ0EYVygIggHw/5tTxUnFU3Vq7/Lm/Mgu93i3PS6Zbw0vYYVUU=
X-Gm-Message-State: AOJu0YwhlscBq2a7GdpN4dmH88ECMBpEqG3UAFjO+01rFazqbywR6cAx
 Ci0UuLl4fp/nMqC5duPamtcjFWFSXS9LpYjZ3Mcptv7jAHNMKXnkCCjXMsopHf0=
X-Google-Smtp-Source: AGHT+IExRphxE5MFH8rVRiyMwWAh3HHoD65qzCiQZQDUsxEPCErcLw0YerzC+LiPcbgRCcntM8ABXQ==
X-Received: by 2002:a05:600c:8a2:b0:424:a400:21cf with SMTP id
 5b1f17b1804b1-424a4002337mr77568375e9.23.1719584637603; 
 Fri, 28 Jun 2024 07:23:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 8/9] target/arm: Rename FPSR_MASK and FPCR_MASK and define
 them symbolically
Date: Fri, 28 Jun 2024 15:23:46 +0100
Message-Id: <20240628142347.1283015-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that we store FPSR and FPCR separately, the FPSR_MASK and
FPCR_MASK macros are slightly confusingly named and the comment
describing them is out of date.  Rename them to FPSCR_FPSR_MASK and
FPSCR_FPCR_MASK, document that they are the mask of which FPSCR bits
are architecturally mapped to which AArch64 register, and define them
symbolically rather than as hex values.  (This latter requires
defining some extra macros for bits which we haven't previously
defined.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        | 41 ++++++++++++++++++++++++++++++++++-------
 target/arm/machine.c    |  3 ++-
 target/arm/vfp_helper.c |  7 ++++---
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9d226c474d2..f6339bde216 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1687,15 +1687,19 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 
-/* FPCR, Floating Point Control Register
- * FPSR, Floating Poiht Status Register
+/*
+ * FPCR, Floating Point Control Register
+ * FPSR, Floating Point Status Register
  *
- * For A64 the FPSCR is split into two logically distinct registers,
- * FPCR and FPSR. However since they still use non-overlapping bits
- * we store the underlying state in fpscr and just mask on read/write.
+ * For A64 floating point control and status bits are stored in
+ * two logically distinct registers, FPCR and FPSR. We store these
+ * in QEMU in vfp.fpcr and vfp.fpsr.
+ * For A32 there was only one register, FPSCR. The bits are arranged
+ * such that FPSCR bits map to FPCR or FPSR bits in the same bit positions,
+ * so we can use appropriate masking to handle FPSCR reads and writes.
+ * Note that the FPCR has some bits which are not visible in the
+ * AArch32 view (for FEAT_AFP). Writing the FPSCR leaves these unchanged.
  */
-#define FPSR_MASK 0xf800009f
-#define FPCR_MASK 0x07ff9f00
 
 /* FPCR bits */
 #define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
@@ -1704,7 +1708,9 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_UFE    (1 << 11)   /* Underflow exception trap enable */
 #define FPCR_IXE    (1 << 12)   /* Inexact exception trap enable */
 #define FPCR_IDE    (1 << 15)   /* Input Denormal exception trap enable */
+#define FPCR_LEN_MASK (7 << 16) /* LEN, A-profile only */
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
+#define FPCR_STRIDE_MASK (3 << 20) /* Stride */
 #define FPCR_RMODE_MASK (3 << 22) /* Rounding mode */
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
 #define FPCR_DN     (1 << 25)   /* Default NaN enable bit */
@@ -1714,16 +1720,37 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_LTPSIZE_MASK (7 << FPCR_LTPSIZE_SHIFT)
 #define FPCR_LTPSIZE_LENGTH 3
 
+/* Cumulative exception trap enable bits */
+#define FPCR_EEXC_MASK (FPCR_IOE | FPCR_DZE | FPCR_OFE | FPCR_UFE | FPCR_IXE | FPCR_IDE)
+
 /* FPSR bits */
+#define FPSR_IOC    (1 << 0)    /* Invalid Operation cumulative exception */
+#define FPSR_DZC    (1 << 1)    /* Divide by Zero cumulative exception */
+#define FPSR_OFC    (1 << 2)    /* Overflow cumulative exception */
+#define FPSR_UFC    (1 << 3)    /* Underflow cumulative exception */
+#define FPSR_IXC    (1 << 4)    /* Inexact cumulative exception */
+#define FPSR_IDC    (1 << 7)    /* Input Denormal cumulative exception */
 #define FPSR_QC     (1 << 27)   /* Cumulative saturation bit */
 #define FPSR_V      (1 << 28)   /* FP overflow flag */
 #define FPSR_C      (1 << 29)   /* FP carry flag */
 #define FPSR_Z      (1 << 30)   /* FP zero flag */
 #define FPSR_N      (1 << 31)   /* FP negative flag */
 
+/* Cumulative exception status bits */
+#define FPSR_CEXC_MASK (FPSR_IOC | FPSR_DZC | FPSR_OFC | FPSR_UFC | FPSR_IXC | FPSR_IDC)
+
 #define FPSR_NZCV_MASK (FPSR_N | FPSR_Z | FPSR_C | FPSR_V)
 #define FPSR_NZCVQC_MASK (FPSR_NZCV_MASK | FPSR_QC)
 
+/* A32 FPSCR bits which architecturally map to FPSR bits */
+#define FPSCR_FPSR_MASK (FPSR_NZCVQC_MASK | FPSR_CEXC_MASK)
+/* A32 FPSCR bits which architecturally map to FPCR bits */
+#define FPSCR_FPCR_MASK (FPCR_EEXC_MASK | FPCR_LEN_MASK | FPCR_FZ16 | \
+                         FPCR_STRIDE_MASK | FPCR_RMODE_MASK | \
+                         FPCR_FZ | FPCR_DN | FPCR_AHP)
+/* These masks don't overlap: each bit lives in only one place */
+QEMU_BUILD_BUG_ON(FPSCR_FPSR_MASK & FPSCR_FPCR_MASK);
+
 /**
  * vfp_get_fpsr: read the AArch64 FPSR
  * @env: CPU context
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8c820955d95..a3c1e05e65d 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -43,7 +43,8 @@ static bool vfp_fpcr_fpsr_needed(void *opaque)
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
 
-    return (vfp_get_fpcr(env) & ~FPCR_MASK) || (vfp_get_fpsr(env) & ~FPSR_MASK);
+    return (vfp_get_fpcr(env) & ~FPSCR_FPCR_MASK) ||
+        (vfp_get_fpsr(env) & ~FPSCR_FPSR_MASK);
 }
 
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 1ac0142e10f..586c33e9460 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -202,7 +202,8 @@ uint32_t vfp_get_fpsr(CPUARMState *env)
 
 uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
 {
-    return (vfp_get_fpcr(env) & FPCR_MASK) | (vfp_get_fpsr(env) & FPSR_MASK);
+    return (vfp_get_fpcr(env) & FPSCR_FPCR_MASK) |
+        (vfp_get_fpsr(env) & FPSCR_FPSR_MASK);
 }
 
 uint32_t vfp_get_fpscr(CPUARMState *env)
@@ -280,8 +281,8 @@ void vfp_set_fpcr(CPUARMState *env, uint32_t val)
 
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
-    vfp_set_fpcr(env, val & FPCR_MASK);
-    vfp_set_fpsr(env, val & FPSR_MASK);
+    vfp_set_fpcr(env, val & FPSCR_FPCR_MASK);
+    vfp_set_fpsr(env, val & FPSCR_FPSR_MASK);
 }
 
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
-- 
2.34.1


