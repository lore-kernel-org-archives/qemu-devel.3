Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0D8E776EA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRo2-00063r-LV; Wed, 24 Dec 2025 11:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRnz-0005uD-5Z
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:44 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRnx-0005Ey-JV
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:42 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7cee045187so1082913366b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766594020; x=1767198820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt+Fg023OLYF+/KqTx4JdKGYP6O1+WjADomLnTSZdzY=;
 b=f4DevuiOON/pjQ3jg3VpF48Ymd4QM7UCpF3I6y6HR19zX0DHraSDcIai/XbjYax+tf
 ueBY/J2xhmWu1Oy/vpZbeW2vIYehxkXWAsTPTdF08voy3LIY/iW2oNESO6pXxfE/ixwW
 GOuZGqFpcvEO2cLuoM08R6s4HStyxgXwwckZiUrWuJoszmZOZmLK1h4PStcLMV9RqU/O
 wN+cJ9QFXLqtLDb7YreRWlO2PY860XpY/KfCQljBFbj4Shbl59nCu693WhzFQyL5ymBP
 WYeZJIXmRT/ho+KKUCD3lsgAq6BrmmgKY4wHDgFY8/8DMn1NgmmasYI98WXUahRRpC9H
 6lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766594020; x=1767198820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt+Fg023OLYF+/KqTx4JdKGYP6O1+WjADomLnTSZdzY=;
 b=Shscb+15s05d+woeruXvsrFYPSm6R5rRuGZWxgJP/ljPaxGVspn5WYJMaIp8LtAitF
 Uc+1SUSzw5RpfswDI1uN/Oo2LwMK0fIL+AZGk6eFwnMKIWsf3uk0dX8/XmH14aXxm+0A
 D/Nmg/w0gLJfdHP3O4P6zSGiomMsaIh1TWmDJoBK6zC5j3TKKiWRL2c5QpPRLSKoU43K
 CnRrmarvCYsgWutyIv0jkE5n6k3NduvQhCOXnG3dgeZDYYf7dmJ2lPrbngCc7D1quedg
 zkcqp6CV/BnraUo66EXROzOnAesDapxv28TjO9nAJXRjFkhi+GqOHVpo/UyWe0B5QXez
 Tc4A==
X-Gm-Message-State: AOJu0YxaPjsigoSkfJOsla0N+vmYV9IZ5CFRESyc2OTNZ9i7JSK9R7+V
 y6oqJhHX3y5B8HKFC01a3MhuzRyJ+fxLwSH9gxPi73HdtZpwSBVb7HMUyYeSrG8rQ/irLcywh/x
 3eP2AXds=
X-Gm-Gg: AY/fxX65sFy+lZrwzGEYF3b0+9zUu7fGysGXHt+uYaifg1xxtg8uZ5M7y1Ugh7l+21m
 gfSYscCYfdydFS16rALaBTaFfnsFCgivSfPgbAPhMj9J1vgxOyf7sZ4HzMrVXo0dT5r+Ca6sUKG
 AUVYrSeh9H2nn2h6TnauCvxd+EdcPBWOBy6iLOlTAQlkKQUvlTgIboRNjVn2fKOLUandq1Now+k
 Gka9zCTav6gwd2ot1kS4cDUBuhP/4Nid2r/BxMLPahQaWewUyEhpVlK9K9HSeS9HpuH4myjZh3y
 2K/5yzw70pBrYexPIRQF+t3/RQCKarIkGXOFbuJ4BBGaGORkJOqbzhKN7eMWYgeaOXDNs9//ICA
 IKz6tTOz0uuSadXCiGdOY0o6AynFElo+81ZB2toG2z187IjS6xIerMTrbV+zBGlQXb5VDVaTdwG
 kdgKYXIJeymF5RdlRrDefPzw6Sk5t2nb1uvDINRIB880SNkVNUdz484k+kIMd5rxFL2w==
X-Google-Smtp-Source: AGHT+IGG85eTOhJaVuEu0LlGs8s5dFygOzjEfuOvVGh9YxaOBjxjQMkDsqIfH5y4e7rWmGGSvPfXYw==
X-Received: by 2002:a17:906:318c:b0:b80:499:8a80 with SMTP id
 a640c23a62f3a-b802058ea0dmr1695967566b.20.1766594019673; 
 Wed, 24 Dec 2025 08:33:39 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5c4dfsm1802764466b.14.2025.12.24.08.33.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:33:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/rx: Inline translator_lduw() and translator_ldl()
Date: Wed, 24 Dec 2025 17:33:03 +0100
Message-ID: <20251224163304.91384-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224163304.91384-1-philmd@linaro.org>
References: <20251224163304.91384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

translator_lduw() and translator_ldl() are defined in
"exec/translator.h" as:

  192 static inline uint16_t
  193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
  194 {
  195     return translator_lduw_end(env, db, pc, MO_TE);
  196 }

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since we only build the Renesas RX target as little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index ef865f14bf5..d2f73221952 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -101,16 +101,16 @@ static uint32_t li(DisasContext *ctx, int sz)
         return (int8_t)translator_ldub(env, &ctx->base, addr);
     case 2:
         ctx->base.pc_next += 2;
-        return (int16_t)translator_lduw(env, &ctx->base, addr);
+        return (int16_t) translator_lduw_end(env, &ctx->base, addr, MO_LE);
     case 3:
         ctx->base.pc_next += 3;
         tmp = (int8_t)translator_ldub(env, &ctx->base, addr + 2);
         tmp <<= 16;
-        tmp |= translator_lduw(env, &ctx->base, addr);
+        tmp |= translator_lduw_end(env, &ctx->base, addr, MO_LE);
         return tmp;
     case 0:
         ctx->base.pc_next += 4;
-        return translator_ldl(env, &ctx->base, addr);
+        return translator_ldl_end(env, &ctx->base, addr, MO_LE);
     default:
         g_assert_not_reached();
     }
@@ -206,7 +206,8 @@ static TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv_i32 mem,
         ctx->base.pc_next += 1;
         return mem;
     case 2:
-        dsp = translator_lduw(ctx->env, &ctx->base, ctx->base.pc_next) << size;
+        dsp = translator_lduw_end(ctx->env, &ctx->base, ctx->base.pc_next,
+                                  MO_LE) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 2;
         return mem;
-- 
2.52.0


