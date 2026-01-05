Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A89ECD0407
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcrl9-0001fL-Hn; Mon, 05 Jan 2026 16:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcrl8-0001em-9R
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:05:02 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcrl6-0003po-CP
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:05:01 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so398651b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767647099; x=1768251899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oojgqbVZJFnZ71rWhStDXV6ptsmCZnMfdxVeg3Qc5V8=;
 b=ailwJBD2h7GqY/FPCJ5982jXD4kV4YHeokCzAOJPmuvND0tneMeQoUa9BR9vJsfCVd
 aV7wo7UPphK2s+3kHZekFgdded+5rJ9m9bWb9Wn35vy1A55xbK0g3LLycOGTnv5glNQy
 jR32rtI/J4eD8dPrKm4abwZsJKa5q6GzTUP9HXR0DefS+pxiS03WHHri0gmumeHGckfk
 FVjoKNNDL+fBEz0fODOgG8WQVWDk7agywqfJB9n1Ckxz2N5R7bUlm19VXaQ0QAqoChWi
 +O2QafLb6/j5OFo1Wdtf2Sgaf43ilvds+e7yBPRhhIYaNDMXJ7LDm19nTxzSua9hyHD1
 LkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767647099; x=1768251899;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oojgqbVZJFnZ71rWhStDXV6ptsmCZnMfdxVeg3Qc5V8=;
 b=rNJjgWFOSEyHgwOufgNR5tYwr4D4SBmc8izbBvPvome6f4uyHsI+OqcfPBi4qeG4Z1
 eRQVpOEJFlZpIFc+kE+ZIjKCduJ2HnL44trfynBZCjgd4lCeR9eLFn652ikM2wS5MaGW
 XCCHUvhz27CkFZRdIGmBiboBIJYdI+taU1pRnpGLnuEMNGPafSlUf5fcb865iksTThdO
 FiN0xpoHCjNajbx60QLFpkAkLwdQcH9qNWVfbnq3GULXqQipsq1noNFaLo5gAp5AjW38
 xKTio3w/zBkpCF01vNPHsDl1YMh+w/UO0KnxCg7g/RTLgfpqSYRspGfQ9y74ZLIo1mGz
 AcVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLts6i/M7Gr8Iq8bn4pt95hRdRrzC3K5r2mBpYNJSHMBDhzlbFMN3FBnj8U0q58XxvaPujvGFw1Yb4@nongnu.org
X-Gm-Message-State: AOJu0Yw3tIMGBRMXrHVM28F9U6+UmQTcVX+V7ypKyxyJUbVDEP0JDfm4
 y2mXbETbVVSnVObUfBZcXxOJxCBd1mlGjw1LhzJN0UWDWLyVE6xV3MvD3V0+4zRAyFFPePyNEWz
 2bvOjbGA=
X-Gm-Gg: AY/fxX7peZMyKQXTYdCYfSGCLMwqcGKrpYavltRvOOp4rw3UP87avi8ZsapJ0Ruy24W
 7yjdRfF6mfLBTyUwJ5jDBLTTvny0pWSUOCo/K6VlVniHj+m3sIGtesh8cuX4Ct5JWyqDUSPb7AW
 2hcXiYqIUvqqjNXsAf1qbsHApCURHc2Ti7iY3XNo0q8qTOPCjXP3BE/AeYGn4TwYL1h81tNMBQQ
 hOmO3b0BDbT6q0akghGMp3AlnGM+uVdsfNh67Q4zzfScSwJsgvudPNhjjjue0Tu0q3Y2HE5bLsB
 pWOeAIOGMNPTRNHD/fd36xbFX9DhAGXgfcNUeLp8FCiDrFfkUXZSEvuCmZ8n0OZf/mvR9Bb3oKj
 4EGcFLkGJFFWdZrY8qRlRJBRKerLG3sF2w7pyLusZymk+1A6AgmP4Kl98H36maFig5BXYUrBydP
 N9N7K9mtyiL8np5vD5fmzIBmw67Kqc8azfmn6hNxU8
X-Google-Smtp-Source: AGHT+IHlWpvGcF/N+VYlYrplC0gLzwQ1oIes7bqBd1+6Y9c6fEmXx5MrSy9tOfZtf546r6EMe11uIQ==
X-Received: by 2002:a05:6a00:1d9f:b0:7e8:4433:8fa0 with SMTP id
 d2e1a72fcca58-818825f39d5mr794022b3a.40.1767647098693; 
 Mon, 05 Jan 2026 13:04:58 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52f8952sm63461b3a.39.2026.01.05.13.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 13:04:58 -0800 (PST)
