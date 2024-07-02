Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C5BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnDU-0002BZ-0u; Tue, 02 Jul 2024 19:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDN-00024i-M3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:14 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDK-0007Vt-IA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:13 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7180308e90bso2780086a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719964025; x=1720568825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaC3T2BfYoaBDwnO5rCCvOq9J0+P8XOAD1K7mnYvbhs=;
 b=kzycDzh4Eqcw22cRXv0pdQsHB9mrzcLcRKXMVV04WYQn6HVSVchBJfWfbjSD4FeHqN
 6gkvPt5o8c/MbrOHnve1bOnLgzNcWNV4knn0RdWmq3hYIWxflm7Gjjej15n9GLn3I3J5
 2Hyv2KJHarKXAQuerH2g0wwPPHjSxU0wsvwsl/1yaDAa9e1r96C+xqTCY96HMcmm5b9Z
 k2+Isc8ML9JTi1rL9c/esPv12g/Zu37ROCHLBQ8uan/6OkLLhykba0SkAG9SByNViowM
 eLcZVbSF3Nd83lUgCTSk52Qd3TRW8kRWAn72kiMEHh92Fu99YA31ZVlHq4UL+yrHBe9D
 AQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964025; x=1720568825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaC3T2BfYoaBDwnO5rCCvOq9J0+P8XOAD1K7mnYvbhs=;
 b=N52G/bkrbG+2YZG5ilABoA9Nvi2CDbe1AilXDPpFcYAtQKtr+Omq+BPXf7gTMKe9xh
 XgWR2wLO1204+VnDIRgbcOJ0sMnd0q19jKYx6EZdn8e8l6YpSbg4JmV7XVEEjPvJ/BiG
 IUwi4B7ZLY2uSfpJgajyTGXPj7+gfqWnhrk4gac0LLIISiyQJbdIpabWhORXu7ZV8SKV
 rBCC29MXm2RMomuD1+HB5B4HABCP2Iu71j5J9FZp7wZGX1ryaQoxiDH+c6JU7WibYcNT
 qsS7DPRrGPyjm6LQkTr2Zi7wdaA/XY3Ds4aaUQPhCRuiQ0ELRbP9oQdYC6QYKuXkZlA8
 QmLg==
X-Gm-Message-State: AOJu0YwwaYRN15SaBP3T/brfacYiIfdIItz+qLFVZn0mrE4jUzKGPd1X
 ipKAa943BzUY5qUWvRQwDBPd/rCYYZn21KgjmNkQvnQIHLFt632oYpg2hZ+VBLtJ0F/PjdrPQLG
 q
X-Google-Smtp-Source: AGHT+IF7pTxdLS7MTob45+/IP0vx6CVNWkAWFL8R0Kkhu1e8Lo8pXNtNCUEenvT77mSp+Xn+CtMXwg==
X-Received: by 2002:a05:6a21:6d87:b0:1be:c0c9:5fa7 with SMTP id
 adf61e73a8af0-1bef6103c73mr9133794637.15.1719964025420; 
 Tue, 02 Jul 2024 16:47:05 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535e62sm90147045ad.154.2024.07.02.16.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:47:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	balaton@eik.bme.hu
Subject: [PATCH 4/4] target/ppc: Merge helper_{dcbz,dcbzep}
Date: Tue,  2 Jul 2024 16:46:59 -0700
Message-Id: <20240702234659.2106870-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702234659.2106870-1-richard.henderson@linaro.org>
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Merge the two and pass the mmu_idx directly from translation.
Swap the argument order in dcbz_common to avoid extra swaps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  3 +--
 target/ppc/mem_helper.c | 14 ++++----------
 target/ppc/translate.c  |  4 ++--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index afc56855ff..4fa089cbf9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -46,8 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(lsw, void, env, tl, i32, i32)
 DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
-DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
 #ifdef TARGET_PPC64
 DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
 #endif
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index d4957efd6e..24bae3b80c 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -271,7 +271,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
 }
 
 static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
+                        int mmu_idx, int dcbz_size, uintptr_t retaddr)
 {
     target_ulong mask = ~(target_ulong)(dcbz_size - 1);
     void *haddr;
@@ -296,15 +296,9 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr)
+void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
 {
-    dcbz_common(env, addr, env->dcache_line_size,
-                ppc_env_mmu_index(env, false), GETPC());
-}
-
-void helper_dcbzep(CPUPPCState *env, target_ulong addr)
-{
-    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
+    dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
 }
 
 #ifdef TARGET_PPC64
@@ -320,7 +314,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
         dcbz_size = 32;
     }
 
-    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+    dcbz_common(env, addr, ppc_env_mmu_index(env, false), dcbz_size, GETPC());
 }
 #endif
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2664c94522..285734065b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4458,7 +4458,7 @@ static void gen_dcbz(DisasContext *ctx)
     }
 #endif
 
-    gen_helper_dcbz(tcg_env, tcgv_addr);
+    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(ctx->mem_idx));
 }
 
 /* dcbzep */
@@ -4468,7 +4468,7 @@ static void gen_dcbzep(DisasContext *ctx)
 
     gen_set_access_type(ctx, ACCESS_CACHE);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbzep(tcg_env, tcgv_addr);
+    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(PPC_TLB_EPID_STORE));
 }
 
 /* dst / dstt */
-- 
2.34.1


