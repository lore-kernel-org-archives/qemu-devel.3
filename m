Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF84C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGl-0000f8-Lr; Tue, 09 Apr 2024 15:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGj-0000eW-Nx
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGi-0004fx-8Z
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e0bfc42783so51977105ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691391; x=1713296191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPbK/NhQe1+jKC23+AkIKSjI/CWiYdFRaJAq7oh1b28=;
 b=eQig0s/CPdmF+V+aC0/7ks4SFPAW4XFCi805/nVCH9GAZBb59ySEplKPKObIotCc7d
 VEy2DNzyOZ08E0L1YejANirDtzM4LXzESRcpjtruG+pLeU4Cj1HAhRv7wn9UvUicvTG7
 agKLa2iBkwYGl0FVwTKPGD0ircy5PewGmQZhLALXAkLkgd1xxQ2SwNsXGEn5axJyJoxO
 fnXWlZugjBZaLPy6hYrtLvLyosItoPd0E1Ogp1TZt2vuIaymp70HTjenpSIW+7qstS7B
 oPurHvKykLbu7ezDxg4DotDmMuLwpb3OFgs4VTq22wUkAMHVd9yPSlhFi0XDFPwUJdLf
 7bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691391; x=1713296191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPbK/NhQe1+jKC23+AkIKSjI/CWiYdFRaJAq7oh1b28=;
 b=Zz5WzBWFJm7NGFOKewk5adTIxW1x+Z8KlfVwd6nIpual3/2WWxL1sUKEuDxeMknqm2
 lAbxV13a5xnWAn1arKFpjzMuMJGB55ZsWibGmyc3umgJUepzuRtPu2pOcZOhpA+F99wn
 hDx/ogxfzDdT5mEBQB0ZfQAjgy2DOBrULnqg7Rbs5v9UvAX9KzVf2eKLw+PHMx87+bwl
 O9Se01yViLSdHfWIXCMhM7L8T9okzcnmPdF/tlL71MuM9TkQDiLZaCypZnqyIiwsjn1B
 d6yO/5WgMYbAG79Rgl2+xgUiXEMC4yfYqYvrJVckTm5F77A/m/aSizPPHeFsN2HsOzRh
 pTgg==
X-Gm-Message-State: AOJu0YwYrOGZzpZVpWTdukbpLa6+vXKuna0aKHRAqC8mz11b+ppNBCo5
 S6omokRAKsbqdxzUXb+I+D3fXZ9beSSY6wdr4r8SqZXPaP2exk5DHrucEYIcoDl0yX+UrNlcwLc
 X
X-Google-Smtp-Source: AGHT+IGzNg9FPa/e7XoCjMuuZEaniikZW7yXxFO7/tW5tX0hvs2ROnXQV5q18k+SOEkxPCEuwnenoA==
X-Received: by 2002:a17:902:eb8f:b0:1e2:b8fc:745e with SMTP id
 q15-20020a170902eb8f00b001e2b8fc745emr942414plg.8.1712691390747; 
 Tue, 09 Apr 2024 12:36:30 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 17/20] target/riscv: Use insn_start from DisasContextBase
Date: Tue,  9 Apr 2024 09:36:00 -1000
Message-Id: <20240409193603.1703216-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9d57089fcc..9ff09ebdb6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -115,8 +115,7 @@ typedef struct DisasContext {
     bool itrigger;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
-    /* TCG of the current insn_start */
-    TCGOp *insn_start;
+    bool insn_start_updated;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -207,9 +206,9 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 
 static void decode_save_opc(DisasContext *ctx)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 1, ctx->opcode);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
 }
 
 static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
@@ -1224,7 +1223,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     tcg_gen_insn_start(pc_next, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.34.1


