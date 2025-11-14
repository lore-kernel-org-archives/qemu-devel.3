Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64333CEACE4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 23:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK2nI-0007wX-IH; Fri, 14 Nov 2025 18:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mE-0007Go-OS
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:31 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mC-0004au-7w
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:21 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-433100c59dcso11182785ab.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 15:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763161218; x=1763766018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XovF2lkS42tfLHytkzYxdDK/Xhg/o5Pl+/gBb/Xdlw0=;
 b=QBByVDO+kxrEDEedPQi8+JeEz475D2IvcxNuzZALVec2pMMvc2YR6U9LRdDdR5iXgH
 4sHx7SiM1uIA/wfoPU89e/yScT2okjl/pkEZuKqhXAwwRvhcL+oBVMOffPVJkEWqYyns
 oT+MIhv00NsWfbMZhMFIqLltB6pRixEXZCByJJji7L97pAL5MnGEN890RV/muriUB/wT
 rVCHAFiXXnwnnMUNaIXmmtsONkKXBbxxcbDS9uanjwqN/Mj4StkAfql3aPWcAO59mpdl
 Fk/bTOf2vKVTYymXHFBuOxcDmlTKYvmjegkBBYkBDLJemGS1boSFsW8upcKqkAkWFEqV
 FnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763161218; x=1763766018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XovF2lkS42tfLHytkzYxdDK/Xhg/o5Pl+/gBb/Xdlw0=;
 b=C1rfD0wDIKBqzM8MMxWNfsNzYsZ/16jrW07hWHTjY7oS8MEc1zz0U4Zme3mj3PUi7t
 4P1J3e+10muU7vFEN+flL8FmDsN5FOkew5XsVcbD8s18kj/mi4EsXieM1GIT25xslqLe
 OBsvQJ1WHCy8+y/O3Axlc6LjqbNR6K4+9w0M1/cIK/gDDiaZPWMtipYJI9M3Rva+qivT
 thkL8wboSQvkRuLGIZG172p6E0/WgIIxlkA2RhM7dWHPR0udfLIex/CPMrxkwxO20GJ+
 2hVPoGAjkF31V4x9mAgwduZTjqq2rBDlB7B1m2YbRu3eOUrNXjIuPd+KASAmrXdLruAp
 4msQ==
X-Gm-Message-State: AOJu0YwvsFe2SMmhYASJnQKq+o4n34c1KUQjetKDFvHxg7CPtFLaq+hk
 j2lLe8EmPXrFNYeGuu4WI4ef3XTyzi20fQ7ZP+NsKYrcUWlwaRuZjEbHMZ51cCcm
X-Gm-Gg: ASbGnctPimu1cuDItn8xtnFBVoLgF1+39Ie1KphG1eL0JQOzZa80M475llyCtIkTU6u
 2yk0m2RfZWVwZdIT2IEsRWv44seDApTkPTlScl6GQTsInKOakwj8WND+1UGag1HPq62gJJasSAp
 2cIaIRbxk6VyFLABKok0SNqnPRPyarifn3qHIif0lGM1ySusoFuDfWkHVjspik2BfLcVF+yylTQ
 h/j0ZQo5IYELcNH2puJy/JpYJ6liNsnuRm4SLKxcVzog0zxi94fyN7tuFE3N31u9+6VFGRgLown
 4KmmBoa8JhG8cSYRMzez4EcAWcDg/+jqv3AEBpQuxYMb9Hr4eJgmN5+njWnGIW20t2KHNnVsTT9
 Gub83N57z0++IlJWvlKNZkkcP3t5x8P/m1wDjICo5Us7n6bR2+vDE0040SQDgV3o+qSGVhZERCD
 zrlAD/Keu5Ay1GYwnuN6hNgdfTvS4f0jtBwTNz+YzGTNdj1Evm9sEjyAeJ+tr1pezV+2GFg/fhy
 RaH1GI6V0P9v18=
X-Google-Smtp-Source: AGHT+IG3TlDV4p/gI6Y4z9XVLM8aUfTCXS9cSNuHMrxWaiytS2hPAk8QyCGp3WMyXGcDKXOwy6UafQ==
X-Received: by 2002:a05:6e02:318c:b0:433:794c:847d with SMTP id
 e9e14a558f8ab-4348c87fef9mr78577275ab.13.1763161218292; 
 Fri, 14 Nov 2025 15:00:18 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434838c24a1sm35673075ab.15.2025.11.14.15.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 15:00:17 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 2/4] Hexagon (target/hexagon)
 s/gen_log_pred_write/gen_pred_write
Date: Fri, 14 Nov 2025 16:00:11 -0700
Message-ID: <20251114230013.158098-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x131.google.com
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

The function doesn't "log" anything, it just generates the write

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_tcg.h                    |  4 ++--
 target/hexagon/genptr.h                     |  2 +-
 target/hexagon/genptr.c                     | 14 +++++++-------
 target/hexagon/idef-parser/parser-helpers.c |  2 +-
 target/hexagon/hex_common.py                |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 10123336b1..60f3d295da 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -599,7 +599,7 @@
         TCGv p0 = tcg_temp_new(); \
         gen_helper_cabacdecbin_pred(p0, RssV, RttV); \
         gen_helper_cabacdecbin_val(RddV, RssV, RttV); \
