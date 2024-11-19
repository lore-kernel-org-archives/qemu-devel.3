Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC4AD60D18
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDF08-00068v-Tr; Mon, 18 Nov 2024 22:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDF00-00068U-W9; Mon, 18 Nov 2024 22:33:58 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDEzz-0001hu-7B; Mon, 18 Nov 2024 22:33:56 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-85700f9cdd6so908947241.1; 
 Mon, 18 Nov 2024 19:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731987233; x=1732592033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzG5NBULP5KvEO/QNiostpQ/uvqFR9QGKOMDcPEVx5A=;
 b=Pd+4c1vdlGZP5YBFBIK+oSfYWimL+OII32wTQUt43uDfUfNQ3kq+aNvQgEpuyVqrHh
 oz/u91AIlgrpMguZshssOJPMXgGJxwns09O2VkhX0un/X95U5V8NNJ7xN87tJ1Hoc2St
 y4P5JWHsHtCRdk9sk38+Q/ksYFROwetIlziVaWYvVptmSD6N9AqS8tC/aB5iKwcg1aFR
 6JWcQ7dFpOnfDK5ptmH4m7eoXwmH1Nm9E+f0COMlTwwk6jB3RdNEla53eP2fXqA853l+
 MXD4DcgwI2jBsGFxC+GDLhO9joNmuZCPQlyTKzbwIIBl7Tyu6ECabxEQeJVx7C9dVQjD
 eYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731987233; x=1732592033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzG5NBULP5KvEO/QNiostpQ/uvqFR9QGKOMDcPEVx5A=;
 b=GvxE/tVxKJPDN73wwTqscV3VnP2uAdhDgbuF01C8MixX6h3UJreD3uSIvG+jFr4ZMA
 Tknchj3tDwsBYjLhOtWM+jV5dCWEJWnpt/pd3uxrLLHTW2Bkx+ddADLK4YzbQGwC0SAI
 xJoNcNSDe5r2cYyQGXMzEIBBhpLiamCz/1zitNz2+2tOG4Ub7VeLjnUPOB39bxlbJJDN
 RLljZtWV0xm9k7x43x5uPAGI7DGmnvmDxTfbkXgYdfa+9ETglZOlbL4tQkB8EDAK6Tth
 RddgiWb5v4/Hojhti7jcFH5BMtDTGn5kg06ac4mOolkCPsjDMA+p58d4c66sDHah3TUZ
 TvgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7C3Ve2w3jlpfXdu2JqKvYA7EdnvYw10zaDaL8RpYkpdOg/A8Dmn1x8cTZFhaBa7ywg3UUE3jk230+@nongnu.org
X-Gm-Message-State: AOJu0Ywgk0rYAVy7w1zjllxz1yI+uG5OaF0H5Es+rwk4pIkfXBngZ6cx
 ZNoQvN8rYTG7/K7tegcNUYMgORcbURQebPnaJ9HJRptY7w9BeJB4JcTtqK9Rxo1ygV7IoewD0Bk
 nwdDULOxuTUE4Fkb0FfGfHAZi8Go=
X-Google-Smtp-Source: AGHT+IE5hLPK7oXUosARcKcTtFmNsU8gjKYZaRXD9Nk7A3ZroA39Qtk/L0n29nBRN/MniQQsn11iJjHW8ZOZEyOMEgE=
X-Received: by 2002:a05:6102:32d5:b0:4ad:4dd5:2b31 with SMTP id
 ada2fe7eead31-4ad62b651e7mr13558976137.3.1731987232546; Mon, 18 Nov 2024
 19:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-5-fea.wang@sifive.com>
In-Reply-To: <20241112091423.2529583-5-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:33:25 +1000
Message-ID: <CAKmqyKOm1Fu28Q0mg1OM--g0wbt89J1SVzufjsYvm7u7-ALmWA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] target/riscv: Check memory access to meet svukte
 rule
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Nov 12, 2024 at 7:13=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Follow the Svukte spec, do the memory access address checking
>
> 1. Include instruction fetches or explicit memory accesses
> 2. System run in effective privilege U or VU
> 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
> instruction is HLV, HLVX, HSV and execute from U mode to VU mode
> 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
> 5. Raises a page-fault exception corresponding to the original access
> type.
>
> Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>  target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69ea..5b29344c4f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -857,6 +857,61 @@ static int get_physical_address_pmp(CPURISCVState *e=
nv, int *prot, hwaddr addr,
>      return TRANSLATE_SUCCESS;
>  }
>
> +/* Returns 'true' if a svukte address check is needed */
> +static bool do_svukte_check(CPURISCVState *env, bool first_stage,
> +                             int mode, bool virt)
> +{
> +    bool ukte;
> +
> +    /* Svukte extension depends on Sv39. */
> +    if (!(env_archcpu(env)->cfg.ext_svukte ||
> +        !first_stage ||
> +        VM_1_10_SV39 !=3D get_field(env->satp, SATP64_MODE))) {
> +        return false;
> +    }
> +
> +    /*
> +     * Check hstatus.HUKTE if the effective mode is switched to VU-mode =
by
> +     * executing HLV/HLVX/HSV in U-mode.
> +     * For other cases, check senvcfg.UKTE.
> +     */
> +    if (env->priv =3D=3D PRV_U && !env->virt_enabled && virt) {
> +        ukte =3D !!(env->hstatus & HSTATUS_HUKTE);

You should just be able to use get_field() here

> +    } else {
> +        ukte =3D !!(env->senvcfg & SENVCFG_UKTE);
> +    }
> +
> +    if (!ukte) {
> +        return false;

and it's probably simpler to remove the ukte variable and just return
based on the result of get_field()

> +    }
> +
> +    /*
> +     * Svukte extension is qualified only in U or VU-mode.
> +     *
> +     * Effective mode can be switched to U or VU-mode by:
> +     *   - M-mode + mstatus.MPRV=3D1 + mstatus.MPP=3DU-mode.
> +     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=3D0.
> +     *   - U-mode.
> +     *   - VU-mode.
> +     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=3D1.
> +     */
> +    if (mode !=3D PRV_U) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
> +{
> +    uint32_t sxl =3D riscv_cpu_sxl(env);
> +    sxl =3D (sxl =3D=3D 0) ? MXL_RV32 : sxl;

I don't think riscv_cpu_sxl() can return 0, do we actually need this check?

Also this extension isn't defined for RV32

Alistair

> +    uint32_t sxlen =3D 32 * sxl;
> +    uint64_t high_bit =3D addr & (1UL << (sxlen - 1));
> +
> +    return !high_bit;
> +}
> +
>  /*
>   * get_physical_address - get the physical address for this virtual addr=
ess
>   *
> @@ -894,6 +949,7 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>      MemTxResult res;
>      MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      int mode =3D mmuidx_priv(mmu_idx);
> +    bool virt =3D mmuidx_2stage(mmu_idx);
>      bool use_background =3D false;
>      hwaddr ppn;
>      int napot_bits =3D 0;
> @@ -901,6 +957,11 @@ static int get_physical_address(CPURISCVState *env, =
hwaddr *physical,
>      bool is_sstack_idx =3D ((mmu_idx & MMU_IDX_SS_WRITE) =3D=3D MMU_IDX_=
SS_WRITE);
>      bool sstack_page =3D false;
>
> +    if (do_svukte_check(env, first_stage, mode, virt) &&
> +        !check_svukte_addr(env, addr)) {
> +        return TRANSLATE_FAIL;
> +    }
> +
>      /*
>       * Check if we should use the background registers for the two
>       * stage translation. We don't need to check if we actually need
> --
> 2.34.1
>
>

