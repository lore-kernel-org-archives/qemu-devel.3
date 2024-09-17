Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2392CAC58E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbKb-0007aM-DA; Tue, 17 Sep 2024 12:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqbKV-0007BS-7D
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:45:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqbKS-0000wn-7Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:45:30 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 24F5D3F47C
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726591526;
 bh=NT1MFgf5d1eFKJ8lvG5GHflLOH9+PDppupkTwcUm1iE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=O4EGoCT5IAydM9oM/FG/qxogUzxAJhlAdNE/QvADs7yeqJ5GYHJcrB0u1Pf5p3REh
 V0G/HZzfQIUEjQstWkns3/nKxmOhn+kzZsXw9oenab+tH/TAbxUMadSOmG3KfpLsqS
 YncZRbuOyonl86Nm9NIFnZksXwP+P4WtJzQmG3fry+Tr3bvz4Q+N+UNNK3V+hUYI4v
 MVHRfgh5RyfLOxRqw+PPa5/ik8oe0YGL2oUhqxG6jEZgwvzNXZ9SzHi/N3A0KDQBwP
 eP0kCZubGh1gHvlrNST781ndCf9xUx4wEsUvzChUpPxkenx+6QoIIpO8LyEP1eWZmj
 Nvxw8fe12pKww==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-378929f1a4eso3170721f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726591524; x=1727196324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NT1MFgf5d1eFKJ8lvG5GHflLOH9+PDppupkTwcUm1iE=;
 b=naErzr1VXe2awNADZuqRALTEX0xLuaWReTWEnDrwxXOYQuGziUrsxZkmOV9A/RzcXm
 pZiwvdNy+y1JeOK8YboGQ+uuWFpkJS+yeXfYGNrKofOCJsHeK6FvA469pG/sP/cgnsuN
 FZ51hsUS1C1+1L5s1PP2lZeUKHLBlSSJh6GVPBtz6M35wS21EfYWAnm35Sf2kE8g8rtw
 dloZ1aBOwv5IEnprafGoXGP2qpME5RJFISDvFMNgzSLbWyIWciioTJjzUC989G3VPC5X
 EhXcHc0Ww26dJfj5X9AFxeCMYByGAF4eznCzVFbNQdkHmXaQ46VvQfc9OWD+pxgHYBXh
 eswQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2S+SOKUL2zXb5V9sdcKPhV+ld6bycHIMzd4oTtPTMFbx5vurCIRESXy1DII+yNSVZCPSqFYy25T2o@nongnu.org
X-Gm-Message-State: AOJu0YwaSOUDdXSgo9MgXRPEOsjGBmLJCfjrln47o5kkHdN/XBWyTvx5
 BXHn04xAG8WtgeCZ3BUq1534LIDPKhRWPHpPIztB2Pq8I1A55yNtcsuuyHZc7pq3lZyUHwQfC8O
 uWzOd3TH/CTZV57XsEr4kNxtWlUzVOcJY17CqpLbTlb7tPNCNn8s+/a/V6xH8bfZUlMuG
X-Received: by 2002:a5d:5e0b:0:b0:378:fd4a:b9c7 with SMTP id
 ffacd0b85a97d-378fd4abdd0mr1676592f8f.58.1726591524367; 
 Tue, 17 Sep 2024 09:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs0Cj+RwanvZfc+Zpgq+IL/nl24ARC+SCQIgbK1A19jHR2OTbPlljOxY0Nabw1aG0vB0qF6g==
X-Received: by 2002:a5d:5e0b:0:b0:378:fd4a:b9c7 with SMTP id
 ffacd0b85a97d-378fd4abdd0mr1676576f8f.58.1726591523830; 
 Tue, 17 Sep 2024 09:45:23 -0700 (PDT)
