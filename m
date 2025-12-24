Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BE9E776C1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRRH-0007NN-UQ; Wed, 24 Dec 2025 11:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRRG-0007Ld-Ks
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:10:14 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRRF-0000g4-4w
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:10:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fb3801f7eso3274403f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592611; x=1767197411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmdkoSJbtTFlszwMj0i/ecIV7kbRsCjj7PD3+CpS8Sw=;
 b=fFXjnIOuHg6OMbNtoZ9/F/bJ6mPR/8negg6tspliVlfKmswziLnb+zxr8lyq+rU+d0
 9OY2YTuRrgYCQR8ERGyMxRiejc8iiNLCVvIeyrNHseTZlY+8kvj/CFDNZFz6oUECAUGm
 GJwz6KKPUKsof0t3sRbAsxJSHJurW/6fiYmcFgChyTqVARMoGOUIjtUqHAn4nGhC8Hat
 PpluENPWYFpzD99X11R/3Fl7fqxF9sLJCzesv/KRSIDjAb8608K3oqpqwakeTJxbzQ7Z
 BfflwLu+F2S+0QSd3Rnwgd9qY9qAAiWV0gr7m/kNljp6ZmqwYjMoIzXsowzsb6f1elDp
 ViUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592611; x=1767197411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lmdkoSJbtTFlszwMj0i/ecIV7kbRsCjj7PD3+CpS8Sw=;
 b=SFdSrL3pr0FcF8e0QuYL8wQj/cUKXCLQTFd+BcJKrZ7qZ8+S9q9sC7Ibi6/x/9GfXl
 w4vAkbYJVFMqdztAqB4RNJdFL6D5D8rYULz/nvqidRIByH59Q4z+QZg4Do3NYZM/dDUg
 0kKTCo43W3o8ZhOBlw7OYTxVQUZ6rpKe63bO/8PCJ2mg9wY6q9Od5Uiv6Xy1QWhqhYx/
 dT8WIgKNc73NI/I4mofnob5m7pGJD8wJ1ds27AVvQjL2T5qgUeqqFFG3/ioBEtnULIKd
 LInUCEXA/Onq+Yo77ITRalRU0Nug0Sezdmx6YSUoCN0RZEa42psz7Wexpe30tgq7u7fH
 Ks4Q==
X-Gm-Message-State: AOJu0Yxhrah0T/hQoq2Duxawr9Twod930NiDQCbl7CH6IEe2XtE33teI
 QWHNXRlTqHqKHfD1lCoBMFhCfSmAkA7K2uDyT79mydVWyl7DMpkeguGhPDujUVfa/o04kRJMHH5
 aHilELsw=
X-Gm-Gg: AY/fxX6KmNcMxzOpCqoTx09+DbzALM/K040dWqrkeOS+WXn7+wnfUbwkcRX/Dw84hou
 SzZc/8K6WHCNx0/NoedccJhmGbrgLcMEkCJBnNQPG1P9Tf2CQbYUce9FeAyl1MOmx3THHKy/6YP
 HMVQpHSi+VOnRkIqjgDcHc6qY+KG1Q8zhNBTM1XrWV+hA5H8YoufLCr/RA+NfCYr7wcleibziQE
 EjJhLAQJl67BHxHq9V/bUmOxrE5L733xlvmnpM7GLh2n15zsZQjlV1nvbvlbiI6AsiK1/k2CSMq
 AqvVd5bW+UFRWPd67WmpjW61Zq/Z30/b3XOCIpCNr4wi/dmh39ODN03wnEenl2MppGDVrHUxbF+
 tBzumQ7lNBW5Z7K1KZvztR1EURaoysfOWMlFaa61181uYewIQJRS0phMtR8jzQb7RwYJQnQw71x
 5aJ3Tdt3hfgFX9JpnxGSbsCId0zvpiRWRi9ZUCz0nhMmfNfVT8jyPhw+Q=
X-Google-Smtp-Source: AGHT+IHl4Sog64Hi8wNuCeSyyiiTlk2b7PP9MoO1ZdHqYPCSl1AysP3bvTAZqPLp5RItXKBMkxSUSA==
X-Received: by 2002:a05:6000:420a:b0:430:f62e:d948 with SMTP id
 ffacd0b85a97d-4324e4bf8e0mr18794460f8f.9.1766592611428; 
 Wed, 24 Dec 2025 08:10:11 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm36271634f8f.10.2025.12.24.08.10.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:10:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/hppa: Inline translator_ldl()
Date: Wed, 24 Dec 2025 17:09:41 +0100
Message-ID: <20251224160942.89386-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160942.89386-1-philmd@linaro.org>
References: <20251224160942.89386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since PA-RISC use big-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 853cba2ba4f..73c2cbdf5fc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4737,7 +4737,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        uint32_t insn = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
+                                           MO_BE);
 
         /*
          * Set up the IA queue for the next insn.
-- 
2.52.0


