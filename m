Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCCAC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 02:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTOa-0008VS-VH; Tue, 23 Jan 2024 21:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTOZ-0008Tk-0e
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 21:53:43 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTOX-0007m2-DV
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 21:53:42 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so282187a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 18:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706064820; x=1706669620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JFieydBCAuUG4qyHZIGK+aTH2JJN0Bvh1QrYsB5q/I=;
 b=vGWWMcCmOAYcfefDaT3NHqeqehIgraBf8VWKMCzcqT4WAgBPHqr/eFnasWEB4q3tKH
 cAqSsKEguOIrPFMV9fkENRFcwKCP3YryZY81pHtlqI1Ou4ojsm2FBxotshPEKPKWue1Y
 IjIZMqUU5jEudkTDLOKBcn1mli2YJTuNSLGJGF5jMUfV2XRjGwAse4RnALJqrFouBFmA
 H2dkW/GYUlv0AwkZ+y8+7gRhAHSl6G13bw0QAW1mujp4+YZBneRV0Gch9X7A0bofVweK
 zjxgQWWINJ+PSWwyCFyjAVwqVffEx+58KLgOuMW8ptwdeN64bq1ji0MPqhTZ0WkcMhIi
 mpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706064820; x=1706669620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JFieydBCAuUG4qyHZIGK+aTH2JJN0Bvh1QrYsB5q/I=;
 b=eFNxXLSVkic0cnABXIy5iKI9uEOj4GtqE66smfr9yshsejJwhtoAN68Q2wg5Cljnal
 GiZwXnY+9K6JUykIIER6gCzNdtSDGP5Yc4RCpBcO0e0Qd4xp2frZtor2xNEw2m4djPZs
 I6jsuDFO+MGnz7x8rqLabiMiO+5vkzHl+7aVkkWer0xgvqap6CXNNoaEqBpHfpvCX1Sw
 sHPZwtZOfsrjogQJ5L22srRR80UF3XN41QmZgyh5iRdmA/Wi4ZKAH3uXcLpCLAs9nZ1X
 tdicGMbSvOzBZTOUv6JImdZmYCsKOApln96IdFgYfI/CsvbY6XVTO5fOHl6IDizlIQnO
 W3eQ==
X-Gm-Message-State: AOJu0YxmHnh9GbJjRInuW10FGUVpCD3joQpGNhwf1VkV96ZtaFhoCXNk
 DTc9CjV/UJkewlGXuwsHn8rFpe+6aRtHJloUMhxZwxfPi+toqyABZ9aDbtsHorE=
X-Google-Smtp-Source: AGHT+IHmI9uIkBTBwNtS4mTf1kIynWtWIDoA5m6teWTcV/fBlEl4uh6S0MSaHOA0DpVYT6p5Zx9xwA==
X-Received: by 2002:a05:6a20:3b26:b0:19c:61bc:cd10 with SMTP id
 c38-20020a056a203b2600b0019c61bccd10mr118644pzh.87.1706064819721; 
 Tue, 23 Jan 2024 18:53:39 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 ke11-20020a170903340b00b001d720323d54sm7664493plb.191.2024.01.23.18.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 18:53:39 -0800 (PST)
Message-ID: <63dfead3-ddab-4502-b3aa-b7481a4f0ebc@linaro.org>
Date: Wed, 24 Jan 2024 12:53:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/34] accel/tcg: Make translate-all.c target
 independent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-28-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-28-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Makes translate-all.c independent of softmmu target by switching
> 
>      TARGET_LONG_BITS        -> target_long_bits()
> 
>      TARGET_INSN_START_WORDS -> tcg_ctx->insn_start_words,
>                                 target_insn_start_words(),
> 
>      TCG_GUEST_DEFAULT_MO    -> target_default_memory_order()
> 
>      MO_TE                   -> target_endian_memory_order()
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/translate-all.c | 38 ++++++++++++++++++--------------------
>   1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 9c981d1750..a3ae0c6910 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -65,7 +65,6 @@
>   #include "internal-common.h"
>   #include "internal-target.h"
>   #include "perf.h"
> -#include "tcg/insn-start-words.h"
>   
>   TBContext tb_ctx;
>   
> @@ -106,7 +105,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
>           val |= (int64_t)(byte & 0x7f) << shift;
>           shift += 7;
>       } while (byte & 0x80);
> -    if (shift < TARGET_LONG_BITS && (byte & 0x40)) {
> +    if (shift < target_long_bits() && (byte & 0x40)) {

You just make TARGET_PAGE_SIZE etc target independent, right?
So you don't need this?  Or is this because of user-only still.

>   static int encode_search(TranslationBlock *tb, uint8_t *block)
>   {
> +    const uint8_t insn_start_words = tcg_ctx->insn_start_words;

Ok, because we're still inside the compilation context.

>   static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
>                                      uint64_t *data)
>   {
> +    const uint8_t insn_start_words = tcg_ctx->insn_start_words;

Not ok, because we're outside of the compilation context.


r~

