Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231AFC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNyS-00007I-Lm; Mon, 29 Jan 2024 04:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUNyH-0008Si-D2
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:30:31 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUNyF-0007rV-8u
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:30:29 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a35e9161b8cso31349266b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706520625; x=1707125425; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sK6gVJD2kWFzpoOZocWDbhfqKKWceHInB+a4B39Yxdk=;
 b=hyeWvJZkdEghrbmGF2PewarsnUVJZ3kY945GukK4ezxpTnVooUT0IWYcv2qIIhWXp8
 k9NnjsxEymlbi3tJ1JoDN1BCbBGpPiC6v23m+oe+4yIq0x3Zjd8Nfsi0qiQUnf4eUoOm
 qxXYgiOz2/S9vIjcvMENYBWkC+Gg5yaS51VsYqDYYuQcH7jnGSD75ag3llA1x/xQONzO
 1EQ8tfc0tS/VwEwnigiPtLFQT/yvevt/FEZlOgGGav3s6rmlpporIULQKMteIJly3Q1U
 FmIGU+yydcTdLxQoGrFjmEm9Vw7txqSUIY7a+zt5CDQInqfLYPQ7dPgXFgjMdVG00Gbk
 tXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706520625; x=1707125425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sK6gVJD2kWFzpoOZocWDbhfqKKWceHInB+a4B39Yxdk=;
 b=Jeehdqo8g0WE8+lFfJ0ReNdgDSxXGa40I1kNdiQCWHpxznzxwOG4VGJFYlOueaxmd3
 4s5tqzLmBKaE2X2f1f8Z/N+J5UfVqzOHSf9JAuoENdtGmU2QbJbXRFxAbKgl4uqXi1/D
 eZSMiOlkiGnZBC3cI5sCpgbj08jUwcR4kSiYkbyDSpXfRo0XHWPTN8g1uawvIdVNEFPy
 /2qDCwij9XhvZrMkrAgIVLdbKy5c7elQmuS+k2Ex1BWcv4tvMR1bIplP3rBU1JVxu8a7
 Rqr3zh2QDNRyEkB+dPGRYb5vpIPA2TL3zZ2KrC57v+grPxAwDKrcnCXyaUliler+y3S7
 4IGw==
X-Gm-Message-State: AOJu0YwZ32nq6qedgeVeT2ymQ441gMyb2YqhkgvU+kPQJI1ZzZQGIkbz
 MSkG4PFNAEJCfpEy7BWfCPVF8nlj4uWZPIvsjt57okjFUc5x2uT9R16ly0QIPY7Ob1uZotf7+Wi
 N
X-Google-Smtp-Source: AGHT+IGNn5GTknneHFSsSx6J/e06gNywvUbQ4wiSXFS07tf3RKwTnvLIUFYuQOP3MJETaGredbFhJg==
X-Received: by 2002:a17:906:4157:b0:a35:f46b:6e50 with SMTP id
 l23-20020a170906415700b00a35f46b6e50mr25815ejk.35.1706520625379; 
 Mon, 29 Jan 2024 01:30:25 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090652d800b00a3193a5556csm3717337ejn.189.2024.01.29.01.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 01:30:25 -0800 (PST)
Date: Mon, 29 Jan 2024 10:30:24 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2] target/riscv: mcountinhibit, mcounteren and
 scounteren always 32-bit
Message-ID: <20240129-01580d76b59950a405002ea7@orel>
References: <20240129084728.48311-1-vadim.shakirov@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129084728.48311-1-vadim.shakirov@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62c.google.com
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

On Mon, Jan 29, 2024 at 11:47:28AM +0300, Vadim Shakirov wrote:
> mcountinhibit, mcounteren and scounteren must always be 32-bit by
> privileged spec

We should also change hcounteren.

Thanks,
drew

> 
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> ---
>  target/riscv/cpu.h     |  6 +++---
>  target/riscv/machine.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5138187727..2236a55bf1 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -334,10 +334,10 @@ struct CPUArchState {
>       */
>      bool two_stage_indirect_lookup;
>  
> -    target_ulong scounteren;
> -    target_ulong mcounteren;
> +    uint32_t scounteren;
> +    uint32_t mcounteren;
>  
> -    target_ulong mcountinhibit;
> +    uint32_t mcountinhibit;
>  
>      /* PMU counter state */
>      PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 72fe2374dc..6bf013054d 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -354,8 +354,8 @@ static const VMStateDescription vmstate_jvt = {
>  
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
> -    .version_id = 9,
> -    .minimum_version_id = 9,
> +    .version_id = 10,
> +    .minimum_version_id = 10,
>      .post_load = riscv_cpu_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -398,9 +398,9 @@ const VMStateDescription vmstate_riscv_cpu = {
>          VMSTATE_UINTTL(env.mtval, RISCVCPU),
>          VMSTATE_UINTTL(env.miselect, RISCVCPU),
>          VMSTATE_UINTTL(env.siselect, RISCVCPU),
> -        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
> +        VMSTATE_UINT32(env.scounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>          VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
>                               vmstate_pmu_ctr_state, PMUCTRState),
>          VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
> -- 
> 2.34.1
> 
> 

