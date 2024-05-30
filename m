Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D80C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCesJ-0004GO-B4; Thu, 30 May 2024 08:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sCesH-0004Fk-8p
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:27:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sCes4-0006aj-Jv
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:27:16 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f8ea5e3812so704468b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717072023; x=1717676823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hpDGL5gvqoW/LFD/zK1cdHUy5ul3+ISS9DXC2BSmS/s=;
 b=RvaIw4qD8WnR/G9fyTx/ioxTxh4rW1r9+RxavufRG0Hs9tg/h7tYN7mOnKeRkS/aRT
 Eqovv/yoSX0uvl6XtjEbf291eEICtDYdfxCtKhmNV3Gsyrz6vv4CbzMqRCS/pfwG3A+/
 r0m3V6Yrqt2f1EYEdf69wGLlvTZnqZz7Zhr+BaqXOkL6miY8cjeFaKwLTDsIwA9U+Yl/
 Ftxu3E3JAOUlAiK3zp7ddQrI6e2vKtA6TXEQ+Gph/GwftsRsDxrQ8fwqh1jl+rkWX5+p
 w/O5ancbZnVkBUHgcCRNga/lQ/HYlmPaztz13SNygTWH0KBK1z4B0TMQA4qd9+WkMxc3
 G9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717072023; x=1717676823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hpDGL5gvqoW/LFD/zK1cdHUy5ul3+ISS9DXC2BSmS/s=;
 b=eaW4PhcGU/aEwmYsHKDbQWDlakLJL5E6iYXMv3ug4Ov9G5jZCrHXhOe7YRMmp0VVhy
 nPAVG9OiAi9uA1Vaz7T2pFF4XuaCZmJ/qo71t+I96P32ofseVBfGRhbyBpj+CWgeDaAK
 yiSMEQxl7PVlgIDmcoXLhXWCDqGqJzUWXIowzLbYeGyKVzctMKy4IW4Pq4vlWhIFTwJt
 Gm/K5CF9IpBFEF7v4m1Sk7WWWd99fobfNgfdIUrHHWeQXt0L0b2yFQalhY/+ID4S5Wfg
 /LpecPdR2joepEXc28XlkXwUqzztMLrzRXoFW6OTck5TBnMr7ZOEBt94cq+ttfdDsZoN
 SFMg==
X-Gm-Message-State: AOJu0YydhhhWldIM4KzecwSkGdXUbBLnWg9j+6n+kJyr6tn7q/an2LeZ
 02iYyla1iZ5MPB5DGcvXtaQzu3287uo0tBjS+KVi0Wv8c/a16fW9Bf9zGpMaIkc=
X-Google-Smtp-Source: AGHT+IF8yJ1r9bfnEIOUgYG5gZw5ZSADEbcYR5LLn81pqv7CcR/6s5Q1sw2SCOVM/BbvyLh9N2q1KQ==
X-Received: by 2002:a05:6a20:7f83:b0:1b1:ce04:e80a with SMTP id
 adf61e73a8af0-1b26451e299mr2274422637.13.1717072022867; 
 Thu, 30 May 2024 05:27:02 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c96790fsm117618525ad.153.2024.05.30.05.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 05:27:02 -0700 (PDT)
Message-ID: <73abe573-040c-4aa3-af1c-c7755db0ba7a@ventanamicro.com>
Date: Thu, 30 May 2024 09:26:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt.c: add address-cells in
 create_fdt_one_aplic()
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, conor@kernel.org
References: <20240530084949.761034-1-dbarboza@ventanamicro.com>
 <20240530-45111cf8b1ee719f055d234f@orel>
 <20240530-2a3bc2792856d6c4bcf18269@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240530-2a3bc2792856d6c4bcf18269@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 5/30/24 08:06, Andrew Jones wrote:
> On Thu, May 30, 2024 at 01:05:41PM GMT, Andrew Jones wrote:
>> On Thu, May 30, 2024 at 05:49:49AM GMT, Daniel Henrique Barboza wrote:
>>> We need #address-cells properties in all interrupt controllers that are
>>> referred by an interrupt-map [1]. For the RISC-V machine, both PLIC and
>>> APLIC controllers must have this property.
>>>
>>> PLIC already sets it in create_fdt_socket_plic(). Set the property for
>>> APLIC in create_fdt_one_aplic().
>>>
>>> [1] https://lore.kernel.org/linux-arm-kernel/CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com/
>>
>> There are other issues[2] with the DT nodes that we should address at the
>> same time.
>>
>> [2] https://lore.kernel.org/all/20240529-rust-tile-a05517a6260f@spud/
> 
> I meant to CC Conor. Doing that now.

I'll take a look at these other DT nodes issues.

Conor, mind give me pointers on how do I reproduce the validation you did
in [2]? Using upstream 'dtc' I have stuff like:

../qemu/qemu_dts.dts:261.4-68: Warning (interrupts_extended_property): /soc/aplic@d000000:interrupts-extended: cell 0 is not a phandle reference

Which seems to also be an error but it's not what you reported. Are you
using 'dt-validate' from dt-schema?


Thanks,

Daniel

> 
>>
>> Thanks,
>> drew
>>
>>>
>>> Suggested-by: Anup Patel <apatel@ventanamicro.com>
>>> Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> ---
>>>   hw/riscv/virt.c         | 2 ++
>>>   include/hw/riscv/virt.h | 1 +
>>>   2 files changed, 3 insertions(+)
>>>
>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index 4fdb660525..1a7e1e73c5 100644
>>> --- a/hw/riscv/virt.c
>>> +++ b/hw/riscv/virt.c
>>> @@ -609,6 +609,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
>>>       aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
>>>       qemu_fdt_add_subnode(ms->fdt, aplic_name);
>>>       qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
>>> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
>>> +                          FDT_APLIC_ADDR_CELLS);
>>>       qemu_fdt_setprop_cell(ms->fdt, aplic_name,
>>>                             "#interrupt-cells", FDT_APLIC_INT_CELLS);
>>>       qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
>>> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
>>> index 3db839160f..c0dc41ff9a 100644
>>> --- a/include/hw/riscv/virt.h
>>> +++ b/include/hw/riscv/virt.h
>>> @@ -118,6 +118,7 @@ enum {
>>>   #define FDT_PLIC_ADDR_CELLS   0
>>>   #define FDT_PLIC_INT_CELLS    1
>>>   #define FDT_APLIC_INT_CELLS   2
>>> +#define FDT_APLIC_ADDR_CELLS  0
>>>   #define FDT_IMSIC_INT_CELLS   0
>>>   #define FDT_MAX_INT_CELLS     2
>>>   #define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
>>> -- 
>>> 2.45.1
>>>
>>>

