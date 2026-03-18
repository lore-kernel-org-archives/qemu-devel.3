Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96498107BCF2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oCu-0002MO-0f; Wed, 18 Mar 2026 06:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCD-0001aV-Da
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCA-0002Qm-T8
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so43328105e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829929; x=1774434729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIB2jgD4xNIjEX+GJ6lU/gnIpJ4tgCJCIcB8p5M/dOE=;
 b=Q8w1VLZjBH3tlOaCYfA5ImwfmaxV0cyY4vJUTFzbomUmEhBr7rM0NOrwqJXXWg0EWx
 w4UK+QFNCItgMnvqbbzzGZfxozbpkxOSwWFi3Sh8dcynfHd+eOvf1q4qoRFrpOWJNs6c
 A/p/pnnWbgrT5Ow9QWtddPoTeGZJcPVnSrYdlHzjnpIzL+t15fJEPWVvdqxK0MtcUBkJ
 N7pMgHsSEL60a7fFiwL/pln4BTXCGj9P9TFR+CzUaiOBdZR8F1D8CyZkVuNyynW8AuqS
 pT86PtZx4iOM4RwgufeO55wnO89WMXsbxjE9W+5XQ23ji4rf8yG1XkQwgpW3wejZ3YnE
 38wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829929; x=1774434729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NIB2jgD4xNIjEX+GJ6lU/gnIpJ4tgCJCIcB8p5M/dOE=;
 b=tNMO/mMuW25ztAMVGEwmwaBMI8QKR0IHdMP917B1ZJmvnAlBTOJmISq8Md+40CyQkn
 YZ9Ivt2sgxWwwuonY/ozqRZWaeVQgUMvvnXaGTGtqdrdMPcTUZ6zx1jcVUGtNYJ8rSNU
 OKLzaQwqcnsdHdYti4b5IYa/7w7RMr2xrI7sFQSszTvOqsmmBmmdfzUl+wsTZcYb1pTk
 y5RmFNikNSP8otqmvY5f9UusTI4DS/sC0Km5xnXg+mZaUS1SxAi3A7atEGI/wr3hh1Ud
 ZdqgiSsYZl0BNEGpYO0C+IKdeDxIlo3LKcSLI9ivvOMpwW/Jwd0tahqXH8TSdzGdfFNt
 J3lg==
X-Gm-Message-State: AOJu0YwvI3k+MD2PSm7AgvI+sqEWZfyg2U4n8A4Xr3hcklkjK2JwKV8O
 SN71Z4HutGlVdfKl9ePsvyD6bGlwd20HppNOqocTgxay6cwKdY4+PPqjYoNOIXFUv9fbS3koCHL
 xCMBtxkU=
X-Gm-Gg: ATEYQzxpWvG/LWG0hPUTSm/na4iMwET0AgTJ6rs2Htp7nhWNGwsYCT25bVjBVt0pBul
 umivXk2XnnB6VP0ZnY6jiqi3kzA6kB81t2OFcj5DI2IX6ONvn1N3vMQgPGjUkNeZ5z11/4aw6B8
 mUo2p9pThMmjdJSzJ2f6VjnCd9NmWRS7cat86nsMnKE1hgFeTWcCAEi/VHpLHIAePXyHpPRKfCC
 5zojBnlXZbBpLg2hsl4I4/fAXTZgts0EKHMqD6oN8f4yTILIa36iWIOHLzQ2KB1ZMoWLJlfpnED
 AKgsZaASfwRC3w4wOFk6tSYR5FWdEYAVsaQcWEtWbta83wWe4A6TcW50jiT2e+2ziRnj0GyXHoc
 voRv8rL7y8Z1NVtGL01Iyk/+7PrQ4n0CwhGiFGM0B1w+I9f2g95WmaYHJSn5F0WiHbwFxyLBYRj
 MUNXkekTwqQOi8mpo0CGSGesP3idiO6dB4OIpXApU/nC8TuoxkrgZW5uL4GdhQgVuZw9pKJKmLX
 bR/Ehhi1gQ=
X-Received: by 2002:a05:600c:620c:b0:485:40ed:2d1 with SMTP id
 5b1f17b1804b1-486f4475049mr46242905e9.17.1773829929046; 
 Wed, 18 Mar 2026 03:32:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4b810c7sm21678975e9.12.2026.03.18.03.32.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 06/16] target/riscv: Conceal MO_ALIGN|MO_TE within
 load_acquire / store_release
Date: Wed, 18 Mar 2026 11:31:11 +0100
Message-ID: <20260318103122.97244-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

All callers of gen_load_acquire() and gen_store_release() set both
the MO_ALIGN|MO_TE flags. Set them once in each callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
index 525f01ca347..2b1f73f650b 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,6 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
         return false;
     }
 
+    memop |= MO_ALIGN | MO_TE;
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -43,26 +44,26 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
 static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
+    return gen_load_acquire(ctx, a, MO_SB);
 }
 
 static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
+    return gen_load_acquire(ctx, a, MO_SW);
 }
 
 static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_load_acquire(ctx, a, MO_SL);
 }
 
 static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
+    return gen_load_acquire(ctx, a, MO_UQ);
 }
 
 static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
@@ -78,6 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
         return false;
     }
 
+    memop |= MO_ALIGN | MO_TE;
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
@@ -90,24 +92,24 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
 static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
+    return gen_store_release(ctx, a, MO_SB);
 }
 
 static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
+    return gen_store_release(ctx, a, MO_SW);
 }
 
 static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_store_release(ctx, a, MO_SL);
 }
 
 static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
+    return gen_store_release(ctx, a, MO_UQ);
 }
-- 
2.53.0