Received: from [192.168.103.101]
 (dynamic-046-114-111-082.46.114.pool.telefonica.de. [46.114.111.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e8340sm9976172f8f.46.2024.09.17.09.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 09:45:23 -0700 (PDT)
Message-ID: <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
Date: Tue, 17 Sep 2024 18:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240917-b13c51d41030029c70aab785@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 17.09.24 16:49, Andrew Jones wrote:
> On Tue, Sep 17, 2024 at 03:28:42PM GMT, Heinrich Schuchardt wrote:
>> On 17.09.24 14:13, Andrew Jones wrote:
>>> On Mon, Sep 16, 2024 at 08:16:33PM GMT, Heinrich Schuchardt wrote:
>>>> OpenSBI enables the floating point in mstatus. For consistency QEMU/KVM
>>>> should do the same.
>>>>
>>>> Without this patch EDK II with TLS enabled crashes when hitting the first
>>>> floating point instruction while running QEMU with --accel kvm and runs
>>>> fine with --accel tcg.
>>>>
>>>> Additionally to this patch EDK II should be changed to make no assumptions
>>>> about the state of the floating point unit.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    target/riscv/cpu.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index 4bda754b01..c32e2721d4 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -923,6 +923,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>>>        if (mcc->parent_phases.hold) {
>>>>            mcc->parent_phases.hold(obj, type);
>>>>        }
>>>> +    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
>>>> +        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);
>>>> +        for (int regnr = 0; regnr < 32; ++regnr) {
>>>> +            env->fpr[regnr] = 0;
>>>> +        }
>>>> +        riscv_csrrw(env, CSR_FCSR, NULL, 0, -1);
>>>> +    }
>>>
>>> If this is only fixing KVM, then I think it belongs in
>>> kvm_riscv_reset_vcpu(). But, I feel like we're working around an issue
>>> with KVM synchronization with this, as well as with the "clear CSR values"
>>> part of commit 8633951530cc ("target/riscv: Clear CSR values at reset and
>>> sync MPSTATE with host"). KVM knows how to reset VCPUs. It does so on
>>> VCPU creation and for any secondaries started with SBI HSM start. KVM's
>>> reset would set sstatus.FS to 1 ("Initial") and zero out all the fp
>>> registers and fcsr. So it seems like we're either synchronizing prior to
>>> KVM resetting the boot VCPU, not synchronizing at all, or KVM isn't doing
>>> the reset of the boot VCPU.
>>>
>>> Thanks,
>>> drew
>>
>> Hello Drew,
>>
>> Thanks for reviewing.
>>
>> Concerning the question whether kvm_riscv_reset_vcpu() would be a better
>> place for the change:
>>
>> Is there any specification prescribing what the state of the FS bits should
>> be when entering M-mode and when entering S-mode?
> 
> I didn't see anything in the spec, so I think 0 (or 1 when all fp
> registers are also reset) is reasonable for an implementation to
> choose.
> 
>>
>> Patch 8633951530cc seems not to touch the status register in QEMU's
>> kvm_riscv_reset_vcpu(). So it is not obvious that this patch could have
>> caused the problem.
> 
> I don't think 8633951530cc caused this problem. It was solving its own
> problem in the same way, which is to add some more reset for the VCPU.
> I think both it and this patch are working around a problem with KVM or
> with a problem synchronizing with KVM. If that's the case, and we fix
> KVM or the synchronization with KVM, then I would revert the reset parts
> of 8633951530cc too.
> 
>>
>> Looking at the call sequences in Linux gives some ideas where to debug:
>>
>> kvm_arch_vcpu_create calls kvm_riscv_reset_vcpu which calls
>> kvm_riscv_vcpu_fp_reset.
>>
>> riscv_vcpu_set_isa_ext_single and kvm_riscv_vcpu_set_reg_config
>> only call kvm_riscv_vcpu_fp_reset if !vcpu->arch.ran_atleast_once.
>>
>> kvm_riscv_vcpu_fp_reset sets FS bits to "initial"
>> if CONFIG_FPU=y and extension F or D is available.
>>
>> It seems that in KVM only the creation of a vcpu will set the FS bits but
>> rebooting will not.
> 
> If KVM never resets the boot VCPU on reboot, then maybe it should or needs
> QEMU to inform it to do so. I'd rather just one of the two (KVM or QEMU)
> decide what needs to be reset and to which values, rather than both having
> their own ideas. For example, with this patch, the boot hart will have its
> sstatus.FS set to 3, but, iiuc, all secondaries will be brought up
> with their sstatus.FS set to 1.
> 
> Thanks,
> drew

Hello Drew,

I added some debug messages.

Without smp: Linux' kvm_riscv_vcpu_fp_reset() is called before QEMU's 
kvm_riscv_reset_vcpu() and is never called on reboot.

qemu-system-riscv64 -M virt -accel kvm -nographic -kernel 
payload_workaround.bin
[  920.805102] kvm_arch_vcpu_create: Entry
[  920.805608] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  920.805961] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  920.806289] kvm_arch_vcpu_create: Exit
[  920.810554] kvm_arch_vcpu_create: Entry
[  920.810959] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  920.811334] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  920.811696] kvm_arch_vcpu_create: Exit
[  920.816772] kvm_arch_vcpu_create: Entry
[  920.817095] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  920.817411] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  920.817975] kvm_arch_vcpu_create: Exit
[  920.818395] kvm_riscv_vcpu_set_reg_config:
[  920.818696] kvm_riscv_vcpu_set_reg_config:
[  920.818975] kvm_riscv_vcpu_set_reg_config:
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
[  920.946333] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
[  920.947031] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
[  920.947700] kvm_riscv_check_vcpu_requests: Entry
[  920.948482] kvm_riscv_check_vcpu_requests: Entry

