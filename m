Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EC1CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4mO-00081h-2z; Mon, 15 Sep 2025 04:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4mF-0007il-Nu
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lt-0002QN-5f
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:33 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-772627dd50aso5594766b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925668; x=1758530468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=512SNwG/42h2YVFM//EPeL3wCt1vmEMWdeuDeCr6XOw=;
 b=hsWaG110Tr/+1APCn+Z1oU+Nfzc2BV6YGoInurvARb8KvsfIdO47/oKDX1zBNCvRke
 L8aln72Eh2nrrN6fDDHY8gdmAwZuce3najB8TyqlFIhG0AQzoDB9qDVX6PcewOntIz8c
 ZTwK+RTPS1BGgAfQ4wK07pr6NgNSE8aiRDux8ahnkC0WlWldUSu5Ig21+5/1I/7ggYH5
 5ZXzYyVx1YOa2Wbz2q5tEiOkWJn4LkKfskMRrQUkxZJcR8Af2zN2rWPMPGnsvJyZaovl
 4WGGS76CIGy6Vl7zUIiIbSSk5GxKlrKac8RIxME4zf9sTUv42ffryupvoPn2OXHHl2ZA
 /4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925668; x=1758530468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=512SNwG/42h2YVFM//EPeL3wCt1vmEMWdeuDeCr6XOw=;
 b=G+RWGDQcsebbBwcbf+z5W+0WMgKt0RbgWLXCxQEvmpLdXoeaUTFaUdDTMm3btrWvHW
 9X2QZPelRidfdAz6/aIK2WP09unNeoohW/HBCCXPisTDIS/zamojffq8QBJLQTg9Godq
 JGhD+qu/jcZz5WWoaU85CCasNLuNQg7mgX2oNsrUU2ZRSPL5+e9UUvBnsNqNtJW7ihb1
 1+by24jvF01cX0LFMIXdBH4Oqdtmav3Yz9JSwxuU28VSqk1EXA+kvv9Q60UxOly0b0dT
 tw9Jjg3iLBe27gzg/QU/qGbKa9yN4bHWAKRhubq5tndCf0gqheB3Kl7UuKRhw9ftKmf9
 579Q==
X-Gm-Message-State: AOJu0YwzC+Lh35Or5Ukt67NnS54yfINTwk55dNF0ASLKnGpoFacMm8wU
 sjFRGRSC7AYuQahhluGTIbyfy75/OuHoUagi+EKkErKDI6dYLRnBnXxTAXV0Go6RIbs4wVSY69I
 5DLRek19EIxWIHGuUaEahc9ak4V+CAK3sEmHdrEwUOwmp+GWVXuQwKx8XZ240ugRmzEgA0Sub70
 oaC/jODSwL7Mu+6V+21BO780lwUnf/UZksN9MyOozMxQ==
X-Gm-Gg: ASbGnctsK3rYLc4rVrAwZvKrNei7QDg78wnqKm164gfKZRZZGJN89oE9/OPFfExokQX
 x5mQ+G6ncnA/XKjg8uEtm4l7+5TIQxUa9mRMlf742UgBoG6TfGUwXmTmBV7xeIuwIVqn1CJanH5
 o3Bnoo9flainri5fdfDYHGBUVHf9ly+UIbUTP96e7uPOUJqh9Wg9axRNna6iwW9m6RPrwXBvXmu
 C+ESl5uWtRR+BDcbYxwZxe7pw3Nz59eBNi52x3ULHiNCtI9K2XIAD+Z8JLDm63eDR/uyXMTYXDv
 b1j9sNO5sysRIHkmSQoJlVCZgRBQSueooes8zbpEvEd/HYi3YR4OcC5eAA2GsvnE9WYTGkeHvI5
 55IzPveb/wGXUzAbsdjS/8WDiuXRHuRTeqFrltFdVAPGzUBKHOudDGjt0eC/IWWsBJV3Ol5Kl3q
 qjSA==
X-Google-Smtp-Source: AGHT+IFoDLndtxzmRjFmPNgqUmSrx8zHVIqUFQdp3DCFdYMLVkCo8j8khTc7kBxGeNWoTrQ9LMlZZw==
X-Received: by 2002:a17:902:d507:b0:24b:270e:56d4 with SMTP id
 d9443c01a7336-25d2a11abefmr139836035ad.4.1757925667933; 
 Mon, 15 Sep 2025 01:41:07 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:41:07 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 6/8] target/riscv: Introduce BF16 canonical NaN for Zvfbfa
 extension
Date: Mon, 15 Sep 2025 16:40:34 +0800
Message-ID: <20250915084037.1816893-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915084037.1816893-1-max.chou@sifive.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
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
index 71f98fb350b..62cc03784cb 100644
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
index 8ad147946c9..d99b58629d0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -201,6 +201,14 @@ static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
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
2.43.0


