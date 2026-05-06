Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603B5FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbgI-0003vG-Ap; Wed, 06 May 2026 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKbgG-0003tj-Cf
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:48:48 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKbgE-0006Xu-QN
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:48:48 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so2878843fac.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 05:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778071725; x=1778676525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7srCvn/uwiMbEPkUKhW/TiRw6dfQOOGSd36ct8fxg/0=;
 b=E0A4V1/IPzmiNpNhoQZ8Tnyvh6M+wNvJGheV9fWv7CGyH+wpgYiIeC8Ga4r089qwYu
 ajOHvq/OoDMRSHLf7on81jKXh3WYFocMr4cCGccFMA39O/IYdA/ODUq/pFBBoXMNEEcN
 X+0qYLSLgdThZluFLIaeUos5gwVEmITOCcC275SECypXnoBM024yNtJBFJz4SL2OamXS
 FjWEKVGJf2SHSxRUza2kI4Nh/NyVK1NJkUEs6exPyKUKPBCSDRIslX22PU9uerDeuMdx
 BVrnNxyzhFN3I9UV6QhEPQISwvbKYP2cwV1ogyx7X6LZTmx1BpxyQGNSUmMxJOQN8ov8
 72ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778071725; x=1778676525;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7srCvn/uwiMbEPkUKhW/TiRw6dfQOOGSd36ct8fxg/0=;
 b=MFUN4RhsCbJcOjqsAv5Kl8rqSTwevwhajSZ7Otein8r8RbuyDxPWv/5RZvSQ4Hvw3r
 GX3WjBw5msYRMDkcyyoyRHaPESdmErfc/wLgxd92k19RLo2uOqwdcAzWyipex3N0GLsR
 X5Xr+3XEcIIA2QI6Z6kwIQaH7r6p5mXTQBuGbKY4LUa1entoGTEroQ/xSD0VPfy31Gas
 K3DhjVA69VNKoqMSm573YUFtDMlcwuHJx6CYdNaDUsh71/6wdKShSwxBgI+OzChw2ifx
 MDGun/6Tq6Ku6nPiYFZIFXJvPqofoaYuHrqY955RC5gHKsrl+tqw+TvTMaruJfcJ/F0z
 l1aw==
X-Gm-Message-State: AOJu0Yx8ElMOO/8U7f/hKaaERPuuoE71qMZixKNwMYP+7s4DjApz5Jja
 FssnClmQlOWhejyqo5ss6pV7iley5wUBse+AJbNVFr6cQxB+cZM8v0ngD10LVBI19tUdQ1jAIO6
 yM8dF
X-Gm-Gg: AeBDietdb208uHiAyjf6YKRMwpKyIF8nfwegxfBN9tIjiZ0heT1gszU8YlhsH+4zOWG
 r4OgUCY3y+cZwzLkmZvORDr9D8WQL+ImjfgTWwu0oIrkIPIA516rhdBZAGMn2prvQR6DNdskxlm
 YP8c6kqGWRzAgyDdbzOyf2Ht/FTpnS5UPkQeglXLMbFczsKfhhA8f36miTjJf63S0TFvbl2leOC
 gtRi0BtTAR2ba3SKAw9OQHzySVIqM0A+Mb/ANy8X/9Qi+VOmpv/5tmTScAZ6a7XT4uIW6TjP8zq
 gUldo9tyBHHIHwXXdlG9V/R+AuDrgjg9XVRQevhjUozNpXtQq4l5cL22BttYYu0RhenCkC/v1Nd
 kAvFkaFBYd55assh18xlJLLIA80gLCoLjSmQFLWQqpTvRDt8XpIHKibegAGaIUm8Byx9JAqAHzy
 MumAyyI2Jb4l6U7Y08vpwtUWQPib+WJtMzs2Ar3sN4K8sZ8shUekJgNJrGm+A2VH7GTg+9g+zMz
 52B8gx1mhQGAUls8PLMBWe0xCPymRA=
X-Received: by 2002:a05:6870:f2a8:b0:42f:ba47:36f5 with SMTP id
 586e51a60fabf-434f588f6bbmr1843550fac.17.1778071725284; 
 Wed, 06 May 2026 05:48:45 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324a4sm16598179fac.14.2026.05.06.05.48.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 05:48:44 -0700 (PDT)
Message-ID: <2c23feac-abf7-4c55-b4b7-51b0dc1059ac@linaro.org>
Date: Wed, 6 May 2026 07:48:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Report IL=0 for Thumb 16-bit BKPT insn
To: qemu-devel@nongnu.org
References: <20260505103726.419195-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505103726.419195-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 5/5/26 05:37, Peter Maydell wrote:
> The Thumb BKPT insn is 16-bit, and the ESR_ELx syndrome register
> definition requires that we set the IL bit to 0 for this, and 1 for
> the 32-bit A32 and A64 BKPT/BRK.
> 
> We used to do this correctly, but accidentally lost it in the
> conversion to decodetree, because we converted the A32 BKPT first,
> and then when we converted the T16 BKPT we forgot that trans_BKPT()
> was unconditionally setting IL=1.
> 
> Pass the right value for syn_aa32_bkpt()'s is_16bit argument.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3474
> Fixes: 43f7e42c7d515f ("target/arm: Convert T16, Miscellaneous 16-bit instructions")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index ce427c5a3c..7f76a57653 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3580,7 +3580,7 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
>           (a->imm == 0xab)) {
>           gen_exception_internal_insn(s, EXCP_SEMIHOST);
>       } else {
> -        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
> +        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, s->thumb));
>       }
>       return true;
>   }

While correct, perhaps clearer to use curr_insn_len.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

