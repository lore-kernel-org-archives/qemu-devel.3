Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8475C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razlt-0000To-Pc; Fri, 16 Feb 2024 10:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1razlq-0000ND-KM
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:04:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1razlo-0000qN-AT
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:04:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7858a469aso18667365ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708095894; x=1708700694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JCEvUgCY4Zqgz741XhFMHq8t08vcZHwgoGYlCzbRxjU=;
 b=DhtRIsx+hDA60Jz63xkDRh7Txu0QLbGbaIqJ7d4aQaq+doeuMv0fFsYHbD/78Qb2b4
 mgY8pYzw9IAIm0BBeRIr3wyWKLxpfXCVCOHc37wqnqnNOQa7NC6OZkrZPfeaDRIlNpa+
 zXM4wo90QqNUA9TkhA9iKBM5FKml6yJnuaR3ubCZctanuU/NE7Hn4ucfqnVW54z2dFyM
 CjMmc0qwhKtxhNhXjqCwLCanYAF4ylut3UFhKe8VvjIuSTJcN+IFN8ZODyqlkv86NPxC
 u7b45mv9FYK+1tUp0wfCmjX5FkFjOJ2tgY5jVBSCsxz3j0RqzViQI5Wj4ayGLHso2Aam
 e7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708095894; x=1708700694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JCEvUgCY4Zqgz741XhFMHq8t08vcZHwgoGYlCzbRxjU=;
 b=N/0G3/K8OzBM7ZrYBtkbBlwiWQ2XftJfUN3eaGbkJU0vMcI0oB25e7jfnFmyt5/4lA
 lOrNsVCBX0avtqA13oU9NjR4XQfP1dQ+LtYwMWEiNA6Of16FCD1RkOkHukIUxBbAkX/1
 ojp/ppMwFZm7j1Lc38JJoFJGdgy++LMpulwcTzlbcLQAxCFYZo9m7IRNj21Tx5eZlITH
 6WiTC3SKaRh2RHVN5nAuoYQWWFxEG/rI9siE9oWy3H1P5xwI0hz87nyuIQDZD+LjeQPY
 BBlWUeAfW9kX2yXIokjLP/HiNXEaEbIbaJK/NvBNwHyUFx8bX0cBDIydYDYHCBmYM71v
 6Wmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSIcLUCRNFwCrXEsF2oMbSFinYwVlserOhoGFbgwG3nKXLyfP5kLGmDkOkv8ka1HHmzk9HZ6EMPsqL8xs54t4xlsn7R48=
X-Gm-Message-State: AOJu0YxPpRrW5fJeUbJp9j3s3pcfT6herC/Conhufoo+Gn1wpt+3CaOD
 iUGEb0yw1QwcN/ft4LD9bvQNt32SiR5np6nQ2cnBrFq7DWH01Kyz0EeySOdHYHE=
X-Google-Smtp-Source: AGHT+IHQuF6e52CxBEwHTTmsnan6DmFyPXx6WUkUI+CAUk27qH1mmPv2bFZ2Vdh9dWjGmsemvHP27g==
X-Received: by 2002:a17:902:7294:b0:1d9:909f:40b6 with SMTP id
 d20-20020a170902729400b001d9909f40b6mr4341670pll.58.1708095894540; 
 Fri, 16 Feb 2024 07:04:54 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a170902a3c700b001db90df1283sm2889442plb.4.2024.02.16.07.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 07:04:54 -0800 (PST)
Message-ID: <300acde2-35d2-471d-8726-4fad7dc04fa5@ventanamicro.com>
Date: Fri, 16 Feb 2024 12:04:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/riscv: Add CSR tcontrol of debug trigger module
Content-Language: en-US
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20240216061332.50229-1-alvinga@andestech.com>
 <20240216061332.50229-2-alvinga@andestech.com>
 <164280dd-0899-42c5-b6a0-eb561f257591@ventanamicro.com>
 <SEYPR03MB6700D4EC6DE89B2265EE5F82A84C2@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <SEYPR03MB6700D4EC6DE89B2265EE5F82A84C2@SEYPR03MB6700.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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



