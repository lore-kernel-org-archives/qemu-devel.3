Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BF8D0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4D-0004RX-LA; Fri, 25 Oct 2024 10:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L44-0004GI-6r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3u-0007sl-U0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43169902057so20481835e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865589; x=1730470389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cCo50wdC0NIgQKfnDkwtGpzRTYsS1ol+AjTcdAhO0A=;
 b=SS6Q9Fp/HdnY+6ajn/QNUZwh7QwfvagZsrs28rDOk4zxQqLmZZXnEh8bQMw2OSKWZD
 wznleDwLjNuJKOghzwreMj9ZEW3IEWW3GLUrYu9hrKg5Ng1q8fy73G7WJhBXVfKIarjH
 GaYanxj2fvkCqJalQaskgtleKvRApWzsPKgr+/AATfIG/Axkt7QeFtGvAX1L2ZtFyspG
 1DRYPy6mpTc29jwu+aRJSqIzKy1Zuv4Ks66lHPK7A9EPmSHluL3O7iDfMAGxetrwP8t/
 oK3m83oRu5rwdo4Ex79/otPqyFnj4rJJY1NbToTzYl0nc9qZ1Kw9yaba2SYTv26AKxsE
 63FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865589; x=1730470389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cCo50wdC0NIgQKfnDkwtGpzRTYsS1ol+AjTcdAhO0A=;
 b=O9y8JK/LpFkFKoXLGZfmDAblWe2eXXJfY2h7DQMzpgzk1AmrzUAuDg0sXOWQh7hQvo
 jYSaJ5s50KcCUkgCF+CAL1C+H+tXsyFUIQecql6lcHnquI0b6RM8txGl1dbArkjTYBNA
 nkkY2CBMRonX5i0IXJ6WjeF02ajvgPrw48nV0+McIav1L+hirspa4WPg4+FdJKQ4VXG2
 EJu+c9Va8lndFsUnVpNznCcekIMA/0N8CQBd2rSTJdn2T4a4F/rC5pvBsQFhw01xQ3Di
 RsK29TftrMaupbIkdoUvBpTfYux3pHFmBZm8WpGwefMzYOB8xL/cY3iPPhgStWX3zGPa
 QaTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7+ozOQDmODyr/8hPcMGpIoM7wNQeqB7Eao0kKtw4mAHdi2uMvfHz7SkBHmdK00H/9Rsm/JKwVam+/@nongnu.org
X-Gm-Message-State: AOJu0YyeywU58tkBbWJeGI3gl/Iz+3XVWY2TiQYtJpzbPvmZoGpb4Tq6
 BeSs5YWTGSLzRvZgpx+fKmG5RQiSo0LPsi34YNcTYZ5hy8BhsmD9b7/7CwPWAy0=
X-Google-Smtp-Source: AGHT+IErRofvNVko14JtpQxdLcThoMuGjBJqi3FTPlWg0ZwyTazi/nWN12GMkiVoSHlJvSwtaTXZqA==
X-Received: by 2002:a05:600c:1d27:b0:431:58cd:b260 with SMTP id
 5b1f17b1804b1-4318418a568mr84761005e9.25.1729865589416; 
 Fri, 25 Oct 2024 07:13:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:09 -0700 (PDT)
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
Subject: [PATCH 15/21] target/i386: Set 2-NaN propagation rule explicitly
Date: Fri, 25 Oct 2024 15:12:48 +0100
Message-Id: <20241025141254.2141506-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
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

Set the NaN propagation rule explicitly for the float_status words
used in the x86 target.

This is a no-behaviour-change commit, so we retain the existing
behaviour of using the x87-style "prefer QNaN over SNaN, then prefer
the NaN with the larger significand" for MMX and SSE.  This is
however not the documented hardware behaviour, so we leave a TODO
note about what we should be doing instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/cpu.h              |  3 +++
 target/i386/cpu.c              |  4 ++++
 target/i386/tcg/fpu_helper.c   | 40 ++++++++++++++++++++++++++++++++++
 fpu/softfloat-specialize.c.inc |  3 ++-
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 74886d1580f..43ba62e92d3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2562,6 +2562,9 @@ static inline bool cpu_vmx_maybe_enabled(CPUX86State *env)
 int get_pg_mode(CPUX86State *env);
 
 /* fpu_helper.c */
+
+/* Set all non-runtime-variable float_status fields to x86 handling */
+void cpu_init_fp_statuses(CPUX86State *env);
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
 void update_mxcsr_from_sse_status(CPUX86State *env);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ff1af032ea..e9260fbc654 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7083,6 +7083,10 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
 
     memset(env, 0, offsetof(CPUX86State, end_reset_fields));
 
+    if (tcg_enabled()) {
+        cpu_init_fp_statuses(env);
+    }
+
     env->old_exception = -1;
 
     /* init to reset state */
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e1b850f3fc2..53b49bb2977 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -135,6 +135,46 @@ static void fpu_set_exception(CPUX86State *env, int mask)
     }
 }
 
+void cpu_init_fp_statuses(CPUX86State *env)
+{
+    /*
+     * Initialise the non-runtime-varying fields of the various
+     * float_status words to x86 behaviour. This must be called at
+     * CPU reset because the float_status words are in the
+     * "zeroed on reset" portion of the CPU state struct.
+     * Fields in float_status that vary under guest control are set
+     * via the codepath for setting that register, eg cpu_set_fpuc().
+     */
+    /*
+     * Use x87 NaN propagation rules:
+     * SNaN + QNaN => return the QNaN
+     * two SNaNs => return the one with the larger significand, silenced
+     * two QNaNs => return the one with the larger significand
+     * SNaN and a non-NaN => return the SNaN, silenced
+     * QNaN and a non-NaN => return the QNaN
+     *
+     * If we get down to comparing significands and they are the same,
+     * return the NaN with the positive sign bit (if any).
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /*
+     * TODO: These are incorrect: the x86 Software Developer's Manual vol 1
+     * section 4.8.3.5 "Operating on SNaNs and QNaNs" says that the
+     * "larger significand" behaviour is only used for x87 FPU operations.
+     * For SSE the required behaviour is to always return the first NaN,
+     * which is float_2nan_prop_ab.
+     *
+     * mmx_status is used only for the AMD 3DNow! instructions, which
+     * are documented in the "3DNow! Technology Manual" as not supporting
+     * NaNs or infinities as inputs. The result of passing two NaNs is
+     * documented as "undefined", so we can do what we choose.
+     * (Strictly there is some behaviour we don't implement correctly
+     * for these "unsupported" NaN and Inf values, like "NaN * 0 == 0".)
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->mmx_status);
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->sse_status);
+}
+
 static inline uint8_t save_exception_flags(CPUX86State *env)
 {
     uint8_t old_flags = get_float_exception_flags(&env->fp_status);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b050c5eb04a..77ebc8216f6 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -405,7 +405,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
-    || defined(TARGET_SPARC) || defined(TARGET_XTENSA)
+    || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
+    || defined(TARGET_I386)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


