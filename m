Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6B4C54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 15:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recjO-0005DS-U1; Mon, 26 Feb 2024 10:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1recjM-0005D5-Tv
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 10:17:24 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1recjJ-0005mT-ND
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 10:17:24 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a43488745bcso167374766b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 07:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708960639; x=1709565439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f52QYFCaGWCpRHsCufjr2Sr63Rl3JmmvQZfQyxIx2gE=;
 b=Sy4QDyaT7fH+g8p1bgkw0YLv1jxE0eyL5zVFLwxUNZDunC22ezPVC6INABRLd1+/G6
 j9uwAyJhBfHnb1pm8e0M4lK7PnSfN7rCx92U1x2RDV13ILhChf3A0vCIeqsK6/naTF8/
 ZG2m2vOYzq5svJI7dMXtje4kWJHHcwfAiimONr5tloBAM905cUR0VcyeAXoWp/zI4QW4
 UhTLEmo+t7kN4/Es2hfXOEX7e96JLOIS264VEUtLgBq1UG2Yhpvow4spj7uF0dk6/0NU
 d1iAsf8FxgkHySFFQyotm8zx4RtEQct1C1zg/6ggRKiD+EApTFYOM7fp2IU8KbSk2MZL
 MdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708960639; x=1709565439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f52QYFCaGWCpRHsCufjr2Sr63Rl3JmmvQZfQyxIx2gE=;
 b=Ow4BQAIWigy+6rACIishJw8FdjoUGowRTf8ak7CHsGtcCVIwLCQuwfBuYwZDQ9ozps
 0AWJEW4TTEk0GE1tHM7pNgjqfMihaFR/mAjO3JLM8yw+C3tCMCydfdTIHnvULADa7raF
 fkAfMHyDuTIThy0fz7RKGEaXzNNs0gVrB6jfGjyjk4TSSBVjbaoYFENRDQAMi8wvdF+r
 Ok+oWTyJHx0TPdskO0/Ki2VGNxJDjZupp6G2NF/kN+RUsZWvnnwqw/UWI0Yf3FXuilVk
 iS3dVOMLWx306Lt1m2c+OSOXpJ8sKh3HSxEWGDrwq+VyxawYZlmM7yGVsEvfVvOWZbX5
 czbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2GcePYxhOU9G8KxzyhqOmKf7HyhyrV9e9FkvXb+MxZBWORsuvdAun18ECu24BzFIULNUhflg02Wsmj5gIWXhV3GH1998=
X-Gm-Message-State: AOJu0YzrWfR0N/zpPTJuFANWk2TYp5/raKn88nT6wOuXinkzaJCPBBcE
 82crs43wDlO//xBAWVckO8+48ioiNg/2mxTn/vG6VVbAL0lk/tcX5zdi21M11IA=
X-Google-Smtp-Source: AGHT+IGItYR0Xtm+uGiBYOpGPUEBwDaS6EWhOV2n9ljJsvyzi7F9JcMNtdqEdWn6eMQxTDmikJaysA==
X-Received: by 2002:a17:906:64b:b0:a3f:bcff:18b8 with SMTP id
 t11-20020a170906064b00b00a3fbcff18b8mr4861285ejb.27.1708960638639; 
 Mon, 26 Feb 2024 07:17:18 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 qo4-20020a170907874400b00a431fca6a2esm1667445ejc.37.2024.02.26.07.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 07:17:18 -0800 (PST)
Message-ID: <26ebeef5-9e71-4d11-9d90-01d63fb1d124@linaro.org>
Date: Mon, 26 Feb 2024 16:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] hw/isa/lpc_ich9: add broadcast SMI feature
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>, 
 Kevin O'Connor <kevin@koconnor.net>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20170126014416.11211-1-lersek@redhat.com>
 <20170126014416.11211-3-lersek@redhat.com>
 <50ad98bf-cee9-44f7-bf4d-ada2a02e330b@linaro.org>
 <e0c25486-a369-f8d5-c9ce-5984083d475a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e0c25486-a369-f8d5-c9ce-5984083d475a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 20/2/24 11:09, Laszlo Ersek wrote:

