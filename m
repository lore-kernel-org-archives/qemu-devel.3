Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF55C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 07:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWA7M-0007HJ-Uk; Sat, 03 Feb 2024 02:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7H-0007Fn-BM
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:07 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7F-0002Ym-CW
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:07 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso24198895ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 23:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706944024; x=1707548824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enqyHM/qlHAKrvGyjKOBiar72kS5zHVgEoJYNNdlxDQ=;
 b=OvvhYBRmq6fhJX5HKZzVatISJ5OYfLnqWflWJgh0hv98tJDnOy1JsuUqtg26Dn3Y7J
 vCPQUqCB6IEFJrk6jirkdy9OJ4Mu+S8bLMxGjdPF5WgTDQYxqLRqk/cnZMcs9fk0fCcf
 aU19DoCGQZoiveVjAUqjHBatnCUYSz+Hv111eabBG7q7LOAtZzgxYHgmlg43ikqi6VGw
 nN4WoNMI8WutZf2nT7CJBa+YR5wyDrevOOv/stkIub3gegwUUZ/44nzQ2oMLKc/rw2VN
 CuMMbIjLn8g4Cs4fUFib6YlhJ2V8MDn1f793uynmH8QU0PYczijQJUScizR9ikIQ89Pa
 JQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706944024; x=1707548824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enqyHM/qlHAKrvGyjKOBiar72kS5zHVgEoJYNNdlxDQ=;
 b=EOkTB2Xdk2Bv2S9idMrduXwO93ctfU6rYMU8NlT4GraNICKRqZEB4E7wM9XzBCklLW
 eUS7fTY36SfDcF4OuYU6QEeMSgV4JnxfOqsvciSJXaeCB/d1ogK6Fm08YazMPuv0WJHk
 NZJ6KV7yr+t5WdzVMDF1ZyKaqB5bsNvXtLypKaXpKErXQO46dhpkgdGaCz2pwdhnZLv9
 FlzKHjoUhFoTAcr16caNm1ZMUOfpn0peWpURPa50xKhQOqlgP/hEEsAuOqgkhV6+npKJ
 Lc0DjvC61CcIInlI7qbbjvMrjyEL2Ag3OV07J4tpnCejbUHNc92cSSEQOzRlwDcISfuo
 2bJQ==
X-Gm-Message-State: AOJu0YyueDqRXwZkUIG8CjDDCtyAEJXFEnVQ9WXcEm1rUem1Xrqj1KO9
 uh6vdUV+nSLonqehaHrfe2vtj0LvGsNLkFPnMS22je7pEME00oVp5nqvUEgZj78QkZGFubmd6ua
 Bsjo=
X-Google-Smtp-Source: AGHT+IHViOtRbZhROnxs3QdUtLcpQolV4d/UXlFx8/MzpjpqpsajFpZmc/Y6WetTeU+tbUTHdTqQ7g==
X-Received: by 2002:a17:903:904:b0:1d9:8b4f:90ab with SMTP id
 ll4-20020a170903090400b001d98b4f90abmr1868935plb.27.1706944023776; 
 Fri, 02 Feb 2024 23:07:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWSm3K5DvU4+oYjJvdQYAM8aJVoOE2pqF7LrlaAxtlPBHC3Wd90CLN5uj6JYaRgvTC6pSCZrsUBnEKFQynT7vBtDs2q
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d08b00b001d94665e9d3sm2658034plv.45.2024.02.02.23.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 23:07:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL v2 35/58] tcg/loongarch64: Set vector registers call clobbered
Date: Sat,  3 Feb 2024 17:06:53 +1000
Message-Id: <20240203070654.982407-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203070654.982407-1-richard.henderson@linaro.org>
References: <20240203070654.982407-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Because there are more call clobbered registers than
call saved registers, we begin with all registers as
call clobbered and then reset those that are saved.

This was missed when we introduced the LSX support.

Cc: qemu-stable@nongnu.org
Fixes: 16288ded944 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2136
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240201233414.500588-1-richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index bab0a173a3..dcf0205458 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2327,7 +2327,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
 
-    tcg_target_call_clobber_regs = ALL_GENERAL_REGS;
+    tcg_target_call_clobber_regs = ALL_GENERAL_REGS | ALL_VECTOR_REGS;
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S0);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S1);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S2);
-- 
2.34.1


