Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BBAC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 06:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0bTf-0001uV-25; Sat, 27 Apr 2024 02:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s0bTR-0001rO-A5
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 02:23:49 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s0bTL-0000oi-4z
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 02:23:48 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a556d22fa93so326270666b.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 23:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714199021; x=1714803821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PU1WiGTy9nuAHYMbOcDD7fsR2eqaB67hJZeJnbAnMfA=;
 b=iBq8MGyyqN6n+d6b8zS4E8Q43wH6bfnNlSCaGjGlnxNoo5Gxg9lx4YKw1rDw9h5CxQ
 WyO5A0LopkEdjF5Vf/hZeArg0C2RzWR/N+NZ1LR+IL4xsvjqnzkrq7RUZTHzRc5GWzuj
 aznOhiAVC+3iwgGsV9HgmU/GLpfPVISOulN+xTIcfAjjsmKXQ0Dce+dQD7Hai2KLg0j5
 AP6g8TVHKYjqCYkLaxQ5rYPD7yBaVolITHE5Dp/WnAHytrZgLEC1f/fz9tsMBN7Wv0wj
 ofpAeTDUcQbau2SO+5V8ce5WzFglIXn04pNv87W3kY+7+CFnlWxoElnm7witI2wUOdn7
 AHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714199021; x=1714803821;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PU1WiGTy9nuAHYMbOcDD7fsR2eqaB67hJZeJnbAnMfA=;
 b=aowD+qoZZ9TQ2+tIeZXcRmw8WUPiWVrfoC9RK1Oe+SKNGeH9Nau1Qe8aYzxkBcmJ2o
 ZiZYZJq38nCuwfir4Ruk/ygytZ/xcv8XZLdQ48150YWhEYO40Z0X8Vt/DXQne49mmxth
 5JC+83SJlvONv//SbrrNGUXeEerykm0VqBMEzLdO0T6wMuAKcsepdI9Y7TGr8UinzfOP
 JbNXw6PBFCSNJxyQ7XR4Aa0O3+q6PCGLQYib9nRBzoNRh3nzoHezGE1uuEOMcIlrdiOL
 epiD9x5GpcFWOFS6simHefeiA9n7fBUTxUNXbXozVczPTh86jnV4OaCgv2ipTw/6AYbQ
 kXAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHcBMnITATi9DOzUEpkgh1M4YtW0lMGlPtHOTePTjJpwM/JwILbYQgReAuwmlS031zVzrN7IDArq28AXY+IYA8FDzIovA=
X-Gm-Message-State: AOJu0YxILfh+7FYIti1m1CBdwRPFXSanKgJ7GPzHq99FZhIf+FhZBvPa
 YRzplbQF5/GajdIcN7EROiUnxUjpCN7lhBjspJeUg6J6a4Hq4830dbprTh8dnyY=
X-Google-Smtp-Source: AGHT+IHAwqaqBvaNm2GnaEQWa4JmeoiwGNfHfPKwEwy1dMsPOLaPuIKYIwUqnXu209L6L7QwN2FRgA==
X-Received: by 2002:a17:906:7c52:b0:a55:201f:75a with SMTP id
 g18-20020a1709067c5200b00a55201f075amr2683296ejp.33.1714199021075; 
 Fri, 26 Apr 2024 23:23:41 -0700 (PDT)