(Cc'ing Kevin too)

> On 2/20/24 08:58, Philippe Mathieu-Daudé wrote:
>> Hi Laszlo, Igor, Gerd,
>>
>> (old patch, now commit 5ce45c7a2b)
>>
>> On 26/1/17 02:44, Laszlo Ersek wrote:
>>> The generic edk2 SMM infrastructure prefers
>>> EFI_SMM_CONTROL2_PROTOCOL.Trigger() to inject an SMI on each
>>> processor. If
>>> Trigger() only brings the current processor into SMM, then edk2
>>> handles it
>>> in the following ways:
>>>
>>> (1) If Trigger() is executed by the BSP (which is guaranteed before
>>>       ExitBootServices(), but is not necessarily true at runtime), then:
>>>
>>>       (a) If edk2 has been configured for "traditional" SMM
>>> synchronization,
>>>           then the BSP sends directed SMIs to the APs with APIC delivery,
>>>           bringing them into SMM individually. Then the BSP runs the SMI
>>>           handler / dispatcher.
>>>
>>>       (b) If edk2 has been configured for "relaxed" SMM synchronization,
>>>           then the APs that are not already in SMM are not brought in, and
>>>           the BSP runs the SMI handler / dispatcher.
>>>
>>> (2) If Trigger() is executed by an AP (which is possible after
>>>       ExitBootServices(), and can be forced e.g. by "taskset -c 1
>>>       efibootmgr"), then the AP in question brings in the BSP with a
>>>       directed SMI, and the BSP runs the SMI handler / dispatcher.
>>>
>>> The smaller problem with (1a) and (2) is that the BSP and AP
>>> synchronization is slow. For example, the "taskset -c 1 efibootmgr"
>>> command from (2) can take more than 3 seconds to complete, because
>>> efibootmgr accesses non-volatile UEFI variables intensively.
>>>
>>> The larger problem is that QEMU's current behavior diverges from the
>>> behavior usually seen on physical hardware, and that keeps exposing
>>> obscure corner cases, race conditions and other instabilities in edk2,
>>> which generally expects / prefers a software SMI to affect all CPUs at
>>> once.
>>>
>>> Therefore introduce the "broadcast SMI" feature that causes QEMU to
>>> inject
>>> the SMI on all VCPUs.
>>
>> I'm trying to remove cpu_interrupt() API from hw/ and found this odd
>> case.
>>
>> IIUC, the code you added is closer to what real HW is doing:
>>
>>    CPU_FOREACH(cs) { cpu_interrupt(cs, CPU_INTERRUPT_SMI); }
>>
>> and previous implementation was bogus:
>>
>>    cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>>
>> but to avoid breaking older VMs ready to deal with bogus impl,
>> you have to add a virtual (non-HW) ICH9_LPC_SMI_F_BROADCAST bit
>> so new VMs can detect (negotiating) it and use normal expected
>> HW behavior.
>>
>> If so, and since this change was almost 7 years ago, can we
>> expect that most of today's VMs use ICH9_LPC_SMI_F_BROADCAST_BIT,
>> and would it be possible to deprecate it, so it become the only
>> possibility, allowing us to remove this bogus call?
>>
>>    cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> 
> For OVMF guests: yes, said deprecation should be safe.
> 
> Note however that the "current_cpu" case (the original case) had been in
> place minimally for SeaBIOS. I don't know how exactly the deprecation /
> removal in QEMU would work, but if you build SeaBIOS with
> CONFIG_USE_SMM, it might still depend on the "current_cpu" branch.
> 
> FWIW, "roms/config.seabios-128k" and "roms/config.seabios-microvm" both
> contain CONFIG_USE_SMM=n, so the deprecation likely wouldn't matter for
> those SeaBIOS binaries (bundled with QEMU). But it could matter for
> SeaBIOS binaries from other sources; plus "roms/config.seabios-256k"
> does *not* contain a setting like that (and the SeaBIOS default is "y",
> when building for QEMU).
> 
> For another data point: as far as I remember, we had disabled
> CONFIG_USE_SMM in RHEL; there had been stability issues.
> 
> ... I can't describe *all* the uses that SeaBIOS has for SMM. *One* use
> is from commit 55215cd425d3 ("Implement call32 mechanism using SMIs.",
> 2014-10-15) -- "this allows SeaBIOS to transition to 32bit mode even
> when called in vm86 mode". Because that commit modifies "stacks.c", I
> think it must be related to the "cooperative multi-tasking system"
> described here: <https://www.seabios.org/Execution_and_code_flow#Threads>.
> 
> I'm really rusty on this [*], but here's one potential symptom I can
> theorize about: assuming you silently make broadcast SMI the default in
> QEMU, and SeaBIOS raises an SMI (expecting it to only affect the BSP),
> the SMI could become pending on all the APs (which would all be in RESET
> state at that point [**]). And when Linux booted those APs with
> INIT-SIPI-SIPI sequences, the pending SMIs could be delivered
> immediately, and the APs would launch immediately into SMM. That would
> likely not be expected.
> 
> [*] Using earlier edk2 commit cbccf995920a ("OvmfPkg/CpuHotplugSmm: fix
> CPU hotplug race just after SMI broadcast", 2020-08-27) as cheat-sheet.
> IIRC, I consulted the Intel SDM extensively back when I was working on
> that patch.
> 
> [**] Hm... wait. It seems SeaBIOS does boot all APs in the system. The
> APs apparently end up penned in a HLT-loop; see at the end of
> "entry_smp" in "romlayout.S". In that case, the problem could be worse I
> guess? The broadcast SMI could wake all APs from their halted states.
> SeaBIOS doesn't seem to relocate SMBASE for the APs, so if multiple
> processors start executing in SMM at the same time, the results are not
> going to be stellar.

Thanks a lot Laszlo for this detailed historical information, it is
very helpful. I'll preserve current behavior as a kludge, because it
helps demonstrate part of my heterogeneous prototype, and see later
if we can deprecate that to eventually remove the kludge.

Regards,

Phil.

> Laszlo
> 
>>
>>> While the original posting of this patch
>>> <http://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05658.html>
>>> only intended to speed up (2), based on our recent "stress testing" of
>>> SMM
>>> this patch actually provides functional improvements.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>
>>> Notes:
>>>       v7:
>>>       - no changes, pick up Igor's R-b
>>>            v6:
>>>       - no changes, pick up Michael's R-b
>>>            v5:
>>>       - replace the ICH9_LPC_SMI_F_BROADCAST bit value with the
>>>         ICH9_LPC_SMI_F_BROADCAST_BIT bit position (necessary for
>>>         DEFINE_PROP_BIT() in the next patch)
>>>
>>>    include/hw/i386/ich9.h |  3 +++
>>>    hw/isa/lpc_ich9.c      | 10 +++++++++-
>>>    2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
>>> index da1118727146..18dcca7ebcbf 100644
>>> --- a/include/hw/i386/ich9.h
>>> +++ b/include/hw/i386/ich9.h
>>> @@ -250,4 +250,7 @@ Object *ich9_lpc_find(void);
>>>    #define ICH9_SMB_HST_D1                         0x06
>>>    #define ICH9_SMB_HOST_BLOCK_DB                  0x07
>>>    +/* bit positions used in fw_cfg SMI feature negotiation */
>>> +#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>>> +
>>>    #endif /* HW_ICH9_H */
>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>> index 376b7801a42c..ced6f803a4f2 100644
>>> --- a/hw/isa/lpc_ich9.c
>>> +++ b/hw/isa/lpc_ich9.c
>>> @@ -437,7 +437,15 @@ static void ich9_apm_ctrl_changed(uint32_t val,
>>> void *arg)
>>>          /* SMI_EN = PMBASE + 30. SMI control and enable register */
>>>        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
>>> -        cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>>> +        if (lpc->smi_negotiated_features &
>>> +            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
>>> +            CPUState *cs;
>>> +            CPU_FOREACH(cs) {
>>> +                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>>> +            }
>>> +        } else {
>>> +            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>>> +        }
>>>        }
>>>    }
>>>    
>>
> 


