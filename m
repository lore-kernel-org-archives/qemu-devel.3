Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05EFCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQl6-00022D-Qu; Mon, 12 Jan 2026 17:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQl3-0001tA-Az
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQl1-00035M-Pt
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso74394555e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258290; x=1768863090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hk8Hsu8dDtZ9+iiMFl2scnFZQ4c0NzaTsiiMypK8s10=;
 b=j73oNTA3GhQSY9BJBQhwtbN8QRC0bHYDmQCiJq3i56Rt9aOST4vAfJ86vG5HOfK1cH
 iTmTozl0GwqQoHQcxi+MZUgUBXaEIpK2+mzvQhnWiS38xTtXoPuurSxhGhKsSfmADsD/
 8mTJXsvCuoKNrzzke/4aN+HxGgLEJpf9zpeoVryKobJaCJ1zKi54XqqBSIPo/ikYozS4
 6qRqAt/XsyL0XWhKvApy5/mLoDQwqJbe7lCPkLF8hoIFcxVq/dCGFZaUiFTM0Plsw4pz
 12wWKBmV2yLKOuVb2XMkUXq/vgxURVIsRpJlNKeuS1hddsLnFAkuFoLsyNICv7lscvwF
 i5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258290; x=1768863090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hk8Hsu8dDtZ9+iiMFl2scnFZQ4c0NzaTsiiMypK8s10=;
 b=N/y3g2tdm1ay2lgOUkBtj4D7gbCaB/Z7YWjUMTGBGHIAgWjGgx+CYFFffME5697HZG
 6IQWso7ATdkUuuI2RVkaVxoJXmj67TKMaX9NbRRDC1yjyYWrk5IWfQBJhJMfeOwRvVh5
 qYlvzw7LrNv1JjCH/Y9nJXN8SoN6W49c7yfY4RZvaJ7kRJm71VNdFis5mUSG9hOOwrn2
 9xm071Afw1++bn5MWCuG/Fc288mYYi7FZxfSyE/Be5nD/PbytBs9UQAGQaFjkHglKjKV
 ec696n1gwqia4tkyWOwngmbB0/BTA//fU0wpxtSJJ11RagkSMtH7y/SEGMOP0inEzXLq
 XCGQ==
X-Gm-Message-State: AOJu0YxL1bEMQtqQMHhLidgUqGG8HGg9u82l4HQpkwhksm+uo2Z/Yo3b
 A6WM0FW/aYT5UQNIKn/Bwscmhqg7gZMzT/48NxSEiSVYeCgEyhYujv7z7E6sLc8bqaKsHnt3TzH
 oUz9ewOc=
X-Gm-Gg: AY/fxX7VXr3SaI2AgJuA3DQfXCHTaszwE/PwnpZ981YoUuaRfy2u3vNHKC8dOgTXB9X
 fyYfS5pNke/M3XSKh0zkhJ+8UpIYdk7oJfVMJ+kTUwZBGgB67P26hjwozcobiuSncWEsS6KG9Ae
 LWqVI2ESbQkKN7nu3MrbozR4v0RTvS+twwWCTpvKUh4LLLcSsQqYX4zvtCHDk3fEZ8IzoYeHvM7
 URPEMl5JmPEB6XbLZCMLNcbLwwnH7NqQF6DahOmEqXssvGTGnPlCyMW1Xn3XHiHyCrTTmf++eBM
 5tAuLKmwUZuxAqNb9NFPu3AiHJk/6amCGgO9m8A7dX/Tgw7IvJVaROZSseSWYkqOqZP+X5O+g/n
 6ai1v4v1qaPwdLC/B7ajGtiWcLgc9wVS04ElYRp8v1MB4yhj6O0NCJvw+3RcEm/wFif3CGzf/7w
 x5pz/fXWJQl0IKTSSHGJtC3IZ4tKkSUOKW2ScrMNJNDpKSsDeS2RGrXrvme9IkJBY5xHLu5Ds=
X-Google-Smtp-Source: AGHT+IG1LJmgZNec1KHK4Q+/PudkyWiwU8u/gg4NjyVHrUWzo7jGuFQiJSTMvlqV+0BLrCxj6YAEUg==
X-Received: by 2002:a05:600c:3114:b0:47d:403e:90c9 with SMTP id
 5b1f17b1804b1-47d84b18663mr211824935e9.11.1768258290057; 
 Mon, 12 Jan 2026 14:51:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda47146csm953615e9.17.2026.01.12.14.51.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/61] target/hppa: Inline translator_ldl()
Date: Mon, 12 Jan 2026 23:48:17 +0100
Message-ID: <20260112224857.42068-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Message-ID: <20251229225517.45078-5-philmd@linaro.org>
---
 target/hppa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 853cba2ba4f..0b7074649b7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4737,7 +4737,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        uint32_t insn = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
+                                           mo_endian(ctx));
 
         /*
          * Set up the IA queue for the next insn.
-- 
2.52.0


