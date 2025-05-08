Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1397C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0oB-0002Qw-06; Thu, 08 May 2025 08:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0o8-0002QQ-Fc
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:57:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0o6-000714-Kg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:57:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e033a3a07so10991885ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746709017; x=1747313817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9pJjdoekuhc4yMSxtr3j+KnXmQZ6lV5ZboD4CrHy7xU=;
 b=az3tbm6Bmf0K00ko1+dEIf6W0CeziiPGb6WfzK2uAQ3Z4s3i3NtiHfymlq/9b9Nl8F
 C+tuJVCxvHac65Ipor9+TKBDvqzd+HQp4RSCl5Osn7xmCKW7RFRZ7XgwzHhQ4JVlsoxi
 P/2UaVNJ+PTbbWv6NqpsFDH0zAxDVF4vHQNDtmqhWdxNnHAfzEj3xcWngOmEV30rDW8H
 L5gvEUPdm3D9PddpFy8ypCCATdrHaRiikDoPbxWlLVSbvq96fZD5iBqxID+gbILf7/Ok
 MLD/ep3fSjwJCG3khTUbTvoSyV2dcM/Ipc+QGa19gMTvDM/5Jp/I+3U0PBLSHYka0mL3
 R3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746709017; x=1747313817;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9pJjdoekuhc4yMSxtr3j+KnXmQZ6lV5ZboD4CrHy7xU=;
 b=aPO9Gt6Wqd0XY/RTtF+iPvoYY1HUp0qjeaRkMJJcAw5bxkPZVNSVABWAeQ8y1Vvlgo
 Q4m92CNmqKPZUmKmoJHhhTLFkHB2Ma90AUCUEZViqkn61HbEFudmLReGQm9/2OqFypHo
 dEeJpqANhRcd1M1vkQ4Lc1jP9OrkvKjwChTMTK/wCni6kOjljMv0a+Q/4iTHWrBf3gjA
 WE3ldKwSi0Pq+83wAmmQi8caS6zP0qTyFsb4EHkB0kOCr9i4owd+2O+UrNzh/LJElP9H
 b+1bNZPBjCZ/43vQEnok9E744x8EP8hjv0T3bLdla5bZMtlv85RFTPaVwqjCckRSkOfM
 CeUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwmtTS02VjxEs9vbGwzIBtMM+67QumqjEDRZepae5KJRVPw7gOhZdWX1bvuslhW/oqEtFirH9Jl9kr@nongnu.org
X-Gm-Message-State: AOJu0YzC3WhKAbglv/Us/qho4fMSQeT9u/PtyJJASAL7C4iW4obuwPUv
 b1hC6aZPt0yFDaFgKLRR7tlc18D83dmv7Zi6NktSZp3b2lU5cM7sI+I3b+y15Iw=
X-Gm-Gg: ASbGncs6UFpZcephmeLQL07Q5PtjetegFB9YoQFMu2XwrpbfPZrkh47VA3Bi2eUp2Vn
 zGXOtcW2WqJBA0DTcfg/UVP7yJohQAglcnp2tkRTwDF9NU4slvTcHxKGBGNQIGqyTQCBpXCla9O
 4TDDjZAXDtjQmIfvKB0ILfDQsMxuFNH1Am1IiJuzFMFdluqnOQPgDBrQZK8kCnbzH39/2MgmauX
 sH50/LwzJJ4VUSYwSK8vcOIQQUeumcnOCyqraevz8+RxNT0cqqfv/oG9LNiCSGuvTaYCslfH7O1
 A/DOy22Zpoy/H0hy2GkSWw9IN79lHo9JeTDHzexyDr90AF5I+t2ozcSoUuLfnH9G0upwSMat2Aw
 JSJ/oRCsK
