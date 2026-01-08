Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE78D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlj-00018U-1R; Thu, 08 Jan 2026 10:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlQ-000103-1Q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:28 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlO-0003Vf-Dd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so2861954b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885445; x=1768490245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEZZYLjQimnKzBKe2ibZI99wEq3mO387ULnUSSxXSEM=;
 b=dX6PmXYHcbkG192HL+CKOvKmFdty7tQYMPXixEGW/jrpFoeVF1/XPSCdDPQhJQhUYG
 jhOD/GxkLlRFZH5kUJl2wUp7qFhvbcBpiZXfGmVPsqqUyAKJ8lmZPj3U9VuOAwfCYs0B
 2i+tT1pSzsAfsy0IMJ+6IC+Kj01mr3fCsVNyaVhymJG18OMPZT4FEZak33KQooxHoe0d
 lhvL7JofHAwvNbjYL5i8XW9AQDJzNTNA034LXrIb9VwnzvNz6UlJcUEtAGtb8NMlUW7S
 BV6oXoqUChUBjj4TpAGpXjGU0/ZKB5XabFWuW3wn5mro49nKmJWnin5mkYD0dEkhibhW
 xO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885445; x=1768490245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEZZYLjQimnKzBKe2ibZI99wEq3mO387ULnUSSxXSEM=;
 b=lbO9BWuKoRT15I7iWybxV8C3qf0rJZz8tDjFO3hNW5syMaAcL9Z8OHxwK2q/ejS7Wa
 3I4uXf5FloL4RIxKAT8VpOMK5g5lAj7DlhA6Ai8D+rRJO5eABe2B03fKCZb6Qf2Q9poQ
 xZ5VZ4jAe0GwO8p5y3gpIaW+jl3IX2MUYhNbg++mncB02TiTsYvZBIXJkp5Qw4uvQzdY
 g9QUMgiBP3GMvgxPmu2lM1BkzhNhctlHfqDPKD9oFMPc4qRvymKPkU+YHoxBdwIQekxs
 xvIINS53iSztQZEAJuQIZYB3OtGJfO9UeHM5MFUp2Za83IXCiSbzHWQxDiQ1MaqKnf5m
 nWnA==
X-Gm-Message-State: AOJu0Yxa44fGOS86z/fOR9UIXJjlUuk2Yc+Fs6rEVgBFSXj8GkLgmGzZ
 UICqgAYUeFZBeoCWNMDwPwUS1g5GukSBVGiXPtR8UwTchQGG5baY+FIxheaY34PwsRUq0fWYRZ4
 +UsXCOWeMwuKdqgY1w7e6ZwhhYApp0eZEcsuxJavWvMzknmYw+eKz09yBjgMJN3iz60NFSuMtpg
 4cSNsWMDIxWGsAvFVzHLNGCsjQ72mO8ft/G0GSiSU=
X-Gm-Gg: AY/fxX7BU8/w1OacCPYjw7j/qyMCN6goWgzXi+U0pYCDx6N1HYOGwGhEBLhFy1UHrv/
 hgk/HB89+U7+oU1X0Dhig2zB3Mem1Wl6EcyN4ojvv2it0I9j50CSDAueC3zpqZUnzIGT2fnF9tj
 SLTDxGtkSMtQiRaA0VGhf7AayY2IbQWLGZWXYXmUW5i3STf8zGkqAW1MZQuhNpUHQdEiOPMaXot
 TEOdvR8ZrColFts0DjkvRfNIpNl0nTSak/ac20SZ3cmxF4169hKLFopQZdHN45cIaN9LJpCHgQ+
 RtHOJQG+cFliXIJ3665a+M313Y3X9sFzCbIhJ5v7tWsA3bSnYvUEUDAi+3tsRRaHRbbufVub+kD
 9kla4tuWsfkHJv/QSRP2hqIfts8YSSk/Um3xA0OZRLW5bEAracDUPCFvmjOqlNjKzl9jfNvn5in
 JITY2DsUGT0zhXPokztF+AGCNF7IxR2Pxub9NJF+G3fb3uwMs4W+GUGzo=
X-Google-Smtp-Source: AGHT+IETBxd7vGdqrmYgS0+oJETTn/2g1uW4xrfHiTyJc6Cs6j4BbEm9Stztw0c1H/lsuL9bcAQHbw==
X-Received: by 2002:a05:6a00:6c87:b0:7f7:13bb:8f20 with SMTP id
 d2e1a72fcca58-81b7fdc34ffmr5786796b3a.50.1767885444715; 
 Thu, 08 Jan 2026 07:17:24 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:24 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 09/18] target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16
 to OFP8 conversion for Zvfofp8min extension
Date: Thu,  8 Jan 2026 23:16:40 +0800
Message-ID: <20260108151650.16329-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
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

According to the Zvfofp8min extension, the vfncvtbf16.f.f.w instruction
supports BF16 to OFP8 conversion without satuation when SEW is 8.
And the VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: BF16 to OFP8.e4m3
* altfmt = 1: BF16 to OFP8.e5m2

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 9aafd4d2ef..16f4403909 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -67,11 +67,20 @@ static bool trans_fcvt_s_bf16(DisasContext *ctx, arg_fcvt_s_bf16 *a)
 static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZVFBFMIN(ctx);
 
-    if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
+    if (opfv_narrow_check(ctx, a) &&
+        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
+         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
+        gen_helper_gvec_3_ptr *fn;
         uint32_t data = 0;
 
+        if (ctx->sew == MO_16) {
+            fn = gen_helper_vfncvtbf16_f_f_w;
+        } else {
+            fn = ctx->altfmt ? gen_helper_vfncvtbf16_f_f_w_ofp8e5m2 :
+                               gen_helper_vfncvtbf16_f_f_w_ofp8e4m3;
+        }
+
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -81,8 +90,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
                            ctx->cfg_ptr->vlenb,
-                           ctx->cfg_ptr->vlenb, data,
-                           gen_helper_vfncvtbf16_f_f_w);
+                           ctx->cfg_ptr->vlenb, data, fn);
         finalize_rvv_inst(ctx);
         return true;
     }
-- 
2.43.7