Message-ID: <b83b2bbe-4cf3-487f-9a46-11487db8c062@linaro.org>
Date: Tue, 6 Jan 2026 08:04:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 01/12] target/arm: implement MTE_PERM
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
 <20260105-feat-mte4-v3-1-86a0d99ef2e4@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260105-feat-mte4-v3-1-86a0d99ef2e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/6/26 05:14, Gabriel Brookman wrote:
> Introduces a new stage 2 memory attribute, NoTagAccess, that raises a
> stage 2 data abort on a tag check, tag read, or tag write.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/cpu-features.h   |  5 +++++
>   target/arm/ptw.c            | 17 ++++++++++++++++-
>   target/arm/tcg/mte_helper.c | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index c86a4e667d..48009b5a66 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1139,6 +1139,11 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
>   }
>   
> +static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) == 1;
> +}

Per the Arm ARM re future expansion, this should be true for any non-zero value.
See "D24.1.3 Principles of the ID scheme for fields in ID registers".

> @@ -3403,6 +3403,18 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
>           s1.attrs = 0xff;
>       }
>   
> +    if (hcr & HCR_FWB) {
> +        if (s2.attrs >= 0xe) {
> +            notagaccess = true;
> +            s2.attrs = 0x7;
> +        }
> +    } else {
> +        if (s2.attrs == 0x4) {
> +            notagaccess = true;
> +            s2.attrs = 0xf;
> +        }
> +    }
> +
>       /* Combine shareability attributes (table D4-43) */
>       if (s1.shareability == 2 || s2.shareability == 2) {
>           /* if either are outer-shareable, the result is outer-shareable */
> @@ -3437,6 +3449,9 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
>       /* TODO: CombineS1S2Desc does not consider transient, only WB, RWA. */
>       if (tagged && ret.attrs == 0xff) {
>           ret.attrs = 0xf0;
> +        if (notagaccess) {
> +            ret.attrs = 0xe0;
> +        }
>       }

Better as

     ret.attrs = notagaccess ? 0xe0 : 0xf0;

Given that this hunk corresponds to J1.3.5.2 EncodePARAttrs, I think it would be worth a 
comment that FEAT_MTE_PERM is checked in allocation_tag_mem_probe and that the attr 
encoding is otherwise RESERVED.


> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index bb48fe359b..942bd4103d 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -57,6 +57,28 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
>       return tag;
>   }
>   
> +#ifdef CONFIG_USER_ONLY
> +#else

#ifndef


> +/*
> + * Constructs S2 Permission Fault as described in ARM ARM "Stage 2 Memory
> + * Tagging Attributes".
> + */
> +static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
> +                                uintptr_t ra, bool is_write)
> +{
> +    uint64_t syn;
> +
> +    env->exception.vaddress = dirty_ptr;
> +
> +    syn = syn_data_abort_no_iss(0, 0, 0, 0, 0, is_write, 0);
> +
> +    syn |= BIT_ULL(42); /* TnD is bit 42 */

Surely (32 + 9) == 41 for the TagAccess bit.

> +
> +    raise_exception_ra(env, EXCP_DATA_ABORT, syn, 2, ra);
> +    g_assert_not_reached();
> +}
> +#endif
> +
>   uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>                                     uint64_t ptr, MMUAccessType ptr_access,
>                                     int ptr_size, MMUAccessType tag_access,
> @@ -116,6 +138,15 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>       }
>       assert(!(flags & TLB_INVALID_MASK));
>   
> +    /*
> +     * If the virtual page MemAttr == Tagged NoTagAccess, throw S2 permission
> +     * fault (conditional on mteperm being implemented and RA != 0).
> +     */
> +    if (ra && cpu_isar_feature(aa64_mteperm, env_archcpu(env))
> +        && full->extra.arm.pte_attrs == 0xe0) {
> +        mte_perm_check_fail(env, ptr, ra, tag_access == 1);
> +    }
> +
>       /* If the virtual page MemAttr != Tagged, access unchecked. */
>       if (full->extra.arm.pte_attrs != 0xf0) {
>           return NULL;
> 


r~

