Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C578C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGk-0000ef-EV; Tue, 09 Apr 2024 15:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGi-0000dr-B2
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGg-0004fg-Mi
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso49678125ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691389; x=1713296189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cP8jA9GFq1yR+e10bjvG/FkvD/Ggh4PQtWX+MXPzUjs=;
 b=VYwTp0IKCKzfZuD34eB9t0TO0IwCX/KgzvXf3jsqFCgxQJYuLPRsp/dOWKl6j7zWQ+
 ll5RE5ucA0Wcppt+x+gRoKO63O0yblAcPb32FWsIyfSAV2MV1alk2aY1teW+wMugbZnk
 H7L1/r69JwTDhULlc4mft0m7NE3j4E5LpQyZxBcXv3fpLj2BGZHvi9nlbZvp6DHMkuLE
 dDmL9RtJJKbTqIlEbUO931CaT5mqm3j5lThAl0KAc0fMBnXQWZkUPFyeHyTw5xaQW40B
 WdAEfWXxi3R25XTOORLzTZ6tBpA9F74MNihJ33hEm2iA/Id/bvBT7Oo+PgrlNJCgDW0m
 sFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691389; x=1713296189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cP8jA9GFq1yR+e10bjvG/FkvD/Ggh4PQtWX+MXPzUjs=;
 b=stJEXMPpy0oQ7A7PLXTxOLjTfn7XSygzVOEWkcbHqD3F/jzn6HciiLjc764Jg48Ixv
 t0yIqxoo8dS37PAb31vUJtQrsTnSIbooDWoHkCdtm50n+4yswuBs3CWDnjd1aR69JRb9
 a+qJ2T5dBqSLE+gWYk5EQ6JbjlLs94eT8rAkJv011tHgem+QZ9fMbkW/Ax5feRfnAq/5
 lmt2xXxXgHgIohzuSKL7CeaQFoly5YgYTqhz9jB2Y64cs5vvrOvrHD1z5h4mTgNvkaVq
 RIScY4ZEZ11mj7u9FrPd9O7rCLPG9KoxPOxBxwjLDOZzUHTS+H/0syl6hTY/Gq2HfBsI
 XOUw==
X-Gm-Message-State: AOJu0YzwHXmpPBd1rXt9etleBe/sTj7xaFANuEzxFqEeVSlwrYBK4Mxn
 ObgsDuHk6Qb+qI/XhIAQSHeUQIeN7/Z2I0dyZcmQXSwGjJoKnVyWeHHgI0MYLb/ykjlTbdf32ND
 p
X-Google-Smtp-Source: AGHT+IG5yTY7+K4lVPHV3qmRTueHsPBIBQxYo9ROo/KQbr/BIa/QhjJTgi83eq2Xz9Qn3xheYu4XJQ==
X-Received: by 2002:a17:902:a384:b0:1e3:e1e8:bb5 with SMTP id
 x4-20020a170902a38400b001e3e1e80bb5mr720667pla.28.1712691389488; 
 Tue, 09 Apr 2024 12:36:29 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 16/20] target/microblaze: Use insn_start from
 DisasContextBase
Date: Tue,  9 Apr 2024 09:35:59 -1000
Message-Id: <20240409193603.1703216-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4e52ef32db..fc451befae 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -62,9 +62,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const MicroBlazeCPUConfig *cfg;
 
-    /* TCG op of the current insn_start.  */
-    TCGOp *insn_start;
-
     TCGv_i32 r0;
     bool r0_set;
 
@@ -699,14 +696,14 @@ static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 static void record_unaligned_ess(DisasContext *dc, int rd,
                                  MemOp size, bool store)
 {
-    uint32_t iflags = tcg_get_insn_start_param(dc->insn_start, 1);
+    uint32_t iflags = tcg_get_insn_start_param(dc->base.insn_start, 1);
 
     iflags |= ESR_ESS_FLAG;
     iflags |= rd << 5;
     iflags |= store * ESR_S;
     iflags |= (size == MO_32) * ESR_W;
 
-    tcg_set_insn_start_param(dc->insn_start, 1, iflags);
+    tcg_set_insn_start_param(dc->base.insn_start, 1, iflags);
 }
 #endif
 
@@ -1624,7 +1621,6 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
     tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
-    dc->insn_start = tcg_last_op();
 }
 
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
-- 
2.34.1


