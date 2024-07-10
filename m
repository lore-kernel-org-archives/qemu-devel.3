Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A131C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0X-0000nf-LJ; Tue, 09 Jul 2024 23:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0V-0000cp-9g
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:39 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0J-0003nB-Qk
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:39 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d6301e7279so3819774b6e.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582105; x=1721186905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8t94LsejldqmNfhg1NCwYzoxnTmvwOZ4iKKvyvaKHa0=;
 b=ie7K0hB1o9cGw3Pr5fX7Y4XBK8FCFBu/1DR82GfZ2RBt4EMb32zIh/vjPanOuyhyjX
 XlRPlaLkgAbhL+1NTGBGYgOiux+dJUkbQdfFPbNM/8+gAsJgMlc0TP5diGq9/WOVJVKv
 ogf86Y0BtQluNNc8ZFTqF07JweVUQP0oclZ2Ete0W/Lg6K/bnOmwljQKFxfZ76YGnnsH
 nowe/pIbiVEnJrqdRPqQk4m/+GIBsxE0ukzoJv10lg1F7zPgcjOKG77UnTQQ/ajAv1BG
 qszSG6I94hKwKsueeJ5eBuxoF7p4WVimrG130M8I2Uwd1pWDfS0NHCVgoVmxbZ+iQxnq
 xIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582105; x=1721186905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8t94LsejldqmNfhg1NCwYzoxnTmvwOZ4iKKvyvaKHa0=;
 b=iB6AgsscLJTHFMNVY2ODea0q/6XJHtlMaH7GOT+H5tFxBDHc4raWLm0xY23HmjJ+Qv
 JbBYSKs6XOaVhgHo9oLWDUH6kibdVsqi6XINCjk0DtMWWcESZ1bUoi7LfOLiSX3NzyyI
 FZBrL+ByOrdNKcwHhJhH2P7IuKZuByFBebW/Yz4qATefqOSutsmyh6jKAktkZxgmYsYx
 U+ndR8Qw00pa7kk33YD84LtuhQwGKM2hGhY6dAh8Zo8e3vg7jndWMZtfdr9T86+7o4G3
 obA7/VaElLQfd84F1SxwRnHNtvcaDaBEVHntGfNtcdmVQbQ8JgulhZ+z3qmug7nVIbod
 6p5g==
X-Gm-Message-State: AOJu0YyyAAPJml63CgFveaAcSWX+yzPlfj3mRUNtCdb7/PXr8hVE4L0t
 3VUGFapGWauabm+9avQE18+bq2UVmqR6Up2uFS6QSaFzzCIJZzlixON71VBQcJ6h3QwCM75agC5
 HygE=
X-Google-Smtp-Source: AGHT+IF5xlE1Zdp/y7Msj1BWwchXEEm0fbtfsZsXSTKThUxSA7qK94eMWrLjYqyh6y7V8z1f/lWu0g==
X-Received: by 2002:a05:6808:1312:b0:3d9:243a:7ae8 with SMTP id
 5614622812f47-3d93c08c8cfmr4333386b6e.39.1720582104075; 
 Tue, 09 Jul 2024 20:28:24 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 08/13] target/ppc: Merge helper_{dcbz,dcbzep}
Date: Tue,  9 Jul 2024 20:28:09 -0700
Message-ID: <20240710032814.104643-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
2.43.0


