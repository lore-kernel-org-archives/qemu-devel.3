Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB78C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvVn-0007aL-Td; Wed, 02 Jul 2025 07:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVm-0007ZR-Ig; Wed, 02 Jul 2025 07:20:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVg-0002JJ-C6; Wed, 02 Jul 2025 07:20:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3138b2f0249so5428226a91.2; 
 Wed, 02 Jul 2025 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751455212; x=1752060012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnu/gBrofYGPtwFVydQpKrmYxzDenOFmEobdvM+2Gm8=;
 b=Duwk4noDgvTeLbqyhIjIv+hBLc6jP4DCxoDJkjEW8jfYf3sG8a+94gjqZNggm6RbJX
 i/mg2M50nQi5h4r4P5K32evBUc8+NQ1rWmS2xbEqrW6K6LpLE10WQhQ0lIB0sizFN406
 8LWa+qApebYfWa/MxWN9X7igpN80epOUIPrneDqzvMe9lN1oAJyUbkISCS9UtE6njKIq
 eYsYNLHP0bAM9d4am1rnZSu+bSiAk5kpq7g+YCJQpC6meqlVUVAZwYyjPjcJfS+wWK0w
 k4bvo0cpdnf+YuOQ94F0A72Ptj2ZcKM4G+3AZi752ZrUeJ9JbDFL/rFhsFevFINsknVC
 jKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455212; x=1752060012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnu/gBrofYGPtwFVydQpKrmYxzDenOFmEobdvM+2Gm8=;
 b=aebF11XemHdiraqpbyA9ru/9Y2TLN6zH6KcPX9TYUCZyO0d4mqFY8BDsR5GKzWfK0N
 vghZJsHc7itHZvVQkcFISoP3Mp8jwN+5+dA8kHFdSYl+/dGB7AqlqbXCuizajMuXfxLe
 rh0QIRGULvSN6FfXqOR2d884vTd59bxfQjcC+Z5C/cALFVFVoIH348VKZgokHL8adHFK
 eWPOO/m3fYBYShj7Mb4+k5VQK4qgDgiG6XjuTPI+jOWPVPGQdDFhllYcac6TRRwwvAV9
 p+4oIojqHfOXfnsTA8OpjjXydyCo7RJUFtamYfIg61SXhRDaO6SUXIFuKDBdy2sizK3f
 u2dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiC/QQBe2i1B8gVmRN2uIN7DufXF+HHRDYgkpMawH4/nbBhVkC7eUi1BrnT1GMaCWZPNaD5QPGAA==@nongnu.org
X-Gm-Message-State: AOJu0Yzy0MUYSea+SOqhTJXxUymyeaaKDeZiApp6Ru8ViLwvrUlZH3hq
 IFDlC3F0ZxAqs5iSe+bcXdHmJTg/YAAvDlYvgC7Ni8lu4mcNTx2s+slT7UHjDNg5+HU=
X-Gm-Gg: ASbGncubiYeHPfb4V67xDfAtA5tcyvsnVSTuVKQldeTxtbycNBBvfJa2kN1zov+2pOX
 nsDXUfpxDlSzLYAtcnJ2KOaheP8M1tslZgh0Va+cRaw8QVUFtZBylK9JeQf95qFRWnbyTIWgbtJ
 +X7NLdDrIc6AN+ZR0JIyCiBl2PVbAEJOnW57ttM4dl2p5eKhKaKafcmoUNEF1TC2vDxhuS2ry70
 F9iTq8waLxqviLOiPlb96RSCm0U99t9l/JUQlMx5lhUStmDNNblxuYM9Nk+QYdcjXPMfvmpt62X
 y+D5Ymb8JiBQr4ro3lHvnTFA/fo0ZN7bTzlvh8qca1gWW6y4wGbt3ODbpKv7Fg1QqU0cMexHLIh
 YfrItV7oqb//IaLPbZthQrFG8vU/GnmXAAMdkrh0ih/w=
X-Google-Smtp-Source: AGHT+IFFbJ9huGhqopeUYK1fxeFKxWnZSMAdBaFgifZO2zNRASUFvRnkG30KWc04jSDd0nfpN+TvRA==
X-Received: by 2002:a17:90b:5787:b0:311:9c1f:8522 with SMTP id
 98e67ed59e1d1-31a90b2a07amr4119983a91.10.1751455211787; 
 Wed, 02 Jul 2025 04:20:11 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-318c152338bsm13886434a91.47.2025.07.02.04.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:20:11 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v3 03/12] target/arm: Fix function_return helper load
 alignment checks
Date: Wed,  2 Jul 2025 20:49:45 +0930
Message-ID: <20250702111954.128563-4-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations (when unstacking the
return pc and psr) in the FunctionReturn pseudocode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/m_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f342d93489..28307b5615 100644
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
2.48.1


