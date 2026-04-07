Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E22A10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXpN-0001Nc-3G; Wed, 08 Apr 2026 14:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXpL-0001MK-FY
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:40:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADYy-00026W-EA
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:02:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so74154375e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775595739; x=1776200539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pEHtRozxbaRsO1Z0uPRcQlJNySfPOxEqqvINVBJS1qs=;
 b=KAL9F4C1hSSWVbV4dW0quA1eELm1ptEBzgrurGAGUUSq/yGS/j9Ertc4aqRCJSJV8B
 25nUtG9R4STzYL1kRMf6MWfhucgwtovdlpPVbAcsRAmO1XzY3xjIaOMFJbvHozUsT0U2
 m1QGBIXxOcDMMLev9a2Aw/FKQjxCRQErCG0Ul/vg/JN0s3ENPMwx8E41znG+hEnGsN5v
 F4PSR0ykVw+jqnBqYkEpTZYoAc3aJqlyQ+wYH5xarXjbqteZJuJlnHnMRi9tvWT2lFl+
 T4lvdYyP07XymgJUGv+SC6XPbo+vRlKEV7jrlNbQTU3UdcMmiqIreTO8au8GLiQ4kaOt
 kTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775595739; x=1776200539;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEHtRozxbaRsO1Z0uPRcQlJNySfPOxEqqvINVBJS1qs=;
 b=LNZncQuOUTc7IlFY4rUWsHFzUYhxMIDry8EH5QYsU10A1Id+zh898GJrE7KiKbEGc8
 9vbJ5MOhbMdRm25+bdlnzDgn4Zje339AkgWXffBCKIPPxxPihzL+hp2MBpRW05PRZoeI
 a7NmTbCRNSmHt1NyCr4nsarQgyVIGq5UWH8O8EUwBsOpBjHzJA+YQjr327ra8y5ANBhi
 hP19JYE+RPHKpRxBVjx9/rqHSIrGc57MgnMiKz7HqjJP2XfcO9JTdOB9AvsZPmMzf2Ic
 u+DZOobtpHbf4Y16fRBAwxCLI+Hc1+MIIj6PuWn0bfWOh0QWgjLwJ2ZVzUnk7LNRfLzu
 8E/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb1ADqWYv6TCiu7UG5BWIEru6keTa3MN9Q0pnGDbu82jtHkOf4KBcJlL1gXq3aP6wc3JWkWPxRsjLB@nongnu.org
X-Gm-Message-State: AOJu0Ywi9hpNedvPNPIcGgKQvAeDF0P60kGdjFfiN4LO16NogAN6XCB6
 r1fnsoaBhA0+yy4aWZEATCKDFVsPBnY4nNVALwlE5vx6hcp86nnb1sNuXOotZdCwrRM=
X-Gm-Gg: AeBDietpH39sHYpTXV6kpe5VYaPm/G5mV4bBqv/f9tR7IzyMRrsTbEp04L6ArSpy+xk
 DF7Lf1dhdjwwdEilLwyOEwWmMKbP9OFkb5aZZixX1oI/xuh0lfhqGen7G5y5MJAInb4kpxrjnDJ
 gXYoljvXv3mCNeg4DQctddkF5FbNZzVsC+c8W2qTP5Cr7dHpKF+hPGCHGyjliSrxb24yQ56RWHn
 2KBp9XAPBYs0sUdN+t8k7hL2kVvpLX0cy/Y1HygmPkxNDonJc2FbB6r4k3o7G3rzKxGhhJZHPC1
 k9UqA8JlYZ69mfhpUMH8eyEpy1kzQYXVqnsGa5BIzki0+aM9jZNti+AhX3CxH9n3ghDQXhNbNTo
 /cO9vf7y90HIhkic1js7iGEwiq8o8gquZuq5P/5VvnNTREH7XK2dWxzYuGgwc/NNTwKwWcFunIi
 Don3xbLRuvn4Ox/FbuN6KPPwvIiTelTZoVNI2PXWQUNKJITLJlORoEuF2r3T03hTUGRw==
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-488996d23femr236502025e9.2.1775595738616; 
 Tue, 07 Apr 2026 14:02:18 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488940e075esm470003405e9.9.2026.04.07.14.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:02:18 -0700 (PDT)
Message-ID: <c18cb395-afa8-42c8-aedd-87863d49befc@linaro.org>
Date: Tue, 7 Apr 2026 23:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/21] target/arm/tcg/translate.c: replace TCGv with
 TCGv_va
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-16-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407195922.196410-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/4/26 21:59, Pierrick Bouvier wrote:
> We know this file is for 32-bit runtime target, so we can set
> TCG_ADDRESS_BITS. TCG_TYPE_VA is derived accordingly and is already
> passed to translator_loop.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index fa4c7907dcd..0b3b4ab86be 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -22,7 +22,8 @@
>   
>   #include "translate.h"
>   #include "translate-a32.h"
> -#include "tcg/tcg-op.h"
> +#define TCG_ADDRESS_BITS 32
> +#include "tcg/tcg-op-mem.h"
>   #include "qemu/log.h"
>   #include "arm_ldst.h"
>   #include "semihosting/semihost.h"
> @@ -910,14 +911,14 @@ MemOp pow2_align(unsigned i)
>    * that the address argument is TCGv_i32 rather than TCGv.
>    */
>   
> -static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
> +static TCGv_va gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
>   {
> -    TCGv addr = tcg_temp_new();
> -    tcg_gen_extu_i32_tl(addr, a32);
> +    TCGv_va addr = tcgv_va_temp_new();
> +    tcg_gen_mov_i32(addr, a32);

The implicit TCGv_va -> TCGv_i32 bugs me here, but the overall change
will make my sleep better :) So:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>       /* Not needed for user-mode BE32, where we use MO_BE instead.  */
>       if (!IS_USER_ONLY && s->sctlr_b && (op & MO_SIZE) < MO_32) {
> -        tcg_gen_xori_tl(addr, addr, 4 - (1 << (op & MO_SIZE)));
> +        tcg_gen_xori_i32(addr, addr, 4 - (1 << (op & MO_SIZE)));
>       }
>       return addr;
>   }
> @@ -929,21 +930,21 @@ static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
>   void gen_aa32_ld_internal_i32(DisasContext *s, TCGv_i32 val,
>                                 TCGv_i32 a32, int index, MemOp opc)
>   {
> -    TCGv addr = gen_aa32_addr(s, a32, opc);
> +    TCGv_va addr = gen_aa32_addr(s, a32, opc);
>       tcg_gen_qemu_ld_i32(val, addr, index, opc);
>   }


