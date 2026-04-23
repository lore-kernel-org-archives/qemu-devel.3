Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2F5F99352
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFpRa-0001XK-Mm; Thu, 23 Apr 2026 04:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFpRN-0001Rr-L1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 04:29:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFpRJ-0000IT-Fo
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 04:29:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso65001565e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776932971; x=1777537771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rqdt7Bo2oFXEve1DJk/ovGu1uZWS/576QDHhaKpVuH4=;
 b=STCvsAtjqQd0d4zYUcGv/rgU2j27/y/3z7AHquauT06pODJTQ5M3hMXMmXymCnLE+i
 9amqUnWX4R6Bx7YAh5xiQK+NddrASK+stybQ5iyEmoZo4OeuD7BxJpG7aS0agAn0xC5y
 A8EX7c0/xf/jTNx3SMKYsQ8FxmWO69qaX46PpaRcON6kREE95HJDqLe/nScJC4Y0pdbA
 FGfyXTUvQO4ZvqJ58enJKKYksJwzwkrRsbani/rTNvVRe3I+GnSmtA0fAT2aIXhfAS9L
 9zkxL3RKhOhY73vSoWupWK9QYqu84IWrs/AhHQD6pU+d1FDPSzZucVyjCLCn7YJWCleZ
 HuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776932971; x=1777537771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rqdt7Bo2oFXEve1DJk/ovGu1uZWS/576QDHhaKpVuH4=;
 b=XD0fG6NuVHEgfXKqdeh8XqWX5KYJMWYJNj3OyffXZXvWGMUCLzLLhfM7ugv/h1XJE1
 RI3gQCH/DIcZnQQrh3mDZK4ZX71AKE0NUD2VQshM5SsR59BzI5l3539hrkdvWEAVVpvx
 kkTY1WFTS93A0cPqNaYg59A8ws8nxKmI8jk30j7KqZ0wkUy7bdDYb+99ZBBS/p9pshL1
 FCppnNOqWkMuzg9FXvsmxZBh44R9inE3rn6Udqq8RMYSppjBY6BdCyhqOPYKO+9x1cXw
 2tSJou4xaulxJulUFjQOi9ul60DeQ0DXwzN6HY9MHzoRnMYZjC54dS+lxdtMUce3pOAm
 vk1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BsMZBDWikF9CI9HbKqDCw9box/LfmFt+J49ONT5badQr4mGINCbOvpc70gAzXkf+a/5jYspYx1sbw@nongnu.org
X-Gm-Message-State: AOJu0YzhnMnmfeZI4zh0ArlM33ptaHY4vjYzUCrew47YANnqW1LAB45i
 wRqOACJm0qKwgtf3Rb5geO6JiNUne14cn24/1LhvNw54Bu/U1edsUCQvn4JfYukCoDQ=
X-Gm-Gg: AeBDietTxbL44lpnuN4NX/7mJbqsWV6Sc4DuyieCHxsvyPR0TeViu5FsOGsztUsBetX
 n89BheiOmOHC0w14ND2CYrBBjSf5XWaf768Z75nrYWOTfrlguSy2P1Sj7y6faB5x5qQzzEzbNVC
 FemzyFHTZhe4FWbEW0cn+/76Xqgb05Tkynqeob/sHdbN/1r64HEvVTtoWGBu0gngisJDkhK5Uh6
 BXNXFS3R8woHMOAmR/L0P19MFSz3mJS3rIUU8vr9ecEKyGBXMOADpxQOt7VS6XhuLaaDAl9ZGiS
 wPhG3y6Uls8FzQEzC5tHao2W5ru1MbO9Weonmx204lvz7HjEjuzPJfEQmJ91wLaXRjZoZO2c6/0
 hRHMqewmVu/RbP3WemxKKHBUbvD6m/45zpwEP1OHfLIAzarERd83AxilASrJxKZ+FG8aGMhQnaS
 +9dbkt+M5z4YSyaZm+2QwrmPmXPE0VoO2sAFG8Bzq5DHP7LgHm9hR5zldgAwHTzujQMbLAVWeT9
 3rD
