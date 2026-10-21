Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9F606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jP7eBVvx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIV-0000XP-4n; Wed, 21 Oct 2026 10:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGt-0006fh-7N
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGo-0002aM-Tp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso816824f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592781; x=1793197581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PhmTY6SzYbdQKcWgUA4HvjqnFrSbrYvSqh70eBxbYSU=;
 b=jP7eBVvxQ4ONvyKhnOgjYodEkSrTk1FnEOC7GqU/mPLE/DOXmgg1M4R7wQmxMjujia
 jaMPYFpWRsMcxUBoUXTsTnl+3KOUdKVudXE9Zzk3Db3SdqDRMLnvyjq9RX32CNXHH+59
 RKLw2SOipkqQkSq4zktrsi59B8UzcmizK8ESlsdKPyj25YUNNLlXaUA/5EWPNPdTaPTe
 JYpt7y6Kos9shbuKLz9G8mm9gObv2mjX2wkb8SLzT0Cly70K8insTA1mhNYcu3rImt0N
 ichrnH82xOEzRIm0iNlp4/98gEk49PpaDr1ePCkMQlpe1PDkJPWsCE5fh4ugf5bGmtJ9
 X+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592781; x=1793197581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PhmTY6SzYbdQKcWgUA4HvjqnFrSbrYvSqh70eBxbYSU=;
 b=r3vElwR/dG4HoXAUl1Lg0T2byJ4ryKJRaZ1ijIWqa8udqMfzc4PtjuQ1U/pxkkdoER
 GkJOMjk24xU+Lb0WmyCoj52oLfU+tar0U4FcQaHuhOnBinlbmF6GOPSykioBwSMH7YMY
 G5UxwMlOpG2NwvdgoC8k0oVcJaKAJiG13HcJDDwS6CwaB58mutBuIXQOZ8K5bQpQipHp
 iYzCoTtAdM2nL/MrOIlU4js0WALAeRsIRUy5m+YuXSeaMlx32tqYSHDdQZyED/ynXSXL
 qAv/ffflXxuHufohfNnImRSohmJphJHp5e8htUe61OQLKbKQ0ZNyfJ40I+u1zetm9dGh
 2mGQ==
X-Gm-Message-State: AFq9FYJQIw1wu3ychKmbf+HoiWi1MOxcEmTfPV/eiBc60mi/LAZQlM00
 OxA6gd9KRP7+wm91tFbPZY2+/OAQoO4bGN0iqxBqYT/YTBy/Lhou5PKKcmbKzFdCuvUjwCn9jbF
 ozEo1irI=
X-Gm-Gg: AYBFou2R5ocxn2h7YHMTQwaXWGCkfCXAVm+QLx/6ORBlqvC2n2GTwPdtkogwBTaJtID
 Sp6JLiycnK+S0PAa32L/gdhbl73bu/DlK/tt7SSpnwc6CL9Soh7wULWKW2CsbdozcJwtbCgKHlo
 puW+nmu2Hkf3mWfbItjfRCfWdyrfwTqOxR+nMyHks7ibaNa/xEiTJDX42ELhITJTJhjLNkxzarX
 3xaSpkpVQYWjARIZAWxu7G2CiCYAWgOuRzbBbC+w0yr/iZJGbfVqbGD+Qd98Oldc+lTBfXTsPIc
 0pJaHef2CZyuB/nQcmrjlpmqeG8tcdueOiSzSd9/i1r1y7Pmu5vbeD1OEYEUVLBH0tjLHErrc9F
 dY+j+CYzyTMmHGA4A7SJGxBg7dh3vDhNVoYXy++PDKlaneYEAVtBYeGeO7SmsrHtWkoVSlnR+g0
 BuHgxL1zBNWduFIFU1iox95FztZgoS9omjXaRc08OAxR7rw8+epgBkyr8FCTe8e9OyBl6wceJh9
 bmVgz/f16WewmMrafXyp4AOfH7k9kmVOiCDQ9G93SivWk0fDfL5zSy/kFABScNl4BtXYfYaHbmJ
 snmVM8TP00H5CpRK8BE9w/smuQc=
X-Received: by 2002:a05:6000:2313:b0:48d:df08:307c with SMTP id
 ffacd0b85a97d-48e264ddf45mr5179717f8f.44.1792592780935; 
 Wed, 21 Oct 2026 07:26:20 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 099/100] tcg: Generic expansion of remaining atomic
 operations
Date: Wed, 21 Oct 2026 16:16:51 +0200
Message-ID: <20261021141652.363109-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

