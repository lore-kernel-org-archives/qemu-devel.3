Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82039C44503
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzT-00011N-3H; Wed, 08 Jul 2026 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzQ-00010N-7p
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzO-0006tI-Lx
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso11477105ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527549; x=1784132349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GPyqv7yuW0jvs6N62tVXNbDMdQQXDeT3dx47BnKVjt8=;
 b=cqGHtUwGKHTHjHhXw3YfWCPSXh+42VD+FACHGoTG6oqAaNjF0wtkauDM5hgedZMVrq
 baf+F5zbH+YyaYy54x2HOd9bK6YwgcZmIxnw0X7h/CqC6FJcwveEqB+Mo1Mml3QdVyiK
 BHk0t5lrDjnL1ggsaZSqIHJKBakU3xx8qK7cI0AJ4/YjcZHFQ/SzbVxQ5BBpXqXq0qSp
 +hkkKuFpZUdj62ExL+TKikbKEa4KwETAcANAgE/DD8EhhNv1pG5bSDRUG6cm9WvCMVg7
 zvQ1FXRf6zoLn7BynfNes8wRaBfPWFnCi8CUYGQCzfeBlSUwgk26vYGipRYFk64XWmpU
 sf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527549; x=1784132349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GPyqv7yuW0jvs6N62tVXNbDMdQQXDeT3dx47BnKVjt8=;
 b=G8CDhjHHK4rrh86tKONxqpDWbkcx6ui4k2fBVvqkvMzAUWnwlrEovF+TgqrVAIHztP
 7qCX3ZlTuypl6TCrte+gFXuGUpjnFQxTGSBj6CSiwoRavZGAqZZJ7xvDqKFKGUgQxz9K
 rNEBfD/tbiSVo6qv2ox+q4jyALVb65NC3cTd7uPEjwytdN9FNSJOAM/n8bRwFyjl84Pz
 CdXMi7l9M7+twnFQDUmzlSr5uErswmYo8PrTzR+1FckD4H51B8NNoSVYFS1Mj+gzmROK
 xjnkRQ1U2atSE1xihmwK3E7ST1gv3vUQ2iA2Ecwmc8zDFS6notd/tMSHmzd/NGF294Xo
 T9AA==
X-Gm-Message-State: AOJu0YzcncI73JeSWi9DplQ1d+Qt/BLuItT1JeFkmPfX/kc+5tn1SzHy
 kZfV/pr4eBgnidxa61fi0besYvf4/8h+ni4n4fEossiv9UXBBo1D2ls1WACRuVCE4qLf/Oapee+
 jgOxz75gpg/1C95Qo0/KM4gsctFOhQXLOkeNsNq/R/BDXgTaXqG6FGMhxaYClk6p3VghLWqTtEu
 xNn445oIVQyBwN3IaZJ7bIGqExEqNhy0Yb+0c796s=
X-Gm-Gg: AfdE7cmrTK9q1KIqiEjw/TQPQLA0hNYQoAHM5FBdjH7ULeiLweS10daUmcUp7Yu0G1D
 mdK6WiCVGQANls9NIu9w6CbBovNpiW87MuAD3ys65aXg6uKVZGTkCUS5F1JSDv+jpaH0CLuC5NX
 hj1rtuNLuYtJW+ikrxQ0zB61IWEJghk8SZ67H8+On+RgapG/ASsHohlh+ZodThfqgDGHR3GeEUB
 DRtsePpsOJ2baR4ATig46MQ6hHW44dawupr21DF1v3J2m1FR9tIItN4QhsHgU8nfA/CAOoKEg2G
 YYGbr4k94Cg1tE13uinvncMVwcT1I3SuVroEWlGIfnK66QulB70uPrVDOy7CwvOnnMkxsf6hdaY
 nYe1LmKIGWbIwtkULlnA7WsdqlluLERCn7NqvLmtKeFR/zsrNYKD4kIT08goCc+RpBIXnu2L742
 7BCa4ua0sCOu0ma2mvebGWn4KwO+IF+GSCSsDFJmBQ2zbeUaiyKqFRPHTa/8jK5FOZoV5A94X9M
 xP6MwHia/oGZu9r
X-Received: by 2002:a17:902:e54e:b0:2c9:e86e:aa0a with SMTP id
 d9443c01a7336-2ccea274c6amr32158255ad.0.1783527549141; 
 Wed, 08 Jul 2026 09:19:09 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:08 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 1/9] fpu: Fix biased exponent write in parts_float_to_e5m2
 saturate path
Date: Thu,  9 Jul 2026 00:18:51 +0800
Message-ID: <20260708161859.1124848-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x629.google.com
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

FloatParts64.exp holds an unbiased exponent. Subtract exp_bias to store
the unbiased equivalent of the max-normal biased exponent.

Fixes: d8be49537658 ("fpu: Add conversion routines for OCP FP8 E5M2")
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bc244a44ff..e2e53c1d68 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2435,7 +2435,8 @@ static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
         /* Per OCP, conversion in SATURATE mode bounds Inf to MAX. */
         if (saturate) {
             a->cls = float_class_normal;
-            a->exp = float8_e5m2_params.exp_max - 1;
+            a->exp = (float8_e5m2_params.exp_max - 1 -
+                float8_e5m2_params.exp_bias);
             a->frac = MAKE_64BIT_MASK(float8_e5m2_params.frac_shift,
                                       float8_e5m2_params.frac_size + 1);
         }
-- 
2.55.0


