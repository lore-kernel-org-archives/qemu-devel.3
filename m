Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6E8C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 11:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERtR-0004oY-S2; Tue, 04 Jun 2024 06:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERtQ-0004ne-TV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:59:52 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERtP-0001eZ-9K
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:59:52 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-794ab0ae817so306327485a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717498790; x=1718103590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VR8Q2oQsyTUsksMkfg6bv2P2gkPUNThQ2da9jCryvpY=;
 b=yCBn2JyN2koFxbGq2q6ltFxdu4ymGtj3XrQtrFhbN1kkdz8ei4EZetblAPf3Ek7/rL
 IzN2NVMAP9HYYNNHugNAx6m56rC//k6r+2NH3sHTUPTrvksqkPgrea0lhGTjsKxU1mZC
 MJUnMBZjK5j98c0Nfis+Ef3VTzuSQW0hR5v1Fqtv4A8WLkFoTX+vFGA8TpiZ8V5UhyJf
 ZzHtlaatuV0LfqfwDscYHiCB6t1ZniFI2CW7NXGumbnhR3M3gBjqXVm1XCYj7C2NDRyU
 NPDALlUayppdhH3MrayKw1KkEayXff0O5NOGIvy5Aksj6hUSI4UPgDAplZWLz+VxoHw2
 dWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717498790; x=1718103590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VR8Q2oQsyTUsksMkfg6bv2P2gkPUNThQ2da9jCryvpY=;
 b=XaoYnOsu9eMDX2gk8drRFK9dJgGeQnh4+I2KWW1hXKCgf3LiwpTGTLWPtJpH0Hx3KG
 AEnJl3EjqRhBQepwd8Gww4gUV5mz5kZoz0StDrhxW8zIvs3G+Lqp5XHImaNpS7KtjHII
 79v7kF2Dt8hIDkmLm7Zyd+Apizx+7R0DLLwq0ton+FPfE4oclDfSKK0GEiD0quZIxPUE
 2C0dT76z5RlWzeKwWVi7dWsd4CUCi5d3dPVIKC+tAYeIlBJXBEy/JwqnnOjzQCvZm2Qs
 PIyew3dr8OWf32o0XoDl42HfQUN1oKijqnDazqfCUA33i3ghyaM8GQ/vtg3nLfYUWChs
 ZNiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCd1v0+O3f/UlnX/VKYHXOZEz0pAt631NyiEg8mYxJtWxJNXfx+dGs2tXQHKujjrQpsGkXecYWaKNC2f4BVv+pAxf5SfI=
X-Gm-Message-State: AOJu0YybK69o4T52pcS41Hf+gMFy3TVRXZCEgv0ilpOEHhPNmn3tbodb
 NfUQ9R41AxGwMm66ES744cZfpH3SfDo4jpDsrr/it+5KIrXDxsmNW5YSWhTHdpg=
X-Google-Smtp-Source: AGHT+IFocxpNoeuqPISJjVSPiRi8hqoKUnSMLcP3shVgCLwzNRFhed8qx1YAZNJwlj97jCfGehyi2Q==
X-Received: by 2002:a05:620a:5684:b0:795:195b:c130 with SMTP id
 af79cd13be357-795195bc482mr134841585a.11.1717498789718; 
 Tue, 04 Jun 2024 03:59:49 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7951dfc673dsm14319885a.113.2024.06.04.03.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 03:59:49 -0700 (PDT)
Message-ID: <0e63b24b-7010-4688-a266-808958cd055c@linaro.org>
Date: Tue, 4 Jun 2024 05:59:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] target/i386: cleanup PAUSE helpers
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> Use decode.c's support for intercepts, doing the check in TCG-generated
> code rather than the helper.  This is cleaner because it allows removing
> the eip_addend argument to helper_pause(), even though it adds a bit of
> bloat for opcode 0x90's new decoding function.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/helper.h                 |  2 +-
>   target/i386/tcg/helper-tcg.h         |  1 -
>   target/i386/tcg/misc_helper.c        | 10 +---------
>   target/i386/tcg/sysemu/misc_helper.c |  2 +-
>   target/i386/tcg/decode-new.c.inc     | 15 ++++++++++++++-
>   target/i386/tcg/emit.c.inc           | 20 ++++++++------------
>   6 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static void decode_90(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
> +{
> +    static X86OpEntry pause = X86_OP_ENTRY0(PAUSE, svm(PAUSE));
> +    static X86OpEntry nop = X86_OP_ENTRY0(NOP);
> +    static X86OpEntry xchg_ax = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v);
> +
> +    if (REX_B(s)) {
> +        *entry = xchg_ax;
> +    } else {
> +        *entry = (s->prefix & PREFIX_REPZ) ? pause : nop;
> +    }
> +}

Thanks.  I had wished for this instead of

>   static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
>   {
> -    if (decode->b == 0x90 && !REX_B(s)) {
> -        if (s->prefix & PREFIX_REPZ) {
> -            gen_update_cc_op(s);
> -            gen_update_eip_cur(s);
> -            gen_helper_pause(tcg_env, cur_insn_len_i32(s));
> -            s->base.is_jmp = DISAS_NORETURN;
> -        }
> -        /* No writeback.  */
> -        decode->op[0].unit = X86_OP_SKIP;
> -        return;
> -    }

this from the beginning, but since it wasn't wrong, I didn't mention it.


r~