These are done in bulk because of existing macro magic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  80 +------------
 include/tcg/tcg-op-mem.h     |   2 +-
 include/tcg/tcg-op-def.h.inc |  20 ++++
 tcg/tcg-op-ldst.c            | 211 ++++++++++++++---------------------
 4 files changed, 107 insertions(+), 206 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 06991b9fa3..633be35a93 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -181,89 +181,15 @@ void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
-/* Atomic ops */
-
 void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                      TCGv_i128, TCGArg, MemOp, TCGType);
 void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                         TCGv_i128, TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                 TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                 TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+void tcg_gen_atomic_xchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                   TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_fetch_add_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_add_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_and_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_and_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_or_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_or_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_xor_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_xor_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+void tcg_gen_atomic_fetch_and_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                        TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_add_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_add_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_and_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_and_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_or_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_or_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xor_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xor_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_fetch_and_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_or_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+void tcg_gen_atomic_fetch_or_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                       TCGArg, MemOp, TCGType);
 
 /* Vector ops */
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 935860f144..6533704082 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -67,7 +67,7 @@ tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 #define DEF_ATOMIC2(N, S)                                               \
     QEMU_ARG_NONNULL static inline void                                 \
     N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v, TCGArg i, MemOp m)       \
-    { N##_##S##_chk(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
+    { N##_chk_##S(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
 
 #define DEF_ATOMIC3(N, S)                                               \
     QEMU_ARG_NONNULL static inline void                                 \
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e0ffd0da67..e694f0e38c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -88,3 +88,23 @@ DEF3(xori, TCGV, TCGV, TINT)
 
 DEF7(atomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, TCGType)
 DEF7(nonatomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, TCGType)
+
+DEF6(atomic_xchg_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+
+DEF6(atomic_fetch_add_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_and_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_or_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_smax_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_smin_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_umax_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_umin_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_xor_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+
+DEF6(atomic_add_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_and_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_or_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_smax_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_smin_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_umax_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_umin_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_xor_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 886d632f75..5690bec6bd 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -881,113 +881,97 @@ void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128 retv, TCGTemp *addr,
     tcg_gen_atomic_cmpxchg_int_i128(retv, addr, cmpv, newv, idx, memop);
 }
 
-static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
-                                TCGArg idx, MemOp memop, bool new_val,
-                                void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
+static void do_nonatomic_op(TCGType type, TCGTemp *ret, TCGTemp *addr,
+                            TCGTemp *val, unsigned idx, MemOp memop,
+                            bool new_val,
+                            void (*gen)(TCGType, TCGTemp *,
+                                        TCGTemp *, TCGTemp *))
 {
-    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-    TCGv_i32 t2 = tcg_temp_ebb_new_i32();
+    g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+    g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(type);
 
-    memop = tcg_canonicalize_memop(memop, 0, 0);
+    memop = tcg_canonicalize_memop(memop, type != TCG_TYPE_I32, 0);
 
-    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memop);
-    tcg_gen_ext_i32(t2, val, memop);
-    gen(t2, t1, t2);
-    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memop);
+    tcg_gen_qemu_ld_int(type, t1, addr, idx, memop);
+    tcg_gen_ext(type, t2, val, memop);
+    gen(type, t2, t1, t2);
+    tcg_gen_qemu_st_int(type, t2, addr, idx, memop);
 
-    tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t2);
+    tcg_gen_ext(type, ret, (new_val ? t2 : t1), memop);
 }
 
-static void do_atomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
-                             TCGArg idx, MemOp memop, void * const table[])
+static void do_atomic_op(TCGType type, TCGTemp *ret, TCGTemp *addr,
+                         TCGTemp *val, unsigned idx, MemOp orig_memop,
+                         void * const table[])
 {
-    gen_atomic_op_i32 gen;
-    TCGv_i64 a64;
+    TCGv_i64 a64 = maybe_extend_addr64(addr);
+    MemOp memop = orig_memop;
     MemOpIdx oi;
 
-    memop = tcg_canonicalize_memop(memop, 0, 0);
-
-    gen = table[memop & (MO_SIZE | MO_BSWAP)];
-    tcg_debug_assert(gen != NULL);
-
-    oi = make_memop_idx(memop & ~MO_SIGN, idx);
-    a64 = maybe_extend_addr64(addr);
-    gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
-    maybe_free_addr64(a64);
-
-    if (memop & MO_SIGN) {
-        tcg_gen_ext_i32(ret, ret, memop);
-    }
-}
-
-static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
-                                TCGArg idx, MemOp memop, bool new_val,
-                                void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-    TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-
-    memop = tcg_canonicalize_memop(memop, 1, 0);
-
-    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memop);
-    tcg_gen_ext_i64(t2, val, memop);
-    gen(t2, t1, t2);
-    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memop);
-
-    tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-}
-
-static void do_atomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
-                             TCGArg idx, MemOp memop, void * const table[])
-{
-    memop = tcg_canonicalize_memop(memop, 1, 0);
-
     if ((memop & MO_SIZE) == MO_64) {
-        gen_atomic_op_i64 gen = table[memop & (MO_SIZE | MO_BSWAP)];
+        gen_atomic_op_i64 gen;
 
-        if (gen) {
-            MemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
-            TCGv_i64 a64 = maybe_extend_addr64(addr);
-            gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
-            maybe_free_addr64(a64);
-            return;
+        tcg_debug_assert(type == TCG_TYPE_I64);
+
+        memop = tcg_canonicalize_memop(memop, 1, 0);
+        oi = make_memop_idx(memop & ~MO_SIGN, idx);
+
+        gen = table[memop & (MO_SIZE | MO_BSWAP)];
+        tcg_debug_assert(gen != NULL);
+
+        gen(temp_tcgv_i64(ret), tcg_env, a64,
+            temp_tcgv_i64(val), tcg_constant_i32(oi));
+    } else {
+        g_autoptr(TCGTemp) v32 = NULL;
+        g_autoptr(TCGTemp) r32 = NULL;
+        TCGTemp *ret_orig = ret;
+        gen_atomic_op_i32 gen;
+
+        if (type == TCG_TYPE_I64) {
+            v32 = tcg_temp_new_ebb(TCG_TYPE_I32);
+            r32 = tcg_temp_new_ebb(TCG_TYPE_I32);
+
+            tcg_gen_extrl(v32, val);
+            val = v32;
+            ret = r32;
         }
 
-        gen_helper_exit_atomic(tcg_env);
-        /* Produce a result, so that we have a well-formed opcode stream
-           with respect to uses of the result in the (dead) code following.  */
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        TCGv_i32 v32 = tcg_temp_ebb_new_i32();
-        TCGv_i32 r32 = tcg_temp_ebb_new_i32();
+        memop = tcg_canonicalize_memop(memop, 0, 0);
+        oi = make_memop_idx(memop & ~MO_SIGN, idx);
 
-        tcg_gen_extrl_i64_i32(v32, val);
-        do_atomic_op_i32(r32, addr, v32, idx, memop & ~MO_SIGN, table);
-        tcg_temp_free_i32(v32);
+        gen = table[memop & (MO_SIZE | MO_BSWAP)];
+        tcg_debug_assert(gen != NULL);
 
-        tcg_gen_extu_i32_i64(ret, r32);
-        tcg_temp_free_i32(r32);
+        gen(temp_tcgv_i32(ret), tcg_env, a64,
+            temp_tcgv_i32(val), tcg_constant_i32(oi));
 
         if (memop & MO_SIGN) {
-            tcg_gen_ext_i64(ret, ret, memop);
+            tcg_gen_ext(TCG_TYPE_I32, ret, ret, memop);
+        }
+        if (ret != ret_orig) {
+            if (orig_memop & MO_SIGN) {
+                tcg_gen_exts(ret_orig, ret);
+            } else {
+                tcg_gen_extu(ret_orig, ret);
+            }
         }
     }
+    maybe_free_addr64(a64);
 }
 
 static void do_nonatomic_op_i128(TCGv_i128 ret, TCGTemp *addr, TCGv_i128 val,
                                  TCGArg idx, MemOp memop, bool new_val,
-                                 void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
+                                 void (*gen)(TCGType, TCGTemp *,
+                                             TCGTemp *, TCGTemp *))
 {
     TCGv_i128 t = tcg_temp_ebb_new_i128();
     TCGv_i128 r = tcg_temp_ebb_new_i128();
 
     tcg_gen_qemu_ld_i128_int(r, addr, idx, memop);
-    gen(TCGV128_LOW(t), TCGV128_LOW(r), TCGV128_LOW(val));
-    gen(TCGV128_HIGH(t), TCGV128_HIGH(r), TCGV128_HIGH(val));
+    gen(TCG_TYPE_I64, tcgv_i64_temp(TCGV128_LOW(t)),
+        tcgv_i64_temp(TCGV128_LOW(r)), tcgv_i64_temp(TCGV128_LOW(val)));
+    gen(TCG_TYPE_I64, tcgv_i64_temp(TCGV128_HIGH(t)),
+        tcgv_i64_temp(TCGV128_HIGH(r)), tcgv_i64_temp(TCGV128_HIGH(val)));
     tcg_gen_qemu_st_i128_int(t, addr, idx, memop);
 
     tcg_gen_mov_i128(ret, r);
@@ -1026,33 +1010,21 @@ static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_##NAME##o_le)   \
     WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_##NAME##o_be)   \
 };                                                                      \
-void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
-                                     TCGv_i32 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
+void tcg_gen_atomic_##NAME##_chk(TCGType val_type, TCGTemp *ret,        \
+                                 TCGTemp *addr, TCGTemp *val, unsigned idx, \
+                                 MemOp memop, TCGType addr_type)        \
 {                                                                       \
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);                       \
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));     \
+    tcg_debug_assert(idx < NB_MMU_MODES);                               \
     if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
