Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E52D185F6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2V-00015C-Hh; Thu, 08 Jan 2026 08:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2U-00013d-Sc
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:58 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2T-0003Wf-B8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:58 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34f634dbfd6so1973400a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878816; x=1768483616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MvbuPpLeMz/D/WGRByFHmT/afSEEWto0MWCvVBzumE=;
 b=UKkl49wJAAUwuldzWkxC8HBrhx01xYihQr4zXB9k4iC41b08nSuikT2GWaprq0wyH9
 oupAVsjiD9tIp9JSiGw1apwttQgF1jhIHHUUcS1MECPPpM/fKJg6S7OnYSKyJ7Eza5wM
 mqI0ogheULAI8T1SrFHUnD89uUW7SUV/2UlzQGZkfxnTLZqkd094a7RBqNexrxviX2p7
 phduSHxZ9D+Koigb7uDrm2fa3LZM4xWyVX53t23f571R+2XUFIc+CaZc3VvfbQo9B0ft
 VQCI0VGLD/U/EFEd3Z6R7YzNrx1CTU3W0q9PKTXc5sTvJljeXbdT1Kzd0UCvf72wtCDb
 XWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878816; x=1768483616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2MvbuPpLeMz/D/WGRByFHmT/afSEEWto0MWCvVBzumE=;
 b=lHfDwvfYvJPbsEwTrbSCFN6DeyKv64W8bAA5NbPKKm5HEOL4MNVIP567ed93KqBMUa
 QwIAmqkky4jO91IOEWe0KnuV/A2ACcOrNspYFXZMSiZGJIDESLZhPMzxTx3xfBCKPDIU
 3U89VVWFJ4y8pnvV4kcOvLGHsYBH1K9HeDQs3IaLkb424jfoqlH5jucFzhsRA3P+1yAy
 /C2Xg3Ux84TWY2W9k3hx9zb+Oh243tuEYqQYoFVKrzoY/IgjPr88zWt16M2kdW4v9z84
 IfleGXaFDhCbDAZWat1X5n564grbof9Rwwuuv07IdWyoX0xGNNGtqCNw+Jm6nITKWh+g
 qZIA==
X-Gm-Message-State: AOJu0YwP9PDyfVVI1WWGZxZg2EuIka4nIze7htVs7ubvNSlKJcDkcjBa
 Cr6JAiheorJCFDkLJQ2krUygYDfhG79XS19eHk63as9EHC2FFouFsjaZIMjuP/fhg5hoJpBlaJy
 x0qlT9F92TKBXIbHrKyxPqBsNzZkrzQbYCeiKtlQjhULTbz6GmbUD4YSkK8aOJ7uOK0E+ES8CXK
 Xbga5BkdEh3GBZtieiIAgDjb19roX+NCY2UdsChSY=
X-Gm-Gg: AY/fxX6cqDh4jaa14rrI0EVS0PiWfMsXcnbvPhDfbZJKpJ11RZMsTGFYW4qYI4E7Old
 2G213uSZDO4r8uunS5uPVaYuVQgmtfbmJi/Gq6GmP2bbzq4pkaBCEjsvGt4hqH6z3RRcflWk01b
 zBh/bF4ZxHiaR4FzIZmWuKPLpgECvRne2mYovmcfHVcy4mA9thLpQecuKWjNuSSPD75ehs+WYld
 4oOIm42hPaDyJ8Uk/ITfNT8SGmNva0x0wUvt+hLiyYcZgirSt6M4HUpSogTyP7D9tPqx0LQsm0S
 VL1p4IRkIyaRoXGsUIFswHWcKsxIZMNkgFJm+F+hFF3cBW4iiv7WsJzGbJLCqBi6gp+V1S9VfXz
 F4fT1c0IZrCE7+8g9JVqeA1K2yPaoOQ/JA+sMFzvHmxkSQO9JMQAjzzqtkKpkBXKq59Eo5NL8Bg
 4eLlvJ5dkdbhuikY6t+wcyfoqDR8XENHir7FCuzPa4YQ8MO9ickqmePFA=
X-Google-Smtp-Source: AGHT+IGpnBmehXr85p4VrkJ4B0HhQj22hW9AcMLMn/lT3mL62utE5NIa4Yj6w0NLlhXuioVT2C9Gtw==
X-Received: by 2002:a17:90b:5848:b0:34e:5aa2:cf61 with SMTP id
 98e67ed59e1d1-34f68cd6ab9mr5828987a91.28.1767878815731; 
 Thu, 08 Jan 2026 05:26:55 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:26:55 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 7/9] target/riscv: Introduce BF16 canonical NaN for Zvfbfa
 extension
Date: Thu,  8 Jan 2026 21:26:28 +0800
Message-ID: <20260108132631.9429-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108132631.9429-1-max.chou@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1031.google.com
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

According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
f-register operands must substitute the BF16 canonical NaN instead of
the FP16 canonical NaN for some vector floating-point instructions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 target/riscv/translate.c                |  8 ++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2a487179f6..3315397257 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2347,17 +2347,17 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
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
index 911d3932f9..a1c4b325e5 100644
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
2.43.7


