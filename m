Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765DCD0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L42-0004FG-Un; Fri, 25 Oct 2024 10:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3x-00049G-Qn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3p-0007pT-Sz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso20341415e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865584; x=1730470384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlVlvBeEo5iy1psg/A6qK9cIHAMeC9pxkWdSURdFSQg=;
 b=Bj8wxhAm9lpUJ1fIxmemV7A4Fhlzh6VxATJrSopcjMESDHrrWek+eh+R60432Qui77
 I7+BvAPgiD/BJqkOMReTZ77j1yhCCpcsSU0/iAzE3AI10kYAje5qerfdZh7WhIBC6CZD
 wX7S6y86FwJ4w6gq7pl6e4jfaWTAHuh831DhRn+GEun/mesvE74+F66eyvv37bcOnd6C
 qEtNxBk380xAreFiLfRkU/QwRZpTR7sJgsAjlRaF2GbTIm8PMZasS5+BzHgZVvuoqLl3
 FLVIuNPmmzXERchBoxiJRJFsg477wo6s5LBuCcnfgT8USyaEj5sCrgELo9Cvl28sCTDU
 uOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865584; x=1730470384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlVlvBeEo5iy1psg/A6qK9cIHAMeC9pxkWdSURdFSQg=;
 b=ghywnIFnV2NnppBQWlNjt91EIqD/LrAe975h3FP3BqJKiJa5YX4yNuEs5Sb8e1cwio
 1Nx0tUr4Plxn80MOvhrvX7p0ZvBUgVRuKoBOfoDbZbUIzSUnrwvix6NFIgfDKg6921kl
 ZDvYwDvQqaR1fq5PQ6nCjRR9ux4MAhBOiPzqvkE3zaFod8/8f1moE7+68zdkRpKDEagq
 Exdx8k1jkUfzgz8T9xhLwEi7zK5X5krYtCs4LNKoF01BtvT3aRRaldPisNfZ8W7Zpg95
 RSrfZlaBcyGgQLFHdT/S5bJ0dOKVh5iYJh1Ii5nHzZ1p42FOofvdMu1OX6T8Sz8zoZ7j
 14HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyHgj+gulJuU60iHK1UK3hXsbD26mQta/t5PBwGpzrEM+VudOCwSF+mNc0M9mrLdmcvVGEOwaxozxC@nongnu.org
X-Gm-Message-State: AOJu0YyWcpM4JDmdeUbf7V0nRizzzywqwagI506FCcXyOnzPEn+ZbtdZ
 WudpqSE3/WXSHf8cbu8mtiW9xcUMRDqhuC067ce9fUkIJZq/QyrNkuu10HXnFHM=
X-Google-Smtp-Source: AGHT+IHuVmVPpD0uEEE99zbT59LiMowu3UFFLJFExcm831LgVTVmwcTaFFic7V7R5EgyO383KTowLQ==
X-Received: by 2002:a05:600c:34cb:b0:430:5760:2fe with SMTP id
 5b1f17b1804b1-4318c73947emr54557345e9.22.1729865584260; 
 Fri, 25 Oct 2024 07:13:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 09/21] target/m68k: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:42 +0100
Message-Id: <20241025141254.2141506-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Explicitly set the 2-NaN propagation rule on env->fp_status
and on the temporary fp_status that we use in frem (since
we pass that to a division operation function).
---
 target/m68k/cpu.c              | 16 ++++++++++++++++
 target/m68k/fpu_helper.c       |  1 +
 fpu/softfloat-specialize.c.inc | 19 +------------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1d49f4cb238..5fe335558aa 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -93,6 +93,22 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
         env->fregs[i].d = nan;
     }
     cpu_m68k_set_fpcr(env, 0);
+    /*
+     * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
+     * 3.4 FLOATING-POINT INSTRUCTION DETAILS
+     * If either operand, but not both operands, of an operation is a
+     * nonsignaling NaN, then that NaN is returned as the result. If both
+     * operands are nonsignaling NaNs, then the destination operand
+     * nonsignaling NaN is returned as the result.
+     * If either operand to an operation is a signaling NaN (SNaN), then the
+     * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
+     * is set in the FPCR ENABLE byte, then the exception is taken and the
+     * destination is not modified. If the SNaN exception enable bit is not
+     * set, setting the SNaN bit in the operand to a one converts the SNaN to
+     * a nonsignaling NaN. The operation then continues as described in the
+     * preceding paragraph for nonsignaling NaNs.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     env->fpsr = 0;
 
     /* TODO: We should set PC from the interrupt vector.  */
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 8314791f504..a605162b71f 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -620,6 +620,7 @@ void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
         int sign;
 
         /* Calculate quotient directly using round to nearest mode */
+        set_float_2nan_prop_rule(float_2nan_prop_ab, &fp_status);
         set_float_rounding_mode(float_round_nearest_even, &fp_status);
         set_floatx80_rounding_precision(
             get_floatx80_rounding_precision(&env->fp_status), &fp_status);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8e3124c11a6..226632a4d10 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -404,25 +404,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
-    || defined(TARGET_S390X) || defined(TARGET_PPC)
+    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K)
         g_assert_not_reached();
-#elif defined(TARGET_M68K)
-        /*
-         * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
-         * 3.4 FLOATING-POINT INSTRUCTION DETAILS
-         * If either operand, but not both operands, of an operation is a
-         * nonsignaling NaN, then that NaN is returned as the result. If both
-         * operands are nonsignaling NaNs, then the destination operand
-         * nonsignaling NaN is returned as the result.
-         * If either operand to an operation is a signaling NaN (SNaN), then the
-         * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
-         * is set in the FPCR ENABLE byte, then the exception is taken and the
-         * destination is not modified. If the SNaN exception enable bit is not
-         * set, setting the SNaN bit in the operand to a one converts the SNaN to
-         * a nonsignaling NaN. The operation then continues as described in the
-         * preceding paragraph for nonsignaling NaNs.
-         */
-        rule = float_2nan_prop_ab;
 #elif defined(TARGET_SPARC)
         /* Prefer SNaN over QNaN, order B then A. */
         rule = float_2nan_prop_s_ba;
-- 
2.34.1