+        do_atomic_op(val_type, ret, addr, val, idx, memop, table_##NAME); \
     } else {                                                            \
-        do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i32);                        \
+        do_nonatomic_op(val_type, ret, addr, val, idx, memop, NEW,      \
+                        tcg_gen_##OP);                                  \
     }                                                                   \
 }                                                                       \
-void tcg_gen_atomic_##NAME##_i64_chk(TCGv_i64 ret, TCGTemp *addr,       \
-                                     TCGv_i64 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
-{                                                                       \
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);                       \
-    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
-    } else {                                                            \
-        do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i64);                        \
-    }                                                                   \
-}                                                                       \
-void tcg_gen_atomic_##NAME##_i128_chk(TCGv_i128 ret, TCGTemp *addr,     \
+void tcg_gen_atomic_##NAME##_chk_i128(TCGv_i128 ret, TCGTemp *addr,     \
                                       TCGv_i128 val, TCGArg idx,        \
                                       MemOp memop, TCGType addr_type)   \
 {                                                                       \
@@ -1062,7 +1034,7 @@ void tcg_gen_atomic_##NAME##_i128_chk(TCGv_i128 ret, TCGTemp *addr,     \
         do_atomic_op_i128(ret, addr, val, idx, memop, table_##NAME);    \
     } else {                                                            \
         do_nonatomic_op_i128(ret, addr, val, idx, memop, NEW,           \
-                             tcg_gen_##OP##_i64);                       \
+                             tcg_gen_##OP);                             \
     }                                                                   \
 }
 
@@ -1076,30 +1048,18 @@ static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     [MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le,                   \
     [MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be,                   \
 };                                                                      \
-void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
-                                     TCGv_i32 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
+void tcg_gen_atomic_##NAME##_chk(TCGType val_type, TCGTemp *ret,        \
+                                 TCGTemp *addr, TCGTemp *val, unsigned idx, \
+                                 MemOp memop, TCGType addr_type)        \
 {                                                                       \
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);                       \
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));     \
+    tcg_debug_assert(idx < NB_MMU_MODES);                               \
     if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
