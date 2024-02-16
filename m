Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C1CC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razmT-0001Tr-Ft; Fri, 16 Feb 2024 10:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1razmF-0001Py-2B
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:05:23 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1razmC-000166-VJ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:05:22 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d918008b99so18096785ad.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708095919; x=1708700719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zItzZE+8VFPxucbXvrzht6cgzQM/wiZTpdu4plEgS4U=;
 b=VRoCed6B6w8H9IT0pybeYNXt1pmiXmrY2wj8RFP0orq2Nvaq9SPloIMCZUwDmWd2UL
 uBtvYW75WE94kjgbV6r96f6GB1qK7MaZ3V9pYjZRmx/mqt/t2PwnotuvsHXIO69PuNgF
 qyTQw67ks4HE8kvljm9WUFEPuz50kMmn5mIyLXWJibCLEh+4kVRUsAH2oD6IytIYTXLY
 yUBZR59aMaKYcPY0zKRWiYzuOVCch3pACH3hD1NgQJMUAauIxG7FuK2S5PyYIpX/3Otm
 kWNXT5SiiKC+ay33cyPbyIAWkME2IL7H2Ig3zx898zDAFx9MFWmmtMnC/tbu4ghSf5i8
 +IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708095919; x=1708700719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zItzZE+8VFPxucbXvrzht6cgzQM/wiZTpdu4plEgS4U=;
 b=th9R9pguS1aiFvv6aCCPdUz8Vll49E0W/W8PNPTAcot/CZO+dXvDW4CMNzipqV8lbT
 1UPent8z7L0saoPpxTHzZFr/jdT42DNHTLsTwjpMxiFz7R7ntyqcoCg0dvniTdQ3bNxK
 +rxLzKFln2zyXnCBdbvTKbrsAUnCN5H+okBe5/qipYV1XI7lUBcuUli7OntF6oAifPJr
 hTMtTcYSKxmfByOeWg8qX/S4gUT7GspL1n2a7y0xjRwI/TdX0+4XhvmoKyWNrYquuABK
 hUjR04VGuEuZ4gpBaVwRLsTe04arLjBvatprTrim7XvqG2Z9YulgHjs6M7L0D1DWQySv
 fIeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEh/nH8Ie8vCXI8NxggPkEoMkFPjqL4zlSZQ8V4sixkHdZbpllqlQc64KEGDiPCeCNpdt1UcO6Py4oeoAtIz6gR7OM5nw=
X-Gm-Message-State: AOJu0YybCXE+PiAC7rZJEE4E+e84/P7gS677+pyRH6RscuGz/vxKuJBj
 UrOdQrG6SxDLjUkzXe9raQ/pC9cPBJmSz/111UzppuMp3Xz22jEnpLFE5BThKWc=
X-Google-Smtp-Source: AGHT+IFE0byytz3npLaHPmQKj4DSQYmeqhUA2ENyVvbKGLMgMbqT38itvH52UVcv0tbfdgN+gQn/Yg==
X-Received: by 2002:a17:902:8c98:b0:1db:5468:20d9 with SMTP id
 t24-20020a1709028c9800b001db546820d9mr4745571plo.44.1708095919582; 
 Fri, 16 Feb 2024 07:05:19 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a170902a3c700b001db90df1283sm2889442plb.4.2024.02.16.07.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 07:05:19 -0800 (PST)
Message-ID: <015d2d76-3903-4b18-8845-77001ac786b1@ventanamicro.com>
Date: Fri, 16 Feb 2024 12:05:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/riscv: Add CSR tcontrol of debug trigger module
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240216061332.50229-1-alvinga@andestech.com>
 <20240216061332.50229-2-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240216061332.50229-2-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 2/16/24 03:13, Alvin Chang wrote:
> The RISC-V debug specification defines an optional CSR "tcontrol" within
> the trigger module. This commit adds its read/write operations and
> related bit-field definitions.
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h      |  1 +
>   target/riscv/cpu_bits.h |  3 +++
>   target/riscv/csr.c      | 15 +++++++++++++++
>   3 files changed, 19 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f52dce78ba..f9ae3e3025 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -364,6 +364,7 @@ struct CPUArchState {
>       target_ulong tdata1[RV_MAX_TRIGGERS];
>       target_ulong tdata2[RV_MAX_TRIGGERS];
>       target_ulong tdata3[RV_MAX_TRIGGERS];
> +    target_ulong tcontrol;
>       target_ulong mcontext;
>       struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
>       struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index fc2068ee4d..3b3a7a0fa4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -353,6 +353,7 @@
>   #define CSR_TDATA2          0x7a2
>   #define CSR_TDATA3          0x7a3
>   #define CSR_TINFO           0x7a4
> +#define CSR_TCONTROL        0x7a5
>   #define CSR_MCONTEXT        0x7a8
>   
>   /* Debug Mode Registers */
> @@ -900,6 +901,8 @@ typedef enum RISCVException {
>   #define JVT_BASE                           (~0x3F)
>   
>   /* Debug Sdtrig CSR masks */
> +#define TCONTROL_MTE                       BIT(3)
> +#define TCONTROL_MPTE                      BIT(7)
>   #define MCONTEXT32                         0x0000003F
>   #define MCONTEXT64                         0x0000000000001FFFULL
>   #define MCONTEXT32_HCONTEXT                0x0000007F
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d4e8ac13b9..816c530481 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3937,6 +3937,20 @@ static RISCVException read_tinfo(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException read_tcontrol(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    *val = env->tcontrol;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_tcontrol(CPURISCVState *env, int csrno,
> +                                     target_ulong val)
> +{
> +    env->tcontrol = val & (TCONTROL_MPTE | TCONTROL_MTE);
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException read_mcontext(CPURISCVState *env, int csrno,
>                                       target_ulong *val)
>   {
> @@ -4861,6 +4875,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_TDATA2]    =  { "tdata2",   debug, read_tdata,    write_tdata    },
>       [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
>       [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
> +    [CSR_TCONTROL]  =  { "tcontrol", debug, read_tcontrol, write_tcontrol },
>       [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
>   
>       /* User Pointer Masking */

