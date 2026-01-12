Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB2ACF45D8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnG-0008MO-34; Mon, 12 Jan 2026 17:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQn3-0006Ee-Db
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQn1-0003ZU-UM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so3472532f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258414; x=1768863214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1e5TafeBzi0NtXIsIixemDxFwGFQ9t1xMrKt3qb1qpU=;
 b=ffeoRZcfgHj4jZHI6IhIsohSGZtYFOqQxo07k+kjotb5K1qZAiVli7kHV5VIKgwmDt
 9Mx8LWCHEaE69of2pqzMKiiFkXQSUQwvQq+SIOoLp18V/wk/ZQIy0wkKG3ejWPiIb2oM
 6Qcu4BVAqo0vVS/UNEeYzHa0IiHkNcHoJIBYgR/0qICIb9vHoXriKtMg4xa3rhWfVOvZ
 qsWMWM7ZAbqNe5dODHGOJEAnNDcc5KAWkILLqZWNoNdLzXfNGiouKLUpgGOCY3PQmXS8
 sG4yQMjfD4hIvSPIr7lyDenluS81f59U1LnUvRTGJIHfPczDevJQLhzgENXyhlejRIPJ
 kZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258414; x=1768863214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1e5TafeBzi0NtXIsIixemDxFwGFQ9t1xMrKt3qb1qpU=;
 b=UCA7JUqyt0FtMbQzZkkjR8B1XDoAgJ5+rFq3qmGehGsjk5INL191GC6uEJOhATpCeM
 4So0d4zZU66KNclqyBQIyTVaAxZeO3XSpbC0aNhH3olpV/yGw9QDyttcXoR2oaR1JqvK
 XEs4bbYQzQ9QcwX6bWTqBHMUfTEcAIcB4EGnxKH0OQ2mJqrvwUujCsSeRWpH7Gmnkc0S
 tKmTMgklPk9ASyVdKou7pgDN+w7g22tarpo9SrH7VM0VOZ0Bc7OliGLYC5vsQOz83vo0
 XUunJ5dTs6J/P75/EIYPD3fpOJBqZJatgdYvyuIq/A+1qfypG3DkOkzYPJWrDcsS4W6H
 pXmw==
X-Gm-Message-State: AOJu0Yz0QGXAWhTbzOEWP+OSXnvxTR/yprReiyM54U7/HnOlA1t6NZd0
 mu/luaoKmZGhdAWpSG7TIDtW18gsp+/N5QdYzcFyaOXfA1VStcdv3caNOXvgXnYc5f2nlVzC7AM
 KZCZwqtM=
X-Gm-Gg: AY/fxX4XAEhlWLT9/+aZkdkzzQY4KLMMdC+rYHGsvQVndMEWsOJ2ldrtzF4yHG+fI/n
 98U8tJv+k1v7JI8Tg15W7wve6stgs8Ep/wVHw7JMZWTxCdCKYaoJecDxmPlYkPcH9c34tq5az8K
 +QSxOodx86QhnVYBI4Zx00N3Ce8wVOiWj44JxRA44YOsOQhc1N+zQ55Uw3p8Pmz1IQWVO5Cdzxn
 5J2PGKQUUqPa4wYTUs+TrvCCT7C5a3meRkNw9CBtjhLmTwUg5jUvqYhNDSgEMJekcW0u0oMSMg5
 7sSuQZiBIik1zGHAf9oTibzq5VCx/LRkKPjm74MbKoEh64/P0oxtLDYXrQ6zbyzQm+Pi2T6zsyG
 FwdT6p6UCFXk1xF165UNGwWPKpivUTKRK+Ox46LlpwM9SI+N3p+13lHE1tn1XQdd0UceqgDKtN9
 rDV782VoLbXwnppLViuvsittIqx3qOni9PdKEhcvjPxS4ZdH4WdzFcZx51EAAD
X-Google-Smtp-Source: AGHT+IEBcRo6zLNKT+cVTICDrCi+gfFDPZnx0uRDXdgiSom52Op0CxA27yiBj+Ciadev68R1DOdSJw==
X-Received: by 2002:a05:6000:290c:b0:431:327:5dcc with SMTP id
 ffacd0b85a97d-432c379f291mr24573431f8f.43.1768258413820; 
 Mon, 12 Jan 2026 14:53:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16ffsm41907215f8f.12.2026.01.12.14.53.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/61] target/openrisc: Inline translator_ldl()
Date: Mon, 12 Jan 2026 23:48:35 +0100
Message-ID: <20260112224857.42068-41-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> mo_endian().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224161804.90064-4-philmd@linaro.org>
---
 target/openrisc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6fa4d6cfa70..ce2dc466dc7 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1558,7 +1558,8 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    uint32_t insn = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
+    uint32_t insn = translator_ldl_end(cpu_env(cs), &dc->base,
+                                       dc->base.pc_next, mo_endian(dc));
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-- 
2.52.0