X-Received: by 2002:a05:600d:8499:20b0:48a:5f32:62c6 with SMTP id
 5b1f17b1804b1-48a5f3263d4mr17584105e9.11.1776932971218; 
 Thu, 23 Apr 2026 01:29:31 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm53092336f8f.35.2026.04.23.01.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 01:29:30 -0700 (PDT)
Message-ID: <7550fc2d-b497-47f5-8ce6-ad920bda4146@linaro.org>
Date: Thu, 23 Apr 2026 10:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] hw/riscv/boot: Provide a simple halting payload
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-5-joel@jms.id.au>
 <71de5fac-7d75-4640-ad16-2707520c53b7@linaro.org>
 <CACPK8Xd6+8Fw_rhPJhZ8jY7yiEp6CjnnDH2T5hkEUaYd+TNXiQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CACPK8Xd6+8Fw_rhPJhZ8jY7yiEp6CjnnDH2T5hkEUaYd+TNXiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/4/26 04:04, Joel Stanley wrote:
> On Tue, 21 Apr 2026 at 15:48, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 21/4/26 07:31, Joel Stanley wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> OpenSBI hangs before any console output if the domain init code sees the
>>> next stage is not in an executable region.
>>>
>>> If no kernel payload is provided to QEMU, the next stage address is
>>> NULL, and the riscv virt machine memory map ends up covering the 0
>>> address with the catch all S-mode RWX region and so OpenSBI prints
>>> console messages and does not hang until the next stage boot.
>>>
>>> The soon to be added Tenstorrent Atlantis board address map has RAM
>>> starting at 0 and it loads OpenSBI there, so it is M-mode and not
>>> accessible by S-mode, tripping the early check and hang.
>>>
>>> Add a helper to set up a simple payload that gets OpenSBI messages
>>> to console.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>> v3: MachineState argument was unused
>>> ---
>>>    include/hw/riscv/boot.h |  1 +
>>>    hw/riscv/boot.c         | 20 ++++++++++++++++++++
>>>    2 files changed, 21 insertions(+)
>>>
>>> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
>>> index fb90bf12399e..a1eb377474b9 100644
>>> --- a/include/hw/riscv/boot.h
>>> +++ b/include/hw/riscv/boot.h
>>> @@ -78,6 +78,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
>>>                                   hwaddr rom_base, hwaddr rom_size,
>>>                                   uint64_t kernel_entry,
>>>                                   uint64_t fdt_load_addr);
>>> +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr);
>>>    void riscv_rom_copy_firmware_info(MachineState *machine,
>>>                                      RISCVHartArrayState *harts,
>>>                                      hwaddr rom_base,
>>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>>> index 3ea95c175c14..3a97fd1441f7 100644
>>> --- a/hw/riscv/boot.c
>>> +++ b/hw/riscv/boot.c
>>> @@ -518,6 +518,26 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
>>>                                     kernel_entry);
>>>    }
>>>
>>> +/* Simple payload so OpenSBI does not hang early with no output */
>>> +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr)
>>> +{
>>> +    int i;
>>> +    uint32_t payload_vec[] = {
>>
>> static const?
> 
> This gets written to below, but I think we can do this:
> 
> static const uint32_t payload_vec[] = {
>    const_le32(0x10500073),
>    const_le32(0xffdff06f)
> };

Yes you read my mind ;)

(i.e. 
https://lore.kernel.org/qemu-devel/20221222215549.86872-3-philmd@linaro.org/)

> 
>>
>>> +        0x10500073,                     /* 1: wfi           */
>>> +        0xffdff06f,                     /* j       1b       */
>>> +    };
>>> +    /* copy in the payload vector in little_endian byte order */
>>> +    for (i = 0; i < ARRAY_SIZE(payload_vec); i++) {
>>> +        payload_vec[i] = cpu_to_le32(payload_vec[i]);
>>> +    }
>>> +    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
>>> +                          addr, &address_space_memory);
>>> +
>>> +    info->kernel_size = sizeof(payload_vec);
>>> +    info->image_low_addr = addr;
>>> +    info->image_high_addr = info->image_low_addr + info->kernel_size;
>>> +}
>>


