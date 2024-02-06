Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C3CC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOKD-0002Ay-0R; Tue, 06 Feb 2024 11:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rXOKC-0002Ai-6F
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:29:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rXOKA-0001hf-5o
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:29:31 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40ff812442aso2187365e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707236968; x=1707841768; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S0uANY8i4xWI7Qyl8WOf3ZMO6SrEUqaO4OLMFDJI5qM=;
 b=RkWWbDGxED5hm4UzcEwYbxIuk3YHBtF+Oz7wKGbe5Twmnf87EZS1EqO29zYCDxgc+N
 m3baaG9HroHWgUeD2PWooAI67OlMh1/VjbGfr1TVSA+wYtp21tXqqrYG3U3BX5ULKq17
 8nLdt9fLBW/PUQh16u5AitW7y+x1PBUm0NzlCMQq8SFXphwKYEeCNsHN9oq88eZqHfaZ
 39uJq05tgZW/pYdnvM1b9bJohxuTm8XjfVGGsBGWhmeWTTqEY/taCIehKxnsK+uR3EC9
 4IHDAVhgpaEOblxtwARnSoEUwyQY8tDsQpYaNVwwPZb14HsqAiU/+G3zNkejMeESHn9h
 eotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707236968; x=1707841768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0uANY8i4xWI7Qyl8WOf3ZMO6SrEUqaO4OLMFDJI5qM=;
 b=FuqZkBBMn3Ublx8ZNgOKP2negrV9udiSUw4mqwS0DYrSJE/Coa6bEUUelvFgvOLrjK
 k/UtyZoJsXutWoFlj8mUVOgXbnGal9HrUop1x03BTxZNIRLo6NwfBTltsFw91usfJD+8
 VMlP5MdDe4Gvd1cOAOhvyGNzTf69/MgvdYt/HS4dFmWPSGd3agoc8RhGP2x+ATMGio3P
 Ehw074FvIk/TTizWjgfSJpJQklDuSDoKh4q3JsZ9Q33ocNYPF/6PFj7oAVDgPx40/1c+
 eS95epGAs5o3Um+N4AoUOoWC8z7Df0Gz9rZBMnIpaFq9rwosrtw3WlLr/cmx6mePKvpP
 TTIQ==
X-Gm-Message-State: AOJu0YxVElNW5Z9OmeOrsGcWko5PnYtV5CdA5oAHJQjoyPh7oul2pC5q
 hxHKTlDyCi7CzgmEKmXTdoFSeTxqHUbIzpo+GueAeCjgarPIf4cc6vNobSJKEyibBACcd2Mdofy
 M
X-Google-Smtp-Source: AGHT+IE/TGcbPIDkltKC28VL4OQV74M0wTVgt9NvGt1DPDuLfll/CQgB8WmXtqRk0yaVPNG3sPQLdQ==
X-Received: by 2002:a05:6000:183:b0:33a:fe30:b8b4 with SMTP id
 p3-20020a056000018300b0033afe30b8b4mr1801054wrx.39.1707236968014; 
 Tue, 06 Feb 2024 08:29:28 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWxjHydBf9l1vvAphjTmX8w8aSLI3V77ChNrF82Fsac84ztPSJyNhC9vA871r+/zdMLJBZ1VmNsayoEuxzWKYScuUinS6JrNeAPNT8B8zjYhmkE6yUwIAoM580cViBBLtKSV27uPf9mBreO1uoE0sMu5jWkJjbRNbQU3jrcClyNEI/7pZwH6SYBX7kx3E3wuSQ/jea0lQg8TpzaUUKaukdcscBYI70b+ArJmQPDoxYsFXs2qmvykFKJIp9IP6vkzb1gYv+GHOf/pRbbEPRaFFx7Ju/Jd6D/aS1p
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a5d4523000000b0033b17880eacsm2473722wra.56.2024.02.06.08.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 08:29:27 -0800 (PST)
Date: Tue, 6 Feb 2024 17:29:26 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v4] target/riscv: mcountinhibit, mcounteren, scounteren,
 hcounteren is 32-bit
Message-ID: <20240206-f53ed33cab0ae364e10d9b6b@orel>
References: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Feb 02, 2024 at 02:39:19PM +0300, Vadim Shakirov wrote:
> mcountinhibit, mcounteren, scounteren and hcounteren must always be 32-bit
> by privileged spec
> 
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>

You should have added my and Alistair's tags when reposting.
And you should CC previous reviewers.

Anyway, here's mine again

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

drew

> ---
>  target/riscv/cpu.h     |  8 ++++----
>  target/riscv/machine.c | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5138187727..cf1867a6e2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -271,7 +271,7 @@ struct CPUArchState {
>      target_ulong hstatus;
>      target_ulong hedeleg;
>      uint64_t hideleg;
> -    target_ulong hcounteren;
> +    uint32_t hcounteren;
>      target_ulong htval;
>      target_ulong htinst;
>      target_ulong hgatp;
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
> index 72fe2374dc..a4d47ec17e 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -79,14 +79,14 @@ static bool hyper_needed(void *opaque)
>  
>  static const VMStateDescription vmstate_hyper = {
>      .name = "cpu/hyper",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
>      .needed = hyper_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL(env.hstatus, RISCVCPU),
>          VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
>          VMSTATE_UINT64(env.hideleg, RISCVCPU),
> -        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.hcounteren, RISCVCPU),
>          VMSTATE_UINTTL(env.htval, RISCVCPU),
>          VMSTATE_UINTTL(env.htinst, RISCVCPU),
>          VMSTATE_UINTTL(env.hgatp, RISCVCPU),
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

