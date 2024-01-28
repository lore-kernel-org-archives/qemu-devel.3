Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C78C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0B-0004i2-4z; Sat, 27 Jan 2024 23:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx09-0004hD-PV
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:37 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx04-0004I6-CE
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:37 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-290b1e19101so2168702a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416951; x=1707021751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8stgI+xO0LshRlV+dbOXjfDk9OWAAP8Iuj6nGWfVSvI=;
 b=ZMeBH8qsYJ009dEw2e/IrqW9Za95sgIFtwbsh7LKXgAsEnP3RPIuNIzAM9TU1Csp2m
 YsxAW8hxtbRTGr5VxiaXIPii/wb1eHa2Lb4f4zhbE5ahh5H7O9qXfHAnVSWU2n5xNYHE
 tp+xb4+m9GOUC5EKQsjlCgR7zucKcO/rg4lIOHAV/4YYaCVu81J9WRvByY6a7eeYv0qW
 ELRKRaW9CoCZnmxggguOx6HVGvEKmt7kj016ziKUW4UYYl42EDNql6fqrXp7Ve4Y17F8
 KkeNj89h2Z6MdC/MiVQuMKGQp+IqlBSxKVj/z/oHbXEipl7JtiKtosRXh7K/oSfGs6TZ
 BTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416951; x=1707021751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8stgI+xO0LshRlV+dbOXjfDk9OWAAP8Iuj6nGWfVSvI=;
 b=FBXwDtAJAwx0UxQNY9W5n3IGR8MuSCHA5riR2b67DuZm4QHfxGrEQF+wU7L6pOcolt
 h0zEP24LSRGJKGKIr3II6K5lVJz2Qtv2Vj871iAyy6rljMtXXT64/g9KHTkGkxzUQ2Yp
 E3Fv/yjEtCkvlhttWtv3pyfFX8dw30vjPunlP4eiZQhMlR3CIqbNLpfsyhQEod7LNlz3
 4ic5fWQPPM7N5Tzjxf91NhyIFbTGsIFNad2QimsKJ6JCkfrTXxXsMu4ckwWEuqv7vaC4
 /38s00izH51pUD6vo7KKAZfytPKyv9TnnViiH2rxYaZmKKlqsT/uhjDhcu/IQ2TQucTT
 ASuA==
X-Gm-Message-State: AOJu0YyY7SucVBHOwnD6nM7rEWmorJ+WP87fYzZHjUYRtQlyz/IHB3go
 DLtOPjY3S7znTeDLtUl//V+6mGrRU3sHJCkDsqDCz6aOvJ3BYUTSZKW7Y9102jcbV+FgAam2rGO
 mKSY+Og==
X-Google-Smtp-Source: AGHT+IHoQHbXyGCIWkheEG2gDNNMGuSHWgbKewCc7D7o5WZRtSE7QjNYLJQkbTL2TBAU8cTbastYpg==
X-Received: by 2002:a17:90a:6e4a:b0:290:58a7:1d65 with SMTP id
 s10-20020a17090a6e4a00b0029058a71d65mr2371173pjm.49.1706416951073; 
 Sat, 27 Jan 2024 20:42:31 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 05/33] include/exec: Use vaddr in DisasContextBase for virtual
 addresses
Date: Sun, 28 Jan 2024 14:41:45 +1000
Message-Id: <20240128044213.316480-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

Updates target/ QEMU_LOG macros to use VADDR_PRIx for printing updated
DisasContextBase fields.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-10-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h   |  6 +++---
 target/mips/tcg/translate.h |  3 ++-
 target/hexagon/translate.c  |  3 ++-
 target/m68k/translate.c     |  2 +-
 target/mips/tcg/translate.c | 12 ++++++------
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index b0412ea6b6..51624feb10 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -79,8 +79,8 @@ typedef enum DisasJumpType {
  */
 typedef struct DisasContextBase {
     TranslationBlock *tb;
-    target_ulong pc_first;
-    target_ulong pc_next;
+    vaddr pc_first;
+    vaddr pc_next;
     DisasJumpType is_jmp;
     int num_insns;
     int max_insns;
@@ -235,7 +235,7 @@ void translator_fake_ldb(uint8_t insn8, abi_ptr pc);
  * Translators can use this to enforce the rule that only single-insn
  * translation blocks are allowed to cross page boundaries.
  */
-static inline bool is_same_page(const DisasContextBase *db, target_ulong addr)
+static inline bool is_same_page(const DisasContextBase *db, vaddr addr)
 {
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index cffcfeab8c..93a78b8121 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -202,7 +202,8 @@ extern TCGv bcond;
     do {                                                                      \
         if (MIPS_DEBUG_DISAS) {                                               \
             qemu_log_mask(CPU_LOG_TB_IN_ASM,                                  \
-                          TARGET_FMT_lx ": %08x Invalid %s %03x %03x %03x\n", \
+                          "%016" VADDR_PRIx                                   \
+                          ": %08x Invalid %s %03x %03x %03x\n",               \
                           ctx->base.pc_next, ctx->opcode, op,                 \
                           ctx->opcode >> 26, ctx->opcode & 0x3F,              \
                           ((ctx->opcode >> 16) & 0x1F));                      \
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index a14211cf68..f163eefe97 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -234,7 +234,8 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
         g_assert(ctx->base.num_insns == 1);
     }
 
-    HEX_DEBUG_LOG("decode_packet: pc = 0x%x\n", ctx->base.pc_next);
+    HEX_DEBUG_LOG("decode_packet: pc = 0x%" VADDR_PRIx "\n",
+                  ctx->base.pc_next);
     HEX_DEBUG_LOG("    words = { ");
     for (int i = 0; i < nwords; i++) {
         HEX_DEBUG_LOG("0x%x, ", words[i]);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5ec88c5f0d..f886190f88 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1457,7 +1457,7 @@ DISAS_INSN(undef)
      * for the 680x0 series, as well as those that are implemented
      * but actually illegal for CPU32 or pre-68020.
      */
-    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
+    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %" VADDR_PRIx "\n",
                   insn, s->base.pc_next);
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 }
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e10232738c..12094cc1e7 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -4585,8 +4585,8 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
-                  TARGET_FMT_lx "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         goto out;
@@ -9061,8 +9061,8 @@ static void gen_compute_branch1_r6(DisasContext *ctx, uint32_t op,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         return;
@@ -11274,8 +11274,8 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         return;
-- 
2.34.1


