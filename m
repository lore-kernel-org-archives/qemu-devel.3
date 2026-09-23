Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF3CC98311
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9VTv-00041G-Hf; Wed, 23 Sep 2026 18:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9VTt-00040j-RL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:30:25 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9VTs-0007ry-6w
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:30:25 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d91ede8035so13187655ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790202622; x=1790807422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tn9uFTChY4Q7XE/SDnvmn4TV0WDkCiN5um7twsxBNXc=;
 b=WFjjN6jkzdAFVx1dbvz2w7u7EP+VbgHV48TDwo2odbFOUhnZURPGM5AUClky7LNd/E
 6yExUZqLuRU34F6VlRIG9JzdQF5WpyK7YzjME+uuWfFB3V8YYrwP6I2777IXpolqlXYg
 MmDW0yUU3SD5OYnN8Kdl4qc2QiII/rCypiteBDYx2HCc9YTkCR+UAeF3/7qIhfKD9uC6
 YdYY6zEfbOBWhdw75/pEb18cFM4QmtBy+i5uY9ZF/rg7lpaTrw6kTY7NM/az/bv1YrPJ
 cSw709RYZ4YwcoM2sdrhFoECpSWBwuAFevMM8zscKcWXMFIYmC4j7lhmJFNRnKdN+Vlh
 CM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202622; x=1790807422;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tn9uFTChY4Q7XE/SDnvmn4TV0WDkCiN5um7twsxBNXc=;
 b=U7sNND+WsIVCVD7wnDH18f+ox7wPxJP47GpuWoLmXaj7PU/iQ8F0+RH5nFV5fuMqAb
 UrR2+mN9VWVQ89bD9m3zkMetVHVps7umhp7AYVr/MKxBoqUbfD4cZke6wb/9bXAEBIQB
 Vo2CO/bKDubnoZw9wux4cQZlWSnmwb/uNGf/bQhsbz21WQxcbCUSmw22LHoIFYi/riKV
 DymG1Giwban9V8jluyb1FVCpetFVHZJfNSGrrxz27MGSa/tH2GUOxxe2L7Jng7+DshiG
 ORnxIoow1R1vF2JzNhyfJLSPkGdDYAmuyeh2Jc0C9/KIst815eXlI82UoJwmfHf0t6S6
 q+zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDcqoNcU2BqGjYu0qovNW7rkv1QzrPwTKC9QY1e3G1WrbBT15wBEQp40ImXtKfaj92y+0iU/3bnx7K@nongnu.org
X-Gm-Message-State: AFuF++kZkVJgABMTpuTZiy6dHrVtfamA5DU9vc4vpWsbs5p0xfuTzPvR
 lO7w+/6L3Uo1nZtvcD9vZwv7KE/kgCBcQUATyEk10ztftjh733kgT9qEPW5IeJXoIsc=
X-Gm-Gg: AYBFou2aktHbt7EB1SUtqRL7N0DAHG1pnKP9kTjMNH7kXzgPpgKzGRP/GsvanLBPWDd
 kb5sQPXQ3Rx8cmOQ++aBUi6SFvHOK6cyXvP0QXPdGpQfo5iNFyWbTEpLY5KsSizkiA1KMNnCgyP
 CFgDsZuudcqMGcB0yX7zlLkbKHMJvani6e42mkc/FEtChCltR7cQsYj3FeDSiaCEVhvPENzpCKg
 ZfBhhdxHyuYAl351ECaMT8M2Su/7KzgPtibajiXp2W3PM6eWHQuY400h3TNdC7gUspZbqYZmPa7
 +X3WvYhQEzARLW6i5bsE1lJ6+BpR0GA/GdG1by3Cotw7BCXzkID6JpbZpggMHwEXd2Lq1TpkmNR
 y0wWVgZBsi+J9+MsSl88MrzPiVzvY9nQ8wxHhCtnqY+SD+Je/sDGwXQHZF9eX+gAXjDRmCfaQ7L
 voKDHOvZxS9qcc/nqv+tJaZZ9bosLDcKZ3GY2JMbABPGsghTIVGh8jTkWNGqN0qsGpvya+Z1j2C
 a7tg8PklDzj0fL0QoEFL8vh6X9GZNd3GnjGuE8j6aKpKWrGca0=
X-Received: by 2002:a17:903:1585:b0:2dd:c053:9c6b with SMTP id
 d9443c01a7336-2df7e406b13mr3587105ad.33.1790202621889; 
 Wed, 23 Sep 2026 15:30:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a516a32sm16961345ad.4.2026.09.23.15.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 15:30:21 -0700 (PDT)
Message-ID: <555e087d-b0af-4cf3-861a-84a37337a005@linaro.org>
Date: Wed, 23 Sep 2026 15:30:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] target/i386/tcg: implement JMPABS instruction
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-11-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> This is the same as an indirect jump, just with immediate operand.
> The requirement of W=0 and 0x67 are already available in the decoder.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     | 3 +++
>   target/i386/tcg/decode-new.c.inc | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
> index b4b0567e7ca..cbc85498a1c 100644
> --- a/target/i386/tcg/decode-new.h
> +++ b/target/i386/tcg/decode-new.h
> @@ -190,6 +190,9 @@ typedef enum X86InsnCheck {
>   
>       /* No REX2 prefix allowed */
>       X86_CHECK_no_rex2 = 8192,
> +
> +    /* No 0x67 prefix allowed */
> +    X86_CHECK_no_adr = 16384,
>   } X86InsnCheck;
>   
>   typedef enum X86InsnSpecial {
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index c2b252c01be..b6d909d5f2b 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1993,6 +1993,7 @@ static const X86OpEntry opcodes_root[256] = {
>   
>   #ifdef TARGET_X86_64
>   static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
> +    [1] = X86_OP_ENTRYr(JMP_m,   I,q, p_00 chk2(W0, no_adr)), /* JMPABS */
>   };
>   
>   static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
> @@ -3119,6 +3120,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
>           if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
>               goto illegal_op;
>           }
> +        if ((decode.e.check & X86_CHECK_no_adr) && (s->prefix & PREFIX_ADR)) {
> +            goto illegal_op;
> +        }
>           if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
>               goto illegal_op;
>           }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

