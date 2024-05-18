Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF848C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQP-0006Lo-HE; Sat, 18 May 2024 05:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQN-0006KU-22; Sat, 18 May 2024 05:32:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQL-0005kP-Ez; Sat, 18 May 2024 05:32:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1edf506b216so31078635ad.2; 
 Sat, 18 May 2024 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024735; x=1716629535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/DkuaTx6S9bv21jsAgT9nwS8XQdb1YTrH6xUMOIF84w=;
 b=ReNrKZwT9djcc02Pr6o5bbGL2IDE8OZdgpIeqwvZoXlktE1kbHDqxoj7BHEa6qq+ad
 PrpOwWQWws0SB0PP9CEV24A+thv4PsE9coVZV3ZvMs6nNTG5z+a9uN9q43s29F3iIQLx
 9o5/hKfw9hc7Nhy0ZibM2zj+wDdPX0LSe0HyJI5aLShufSTeY9icRIfNApel3tCFljRs
 3prQsNcYpD91sj0NojM7HeADGI/rhcBXU7X5bQV+GcOGZN++yMU8xUgm4wFgQMpRyahz
 tp9C6TVp0sgti5t7josonXYdTnNWUsZgig4YlNq179Gw3gJXTH2XGYCXAPj2e4JeyyO+
 9FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024735; x=1716629535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DkuaTx6S9bv21jsAgT9nwS8XQdb1YTrH6xUMOIF84w=;
 b=YIRS3w81Cdu+8EFyA6b00cPo7vkwdw+6eUyVF4w+ybyVfIL2fPpV3dOV0QzIEr1q7F
 e6OilV9BUBj5zaZ5sfC2+jOlBa6kQXrCb25xu0Wh26ux9+tN0oLXw0f3wX0rQ2J7bYVl
 yMR8TIo2Bqha7yraQFCJiTXJ1cHaLRSausAeQ+2DbDRmd9pfrGSmzN75iiFC5mqP2wES
 36Bk1MTx9wR864hFhvCAVxQum3ldOPQ+cYItSO2BzYZXIZtOK2S4QYje4H2XWMHbGRXJ
 4USnR7u3g3J1sC5exXbjdF14SI267KwGhCrQ+bS3W48jsvTQjHsEEYVhDglIgtepg7IV
 XzLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+SYZZkKd4/oJSZau/4uPQePW+hYhOQiBGMUGCYCxEqtILAZYOdsxefkG6CU6TXnfEe43mQphKDd8dRWgSKpsXjSuy2pY=
X-Gm-Message-State: AOJu0YwLNwpsvd0SUXJha732vBEWUIIZm8oxjBgcEwq/ashtMliwb6PO
 FB358BFfK8q0SOOqiHuFIA5QKnUjUcNdcFOnCAfslyltuVP6HDr1wOYMmg==
X-Google-Smtp-Source: AGHT+IElv1wAahrvZxYGUKpEQsiAvx8JKDwHaPbxJ3oq1Uqmyi5zG7HI4+todDG+rDhZWw45Wfp35g==
X-Received: by 2002:a05:6a20:7fa6:b0:1ad:7ff5:cb38 with SMTP id
 adf61e73a8af0-1afde238da3mr26284409637.60.1716024735166; 
 Sat, 18 May 2024 02:32:15 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 02/14] target/ppc: Remove redundant MEMOP_GET_SIZE macro
Date: Sat, 18 May 2024 19:31:44 +1000
Message-ID: <20240518093157.407144-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

There is a memop_size() function for this.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0882fe2fd2..cf2404330b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2904,8 +2904,6 @@ static void gen_isync(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-#define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))
-
 static void gen_load_locked(DisasContext *ctx, MemOp memop)
 {
     TCGv gpr = cpu_gpr[rD(ctx->opcode)];
@@ -2938,7 +2936,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     TCGv u = tcg_temp_new();
 
     tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
-    tcg_gen_addi_tl(t2, EA, MEMOP_GET_SIZE(memop));
+    tcg_gen_addi_tl(t2, EA, memop_size(memop));
     tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
     tcg_gen_addi_tl(u, t, addend);
 
@@ -2948,7 +2946,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
 
     /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
-    tcg_gen_movi_tl(u, 1 << (MEMOP_GET_SIZE(memop) * 8 - 1));
+    tcg_gen_movi_tl(u, 1 << (memop_size(memop) * 8 - 1));
     tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t, u);
 }
 
@@ -3110,7 +3108,7 @@ static void gen_st_atomic(DisasContext *ctx, MemOp memop)
             TCGv ea_plus_s = tcg_temp_new();
 
             tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
-            tcg_gen_addi_tl(ea_plus_s, EA, MEMOP_GET_SIZE(memop));
+            tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
             tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
             tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
             tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
-- 
2.43.0


