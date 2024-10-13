Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA7CF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06q0-0007H4-2m; Sun, 13 Oct 2024 18:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pg-0007Bn-1j
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:00 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pe-0000x3-D0
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:59 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e188185365so2840308a91.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857577; x=1729462377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpCts7Lc7po90jMJZMaWUdEUzHFwVBTsaL90Hh3zO7Y=;
 b=bmn4ZD0zL7DMGm1gR5ZhLlqQKWHunczXtg3dfZsxXhUOibwP2yX/V9DYAXAVm1IRIm
 Bgv5eTzOucYoV5XPOcSMRzPIU5DdIB4iauLb5lg+aaioH7cbwUfRMCvboyPfpj2XqRZ2
 bw4fNNimSKDqei0noKntm+TV0k0K0xZzrMomJwmBvEyPLYFJJNAUSLqoSjy0nzPDeXVt
 U5lfpvHzpHVRkGf/BWqHASDHebLCM5NcvRktt6Tdw3vQEbaoK24gSu9PronUgCqNXzAH
 hMa7zgVoFjPh5iNxxxIFxFUJoW1dSA/D/FOP9UESZDfIH4qOqyS2gk8mb03TsfgKFe1b
 L4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857577; x=1729462377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpCts7Lc7po90jMJZMaWUdEUzHFwVBTsaL90Hh3zO7Y=;
 b=R4lKjWv+FR5WkMuQQuMuDIiQMc2XIlbudvEQSSjaUTpHlmqMFXm3WdDXYZT93WRb3h
 sNN2NocAXbJVvsQhPABGJxVmMvFMnweKGfx3r6m8tmfccfmNxhHJy5x7NqWCXKxgxPkt
 c5UXkn0w9taX0J8HzIu16P+3grrnONpBdVWlIMvzgZuBQnTeUjb7xOowIk7ZCljhbpgv
 I7B2+ggQJ9mUJezgY9uv68N80p9X9wSSmUyqjjrIbnRhpFgxQivsqT084k3/YvXEF3Xf
 TnKHLw7g+3074BTEZ+WWj1O78gOPSSCpyFdlCqrwRqojNwQ0SdAV9y3kWsGeaynzxitK
 iMEQ==
X-Gm-Message-State: AOJu0YxD1ttK4xviU+ejuedInEJ6oP8DBRd9qES2HecJ5EKNHzmY8cgC
 WMObcRsU0SfxS1SeFl3PrDIuLUYDz80mHm7IEg7ZaDAMov7hUvkEnB1rkeQMjFRWLX2Fn1+WQ3L
 K
X-Google-Smtp-Source: AGHT+IHghjQRIs6cYbA6rGD/3eMJOK5GrRxNGVSwN053wdDB52hhREw1yF2qF4gfA1sYfbpImFfvQQ==
X-Received: by 2002:a17:90a:6886:b0:2e2:b21b:2247 with SMTP id
 98e67ed59e1d1-2e2f0d80e8cmr11945651a91.27.1728857576996; 
 Sun, 13 Oct 2024 15:12:56 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/27] target/arm: Pass MemOp to get_phys_addr_nogpc
Date: Sun, 13 Oct 2024 15:12:30 -0700
Message-ID: <20241013221235.1585193-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Zero is the safe do-nothing value for callers to use.
Pass the value through from get_phys_addr_gpc and
get_phys_addr_with_space_nogpc.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e92537d8f2..0445c3ccf3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -75,7 +75,7 @@ typedef struct S1Translate {
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                 vaddr address,
-                                MMUAccessType access_type,
+                                MMUAccessType access_type, MemOp memop,
                                 GetPhysAddrResult *result,
                                 ARMMMUFaultInfo *fi);
 
@@ -3313,7 +3313,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
 
-    ret = get_phys_addr_nogpc(env, ptw, address, access_type, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, address, access_type, 0, result, fi);
 
     /* If S1 fails, return early.  */
     if (ret) {
@@ -3339,7 +3339,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type, 0, result, fi);
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
@@ -3406,7 +3406,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                       vaddr address,
-                                      MMUAccessType access_type,
+                                      MMUAccessType access_type, MemOp memop,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
 {
@@ -3547,7 +3547,8 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
-    if (get_phys_addr_nogpc(env, ptw, address, access_type, result, fi)) {
+    if (get_phys_addr_nogpc(env, ptw, address, access_type,
+                            memop, result, fi)) {
         return true;
     }
     if (!granule_protection_check(env, result->f.phys_addr,
@@ -3568,7 +3569,8 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
         .in_mmu_idx = mmu_idx,
         .in_space = space,
     };
-    return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
+    return get_phys_addr_nogpc(env, &ptw, address, access_type,
+                               memop, result, fi);
 }
 
 bool get_phys_addr(CPUARMState *env, vaddr address,
-- 
2.43.0


