Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D82C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXd8b-0007PX-4n; Wed, 07 Feb 2024 03:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rXd8Z-0007Ou-UQ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:18:31 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rXd8Y-0005oS-DN
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:18:31 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e12b917df2so198262a34.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 00:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1707293908; x=1707898708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aicKXpUQO39cEI4kVtjxvQ6+IcJ9GZuamadBnr6FUGA=;
 b=Bw48r2g/LjuWWyJzog7Q1noWpmyCK+apxIb1oXj15BDPmeMd10vkcVRwwGU1OMDVb/
 j1s6xUZDQC2yaOdOPeAwJNsPQRhsemN+9mFvzbc3Pm89mwLIYUr7POsClznadrhvAT/V
 /tLXNWEg2vtnj1f4OBCdT/FmFis2Hn5NXDpzO+SXl0wALZbtuk0uPYcJbhRCYg/akWw+
 B2ZDMTC67Wk5BzfxD6h/imHAhqZ+5CDDoLe4oBDnfEoato68FN2xA3vypdLILf+Vqitf
 01J85syw+/TCGlEAKPXmemt1nCL1ZF7V8oh+6ezigZJUvjemjStbU8o7px17L8ucaHoY
 NjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707293908; x=1707898708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aicKXpUQO39cEI4kVtjxvQ6+IcJ9GZuamadBnr6FUGA=;
 b=amCQ6KtD2WZwVUMORJU6ZaWZZKcfgwu4SBT3904YCrm582cSdlK6jqMlDMImR2nYK0
 +KJhwSmGjIQoDVWO+/UrqpM7EwbiInu/U35Gx/zC+grnUXyxMn2ZgmB+vt9Whfb1ELDZ
 hA02oTU8j1gP+jHh+bJDAYSD2t9qfjL9Ht8hDorAjdkeYvJUCj/rqDCZY18dzlfXjlwe
 gjokN3ojdNM587txTlMPjwnW/SgUypa/rNMgGOsUTYmnAjR58y46phQGJ/cgcAszyMru
 xkM5WqeksuwtqP9Ks8aiBUYk4xGl3bojoAjSysfMvwYQxMioVH8YeX4xxdAfCeND9NCu
 a2zw==
X-Gm-Message-State: AOJu0YzOm+hASnpH61KYRQ2Tmqj2RE1ZwOlJUPB/M6ZZbbw2lEezWHZd
 q3Sywin1Wv+FJSIFnQ96r0PELgwez3u2jxdBfh1DBYIuWkHgMxyuU8rNeBhd/9JiKWEYlUhTR+/
 valQTrW52EdMP5hmOivW+mkrQuRU++jzLsJmCgUloM1dkG8gFYkVyCWaRsFT8p8YgZYnM5ndIY8
 Ta5A7Q2s9duIi/sQIROrGt0hWGcDrma6/lFZGoSVTeCn6o
X-Google-Smtp-Source: AGHT+IGTBn8o9y+pTeqTANSczOYbrrMndwzzgx9b9kvnq0knaxfs19z9Uwlxu9xZ5Cz64YUUct/Ifw==
X-Received: by 2002:a05:6359:2382:b0:178:9756:34c4 with SMTP id
 lm2-20020a056359238200b00178975634c4mr1831354rwb.30.1707293908016; 
 Wed, 07 Feb 2024 00:18:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWGV/lMBmSg9cZcmBtWy7aayQUnsbilK6p0HqNrfMfx22PChgoEwbRWQTX0Rkx7IdPML8754oSPX+DNQc5tRMpfa52G7ukxOgr9MWnpDBaCcLz2vM7xDknKmW3VbYZ0Wtj0NkDVN6TQBdB44bm1o1f/RujoKBAA7/UtVIIjSq/ccMT0WOeE3qf2vEJ1TNx9PPGcCKRxdBfLxNr4qtP4JzQMErz1XE4wAOlvSeNcSnjwVNYsQh9lcjlfG3aBiVw5IaVuKT6m/R7bGS5kWLk+RpIs0QsOvYGCjCf6sIrOP17EZUAiZ3TsNmwVgSWLNmb4BG6hkgNVPTrSuUQLm2A65MtZvrJAbM/umo72tQqnLHKEGeh0rP/SqZpEldN5ESUUnI/UmpnwywIRnHxYEKKu1YrU1+OmxCXV7zAolEjB
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 cl13-20020a056a02098d00b005d34cf68664sm772294pgb.25.2024.02.07.00.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 00:18:27 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/riscv: Update $ra with current $pc in
 trans_cm_jalt()
Date: Wed,  7 Feb 2024 16:18:08 +0800
Message-ID: <20240207081820.28559-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=jason.chien@sifive.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The original implementation sets $pc to the address read from the jump
vector table first and links $ra with the address of the next instruction
after the updated $pc. After jumping to the updated $pc and executing the
next ret instruction, the program jumps to $ra, which is in the same
function currently executing, which results in an infinite loop.
This commit stores the jump address in a temporary, updates $ra with the
current $pc, and copies the temporary to $pc.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
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
2.43.0


