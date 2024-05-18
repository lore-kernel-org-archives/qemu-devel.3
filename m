Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF86C25B79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQP-0006Lp-Kc; Sat, 18 May 2024 05:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQJ-0006Ip-O4; Sat, 18 May 2024 05:32:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQI-0005hn-31; Sat, 18 May 2024 05:32:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1edc696df2bso36166445ad.0; 
 Sat, 18 May 2024 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024732; x=1716629532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91uP2jL5cMpjHFlYh8Ox6n/w/HTZkVs7U55uKl7yZTo=;
 b=hpox4f4R6Dzt7QZRpHQt5KwYWw0Yjmle06wDlkBYHj94HbLSz5bYryPmZmMjYoPbo4
 R5bIFBm/m3ppwnKPTiKgeGJSx0kPwOyXclw9DMTlB9XqtPL/bl5g8+SDoIcIjMvnbu5c
 Cr02fc9DdUhRekVYioDEjiqh7N0YaLR26ikt5y8Zy+vVu5z/tVXrKBL7A+zRoIGh7yyt
 rW1Y3YxWKut6RLEb3RHHAN1kTEMbCde/LgJ1U2PqerCXJ+GQCCCPGAoOOeTcjYnivTLj
 rd/ahlvdH9axkq+0J+ehdvxwTzTJQrnlLDp1tVWBxWi2ixMuucvS7f4cp9LYOLGPkk5m
 jLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024732; x=1716629532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91uP2jL5cMpjHFlYh8Ox6n/w/HTZkVs7U55uKl7yZTo=;
 b=ZFf5bI8cfp9zXedpDt4Yk7Y2emm2q5khl1Vh3TMc3SWgpore0bIGBgbOVUOjELZ8kl
 6BOsnCcDbg8uYHz1YORLtihqLzgmF/TFph3FTWAUEB9mWOrk5y3TjtKdEln+9ao5gxcD
 nClzn+8PQ1P41M/GXI0feZSfFG7FUvAQ1YGpPnrmZSn36bHhSZhr9qqyAsd/Q2WXjglY
 QgWQ4Evf/ltcjWPHE7oiGC9Um2lhl40kvQBOeJyQ58aNi4L7VN4GeJBSHPlpXU3bNi9m
 D7JEM2FkXFFtUArmtSpkiNcxaQ01d6fYVh7tfkwio18+UzdsivYR93lMQmbZjaTCVovR
 ZIHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4/SJnnoAMsHoZRCeH8zu5qyeHtz+58rbTRCzDNzloGLIHHbrb9bmn/qGi5l5kRyA6RH69vnYSz6I0bya5EPsDEZpTE+U=
X-Gm-Message-State: AOJu0Yws9dTO0KqzbR+1gMkB750EGn5Fs7S6R6IWFS8NeWPZM6YtSezJ
 mfnrwnG4XNdpmArcJKEinGTRFqIwnlE+x6GznkNq4JsHglQF+Abm8GfJXA==
X-Google-Smtp-Source: AGHT+IF4deljv39U6EykMVVdrFzAfsIpOdo8//6tfvN0VJT4Jxq/QUCWHurUIXVF7QoYYMfZumS5gg==
X-Received: by 2002:a05:6a20:394f:b0:1af:cea1:7ea5 with SMTP id
 adf61e73a8af0-1afde1d9183mr27619667637.57.1716024732002; 
 Sat, 18 May 2024 02:32:12 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 01/14] target/ppc: larx/stcx generation need only apply
 DEF_MEMOP() once
Date: Sat, 18 May 2024 19:31:43 +1000
Message-ID: <20240518093157.407144-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use DEF_MEMOP() consistently in larx and stcx. generation, and apply it
once when it's used rather than where the macros are expanded, to reduce
typing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a8fd6ef3ae..0882fe2fd2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2913,7 +2913,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
 
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
+    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve, t0);
     tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
@@ -2926,9 +2926,9 @@ static void gen_##name(DisasContext *ctx)  \
 }
 
 /* lwarx */
-LARX(lbarx, DEF_MEMOP(MO_UB))
-LARX(lharx, DEF_MEMOP(MO_UW))
-LARX(lwarx, DEF_MEMOP(MO_UL))
+LARX(lbarx, MO_UB)
+LARX(lharx, MO_UW)
+LARX(lwarx, MO_UL)
 
 static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
                                       TCGv EA, TCGCond cond, int addend)
@@ -3173,15 +3173,15 @@ static void gen_##name(DisasContext *ctx)  \
     gen_conditional_store(ctx, memop);     \
 }
 
-STCX(stbcx_, DEF_MEMOP(MO_UB))
-STCX(sthcx_, DEF_MEMOP(MO_UW))
-STCX(stwcx_, DEF_MEMOP(MO_UL))
+STCX(stbcx_, MO_UB)
+STCX(sthcx_, MO_UW)
+STCX(stwcx_, MO_UL)
 
 #if defined(TARGET_PPC64)
 /* ldarx */
-LARX(ldarx, DEF_MEMOP(MO_UQ))
+LARX(ldarx, MO_UQ)
 /* stdcx. */
-STCX(stdcx_, DEF_MEMOP(MO_UQ))
+STCX(stdcx_, MO_UQ)
 
 /* lqarx */
 static void gen_lqarx(DisasContext *ctx)
-- 
2.43.0


