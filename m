Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DEBD6B6AC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6BfI-0007Xv-AD; Wed, 30 Oct 2024 12:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6BfC-0007Wj-NU
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:35:19 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6BfA-0005Rt-Ux
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:35:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-208cf673b8dso188125ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730306115; x=1730910915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1sClMwP5JBCTijhw0BM+ZX9qUprk+C4Q7g+q6SUVhwY=;
 b=cyG0a/S+4w7PhMlei8fhHXt9o34vbyZzlW26vOKrSjxF0777VcUyBeh+jnUrgMKinD
 30ICQejqmFCLYGtQ5LuTxeBZEYo2tg3xzJoAOrNigoqwf+UK+KlpasLRj5W47uRpqode
 5ptCcnbk5+TiJMNf4Ot/7u6HFh7fmfv+DcGsItwjsQpU+V/cK/CkDmPkhcO5iw7vQQkD
 h8DOUxNXe7wdElMY9IJFx6u/eld3OIp6EiQKEXLkktSpw2L3cNmaptnc97ZxezH7LCLf
 lPgK3xS4NPkEeU31L8/ZL1y+yMpOqeJUWqXDzHsGHCbAn5imlCXj690ZpP0v4s1wvL9m
 /wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730306115; x=1730910915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1sClMwP5JBCTijhw0BM+ZX9qUprk+C4Q7g+q6SUVhwY=;
 b=BwKhZb/0/JQ3aaS7EleIG68f1kTvCGWdL+P3nwgr7YkivfeHcNnvcY753IeaWvzXoS
 0jddfoNIyMPD1uDDGZPJhMOdWuQa6RPQXGtfS2WuVEDpQ2Ew51KOPG/CoLT5F7hxYsDI
 OszHsjCJmTeKb9bHAKU3RSVcE0AEyG7wYHq0KzzYd+xO+QdV3Ow7L2yWjs3nXNJmQwPB
 USpR36HnzO5kl/SLpjXng13BNb8t1y3o0odpwEXfV74JrRQmrjfIiBl5VUsRcRNEw0Ka
 r6d+AHDXGQk+ywKR+Jwd9ziJkTErakslWo1Bx44z9V3krDNXATdFYGXmh1LaQY+YuOX4
 xoCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX6uYENm/XwFCqxlYHF7GuTkduFztI5gyQsCzvbsouVwLl2Fv+y5lS+AVo0tISx/yRovlMLaKHX0F6@nongnu.org
X-Gm-Message-State: AOJu0Yx2hFp6VCloGnGA5Cv9Xh2cdTlUyipgNM93i7ipQnuVyY8SzH9a
 mxS0+ameUGCljLsJTe/2zGJaLp3Z/odLPrwBa8Fppcbwh1NOJ/hkbBjhCumNuFA=
X-Google-Smtp-Source: AGHT+IH7m7dmy33tMnIIRUrZGFPYXXQYUx6uPmgjmMPh50RFzLrViM34xvYTJNTvFsvT1krc2QGktg==
X-Received: by 2002:a17:903:41cf:b0:210:f69c:bebf with SMTP id
 d9443c01a7336-210f69cc44dmr58073745ad.11.1730306114751; 
 Wed, 30 Oct 2024 09:35:14 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc045298sm82003685ad.261.2024.10.30.09.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 09:35:14 -0700 (PDT)
Message-ID: <89cc9f3e-7980-4676-a541-b6dbad70ac42@ventanamicro.com>
Date: Wed, 30 Oct 2024 13:35:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unit-stride load-only-first load instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org, negge@google.com
References: <20240918171412.150107-1-max.chou@sifive.com>
 <20240918171412.150107-6-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240918171412.150107-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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



