Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCE7C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZH-0001Q1-Co; Thu, 23 May 2024 19:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZ7-0000RF-4d; Thu, 23 May 2024 19:09:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYx-0005oD-HR; Thu, 23 May 2024 19:09:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8e819a540so346324b3a.0; 
 Thu, 23 May 2024 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505763; x=1717110563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqUaQGSgYMin+3lQdQKQjhzEKnE4NEk8qBGjnn1PYKA=;
 b=Iek1cShXx8fQWZyva8d7PXuwpImVm1S9YRy7dwyNufzgVSWvpdFUZ6A3dU5gDN2trO
 ENdeDmsVMnlEXITDSCEEPzsXs5+IJbDQdll9NarlCJkBVrGcM0DvQv/tS3ATFZq0H90+
 4TZ6YQVbxPeisW8wLSq9+zPrijaZVcfgCtPAU/Tbp+S6hDvx7rsWfHxapW+hvNAJFzhD
 LTBP7EfKZWcCLLnbUnlDFB/MK7w/OtBjtbibU2CLi2FF3N/fwWyL2GAEG8Ymv3cwmK0S
 sRzFThi/12Nd6FUVGcjrKedpx6Ycp/U3bksFdlpyAF8cRe7q8BKdm75T5xyFNuq07g4h
 a7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505763; x=1717110563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqUaQGSgYMin+3lQdQKQjhzEKnE4NEk8qBGjnn1PYKA=;
 b=Ps1NK7xJuQu93BGbg6ebLDrv8SplDGFxAVZEclBepyh/lsoGAwFC0h4sexdKqkJ4Jg
 zxIspXN4yflsuDSMic9+sW9VvHOCxXWMo6oQCI1U4wgDf2+qldki4/Wtoo8ZiYfwpRn7
 N9jDnLa0xrvX3/gmuP6ldXyf48bSSfS0E204MpA820g5ekE5z/XeIIU9eaP6ws42evAa
 lbG/QqgrX+jAtY/dPCoyz0pnCWUlk8kClohu+tEiKLQxuCs48vL2bupxYZ5j16P59cWx
 clMDkOae3f43bxSP+k9nS9DxFtreR3dnuXV72ZM0pE4r1rinbEQzQntrN3ZLLHEhKgaa
 p/DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrF5lWFepCpR27O+FNxNIiShqfeCQ8Scmefg4Oxxxy9FChNH0Ji5Ajeqhs7OK6MrIfRKCN0+SfEhmdpWsNNSzAPRD7
X-Gm-Message-State: AOJu0YyoJ1NsBG5ZK0bBWarwCqRUO040QN8HqOa83i1E9HlCGzX3X6z9
 rYS5wg4XhVSKw7wklVGOzKjS2eM7e+ArFugidmYZHA9aZV8WzCHVP3gxKA==
X-Google-Smtp-Source: AGHT+IFDzZkKj+s0I/96qv3ijwwOjdAXP3lWyEr4ZKFH45atYFLnrpUpo6MLvXzxJCdmPMqFW9ntuA==
X-Received: by 2002:a05:6a21:1f28:b0:1a3:e2c4:956e with SMTP id
 adf61e73a8af0-1b212d1d3c4mr839170637.25.1716505762969; 
 Thu, 23 May 2024 16:09:22 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/72] target/ppc: Remove redundant MEMOP_GET_SIZE macro
Date: Fri, 24 May 2024 09:07:00 +1000
Message-ID: <20240523230747.45703-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 6c103dafe0..cf42dfcc9d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2840,8 +2840,6 @@ static void gen_isync(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-#define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))
-
 static void gen_load_locked(DisasContext *ctx, MemOp memop)
 {
     TCGv gpr = cpu_gpr[rD(ctx->opcode)];
@@ -2874,7 +2872,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     TCGv u = tcg_temp_new();
 
     tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
-    tcg_gen_addi_tl(t2, EA, MEMOP_GET_SIZE(memop));
+    tcg_gen_addi_tl(t2, EA, memop_size(memop));
     tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
     tcg_gen_addi_tl(u, t, addend);
 
@@ -2884,7 +2882,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
 
     /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
-    tcg_gen_movi_tl(u, 1 << (MEMOP_GET_SIZE(memop) * 8 - 1));
+    tcg_gen_movi_tl(u, 1 << (memop_size(memop) * 8 - 1));
     tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t, u);
 }
 
@@ -3046,7 +3044,7 @@ static void gen_st_atomic(DisasContext *ctx, MemOp memop)
             TCGv ea_plus_s = tcg_temp_new();
 
             tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
-            tcg_gen_addi_tl(ea_plus_s, EA, MEMOP_GET_SIZE(memop));
+            tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
             tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
             tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
             tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
-- 
2.43.0


