Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9298EC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjE5-0001G8-Lc; Sat, 25 Jan 2025 11:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjE4-0001G0-TD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:41:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjE3-00060M-5g
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:41:40 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2163dc5155fso55325455ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737823297; x=1738428097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cqq+qdCupQE0S6kB0RrbNb7BIVy0dxLo5MSiHohEEI8=;
 b=g+xCgVaXfndOTMyLIWo7uyfnV4hyjc3+dQ4TqKSotnQ+zfFfYTqROWP2GT1R56Y6TR
 HFwAWl3hNjTseoTBqFBQYtasl7oqzYerZwaI7td5qU9CAoEn0MtFs8wHNa5MQPgdNxTE
 gHSLpjDFee6ZkbpalbNKNyjDa2Bl40LUj4T6lF/muBfyVn7IRa6ssjOTp6eYL5yRg8i1
 wLYwKeW6Yykz7xLdxRh2C/g4XU3cz3Upp5pcTfL36GwKkbTQiIG0nG0YKK/5WE2HfxC5
 8I5VZwXrkk/Ypn6eNB8sTjjniNNW/ZL89kxwqaTjsO/SEbFylIkFIiFwwoYeUBThRsvy
 jaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737823297; x=1738428097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cqq+qdCupQE0S6kB0RrbNb7BIVy0dxLo5MSiHohEEI8=;
 b=O/3L51GRQdiV0+rSmDyLm3EMSuAqo/NocI9fBbJaXnmzx2yDfppMwM6u416KAlnzqW
 wciwDnkTpbHE18X97wPP//uofqBuTw+EkFmjMnJ/1WOISbcL8AGsaEUtVNzQTf4QgDFt
 noOBNqDmGSzx74MlyYdq84QAGPxJ15KocmhGQsGUk8IeWRdvt+Z7dJD/QI3qt16wVwuS
 nMrCrXC/LxX63eWWhdDvKQYfpZSu+Wt+f7HuKazgXZRsGiAPak2gDDg29un4DVBzb30m
 TBfZII1ZaKZyH8fRcgYEXNflz/KAZ+ney/eSvxhVif8hucASiCRgkULib03cV6mZI2iP
 qn0Q==
X-Gm-Message-State: AOJu0Yy0dLx7s7NtjrPZRhXDqWSipkcfCymdN09aV4A9WbS86K4+K7x0
 QrkP5gGJKGiO+3GapaqA4SFRRvan1j46nhnvYWRDEcvKSYkdN5nDq/SwmOdfS0IBDSjB0noXqY8
 b
X-Gm-Gg: ASbGnct0RZHshtxYacBHIwA+XWPrpxmh49gIi+pC4cei7pUDpid7iQjLS6DubjzjWec
 RfV03QgZSzMiuUv2gtAcHYJbyuZrLqWhY5mA2QAPXD/dWCAzcCPWl8KHHd8zoLdx9bTmjUaRlep
 YdynonU4y4AjDIOZo1lBLOvFe7wN3tqa+GEmRx0xZ+b+/lu+bLRBFgArTRLkS8IPdWtr3CLSTDa
 257YvhHnsrrdrVpOjSTQCVjPFHL+Ph6T2425EtSCY9407B7EzgMQwLweJnegF+xXtPDkC2jb+XF
 oYqBqW8xIy3Po79xYVe3ll75gAnZcD1y
X-Google-Smtp-Source: AGHT+IHjYxiTtXwdY9IHCF4HVLrUsxpgVDkF2kV7+mlEjY4xLZmTmTAszM0F598gNN5f83aY3QfRzQ==
X-Received: by 2002:a17:902:db12:b0:215:603e:214a with SMTP id
 d9443c01a7336-21c352c8151mr600376145ad.1.1737823295598; 
 Sat, 25 Jan 2025 08:41:35 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424ec12sm34039845ad.236.2025.01.25.08.41.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 08:41:35 -0800 (PST)
Message-ID: <d8d04708-ddc2-476e-9e17-8493f573d7a5@linaro.org>
Date: Sat, 25 Jan 2025 08:41:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/76] fpu: allow flushing of output denormals to be after
 rounding
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-25-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> Currently we handle flushing of output denormals in uncanon_normal
> always before we deal with rounding.  This works for architectures
> that detect tininess before rounding, but is usually not the right
> place when the architecture detects tininess after rounding.  For
> example, for x86 the SDM states that the MXCSR FTZ control bit causes
> outputs to be flushed to zero "when it detects a floating-point
> underflow condition".  This means that we mustn't flush to zero if
> the input is such that after rounding it is no longer tiny.
> 
> At least one of our guest architectures does underflow detection
> after rounding but flushing of denormals before rounding (MIPS MSA);

Whacky, but yes, I see that in the msa docs.

> Add an ftz_detection flag.  For consistency with
> tininess_before_rounding, we make it default to "detect ftz after
> rounding"; this means that we need to explicitly set the flag to
> "detect ftz before rounding" on every existing architecture that sets
> flush_to_zero, so that this commit has no behaviour change.
> (This means more code change here but for the long term a less
> confusing API.)

Do we really want flush_to_zero to be separate from ftz_detection?

E.g.

enum {
   float_ftz_disabled,
   float_ftz_after_rounding,
   float_ftz_before_rounding,
}

BTW, I'm not keen on your "detect_*" names, without "float_" prefix like (almost?) 
everything else.


> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 0122b35008a..324e67de259 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -334,7 +334,8 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>               p->frac_lo &= ~round_mask;
>           }
>           frac_shr(p, frac_shift);
> -    } else if (s->flush_to_zero) {
> +    } else if (s->flush_to_zero &&
> +               s->ftz_detection == detect_ftz_before_rounding) {

else if (s->flush_to_zero == float_flush_to_zero_before_rounding)


>           flags |= float_flag_output_denormal_flushed;
>           p->cls = float_class_zero;
>           exp = 0;
> @@ -381,11 +382,19 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>           exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !fmt->m68k_denormal;
>           frac_shr(p, frac_shift);
>   
> -        if (is_tiny && (flags & float_flag_inexact)) {
> -            flags |= float_flag_underflow;
> -        }
> -        if (exp == 0 && frac_eqz(p)) {
> -            p->cls = float_class_zero;
> +        if (is_tiny) {
> +            if (s->flush_to_zero) {
> +                assert(s->ftz_detection == detect_ftz_after_rounding);

if (s->flush_to_zero == float_flush_to_zero_after_rounding)

and no assert.

> +                flags |= float_flag_output_denormal_flushed;
> +                p->cls = float_class_zero;
> +                exp = 0;
> +                frac_clear(p);
> +            } else if (flags & float_flag_inexact) {
> +                flags |= float_flag_underflow;
> +            }
> +            if (exp == 0 && frac_eqz(p)) {
> +                p->cls = float_class_zero;
> +            }
>           }
>       }
>       p->exp = exp;


