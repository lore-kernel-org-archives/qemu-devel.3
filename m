Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BB5C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSf-0001Ni-9k; Fri, 02 Feb 2024 00:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSa-0001IH-D3
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:32 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSY-0001rX-7x
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:32 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6e118b528aeso875705a34.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853089; x=1707457889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWFZsOSqQ4Z7s/RrBOUjbekx6H9vQkuMkzZGGFe3Im0=;
 b=W7YdEQnVTZm1E+XRNk242GMHeNWOH1qFod6Kmi88nZ/KBAE9M2q7eLcFqNdgMT3gR2
 opKvTg5ZO51oVx+/rugUpNpvWpmNae5kVC21Ypto5+qvjQLHmnGUszEHyQlSPjcPTijh
 yFM4heYRMVWhED/DQf7rDrBR6CzRx4eYslbzanEPOZzyWzBDg1Znk1/RY1a+G7Qc7/rq
 uiIIi5i/ARuiO41z+e3C6Pnm2AqSGm31Xv0COECmCSX/cUNquAK4YDuBduz737vS+WeH
 cCObHpZzjxfR8BB0rPx8Ct3vxfCDUo3hUydbHafzfr/4eCvA6Yz0sFm8GCkqkIUrh0Hc
 tYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853089; x=1707457889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sWFZsOSqQ4Z7s/RrBOUjbekx6H9vQkuMkzZGGFe3Im0=;
 b=Rr3ZPWzv9ckVgivMwNbBdAW6LFyM2RPigieXNBcEHkdjD3ir5u+cnw+x539vkgOVek
 xtKpxrnAqGGUX8yCysI4tbsS5pgc2K6Yqq7iuQWq/3BvwVsEhVkJIMv2KmhxusRzSjDv
 CfrB+e7dwW3r6A1FCsP4tB8X4X+yxM8+TE/dBKb8swO/A+2e1/zKM1XEXKBturzbSFGl
 ii8900aql8OGeZSQnLi7GUbLYNf3KkVj3sa7Qy711uSe5DQeXw5t34QK45AQ/Q3ZZEqp
 DlMbBKxkrZQaiEXYRzCxRJUitYg6yi4i6pKPDhAps3bT4Kk1S1SbEAfXconUYsNXoMf0
 LcoA==
X-Gm-Message-State: AOJu0YxLm85ln99k9Qk9LVkZUgRm6cEfDKVkD8YCUFNOh+w32k/3dw74
 XGpq9T3/qlF4QTsXtQHnKEAutSD445mMJW3X8IiCQVRQH+XBkGHqJCTFXemiWYLTkl1OPtG/fl2
 MbZ0=
X-Google-Smtp-Source: AGHT+IFJwoe2kooifa0wLSBMTpsA4TVctULJ+1tUkgok+1PYGkj+jLrCrulGK+uimCKSZYvRCrVGkA==
X-Received: by 2002:a05:6808:1509:b0:3be:1e78:22ed with SMTP id
 u9-20020a056808150900b003be1e7822edmr5632468oiw.21.1706853089099; 
 Thu, 01 Feb 2024 21:51:29 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUu6JinBY+v8G7V6njozTEJik9Y4q+ycaEF6l+46X2yJyexpTENwS1AIDncXHxt2jm4c2NENh2wZSVKNu9ssYklSA==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/57] target/riscv: Rename riscv_cpu_mmu_index to
 riscv_env_mmu_index
Date: Fri,  2 Feb 2024 15:50:01 +1000
Message-Id: <20240202055036.684176-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Free up the riscv_cpu_mmu_index name for other usage;
emphasize that the argument is 'env'.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        | 4 ++--
 target/riscv/cpu_helper.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5f3955c38d..9c825c7b51 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -498,7 +498,7 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
+int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
@@ -507,7 +507,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 
-#define cpu_mmu_index riscv_cpu_mmu_index
+#define cpu_mmu_index riscv_env_mmu_index
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c7cc7eb423..15f87ecdb0 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,7 +33,7 @@
 #include "debug.h"
 #include "tcg/oversized-guest.h"
 
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
+int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return 0;
-- 
2.34.1


