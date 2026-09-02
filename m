Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7097AC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gjo-0001IV-8k; Wed, 02 Sep 2026 04:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1gjm-0001Hl-OO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:54:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1gjl-0007tW-84
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:54:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-482f9309813so800480f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788339267; x=1788944067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ess7pqfJa2NlMtnSA6lUjrEcfwTPcwU/6N1LeUxIGk8=;
 b=qUvwGaKJWUVbOfLPOTgFwBxuwwS7IL1A9A80GS9qg4+nAqBxsg/PgvAxNDL8e0ejVj
 j9b3tnC8CsUEODEqM9wn25OZc/AYJQrKsSYikOUwtoH2RFEoPhF9oq7tTafx3LJWGq1n
 Vobat0H9CWspvC4m0/NH9/dfe25dcuCSSrn9yKMrlorS4vVScgufkr7chPdjyL1J+BRl
 x6YZg+s+vARpeGFoB1Dru+b6Hx9HRDad5+30RmYw92cA6JQfxwksI74Xlm3OrAJbM6jc
 yQkOPtyUWHvwK8ufIozHv5U1StmJ/kfapytYDn24bmXD7SwpoVkeIMuzLAo9LqfWfnB3
 1Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788339267; x=1788944067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ess7pqfJa2NlMtnSA6lUjrEcfwTPcwU/6N1LeUxIGk8=;
 b=K43VQP4Z3fOszBhKSaEuSOAhvCfucp743gaDPR1xY0zv94D1EcDEeNVgXqLKwiq4Wd
 fpE7CNFsodEKNq7h0ZMDJk6qHQu4rplB6lh5v6MLf3lPgBb2A8tyhq1M6x8d5H6NISoG
 6YE1k9On8ZzcvIScgnrR4ikkqMwYZNTtIz+dNM4QrhvtqYuX+GSewctuOYq+EIe9J65x
 uagTZgxIeJ1QQ4dHi9Ucefvv09wuIRz0RC+XW1bhBLn0hVUd7XQ3mb51hzljsYL5QN79
 FKE7tKbrQZJp6WpyRep27mLT2y0LG1JWevEBkAN07fFWKnOqm98kZJxQ7d6suZWlQCeD
 bEvA==
X-Gm-Message-State: AFuF++k+S31pJgAk3kgif1mjV0mClEVJ5pQOGoBj40JNY+yaV63a8xAs
 6/SdF7rNXylkQY190xByHJXQ5ex4cEEikzA/Xt3KFMSPpKCnXkhN8fP6neHPFNSxG+g=
X-Gm-Gg: AYBFou3DIPwrUVQwUlj7fpGXnpkWQZRmeQl/5ER5k3VJIus5chGm77ecSqtQUAVWMmU
 5F06gfsb/Brsq7vXV5DFCp31mMndcyr2MRzfvYIwrfxryc3CfRahbB2F9xus96ydGA+OCPPWJSh
 VWThZkF2l7b/8XPoaglyNW+AkgOfbkMxCcZVhWOd1qUYg2iAKI0rehdXbpYzriXN6P1GDOUC8mY
 K4UUhvM42VDCfNsy3dPOL5vLcaqKGd14QbrwgQ0FgfTbFvH15qEC/2sYNp7m6ERK19fsOBhYjEt
 jk/qjhNGrzAucBml3UroJAIUJNHYe0mzxHbWQLxH79wo2LI88KXkFQF6Ngy/ZM1nuTCKRB+jjN+
 5oY2qOtGgkyACoezOWhZW7UMLDq7V/KLTw9qm2bnk72bDUot1jjI9wKVrv2AWqbB0ZqQOLQ4R9d
 9hdF0PE0IaFAi5WIfJ0Beu7cgOphaS1x0eqVGk9DGAtfX/LmfcgWDIYYyIXm71pz72WIKCul8uZ
 ASl91EX+ZFy8onE3b7j9/pYAzs7JysmL/GpfgteOh/+Vm5VUJoKRp4lp04cgfCDoeSMGPA21t1W
 DSShWsdCYYAoF3bDqei5EbuHZxvttr0ytfOjuqgh6A==
X-Received: by 2002:a05:6000:1885:b0:482:f0e4:3ef5 with SMTP id
 ffacd0b85a97d-4847b629897mr6013659f8f.0.1788339267149; 
 Wed, 02 Sep 2026 01:54:27 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-225-161.tugraz.at.
 [129.27.225.161]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e7f8f9sm5034634f8f.9.2026.09.02.01.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 01:54:26 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: Fix FXCH to unconditionally clear C1
Date: Wed,  2 Sep 2026 10:54:24 +0200
Message-ID: <20260902085424.148650-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Per the SDM, FXCH unconditionally clears the FPU status word's C1
flag. QEMU's helper_fxchg_ST0_STN swaps ST(0) and ST(i) but never
touches fpus, so C1 is left untouched from whatever prior instruction
set it.

This patch clears C1 after the exchange matching the SDM.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4399
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
See also my earlier patch (20260828082235.128360-1-scherer.simon89@gmail.com)
to unconditionally clear C1 for the x87 compare instructions.

 target/i386/tcg/fpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..32af8b79f4 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -519,6 +519,9 @@ void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
     tmp = ST(st_index);
     ST(st_index) = ST0;
     ST0 = tmp;
+
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
 }
 
 /* FPU operations */
-- 
2.53.0


