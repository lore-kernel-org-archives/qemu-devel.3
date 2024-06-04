Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEDDC27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUSq-0002xA-Ct; Tue, 04 Jun 2024 09:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUSp-0002vd-5E
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:44:35 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUSl-0001PS-Pu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:44:34 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d1f7593ddcso977740b6e.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508670; x=1718113470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Dudm83Ei/8EP8zY5gPKzR/Azveq4gImYfovdKP2G+w=;
 b=ojHtNuMmZvmgD4r1LL/sheYBSq9hb+CL7tjFIVrlj5qZX1w1+m5I+BnD3hIpind/iS
 q3yIqOPBtDv+ceo5drPx3wCpd5ogRlCsQc8RR+OoQWi6InPGdjN1kFg6xwBf13o32th+
 OLrGMRiowSZl7SY0CWtsWZnjlAy8uGl2P4fg61cZ3bKGR92tyhqRPR9YHVsrQbfQSK3+
 RqdzKRfnuw3xF8mgu/pv9gxUXnaJ/alKkqREqnWYCdBYdhtFoOkPnt2+czx5LQXYf6EA
 AffiBlk8Kjp8okel0S7LF4IhK4VOwBc60RQhF+hBw412l1xebaVV344rj+8A6Vt7/QRU
 KOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508670; x=1718113470;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Dudm83Ei/8EP8zY5gPKzR/Azveq4gImYfovdKP2G+w=;
 b=Y0n+vD2J5pqqE5hQpjgVbzvjSztbTqZV9zfBiAywsF0eNSasGEL3W9X7lZxmOFQ8dV
 WYj2XUwPGlQyAAstdOqYduwBVhO/5RP5nHiMI3/Q2NknZ8+vHphaOhQgEplb1Hv6L+x5
 AzPTQDRkpqwOWcsPkoQfXaJziYwTu8OeELYhvglr/DT0+g/qBei8diyW0+KS/TjYIHvA
 QUQzq8jHmuE3nHZyaAHk45cO/iBiYtCntTGs26LkGp2ahr6E2aaX29MHv5xO9YXwzk5A
 5PhTqg77zC/9mQdBxP1vv/5BBvEAFF8oIGzm39Eizao09BQeiATte1n8FDojrqLF56pR
 ejzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeK2PJ4C/v3oGnXQ/BMpJVd112LbtBkup/L8Nfr1uxZl/yzDIMeyfir8v6Qw2+ZyZ/QBeS0DaiuQNCFYo1B62i/1aXrZM=
X-Gm-Message-State: AOJu0YzB37NwuFSL1MZfMHnR3kmLRD8yUUvlh1EFuo5Btd4esDhtc79W
 MJMrTfpHG3c8zqu212M3HAkaK1HBm4JI9P2JVnMrAONK4/NaGWyYg8RSL5jhAHPFEh+nsenIcZI
 W
X-Google-Smtp-Source: AGHT+IGRq/mxnKZo0C4QUX+2GNGttYAvoUE6SIRviQz497eOnFmL9kKa5Yimh2ixN0LlVNruXPG+BQ==
X-Received: by 2002:aca:1c0b:0:b0:3d1:fe84:6128 with SMTP id
 5614622812f47-3d1fe8463edmr1543063b6e.20.1717508670187; 
 Tue, 04 Jun 2024 06:44:30 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d1e1a461f4sm1809255b6e.37.2024.06.04.06.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:44:29 -0700 (PDT)
Message-ID: <0dc2521f-7d7c-48c1-943e-b71566284450@linaro.org>
Date: Tue, 4 Jun 2024 08:44:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/i386: fix INHIBIT_IRQ/TF/RF handling for
 PAUSE
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 6/4/24 02:18, Paolo Bonzini wrote:
> PAUSE uses DISAS_NORETURN because the corresponding helper
> calls cpu_loop_exit().  However, while HLT clear HF_INHIBIT_IRQ_MASK
> to correctly handle "STI; HLT", the same is missing from PAUSE.
> And also gen_eob() clears HF_RF_MASK and synthesizes a #DB exception
> if single-step is active; none of this is done by HLT and PAUSE.
> Start fixing PAUSE, HLT will follow.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/misc_helper.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
> index 8316d42ffcd..ed4cda8001e 100644
> --- a/target/i386/tcg/misc_helper.c
> +++ b/target/i386/tcg/misc_helper.c
> @@ -92,6 +92,10 @@ G_NORETURN void helper_pause(CPUX86State *env)
>   {
>       CPUState *cs = env_cpu(env);
>   
> +    /* Do gen_eob() tasks before going back to the main loop.  */
> +    do_end_instruction(env);
> +    helper_rechecking_single_step(env);
> +
>       /* Just let another CPU run.  */
>       cs->exception_index = EXCP_INTERRUPT;
>       cpu_loop_exit(cs);

Perhaps it would be better to do

void helper_cpu_exit(CPUX86State *env)
{
     cpu_exit(env_cpu(env));
}

static void gen_PAUSE(...)
{
     helper_cpu_exit(tcg_env);
     s->base.is_jmp = DISAS_EOB_NEXT;
}

to keep from replicating gen_eob?

Anyway, this is correct, so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

