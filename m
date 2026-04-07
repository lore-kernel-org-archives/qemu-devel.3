Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BC9FB5181
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAo-0007br-Qq; Mon, 06 Apr 2026 22:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAn-0007aD-I2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAh-0006zE-G3
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so18983045ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528886; x=1776133686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=VflEIBJ1/peda3v7MTr6U4GobQN+kVujohzBAV1/XMQqe3cylltZcIcC9cszin4fKg
 Y8kfTvpEyLAEjxJXqYlkpNZZpo0LUa8OPJ8BdtLxdikX7iuF3zgV4uEC2xu4VSNspeAp
 78gIMSUuAMBZkZAcDhghx+hk5li0/FXTHDvStRtmdwtM4ecBOQEg73N+XzZcUG5GbEwN
 Qk+AL2W512y/YxEBAIDyYz5022qyUsFBQNG8o85uGTMXXm7xpRAAjAUkeYf5hKGijHYg
 1ZStZsug/2I8V4/L5K+KayLU27FlxNr9bCZCEzyrU9B/uViJGt+i/QD76rmdQB0uBESc
 YbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528886; x=1776133686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=LZPVYSccDGTmGzw56BO1TEL1jpxePght3WfwR0no0tg5RUcy6mbrcfslA+G3ZfT8UI
 kZoooi1de3BEGyq+R/qWS1hH9HGcSoxjk1FUoUpMuaHJ/2rzSOKxEAOzYTMpJUR1YCZq
 igbV8l1mBdx8A1I+8ttiea2L16Xa5cF+IsUfUG4R7BuFVczl93mx1LUwo9m/7lA93tZY
 3nD9LyovznXT37JN6LfnzqdzEw71ccGsYLteE+ajtdrua2Alw1S9+dPp3cHOa5zpB8bS
 EY/Flo7TnNduYM0UutES2rW3XQQOQratUY4v1bWCGv5p2OS9Bz8gtmpDltdTeGeXJrDy
 VUxA==
X-Gm-Message-State: AOJu0YyTXRm7hzI9D0lrNPHLvRCrjViMeNUyYfJRgCzXIKzjK5N2j9z5
 yemgB9zptX4r4iwstz8Wg+Pev9GyGJ30BxoAMSng+Gs8pCSwUznFblPpp17y2T0xOdEzzzBYixd
 VltdyFnFK5A==
X-Gm-Gg: AeBDiev6CezHVLd7EpeUjxmzFQmPmsG9iR1nQz/Mlim38X1aXlyFG7UDmMx1T068uZV
 JFVTO8UuwlYYV1XEKC9DFq4BuxvB9+uZ62BviUiDogakVf/vS78LYGLcI1DWp6IggXrbit7wtEv
 U0bBS04RLyM7kSmORiFsFX4SPjdo9p6u5Ot1s8/oE9F4A/XBkDbxj8MW5oUHJX2UBqbstJD1aGT
 f2z5FCbrb5Y/ctWdt87YAHxla93YxH5RTpJ2cF1MGP3vRStZaTzPE9+wHdB09xDvIbLG/MgnIVH
 XPaCgnTkNV4JpNCYE5L3QlLZy5P1FUbceU2kFfTy60BnvPYuY9en+AP2df9ebDXlu7xHTd9sIJb
 dTXXXzfBGlagS+swjbIfMX96I3zU3jnwMHdNcaA4AeNvlKMisjlSpMm3sJLCd8ISEAN1mFs2AYc
 cm+FKLB/eeFXklRyUDrX6rfXnst4LHW1UA0mYvv4JSs/PogvYNEyRTOFB/kbwsAr9Nye2ixO/Jp
 rO4
X-Received: by 2002:a17:903:3508:b0:2b0:7a27:bb2b with SMTP id
 d9443c01a7336-2b28178ef7amr164946485ad.34.1775528885940; 
 Mon, 06 Apr 2026 19:28:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v9 11/20] target/arm/tcg/translate.c: remove MO_TE usage
Date: Mon,  6 Apr 2026 19:27:39 -0700
Message-ID: <20260407022748.57629-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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


