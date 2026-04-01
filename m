Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9ED10FCACC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8186-0006gw-Tx; Wed, 01 Apr 2026 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w8184-0006cZ-0h
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:28 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w8181-000330-5W
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:27 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so43188a91.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071282; x=1775676082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=t6uHQEEq4aNiIpE8kix+FSNa+AiHVDagscDydj3snHvwerPPk3T3k0+KzWnGZ9zhYI
 fRXJjVvFyVpCc/UFw/dJSK46QF1boj1k/6vFJQseLHKqtxnfdDoXvDikoLj+c4Z5K4wW
 dM20QRNrQOyZDX74Le0cw60017e6K8FXwRAMwVIKBpgyvtvr+ZkN8mb36xLdRUtu0tjF
 uXurBpuvv8z35Bp56WCKXWNeBMVKOrFyBn+E2R6pSx8WudGXfQ+u89WIZaFFKVQM9Mhp
 0zq/nty+rlgvMgSncCGkJW6MNHGuJjwcOBjxX0Q6+iq7TxzHVibEBzkbdZ5q/Oap4CXP
 Go0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071282; x=1775676082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=rhwCCy5uYeBgHtXNapuTgaGH7aTOGKmNPPeEEuppLxEyiIqgP6c9AUTkwSetUWNiBp
 5IyCLYv6eWIj6OdmlOqvshlm99OwyUGbcTuYkC3G5wCEn8+ogp6aSZUw1hTWvdiFmM5+
 sQLWKY0jA9O18gPg/PDRWIzCuXN/us3kGuoDGOcWxkGeZhlY7nM5q8Yk5w98xvFXegZZ
 xtpGsFyXkkOXe/bJzV5B3KCCQs7fJgjZ0Gm2x3q42mWB4AcwxM3C/oYLmYv0si9ynxbQ
 0ilio/NjNvh/cTNpX3/Xc/h+UFqBs4oXJEd1hEFN9d0OWpS3h4ZclmIYuLDcXY7XZIW/
 8jYw==
X-Gm-Message-State: AOJu0YwsGBcj8kBAoMKwVkvUpDZMRPFaH+eP10ZT4+ss7zsGisPqUTM3
 M9x/LizLVMNTZHY94dOcrjVeRlXlzwFs/fGMardTQ60nX6hmWr3IAmifYpTot1yqmUMFGqq5HfB
 SzlYuDHgWNw==
X-Gm-Gg: ATEYQzzMiZTjmOSMbZ1ItDH3eUVGSBnb5UCX//iq9odFuAlcrc+yC7qwaaA02f8aWvk
 E5eIyJIdqjC4g+pmHVnzlGvBRwEv7s8dzfAjYqd2XB12zggeE6hY/WzFSo3Re2M2r8XYaSJJnqv
 Xq+w02Tl7tvxFCwCMCnAVwvPDYOx/XSn6EE1XGNLrJmG78FlOyJetKwXV/vYs27XRL8zvFM/pLV
 WL7OqECz7RHmMp9SGjPFXg+FJGEmlk0pQ3r61VejOzF99pyiA1uyXAHDJ9dZhAV6ne8sVnWsoeJ
 KfWwke9XcYHDXce1Q/CoZmJbz7LnYtLQIf8oL8c3kRu+ws2fXQygSfoSDo+E2Vs6wcvuxPbIZ3Z
 pwTUNCsRmSTj7BQ5K+6codlaA2mSvM18roM9RsyGrflZ6X0SrwsQ85lmhm5rdWCuLbYqWnzxypa
 pWYAyEccJDk7qfX94lueec/7T31atw+CyCjPvBAYSZSfk89S2DbmjSMy6kSpNRolEnskISV2oON
 ghe
X-Received: by 2002:a17:90b:4a91:b0:35b:a170:f266 with SMTP id
 98e67ed59e1d1-35dd406afc5mr539092a91.13.1775071281889; 
 Wed, 01 Apr 2026 12:21:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH v6 11/12] target/arm/tcg/translate.c: remove MO_TE usage
Date: Wed,  1 Apr 2026 12:20:56 -0700
Message-ID: <20260401192057.1182724-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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


