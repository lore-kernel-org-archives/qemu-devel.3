Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5D2CD37B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 22:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slbrM-0001xc-8Y; Tue, 03 Sep 2024 18:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slbrK-0001we-J9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 18:18:46 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slbrI-0000b3-MX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 18:18:46 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-710a1bb9ecdso1548659a34.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725401923; x=1726006723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7IS12mMYKrrEOTbZHm3qjCQE84at0VshdLotO1w12Rw=;
 b=cGMpBrnqUQmCwKDfcRMhEJA/aU87g3C+rZs0oLQowOu84IreNMatU6bgDi8icltr4J
 4QXLoRbwz1Xj8ODXh4U6XWTJsQoRvbicVKvpErz2yQqNFm94zy08ZWZZv46dMlPyHJ0P
 KMUkEWPdSwMQkAQ/tchW4yd59NPrTk05si5iAQHYuMrHoQ/pfwW0dGj/d0ees8/dsET5
 wGa146jMbnUtIcpMfZnZGbyIyZQErvGDwjdO6Z18/rVyoD4R7ovo0IySM9+wo5hWkauL
 V6I7bTHtLdyqTFkQ9OsI80wyYkzbU5oE/XHK5pY3bIwNyjQC5GezyIrejQbVKnlPmVD3
 RkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725401923; x=1726006723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7IS12mMYKrrEOTbZHm3qjCQE84at0VshdLotO1w12Rw=;
 b=pBZqGjZpTFejlXTj9H9XJgwKu9EdtbEXC6o+0BDhhIhyG0xkFoGa9mIEZ72s967TAo
 7gfgvrNuWFPT1IyPZfS4mnVC3bdqrKaklca2im17zrezNab/Ubw2mvoJTpTGpKn0YX7s
 qdBQayh/HP/YMoNiCgpUQBYFsx1zIHgCVXBLnc5T4yUMZ7rvswvMfl0j957QAVMW5WHO
 bIrUvFxzmmoQ0avNWnRPrg0H++eMxAIWTlXW8/kV5dybwCO9BNCwOmg8HKhTB24WSkKy
 TGCQ/9eZZvJejqQk4StrRJbYT5FRBvQx4ufgvr6wzferbKH7VtOn9l9nrn7PF66OAz0A
 KUqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNUz297wwmrKZbBVDvzIsjzQNTRDgBV8tY0yQN1+DMESdv3UBv5rYxaH1ckUM+IIYNf7uib3i7JySu@nongnu.org
X-Gm-Message-State: AOJu0Ywidc8AoO3jUCZisxXugSpruqu3HccQQpsM5pwbWLapTs2bfahm
 aAGytmEoBIcv3rlGXrWf3LR3M6/jp6r8Q6thA/DYJmrqHz+D/Yuyde4lqgzbtig=
X-Google-Smtp-Source: AGHT+IEqbIUaKaavLqER+dNpWPozOZZplYWagl66VzBoK3LYvmpN78qje1zEitcRgeWdpsoi+8cF+A==
X-Received: by 2002:a05:6358:9146:b0:1aa:d7aa:62a3 with SMTP id
 e5c5f4694b2df-1b7ef70b24cmr1550177155d.28.1725401922716; 
 Tue, 03 Sep 2024 15:18:42 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d4fbd92aaasm376712a12.50.2024.09.03.15.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 15:18:42 -0700 (PDT)
Message-ID: <336979c7-4396-4475-9323-5e0523d27b5b@ventanamicro.com>
Date: Tue, 3 Sep 2024 19:18:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/riscv: Check memory access to meet svuket rule
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
References: <20240903061757.1114957-1-fea.wang@sifive.com>
 <20240903061757.1114957-5-fea.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240903061757.1114957-5-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x336.google.com
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



On 9/3/24 3:17 AM, Fea.Wang wrote:
> Follow the Svukte spec, do the memory access address checking
> 
> 1. Include instruction fetches or explicit memory accesses
> 2. System run in effective privilege U or VU
> 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
>     instruction is HLV, HLVX, HSV and excute from U mode to VU mode
> 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
> 5. Raises a page-fault exception corresponding to the original access
>     type.
> 
> Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>   target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d9140..db65ed14b9 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -777,6 +777,54 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>       return TRANSLATE_SUCCESS;
>   }
>   
> +/*
> + * Return 'true' means no need to do svukte check, or need to do svukte and the
> + * address is valid. Return 'false' means need to do svukte check but address
> + * is invalid.
> + */
> +static bool check_svukte_valid(CPURISCVState *env, vaddr addr,
> +                               int mode, bool virt)
> +{
> +    if (VM_1_10_SV39 != get_field(env->satp, SATP64_MODE))  {
> +        /* Svukte extension depends on Sv39. */
> +        return true;
> +    }
> +
> +    /*
> +     * Svukte extension is qualified only in U or VU-mode.
> +     *
> +     * Effective mode can be switched to U or VU-mode by:
> +     *   - M-mode + mstatus.MPRV=1 + mstatus.MPP=U-mode.
> +     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=0.
> +     *   - U-mode.
> +     *   - VU-mode.
> +     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=1.
> +     */
> +    if (mode != PRV_U) {
> +        return true;
> +    }
> +
> +    /*
> +     * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
> +     * executing HLV/HLVX/HSV in U-mode.
> +     * For other cases, check senvcfg.UKTE.
> +     */
> +    bool ukte = (env->priv == PRV_U && !env->virt_enabled && virt) ?
> +                                           !!(env->hstatus & HSTATUS_HUKTE) :
> +                                           !!(env->senvcfg & SENVCFG_UKTE);

I would move the 'bool ukte' to the start of the function, and would avoid the
ternary to make the code a bit more readable:

       if (env->priv == PRV_U && !env->virt_enabled && virt) {
           ukte = !!(env->hstatus & HSTATUS_HUKTE);
       } else {
           ukte = !!(env->senvcfg & SENVCFG_UKTE);
       }


> +
> +    if (!ukte) {
> +        return true;
> +    }
> +
> +    uint32_t sxl = riscv_cpu_sxl(env);
> +    sxl = (sxl == 0) ? MXL_RV32 : sxl;
> +    uint32_t sxlen = 32 * sxl;
> +    uint64_t high_bit = addr & (1UL << (sxlen - 1));
> +
> +    return !high_bit;
> +}
> +
>   /*
>    * get_physical_address - get the physical address for this virtual address
>    *
> @@ -814,11 +862,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       MemTxResult res;
>       MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       int mode = mmuidx_priv(mmu_idx);
> +    bool virt = mmuidx_2stage(mmu_idx);
>       bool use_background = false;
>       hwaddr ppn;
>       int napot_bits = 0;
>       target_ulong napot_mask;
>   
> +    if (first_stage) {
> +        if (!check_svukte_valid(env, addr, mode, virt)) {
> +            return TRANSLATE_FAIL;
> +        }
> +    }
> +

We can avoid the nested 'if':

> +    if (first_stage && !check_svukte_valid(env, addr, mode, virt)) {
> +        return TRANSLATE_FAIL;
> +    }


I would also add a check for ext_svukte before doing any checks. If we don't have
the ext enabled we can skip everything:


> +    if (env_archcpu(env)->cfg.ext_svukte && first_stage &&
> +        !check_svukte_valid(env, addr, mode, virt)) {
> +        return TRANSLATE_FAIL;
> +    }



Thanks,

Daniel


>       /*
>        * Check if we should use the background registers for the two
>        * stage translation. We don't need to check if we actually need

