Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C47606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RtFv5rjU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOe1G-000427-8k; Wed, 04 Nov 2026 11:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOe0q-0003vs-G9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:39:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOe0n-0008Uo-Vm
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:39:00 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso6053755ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793810336; x=1794415136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eYOXZ6lUypeKGCZXNL4Bf7EpT95UNCNfs1HzTQQN73M=;
 b=RtFv5rjU3NxHDV4aatdJ0TZ7g8zcmpl144IQzifVFvjM9mcdUiXSTOsHZoWywKbsDK
 v9mq56tqnXv3alaUdYONJa00EriKYZZs3wjoO3Cg7OM6Pj8+rkLzn7wHaEDg7pY7O5py
 PEG5pQpFxWbk1IfI4PdxUfA2l2TnIsrVyc9d+EdzJpv6YXlBwg0rOOinw3H0JMxYwDKj
 wRp9Q2b9jKUNQWddE6605PF+H9V8AXkpJJrfzwkytZ9YallG5ntIQTC3MUwXEJFkqwRp
 c6t3h8UkwmBcPZN/Jv0luQ8CFCeZLlDMFI4Ht8fvDOFCMF9e8zwR9jY5l8QVAyK7Z3Sv
 6WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810336; x=1794415136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eYOXZ6lUypeKGCZXNL4Bf7EpT95UNCNfs1HzTQQN73M=;
 b=RgK7uIqlVWFkOHvHJ/a5vzOu0AMoFulMASVYTKs5qHKxZunYknlHMkFzMpSR4Bw6G3
 wA8DljGosvX+i/4P3Lu918yJIVORAYtXdEPqeIJ8BlLJURqh1XfhjZqjr4Gjm2dXX/bv
 7/Ivm+d9/jrzYIH9I+YQ3GvO8uZaEcwk3AThq80Hk/LPtYQqAbaRkqEozWFsFbkACohp
 7nYtYXjD6owp36IVyDURs1VEgWR8FECIkM8JKNdhD1m46GIjv2UJ8Awd6MYvFxtaarpK
 9yNmPVR/bn0GB2y+sQycPu6Y4a5LFcM4F/BJXbQzG/lDLmpwCC6CAe6bTpufWF7EL5h1
 uX8Q==
X-Gm-Message-State: APuU4Z/xHIX/4+SzVcX3CCo1ArBokAUR7p1qK9j6WVXbMB54iBsKiMHk
 sAIe/xFNoIKM44eMaBUd93V3ZJIcv63Tf0FKtZz6Vm2Uc5eTIBlV8VS2rWkzadG78i0pUi7WMGs
 yaOo5
X-Gm-Gg: AYBFou2b7GObF8l/vWumdKBb1cgJV5v+cpsYtQFU9pao2OLqgJN+g3nQ8I6BShfYDf8
 EDBnnQfX92ZgvMC6LyUNI8Tt3GBXH9QKemULf/fi1tkjFrHIDcTXJJJ+qnMDzNKvACC2KuT0qez
 VcRU5knPrpuzkf2Kgeg3XrUA+OCyVVOY9CQhCnWFQhR0Axsm32Nu01hSOhHvsJYAZILd6eNKymp
 CupTQS+niTSZk8Rm6Re4JO9WFXRcvDd91NPmqbV7ptWVGSKOLEzsSl440K4mN/2hnHuN1iK3DRC
 gH6fDmkmJpx7t8pL5Pa0vghYkTnCblkjQpXwgbevPTc3rSnvfAw4XgMLve7aFVnE/k31Kdo5M57
 Ts4DLmeovduE8mOxrHH4fSaMSBoYtuTILhVZvPzSJ0vJlxAMr3xMWb+zxlT0c8lb7esVhvjDO32
 1ljTfFcxwZcWc6SCMaRvtpl5SMtNx5sDaS4VMrNqTe/OMtlXIkyCPb2ApwLPi8CUQrtbOaepG6K
 bax00GPMF+3Bum47qJ8dtYgeOnpG4H1S3i0p3DWIMPgQ0w2qeCyvgOE6mqy+1TnbLA00ruBbUpC
 KZtCJb4hLF61tQYOeZw4T+/2TwThH2vHCjzqpFxM7RLXFzXZZ0aTchy9y2G4ZA==
X-Received: by 2002:a17:903:1b0b:b0:2e9:95c0:7c50 with SMTP id
 d9443c01a7336-2eb364941cbmr144493495ad.71.1793810335745; 
 Wed, 04 Nov 2026 08:38:55 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08bd50b5sm10454115ad.4.2026.11.04.08.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:38:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>
Subject: [PATCH] target/ppc: Fix pmu_count_insns test in
 gen_lookup_and_goto_ptr
Date: Wed,  4 Nov 2026 08:38:54 -0800
Message-ID: <20261104163854.87398-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CF_NO_GOTO_PTR is in cflags, not flags.

Cc: qemu-stable@nongnu.org
Fixes: 46d396bde98 ("target/ppc: enable PMU instruction count")
Reported-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4e..dfd09b66ff 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2645,7 +2645,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
+        if (ctx->base.tb->cflags & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
-- 
2.53.0


