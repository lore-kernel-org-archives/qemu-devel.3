Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06468C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 04:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK9QO-0001yS-0i; Thu, 20 Jun 2024 00:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9QL-0001xw-Vr
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:29:26 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9QK-0005oy-17
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:29:25 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7005c84e525so283992a34.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718857762; x=1719462562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1YdU5qz3XNjiVXUxby189CyNSPwxWQ54YJxbDibKdQ=;
 b=IM8HVbkHG1HiuMNrKuBL6RTDk2Bl+yMj+UUBAMttA6qGqAP9LhJwXvciW5ydySamWh
 i8HvW9bX1PlQn7+88krdA7SC7ORa/lsmK6M65MqK+bG6dLDXUAJs+Hl9vbQXJGHhEmNn
 EaCb9HKiFmRj7m7GWyT21BpZ4/ajOEbHGSY8xZFevvdY0zVXGOh9I5g+0gMieFpYLHPB
 R71g78UoZytCn0QYOqM+9Tt9XREh/fNxr6UgVnFhIZjM+4FmTQPFmR3B+84kOau/Oo4O
 CfhCU7LGMW19CQjOatpIlWLyte8kyPwYIA9xLk0BB4c+zNb/XgvMY3A9oqg8YIwy1eMW
 k3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718857762; x=1719462562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1YdU5qz3XNjiVXUxby189CyNSPwxWQ54YJxbDibKdQ=;
 b=TOMFp+wQMefFhiIG8qLed68OVLxoeAYBKZVdESxZFrl605v0n+aroy8N6dTLHAz1i4
 zdQmdk/SvfiW7hbZtdpQSdZ9KXwBUQbBnjz8hurh+1hX+MKmye1HgNxvrFz7zvGOLDj+
 Z0TZZ9e+JRDc73MISAS9pamTE1zSYV5y1x9RmkNLM/BfUxFs2tAIgrkUu6nSFi41Bv7T
 XH/oHyKy5T1PCOYezaPCdLlA5JsNheLbS7OpdikN8OmdndNNOoPiAF3XYeb7l0qfVdBv
 nb4WKjeWoXL4kHZfRbI0xvcB4MNSfJQ2NDyvCwN2fNKmqC3ajgm+8vTn/Zh5E0tgpkgp
 tQnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWglAMYQbJC4HWizkfhJVD5QFsYcn8MlxdoJ5UFdTWy9IFvwqnv6Emfx2IdoS+e7zJEETCCZmXIzxS8hMpUIJ+447D5YMI=
X-Gm-Message-State: AOJu0Yw447gWhC+tD3/fgWHURJ0N+zHsNEIsLSEmC1O7eJX3C1dmgInC
 MF5q4nSSdUkE2JsR83K6FUADwrMKlBniQl5J+MD+32fjXHcYJjY6QhFaSP22KC8=
X-Google-Smtp-Source: AGHT+IGB39CXclgraf1uS0E9A/+NWGjdHSCXh31tXdnVSp6ogfyuzEONlAQ5J9gRJzth4B5zqiUx/w==
X-Received: by 2002:a05:6358:6f19:b0:1a1:f9fa:bb8b with SMTP id
 e5c5f4694b2df-1a1fd60c317mr509688755d.20.1718857762283; 
 Wed, 19 Jun 2024 21:29:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fee3ba4241sm8757009a12.82.2024.06.19.21.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 21:29:21 -0700 (PDT)
Message-ID: <4d7d0813-2ba3-416e-9bb9-3f0ef00818f1@linaro.org>
Date: Wed, 19 Jun 2024 21:29:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unmasked unit-stride load/store
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
 <20240613175122.1299212-3-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240613175122.1299212-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 6/13/24 10:51, Max Chou wrote:
> This commit references the sve_ldN_r/sve_stN_r helper functions in ARM
> target to optimize the vector unmasked unit-stride load/store
> instructions by following items:
> 
> * Get the loose bound of activate elements
> * Probing pages/resolving host memory address/handling watchpoint at beginning
> * Provide new interface to direct access host memory
> 
> The original element load/store interface is replaced by the new element
> load/store functions with _tlb & _host postfix that means doing the
> element load/store through the original softmmu flow and the direct
> access host memory flow.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc |   3 +
>   target/riscv/vector_helper.c            | 637 +++++++++++++++++++-----
>   target/riscv/vector_internals.h         |  48 ++
>   3 files changed, 551 insertions(+), 137 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 3a3896ba06c..14e10568bd7 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -770,6 +770,7 @@ static bool ld_us_mask_op(DisasContext *s, arg_vlm_v *a, uint8_t eew)
>       /* Mask destination register are always tail-agnostic */
>       data = FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
>       data = FIELD_DP32(data, VDATA, VMA, s->vma);
> +    data = FIELD_DP32(data, VDATA, VM, 1);
>       return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
>   }
>   
> @@ -787,6 +788,7 @@ static bool st_us_mask_op(DisasContext *s, arg_vsm_v *a, uint8_t eew)
>       /* EMUL = 1, NFIELDS = 1 */
>       data = FIELD_DP32(data, VDATA, LMUL, 0);
>       data = FIELD_DP32(data, VDATA, NF, 1);
> +    data = FIELD_DP32(data, VDATA, VM, 1);
>       return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
>   }
>   
> @@ -1106,6 +1108,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>       TCGv_i32 desc;
>   
>       uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
> +    data = FIELD_DP32(data, VDATA, VM, 1);
>       dest = tcg_temp_new_ptr();
>       desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>                                         s->cfg_ptr->vlenb, data));

This is ok, and would warrant a separate patch.


> +    if (vm == 0) {
> +        for (i = vstart; i < evl; ++i) {
> +            if (vext_elem_mask(v0, i)) {
> +                reg_idx_last = i;
> +                if (reg_idx_first < 0) {
> +                    reg_idx_first = i;
> +                }
> +            }
> +        }

This isn't great, and isn't used for now, since only unmasked unit-stride is handled so 
far.  I think this first patch should be simpler and *assume* VM is set.

> +/*
> + * Resolve the guest virtual addresses to info->page[].
> + * Control the generation of page faults with @fault.  Return false if
> + * there is no work to do, which can only happen with @fault == FAULT_NO.
> + */
> +static bool vext_cont_ldst_pages(CPURISCVState *env, RVVContLdSt *info,
> +                                 target_ulong addr, bool is_load,
> +                                 uint32_t desc, uint32_t esz, uintptr_t ra,
> +                                 bool is_us_whole)
> +{
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t nf = vext_nf(desc);
> +    bool nofault = (vm == 1 ? false : true);

Why is nofault == "!vm"?

Also, it's silly to use ?: with true/false -- use the proper boolean expression in the 
first place.

That said... faults with RVV must interact with vstart.

I'm not sure what the best code organization is.

Perhaps a subroutine, passed the first and last elements for a single page.

   Update vstart, resolve the page, allowing the exception.
   If watchpoints, one call to cpu_check_watchpoint for the entire memory range.
   If ram, iterate through the rest of the page using host accesses; otherwise,
   iterate through the rest of the page using tlb accesses, making sure vstart
   is always up-to-date.

The main routine looks for the page_split, invokes the subroutine for the first (and 
likely only) page.  Special case any split-page element.  Invoke the subroutine for the 
second page.


r~

