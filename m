Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4962AE87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHzB-0004UL-32; Tue, 03 Feb 2026 10:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHz7-0004Mc-Ht
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHz5-0002J5-UJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:33 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso9522825e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131190; x=1770735990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2BwdxwgOylBEELY70JUf+5ITZYYVYk6FsH73loe8VHg=;
 b=y8WyhJ59RfE477CtrvRUST1ZbgPATxfRM4oB1AvJ3M4R843Ot0kkC8BjjWpAZp0ZuF
 fvkHJbmH1Ts4ulZ1JpyUfzX1AhPDjMuYCscYZv1K+yBtkFMcKWZt0pb6mSWP1dRzBK9L
 Pu+XlDel6OLYaiR+z0SG+7nqBROc+mDYGtGiQ6530l2oDmeyrEpwDImPQaNzATmxnr2y
 FiAfCMhoNEgb0NQEkpI1XsBr/h6oEJf3ffXTtJML2K1xytY8Wp99OCd2AqABIEwOEtkT
 msl2U+9TlUucQjgPS6dcB0BVkkp9gcG+EPyJQPasA376ql4fw6Xn1tGZa3XHY0aq2HmX
 HGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131190; x=1770735990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2BwdxwgOylBEELY70JUf+5ITZYYVYk6FsH73loe8VHg=;
 b=tsXgdIzVlGRP6yg0tuqWZ+sXRrvVnVTDfuyaTYBqC79fN+TKKyHfb/VN8OzepINliu
 Ln/JVWLjfZcgA8zkojO0HcVV4G1kJw42wjjgBXndTzo32xeeQLBs4cugwZlpWgQ6SW7b
 krTc8O2oQyh7/1pE2sApJL8WJ2+ZXYXzgZoMJKUE7sfxCwQ5ZxUMRGwUxikvinYsqhir
 BQZK/UGSD1wm/tmfIWPyq0wuGpYgma28FlM2VfmX4LNCJwImel4nIFysY/02sl8vHz8B
 B/GKsuacD7rW6YcpLGszWIit8pQtIAxKM9PJYz2lL6UtdtpExnE97DcY2Q4T9cHFc+Rl
 fJzg==
X-Gm-Message-State: AOJu0Yxsw5JDTetO1t7fGFcZplmLmQZkt0mObI+6p3DThfu54pgtI9/2
 WNjbYoBs6tyA5fcXyyFAMVJmuxMR7/NSWOwFOIrS8VJ4RUviEFb0N4BxGWDNfb28linmi/oNzic
 kt155AU8=
X-Gm-Gg: AZuq6aLzkoCTk4VQHp5qApv2HY1zfTY5WU09qKYW+Z+M2fA2KhS1MiQF49UEafZplXt
 4QbtxFgSkf+H8SpaN4K5H/NNSwAidUkzf0Ilo0nUbjWO4tylY8+z7ns7gc/L1M0yRFAlwl4edNz
 iajamZzMzQkRtU+4e4LLuCp7mXdUCthFAQKQoH8fX1LkdKhGcucMqYvGqdShPFNZL70VQDqjYy1
 g614jeO+tuOw4K1w3W2hlYOu0W3WYaP28spSb+kXffG4JTuQKzPbPHwW2EvGUnYWrLncQmDkOFZ
 QmnZXOklTZGPDFrJ/ECkyIEZXeWBB30H9ylhumvv4F3YRxjeZSRPvMpz1R/8J3bWHV1YqR3lQzN
 ORsKQWiyNiyXtevkQ9KQJsMpjRNRV9B6apAsLrMX4RF0BfExgWfGyDehM8CFKfA/Qh12uO/OuRP
 k73XaQDoicpRL0b3Za110u0f3LEcwCF7c+f6K2OA6V4DBJXzzBeA1VOulgrklj
X-Received: by 2002:a05:600c:3e18:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-48305144e7cmr45290105e9.11.1770131189987; 
 Tue, 03 Feb 2026 07:06:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cf16sm52972114f8f.22.2026.02.03.07.06.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/30] target/m68k: Inline translator_ld[uw,l,q]() calls
Date: Tue,  3 Feb 2026 16:04:21 +0100
Message-ID: <20260203150436.71907-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the m68k target, expanding MO_TE -> MO_BE since
this architecture is only available in big endianness.

Mechanical change using the following Coccinelle 'spatch' script:

    @@
    expression env, db, pc, do_swap;
    @@
    (
    - translator_lduw(env, db, pc)
    + translator_lduw_end(env, db, pc, MO_BE)
    |
    - translator_ldl(env, db, pc)
    + translator_ldl_end(env, db, pc, MO_BE)
    |
    - translator_ldq(env, db, pc)
    + translator_ldq_end(env, db, pc, MO_BE)
    )

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20260202214050.98935-1-philmd@linaro.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 721668634d9..a0309939012 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -347,7 +347,7 @@ static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
     uint16_t im;
-    im = translator_lduw(env, &s->base, s->pc);
+    im = translator_lduw_end(env, &s->base, s->pc, MO_BE);
     s->pc += 2;
     return im;
 }
@@ -1412,12 +1412,12 @@ static bool semihosting_test(DisasContext *s)
     if (s->pc % 4 != 0) {
         return false;
     }
-    test = translator_lduw(s->env, &s->base, s->pc - 4);
+    test = translator_lduw_end(s->env, &s->base, s->pc - 4, MO_BE);
     if (test != 0x4e71) {
         return false;
     }
     /* "... and followed by an invalid sentinel instruction movec %sp,0." */
-    test = translator_ldl(s->env, &s->base, s->pc);
+    test = translator_ldl_end(s->env, &s->base, s->pc, MO_BE);
     if (test != 0x4e7bf000) {
         return false;
     }
-- 
2.52.0


