Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC28C5AE59
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoU-00028g-Oe; Sun, 25 May 2025 12:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDoA-0001sn-UP
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo9-00038c-99
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso11186115e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188959; x=1748793759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3z8i6F7kymnU0LwN0DeHuQEwxf48sA9XDGghzhBVGcM=;
 b=H5oJLQSW84F/cOfyoi32qJShah4CT1j/orWF5NtpZHRBSOgV4z5Ag3SNOhWvGjYaaL
 uAL6xEVtPdL7OYuyTEkqyVLmbYJQQMcnaQlYmCYcm8r7MJ616zNeBf5TSxN8qHzHveLi
 VZ3y0ycY6mOdJpkeb2yojo2wFRtTMjHx1R1Maa24GAW/B2k7Fo9Ls/ag/nhZAwRDn1Z/
 P8F4qvVcuBk7i0AM82cGTqzbdoJST2YaIGt7wX2i/4C6YHio3oGaFoUtxd9MrOiVtynV
 UEDZafLIOBmwI9HRqJ3OFp6DKNjW5t+gCVb/Iyr1BRRKOKntvkcXCiZ0LUXvXdvGwM2q
 t7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188959; x=1748793759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3z8i6F7kymnU0LwN0DeHuQEwxf48sA9XDGghzhBVGcM=;
 b=NEdb+2lqGybi05LBoH+iy9qUUeqORs9APhQNaxiX6H/rxPGJkp5FWnJQKemkPIYVVT
 o9pzbkYMQPmuyKvfd8UVj3/37tmDvDQ+k/rA/1Kr5vJyQITRcG/CLmqASSO2/EF5migb
 xJQZev/YCWBV6WLpbaEy/taQJK+cb7KoDxUIhiMZHILjEoU2b3S98XpSr5Zpb5NSTxGT
 C1Wus9LFzdL1csEaLyND1zZ1MfxP42ZCHqwsWlgbvuersZAVLEWreA0XlW4BJGY8fVsg
 vR9OTTDgbC56o1MYmpGt9btCmcDc5OSLXWK3wsEF4CX1MDoOEorJG/NQpHUVZRf+E0wT
 NUuw==
X-Gm-Message-State: AOJu0YzDvBf09Go/sGWvnhIXlKYZkJbzM3XHzo98D5qGHybcEL/HlIVQ
 mquW/i/5XeRQSiASNvqLJHKlnXFu2VwX28Lx7UgPT2dfOrUDNTROUyWW0/8ULzm7CMAjhYWLsB2
 uVJ52VFs=
X-Gm-Gg: ASbGncsMW9V4EYNZgE5VTq7AsiH98VQ3qLj/Sg/LzOc+IugSCobJigxvZ1cwQlAg0T1
 mG0oxrDT0PD5Qx3kdgCFnYdmecb4gtIY8FurLH33/lSmbL0Fi0DC+cxDJshrYfXNxKMWaLQsmmI
 bO/uxT+k258jtIIzwg/1g8+4xxtTdJYEh2+kU28orIPNgtR7HiKojwcwrh3GzlWJXCZ3Jz6QH/i
 1oLIe2H1IPqmoQStPVGxp7i4Ml9mIf6HVAfWfiWY2JxbfbGrseINTJgSwVbudqLk2+T1TVXzkJV
 a5ap47mcC1dDb356/1T16eFduWsWI7ZSAg0RjVOtpsseiTUOuro2WORi
X-Google-Smtp-Source: AGHT+IFocV0yokKkb0W9gKPEx0CGAgb2fOO25aufHGjMixHEOswguxserhXcAHksHxSaYST8S3HK3A==
X-Received: by 2002:a05:600c:1f18:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-44c935dd80dmr51511815e9.9.1748188959528; 
 Sun, 25 May 2025 09:02:39 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 09/10] target/microblaze: Drop DisasContext.r0
Date: Sun, 25 May 2025 17:02:19 +0100
Message-ID: <20250525160220.222154-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

Return a constant 0 from reg_for_read, and a new
temporary from reg_for_write.

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


