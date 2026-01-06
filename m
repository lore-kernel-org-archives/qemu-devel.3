Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D594CE9D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9SE-0003VW-5z; Tue, 06 Jan 2026 10:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9S8-0003QE-GF
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9S6-0006je-Tr
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so6815695e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715113; x=1768319913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsmbcceSWYg0oBTVRUldiOXkUQKy7EHtgbIvYk6Ti2M=;
 b=O++RiiguiuxnIoyQ+s6KoL0J7a6TeDj5HDH/14SVfHsIXWZXq5ETvuYgR/wXcp11Ha
 TcJefDc45abXJr14moAgzM1DTpQy5arfs08kWNS2piEzNVZKvs0TDiKpUWd02s96fPl3
 gDp1Z8Rq+ctKgW7YgREXKfqAgOkr9nUZ4+aPTsoodKX7QArbelzmwTM6zGq7rGggNwCy
 HSWSgTV//X3Gc9uCjtmiehB2lxaRIqxcvvGBjJ7KFBtt8TG70B2htKaACzziafOZ1Brw
 Pio9wPsquSVnzbpgfvcXw7hoq9hL9v1684KcMSORbDgznXN1ibnU8DC8tLt/dXjTk6KZ
 EE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715113; x=1768319913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JsmbcceSWYg0oBTVRUldiOXkUQKy7EHtgbIvYk6Ti2M=;
 b=MuGJc56MSW8IRNRU64wQwjV9p6Mnm8HyzT6txIGyqQvDhpoqJ6b9D5bfEZNwTFIPzu
 pTUX1mlh7kztGhmJDXFr2O4KoONQ86PzS5Xl/9zWzCHaoUvZWryygoYVO0HM7wqZ1MkV
 kAGyczMYLJUi2YEuhfZ67wIMT2aHq5hBQUOFM8KAR9rTqrlRcfwC4S9Zqyn0KGuMcQNN
 Z4MaBVVD1K2Iiak/QBjaytsxcc/5U3ui9VekvJ2W+8okDr80BtkwTpkUmPDpWtMWlTwm
 tsAMgFHVkQzBlylrCWWsz1pF4ixVDGhrC6jIAmAZmWk4bkxfdf3+g7fBANVCOUhdAO8Y
 ifXA==
X-Gm-Message-State: AOJu0Yx583pSDJbHV9VvtGq6MO+llNOGTlft6hLaXrYUbzwFS9OBrQBT
 yunYy/Ngv7gmuKOeFUIvDAOhL5ZI5JPoR5Q6r0VNeIz/A6wWIvY9GyGkYvF1x1jU4NkffjCrIvf
 HhNigow8=
X-Gm-Gg: AY/fxX7GzxRSMeNsVad7O+AQemjf/JGuR7RPdf8mlF31lw3lrnLz9TPRTREAxG8aTfC
 NRIJ8XRrex/8WAGbAsUrTlfAezaKqvkbMQs20EQsZCDCvkERMoDyOsZfeHlbhck1IMCbgeJBtT2
 oQMNaif53Ix/HqxOcBSN062vbnE26ksEsbonwr11QJyHFxAwOuF3hYW3RUZR+UfX67B1F/NlVtt
 YuwXhFC5oudPpcjxXbNWqdqclm1ZwjzoZng9TaPakHEiWwFD9jFouYQ0Gll7J6hQG+i/1HnF4YG
 ijcI4rB5ezVmVrieGtfUpN3SlOQgHKMEeWZZgMnjGhLAhhPsefIq0xF+30RQrSvKbyfwwY+HaEq
 rZj9jYHils852GPNyVqpj0evsEEOxDsZu3e7HGErBOVjWyn4mcchBvSqqaK4zcXliXQKQ4ckZ4n
 4po0YkBKKwWhyVGB4Hvb/QokETxaCf7zP9brSHdbMceADChyV4Yfikc3dpnk03
X-Google-Smtp-Source: AGHT+IGle4zSoPygz2LgdyL21jWjRKLTSUx0e85DDeOFVWepi3Y+otym2t3Hp5FCsAS3TeEaE/S9iA==
X-Received: by 2002:a05:600c:b8a:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47d7f06ff42mr42952915e9.15.1767715113034; 
 Tue, 06 Jan 2026 07:58:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7faf05a8sm20133295e9.7.2026.01.06.07.58.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/8] target/alpha: Factor mo_endian() helper out
Date: Tue,  6 Jan 2026 16:57:51 +0100
Message-ID: <20260106155755.53646-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 3be97057465..4f918cbfe63 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -96,6 +96,11 @@ static TCGv cpu_lock_value;
 static TCGv cpu_pal_ir[31];
 #endif
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 void alpha_translate_init(void)
 {
 #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUAlphaState, V) }
@@ -2905,7 +2910,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
-                                       ctx->base.pc_next, MO_TE);
+                                       ctx->base.pc_next, mo_endian(ctx));
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.52.0


