Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF318C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm61-00063D-5D; Wed, 24 Apr 2024 19:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5p-00060g-GW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:01 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5n-0003pf-Pm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:01 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2a2d248a2e1so1154364a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001518; x=1714606318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vkb1QXWH8K0P/RdBZMhJSWyNsEh7cNmhz4uSK4oxloU=;
 b=N1KX8GXZcYsDWXX/p48uQ+T/wxBr5w0Vau1w1+emWoW/ZcUoYjwRgit0bW0DP0BHNL
 pzwp/1R9BH2aXpFg2JFLawMil3a6n+90TEgqzauMoCVarWupXm1Nx/M9QUcGea+I9A7o
 EXE1viX5jAZq7Y7MVy4BmJ9er4L2JW4/vZVTPz16tva9a0e9mFwyAdg9DQTX4Pbhb/XX
 q4qpIFPSRTt3ST0xUCdtEQ40Btjbw/FLfv+5NyAiOomqUt7sUVoRPy1TehjSkBgZT4Bb
 BCP9uPeBoX9Mjs8GATn93TLMJqCV85+S/vzQJFRqrFSB2Kbx8674SM45tN9w+OoMNMct
 61CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001518; x=1714606318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vkb1QXWH8K0P/RdBZMhJSWyNsEh7cNmhz4uSK4oxloU=;
 b=c01iXSLiSl5g9mUraXkKqud4YHvWnTZCTdSC1Bkdl+Hh83cxnEcwrih3lGVlXuhrEa
 Zk0jMPB+E+KmUOPX5c6dgcWt49xby4G7B0Ik5Jppt/cRrPxckb7GXDKHyNLJvAuCpn/P
 rHamQGm1zmbCeDdZlUoENADDFtnYDw+gEyC710CGDnGprfrijRVROx/u2oI0l62QayWc
 TN2EPfEr6OYewgb/+wbdTQENER3bey97poYg3HCC+53nkBc9hTucrv0sVB6K5AiDwU3+
 xpdiKuc/gAQnNRUgUZ8NH3M2dBHkH1xW7NKpZEGufyxIxTP6yCQz7QC8u7i/iuviLjYN
 tLnw==
X-Gm-Message-State: AOJu0Yy3Rz04/YqKx6ynFV/r7Vemw94H6ZncCvQ1XZv3xLpu4KWx6IVh
 zKI5eoZhltXHFqg9Kb0ZVcuDdn2IYDlG39UPmtMVrhpo6ys4p3IPtvQdDJMeyB+6nlk6mcTCPfS
 S
X-Google-Smtp-Source: AGHT+IEhgukgTrqmTm0uGo5X5i1mTpVB6XnHIJtO4O0WGJO+So4MNDHD42gpQuAQLAtxbBq8fKNicg==
X-Received: by 2002:a17:90b:1d0d:b0:2aa:d88d:d706 with SMTP id
 on13-20020a17090b1d0d00b002aad88dd706mr1695037pjb.4.1714001518476; 
 Wed, 24 Apr 2024 16:31:58 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/33] target/riscv: Use translator_ld* for everything
Date: Wed, 24 Apr 2024 16:31:27 -0700
Message-Id: <20240424233131.988727-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c999e942e1..2c27fd4ce1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -1082,7 +1081,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return cpu_ldl_code(env, pc);
+    return translator_ldl(env, &ctx->base, pc);
 }
 
 /* Include insn module translation function */
@@ -1243,7 +1242,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
 
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
-                uint16_t next_insn = cpu_lduw_code(env, ctx->base.pc_next);
+                uint16_t next_insn =
+                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
                 int len = insn_len(next_insn);
 
                 if (!is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
-- 
2.34.1


