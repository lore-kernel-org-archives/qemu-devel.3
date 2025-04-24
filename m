Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFCBC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksF-00087p-7o; Wed, 23 Apr 2025 20:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015j-SW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqJ-0004ko-0U
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso510892b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456009; x=1746060809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eY3tVR1Ho6nb9UcI2ivFSVueJvDpQEAHEetuLect7PU=;
 b=cDr+VzZDlhwt8T6a4wZJu2fRk8GXnZ6h5dQg3P+eIhIvQdfs0/sP8xuzRDNHkVaUKf
 GGZNZMNxCRgnd3PA/BB8YbwbncX8vwJsJLVHlD/QJKfLoT7MoKiyV0DZlUGImWrONISO
 kCXmv1A9yVE11USOaUC8rxX5mJ8snETpH6Z952kZ4es/9p6h7gSfTq/lOuHpyf6i15T5
 11BsAfA1IN0oBGv0xm39BFMSEFLtidEtGKI16y9ebBU+jXimjVxFO8dOJrzx4SWxmFaR
 mgpHhB9PSLeN7bqr5ajFgvPGTd+FgDwnLp8ksfyFqoQkTno+oFW3yvB4rsEUudK6fX2x
 ObzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456009; x=1746060809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eY3tVR1Ho6nb9UcI2ivFSVueJvDpQEAHEetuLect7PU=;
 b=uB5se2A8WvRX8cQ2B1h7TGjmYb72Eewj0cjqHHcDUH8d/XngF7jCfG0sNU8XLvPEcb
 YYL1932JvSNTxbh8Yyrlh7V7El1OvAfyEQE5rwlxkggeJ/5K06yB+Eo0PHffUA74X21q
 eK4+Sds47o5QqpWIQayTps/htZovJpOtPADqpiune5Oi4pje4Gw/ck0q5yPwtIYs4Fnj
 2s9sDJhj5M4COt039klThUVTkEFpZMpoBZDzaCxu2mDfamIUcfcigIEe4uUEvkhSA9iG
 HzeUvuwniAj8RwzfcGDkDDREXBrVnFRQggKhr1hnkSQh8lNLgzqPVzLfS1H+kAN5h9uv
 matw==
X-Gm-Message-State: AOJu0YzHIGAiLiULkgqnjlu1BV+cct2yScGJ73rPW7dpJzr87PrS0Ebm
 tTtYh3XgR8XmWWJYbowItxe9uo9zLDnpK4M2PFk0md/ZEp0XLZ0S6Gcn0Ls2uKVl/w0JJ57jMCf
 S
X-Gm-Gg: ASbGncvlf7nm7lNDvys9/Hdk6quEJcQrPOAB2+xqYNKJIFX06lva0es4oJsMrIouNtS
 rHUUimRhxvixWVC6R2gltFWC816/EBfG30eZI3wLuOwytXnAC7ap2dklmA5pIgU6Jx2Q2bWsYUs
 Q+Kwk4Yr/iWBAgxZULx8vvpyAjbkKkK/LfNMo/2gu0GJ7Fh5UCJlSXZkAeUJf2VZfK/VC9VMcpx
 TVQ+38a5cfRPnhKr6hjlL7oJSGL2N9auQr1QiMcZSBrznMX6FrC5XM6Nao2ZbyNt8b3AjI5DbgH
 WL2jpN38Y59di/3xtOBn+RKW6SYcGMuCv8Gv6TPCkDhHFHbDHKMLjJmTRjqVuQeqQAqTx6zXAAH
 mhiPcSp5Uiw==
X-Google-Smtp-Source: AGHT+IGY/Wnjjz319h9oQQM+kQYChLszcDGCN+ptuP20RV1mJiN1azg5Pgs0wdXI5jbZ15xZ/P7YxQ==
X-Received: by 2002:a05:6a00:3be1:b0:732:56a7:a935 with SMTP id
 d2e1a72fcca58-73e268ef408mr482246b3a.12.1745456009574; 
 Wed, 23 Apr 2025 17:53:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 073/148] accel/tcg: Introduce TCGCPUOps::mmu_index() callback
Date: Wed, 23 Apr 2025 17:48:18 -0700
Message-ID: <20250424004934.598783-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We'll move CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-3-philmd@linaro.org>
---
 include/accel/tcg/cpu-mmu-index.h | 5 ++++-
 include/accel/tcg/cpu-ops.h       | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index 8d1cb53bfa..f1ca385d3c 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -10,6 +10,7 @@
 #define ACCEL_TCG_CPU_MMU_INDEX_H
 
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/debug-assert.h"
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_USER_ONLY
@@ -33,7 +34,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    int ret = cs->cc->mmu_index(cs, ifetch);
+    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
+    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
+                                 : cs->cc->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f60e5303f2..106a0688da 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -67,6 +67,9 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
+    /** @mmu_index: Callback for choosing softmmu mmu index */
+    int (*mmu_index)(CPUState *cpu, bool ifetch);
+
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
-- 
2.43.0