Test payload
============

[  920.950012] kvm_arch_vcpu_ioctl_run: run->ext_reason 35

[  920.950666] kvm_riscv_check_vcpu_requests: Entry
Rebooting

[  920.951478] kvm_arch_vcpu_ioctl_run: run->ext_reason 35
[  920.952051] kvm_riscv_check_vcpu_requests: Entry
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
[  920.962404] kvm_arch_vcpu_ioctl_run: run->ext_reason 24
[  920.962969] kvm_arch_vcpu_ioctl_run: run->ext_reason 24
[  920.963496] kvm_riscv_check_vcpu_requests: Entry

Test payload
============


With -smp 2 this seems to hold true per CPU. So essentially the effect 
of vm_riscv_vcpu_fp_reset() is always ignored both on the primary and 
the secondary harts.

$ qemu-system-riscv64 -M virt -accel kvm -smp 2 -nographic -kernel 
payload_workaround.bin
[  202.573659] kvm_arch_vcpu_create: Entry
[  202.574024] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  202.574328] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  202.574626] kvm_arch_vcpu_create: Exit
[  202.580626] kvm_arch_vcpu_create: Entry
[  202.581070] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  202.581599] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  202.582040] kvm_arch_vcpu_create: Exit
[  202.587356] kvm_arch_vcpu_create: Entry
[  202.587894] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  202.588376] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  202.589188] kvm_arch_vcpu_create: Exit
[  202.589650] kvm_riscv_vcpu_set_reg_config:
[  202.590014] kvm_riscv_vcpu_set_reg_config:
[  202.590340] kvm_riscv_vcpu_set_reg_config:
[  202.595220] kvm_arch_vcpu_create: Entry
[  202.595604] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  202.595939] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  202.596278] kvm_arch_vcpu_create: Exit
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
[  202.602093] kvm_arch_vcpu_create: Entry
[  202.602426] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  202.602777] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  202.603110] kvm_arch_vcpu_create: Exit
[  202.607898] kvm_arch_vcpu_create: Entry
[  202.608306] kvm_riscv_vcpu_fp_reset: At entry FS=0
[  202.608989] kvm_riscv_vcpu_fp_reset: At exit FS=8192
[  202.609416] kvm_arch_vcpu_create: Exit
[  202.609939] kvm_riscv_vcpu_set_reg_config:
[  202.610312] kvm_riscv_vcpu_set_reg_config:
[  202.610666] kvm_riscv_vcpu_set_reg_config:
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
[  202.749911] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
[  202.750370] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
[  202.750799] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
[  202.750819] kvm_arch_vcpu_ioctl_run: run->ext_reason 0
[  202.751574] kvm_riscv_check_vcpu_requests: Entry
[  202.751617] kvm_riscv_check_vcpu_requests: Entry
[  202.752737] kvm_riscv_check_vcpu_requests: Entry

Test payload
============

[  202.753678] kvm_arch_vcpu_ioctl_run: run->ext_reason 35
fcvt.d.w fa5,a5
[  202.754145] kvm_riscv_check_vcpu_requests: Entry
Rebooting

[  202.754655] kvm_arch_vcpu_ioctl_run: run->ext_reason 35
[  202.755030] kvm_riscv_check_vcpu_requests: Entry
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
QEMU riscv_cpu_reset_hold: Entry
QEMU kvm_riscv_reset_vcpu: Entry
QEMU kvm_riscv_reset_vcpu: Exit
QEMU riscv_cpu_reset_hold: Exit
[  202.770352] kvm_arch_vcpu_ioctl_run: run->ext_reason 24
[  202.770915] kvm_arch_vcpu_ioctl_run: run->ext_reason 10
[  202.770951] kvm_arch_vcpu_ioctl_run: run->ext_reason 24
[  202.771802] kvm_arch_vcpu_ioctl_run: run->ext_reason 10
[  202.772272] kvm_riscv_check_vcpu_requests: Entry
[  202.772888] kvm_riscv_check_vcpu_requests: Entry

Test payload
============


When thinking about the migration of virtual machines shouldn't QEMU be 
in control of the initial state of vcpus instead of KVM?

CCing the RISC-V KVM maintainers.

Best regards

Heinrich

