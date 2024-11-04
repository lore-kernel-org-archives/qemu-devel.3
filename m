Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C64FD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vzr-0005ua-D6; Mon, 04 Nov 2024 07:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t7vzf-0005oI-Dj
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:15:42 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t7vzd-0006sT-Kd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:15:39 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e983487a1so3551044b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730722535; x=1731327335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdjVU/BH2CwjfStYpYOl3F+q0QoONZJX3qaVJDdlVlc=;
 b=WwONtjG4tay/OAUQ1sEUk0+0Dg4iYZBra3vJOFO9dGVNJtKQ/ugcajaSz9aIfXrl+s
 pHT6EraVmvHEboulodEt9sNDNIThOdX2EX6GT20bINd8ip1THO/UNOWy0v/Aimdm6M7T
 yUMAXRzNr8c1tqT6ClGsg/Zx3xUKWjkbRQIAgMhq5L9lztF5Mihb8VJki42sa6OoSKBB
 BUVNKYTyars4Dmtg4tILandPuOloBAacLe8QhmKdI3GYgCwmutw/mjePhKDFbHbc3yI4
 d/fUGzs0Z4Q/qG00q5OcJpgHtQdZ63VIZjhrMR+VyczKF8zDF185kq8hjynImpL5OVeT
 EVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730722535; x=1731327335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KdjVU/BH2CwjfStYpYOl3F+q0QoONZJX3qaVJDdlVlc=;
 b=s6ptqD1uIbJK+kLVHO7h5d4XX8/wZnt1y5mosoJc6bHXIIoUv0LMYnzwT8VTYTNS/Z
 n5Fo/6ivcoOYUklz6X8GrSdopKYxuSX3F1hovj9dqemw3rXTeQ1XICLZrwigH3feWCPW
 zJAnjJ3dTHheZWPiKjM1pRfdWyz3lxjkumBFNlH4QSjwlejhAPQOjAXyp8sqRG+kcOGP
 S9iIz6Wk49ZpPzXJ3AG9bnr39/8+Wdj6wvqRshATPakfP/mRRUOyraXF7b9RzRR4WT2u
 OoxAi+HXb2itsjW+IBXCZyEyXv+JIdeKIeRjMWFDnBclV1Q1j77YgUsovFfZKcph2KDe
 C4Cg==
X-Gm-Message-State: AOJu0YyCkqg6fSH/EWVzT4zyJCoKvLRYXb2RPi1C/eL+SaKongcg6r6U
 edzJSr9Zv/myaGBnjZoUdwkKluBmReuYJ4RhGNqeHe+xtBObyVggCGULTDWZD2A=
X-Google-Smtp-Source: AGHT+IFJ6n4l6BeskxndZpF8Wgt4X0/NTjNpKEqd7q/l4mpuqRGcHAeWdaKdXDvpmYywJmJvVj6h2A==
X-Received: by 2002:a05:6a00:9298:b0:71e:3b8:666b with SMTP id
 d2e1a72fcca58-720b9ccc053mr21466812b3a.15.1730722535360; 
 Mon, 04 Nov 2024 04:15:35 -0800 (PST)
Received: from [192.168.68.110] ([152.234.121.56])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1e780fsm7299513b3a.46.2024.11.04.04.15.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 04:15:34 -0800 (PST)
Message-ID: <f2614f02-b297-4320-84ca-42b7384f8f93@ventanamicro.com>
Date: Mon, 4 Nov 2024 09:15:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host
 doesn't support it
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com,
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241101083606.5122-1-yongxuan.wang@sifive.com>
 <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
 <20241101-6ada91d63644e8d715b1cf35@orel>
 <CAMWQL2hwDZdB9TmHF4=krzrUa1_=P78aBYt6nJddGZxMjk702A@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAMWQL2hwDZdB9TmHF4=krzrUa1_=P78aBYt6nJddGZxMjk702A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 11/4/24 8:14 AM, Yong-Xuan Wang wrote:
