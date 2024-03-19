Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DD9C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmhST-0007KH-2e; Tue, 19 Mar 2024 17:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmhSR-0007Jm-BG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:57:19 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmhSP-0007Ey-Hi
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:57:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6b6e000a4so277437b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710885436; x=1711490236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s+coWbZC9Fqk/3NbdQiMdaupeB27AyeDTeZ71l0t9hc=;
 b=gEwo4fQUYJQ1BWDojBYhAyiIatHhRhFVtijTpNWfE4Yuy57lTow7LFzK5OMqb4SUr5
 OSGwkuWX5LSofH8YhjPtdlx8rs5sHAisJu9Db4HNQWTjx8bz/r+xTMj1WRo65ts6r0kX
 5979H4cmRnJ3QlAVW8oh3RZ90CElyo+jbYSRFpriOx/Un7ycO2VCbH1rzZ2VW5IDYrAh
 FBhalQy+fWUMxhwXGbzrUs9hSvDQhSErl7cYDEzfyXkMxbbWnTybiHWjUBUI+uvQWcT5
 AW2y+gC4ZZ9DXt05BvEHtfagXsuPGlFoGjC1XHVspz0wZh832pL/wEhHjuQLxHMBkY7+
 IwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710885436; x=1711490236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+coWbZC9Fqk/3NbdQiMdaupeB27AyeDTeZ71l0t9hc=;
 b=LbR0nFPzSI3h2xSHXVBfBQiVIRCvPd0BrN0Lt3rUcnxCQz+VEc8/uuIM9LlE6l8MHL
 V8O3PvayuOhnHJ9Q6K1xFaIrjSWjrRl46ocCuz24hZNG+Po2KHirTpm215KJ0q8eP/5t
 cjui/5MMWA4yFWKPRq2w8PIRttqDGfHIF+LEc+fnyppSqRTNRyZKCTaKTu0+BL4qKQSF
 +e5eSWAHaV/WxFDbAEWB+L0ln0Jg9wJrW4fVvmnyFh2QIvZo9oVSk2+Ke5OxkC7lFCUI
 WKEDlBN4AV5mOKflAmLh0TN/UcrwUJsqXGIzp4GlQIOWQs2FG7zJkUgA5+NM8LAwl/CB
 ckjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9LYDjrZQ0ZRF62LBS7HWKWrNbWGru8Oirp1IF3aw3dcEhFsxkK9B1j2CLQTSUwvPsWkBD/I4jvnPyn0xzjQHC6U4X1jo=
X-Gm-Message-State: AOJu0Yw9I4aceBnmGtxrj/wAxqzlW25W6IWsuVG1O9/DxPmZ73ywd7iL
 y+cwQ7eWb2eWv8RffLvkGGasIFL8QbxrgyvGgLkrd9fbSfL5U1D65lfgzjFKPQA=
X-Google-Smtp-Source: AGHT+IFx8xTvXEnW8eb4b3vsBQncpNmhgPqcT2Ha0C+056vthqAnMpYrDmSQ6VmpMm5cGJsV/d7K6Q==
X-Received: by 2002:a05:6a00:3d0c:b0:6e7:ad5:622c with SMTP id
 lo12-20020a056a003d0c00b006e70ad5622cmr5860610pfb.1.1710885436217; 
 Tue, 19 Mar 2024 14:57:16 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 fn15-20020a056a002fcf00b006e091a254adsm10129446pfb.30.2024.03.19.14.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:57:15 -0700 (PDT)
Message-ID: <c765adcb-2702-45d3-b875-6eaa6b6d7d0c@ventanamicro.com>
Date: Tue, 19 Mar 2024 18:57:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/riscv: Add right functions to set agnostic
 elements
Content-Language: en-US
To: Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
 <20240306092013.21231-3-eric.huang@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240306092013.21231-3-eric.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

(--- CCing Richard ---)

On 3/6/24 06:20, Huang Tao wrote:
> We add vext_set_elems_1s to set agnostic elements to 1s in both big
> and little endian situation.
> In the function vext_set_elems_1s. We using esz argument to get the first
> element to set. 'cnt' is just idx * esz.
> 
> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
> ---
>   target/riscv/vector_internals.c | 53 +++++++++++++++++++++++++++++++++
>   target/riscv/vector_internals.h |  2 ++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
> index 349b24f4ae..455be96996 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -20,6 +20,59 @@
>   #include "vector_internals.h"
>   
>   /* set agnostic elements to 1s */
> +#if HOST_BIG_ENDIAN
> +void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
> +                       uint32_t idx, uint32_t tot)
> +{
> +    if (is_agnostic == 0) {
> +        /* policy undisturbed */
> +        return;
> +    }
> +    void *base = NULL;
> +    switch (esz) {
> +    case 1:
> +        base = ((int8_t *)vd + H1(idx));
> +    break;
> +    case 2:
> +        base = ((int16_t *)vd + H2(idx));
> +    break;
> +    case 4:
> +        base = ((int32_t *)vd + H4(idx));
> +    break;
> +    case 8:
> +        base = ((int64_t *)vd + H8(idx));
> +    break;
> +    default:
> +        g_assert_not_reached();
> +    break;
> +    }
> +    /*
> +     * spilt the elements into 2 parts
> +     * part_begin: the memory need to be set in the first uint64_t unit
> +     * part_allign: the memory need to be set begins from next uint64_t
> +     *              unit and alligned to 8
> +     */
> +    uint32_t cnt = idx * esz;
> +    int part_begin, part_allign;
> +    part_begin = MIN(tot - cnt, 8 - (cnt % 8));
> +    part_allign = ((tot - cnt - part_begin) / 8) * 8;
> +
> +    memset(base - part_begin + 1, -1, part_begin);
> +    memset(QEMU_ALIGN_PTR_UP(base, 8), -1, part_allign);


This seems correct but a bit over complicated at first glance. I wonder if we have
something simpler already done somewhere.

Richard, does ARM (or any other arch) do anything of the sort? Aside from more trivial
byte swaps using bswap64() I didn't find anything similar.

We recently posted a big endian related fix here:

[PATCH for 9.0 v15 03/10] target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess

But not sure how to apply it here.



Thanks,

Daniel



> +}
> +#else
> +void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
> +                       uint32_t idx, uint32_t tot)
> +{
> +    if (is_agnostic == 0) {
> +        /* policy undisturbed */
> +        return;
> +    }
> +    uint32_t cnt = idx * esz;
> +    memset(vd + cnt, -1, tot - cnt);
> +}
> +#endif
> +
>   void vext_set_elems_1s_le(void *base, uint32_t is_agnostic, uint32_t cnt,
>                          uint32_t tot)
>   {
> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
> index fa599f60ca..c96e52f926 100644
> --- a/target/riscv/vector_internals.h
> +++ b/target/riscv/vector_internals.h
> @@ -114,6 +114,8 @@ static inline uint32_t vext_get_total_elems(CPURISCVState *env, uint32_t desc,
>   }
>   
>   /* set agnostic elements to 1s */
> +void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
> +                       uint32_t idx, uint32_t tot);
>   void vext_set_elems_1s_le(void *base, uint32_t is_agnostic, uint32_t cnt,
>                          uint32_t tot);
>   

