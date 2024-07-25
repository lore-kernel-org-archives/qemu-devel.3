Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48250C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 06:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWrbl-0001Xa-IL; Thu, 25 Jul 2024 02:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWrbj-0001PZ-B2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:05:43 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWrbh-0001tk-9t
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:05:43 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb64529a36so455677a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721887539; x=1722492339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ykyzOXDf1aFweIz87FKCn4XcbntHBbCG3Yl+QmCq46s=;
 b=opBqB8jltk5cEFtfWNLutCZYUkLTWmnnB3i2ZAiqwNDQqm+T1Hfy4ibDXj6oA6kkSX
 ziSUfm/H1C/wVziqIvfDMd1JqiwSyWMU/jkp/+PMHkeqfSj2MQW556O9SVzzlGeKZcfk
 QEFKUdX9K9AeZ//+8qiF319SyBkjEqb2RZdtR47psQUhJsyWTxAaUc115/tWwBSOt8rg
 rHL5NtGRNvKqf0MvbnnN3hLTKnLaqnxl0uYvwmwgOTnv/EP6Eldxbaj8VVB33VQdEilp
 8sKNa1HZEE7P59NnUdwFg32xps8iLISS4icCeB5vULYkkcippWZYOF5Z86osJ40ENXp2
 eqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721887539; x=1722492339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ykyzOXDf1aFweIz87FKCn4XcbntHBbCG3Yl+QmCq46s=;
 b=IrvcqYDynDbJIdAhxwH3XF+gA1uWHbIoyvnz88M9JFzT5u7dSF75IaaAlvOEtwzbs+
 CCkvetDU5uUaJ0Ormcbw1cnmrc4Jp9KL+6A7nNfiS2P97fqoeWEOzefmgBtDaRNjrdOV
 IbGxf8VWt5gGaZwwRv66Ez5pVwEgAKrM0VG5VyI5MMBBtS8EKfuR2PDAxm9EMYfwRN+Y
 3Z3cs5IBjim3zYYHG50X4AwQykUh+d90UjRm5ubtFGh0Mjp39dvIaRn0x7QKetJZEfom
 SHGkAmKyl8bzDSnkJlqmHaTZzcj7wiELuvRfPn8FbuIQMERMeZrsUUxVwBqfZBSzCz2K
 3tcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW27aaLHDArRUVWFxPQDeDI6jprlHuVSaEAX/2M7cIYDNNJTyAOQoJvWSjTUX6RtsChqfQ9pfLYhh1XTlwyQ3EKvbjs8ho=
X-Gm-Message-State: AOJu0Yzuf4FbBeR2LEipAEbPpzj2ovD1qg/XAmbLj3lnJ3g1QyR0gozX
 Y5e1hQs38YBlPFT2eokyx342bfJGjyiU+TSCZAimIG+FXW876z5phCMoAx2OD3k=
X-Google-Smtp-Source: AGHT+IGLg6B/TRPNqCdhViGi7/l7OX/kx3zf7HFwVYzHmEf2fYmeGRTdJuTN5yvTFvJRnmleD2NsQA==
X-Received: by 2002:a17:90b:314d:b0:2cb:f9e:3bfb with SMTP id
 98e67ed59e1d1-2cf238ec69dmr1970682a91.32.1721887539355; 
 Wed, 24 Jul 2024 23:05:39 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c9c9a1sm667341a91.24.2024.07.24.23.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 23:05:38 -0700 (PDT)
Message-ID: <abdab05e-3001-4a6f-afdc-05fc997657ee@linaro.org>
Date: Thu, 25 Jul 2024 16:05:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 5/5] target/riscv: Inline unit-stride ld/st and
 corresponding functions for performance
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
 <20240717133936.713642-6-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240717133936.713642-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/17/24 23:39, Max Chou wrote:
> In the vector unit-stride load/store helper functions. the vext_ldst_us
> & vext_ldst_whole functions corresponding most of the execution time.
> Inline the functions can avoid the function call overhead to improve the
> helper function performance.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/vector_helper.c | 56 +++++++++++++++++++-----------------
>   1 file changed, 30 insertions(+), 26 deletions(-)

You'll want to mark vext_page_ldst_us similarly.


r~

> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 2e675b4220c..95394c425ed 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -150,18 +150,20 @@ typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
>                                      uint32_t idx, void *vd, uintptr_t retaddr);
>   typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
>   
> -#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                         \
> -static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
> -                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
> -{                                                                       \
> -    ETYPE *cur = vd + byte_off;                                         \
> -    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);                   \
> -}                                                                       \
> -                                                                        \
> -static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
> -{                                                                       \
> -    ETYPE val = LDSUF##_p(host);                                        \
> -    *(ETYPE *)(vd + byte_off) = val;                                    \
> +#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                 \
> +static inline QEMU_ALWAYS_INLINE                                \
> +void NAME##_tlb(CPURISCVState *env, abi_ptr addr,               \
> +                uint32_t byte_off, void *vd, uintptr_t retaddr) \
> +{                                                               \
> +    ETYPE *cur = vd + byte_off;                                 \
> +    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);           \
> +}                                                               \
> +                                                                \
> +static inline QEMU_ALWAYS_INLINE                                \
> +void NAME##_host(void *vd, uint32_t byte_off, void *host)       \
> +{                                                               \
> +    ETYPE val = LDSUF##_p(host);                                \
> +    *(ETYPE *)(vd + byte_off) = val;                            \
>   }
>   
>   GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
> @@ -169,18 +171,20 @@ GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
>   GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
>   GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
>   
> -#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                         \
> -static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
> -                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
> -{                                                                       \
> -    ETYPE data = *(ETYPE *)(vd + byte_off);                             \
> -    cpu_##STSUF##_data_ra(env, addr, data, retaddr);                    \
> -}                                                                       \
> -                                                                        \
> -static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
> -{                                                                       \
> -    ETYPE val = *(ETYPE *)(vd + byte_off);                              \
> -    STSUF##_p(host, val);                                               \
> +#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                 \
> +static inline QEMU_ALWAYS_INLINE                                \
> +void NAME##_tlb(CPURISCVState *env, abi_ptr addr,               \
> +                uint32_t byte_off, void *vd, uintptr_t retaddr) \
> +{                                                               \
> +    ETYPE data = *(ETYPE *)(vd + byte_off);                     \
> +    cpu_##STSUF##_data_ra(env, addr, data, retaddr);            \
> +}                                                               \
> +                                                                \
> +static inline QEMU_ALWAYS_INLINE                                \
> +void NAME##_host(void *vd, uint32_t byte_off, void *host)       \
> +{                                                               \
> +    ETYPE val = *(ETYPE *)(vd + byte_off);                      \
> +    STSUF##_p(host, val);                                       \
>   }
>   
>   GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
> @@ -366,7 +370,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
>       }
>   }
>   
> -static void
> +static inline QEMU_ALWAYS_INLINE void
>   vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>                vext_ldst_elem_fn_tlb *ldst_tlb,
>                vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
> @@ -695,7 +699,7 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
>   /*
>    * load and store whole register instructions
>    */
> -static void
> +static inline QEMU_ALWAYS_INLINE void
>   vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>                   vext_ldst_elem_fn_tlb *ldst_tlb,
>                   vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,