> Hi Daniel and Andrew,
> 
> When handling an external interrupt via IMSIC, we need to use the stopei CSR
> to claim the top interrupt. Even though the QEMU can emulate the IMSIC devices
> without the in-kernel irqchip, we still need to trap and emulate the stopei
> CSR. But since the host machine doesn't support the AIA extension, the guest OS
> will hit the illegal instruction exception instead of the virutal instruction
> exception when it accesses the stopei CSR. We can't have a chance to redirect
> this instruction to QEMU. So I think we can directly report errors when the
> user wants to use KVM AIA(MSI) without in-kernel AIA irqchip support.

Can you please add this info in the commit message? This makes it clearer
that there's not much we can do in QEMU aside from erroring out.

Also, please add a:

Fixes: 48c2c33c52 ("target/riscv: select KVM AIA in riscv virt machine")


Thanks,

Daniel

> 
> Regards,
> Yong-Xuan
> 
> On Fri, Nov 1, 2024 at 11:09 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>>
>> On Fri, Nov 01, 2024 at 08:45:13AM -0300, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 11/1/24 5:36 AM, Yong-Xuan Wang wrote:
>>>> Currently QEMU will continue to emulate the AIA MSI devices and enable the
>>>> AIA extension for guest OS when the host kernel doesn't support the
>>>> in-kernel AIA irqchip. This will cause an illegal instruction exception
>>>> when the guest OS uses the IMSIC devices. Add additional checks to ensure
>>>> the guest OS only uses the AIA MSI device when the host kernel supports
>>>> the in-kernel AIA chip.
>>>>
>>>> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>>>> Reviewed-by: Jim Shu <jim.shu@sifive.com>
>>>> ---
>>>>    hw/riscv/virt.c | 19 +++++++++++++------
>>>>    1 file changed, 13 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>>> index 45a8c4f8190d..0d8e047844a6 100644
>>>> --- a/hw/riscv/virt.c
>>>> +++ b/hw/riscv/virt.c
>>>> @@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *machine)
>>>>            }
>>>>        }
>>>> -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
>>>> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
>>>> -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
>>>> -                             memmap[VIRT_APLIC_S].base,
>>>> -                             memmap[VIRT_IMSIC_S].base,
>>>> -                             s->aia_guests);
>>>> +    if (kvm_enabled() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
>>>> +        if (virt_use_kvm_aia(s)) {
>>>> +            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
>>>> +                                 VIRT_IRQCHIP_NUM_SOURCES,
>>>> +                                 VIRT_IRQCHIP_NUM_MSIS,
>>>> +                                 memmap[VIRT_APLIC_S].base,
>>>> +                                 memmap[VIRT_IMSIC_S].base,
>>>> +                                 s->aia_guests);
>>>> +        } else {
>>>> +            error_report("Host machine doesn't support in-kernel APLIC MSI, "
>>>> +                         "please use aia=none or aia=aplic");
>>>> +            exit(1);
>>>> +        }
>>>
>>> As you said in the commit msg it looks like we have a bug in this particular path: kvm accel,
>>> aia=aplic-imsic, no irqchip present. Erroring out is one possible solution but I wonder why we
>>> couldn't just emulate the APLIC and IMSIC controllers in this case. We have code that does
>>> that in TCG, so it would be a matter of adding the needed plumbing to treat KVM AIA without
>>> irqchip == TCG AIA.
>>>
>>> Drew, care to weight in? Thanks,
>>>
>>
>> If I understand the motivation for this patch correctly, then we'll always
>> need something like it anyway. With the proposal of supporting KVM with
>> usermode-imsic, then KVM would ultimately have three possible states:
>> inkernel-irqchip, usermode-imsic, nothing. usermode-imsic will need KVM
>> support for forwarding imsic accesses to QEMU, but when that support isn't
>> present (and the inkernel-irqchip isn't selected either), then we should
>> still want to error out before allowing the guest to try accesses that
>> can't work.
>>
>> Thanks,
>> drew

