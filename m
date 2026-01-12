Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1C5CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkC-0004h2-Kg; Mon, 12 Jan 2026 17:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQk9-0004Rs-CJ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQk7-0002uA-WC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso49368025e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258234; x=1768863034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nKnmAuhg2j5g1FJP9++SXoe3W19bdqyFpA0yNrVoyGQ=;
 b=lHjZXxzwQsxoTimwjS93R2R9jHsKR3BI9gg9SKOjVxnYl02UzGuLX/9AHR4Q3E34f8
 fiQtmYVyndz8MezTx0SJenLXiExxbQBmYibz2Yv+mFtJLUkL4WolOFIWWZLo90r4imrm
 jZQE/XWULcGAtEHbDbWCacQfhKqgZ/gV2m7FZE2x8nsykzvvfWHLGxwhlpaO+3Jemqa3
 Laj2nGVcl8mvfsXpQNRXO9PRWEpfGqGW2kXycXxxr6DlALfsJ6ng/a+xio4EZzE7pTRn
 quwP4My6sCUNqqVFKUmVtCJbnfQMgsADJ4f0qmjGBuiLJgxvs52JsF78efS4jVifbN85
 +JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258234; x=1768863034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nKnmAuhg2j5g1FJP9++SXoe3W19bdqyFpA0yNrVoyGQ=;
 b=NBxx4/KMAVCoDxgRibUWoXdqFlvdlb+bV8MIy1J0tVrzUGmBLOxYzOi7eeNmYEvz57
 dxSN1+mXRq+tUDNWTXeWnC7jx6hQvazJFNHFst1Gzsfi2RLP4SKQYX6FJ5WNk8pP8luj
 pGWooztgakLaJ6UeJXTFECF012bdp4v7bZwBgUEsEScZM05IRCWV/wUU0kdfTPBG69Vz
 FwM02/eqdO5GgVcWSB7D069SVGRjaAegeLHRkuLlMSboo3//Vh1nOebAUStHuQ0jogkV
 Fb+jxbzASDA8joVhvqBSSQHqJmZN73i11YGs8J+BwZkJqvNMYwuizvvPCGyRHvuM2wLG
 NQfg==
X-Gm-Message-State: AOJu0Yyz+QfpXYLzMENljwMyv4KwNpO/MVfdEMV8ps/gASFPx1Dow9Zk
 hWFl49JfYCucJ2MCj3bdR4zDyOOOG7hY3HLtT1ZSTV4pEcNIy2EpD0V8UHwJ3h41Am49uummp75
 YkMlOxas=
X-Gm-Gg: AY/fxX7YMVeHLfxElTYYfVMwLtOT2TxejzyFxJrTwmW1qAz2Q3wtCPmDaYAVXnbeq3v
 n6a02u+soBK5B4yZbk0F7q9PUm7kbzC72GVTDKVfGQ1kCZg2XIK51YI9Hnwebw5ZeMr1HCPdPKe
 HwmBnN1Dpzp62Ts+K3pBHM8VrQ4/5DbqQtuG+0PPkyfpM5AMldhvn56LI2kIq/QIL8ZXRpJO9W+
 3514xYrdHoNSZf2rvivFC54i5Cpy6FPA89Vxqyh9i184h9/aMOkUJ803BuoHHd01V/KbKRrep+h
 Jrz+dtYbqU7l8fGP5+D65q+QsVwH6IySF5fTAjcIGl9QEQY/T05jkv+0SG44IwbRDsSSLd0PqmJ
 tsGSbqKddjtNEFQdd64lZM6rxkCwQtvj9oEc4htjlXj4+zxK4t2c5dxeMOub1e4mXqooO3oLWdl
 P7SIGgyE5Y/VyHEc+KUkhwJQ7T0JEf7qTHsuBa1Fg5CXJ4L34BJXYGFOWUUUnE
X-Google-Smtp-Source: AGHT+IEqNJwJoi2JeKtGTo9lvMtcw8mdnoLhKiK66N8gRAYIQQWNMD5cHrARfC/P2pO2dbhsfqhuew==
X-Received: by 2002:a05:600c:4e8a:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d84b18037mr258125295e9.9.1768258234202; 
 Mon, 12 Jan 2026 14:50:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ed9b2a92bsm2208955e9.0.2026.01.12.14.50.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/61] target/alpha: Inline translator_ldl()
Date: Mon, 12 Jan 2026 23:48:09 +0100
Message-ID: <20260112224857.42068-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Directly use the inlined form.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260106155755.53646-5-philmd@linaro.org>
---
 target/alpha/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index b1d8a4eb80a..3be97057465 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2904,8 +2904,8 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    uint32_t insn = translator_ldl(cpu_env(cpu), &ctx->base,
-                                   ctx->base.pc_next);
+    uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
+                                       ctx->base.pc_next, MO_TE);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.52.0


