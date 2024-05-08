Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BC9C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4e45-0001I9-Id; Wed, 08 May 2024 05:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4e43-0001Hl-9x
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:58:19 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4e40-0007zm-A6
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:58:19 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so6306163e87.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715162294; x=1715767094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SiAt7yhXVrya0kacI9iqGWaYfivCpMx9tK+/08mVhWI=;
 b=tMVz665BWhxpzRKgL/YLwyabOB5ltWYnFtK3MxCm3WnsJ+GHUfresX8RYHNgZCusN1
 mEn9fysDYJ7FS1nbp0HSX6G6E1+FwdSu4MtIzA8otIwGoyBWJcjv4J+4rSHfAcvCQoNl
 2wcbajZIKQma2S/zzVYgiwFODH47r4POU4p1wcV+UUzsnvR6mkxVwxfyKkDVHdPXD/Ds
 KxXOCC6iLb0vBwIyRCQ3hhu5iaNR4VWaicoHg7zSdFE7i93QIN0JU7hz0UnL5qUFm27/
 xRC2nBLW02OQ6UStrTu43pCge2kdo6psNO/s8B0MF2/YpO/IbZPfwLQdD37Y6T8PV7Uu
 Kf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715162294; x=1715767094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SiAt7yhXVrya0kacI9iqGWaYfivCpMx9tK+/08mVhWI=;
 b=LOfb/Rd7QMennwCHGEe07FMLnQ+Mc9eXx3w6ZqGVEjm2p9WLDlTQA+/O4rJclcRhTW
 dtJB4MDsVP4WGZT4Iqep76/fqx+SAYKjGbIXG+JT5Jr2ORIekTk1zgSejw9Un9KQDsV6
 9KGB3L/oBmf3PWUFEq+uBgPN8rac6Dt8BoQaZhc66OY+EHoOjMTFIA/v9zd5/XMNg68S
 yI0Pn+NkM2yhnISJ+FupPEkflIVSsvsPmEPyEr/VuhN/HxQDNbPVp7yuES8yWwnwMqmB
 tPHpQXM1EbR0k3uLS4ot94s3H/6Ncg1ruhovq1uALRrjXrLVl7waSVBKvdTHV8Gzcb2m
 wf0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWosKSQRtbOVRIEi+VLmuTuSQIo0rr3xnY0jagHcGiluk5AUBefyrofLaHlnqqfDlAf58f5DKwrl2S1pOL+NVN8t2QNKMo=
X-Gm-Message-State: AOJu0Yx9j+phv+pSupQNjZIH3wTQX7c880IQlFc/E2nTTlwanXoQaBbq
 0QmthJjr3prvNPg/c859Zo83YMwA+YDJMEVPl8EXjSX4cAYCEgZ2sotrVXf/dG8=
X-Google-Smtp-Source: AGHT+IHRL0Tgh4YjFFam7tY0iVc6Scgox2OODQklOm7yvrqOhNYmip9XBkylyrc1KZ93StUUlZN2AA==
X-Received: by 2002:ac2:4472:0:b0:51a:f362:ab40 with SMTP id
 2adb3069b0e04-5217c373e28mr1749700e87.2.1715162293908; 
 Wed, 08 May 2024 02:58:13 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 hb4-20020a170906b88400b00a5599f3a057sm7529067ejb.107.2024.05.08.02.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 02:58:13 -0700 (PDT)
Message-ID: <39752709-381d-47c7-bba3-8cf5e9ff920a@linaro.org>
Date: Wed, 8 May 2024 11:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] hw/i386/pc_sysfw: Alias rather than copy isa-bios
 region
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-7-shentey@gmail.com>
 <65316058-d2e1-4250-91e6-4da22c1279ed@linaro.org>
 <CDABAD92-BAD8-41A4-97A2-1C13C72552F8@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CDABAD92-BAD8-41A4-97A2-1C13C72552F8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 8/5/24 10:17, Bernhard Beschow wrote:
> 
> 
> Am 30. April 2024 15:39:21 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 30/4/24 17:06, Bernhard Beschow wrote:
>>> In the -bios case the "isa-bios" memory region is an alias to the BIOS mapped
>>> to the top of the 4G memory boundary. Do the same in the -pflash case, but only
>>> for new machine versions for migration compatibility. This establishes common
>>> behavior and makes pflash commands work in the "isa-bios" region which some
>>> real-world legacy bioses rely on.
>>
>> Can you amend a diff of 'info mtree' here to see how the layout changes?
> 
> Will do.
> 
> Right now I have to manually sort the output to get a minimal diff. Is there a way to get a stable ordering of the memory regions? How would one fix that if this is currently impossible? With stable orderings we could have automated memory map tests which had been handy in the past.

It is stable until the guest plays with it, so it depends at which
point in guest execution time you stop your VM to dump the mem tree.

> 
>>
>>> Note that in the sev_enabled() case, the "isa-bios" memory region in the -pflash
>>> case will now also point to encrypted memory, just like it already does in the
>>> -bios case.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>>    include/hw/i386/pc.h | 1 +
>>>    hw/i386/pc.c         | 1 +
>>>    hw/i386/pc_piix.c    | 3 +++
>>>    hw/i386/pc_q35.c     | 2 ++
>>>    hw/i386/pc_sysfw.c   | 8 +++++++-
>>>    5 files changed, 14 insertions(+), 1 deletion(-)
>>
>> I'm still not convinced we need a migration back compat for this...
> 
> A copy behaves different than an alias, thus there is a behavioral change. Whether it really matters in practice for the kind of guests we care about I can't tell. Therefore I'd keep the compat machinery.

Yeah I know MST asked that, I'm not against, I'm just not convinced
(in particular because we'll need to maintain these few lines for
6 years).

> 
> Best regards,
> Bernhard
> 
>>
>>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>>> index 82d37cb376..ac88ad4eb9 100644
>>> --- a/hw/i386/pc_sysfw.c
>>> +++ b/hw/i386/pc_sysfw.c
>>> @@ -135,6 +135,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
>>>                                    MemoryRegion *rom_memory)
>>>    {
>>>        X86MachineState *x86ms = X86_MACHINE(pcms);
>>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>>        hwaddr total_size = 0;
>>>        int i;
>>>        BlockBackend *blk;
>>> @@ -184,7 +185,12 @@ static void pc_system_flash_map(PCMachineState *pcms,
>>>              if (i == 0) {
>>>                flash_mem = pflash_cfi01_get_memory(system_flash);
>>> -            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
>>> +            if (pcmc->isa_bios_alias) {
>>> +                x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem,
>>> +                                  true);
>>> +            } else {
>>> +                pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
>>> +            }
>>>                  /* Encrypt the pflash boot ROM */
>>>                if (sev_enabled()) {
>>


