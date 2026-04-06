Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C335F46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVn-00039i-GT; Mon, 06 Apr 2026 11:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVk-00035m-1y
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVi-000451-5Z
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso26147865ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487905; x=1776092705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=kuNDAMVM91p6Zt9Um9Vo2t5htWbF/b9VefOu5hvwFc9RGmwWqrrVLOsNdOA04sq5Ry
 Uv4jM0Z08y2mB83+lt3xyGUSb8HqXb5G75SYHripdsesYUPm9dWJEhiTkM5ShHW7RV7o
 SyrVuLiKp0t6tfeuMUSHIzYWgTAc9NEP04cVvDuDEezXp4BTqcZSZ5rkcHVr3EH6Yzax
 DdC1P3vqkBJlm4rODF+pNL4wwUQ/iM5roP5CODB7n4kgoep3MBENNgdleQttHs7fl3mu
 ZZSjjndJhj/kYNTtU+78FmLw9VZEbEfVKXMLLL/oOhuK9Nch88W0JIkbHHLP0SamOOW7
 YMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487905; x=1776092705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=m5nHjH0S+n6dji+ePAbdqnnX3lkWPXlhgLTPRgxEr7J0L4gjEbNxjgn2PLxaQ+TKhT
 X/UQItjfcwBe6877+U+z84aEWplznncesmSfylTeBu5QLWVLv1dWNhMqi4/pgMg8pOlX
 UKIlEbfz5Upiv/sDcQsBTLP+aEF0ZXfCTvXu5InkLqPjLuiXAK5/v4/w0SJOUwN1ikfY
 CGgR9ndP1anoYeYfTas7KQ6KnklVLhbazBls8t2pMXgHVtWo720lA8qFPJ3Ivpmdkpmm
 ta7D5GgpJ+MIrHfu9vGEcNtHXfB0rOTHv9V2t3wo6sO1LH5ZFZnvHoPwvBXNqYSNwVOu
 JKMQ==
X-Gm-Message-State: AOJu0YzwWSZRt96hvaz9tJwbE9wgebk5jqR6461ugt47ENQ3yy6cDe4V
 AGJqahECc5D6tCucJIaH2qOlHNIB2rFD4wDsmK4nQoq2jPI2kVYwuQpsHxDR64Y1SyJ3mNP9+ay
 6OoANDm4EHg==
X-Gm-Gg: AeBDieucFl2WGoIhQ5lQAuIz9hqKDXDd2uumwMMqD3pfZ3V/oc583JlBYBPlZMuLKSX
 b4ktWh0kleG0vTI09KM+w9i8Y4HWyV8sk/19+AzsjoUOOvakzPZb/7ROhod41hTF2B0WbaSG2Oq
 30lXzYwcLa0TDdbbuO/zJkZnNlUEslWhmt08dOpkYThQIGojbc039NblCzfVZa+ZiK40gcOp+IT
 6+mahV6JtiTSIkpKCIRA1aH82JvkFJp1qnvD0pzjaXfLEpA4Q38Vc3qik8VDorQf8tzi2CXI5Dm
 pgubnHC/XE9GJp2jpf0LZKSDuLK5D+aA3r1FYIAODLc0lgqAfO1LAYC7dPh0HOYfGYDxhsXFD5d
 ONvEknii0DXngjMGlfh6m4AcLS4s5hO1EFI8hJQMb/N+MiGHcq2LoE6lvu3RDT/WiWIewB90eDu
 ZJ6pqG5mPr8xlKzmhbHAZrVsU7A3GFXKqCG62ZK36ythuMGdpNXKH0rZ9muBnBZitG/VjedBa5q
 k9b
X-Received: by 2002:a17:903:4b0c:b0:2b2:5305:d492 with SMTP id
 d9443c01a7336-2b281783b69mr136552605ad.17.1775487904419; 
 Mon, 06 Apr 2026 08:05:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:05:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH v7 11/14] target/arm/tcg/translate.c: remove MO_TE usage
Date: Mon,  6 Apr 2026 08:04:31 -0700
Message-ID: <20260406150434.407201-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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


