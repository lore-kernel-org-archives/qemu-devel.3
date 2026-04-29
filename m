Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F5CFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtd-00083b-8E; Wed, 29 Apr 2026 00:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwt1-0007FC-BQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsz-0000qA-S0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:59 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b9705613ddso16505335ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438256; x=1778043056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvzcxG+epy8Ki+870FfNlVL7pr0x5PDwCS1eWs4a/Mw=;
 b=sxxW0sFcOITYlTkRytR/F0mPc2tV1/XbB8nktoOn/sqpVCmSSK6O14+mlvRXKqhXHl
 Z/04QgmnB4edGKVm3MCOVPl4H98tSrHcXbJSqOZGQULtgvwErWQPeT+u9lXesgdLrp6g
 Q45nTHfRET1lm1ofYtfIyubCYqeuNhv3BU5JNzB4B1pgceH3fIFsMQwizqghKvehFTXi
 3YkvwFKtxdoF0+f2/rOZtPhtvV7mIV1M496EB5EXUoTp/an4ZXdtRYKH96v7bcldg0n5
 OvQJB9nWrsSiKlykPuss7XvQxxmOF9kxPNws/xbZSU9rjCYx1VmXkvd/wrQxBU+umrGp
 YBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438256; x=1778043056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DvzcxG+epy8Ki+870FfNlVL7pr0x5PDwCS1eWs4a/Mw=;
 b=N6WOtSlBCXbKW6n0HHu28X+q7xRyJ3fs73zBjmU/RyHhnLsUxpGJWUAAuDrw9FVPp4
 6yNisDRMYMnJfLL7FaVRee/vHyZ4P0MO7lUlaXXjoNp2cC0xwOewHw+1rEtM5Dy4YLCZ
 7rU1zwuyua916L8Gl9B6kz4DYPa+TWMbhiWV3q8/e8QPRrH2njTj97qQRkSKyJBZsqlM
 0iL9oWk7/iYoXdMiXZ/O7gFqJWMZD5fBbf23hjxMxPNnAXdrsMWisB8HYxQYI7QYzV19
 6xgVK3ofzZ+NBX+OgbRWfgcPvZulWa7wWVpBd0Vx2fPFrZwvzl5/PWSR8t1Bo0v22S//
 8xRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ96qqKKpGGQIoyP2WLGWwDOI36ndQQGNCxyO3ugM1dmdHesrLoDn3F6yFI+ToirxYgFrm21O3MqvDh/@nongnu.org
X-Gm-Message-State: AOJu0YwZfBe06x2919l7wEZCIWckoF6jsIsJ4XtHh5/U59zdtmZJe1lF
 kT4llQIVAebc15zhNXxNzC4Bjza6iuFI9rNila/CxvyVjxm6rUxqKKCM
X-Gm-Gg: AeBDiev7Hq4Gu434qjeGWAcbfFt2C8qVQMDr04LEd+ErWNc3a20KKbe9eHB0CSORpQR
 yCVmWb9fr2dJmjxQsufu+KBvsFLBevvJ1byIUjcASeEzzdgmVOrJN+QgYgYPb6wiCGClsSholQh
 wHQgJJxk10dphqb5Kn6+JhaU3RPauIhCZXLnmjrcs4j57LWk/E8OYXWWmX8/A9FRcFogwS3jkvq
 yGGcuFkluCP5CUA/62cftzrck/5hYzwFtTMPZtyqOJ4eNyNG3ht/uDzCWKuRG39GrH28guuKM58
 3nt/CRzxuK8yXpfY1wl+FcHCbIMoJnMLXqg91NwJWVSdB75IOSq37EQxGX5AV3EKNmtLxqgJGqh
 EJkPtZ83+yHimwap1coAsk6IiCyY40s0VhSWuT/z/aXHsNKd5tZJYJTT+5dzJGfNCnVl3kKChwV
 AJmZg8Pis31D2SutKGn6EVRxoKhbpM57EiSPfoXrJgW2fpFdXGb80v
X-Received: by 2002:a17:903:2c0e:b0:2b9:78cb:3477 with SMTP id
 d9443c01a7336-2b9872f82a1mr21524875ad.8.1777438256514; 
 Tue, 28 Apr 2026 21:50:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/51] target/riscv: Introduce BF16 canonical NaN for Zvfbfa
 extension
Date: Wed, 29 Apr 2026 14:47:34 +1000
Message-ID: <20260429044752.4176397-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
f-register operands must substitute the BF16 canonical NaN instead of
the FP16 canonical NaN for some vector floating-point instructions.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-8-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                |  8 ++++++++
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f8ccf34438..1e4f340256 100644
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
-- 
2.53.0