X-Google-Smtp-Source: AGHT+IGZpcx63wuPU1bRAh1qPdu9aqbL5NgEYwwxIg6K0jsxzLMLTJKWnbrbAPz7BUBUAQHaL6wFyQ==
X-Received: by 2002:a17:903:4091:b0:22e:1791:2e5a with SMTP id
 d9443c01a7336-22e5eaa70demr98224355ad.35.1746709016620; 
 Thu, 08 May 2025 05:56:56 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6265945fsm33740185ad.134.2025.05.08.05.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 05:56:56 -0700 (PDT)
Message-ID: <a829863c-33d2-42c9-8068-431c60540ba2@linaro.org>
Date: Thu, 8 May 2025 14:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-4-philmd@linaro.org>
 <2acc8c0c-f563-4d27-b73d-ce4c0f8ef424@nutanix.com>
 <54d72848-9108-4b04-a46c-1f82492e06cb@linaro.org>
 <bd23ff1c-d1a2-4967-b8bb-a6eda6a4ca33@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bd23ff1c-d1a2-4967-b8bb-a6eda6a4ca33@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/5/25 11:06, Thomas Huth wrote:
> On 02/05/2025 12.45, Philippe Mathieu-Daudé wrote:
>> On 2/5/25 11:08, Mark Cave-Ayland wrote:
>>> On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:
>>>
>>>> The X86MachineClass::fwcfg_dma_enabled boolean was only used
>>>> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
>>>> removed. Remove it and simplify.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   include/hw/i386/x86.h | 2 --
>>>>   hw/i386/microvm.c     | 3 ---
>>>>   hw/i386/multiboot.c   | 7 +------
>>>>   hw/i386/x86-common.c  | 3 +--
>>>>   hw/i386/x86.c         | 2 --
>>>>   5 files changed, 2 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>>>> index fc460b82f82..29d37af11e6 100644
>>>> --- a/include/hw/i386/x86.h
>>>> +++ b/include/hw/i386/x86.h
>>>> @@ -29,8 +29,6 @@
>>>>   struct X86MachineClass {
>>>>       MachineClass parent;
>>>> -    /* use DMA capable linuxboot option rom */
>>>> -    bool fwcfg_dma_enabled;
>>>>       /* CPU and apic information: */
>>>>       bool apic_xrupt_override;
>>>>   };
>>
>>
>>>> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
>>>> index 6e6b96bc345..bfa7e8f1e83 100644
>>>> --- a/hw/i386/multiboot.c
>>>> +++ b/hw/i386/multiboot.c
>>>> @@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
>>>>                      int kernel_file_size,
>>>>                      uint8_t *header)
>>>>   {
>>>> -    bool multiboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)- 
>>>> >fwcfg_dma_enabled;
>>>>       int i, is_multiboot = 0;
>>>>       uint32_t flags = 0;
>>>>       uint32_t mh_entry_addr;
>>>> @@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
>>>>       fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
>>>>                        sizeof(bootinfo));
>>>> -    if (multiboot_dma_enabled) {
>>>> -        option_rom[nb_option_roms].name = "multiboot_dma.bin";
>>>> -    } else {
>>>> -        option_rom[nb_option_roms].name = "multiboot.bin";
>>>> -    }
>>>> +    option_rom[nb_option_roms].name = "multiboot_dma.bin";
>>>
>>> Question: now that all machines support DMA-capable fw_cfg, does that 
>>> mean that the non-DMA options roms above can also be removed?
>>
>> All x86 machines, but there are still 2 not supporting it: HPPA and
>> MIPS Loongson-3:
>>
>> hw/hppa/machine.c:204:    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
>>
>> hw/mips/loongson3_virt.c:289:    fw_cfg = 
>> fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
>>
> 
> But these don't use "multiboot.bin", do they? So I think you could 
> remove pc-bios/multiboot.bin now from the repo?
> 
> Same question for "linuxboot.bin" : All users in hw/i386 seem to enable 
> DMA, so fw_cfg_dma_enabled() should always return true here? If so, I 
> think the normal "linuxboot.bin" could go away, too?

You are right!


