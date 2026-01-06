Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8313ACE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9SC-0003T7-Io; Tue, 06 Jan 2026 10:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9S1-0003OA-JZ
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9S0-0006ge-4q
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:29 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so7657585e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715106; x=1768319906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WX7ny9hKTTzw6SP1v80xQA6vUE2M3vQFdosLC/UPUo0=;
 b=AcpS523B3qQJXjaRS7sWjAMORxmA44sioIeCGPSdMdFtCVTYw3GvmtiSP03M56InnW
 n97gpsQnVGjUCAcqv0S7Pf26Yb5tUQ+Xz9EDsYb2E/GraO7Ki4n6GQUu6OyGauvkP9x8
 qI27ZSO/3qJaGy8I07i0KApykkwai3sYe6vkKSk8qLeWWDCbHuTDv0xcQQ0UE6np0GaO
 1+oJb8lRmJM3eSlZIkVTHVeMU4+hNHtwOGhqssKSmgfyKTnnfTACUNl00+m13Hfk9qYu
 p8C81bUFQpUcvkzsbBBDqRVs+VGIvFHVMTRQp5ioM8xGtBnUMpW/awBy9Q3a2EkziCNp
 uiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715106; x=1768319906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WX7ny9hKTTzw6SP1v80xQA6vUE2M3vQFdosLC/UPUo0=;
 b=Uh5wOzSBrntqd8c3WHrsf4jFXSI5fjLEEx+4XInfpe58qyZdvoWsYUGgdskdyS/2bw
 8jsm85esfeWZ5OQfw1k++DrW1UQPk4j3fJt4xp5ze/Vpz6jvUqQKhfJDwgLnUQz22YHM
 KDV8TedmkfNb2W4Zf+4Ps5n2uPFFAorJxW3DKoZ8bM6l7F1upzplmWYBElSbzemlfzSU
 aXpcgED7wA69J5GYVy+bFP8At7O/tPeRG6vyRmM3lUwE9mxIAtJAKdzentJ37VwfJq1k
 2kt4VcOi9LhPWf2+hqKrnjh3Rx4ug/y0rsyJc44Q8uui2dkSR17TdbtehTVnoDrfjXDl
 2o8w==
X-Gm-Message-State: AOJu0Yz05oEPC5BjAMnrkBcrdAvDpT3S2yaVcwJ/p+N2nT1oGuTmWpWR
 /lk/4utZDJBqrHjs4V8V9cZ7Nb2pg/2lalunIzPsZuLe/pkv10av0ebK+2FDYqD03NHXENh67bu
 Y4BkQEVI=
X-Gm-Gg: AY/fxX5ob9JkmNhHInPofjBZTOiCAn6FwCKjSWEqmXqYoREeqW7F6ufN+AK+4AbIIfj
 m4FWEDSGE5DemgdqY4LHold2sF68yB4LMegzm4AQKIMpstOzin0epoqBDVAD0joWaKGDT0/gwDe
 ZbOLooDFRZsI/THVg/psHY3Tg/nBxGx/+UaI8FAe9eE55yumiP1jRyPdx5g/93qbSI5KCe2U/Bp
 /Gp1aZnRuefMfVqgg8OxeCVzMZ4zLyuIiGmhy7rAV5i+C5WrA80MlUWLQXa4bURtD3G05Y52+sw
 qkREFdiXUC1O1frtflmTOub306gdgcNG35gR6z/UA65lvH46dWGNesoBfpbcoNJFglZHZbXUuhT
 PTpq+yQsIh3iPGCMM4AMy6J4oOGAV2qE2wjinp3EbI/W7pNpntLlGF535drler+4CaNVcdjHVEu
 UBzd7h9QZd4E8fDPwUocMJC6dSAs+Mb7sDy9wpsytKp78ixq7SwXLkA6+FHU45
X-Google-Smtp-Source: AGHT+IE871QmAPL1wi12j9BKO8IjYBYH0/x7ojMPGeJPDT26p5jlRZWRPL6ZQzLS5lY+ji1ewuYWqg==
X-Received: by 2002:a05:600c:8887:b0:479:3a86:dc1d with SMTP id
 5b1f17b1804b1-47d7f36e16emr27413125e9.37.1767715106025; 
 Tue, 06 Jan 2026 07:58:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f99bc42sm21150025e9.0.2026.01.06.07.58.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/8] target/alpha: Inline translator_ldl()
Date: Tue,  6 Jan 2026 16:57:50 +0100
Message-ID: <20260106155755.53646-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Directly use the inlined form.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


