Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7CCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfb-00082k-2B; Tue, 29 Sep 2026 06:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfH-0007cn-H5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:27 -0400
Received: from mail-ej2-x0d.google.com ([2a00:1450:4864:34::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfF-0008FY-S7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:23 -0400
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2dcdc386ddso296526066b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676140; x=1791280940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HltrDrUs47tkb4C1KnaoxhwX552riqDQeLdTh8QJq3E=;
 b=hb0csN5ZuJFpILwpGA+AkgbjW1IkTirSxw/edFYKE5QQh7ZgvNSZgbeIXF3z2XHJCB
 /91S4OkKd5XaiIXpwvqcInqlfp7/UeE84Wd2t/N0Yywzr486NiWMgRmsxa2AYQNpVUYZ
 BxuzaEjQeypZ2y6XE36pq3u1PkvdZfDExbf+Ehwn0vjOfrMVVIPJUklam1tWLFcDv8A+
 S0tYiTnYz80FHKsYr1xcR4H1yNpOyISHToqOpqJuREsVBfXI5UQbbAa3kzpYmIKXSGN8
 3iyERs+BWrLO3ftXIBXddg91B2C34LpTJ/EHc8jOohRW2zQQfsU/s6N597MItm+DMUtQ
 AjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676140; x=1791280940;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HltrDrUs47tkb4C1KnaoxhwX552riqDQeLdTh8QJq3E=;
 b=ZCewd7tutPCNW0eXCWd5Ca4rn1hXmMcvzrmgOTWNIu6m8PrGsJNSnk7vbDkB75fIF5
 T24f+Uilf+ZSeBQ1DBc7hbEA5n5mED4nevrhALW7coSnLS9nBWJf3a3HmUdtpgAafYaq
 nkdhCLozDBxqczZ/NmFztcnrpG3Br6H3m5VXrex9pl1aoxw9EKAaNjnxeJBP8xJMUxnR
 xmKQ+nnIJ0CPkl3n1ISQ+14nBRsLl2a17XlPWYCaRMChuko+EzhWBqyltFXa4I0+q6uO
 TJ/KTET2bmuRzw2/02+nJTTgleulXfagzn2nnZAgd2ub9WchOM6kbvl2KjSyGe99USJ3
 N3bA==
X-Gm-Message-State: AFuF++nBOyS5kriXjaSfwQiJQb2i8Y23JHYhqJK9z+LnyawAzcBGbMvM
 AkzN0+82sh2xzuUPsZRpnyQs4YxBiEZhMxX9XQZjaAGy4Cz+8qOYiDhhCfYZKEzIgig7GcIg597
 Unega
X-Gm-Gg: AYBFou3q6OalenCkae2Z5uHBcInFT4IbXx2FkFH4T0zOOtsADwZyOjlsxte2cRUMINa
 /kjnuGD92Dn6EBshyVrbEgP9a5JvzPH6AQ5fmLY2B5BCBEnbqTHlUewJNBhH/gTW5pjqLYZS7fj
 CDj8EcWEKw7D5vg7SilYWPDY3thKeAIwKkHc2wiMC4FUcZrh2H0oT+CJsaoD7KnknBDAN0CoN8N
 jQe0hynex2lkqXNV7ApdWBeoWNCLZRpiynUNp6kACpGWRz0AVYO9Zcypfevx3W4VVZf9IfXvlV3
 gzBPX0dPHHqtnYQ29tYsXE9wZRfMTQqv7itPsQhu+3CX8Rx2jFmMOtEpxiEhALRDttKj1e/OKIA
 7imldVhl4WwC5vJ5s7FMxlBgRCthoqDonXObNzdXNxSFVVU6ZDqF4Q0j70qmS5FCXyJThKfOuBB
 yr41sbf5yJ9xVslYEvABeiUzUOqwIcVLq5l7QnyxvE2q9QPClnsvQBzjMh2sMV1G3zc0lZj9QsA
 +fJpgQbCwSIngW1ZImrgfP2QGe/2YOG8mF6ZaD+T36Ca9WwFun8cGDvirmM4z36Sp+EcHPCum3W
 kWg=
X-Received: by 2002:a17:906:c115:b0:c26:22ae:b66b with SMTP id
 a640c23a62f3a-c2ac2328075mr1328659366b.15.1790676140208; 
 Tue, 29 Sep 2026 03:02:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/37] target/arm: Clear PSTATE.UINJ when taking exceptions
Date: Tue, 29 Sep 2026 11:01:24 +0100
Message-ID: <20260929100133.2598676-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej2-x0d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Clear UINJ when taking an exception.
Clear UINJ when exception return is invalid.

In both cases, perform the clear without feature check,
since the bit is otherwise RES0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            | 1 +
 target/arm/helper.c         | 9 +++++++++
 target/arm/tcg/helper-a64.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 141cfdf6a88..78bf4576a58 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1603,6 +1603,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_Z (1 << 30)
 #define PSTATE_N (1ULL << 31)
 #define PSTATE_EXLOCK (1ULL << 34)
+#define PSTATE_UINJ (1ULL << 36)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
 #define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9ba924e5de3..76956cfd97b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9744,6 +9744,15 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
         env->condexec_bits = 0;
     }
+
+    /*
+     * R_XKSNJ: If FEAT_UINJ, PSTATE.UINJ is set to 0 *and* the resulting
+     * value stored in SPSR_ELx is 0.  The new PSTATE is automatically
+     * handled by construction of a new value from 0; clear it from the
+     * old state and as UINJ is RES0 otherwise, skip the feature check.
+     */
+    old_mode &= ~PSTATE_UINJ;
+
     env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
 
     qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%" PRIx64 "\n", old_mode);
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9d805231a08..f76d89990c3 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -764,10 +764,12 @@ illegal_return:
      * mandated behaviour:
      * restore NZCV and DAIF from SPSR_ELx
      * set PSTATE.IL
+     * reset PSTATE.UINJ
      * restore PC from ELR_ELx
      * no change to exception level, execution state or stack pointer
      */
     env->pstate |= PSTATE_IL;
+    env->pstate &= ~PSTATE_UINJ;
     env->pc = new_pc;
     spsr &= PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT;
     spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT);
-- 
2.43.0


