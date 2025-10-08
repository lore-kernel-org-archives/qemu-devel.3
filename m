Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132C7CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cE5-0001pE-6K; Wed, 08 Oct 2025 18:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCy-0000p7-F2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCQ-0007OI-84
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-781010ff051so223728b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960791; x=1760565591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtTcosX1PI6oFmrETJfm7j20wRw4ZF0RoKREZSs+mx8=;
 b=tFpazfECAC3WZwU/kkGyFlPTqEVh0kBhmWbhcTuKHNq9enavoTiHXsEA6MN5OddoFJ
 gSm+JgOC1UVVLLfJKUv38PJhwo2UaOZ0JUz0jWyBcWc0CeGr1MvnsrD1/EgX1w6dlcI+
 yFnvOZDGLXVW4m81lDiQtj2/y9UbtbXFaaM7sFYGcuHzHL0zUlcteJysWn6qRcsc0EUB
 W29lmR1G5rqtXHgOqmgATREg2N3dftXVnTF++IMn7DqqakqyEvOQ7lvojo6aOXnGKmNI
 6DiJquYPHG2BmXOakv2avgfZYOPRtfKTJwiLdbk9NJpNCWgLcFnNXt6EDjJ/0PQJlNQt
 jl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960791; x=1760565591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtTcosX1PI6oFmrETJfm7j20wRw4ZF0RoKREZSs+mx8=;
 b=hJP3FwJe3hmpBYoNIirB4HnXxs2bNOYy9yWerfziR1aPkyGzNb0sh1D1XVkwv/6iuA
 hfH+2sSIOF4DbJ4gvgW6BcrmjCPkLtY/MVwORMD7UqHzfJrDAnvE/68pQwgz2hsDvhG7
 XUAX7GaehyhN/5C3FDAmroI7QNuv2rGPWZFHPXsE7i3qPeS7LWvyT9teH6PFkzSB36WU
 l51bz3SoE4tRK1p/WHL2PoMfwQG/O61vgll0Nk4oiZwOjFzepcwTwJNSAlkw/KlUDuP+
 iyingUI1q7RR3V81ukVlSiXvLbxrytqnRhvi8Qz0KUzna9IsWypVD232vlcg+sK2OUzv
 IK3Q==
X-Gm-Message-State: AOJu0Yyj/qd9i5u6id85ZmDNJfYh+4A5Ioxl8/J/oafrsi3aVBKAUpHG
 Mjd+d9MHbzuasNWipXnJf9Fhvp4PLUY0bBopE6Va6HqMM7f0mbo0vvKteBb2D9cTdHv+8k06jkB
 Sy3VH3ZM=
X-Gm-Gg: ASbGnctIBF/DbmJE4zJWsOFcYZUWhB//gQxBI6rXv+AVV4VNCI4W7li1vmVEVYhEScb
 NRj69JVubElOz4fYY68FtPIQTEMXr1fRsQttMvOLHaIwM8V3Tqiq5jk47vPaH8TvPg0SitbzLE5
 nbnhx3vrXFg2FaaQphKcKgOBcrBzrXGtzh2iXVyYWE9A1fj6m3GNKvP0IDdTXr4+sJSdIquy6Gu
 99m01tPHKTrCtzaL6GkvITw8n/lVzDtOnSSsmLPdMvxqNx72BmaQZXz8LNT4Z7mT5M2nyKHgAfF
 ilVS2PiB4qQdo43/npc39BsaWjrmOnq8y0mPH+XS+sU+sL549R47RzQx+Q/82ORnr6zuICAR1Gv
 /lbNKzQyiy51Fzs+STnEuucb2jdlbW2Fm5LemN7eEoLENCyDbYXXbPxIf
X-Google-Smtp-Source: AGHT+IEI4zw2x5A3P/GyHqWIBLtD6hN8Kl0LWetIEPTE0Yk9AndjnbS+VKUqsZvXaRGr7MLdpdIQ5g==
X-Received: by 2002:a05:6a00:9a4:b0:77f:efd:829b with SMTP id
 d2e1a72fcca58-7938783414emr5393857b3a.22.1759960790627; 
 Wed, 08 Oct 2025 14:59:50 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 55/73] target/arm: Add gcs record for BL
Date: Wed,  8 Oct 2025 14:55:55 -0700
Message-ID: <20251008215613.300150-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d58257be40..9a564339fa 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1678,7 +1678,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