Received: from [127.0.0.1] (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a1709065f8e00b00a559bbe8a00sm8548052eju.100.2024.04.26.23.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 23:23:40 -0700 (PDT)
Date: Sat, 27 Apr 2024 08:23:40 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
CC: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_target/riscv/kvm=3A_fix_ti?=
 =?US-ASCII?Q?mebase-frequency_when_using_KVM_acceleration?=
In-Reply-To: <e841b1ba-1348-48ae-89b7-bfa14ff8e70c@tls.msk.ru>
References: <20240314061510.9800-1-yongxuan.wang@sifive.com>
 <e841b1ba-1348-48ae-89b7-bfa14ff8e70c@tls.msk.ru>
Message-ID: <2C907355-C0F4-4C7F-B37C-8B4371A57B00@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x634.google.com
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

On April 27, 2024 1:44:42 AM GMT+02:00, Michael Tokarev <mjt@tls=2Emsk=2Eru=
> wrote:
>14=2E03=2E2024 09:15, Yong-Xuan Wang:
>> The timebase-frequency of guest OS should be the same with host
>> machine=2E The timebase-frequency value in DTS should be got from
>> hypervisor when using KVM acceleration=2E
>
>This change ended up in stable-8=2E2 (v8=2E2=2E3)=2E  Interestingly, this=
 thing
>compiled not even once, or else it would be obvious it fails to compile=
=2E
>Somehow I was too used to CI, forgetting that we don't have riscv *host*
>in CI (and I don't have one locally either)=2E  So 8=2E2=2E3 is broken on
>riscv64 *host*=2E

It's possible to cross-compile qemu, so it'd be good to add that to the CI=
 for riscv until we can add native compiling=2E

>
>In 8=2E2, KVM_RISCV_GET_TIMER macro accepts 4 arguments, because it does
>not have 10f86d1b845087d1 "target/riscv/kvm: change timer regs size to u6=
4"=2E
>
>What do you think, should I revert this change for stable-8=2E2, or pick
>10f86d1b845087d1 too, or change this commit (fix timebase-frequency) to
>provide the missing argument for this macro?

Changing the timer regs to u64 is an rv32 fix, so it's reasonable to also =
pick it up=2E I suggest we keep this patch one way or another, though=2E

Thanks,
drew

>
>Thanks,
>
>/mjt
>
>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro=2Ecom>
>> Signed-off-by: Yong-Xuan Wang <yongxuan=2Ewang@sifive=2Ecom>
>>=20
>> ---
>> Changelog
>> v2:
>> - update the function definition
>> - restructure if-else statement
>> ---
>>   hw/riscv/virt=2Ec              | 2 ++
>>   target/riscv/kvm/kvm-cpu=2Ec   | 9 +++++++++
>>   target/riscv/kvm/kvm_riscv=2Eh | 1 +
>>   3 files changed, 12 insertions(+)
>>=20
>> diff --git a/hw/riscv/virt=2Ec b/hw/riscv/virt=2Ec
>> index a094af97c32a=2E=2E533b17799581 100644
>> --- a/hw/riscv/virt=2Ec
>> +++ b/hw/riscv/virt=2Ec
>> @@ -711,6 +711,8 @@ static void create_fdt_sockets(RISCVVirtState *s, c=
onst MemMapEntry *memmap,
>>         qemu_fdt_add_subnode(ms->fdt, "/cpus");
>>       qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
>> +                          kvm_enabled() ?
>> +                          kvm_riscv_get_timebase_frequency(first_cpu) =
:
>>                             RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>>       qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>>       qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
>> diff --git a/target/riscv/kvm/kvm-cpu=2Ec b/target/riscv/kvm/kvm-cpu=2E=
c
>> index c7afdb1e81b7=2E=2Ebbb115eaa867 100644
>> --- a/target/riscv/kvm/kvm-cpu=2Ec
>> +++ b/target/riscv/kvm/kvm-cpu=2Ec
>> @@ -739,6 +739,15 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>>       env->kvm_timer_dirty =3D false;
>>   }
>>   +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
>> +{
>> +    uint64_t reg;
>> +
>> +    KVM_RISCV_GET_TIMER(cs, frequency, reg);
>> +
>> +    return reg;
>> +}
>> +
>>   static int kvm_riscv_get_regs_vector(CPUState *cs)
>>   {
>>       RISCVCPU *cpu =3D RISCV_CPU(cs);
>> diff --git a/target/riscv/kvm/kvm_riscv=2Eh b/target/riscv/kvm/kvm_risc=
v=2Eh
>> index 4bd98fddc776=2E=2E58518988681d 100644
>> --- a/target/riscv/kvm/kvm_riscv=2Eh
>> +++ b/target/riscv/kvm/kvm_riscv=2Eh
>> @@ -28,5 +28,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint=
64_t group_shift,
>>   void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>>   int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>>   void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>> +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
>>     #endif
>


