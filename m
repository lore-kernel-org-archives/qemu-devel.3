Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0F1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuLj-0006HO-5X; Mon, 22 Apr 2024 10:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryuLg-0006H3-4K
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:08:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryuLZ-0004kQ-GN
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:08:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e3c9300c65so37775045ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713794916; x=1714399716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cFMVmV1V+IsJmWjvHA1Pf92EBcGaU+9cGPfXHv2Dts=;
 b=IOMPIOXs4Dp3AhQV//Ta6KDZoq4+5oawOlHl2ZMt338SWSZtL7CP89MLbRydZQvV4f
 YXOD3gA/tz1ZGk3HCMdvduzpdNyTGmsfDNoXiYgJlRjOx3odznPB3IfCivA750F0uTyX
 AFCHY9jGe1bqEKm0W2P5yz6Nh5bvqjw045XU1ogSumzZMZ6WXvhqHP0d3uikGCwrALvH
 tYdEAXNNkoZW+DP6QVjiO1/vOGySiXA/JJo8cAKlGpcW+hL9amZU+fsq4yqEnPIn29GM
 qg27eR+TBvBFvPmeUGfp4FWH3/O3J7ivwgihwQCzf0pyuQBlWtIYG0GtbS7o/HGpnk7f
 XTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713794916; x=1714399716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cFMVmV1V+IsJmWjvHA1Pf92EBcGaU+9cGPfXHv2Dts=;
 b=OlZH5oECZ0kyYy8i8b3eZ05YNGTGhg6Qq8X4VRMV/et3S7cEW5yikPjqvFwqo8hbSh
 3OyFZ1qIu9YGpDmNzvel0fQfNvqMx4OtZatF1oC1vHvuWqtLXTc2azCxxH5J8WtDLaps
 Eyd4vtGBIkqjDUdqmOvQ2nh1EuPCELazYrcRB1i6oaRUNXN8KEuNcYsB2EmdZHWybygt
 JooBLGmjXMwr7R66l8xjeTfnKt9bspX9h4OoUHUcuEo4nzuN8E2ZMg4arht0AR9Mrovr
 Y2XKa/i8lyUPWMK7RF59EurNz527oim8IvnTunayzFdXYekBZ47rUqNLQ8d918o+pJ3I
 oFGg==
X-Gm-Message-State: AOJu0YwBwPodPasYlzZtFv2i+3mcB9X/6wZWMeH0Eu/1iD2Bl4OuF8jF
 MMTmt++omskscDjxRYC6RPi0az7nsmjR+dQcjXBTlwOc67/4yZh9Hy1sf4dUsDc=
X-Google-Smtp-Source: AGHT+IFGj2R7ewFPLB3losamGt3SrThYqax5I20UY+H8ndeqsZ5M3BRHUQo64ytnAEQ2GyBgo5+7RQ==
X-Received: by 2002:a17:902:aa4a:b0:1e3:1526:77d5 with SMTP id
 c10-20020a170902aa4a00b001e3152677d5mr9631747plr.23.1713794915976; 
 Mon, 22 Apr 2024 07:08:35 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.121])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170902a50a00b001e0da190a07sm8180072plq.167.2024.04.22.07.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 07:08:35 -0700 (PDT)
Message-ID: <09749ed3-840c-4a47-8cd2-9a50c9951cdb@ventanamicro.com>
Date: Mon, 22 Apr 2024 11:08:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: tolerate KVM disable ext errors
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20240422131253.313869-1-dbarboza@ventanamicro.com>
 <20240422-8145ee4f1a24e27ac9dcb1b3@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240422-8145ee4f1a24e27ac9dcb1b3@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 4/22/24 10:43, Andrew Jones wrote:
> On Mon, Apr 22, 2024 at 10:12:53AM -0300, Daniel Henrique Barboza wrote:
>> Running a KVM guest using a 6.9-rc3 kernel, in a 6.8 host that has zkr
>> enabled, will fail with a kernel oops SIGILL right at the start. The
>> reason is that we can't expose zkr without implementing the SEED CSR.
>> Disabling zkr in the guest would be a workaround, but if the KVM doesn't
>> allow it we'll error out and never boot.
>>
>> In hindsight this is too strict. If we keep proceeding, despite not
>> disabling the extension in the KVM vcpu, we'll not add extension in
>                                                          ^ the
>> riscv,isa. The guest kernel will be unaware of the extension, i.e. it
>   ^ the
> 
>> doesn't matter if the KVM vcpu has it enabled underneath or not. So it's
>> ok to keep booting in this case.
>>
>> Change our current logic to not error out if we fail to disable an
>> extension in kvm_set_one_reg(): throw an warning instead and keep
>> booting.  We'll keep the existing behavior when we fail to enable an
>> extension in KVM, since adding the extension in riscv,isa at this point
>> will cause a guest malfunction because the extension isn't enabled in
>> the vcpu.
> 
> I'd probably add a sentence or two explaining why we still want to warn,
> which is because KVM is stating that while you may think you're disabling
> an extension, that extension's behavior (instructions, etc.) will still
> be exposed to the guest since there's no way not to expose it.  The user
> should be aware that a guest could use it anyway, since that means the
> attempt to disable it can't be relied upon for migration compatibility of
> arbitrary guests. The guest needs to be well behaved, i.e. one that won't
> try to use any extensions which aren't in the ISA string. So, disabling
> these types of extensions either shouldn't generally be done (so a noisy
> warning helps prohibit that) or done for debug purposes (where a noisy
> warning is fine).

I'll add this in the next version.

> 
>>
>> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 6a6c6cae80..261ca24504 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -427,10 +427,14 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
>>           reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
>>           ret = kvm_set_one_reg(cs, id, &reg);
>>           if (ret != 0) {
>> -            error_report("Unable to %s extension %s in KVM, error %d",
>> -                         reg ? "enable" : "disable",
>> -                         multi_ext_cfg->name, ret);
>> -            exit(EXIT_FAILURE);
>> +            if (reg) {
>> +                error_report("Unable to enable extension %s in KVM, error %d",
>> +                             multi_ext_cfg->name, ret);
>> +                exit(EXIT_FAILURE);
>> +            } else {
> 
> Maybe we should check for a specific error. Is it EINVAL? If we do, then
> the message below would drop the (error %d) part and instead state
> explicitly that it cannot disable this extension since it's not possible.

It's throwing a 22 (EINVAL).

> 
>> +                warn_report("KVM did not disable extension %s (error %d)",
> 
> s/did not/cannot/
> 
>> +                            multi_ext_cfg->name, ret);
>> +            }


I don't mind rephrasing it to "The KVM module is not able to disable extension %s"
But I'm unsure what we gain from not showing the error code.

Aside EINVAL the other (very unlikely) error code being thrown would be EBUSY. Should
we handle EBUSY differently in this case? I don't think so. If we're already throwing a
warning, with error code, the user is well informed about the guest having a flaky
start and can proceed with discretion. Regardless of the extension disablement failing
due to EINVAL or EBUSY.


Thanks,

Daniel

>>           }
>>       }
>>   }
>> -- 
>> 2.44.0
>>
> 
> Thanks,
> drew

