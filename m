Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC83EF589AE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtHt-0007tf-S2; Thu, 23 Apr 2026 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFtHq-0007pn-G7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:36:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFtHk-00014f-SJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:36:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so31298885e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776947759; x=1777552559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QLzYsEeo1H5y7cODwI5WfN2h4MJyTe8w40oNzlVxZbc=;
 b=rTrAuVN1BVD0jn8LFG+0U7IETMZ0b/6m4hdybZSty1LkHGm6G3pCAtoPoYUgfw86JS
 IY0QvcbVQXzEAhNl+euynt5V3f7G+WIrJXScnWKiZ66TQWeh3dCKoMhppO3GlPphIZx1
 NucCK6GPVvjugG5GXq3d0/McWy1g6d4che/HAFAZBjJ/UIrjGZ3VssbGtznDPwGaTO3Q
 q6/pnaMtpWq8gmSbKd9u2/2xlFNV8oJxrbr9C6D3EbzSU2m3nLsExQNNGVWRxzEZ/Uxx
 VHbVlHl7mN4NF8P3RhPS6UbkMP+I+YKA43z7xTBakMMZiaRcN8ltXD+DCf1WYuLkegEV
 YfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776947759; x=1777552559;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLzYsEeo1H5y7cODwI5WfN2h4MJyTe8w40oNzlVxZbc=;
 b=N2bo8St7gMWOQAAvQ861lEqBgljB/vXgqzpyuRxgMJr1NZNnRHVT7CwSlVTI5m1t1O
 qbBzfp8tbm9dPREurpg9hOwuIQtjra14qIe09zpUtdUczYu+K9qxivlW+6Jc+YmvWLzF
 Zpq6u9EOlCpwGJCkrj8SoBEVNpXTepBYlAh1JoogqPNqGztM35q6AGGWzC7PQ70HLftG
 k317cLlF6iwpT5IxnmjgMcuKjiASvOClUlcw3oGNblMOYnhZ4nocaxxV2eXsL/EAotO3
 GBjOKcaKLYUE457hBJFIXvXLT650ANd8VgZgbTipwFn1geAsmmsZTtyed35FaqNAq/af
 3NHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cfUdBJMxer2FgN81D5NSs/HmA9oYzj2/0YWAkIsDmq6SjuWIFul7O+aEK33V/rstmGt/ROlSDEsZN@nongnu.org
X-Gm-Message-State: AOJu0YzbKytyu8HA9RSSpmlCXIbIJoFpyGl1bM/TDSnkRTPi/T/Dxs3T
 MZYpxDgQ5qvBoIi/5EaWD1Rti6rtF240oVdhXaor/dezs/+ZdHU9LkN71jnX+wi8F9pQJ5hfemm
 rkIzFr54=
X-Gm-Gg: AeBDietsoGM00bI+LGAp8bc/iEPRi4XZbX2CJys6/82ZvFybHaCKnAP3ClzptagiRrT
 RnJ0JPTXhm84qD39gNBRPxnW61FYtYAdvmlrpCwNoTIEcXDuulMhUItuYagJ0soWhJtrJrB3xhG
 L+yDRylPh/9eDh1u/5cJ+NLc40Ig96OBRhLDB3tQ+ViIqNs6YCQnBB+WdiL7cWdJzUbRCukx7+e
 DKeQZeGiFUosZ/o1MGwKGLfsZiqPGtgpJ55aIsoc+hZevk2ArW/6nHHnPATzOjP+HE3iVbJjyOk
 O4G+fx0vRBW7I+Z6qDLNYWXTuzckprmzTMl+t4oMqg6SaKHUscXSBYHnpQtOkt8GFqZ5X5Y9hr3
 2UxmR2CX2Mgr7WDueNiIn0WP3kTW7Qtteflmz++iWSR4tNKXLx496Msi3+CnFcbWBfqvRoLUVbH
 CX+vtmLsDfnCcVeN0E/kZkyrCnMqedDQfm2I574prZ7TnN3T6+fEu4v4LLkeLa01wfnbACOVlwj
 TW9
X-Received: by 2002:a05:600c:8183:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-488fb750809mr396554285e9.13.1776947758429; 
 Thu, 23 Apr 2026 05:35:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a06f3sm190687685e9.22.2026.04.23.05.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 05:35:57 -0700 (PDT)
Message-ID: <51498985-6742-4d9d-b924-07ce873cd531@linaro.org>
Date: Thu, 23 Apr 2026 14:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/59] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
 <20260423100229.2941820-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423100229.2941820-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 23/4/26 12:01, Peter Maydell wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> This new header defines a new type for target virtual address,
> independent from TCGv and is parameterized by a new define
> TCG_ADDRESS_BITS (name was suggested by Paolo instead of
> TARGET_ADDRESS_BITS).
> 
> By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
> it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
> set TCG_ADDRESS_BITS manually, which is what next commits will do.
> 
> We preserve existing MIT license when extracting this new header.
> 
> Implemented from:
> https://lore.kernel.org/qemu-devel/a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org/
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-id: 20260407222208.271838-2-pierrick.bouvier@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/tcg/tcg-op-mem.h | 126 +++++++++++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h     | 100 +------------------------------
>   2 files changed, 129 insertions(+), 97 deletions(-)
>   create mode 100644 include/tcg/tcg-op-mem.h
> 
> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
> new file mode 100644
> index 0000000000..36931d1dd5
> --- /dev/null
> +++ b/include/tcg/tcg-op-mem.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Target dependent memory related functions.
> + *
> + * Copyright (c) 2008 Fabrice Bellard
> + */
> +
> +#ifndef TCG_TCG_OP_MEM_H
> +#define TCG_TCG_OP_MEM_H
> +
> +#ifndef TCG_ADDRESS_BITS
> +#error TCG_ADDRESS_BITS must be defined
> +#endif
> +
> +#if TCG_ADDRESS_BITS == 32
> +typedef TCGv_i32 TCGv_va;
> +#define TCG_TYPE_VA TCG_TYPE_I32
> +#define tcgv_va_temp tcgv_i32_temp
> +#define tcgv_va_temp_new tcg_temp_new_i32
> +#elif TCG_ADDRESS_BITS == 64
> +typedef TCGv_i64 TCGv_va;
> +#define TCG_TYPE_VA TCG_TYPE_I64
> +#define tcgv_va_temp tcgv_i64_temp
> +#define tcgv_va_temp_new tcg_temp_new_i64
> +#else
> +#error
> +#endif
> +
> +static inline void
> +tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
> +{
> +    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
> +}

Missing:

-- >8 --
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 36931d1dd57..ea35a02fb40 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -12,6 +12,8 @@
  #error TCG_ADDRESS_BITS must be defined
  #endif

+#include "tcg/tcg-op-common.h"
+
  #if TCG_ADDRESS_BITS == 32
  typedef TCGv_i32 TCGv_va;
  #define TCG_TYPE_VA TCG_TYPE_I32
---

"tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h":


   include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 
'tcg_gen_qemu_ld_i32_chk'
    34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
       |     ^

   $ git grep -w tcg_gen_qemu_ld_i32_chk
   include/tcg/tcg-op-common.h:328:void 
tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
   include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, 
tcgv_va_temp(a), i, m, TCG_TYPE_VA);
   tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, 
TCGTemp *addr, TCGArg idx,

