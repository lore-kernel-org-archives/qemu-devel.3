Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6872D39428
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILK-0008Qx-4k; Thu, 02 Apr 2026 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8IL1-0006PC-Mc
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:44:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXi-0008Pp-H4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:53:04 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so512740a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134377; x=1775739177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ld8CnnyzAcOV67sMQVplRnhgRJDPtnHgEL5Grwo2gE=;
 b=bFqOraMzRh/NpyDDK12jkUtJ1sVhLXGcGD1zACuRKhjKdzyFLDNKg0yfvNlF0lr19Q
 zjv9QGmscXNvEHPYAKeVTmrsQyFcymSjEnha/GyK9GkwtTsp5lyE8UoirDjg789EDkO2
 7QudVe6KYDGj/hR/sMUssZ7qNd+EfPy9TFcGCUKICzP4Sq5mqbCpI5PbKjpe/bC1gBEl
 nyQDTAwazELYl20GL2SmwZY/wStqj9KynbRbIx4HHkqYD/kpd4cKAV8ocDIfA6AVAtv7
 ZQahkgzddcI1hfoK4fKtOmc1N9W0pyQsIBoogQFJE2lcCcG3hCtGyeQtUTQr409x5wzH
 WHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134377; x=1775739177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ld8CnnyzAcOV67sMQVplRnhgRJDPtnHgEL5Grwo2gE=;
 b=YDSza4jPd1IHydiYnTOOm+sSn870bvfjreuPTfn9W57AlVI2QkSimkeBqicl3f6f9t
 /VNBE/ccZm871eKpTJknHbY53rgxXNtU0Ll29U08BBOzSIQIfx9y/DUA4n6q6wp07AN2
 FJBRIgkqh273ndJD6ImaVxFDUEc6S40DH1GFo64v23imq+KTbVhCK0IwZCNpnyPqYg51
 yLkZW5i3tDqAFfbV35F9KF0oIc8Yc3EAHzXtaX+NfQLr+WqR0hiewLNeYEKeJqclCkiR
 sRm84nbT4peMIGTfyIee5GOd/L8Ys0XPwd4alJnF6kBzyov6gs7OIOp56/x5B146/jmN
 229g==
X-Gm-Message-State: AOJu0YyqjSFT7vVBtZSQYJq6vYhjUngWcXEq5BQgD75Uug2jMJ23xq12
 Y5ezyWNNu+Y39PgtQQG0Om27jyrPxu+kjDnHeiuDVPhHYfDgFWmXneniCScilmX4JFHxVI256l5
 OM93ChXoGUL0kt+K2zoTB5sexe2fe1RSxvnKJQsFASYRHNvowHPrT5S1wKxBcQ/cyNFs6C8M/u0
 TzSCdUJ+74/fpdfUyMk0OR+K6Q/q7qbLw+ChdTlAA=
X-Gm-Gg: AeBDiesWa7X4z8V001EfN2F8cJVR47+90lPtyMLKGUOLPN/oyj7W0V4ELIl8AKK1QOk
 Moh8wG/JbxkzlQNUi7lBcAq592d6crrO7yPLooG6/iVMhYqAl2ObiDX+4/u+YbTyGxaukOJhBuE
 FWRihkpvQAtm3scZnOt9Xh/vlMa6g0mfDw0gi+m70YXZeJxZkUhUsdCPo0I4cu2LG1Wv90Wpiuq
 DS8fHREv+/HrFuiKgCZ56OhteU3vfC+ZFgMhl59A1orr8yABiezddMMHDFB6jtHOzH/o4s0ogZJ
 QwFGy54NcHETqladGVA30xLYh7tAs1JXwXNhu/5h9uOUEzPh4DfRbBKmU2YwMnXRR2o7sTckkdI
 QWWzdBOh+ysQrzu6DFA3iKjBENd5PcSN9AtUhTQvy5noUzdFJNFzKqUGXi7uFk4cDl8NGLLE2Qm
 rELhvicNZXi4rD/eFtGeuPl6imu3gmK5n3wlOJu7xKLzJ42Ao2PD1iCbvhMjwZb1MCTjVzhPAGH
 P98+VB3co/k3XRTLwYeUlY3Omc=
X-Received: by 2002:a17:90b:5108:b0:35b:929f:7e8d with SMTP id
 98e67ed59e1d1-35dc6f4a461mr7514902a91.14.1775134376821; 
 Thu, 02 Apr 2026 05:52:56 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:56 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 7/9] target/riscv: Introduce BF16 canonical NaN for Zvfbfa
 extension
Date: Thu,  2 Apr 2026 20:52:32 +0800
Message-ID: <20260402125234.1371897-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
f-register operands must substitute the BF16 canonical NaN instead of
the FP16 canonical NaN for some vector floating-point instructions.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 target/riscv/translate.c                |  8 ++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4df9a40b44..03ae85796a 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2319,17 +2319,17 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
  */
 static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
 {
-    switch (s->sew) {
-    case 1:
-        gen_check_nanbox_h(out, in);
-        break;
-    case 2:
+    if (s->sew == MO_16) {
+        if (s->altfmt) {
+            gen_check_nanbox_h_bf16(out, in);
+        } else {
+            gen_check_nanbox_h(out, in);
+        }
+    } else if (s->sew == MO_32) {
         gen_check_nanbox_s(out, in);
-        break;
-    case 3:
+    } else if (s->sew == MO_64) {
         tcg_gen_mov_i64(out, in);
-        break;
-    default:
+    } else {
         g_assert_not_reached();
     }
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 551581b8d8..81087e0a5d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -214,6 +214,14 @@ static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
     tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
 }
 
+static void gen_check_nanbox_h_bf16(TCGv_i64 out, TCGv_i64 in)
+{
+    TCGv_i64 t_max = tcg_constant_i64(0xffffffffffff0000ull);
+    TCGv_i64 t_nan = tcg_constant_i64(0xffffffffffff7fc0ull);
+
+    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
+}
+
 static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 {
     TCGv_i64 t_max = tcg_constant_i64(0xffffffff00000000ull);
-- 
2.52.0