+        do_atomic_op(val_type, ret, addr, val, idx, memop, table_##NAME); \
     } else {                                                            \
-        do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i32);                        \
-    }                                                                   \
-}                                                                       \
-void tcg_gen_atomic_##NAME##_i64_chk(TCGv_i64 ret, TCGTemp *addr,       \
-                                     TCGv_i64 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
-{                                                                       \
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);                       \
-    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
-    } else {                                                            \
-        do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i64);                        \
+        do_nonatomic_op(val_type, ret, addr, val, idx, memop, NEW,      \
+                        tcg_gen_##OP);                                  \
     }                                                                   \
 }
 
@@ -1121,14 +1081,9 @@ GEN_ATOMIC_HELPER(umin_fetch, umin, 1)
 GEN_ATOMIC_HELPER(smax_fetch, smax, 1)
 GEN_ATOMIC_HELPER(umax_fetch, umax, 1)
 
-static void tcg_gen_mov2_i32(TCGv_i32 r, TCGv_i32 a, TCGv_i32 b)
+static void tcg_gen_mov2(TCGType type, TCGTemp *r, TCGTemp *a, TCGTemp *b)
 {
-    tcg_gen_mov_i32(r, b);
-}
-
-static void tcg_gen_mov2_i64(TCGv_i64 r, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_mov_i64(r, b);
+    tcg_gen_mov(type, r, b);
 }
 
 GEN_ATOMIC_HELPER128(xchg, mov2, 0)
-- 
2.53.0