On 9/18/24 2:14 PM, Max Chou wrote:
> The unmasked unit-stride fault-only-first load instructions are similar
> to the unmasked unit-stride load/store instructions that is suitable to
> be optimized by using a direct access to host ram fast path.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 98 ++++++++++++++++++++++++++----------
>   1 file changed, 71 insertions(+), 27 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 824e6401736..59009a940ff 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -557,18 +557,18 @@ GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d_tlb)
>    * unit-stride fault-only-fisrt load instructions
>    */
>   static inline void
> -vext_ldff(void *vd, void *v0, target_ulong base,
> -          CPURISCVState *env, uint32_t desc,
> -          vext_ldst_elem_fn_tlb *ldst_elem,
> -          uint32_t log2_esz, uintptr_t ra)
> +vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
> +          uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
> +          vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
>   {
>       uint32_t i, k, vl = 0;
>       uint32_t nf = vext_nf(desc);
>       uint32_t vm = vext_vm(desc);
>       uint32_t max_elems = vext_max_elems(desc, log2_esz);
>       uint32_t esz = 1 << log2_esz;
> +    uint32_t msize = nf * esz;
>       uint32_t vma = vext_vma(desc);
> -    target_ulong addr, offset, remain;
> +    target_ulong addr, offset, remain, page_split, elems;
>       int mmu_index = riscv_env_mmu_index(env, false);
>   
>       VSTART_CHECK_EARLY_EXIT(env);
> @@ -617,19 +617,63 @@ ProbeSuccess:
>       if (vl != 0) {
>           env->vl = vl;
>       }
> -    for (i = env->vstart; i < env->vl; i++) {
> -        k = 0;
> -        while (k < nf) {
> -            if (!vm && !vext_elem_mask(v0, i)) {
> -                /* set masked-off elements to 1s */
> -                vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
> -                                  (i + k * max_elems + 1) * esz);
> -                k++;
> -                continue;
> +
> +    if (env->vstart < env->vl) {
> +        if (vm) {
> +            /* Calculate the page range of first page */
> +            addr = base + ((env->vstart * nf) << log2_esz);
> +            page_split = -(addr | TARGET_PAGE_MASK);
> +            /* Get number of elements */
> +            elems = page_split / msize;
> +            if (unlikely(env->vstart + elems >= env->vl)) {
> +                elems = env->vl - env->vstart;
> +            }
> +
> +            /* Load/store elements in the first page */
> +            if (likely(elems)) {
> +                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
> +                                  log2_esz, true, mmu_index, ldst_tlb,
> +                                  ldst_host, ra);
> +            }
> +
> +            /* Load/store elements in the second page */
> +            if (unlikely(env->vstart < env->vl)) {
> +                /* Cross page element */
> +                if (unlikely(page_split % msize)) {
> +                    for (k = 0; k < nf; k++) {
> +                        addr = base + ((env->vstart * nf + k) << log2_esz);
> +                        ldst_tlb(env, adjust_addr(env, addr),
> +                                 env->vstart + k * max_elems, vd, ra);
> +                    }
> +                    env->vstart++;
> +                }
> +
> +                addr = base + ((env->vstart * nf) << log2_esz);
> +                /* Get number of elements of second page */
> +                elems = env->vl - env->vstart;
> +
> +                /* Load/store elements in the second page */
> +                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
> +                                  log2_esz, true, mmu_index, ldst_tlb,
> +                                  ldst_host, ra);
> +            }
> +        } else {
> +            for (i = env->vstart; i < env->vl; i++) {
> +                k = 0;
> +                while (k < nf) {
> +                    if (!vext_elem_mask(v0, i)) {
> +                        /* set masked-off elements to 1s */
> +                        vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
> +                                          (i + k * max_elems + 1) * esz);
> +                        k++;
> +                        continue;
> +                    }
> +                    addr = base + ((i * nf + k) << log2_esz);
> +                    ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
> +                             vd, ra);
> +                    k++;
> +                }
>               }
> -            addr = base + ((i * nf + k) << log2_esz);
> -            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
> -            k++;
>           }
>       }
>       env->vstart = 0;
> @@ -637,18 +681,18 @@ ProbeSuccess:
>       vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
>   }
>   
> -#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN)               \
> -void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
> -                  CPURISCVState *env, uint32_t desc)      \
> -{                                                         \
> -    vext_ldff(vd, v0, base, env, desc, LOAD_FN,           \
> -              ctzl(sizeof(ETYPE)), GETPC());              \
> +#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong base,        \
> +                  CPURISCVState *env, uint32_t desc)            \
> +{                                                               \
> +    vext_ldff(vd, v0, base, env, desc, LOAD_FN_TLB,             \
> +              LOAD_FN_HOST, ctzl(sizeof(ETYPE)), GETPC());      \
>   }
>   
> -GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b_tlb)
> -GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h_tlb)
> -GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w_tlb)
> -GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
> +GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b_tlb, lde_b_host)
> +GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h_tlb, lde_h_host)
> +GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w_tlb, lde_w_host)
> +GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb, lde_d_host)
>   
>   #define DO_SWAP(N, M) (M)
>   #define DO_AND(N, M)  (N & M)

