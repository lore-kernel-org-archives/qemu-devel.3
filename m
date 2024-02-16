Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB66BC48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 12:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxgV-0001Qq-JJ; Fri, 16 Feb 2024 07:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raxgQ-0001QF-VK
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 07:51:16 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raxgP-0005v6-4I
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 07:51:14 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so16096265ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 04:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708087871; x=1708692671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uvMDsR+HQYL/mnTd2qTEbsZ+UmxidYMbybuxyE8uhyE=;
 b=kHxgGAfdL/wZq71FccT2niAEiIfccd7vBWLrLq+cWuHB9QtzerCDFIK+zNFghRj66T
 hg7prP+8qyxcCIQFDrpw1UkmU3iwvJLyH+vyfOxekVnuteoQx++5L4+ARsvJjiQuMQ1Z
 KdCjdZnBtx/bvVTPLo80CkYn3To3P0/Ks4ApMI2YUQLVMuB98OTIrufzGTGH65qD31uY
 euriTNbv9U6AB4y8WcEC2FS6llomfvcQu0zKARKvy0n31EdfkRmaQzr5DMVzZny0vNk/
 gjcWKPz3SRdpZbM8Irw4Z9GVBkCAKRKZ1ynheEz5ypIzsM01iwjrzLp7SjE7bViQ7JLt
 +KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708087871; x=1708692671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uvMDsR+HQYL/mnTd2qTEbsZ+UmxidYMbybuxyE8uhyE=;
 b=kPR1N7RTwm+F2LYFqp8wsJuFUGSvUHXe4mzhLYJGeZozjodYpdhGpPuCE8rqIrekbx
 rANDQhzOze8TMrYCgeepTRQnnszltu2nQhoW6ZJK6waouSo8X0eYJPBwKTWqmEGN1mXP
 Fo5qXGCVhrKcYgSUP7zJnqVVFv5cvc8b09NFTdQ2w7OEFJzPgIt1SOnRt539WRnqUZ59
 nSWtlh6ecq5h3CKXPQZ/nspPyNcQ/V+A3952VHriu7MMSPW3+oRW8ecN2b6IurFkxjju
 w5VetvkDsu82lQwe0yUUHcyfSboSVvPB56DCHbkCwsMr2qM7Ig7h3epWN+vpjSmr4LmS
 VFmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuKphwq73JuQyGJfwSSrs8TkHJBlh5FkPnNvyC3NL8VnMnPJtq5T3WP7b5yRRYGwauuwMz2IWp6MRiVAAsvAHc4mQRmRI=
X-Gm-Message-State: AOJu0YwYs9FNlR8fww6b8XDrNYnnlRSLc5NDE2v+X+RXBuip9IXyDcmB
 kVEjhOjeftbRQXlmCUbnPFyv+EprouX9TjfOKuazSWjXrDYxWZP3L+5j35hgynY=
X-Google-Smtp-Source: AGHT+IF4tTB0G+GeD+geCcObqCj65gjtw0JQrpqYjNDO5v0PRhvei813CARp5YZt/qsRdRvjHjaj7A==
X-Received: by 2002:a17:902:b7c6:b0:1d9:5b8b:f70 with SMTP id
 v6-20020a170902b7c600b001d95b8b0f70mr4351448plz.29.1708087871054; 
 Fri, 16 Feb 2024 04:51:11 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a1709029a9300b001db5ea825b2sm2908344plp.123.2024.02.16.04.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 04:51:10 -0800 (PST)
Message-ID: <164280dd-0899-42c5-b6a0-eb561f257591@ventanamicro.com>
Date: Fri, 16 Feb 2024 09:51:07 -0300
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

The spec reads:

"This optional register is only accessible in M-mode and Debug Mode and provides
  various control bits related to triggers."

"debug()" is checking only if we have the 'debug' cpu option enabled:


static RISCVException debug(CPURISCVState *env, int csrno)
{
     if (riscv_cpu_cfg(env)->debug) {
         return RISCV_EXCP_NONE;
     }

     return RISCV_EXCP_ILLEGAL_INST;
}


It looks like we don't have a "Debug Mode" model.

Section 4.1 of the spec mentions the following about "Debug Mode":

"1. All implemented instructions operate just as they do in M-mode, unless an
  exception is mentioned in this list.
  2. All operations are executed with machine mode privilege, except that additional
  Debug Mode CSRs are accessible and MPRV in mstatus may be ignored according to
  mprven. Full permission checks, or a relaxed set of permission checks, will apply
  according to relaxedpriv (...)"


So, if the operations are "executed with machine mode privilege" then can we expect
env->priv == PRV_M ? As it is now tcontrol will execute in any mode, so checking
for PRV_M seems reasonable.


Thanks,


Daniel





>       [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
>   
>       /* User Pointer Masking */

