Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BEC3ABA8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 19:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spvNy-0003VT-Qo; Sun, 15 Sep 2024 15:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1spvNx-0003Uh-2S
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:58:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1spvNt-0005Ac-Hn
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:58:16 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-719232ade93so2134209b3a.2
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726430291; x=1727035091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KIepHZ0yszDcGbwSThjpa2tQkMJutvpwWqY0UHs+PXw=;
 b=DIVgHCfk8OZdXhHyMRQUKlbuDA7fYPrpUFPZUQN4gUNaw3CpeQ3zx5fdu3T/aRezl/
 8ATB3CzSeOJsktszFEYpNPQrt47Zd+sfGFFEAB+xchhC/+CHjkOo+l95ZnAjuDvSqdi/
 1o90mxYrcbtN1l4s2MoHdDMs4CfknqeUU4x6knBq2zgMvBl+hzv/r18kGZjcjg4bTX0q
 99RIZp7/irLsbZYlsRKyy9zm4plm+KVRRanCXMTJA+rrse3VAFqOD/p14PRlO69CtJ5D
 osWIcM8oMekJvkqSF9V2d0gqyK5sj3/bw9ej5LUHza25nulLMMCxKVx4EjT0iXOpn4BU
 wmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726430291; x=1727035091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KIepHZ0yszDcGbwSThjpa2tQkMJutvpwWqY0UHs+PXw=;
 b=d9YSVxYPdHFvGn3VtYxvAZWnAWDYBOb42pOVL6Kn8THtcEBlCrFiz5tjDJ+aClBW4G
 BNi1b94GSHx5ygxKQ9FvPSiI+CCfLsNNQVnqClGTXJj5hHq4GgKx5gjhE41aqFLALQ3A
 bYVM1atoRGxIYoaqhp/l7GKDMqieUq3n+yeDKltxl6VrwEnTGX0DwCg6GlaBekt6lrPG
 r4X96aCBQg4u7lKykAV1LKtDHCQ3M1pbLUDpyDL+5Mz+fuZPW4RoutYi/bxyjLOLoGIn
 /1Ek1RyUpMGBqrJPpu/wr33Hqjqk4eQd0CnVVy61+AXe5mLo1lCvR3Siw68yoN7aAz7/
 2Mrw==
X-Gm-Message-State: AOJu0Yw17oZATHM58rUPTS9g42b3B1u1V3Id02GZ/L/wkbhR8Pdr37rA
 2OJsGXZinr492bG6vqmRsbbOlqDa62VV5w/zry1ksAP6OMr24oby/Jds+8ZHxvY=
X-Google-Smtp-Source: AGHT+IH1C8oxwN9CSPKfDybVcKYkAODL7yFTSLQeFLTXHu8ObhVonvY8K7rx1hZCIPXQGUEXc1t6Vw==
X-Received: by 2002:a05:6a00:27a0:b0:718:d519:20de with SMTP id
 d2e1a72fcca58-71936a5de5fmr14190820b3a.13.1726430291482; 
 Sun, 15 Sep 2024 12:58:11 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-33.dsl.telesp.net.br.
 [201.68.240.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944b9756bsm2539143b3a.160.2024.09.15.12.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Sep 2024 12:58:11 -0700 (PDT)
Message-ID: <4aa984d0-db18-4a41-808c-e4d164c03d13@ventanamicro.com>
Date: Sun, 15 Sep 2024 16:58:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/47] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
 <CAFEAcA_W5bTcCmeAx+dB4+djcUHzjRH4GfBobaHot5VjE+x05g@mail.gmail.com>
 <CAKmqyKOFnajGSsKS2k=kYsB--uRjoCZZTv3QSxbEm40HK_k1jA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKOFnajGSsKS2k=kYsB--uRjoCZZTv3QSxbEm40HK_k1jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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

Hi Peter, Alistair,

On 9/14/24 6:15 AM, Alistair Francis wrote:
> On Fri, Sep 13, 2024 at 8:37 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 12 Sept 2024 at 06:30, Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8332f:
>>>
>>>    Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/stsquad/qemu into staging (2024-09-11 13:17:29 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240912-1
>>>
>>> for you to fetch changes up to 90d5d3c1115399d8e27621efd69dfa74a35a4932:
>>>
>>>    hw/intc: riscv-imsic: Fix interrupt state updates. (2024-09-12 15:05:10 +1000)
>>>
>>> ----------------------------------------------------------------
>>> RISC-V PR for 9.2
>>>
>>> * Add a property to set vl to ceil(AVL/2)
>>> * Enable numamem testing for RISC-V
>>> * Consider MISA bit choice in implied rule
>>> * Fix the za64rs priv spec requirements
>>> * Enable Bit Manip for OpenTitan Ibex CPU
>>> * Fix the group bit setting of AIA with KVM
>>> * Stop timer with infinite timecmp
>>> * Add 'fcsr' register to QEMU log as a part of F extension
>>> * Fix riscv64 build on musl libc
>>> * Add preliminary textra trigger CSR functions
>>> * RISC-V IOMMU support
>>> * RISC-V bsd-user support
>>> * Respect firmware ELF entry point
>>> * Add Svvptc extension support
>>> * Fix masking of rv32 physical address
>>> * Fix linking problem with semihosting disabled
>>> * Fix IMSIC interrupt state updates
>>
>> Hi; this fails to build on FreeBSD:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/7817823771

Is this one of those jobs that are only available when running the main pipeline? I don't
have this x86-freebsd runner when triggering the gitlab pipeline. I ended up installing a
FreeBSD VM and using it to reproduce the problem.

Would be nice to have access to a FreeBSD runner as a regular user, even if just for x86_64,
to help detect these build problems before sending a PR.


> 
> Ajeet do you mind looking at this failure and sending a new series with a fix


I sent some build fixes in patches 27 and 32 that worked for me. Since they are trivial I think
you could just squash them in the PR and send a v2.



Thanks,

Daniel

> 
> Alistair
> 
>>
>> In file included from ../bsd-user/elfload.c:31:
>> In file included from ../bsd-user/freebsd/target_os_stack.h:24:
>> ../bsd-user/riscv/target_arch_sigtramp.h:32:33: error: initializer
>> element is not a compile-time constant
>> 32 | /*2*/ const_le32(0x00050513 + (sigf_uc << 20)), /*addi a0,a0,sigf_uc*/
>>     |                  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~
>> /tmp/cirrus-ci-build/include/qemu/bswap.h:168:26: note: expanded from
>> macro 'const_le32'
>> 168 | # define const_le32(_x) (_x)
>>      |                          ^~
>>
>>
>> and
>>
>> In file included from ../bsd-user/main.c:53:
>> ../bsd-user/riscv/target_arch_cpu.h:126:13: error: call to undeclared
>> function 'force_sig_fault'; ISO C99 and later do not support implicit
>> function declarations [-Werror,-Wimplicit-function-declaration]
>> 126 | force_sig_fault(signo, code, env->pc);
>>      | ^
>> ../bsd-user/riscv/target_arch_cpu.h:129:9: error: call to undeclared
>> function 'process_pending_signals'; ISO C99 and later do not support
>> implicit function declarations
>> [-Werror,-Wimplicit-function-declaration]
>> 129 | process_pending_signals(env);
>>      | ^
>> ../bsd-user/main.c:608:5: error: call to undeclared function
>> 'signal_init'; ISO C99 and later do not support implicit function
>> declarations [-Werror,-Wimplicit-function-declaration]
>> 608 | signal_init();
>>      | ^
>> 3 errors generated.
>>
>> thanks
>> -- PMM
> 