-        gen_log_pred_write(ctx, 0, p0); \
+        gen_pred_write(ctx, 0, p0); \
     } while (0)
 
 /*
@@ -914,7 +914,7 @@
     do { \
         TCGv p0 = tcg_temp_new(); \
         gen_comparei(TCG_COND_EQ, p0, RsV, uiV); \
-        gen_log_pred_write(ctx, 0, p0); \
+        gen_pred_write(ctx, 0, p0); \
     } while (0)
 
 #define fGEN_TCG_J2_jump(SHORTCODE) \
diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
index d932255042..228d7f1d7d 100644
--- a/target/hexagon/genptr.h
+++ b/target/hexagon/genptr.h
@@ -37,7 +37,7 @@ TCGv gen_read_reg(TCGv result, int num);
 TCGv gen_read_preg(TCGv pred, uint8_t num);
 TCGv get_result_gpr(DisasContext *ctx, int rnum);
 TCGv get_result_pred(DisasContext *ctx, int pnum);
-void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val);
+void gen_pred_write(DisasContext *ctx, int pnum, TCGv val);
 void gen_set_usr_field(DisasContext *ctx, int field, TCGv val);
 void gen_set_usr_fieldi(DisasContext *ctx, int field, int x);
 void gen_set_usr_field_if(DisasContext *ctx, int field, TCGv val);
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index e58021ed6c..bfbbd61c33 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -120,7 +120,7 @@ TCGv get_result_pred(DisasContext *ctx, int pnum)
     }
 }
 
-void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val)
+void gen_pred_write(DisasContext *ctx, int pnum, TCGv val)
 {
     TCGv pred = get_result_pred(ctx, pnum);
     TCGv base_val = tcg_temp_new();
@@ -215,7 +215,7 @@ static void gen_write_p3_0(DisasContext *ctx, TCGv control_reg)
     TCGv hex_p8 = tcg_temp_new();
     for (int i = 0; i < NUM_PREGS; i++) {
         tcg_gen_extract_tl(hex_p8, control_reg, i * 8, 8);
-        gen_log_pred_write(ctx, i, hex_p8);
+        gen_pred_write(ctx, i, hex_p8);
     }
 }
 
@@ -557,7 +557,7 @@ static void gen_ploopNsr(DisasContext *ctx, int N, TCGv RsV, int riV)
     tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
     tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV);
     gen_set_usr_fieldi(ctx, USR_LPCFG, N);
-    gen_log_pred_write(ctx, 3, tcg_constant_tl(0));
+    gen_pred_write(ctx, 3, tcg_constant_tl(0));
 }
 
 static void gen_ploopNsi(DisasContext *ctx, int N, int count, int riV)
@@ -597,7 +597,7 @@ static void gen_cmpnd_cmp_jmp(DisasContext *ctx,
     if (ctx->insn->part1) {
         TCGv pred = tcg_temp_new();
         gen_compare(cond1, pred, arg1, arg2);
-        gen_log_pred_write(ctx, pnum, pred);
+        gen_pred_write(ctx, pnum, pred);
     } else {
         TCGv pred = tcg_temp_new();
         tcg_gen_mov_tl(pred, ctx->new_pred_value[pnum]);
@@ -654,7 +654,7 @@ static void gen_cmpnd_tstbit0_jmp(DisasContext *ctx,
         TCGv pred = tcg_temp_new();
         tcg_gen_andi_tl(pred, arg, 1);
         gen_8bitsof(pred, pred);
-        gen_log_pred_write(ctx, pnum, pred);
+        gen_pred_write(ctx, pnum, pred);
     } else {
         TCGv pred = tcg_temp_new();
         tcg_gen_mov_tl(pred, ctx->new_pred_value[pnum]);
@@ -834,7 +834,7 @@ static void gen_endloop0(DisasContext *ctx)
     TCGLabel *label1 = gen_new_label();
     tcg_gen_brcondi_tl(TCG_COND_NE, lpcfg, 1, label1);
     {
-        gen_log_pred_write(ctx, 3, tcg_constant_tl(0xff));
+        gen_pred_write(ctx, 3, tcg_constant_tl(0xff));
     }
     gen_set_label(label1);
 
@@ -908,7 +908,7 @@ static void gen_endloop01(DisasContext *ctx)
      */
     tcg_gen_brcondi_tl(TCG_COND_NE, lpcfg, 1, label1);
     {
-        gen_log_pred_write(ctx, 3, tcg_constant_tl(0xff));
+        gen_pred_write(ctx, 3, tcg_constant_tl(0xff));
     }
     gen_set_label(label1);
 
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index f5802ceadb..70bfa64432 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1713,7 +1713,7 @@ void gen_pred_assign(Context *c, YYLTYPE *locp, HexValue *left_pred,
     /* Extract first 8 bits, and store new predicate value */
     OUT(c, locp, "tcg_gen_andi_i32(", left_pred, ", ", &r, ", 0xff);\n");
     if (is_direct) {
-        OUT(c, locp, "gen_log_pred_write(ctx, ", pred_id, ", ", left_pred,
+        OUT(c, locp, "gen_pred_write(ctx, ", pred_id, ", ", left_pred,
             ");\n");
     }
 }
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 093def9386..1277fec9a2 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -571,7 +571,7 @@ def decl_tcg(self, f, tag, regno):
         """))
     def log_write(self, f, tag):
         f.write(code_fmt(f"""\
-            gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
+            gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_write(self, f, tag, regno):
         f.write(code_fmt(f"""\
@@ -608,7 +608,7 @@ def decl_tcg(self, f, tag, regno):
         """))
     def log_write(self, f, tag):
         f.write(code_fmt(f"""\
-            gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
+            gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-- 
2.43.0


