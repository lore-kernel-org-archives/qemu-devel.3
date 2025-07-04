Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A75C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDu-00088R-8F; Fri, 04 Jul 2025 12:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDq-00086d-Nr
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDp-0005sT-18
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so7682085e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646307; x=1752251107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IJZT982rv2FiWLlGvuubYPPwI8y9TaD7lxYnflFDfTs=;
 b=kw4vZ3nq7i7REMV+Nahhh92hikKHnQG5PQ2cMir+JE206I012dck0Dl2y5hHxSo1Ou
 ff4EDceINowmy5kZCMIF7wPSV1a/4zmsSCQDTSCsaXh7ia5US6W3on5Fl8WnNapOYrFE
 ty9OMeJjTDZcwtKGLz4eTPUREdt9hLjWcgpWyD4GhHmcSMXXazVQfKzgnA/vBHBg8T+6
 5UwJrQYv3Ho9VqhTnXkN21dhVzB4tX+jiz1qPt/2UyHeM7lsOafrWovZOKKac1fu4pLS
 qzcp+nFDnApeBnZ9+KyIGuSORGoBLmFCcX5QgOuFXCQG9rizzPsEZRca+oTZXozPvt77
 OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646307; x=1752251107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJZT982rv2FiWLlGvuubYPPwI8y9TaD7lxYnflFDfTs=;
 b=Ca+sufr3EBpy5ZuzjGcmJof2T3sEvrQRdfDSc0JEETPMBCzEAPEibFPhmFZ5Y3ajpF
 ZmNrwH6k/xggnjtqArNZ8ghjBlgPgYVICdvaBEJz2Wm5ko7WitJZ9aIp0/OGUkHLe4Xf
 xFakFWWLAbXs+kwcUJ8dxdJ1MOogCFEyg2Mo2YpCOWA0PC9KV4lehq9Cf8dr7iv3aAzu
 tqNWh790pZS5/3caMgrQC0P6+QAR2y6klSHUA0BPKSf3Mx9Q9G8Y5XMzdERvpgbdCLCU
 OTqEL+69tgAomKSSx13BV/b/yXZZPD09vOGDXO8JpL3G3sPdw5PsOIk78Uw3k7fYLqSH
 NdNQ==
X-Gm-Message-State: AOJu0Yy5xU+8DXt1GVWKYQ9cUxfDUVOp8KIgsaFZQ8PLCe0Z7e9yTDes
 kcNcxv/pwYEtK4F3npBvqroySp00FeZY4MfoGJdDjNyF3lHkc2LRpvlMNvgA97NPf8KbxgFVgFx
 qnxXu
X-Gm-Gg: ASbGncsAR85ys459lMTHLK49qdyMzQBQ4DmfqnacN/dJMLn1IOPg4aNDgkasPX5Pt+p
 5R7nS+Ei62t83ceccKmI9Gp8HwxRfeyoLn6Yi6d/LO3nXu/vSzh+o/GMEv0OO3EjfW7uTc7JjwB
 vT3r2/QUZg8rVK6K2zCE1YdGqBjSZLGSYjvXyYt2DzNcwbAwLHtwQm+gO4kBiyyV2c1lCoaDTeO
 xMO/aAe1nnV2pKyYf6dF7PlFJyyGgAPclyWhwsma9JoIx2xCtdY/c5V6CGXzliP7FGK/3AZEPF+
 LWE2NC5kbkJeG/iJvrXdmdNMY21CCcVOTnTPYy76HxK81LPDz2O3wFkoN6aLVdytWW1+aibmlyZ
 P0zo=
X-Google-Smtp-Source: AGHT+IEkd3lgkCato2O43K96ck/dFsBWMSzKV/LkfESqbwoIZo333m/0TDGYARTgyitAPTvQoBE9Lg==
X-Received: by 2002:a05:600c:1f82:b0:453:ec2:c7b2 with SMTP id
 5b1f17b1804b1-454b26b2c22mr36722285e9.7.1751646307367; 
 Fri, 04 Jul 2025 09:25:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 004/119] target/arm: Fix function_return helper load alignment
 checks
Date: Fri,  4 Jul 2025 17:23:04 +0100
Message-ID: <20250704162501.249138-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch adds alignment checks in the load operations (when unstacking the
return pc and psr) in the FunctionReturn pseudocode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-4-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/m_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f342d934896..28307b56151 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -1946,7 +1946,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
          * do them as secure, so work out what MMU index that is.
          */
         mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
-        oi = make_memop_idx(MO_LEUL, arm_to_core_mmu_idx(mmu_idx));
+        oi = make_memop_idx(MO_LEUL | MO_ALIGN, arm_to_core_mmu_idx(mmu_idx));
         newpc = cpu_ldl_mmu(env, frameptr, oi, 0);
         newpsr = cpu_ldl_mmu(env, frameptr + 4, oi, 0);
 
-- 
2.43.0


