Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E193D19511
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6n-00012z-E7; Mon, 26 Jan 2026 20:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6l-0000zz-D6
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:07 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6j-0008ED-2L
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:06 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3530e7b3dc2so4282569a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478184; x=1770082984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqNWh6oOBtVxwncxwUoNFRBZbQ60IZ6UKqKb/SH1Ps8=;
 b=arap1NUMYH4e4QN3b1tojPd9ougnadlQDf6UBBkUrhtAce+B5g0OSPixOLVGiVkm8W
 yZWJtvzSO+bJk3BqsBz7ZQ8J38zY8ZaDi0VtsV/oqE8owk3V4OVsParBng4udCU2F4L4
 gn7CCfjBrYL+DeC6tQ9afuYpUSvjyAG9eZ8ORGN3qitrsal1Psla/FIdeJ0c3NINMa6m
 j9ad0YH64uBDaWzQxAj95bMgjqgKY0RtDcNDp/tFY2teaKbYJMNBed4IuHRn4kW6LLbv
 9PwHPw222sbiyC0UxmsXpavyVhQvmgQxvlv2F0Z3x7sms0itLdqXXETfE+kELtFxATu2
 J+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478184; x=1770082984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KqNWh6oOBtVxwncxwUoNFRBZbQ60IZ6UKqKb/SH1Ps8=;
 b=uLUuQU48xuww5Wo0ByAk3rv+x1lrkNJVbrTUd71qfibM0vsHqm7WNhAIEwmhDRQgLa
 r4XeBZ8fOnSmePkkVUgme79b212FAwjMGlAiVz5cVbFSymu/Pokf+hTtz/nlIJ9V6R3u
 FnHmBuNPSmjDrhBp5QrANuc/MUmBT1EG/V+2ngE56HJ2NDa5V/zPdPxBHMxr9/nLyTq1
 GKqb9wzNapvlnC8noyl2nV36B7qVmZDoLKv+fBMdllDsswNqjpyXELC1AfEhnqDmLavF
 kM64y4PluCkGIt/SrqYz2XOaQ/qXCPriBcjvXbZAr/hRQoTq7TRyAimK+sdL/+KktnDC
 k0/g==
X-Gm-Message-State: AOJu0Yz+lbq7xi20dGEST//LYdDLXiKC1dFRPPAPWP4wio8vkoh7O98a
 1CmWCOOXLSMidE2YsSraOuC/For7ZQU01cDQ8LhrJI3SEEAy4Ir2IcTu0/Rtb5Y7CfhZQJWtOAY
 czP68QEvvFEXyatn2b4igEDFTCDO9ssBD83+T9v5nnaWlE6gHvITH4gb0nNkz2O+fHxrWDVMdnM
 3tSZE7UICjSGtBSbk1/o18U72p9Z9ymm39icD0OnBlfA==
X-Gm-Gg: AZuq6aIb26bRDTLiy4YP+mWD6b3bA6+tc4NNoRSXsI/V35r/D9QOZ6UQOU69reiq6NU
 csPte5PVtSlJgSFm5W6e0k2wrdhYSzVldciMipaxi8h/7d97E9tPA/DupBX4fDy1sPecfSTmTcX
 Lzllkd5H32HuD5aVCHppsk4mOquhBytMmelbtq4AL3Sq2Uih6J+3mpLzp6DH33sePBrwb5G9tN5
 7HnVy0FDTR47LvlUaFbUHC6rzeM5J5ivTYPWzJnmVFwY0bwDiEb/ysL2NFbncFowekNPejA9cvD
 y8LRJbsIx0zEr9oxyAS9FruGFueC0N2tezAwSqE09NUlr0CZMmP8GHqP+a23NYcZtCLYBzZi0lU
 L9L1m0Njpf/s1QmjYeiEo6Ht5iw/L6wYiffn9qd2PmCqlSUYDikDjt8q/kK7g42p9vCO4HRF8h0
 I4p+FctD1QP8Qj1tiHv3Tt1t8TeDmH22n6QJ2uatWxsS3v7qkKGcFI93rqXRBgejNjwcjRJG5fE
 APLa8DpfeXHJm4=
X-Received: by 2002:a17:90b:2ccd:b0:34a:4cc0:9e38 with SMTP id
 98e67ed59e1d1-353fece37a0mr186202a91.10.1769478183656; 
 Mon, 26 Jan 2026 17:43:03 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:43:03 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 7/9] target/riscv: Introduce BF16 canonical NaN for Zvfbfa
 extension
Date: Tue, 27 Jan 2026 09:42:25 +0800
Message-ID: <20260127014227.406653-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127014227.406653-1-max.chou@sifive.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102f.google.com
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
2.52.0


