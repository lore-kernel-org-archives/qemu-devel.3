Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EDAC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 05:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWrO9-0005vA-SM; Thu, 25 Jul 2024 01:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWrO6-0005nh-KM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:51:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWrO4-0004tF-Bx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:51:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fed72d23a7so3280185ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 22:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721886694; x=1722491494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TZLdUhiHiJY+HDjHkpTdKEGF6p5T/aXwZgHKgsEq930=;
 b=hSpc7CeWQruUicGl+eG/3UIfbIeFTGz5Pb0S3sv2qTmKrSV7Krn/5CACpszeVAK7KF
 IGS2jK+SUPO304t1HCUpVGiRtigSvZWd13XpWp3Dd/y7UNuyPNU1eqXIJsmFySVxdJpn
 TiTCoMir/XoBtyyXlhG2fhN+UhdsePHhCL6CxFJnpZr1R5N4Ym3rlaIzzkuJy+DbRpBV
 j/vB8fRudZ5AoRNKzVafUF0fxCPsrQyY9YQxbhoexf69eHV+q+0r2C9rH6rN29xmAntp
 Zhqs15SVMrTwLa7164C4cIiH3U7RkKcUNpsmxByc1Zmty/AE/2+nJDySGII9vSXb8Qzk
 CYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721886694; x=1722491494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TZLdUhiHiJY+HDjHkpTdKEGF6p5T/aXwZgHKgsEq930=;
 b=T315Rqz4w5YD+XckZ43Go5azCaiRLIGduCe266wrkM6mvpKb/IY6XvHiJvF1/GQJPY
 QbyPsLhTtLWSi3TbFIRWimP82E2J8pruL2M8vk7jYIhUBb7aqYSZwbhkMVo4ePnfr7ZU
 Qky65dXJebMDwGgx1j65/aj5c6lFU4fygld+JgmVDlIg0DCDl6fiMagrxFKH2dMMCgkH
 syQuI2oW0thT8zdVsq4kzi9GygpNjthHufb9PpJR/KsSTeClPeEu8xFuXqmnwdTiKxFi
 Uml+iuA16k3M8tDgFMxPmBMRb1+9S4xecl+gTpYG7+XONv9D0yVSHMSTIrrovV+DzzSy
 U33w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1JEqtydEahcofnjlMiJWOxzWOsnHvMdhhZm5T7ExdwVQSxKnz0j1spgj47AfwFfyzDZrw4M6X0nRdVTcpyW1+BXGA4K4=
X-Gm-Message-State: AOJu0YyNVJhD81WnZtd19P+R6/760q3L3en/pXKcR4myfRLKOIuCl1nc
 IXO/VoGhYiE8xuyO56k50r4x3Xx16g5JIFFRqQXlMr/zqlTvzACr2O8pb/twOq0=
X-Google-Smtp-Source: AGHT+IEZt7Ca3iM0ki8iXJWD3eY4u2YxFVg4h7RU95+r2cdZnP3lLnvoVKtPLrgHTso93ctUPQLJjA==
X-Received: by 2002:a17:902:db03:b0:1fa:925b:5b77 with SMTP id
 d9443c01a7336-1fed9390996mr10668325ad.64.1721886693539; 
 Wed, 24 Jul 2024 22:51:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f1e880sm5390085ad.185.2024.07.24.22.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 22:51:33 -0700 (PDT)
Message-ID: <a02bcaba-0712-44f2-924f-8972a4f98ce7@linaro.org>
Date: Thu, 25 Jul 2024 15:51:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unmasked unit-stride load/store
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
 <20240717133936.713642-3-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240717133936.713642-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/17/24 23:39, Max Chou wrote:
> @@ -199,7 +212,7 @@ static void
>   vext_ldst_stride(void *vd, void *v0, target_ulong base,
>                    target_ulong stride, CPURISCVState *env,
>                    uint32_t desc, uint32_t vm,
> -                 vext_ldst_elem_fn *ldst_elem,
> +                 vext_ldst_elem_fn_tlb * ldst_elem,

Extra space: "type *var"

>                    uint32_t log2_esz, uintptr_t ra)
>   {
>       uint32_t i, k;
> @@ -221,7 +234,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
>                   continue;
>               }
>               target_ulong addr = base + stride * i + (k << log2_esz);
> -            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
> +            ldst_elem(env, adjust_addr(env, addr),
> +                      (i + k * max_elems) << log2_esz, vd, ra);

