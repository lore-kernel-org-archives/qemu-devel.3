Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856C210F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVy-0005Zl-7i; Wed, 08 Apr 2026 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAY6K-00072y-VU
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:09 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoX-0000pK-2g
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:31 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so4950681a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600547; x=1776205347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=Fh2GmEM0c5du/RDopSOwTY50J0TDuS+klyflu8/TGWV6lw1HXdFjt2NLp70pPVAHKR
 KHVegyNSp+ZVpKVbeVZf/gb2B3GSBSM4bCylYkqffEhkPJjMcGjbDfYCTGD+g3R5273c
 JJgApWjzpHeJ4lk0wFrwkFqDVoifJQI5R3pxMQNXskZA1N4JUihMrmKpnvfst0WfQuyv
 56pPW/E/seWWcvOX9HP7UMq6c7bo2giiEu6op/xzwQvhX3u8271p7iWi6DPzwdx7vKQp
 JWVXIVgeLLqGVJDd7Lj5rpaLjHb94qUQ0JqQUdU99j08NkQyD0t2fHXmd2o8GLz7ydII
 WIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600547; x=1776205347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=JyZ0AB3B0STL1ULF/I+2d1+BA9LCjh44V6aQyXI2bQB0PZFX1qVgkbr5gn2r5/3SGO
 qwogS3p/5ADYMo2IlX1mmtzABXmRBUcDWQ/xqP50RjbXeuHMqhHl1n8EOYVXBYgeiMmZ
 bDphvNsEq/vnnMytPBUxM+ba7Ftz8JwDY+v4KmCNB/YmEAp73k7G2Yq8bj4I27gJc+S4
 49Y3XdxLp4B3zwCOwllqENQ3SpeqYfoY8LRQhE9zqA1pI+MMx5G9CcosAyrKN0bx/fro
 Tlsmek3itoPAw4pW5tJoOpKRvoo7H6RSd6nRtQKQp0qZgKgDnb+sgcqJbBoBS2kLojlN
 +ccQ==
X-Gm-Message-State: AOJu0YwJoSJdAmYAl7ou6LWO9hu5xM4BntGL87j2SF5HeIhCDI8MXG0/
 mVR/aVPSdHgnRfd/tXckjRVnW0ujYI3m2JvZ8ZWwEP8U6ww7/p+6Sc3HB8JZjprKjiMdj+B0Rhq
 3GaIOt2I=
X-Gm-Gg: AeBDieuv9vSBWL88CkUzz2kj83oJO00LF7/h/EXe2zqvh3ec9+KtigXEpW+exDSiRXZ
 M0QmZFg6FfibqkQlTpSn+QLupkB8SkkAPeUHF+IpwTei6VwURiTWIVUBs/XpYMVthJIfeYGVM2a
 NZTIxCGbmevGipv3fMymyX70MENSEb/yCeIcWxw0hXSqj9F4Oe4Tf/9i9ZkvGgtRkb/X1RogyQ/
 XH3gOGFNJdad2KL2z4lYuXpxl4WNxnaVF8XMY109BLnxB491CuYDZVkW2mGg/jukQi/5r4+YotE
 dxXJDmJhA7pCNeCF3JU7D5lncPTeJfWPDpvtNbM9nUV9s/ekkY1so3/7lac5i1KqjmzLYM1jb2u
 TIFTJF6LY1Gxfje/zsn5Ym4jK6e9IBYOnex/8qDASxbSk28NYls0CJBIyDJvCQBn9Dl1u6xzON8
 OHPoGWuppHW3nl7hnbQlDIJ9TDwlZLWPFubQxZqcSFyiD5DQjjMKQjfbpzle2exFAcl3SYvSzpV
 emA
X-Received: by 2002:a17:90b:5547:b0:35b:af3f:3618 with SMTP id
 98e67ed59e1d1-35de69aa3e4mr15301088a91.28.1775600546846; 
 Tue, 07 Apr 2026 15:22:26 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH v11 11/21] target/arm/tcg/translate.c: remove MO_TE usage
Date: Tue,  7 Apr 2026 15:21:58 -0700
Message-ID: <20260407222208.271838-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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


