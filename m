Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318B2C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOdm-0007cB-BV; Fri, 09 Feb 2024 06:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdB-0006z3-6G
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:19 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOd7-0000rM-8k
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:15 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso692645a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476471; x=1708081271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGZZ3wBBPXzkhU51BAbT8JEgnl/RISp7+8LCgpoAm60=;
 b=GfuMivA1y5bwOI3iLKMQV7Zs9oWLAeuWQJpIafNIxgGpqMleU58bjHoHHDK3fx9CQe
 HCAhkW5kXtNyQVeXyVa3RrNjQN03DJaXHg5OSiyP7EhQjg/6UgWzpyqHwOHkf93bo3tT
 gjju7faBwmRAe9o0YYmJqYnjk8ISBUbB/fT7w034H+5xeHAGk7SMBDiR9l5UeNOPvAT6
 OiFSyBOPS+ae1uElQG5CfSXG0HdQYEvmICt/j7fYcWvZDL6rOOdDI7lQFz3r+Dd1Hiel
 8BdRiXooQQygdbYyadOe9YHuIhlEYM3eklb4r/RgXB614Y5AepPu/3sQgGbRpLVrtfyM
 WNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476471; x=1708081271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGZZ3wBBPXzkhU51BAbT8JEgnl/RISp7+8LCgpoAm60=;
 b=k0EhmgVB8WoXaHxKhBVhTaUd/icCOFiSp2elad1ehPQ7IB6B5QELXaAyFQKSMSDI3F
 F6dxQjw9SmsUsK16ODYThhxJCAbjdugm7p1IUcxIipiIUvchJxagiub1/oSK5wyoXKcG
 Zdqbw1sEAQwHL2AcDJGw7KAPwJRV+Lp1ha/sbXCUKRgceU4MJdIZXb5ywURIwCDqSK/Y
 sf2JS/p7ncaEedzMSyZ6yrlPEklGvIlXbn+bQb9UUtPixdczE+URqlpWewzCuEQDgH4t
 xUHa/Xj0xtVPH008H+XNXSeXZMQViZyQ51a6qfBsrHnKTK7Qh0UwjHwsxfAgV9ihIkcv
 FfRQ==
X-Gm-Message-State: AOJu0YwQbEj/TB58LRrxeNtM7TtJR0wx/RZRdt7aWnwr6pKGHLXBfuOa
 qB8sVdP4TgmH2cqFg67ylTBOdU/rksr4OlbuJVKgHIoYNosawmQI3otPDSPyuYBP/Q==
X-Google-Smtp-Source: AGHT+IEVVeAxXIEHgbS+GHSViLM+lxzr70k8cjsMNTaNHW2CJHlvqPiWYneRZTPqZ4A/+cag3TeFWg==
X-Received: by 2002:a05:6a21:680d:b0:19c:ac7f:c3e4 with SMTP id
 wr13-20020a056a21680d00b0019cac7fc3e4mr1260298pzb.42.1707476471413; 
 Fri, 09 Feb 2024 03:01:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWSyhxrKS6v4DbOepFVpGps2GvVv7Dm0hRJMasmR80oQdBH/TdbuqpL7Twxcm6/la7m2QLSOKFtQLHonUepavs5WosEZKiZ88UiRYLhTOFfB7I3X2Ilnlf0J3X3cw4tgNZy3FbMqkpzAidJgsBVbQanvXjPzNUZ+iktx9g=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:10 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/61] target/riscv: Check 'A' and split extensions for atomic
 instructions
Date: Fri,  9 Feb 2024 20:58:03 +1000
Message-ID: <20240209105813.3590056-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rob Bradford <rbradford@rivosinc.com>

Following the pattern for 'M' and Zmmul check if either the 'A'
extension is enabled or the appropriate split extension for the
instruction.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240123111030.15074-3-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 56 +++++++++++++++----------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index f0368de3e4..267930e5bc 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -18,6 +18,18 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
+    if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
+        return false;                                     \
+    }                                                     \
+} while (0)
+
+#define REQUIRE_A_OR_ZALRSC(ctx) do {                      \
+    if (!ctx->cfg_ptr->ext_zalrsc && !has_ext(ctx, RVA)) { \
+        return false;                                     \
+    }                                                     \
+} while (0)
+
 static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv src1;
@@ -96,143 +108,143 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
 
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
 }
 
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
 }
-- 
2.43.0


