Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EFAFF5139
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaV-0004ET-8U; Tue, 07 Apr 2026 15:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaP-00046B-G4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:45 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaM-0007Ly-1Z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:45 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35d9749c26dso3994199a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591981; x=1776196781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=LiZzLT/e1+D14Dnk6fsYcBaew11ePrww1Y+1QF7vrwoYdHrFo1ovHgL3G5zWvG8I/q
 DIx1/VbiUeASOsLpxrF+7rPzsk2XC9RtDk2vnF0J0RG/F5LVcqTqPTjrqWLd6W/Felpq
 N3aTqJeyN9O2WgH+HXruWO+h+bW6PS/bHzYnu5c0DbkFXu8gaL3hbg9ZwW4gl5bW2QOQ
 jQDimJ2OWRrJUIqZwFazrgSEupz2rcwubirt+MrOpnZc8jGWmBjKtEx3ASLNajqbUepR
 9yEoDLgXpZajHbBidP5IskpW1DIHO1x1ZsBSqBJWBWtc4gkffEEJTOXuoJ7HopRUcVCe
 5n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591981; x=1776196781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=R3/OWK+Tzjkn3fx3auEXTeG1U1y54sgLdcw2p+yTi0PZj3djTvGxmp926rdanS90CI
 hiAqv7QHRgAkH2SI5osNSK/RkruT1rWnsuIJrMxViSwSMHeFcHFQzJios3kKKjepVqwY
 JAbAuQ6mqwZ+iwro+82u+0TcemTFt2S9jxWrxw2l3kRPPWeUP2Q6fDHvkC3plXpWde+9
 OkDNPlpAXNRBNQPw2QojpWOvP9wu9BFEy5/XuYwYbhzDb4lSdrGyJDBoTUvEluykvmsY
 tjSKw4mCtu+bGcT76+AL/xFrmdEJCif5h1yZkN2gqdqUH9MexBygq0ee4TEdOheOZ5oh
 ylLw==
X-Gm-Message-State: AOJu0YzxsezWLQbhkagj31NAM0ojh+YIkwukyGvV1K0dBhDTX3uST2JK
 T7C5EHC03nzp7oq/D9hleg07Il9v0NrHfiH5PcuY5cjcRWg7v7t+wGMI45L2iKFoP/WS0HY7noA
 V6Gw0oaI=
X-Gm-Gg: AeBDiesFt/ItIYesYfJH99pKnoJuGEZkHX05LUbox9TymIk+zCqb9oecZBfcvJGcV4/
 qT0JMJfXKMwONI30T6CyaBfGRlJV+7a10q2651ZxGzsxMGJS5kwWNe+0MMFISXGgyt94sH1OFOs
 J9flgirCWupgBxApGXwDUPDtWCbkS2lXdYuBBtPJo47EX5gOggHQLso9FJ5d2bOqMcPiui2d1jG
 XHPHnmW7wU3t3K+4hKQk/6DlzIl10V9HpJX5eZOSuoEYy1QAQPNdQsGfyOWzgFSBilk0Jn2Zevv
 wExRCvqFbOhwwBwAMXIYY/NrIrtCDOrPHZwfQ8oeT5ixSS92AllXuUiT2na9hRK9oJVx5C8N+G8
 weL0NNrkWVZ03DGycqpd9bvWi31ozESeiyye1vpTMoApmE64NBGASX/K4RSd6NQqrnO8E8B1Icn
 RTzsD/iDsCvnCABfglkw8/Ew7mIRj0rAPgXkS3IXuzXPj9k5A+yuh3OCTJlmRNJxyOGvDZ6AmHA
 BdA
X-Received: by 2002:a17:90b:5583:b0:35d:95eb:87a1 with SMTP id
 98e67ed59e1d1-35de67daa63mr17225473a91.3.1775591980691; 
 Tue, 07 Apr 2026 12:59:40 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v10 11/21] target/arm/tcg/translate.c: remove MO_TE usage
Date: Tue,  7 Apr 2026 12:59:12 -0700
Message-ID: <20260407195922.196410-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

dc->be_data is already set just above in the same function:
```
    dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
```

Cc: qemu-stable@nongnu.org
Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 56ef1e0eb59..4546bbeeeff 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6344,7 +6344,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         dc->vfp_enabled = 1;
-        dc->be_data = MO_TE;
         dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
         dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
         dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
-- 
2.47.3


