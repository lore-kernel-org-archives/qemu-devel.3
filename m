Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EB1C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBwz-0000YP-Hb; Wed, 28 May 2025 04:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvn-0007wk-EC
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvk-0005Fp-O8
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso33409265e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420069; x=1749024869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpxUd17c3m77ey9D/1drD1plUrvJ4iXwsNR9pLccurE=;
 b=dBBZbx8Awrpf0rIIvubizVtTY7VVptc97iVUO9ct2lY55IHJcaBW8XNN1e706vwLwy
 VkeHy67MJHGmqqMcJfZc3sNuMK+1Bl+CY7WhzVxylW++g9HgqYWyriCHWpMKh6XHdCyh
 guTqxlzOaQmCHybCvROXxQG7AT8sE3zO97tY/swfu9xBSDWZFP3G7hGVzqUOFFPd2abE
 Mh8Z8+WdugevH7p92S61PyfJDCtwVvjQFgTakEHiIa8m02L2Y5rbTNUC1G+xougokSsn
 6sC7opVvy+nkj5F7TvPFXptQ1uPx24jcufx9Zr2zBqGqgSROeGJAERVO/mcwePbeRk2d
 LykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420069; x=1749024869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpxUd17c3m77ey9D/1drD1plUrvJ4iXwsNR9pLccurE=;
 b=Weqa1DCl9qZ18M2znhQiEz8M45+c7fsylKp2Jk0jYhmpwp623D2EKFu3okuEZAz6aB
 Sf3D4ZgqBNnXAY/sBWCg/mQSO7aX+BKBgzlgG5rXpZOzUn9NybgTE8BfJodEwKZrqzg8
 IRGv6Zvc7luNaMlki7397ZUlezzFKxQ4pZYYqOc0KdSzTc9Sl4m0CoE5h0DUR/oSykQR
 mbiS5hqLZ6SpYcCA3+nULFu8W8Tz+cGg/I5UMQOSKwj1wChop1gUzQuDpTgW5A0YcAcO
 vlxPvh+VhwEVx+TxjbOmaZf1uVZFyKj0Usxkb64Y9mwsODQ6glOmS25j6VWi5+IZO7hq
 tBlw==
X-Gm-Message-State: AOJu0Yz+jSyBNQPRJ0LSksv1w6a5ZYIj6YSkI5mCtaqSUg1+Jkk2V0fX
 /bC8f+XQEGmC13ZuLLcnYWu3iBAfuEkX+uXsxFN18MYkss8D9ogwQkT7APdLPqnpoH3wZ1SAccP
 BLPobbMCNsQ==
X-Gm-Gg: ASbGnctP11qIxIEPY0pfxGyuyuV+p9nBsOtu0orZMWoLlA2Vw6K6ZSUeSCZM8eNJqED
 Y+3/gLsRUqHLoS0va4eAgPhHRlNZTDLpH66VPO+Uh4sWUrfAoGtWy50VVrKDTBIxwM/Ng0H2qan
 nAxnNJ4K34lq3hC382+SBsQQD+bcOakTwZDXRLJMs4RugPeubOUOl0V/OKaTI5f8SXx9ULFA5W4
 pl2usZFjTOjAattVPlxKHPYZIEqCpy86eVrw1FOpC86mjTaXwz1FM5L36PNVCbSoV4xkCf/bfhY
 DnGyhOhs/OGBq5x2XubqESWk8tVxEZFyhFlniOmwyyP38DGSTUqAEOxjy9RRs/GyDO0=
X-Google-Smtp-Source: AGHT+IEpSh9fNapISHmkVCos9ZhjoYIWbfSdsiJkY+kIV+5oTk2q2kgVFvjrwSwssBRSBHVFQ1NuDg==
X-Received: by 2002:a05:600c:46cb:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-44c919e16a8mr134054495e9.13.1748420069536; 
 Wed, 28 May 2025 01:14:29 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 12/28] target/microblaze: Drop DisasContext.r0
Date: Wed, 28 May 2025 09:13:54 +0100
Message-ID: <20250528081410.157251-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Return a constant 0 from reg_for_read, and a new
temporary from reg_for_write.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index dc597b36e6..047d97e2c5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -63,9 +63,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const MicroBlazeCPUConfig *cfg;
 
-    TCGv_i32 r0;
-    bool r0_set;
-
     /* Decoder.  */
     uint32_t ext_imm;
     unsigned int tb_flags;
@@ -179,14 +176,7 @@ static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
     if (likely(reg != 0)) {
         return cpu_R[reg];
     }
-    if (!dc->r0_set) {
-        if (dc->r0 == NULL) {
-            dc->r0 = tcg_temp_new_i32();
-        }
-        tcg_gen_movi_i32(dc->r0, 0);
-        dc->r0_set = true;
-    }
-    return dc->r0;
+    return tcg_constant_i32(0);
 }
 
 static TCGv_i32 reg_for_write(DisasContext *dc, int reg)
@@ -194,10 +184,7 @@ static TCGv_i32 reg_for_write(DisasContext *dc, int reg)
     if (likely(reg != 0)) {
         return cpu_R[reg];
     }
-    if (dc->r0 == NULL) {
-        dc->r0 = tcg_temp_new_i32();
-    }
-    return dc->r0;
+    return tcg_temp_new_i32();
 }
 
 static bool do_typea(DisasContext *dc, arg_typea *arg, bool side_effects,
@@ -1635,8 +1622,6 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->cfg = &cpu->cfg;
     dc->tb_flags = dc->base.tb->flags;
     dc->ext_imm = dc->base.tb->cs_base;
-    dc->r0 = NULL;
-    dc->r0_set = false;
     dc->mem_index = cpu_mmu_index(cs, false);
     dc->jmp_cond = dc->tb_flags & D_FLAG ? TCG_COND_ALWAYS : TCG_COND_NEVER;
     dc->jmp_dest = -1;
@@ -1675,11 +1660,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         trap_illegal(dc, true);
     }
 
-    if (dc->r0) {
-        dc->r0 = NULL;
-        dc->r0_set = false;
-    }
-
     /* Discard the imm global when its contents cannot be used. */
     if ((dc->tb_flags & ~dc->tb_flags_to_set) & IMM_FLAG) {
         tcg_gen_discard_i32(cpu_imm);
-- 
2.43.0


