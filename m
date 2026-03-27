Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBE610F284E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AJN-0006rF-6h; Fri, 27 Mar 2026 12:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ6-0006er-4J
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ1-0003M9-9L
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b042533de1so13760235ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629905; x=1775234705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=uCFGFBFAhd4dv8nHuXPmYkciY60drEdi7ljK7iAigYuY1ixV7v2B1FHBkbVcwnJqH5
 6ROzLYZb+REDYh1IiWBToZ+a18F7vaAlB1rQhQKBSxannaWUnnwgLOjW8/9L89Q4FHK8
 URkBoSOabaiJ53iPDxpW4fVmN/tUGHaurVKN6UoPxexQuWCfF5GIMwLxS5u5Yl+MraTC
 OyuFOsjbWzdmckq0yB86UasjAcfY1doYwDkBvWwr67pDSogFQozzrFP/AbP3wE7KAUs1
 sHoj0M5qw8Mn45guvJ+CUJZb88eecwzfQv087nde9oEggPYOo3/zHhJSsrRaRjUXvE8N
 l7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629905; x=1775234705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=U3QJvlzUxNXT2QN0VnGGt5nZeLgsG64ltM4qQtGZ+EH5JvSw+q/YLoHdGQOpaLliVQ
 fHDHeS+DgGwvV1v1qG4EYliMQnezEz9iC4whLfR1mNk4li0Vr5cq4wq6PCkHtJ2fKhxS
 WoKUjoqxVIY9y29CW4duWBb8yxjliBuuBQBFe9PNzfxFAroxo70jQrVAkE22FZgGhGuO
 iTGkWxqaApfvW66vbZiAT2F/N2Vcpg+tj9gWrBgyEeAHOJTNHGOUJ8j+lucGx7Hr41Ua
 me27OE/F8eh1QLhEu6YTWBrkefI4qNRymIxtmIzPyYuShNkzwqs1FLXGRJ6HWAvP8ImU
 hGag==
X-Gm-Message-State: AOJu0YxDFHB8QZ7nc6JXas+5oV3HpCAW7Ofc0J5Wq5eqNKKWwTPLTTZF
 pon9z09C0dtWnxq8+0GDJGEOiPoA1CClNlF2n5fgzdMqTJd6gZPq5nWrT1Ci3/ec7a+S/oJMWY+
 6xpAWg2U=
X-Gm-Gg: ATEYQzypyJ2eBD+CZOJTsd+t55gp7rqZv0dXFQ6Hlm7txkFbqIDiEN54mvzNszH6IaE
 EWG2DcpIlSAyMSsHW4itrAI7MVzK+fzDg5w6R4VtmeH5oZrhusw854Aiu0zAKNhVewU0lhFRjzc
 iUpj5eb4sxyHilNoyCF4vbgS9IXhfvfvgE1gUiLSRziX7PbjLiUcTpu/DHgYGhX/8zmUiF6FIiO
 hFgGzyAvVw3avN09SGwRDCeOHaWmwUfqVgCfj25RU+FU16E2GsU7iPig1c3tIKKyH/bH/IAm9Ox
 Xn0v3eevESLL4cHXxzT8BiprKG5M2ozHiKTE45//n7o+aoRuKeahu8hBUoPRzQe5UESc1ZVAO47
 iiU1u00UqK2l3hqhTaoqQnYYa1/wrhqYpJzm42CrG2Xuv83syTL1tVOucRWD00IWY1KUXasBMjS
 Ci+n3JSeIxLrp6twIrFFMrhL1bXQRY9etSIRBFJGh6Bts2AyxfKL8594boAiGQIEeLa4chcewih
 zw8
X-Received: by 2002:a17:902:e883:b0:2b0:4a57:e480 with SMTP id
 d9443c01a7336-2b0cdd21003mr37122195ad.45.1774629905249; 
 Fri, 27 Mar 2026 09:45:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:45:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH 11/12] target/arm/tcg/translate.c: remove MO_TE usage
Date: Fri, 27 Mar 2026 09:44:48 -0700
Message-ID: <20260327164449.596767-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
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


