Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A997FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9M-0006Yb-2m; Fri, 08 Mar 2024 06:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9F-0006X8-QW
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:23 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY93-0001Nq-5V
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:21 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc96f64c10so15382715ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896327; x=1710501127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syLEtoMRDneJrDhKp8oXy56RWMScuG+MxKEcSUXVGqA=;
 b=fNSxLLjnOpO747bfpbNNN6KhK1qy5LjQQazwcdckvy43eFiPAepwFP6Dyf2OdnOQGS
 PnIrzUGXv6crCzXjN5J6TF8SNis6j+R4SjQozA53vlNTj+eUOjljqQcCfISmF3VRURBt
 DaWIHdo6o46Lrf/UV0yim3NQZ2qCX9cQZh5CLaCDdNK8ZQoPNozwSElZevu5z//xd4Up
 1hp0wyTXfReYaPMQzFkWG1weuWbUYsvHJ/xu3aoh70wm3OjaCcSiwbKU12P+p9iJ8H5s
 jVlhWo7ept3imgTsSjL5H/biHPoAhSqS0vw6vjh93EQ+B713AEPZh4Qd8GV5gVnRdUXF
 OAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896327; x=1710501127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syLEtoMRDneJrDhKp8oXy56RWMScuG+MxKEcSUXVGqA=;
 b=CXeA77EuoVgRAVeg37tc8Xhb07HXlxAsIMMbTtbWoIeR9yDfDOhNWphQBZ+GjvjGya
 uJH/V4YNfpLX9q4vaD0Nj1INxh6VsraKk1Hr5fnmIWhCA4N0bJvzFgyWX6Lfb0ZhmS/j
 RzJYmj/51dWO8H1krssMdg2T2hx6PHEBIXcCIjd5MD1WffykD6MBV5fRucSCYr63f/mg
 YN1rM6P9DHbRNnXbcQbvXqFo29EjCSomqVQg2PAOEP6EsP7UWPKo6P4DzfML3XikjPob
 JOVlpyhhHLstzhMi2DDYJ00FOsrY4vK4AXYu6R13AuvCh/jwWHVfRItnHVbK/d0X7pzK
 7Isg==
X-Gm-Message-State: AOJu0Yw43e7rPA+fqXWz88/4zwHElRly/etpwLeMiS2S6Ab0E0Hkz5i8
 fC6Nh9BvWY+UIl+XFTi/hY5F/cV2uHak8WJao6KEvEH5ddqOFjq6SSXwEP5ww8nelA==
X-Google-Smtp-Source: AGHT+IHHPKKaF0kngO87F9yF3oKTSPxjfK9OGFaXHVZXI2yWJApy+bb3qlnvr1CbUzlkggUq97VTpw==
X-Received: by 2002:a17:903:11c6:b0:1dc:af70:9f78 with SMTP id
 q6-20020a17090311c600b001dcaf709f78mr12418782plh.46.1709896327470; 
 Fri, 08 Mar 2024 03:12:07 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:06 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/34] target/riscv: Update $ra with current $pc in
 trans_cm_jalt()
Date: Fri,  8 Mar 2024 21:11:19 +1000
Message-ID: <20240308111152.2856137-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Jason Chien <jason.chien@sifive.com>

The original implementation sets $pc to the address read from the jump
vector table first and links $ra with the address of the next instruction
after the updated $pc. After jumping to the updated $pc and executing the
next ret instruction, the program jumps to $ra, which is in the same
function currently executing, which results in an infinite loop.
This commit stores the jump address in a temporary, updates $ra with the
current $pc, and copies the temporary to $pc.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240207081820.28559-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 2d992e14c4..cd234ad960 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -293,12 +293,14 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
 {
     REQUIRE_ZCMT(ctx);
 
+    TCGv addr = tcg_temp_new();
+
     /*
      * Update pc to current for the non-unwinding exception
      * that might come from cpu_ld*_code() in the helper.
      */
     gen_update_pc(ctx, 0);
-    gen_helper_cm_jalt(cpu_pc, tcg_env, tcg_constant_i32(a->index));
+    gen_helper_cm_jalt(addr, tcg_env, tcg_constant_i32(a->index));
 
     /* c.jt vs c.jalt depends on the index. */
     if (a->index >= 32) {
@@ -307,6 +309,8 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
         gen_set_gpr(ctx, xRA, succ_pc);
     }
 
+    tcg_gen_mov_tl(cpu_pc, addr);
+
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
-- 
2.44.0


