Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF385D1268B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbO-0004YZ-8f; Tue, 05 Nov 2024 06:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbM-0004X8-20
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:00 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbB-00076l-Q4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:59 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb58980711so49179021fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805586; x=1731410386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TfXkDdm7UXvN9SQ0HEv89qVQFRKDh0IE2sOcAT0PJD8=;
 b=N1qMw7DMsWOiwKMY031CGaepl7EUNCYPb3HvBM0vQWisgzJR8EIGIXyUjrHWiwXcAn
 bGIgolw2uyxgpT3afSzmRi5PYSTD3qfDFsxvXSoly+t/9wA0SNFf3Hp44RNmhBYQk/3N
 ybmIyhEfarKY1JuhKJLUSB6jqbtn9i8swbFp5CoUwzxFhCkkuurHv31qENr+tK+XBxnB
 omVu2rlB3XL44H7i9CPlCqI7E/IBpBbExCSaqyvz9sQT0P0Tof2tbRUcmnNDg+JtFW7P
 VopLUwYYnhy2H2qGsPaE7aLf5iPDQbdr43UxMWKKKbl8V96410k0/BTcSo/aXGT9RrIM
 4Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805586; x=1731410386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfXkDdm7UXvN9SQ0HEv89qVQFRKDh0IE2sOcAT0PJD8=;
 b=FV3IDV8A9UcLBWUIzXrOXTTIKnH/iwxR5Ia6+szrnYJORJc+FUeitfH5RKRDhoRMxr
 hF2eUwGWWK1ekk+r+8PR6RR/giuTxuKug9aYSjaxiicb65rgxN2+H+SkEI28H3EnuxJn
 aypyYjNpB0rwekY/FOTjxm8u7+1IyKBq0Sy4fNnU7mYX2JEuJLeIcquOr++rD8Eg/Gyo
 qs7Ig56v8PLFsIlUQtghDSDQsE92ei9BHXpOGvfGdyV9qI2l2AyiM/8Yb/2fE3uDEFoS
 h1i120iK28W3YjI38V81MHHIeWRW4h6z1QQTU5zx4yq8r+TV/ly9h/diTRv7A/Uwrlek
 WZsg==
X-Gm-Message-State: AOJu0YxYtPIwRpCJa4Yztcqc12uMghKD6Vkiyi9DkXHnXHRDakvK1kPn
 51WutooIzMSUwCvXcQtK1P7DTl6WALa++nUimPC8wUGVPZVIV8oqSai60ezaE2nUY4OjqblDlQ1
 m
X-Google-Smtp-Source: AGHT+IGnIgx/0VLex4zqBzzPZi1TK5YIj7omJ03TBImVnyLLf8DI8TOk/sRYvCU96Drx4kXhcpcgjA==
X-Received: by 2002:a2e:b895:0:b0:2fa:de52:f03c with SMTP id
 38308e7fff4ca-2fcbdf5b818mr161391041fa.5.1730805586475; 
 Tue, 05 Nov 2024 03:19:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/31] target/alpha: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:20 +0000
Message-Id: <20241105111935.2747034-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Set the NaN propagation rule explicitly for the float_status word
used in this target.

This is a no-behaviour-change commit, so we retain the existing
behaviour of x87-style pick-largest-significand NaN propagation.
This is however not the architecturally correct handling, so we leave
a TODO note to that effect.

We also leave a TODO note pointing out that all this code in the cpu
initfn (including the existing setting up of env->flags and the FPCR)
should be in a currently non-existent CPU reset function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-17-peter.maydell@linaro.org
---
 target/alpha/cpu.c             | 11 +++++++++++
 fpu/softfloat-specialize.c.inc |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 9db1dffc03e..5d75c941f7a 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -24,6 +24,7 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat.h"
 
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
@@ -187,7 +188,17 @@ static void alpha_cpu_initfn(Object *obj)
 {
     CPUAlphaState *env = cpu_env(CPU(obj));
 
+    /* TODO all this should be done in reset, not init */
+
     env->lock_addr = -1;
+
+    /*
+     * TODO: this is incorrect. The Alpha Architecture Handbook version 4
+     * describes NaN propagation in section 4.7.10.4. We should prefer
+     * the operand in Fb (whether it is a QNaN or an SNaN), then the
+     * operand in Fa. That is float_2nan_prop_ba.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
     cpu_alpha_store_fpcr(env, (uint64_t)(FPCR_INVD | FPCR_DZED | FPCR_OVFD
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 77ebc8216f6..a5c3e2b8de5 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -406,7 +406,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
-    || defined(TARGET_I386)
+    || defined(TARGET_I386) || defined(TARGET_ALPHA)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