Is this some sort of bug fix?  It doesn't seem related...
If it is a bug fix, it should be a separate patch.

>   /*
>    * unit-stride: access elements stored contiguously in memory
>    */
>   
>   /* unmasked unit-stride load and store operation */
> +static void
> +vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
> +                  uint32_t elems, uint32_t nf, uint32_t max_elems,
> +                  uint32_t log2_esz, bool is_load,
> +                  vext_ldst_elem_fn_tlb *ldst_tlb,
> +                  vext_ldst_elem_fn_host *ldst_host, uintptr_t ra)
> +{
> +    void *host;
> +    int i, k, flags;
> +    uint32_t esz = 1 << log2_esz;
> +    uint32_t size = (elems * nf) << log2_esz;
> +    uint32_t evl = env->vstart + elems;
> +    int mmu_index = riscv_env_mmu_index(env, false);
> +    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;

You may want to pass in mmu_index, so that it is computed once in the caller.

> +
> +    /* Check page permission/pmp/watchpoint/etc. */
> +    flags = probe_access_flags(env, adjust_addr(env, addr), size, access_type,
> +                               mmu_index, true, &host, ra);
> +
> +    if (host && flags == 0) {

If flags == 0, host will always be non-null.
You only need flags == 0.

>   static void
>   vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
> -             vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uint32_t evl,
> -             uintptr_t ra)
> +             vext_ldst_elem_fn_tlb *ldst_tlb,
> +             vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
> +             uint32_t evl, uintptr_t ra, bool is_load)
>   {
> -    uint32_t i, k;
> +    uint32_t k;
> +    target_ulong page_split, elems, addr;
>       uint32_t nf = vext_nf(desc);
>       uint32_t max_elems = vext_max_elems(desc, log2_esz);
>       uint32_t esz = 1 << log2_esz;
> +    uint32_t msize = nf * esz;
>   
>       VSTART_CHECK_EARLY_EXIT(env);
>   
> -    /* load bytes from guest memory */
> -    for (i = env->vstart; i < evl; env->vstart = ++i) {
> -        k = 0;
> -        while (k < nf) {
> -            target_ulong addr = base + ((i * nf + k) << log2_esz);
> -            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
> -            k++;
> +    while (env->vstart < evl) {

VSTART_CHECK_EARLY_EXIT has taken care of this condition for the first page.
We know that one contiguous operation can only consume 1024 bytes, so cannot cross two 
pages.  Therefore this loop executes exactly once or twice.

I think it would be better to unroll this by hand:

     calc page range
     if (likely(elems)) {
         vext_page_ldst_us(... elems ...);
     }
     if (unlikely(env->vstart < evl)) {
         if (unlikely(page_split % msize)) {
            ...
         }
         vext_page_ldst_us(... evl - vstart ...);
     }

> +        /* Calculate page range */
> +        addr = base + ((env->vstart * nf) << log2_esz);
> +        page_split = -(addr | TARGET_PAGE_MASK);
> +        /* Get number of elements */
> +        elems = page_split / msize;
> +        if (unlikely(env->vstart + elems >= evl)) {
> +            elems = evl - env->vstart;
> +        }
> +
> +        /* Load/store elements in page */
> +        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
> +                          is_load, ldst_tlb, ldst_host, ra);
> +
> +        /* Cross page element */
> +        if (unlikely((page_split % msize) != 0 && (env->vstart + 1) < evl)) {
> +            for (k = 0; k < nf; k++) {
> +                addr = base + ((env->vstart * nf + k) << log2_esz);
> +                ldst_tlb(env, adjust_addr(env, addr),
> +                         (k * max_elems + env->vstart) << log2_esz, vd, ra);
> +            }
> +            env->vstart++;
>           }
>       }
> -    env->vstart = 0;
>   
> +    env->vstart = 0;
>       vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
>   }


r~

