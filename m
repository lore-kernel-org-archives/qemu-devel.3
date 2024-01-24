Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2E0C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 20:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSjSc-0001Yb-9o; Wed, 24 Jan 2024 15:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSjSZ-0001Xe-Oo
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:02:56 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSjSX-0005Yw-PU
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:02:55 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d7881b1843so6610905ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 12:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706126572; x=1706731372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+w2Z/B9DvCeSq6bcxM6bUW3f+gLJiWZyp7gFEq+AuD4=;
 b=m4ixX/bnXZWKeFDCL3DiExe9LYfzcOp0fwMSG3DyfyLkLVCsizrtvu+bPMUlqI+pg7
 /SdNhXFXHK84Eyzjteum80CM2BzfqQddIvOp5AQL1v8ovvS87DdyIoHg8DSkVJfrWxxB
 L5RkZNVJa+rmE3B9EzjDh2e0WSy8CERyZvpiZHUyqTmnVyn4KLTiBOnK8dEMIk+g7318
 rCe02nUz3Ke6T5OifLe3GmKQdAthm+K1Ygx1Eydo/QRqRbTQ07sFoqi5AlUH6+hh/KSo
 l7pODVfWnV3C5U4GCy8wmvc8CUI7Lt6vzFSJuNRa4K1slOSR4zli3I7G6dBm2MQ/wbAG
 7Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706126572; x=1706731372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+w2Z/B9DvCeSq6bcxM6bUW3f+gLJiWZyp7gFEq+AuD4=;
 b=siHk/lfrda/mti4RzTKXfESoHamzyvWf/3pg4sD8Ui2RcywCdMbp7jS4f/x1d2UYy0
 xfNsZqcHR6mSb//DFMTm/MWwx5fc5teseBUWaBFhbJKh7EHikz0lFv/4EurrKhh56Fly
 JcBdo7B+0daEVR1BoqYk0OsHHfKyMIqTx7MFFxZXfBU62Y/1ZVQWSokZOk+HWyzc5SM5
 z7JoSPbwRYOHIhAP0KcogQ8I1TqbWolPBcSMmIwgaKhZjQTdC0dKnpug0/vevU25ovjh
 IO10PQEnDE0vCKhixVEy/FE4zqyU+XXHtwR4hkQ4+fjeJVTxSHP9Bi2rrRB4tQ9irxRf
 5TBg==
X-Gm-Message-State: AOJu0Yxis2zHPeXV3sYxsM0gI/9LNGszda+aSP1Q3jIKN7iZ3dlPWQtu
 e7ivvEEZOx8cwTQMpA6kF3peE1V/tZ2Rcp8jGO683hAlaaJnHA+ReVWsNUDxobA=
X-Google-Smtp-Source: AGHT+IHmdnAzRy94TdW37rxIReLv8xmTxnle59ObMQ60OBh/Hx1dq+31Zqz4kUmazN7Jz6XbTetWjA==
X-Received: by 2002:a17:902:6b4a:b0:1d5:f10d:2ac6 with SMTP id
 g10-20020a1709026b4a00b001d5f10d2ac6mr1232352plt.115.1706126571674; 
 Wed, 24 Jan 2024 12:02:51 -0800 (PST)
Received: from [192.168.68.110] ([152.234.127.94])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a170902c18d00b001d7134d149dsm9769222pld.256.2024.01.24.12.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 12:02:51 -0800 (PST)
Message-ID: <08188a93-0d5b-40bf-aefb-ac74d9c3d0be@ventanamicro.com>
Date: Wed, 24 Jan 2024 17:02:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu riscv, thead c906, Linux boot regression
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley
 <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
 <78107c83-7035-414c-9a44-af5e234fd5c2@ventanamicro.com>
 <87wmryr0rx.fsf@all.your.base.are.belong.to.us>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <87wmryr0rx.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 1/24/24 16:26, Björn Töpel wrote:
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
> 
>> On 1/24/24 09:49, Björn Töpel wrote:
>>> Hi!
>>>
>>> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized that
>>> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
>>> ("target/riscv/cpu.c: restrict 'marchid' value")
>>>
>>> Reverting that commit, or the hack below solves the boot issue:
>>>
>>> --8<--
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 8cbfc7e781ad..e18596c8a55a 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>>>        cpu->cfg.ext_xtheadsync = true;
>>>    
>>>        cpu->cfg.mvendorid = THEAD_VENDOR_ID;
>>> +    cpu->cfg.marchid = ((QEMU_VERSION_MAJOR << 16) |
>>> +                        (QEMU_VERSION_MINOR << 8)  |
>>> +                        (QEMU_VERSION_MICRO));
>>>    #ifndef CONFIG_USER_ONLY
>>>        set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>>>    #endif
>>> --8<--
>>>
>>> I'm unsure what the correct qemu way of adding a default value is,
>>> or if c906 should have a proper marchid.
>>
>> In case you need to set a 'marchid' different than zero for c906, this hack would
>> be a proper fix. As mentioned in the commit msg of the patch you mentioned:
>>
>> "Named CPUs should set 'marchid' to a meaningful value instead, and generic
>>    CPUs can set to any valid value."
>>
>> That means that any specific marchid value that the CPU uses must to be set
>> in its own cpu_init() function.
> 
> Got it. Thanks, Daniel!
> 
> For completeness (since it came up on the weekly PW call); Conor pointed
> out that zero *is* indeed the right marchid for c906, and in fact, the
> non-zero marchid pre commit d6a427e2c0b2 was incorrect.
> 
> Post commit d6a427e2c0b2, the correct alternative is picked up, and
> ERRATA_THEAD_PBMT (using non-standard memory type bits in
> page-table-entries) kicks in. AFAIU, that's not implemented by qemu's
> c906 support, which then traps.


This looks like a very good reason to actually push what you called 'hack' as
a fix. Yeah, in theory that commit did nothing wrong, but the side effect
(missing support for non-standard memory type bits) is kind of a QEMU problem.

You're welcome to format that hack into a patch, explaining in the commit msg why
we need to set marchid for c906 to that specific value. I'd even add a TODO
tag in rv64_thead_c906_cpu_init() to remind us that this is a band-aid and
that we should remove it once we implement the needed support.



> 
> That's the theory. Maybe Christoph knows if the non-standard bits are
> implemented or not?
> 
> Regardless; I removed booting Qemu T-head c906 from the CI, and the
> build/boot passes nicely ;-) [1]

I vote for setting marchid in c906 cpu_init and re-enable it in the CI.


Thanks,

Daniel

> 
> 
> Björn
> 
> [1] https://github.com/linux-riscv/linux-riscv/actions/runs/7641764759/job/20819801235?pr=447

