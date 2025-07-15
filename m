Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79A1C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ17-0002K4-PS; Tue, 15 Jul 2025 02:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ14-0002I5-Ep
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ12-00073r-Eb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so4184210f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560386; x=1753165186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oLj9I136vA6ZJns/MpzluU+zNCyNhpu0U3nlVsQVbc=;
 b=C7Pm0/GsizP4CRVleM8cCEHpDlYhbpqXNa0Ukh80UjEOXy613cd1ZsbuZquzD2SY+h
 JryUVAYWhNNi1LeaOHU5Tuz6xUlX24xVS9CMiXmPLJOwazmwBNiDyA3ZtJZw2G08Myt7
 +3daW1oA3A/mboQQtHDTkiZKDMSfKX/g6Y/gTUyhGpRZ73Cab7mhlv93Jkt+noUWcStm
 sbg0KDvT+j6baVhV51MySghUWV6+LfiaSN4yik0hQliMvnSmf/i5+iWX5JRoWhl7Cuc3
 HxUbXjtmGwBKUx7UyLiwQwxo1eOt28TDcG705QHn1bXEY36Ti6nig80rLs9W9aipfPJA
 Zm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560386; x=1753165186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oLj9I136vA6ZJns/MpzluU+zNCyNhpu0U3nlVsQVbc=;
 b=oeCw5i8w0lVUNMvaGCJ8pWin1IsyvCG5TY+jOq6pzhlyeoSFmnCPvhjTA7kHvt0XDH
 eapFTAy2mpIdyCcC4ixVB3bVJMsoR3C8yDlZTK0mHu/E5RU3cuw96fEmfvT75EJ3Rzpl
 RfRGzg7UrXrvaYTenkp2Ynt5qPUlAzW5z2uwdplCd70Ms5YATmZ8aQM32w8Pa9g2BgT6
 20zMgJCWL2ZXlbXda619kdjy+BP+pvu+YityN4mo+kz0WvlBQM2bqIb/roeez1UhjwVH
 5fdvnGl6tuddkG1G5YvCB+2CBbxQ0vCJd3y08tOHmTChRuDdwG5l1aEUCT47u2twKDgF
 GsLQ==
X-Gm-Message-State: AOJu0Yy7SNYyB6KXamg3hvPu/2lfNlpL6EsksqHskyFUvedFMnp8meiu
 4j24QbsoFrDLcPHIgZa8bDDenkIWD1pUEKAdKF1KojkyMUUArGWCfaT0qrIu+cx1phvknyKCYpI
 OctQa
X-Gm-Gg: ASbGncsjjX6jH0Pv6YF6NoLJy6kLLm/g6p4aBNLpi8Kv0O2OBrIDjnfYDAVNKBGLEiZ
 suoJ9hxyrNad1J8q//kgn4WJMalesxos1H9hunMpZBwiMyg/qK4uuHGLMYwIDq7BPbyyt5uJ+1o
 Tpu815Q5KtKHAQ8sjRkKjmxWVNBi4wc7XKZZTUlp9Ue/GH29HTr0niLdAepeJkSmNcw5t6T2ofc
 7bam17YDGAa7JiuTuwCe91I5UbSFL29B6l/qxjhudsYA174Nv+57Ax4AASpIA8GhDGLVihrDAc8
 WxRYEcIErLNJO7Ci5PIcC+vNBMMgwYIoBxUdS24YndoVIJi/5YE0eFcWskmy8O550eBp9l//1BX
 OGruavoKiiWfRjWmR09W9Zp5uotUKLJ931t91h+ZYUxHReB2u7VlZ9D1sbeTBOLHgZbQj1gCc
X-Google-Smtp-Source: AGHT+IHkq1ccNKUzGMehQoWdsomNsA7HAMbw1ngTaheYWlB4DZdtgMTDOMIFvfWLf/hPt8DPdjNBlg==
X-Received: by 2002:a05:6000:144b:b0:3b4:9721:2b13 with SMTP id
 ffacd0b85a97d-3b5f2dbef03mr12739369f8f.14.1752560386117; 
 Mon, 14 Jul 2025 23:19:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e135sm14338578f8f.72.2025.07.14.23.19.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 05/17] target/mips: Have gen_[d]lsa() callers add 1 to shift
 amount argument
Date: Tue, 15 Jul 2025 08:19:05 +0200
Message-ID: <20250715061918.44971-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Having the callee add 1 to shift amount is misleading (see the
NM_LSA case in decode_nanomips_32_48_opc() where we have to
manually substract 1). Rather have the callers pass a modified
$sa.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-4-philmd@linaro.org>
---
 target/mips/tcg/msa_translate.c           | 4 ++--
 target/mips/tcg/rel6_translate.c          | 4 ++--
 target/mips/tcg/translate_addr_const.c    | 4 ++--
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 target/mips/tcg/nanomips_translate.c.inc  | 7 +------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 75cf80a20ed..82b149922fa 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -780,7 +780,7 @@ TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -788,5 +788,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 89335063977..4c056621c97 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -23,7 +23,7 @@ bool trans_REMOVED(DisasContext *ctx, arg_REMOVED *a)
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -31,7 +31,7 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
 
 static bool trans_CRC32(DisasContext *ctx, arg_special3_crc *a)
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 6f4b39f715b..1d140e918da 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -26,7 +26,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa + 1);
+    tcg_gen_shli_tl(t0, t0, sa);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
     return true;
@@ -47,7 +47,7 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa + 1);
+    tcg_gen_shli_tl(t0, t0, sa);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     return true;
 }
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index c479bec1081..8fda7c8a214 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1795,7 +1795,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             return;
         case LSA:
             check_insn(ctx, ISA_MIPS_R6);
-            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
+            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) + 1);
             break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS_R6);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 1e274143bbd..9d4e0bee81f 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3626,12 +3626,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
             case NM_LSA:
-                /*
-                 * In nanoMIPS, the shift field directly encodes the shift
-                 * amount, meaning that the supported shift values are in
-                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6).
-                 */
-                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) - 1);
+                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
                 break;
             case NM_EXTW:
                 gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
-- 
2.49.0