On 2/16/24 10:42, Alvin Che-Chia Chang(張哲嘉) wrote:
> Hi Daniel,
> 
>> -----Original Message-----
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Sent: Friday, February 16, 2024 8:51 PM
>> To: Alvin Che-Chia Chang(張哲嘉) <alvinga@andestech.com>;
>> qemu-riscv@nongnu.org; qemu-devel@nongnu.org
>> Cc: alistair.francis@wdc.com; bin.meng@windriver.com;
>> liwei1518@gmail.com; zhiwei_liu@linux.alibaba.com
>> Subject: Re: [PATCH 1/4] target/riscv: Add CSR tcontrol of debug trigger module
>>
>>
>>
>> On 2/16/24 03:13, Alvin Chang wrote:
>>> The RISC-V debug specification defines an optional CSR "tcontrol"
>>> within the trigger module. This commit adds its read/write operations
>>> and related bit-field definitions.
>>>
>>> Signed-off-by: Alvin Chang <alvinga@andestech.com>
>>> ---
>>>    target/riscv/cpu.h      |  1 +
>>>    target/riscv/cpu_bits.h |  3 +++
>>>    target/riscv/csr.c      | 15 +++++++++++++++
>>>    3 files changed, 19 insertions(+)
>>>
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h index
>>> f52dce78ba..f9ae3e3025 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -364,6 +364,7 @@ struct CPUArchState {
>>>        target_ulong tdata1[RV_MAX_TRIGGERS];
>>>        target_ulong tdata2[RV_MAX_TRIGGERS];
>>>        target_ulong tdata3[RV_MAX_TRIGGERS];
>>> +    target_ulong tcontrol;
>>>        target_ulong mcontext;
>>>        struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
>>>        struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS]; diff
>>> --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h index
>>> fc2068ee4d..3b3a7a0fa4 100644
>>> --- a/target/riscv/cpu_bits.h
>>> +++ b/target/riscv/cpu_bits.h
>>> @@ -353,6 +353,7 @@
>>>    #define CSR_TDATA2          0x7a2
>>>    #define CSR_TDATA3          0x7a3
>>>    #define CSR_TINFO           0x7a4
>>> +#define CSR_TCONTROL        0x7a5
>>>    #define CSR_MCONTEXT        0x7a8
>>>
>>>    /* Debug Mode Registers */
>>> @@ -900,6 +901,8 @@ typedef enum RISCVException {
>>>    #define JVT_BASE                           (~0x3F)
>>>
>>>    /* Debug Sdtrig CSR masks */
>>> +#define TCONTROL_MTE                       BIT(3)
>>> +#define TCONTROL_MPTE                      BIT(7)
>>>    #define MCONTEXT32                         0x0000003F
>>>    #define MCONTEXT64
>> 0x0000000000001FFFULL
>>>    #define MCONTEXT32_HCONTEXT                0x0000007F
>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c index
>>> d4e8ac13b9..816c530481 100644
>>> --- a/target/riscv/csr.c
>>> +++ b/target/riscv/csr.c
>>> @@ -3937,6 +3937,20 @@ static RISCVException read_tinfo(CPURISCVState
>> *env, int csrno,
>>>        return RISCV_EXCP_NONE;
>>>    }
>>>
>>> +static RISCVException read_tcontrol(CPURISCVState *env, int csrno,
>>> +                                    target_ulong *val) {
>>> +    *val = env->tcontrol;
>>> +    return RISCV_EXCP_NONE;
>>> +}
>>> +
>>> +static RISCVException write_tcontrol(CPURISCVState *env, int csrno,
>>> +                                     target_ulong val) {
>>> +    env->tcontrol = val & (TCONTROL_MPTE | TCONTROL_MTE);
>>> +    return RISCV_EXCP_NONE;
>>> +}
>>> +
>>>    static RISCVException read_mcontext(CPURISCVState *env, int csrno,
>>>                                        target_ulong *val)
>>>    {
>>> @@ -4861,6 +4875,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>>>        [CSR_TDATA2]    =  { "tdata2",   debug, read_tdata,
>> write_tdata    },
>>>        [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,
>> write_tdata    },
>>>        [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,
>> write_ignore   },
>>> +    [CSR_TCONTROL]  =  { "tcontrol", debug, read_tcontrol,
>>> + write_tcontrol },
>>
>> The spec reads:
>>
>> "This optional register is only accessible in M-mode and Debug Mode and
>> provides
>>    various control bits related to triggers."
>>
>> "debug()" is checking only if we have the 'debug' cpu option enabled:
>>
>>
>> static RISCVException debug(CPURISCVState *env, int csrno) {
>>       if (riscv_cpu_cfg(env)->debug) {
>>           return RISCV_EXCP_NONE;
>>       }
>>
>>       return RISCV_EXCP_ILLEGAL_INST;
>> }
>>
>>
>> It looks like we don't have a "Debug Mode" model.
> 
> Yes, currently RISC-V QEMU doesn't have "Debug Mode", so I just ignore it and only consider M-mode here.
> 
>>
>> Section 4.1 of the spec mentions the following about "Debug Mode":
>>
>> "1. All implemented instructions operate just as they do in M-mode, unless an
>>    exception is mentioned in this list.
>>    2. All operations are executed with machine mode privilege, except that
>> additional
>>    Debug Mode CSRs are accessible and MPRV in mstatus may be ignored
>> according to
>>    mprven. Full permission checks, or a relaxed set of permission checks, will
>> apply
>>    according to relaxedpriv (...)"
>>
>>
>> So, if the operations are "executed with machine mode privilege" then can we
>> expect
>> env->priv == PRV_M ? As it is now tcontrol will execute in any mode, so
>> env->checking
>> for PRV_M seems reasonable.
> 
> The riscv_csrrw_check() function has checked the privilege level by the accessed CSR address.
> Please see https://github.com/qemu/qemu/blob/master/target/riscv/csr.c#L4360.
> If the current privilege level is lower than the accessed CSR, the illegal instruction exception is raised.
> 
> According to privilege spec, each CSR address has two bits to encode the lowest privilege level to access that CSR.
> Sdtrig CSRs (tselect, tdata{1~3}, tinfo, mcontext, and tcontrol) are encoded within 0x7A0~0x7AF,
> Therefore, their lowest required privilege level is M-mode.
> If env->priv < PRV_M, the checking on those CSR fails in riscv_csrrw_check().
> 
> Is this enough, or do I miss something?
> 

This is enough, thanks for clarifying.

And since we're not modelling a "Debug Mode" I think this is already the best we can
do ATM.


Thanks,

Daniel

> 
> Sincerely,
> Alvin Chang
> 
>>
>>
>> Thanks,
>>
>>
>> Daniel
>>
>>
>>
>>
>>
>>>        [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext,
>>> write_mcontext },
>>>
>>>        /* User Pointer Masking */

