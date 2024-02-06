Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CCCC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 19:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXR0w-0007Zn-6z; Tue, 06 Feb 2024 14:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXR0r-0007ZQ-Iq
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:21:46 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXR0g-0003Hm-P0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:21:44 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3832ef7726so108414266b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707247292; x=1707852092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zeN2GYndT3rYVw9aH89oXBvwvMJv6cZWW3iXWW8pX5k=;
 b=I9Gksr6WNeViBH6DLfaHtdo9cTHkwNxSZVW/YrBvxFNGuw4tjGNN2GhC3uj/L//kki
 IOg07JIR8ic8n9vBkuVTYv5LZ9ZACbILfFPHQd++YQZZ9lgwCcKiEYctUnoZQi6QtBtY
 nsZZRWbTygqpvY3RxCnnqDfxX9XGYFueWh+aCoT/3gr6I3sewAaYS0Cg3yH2syyGaB1c
 pkuB8Ag+CBnzWGSyM0nFRFKmhpVWRBJKGP8j88gBtmzVX6PGU35N1f6mE4e2r+j4NOvP
 OOxxmuwnTabKmwY7muXkWPZd2RLbsMaNdGFaSKgS2LBf5bmlQZZJnNgS2aDffen7zDZ1
 I4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707247292; x=1707852092;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zeN2GYndT3rYVw9aH89oXBvwvMJv6cZWW3iXWW8pX5k=;
 b=ftj+YWMHmCfPfJPHR2is1MF3pG9nXfiPrUcYR077KChmPt4jRt1ESe06DKzgGi2fYc
 wy1qI43a4GYqxb3G0uxcPr6gatkK/JV5HGWdJmCrzPufw/GX9D5gdu6h3+H6ikyfPFo7
 3Z9tGRgrFCLOChcRphhYrz/N4eSU2/1yDyvLeDifoyQWiE1T8SBKfOmUnWW6m8YYZ0ZQ
 yNEo8nLG5apUfiFYCiYH7BbnLytnrnvD/f2iCzU8/fZT0BB9XCDlRgcFzUL+5i4qJ1DT
 4nwelPqkOCPM1repCeACZvre0p4BZu+RY7wkiLJ+PNy2Rk/oquZkxnYvDonv8pOr8AEF
 5VFA==
X-Gm-Message-State: AOJu0Ywq8J8mhlnqcKYVw8CZmEDfRD//nD+t9xovFslN2rHIGMga19Z3
 qsCLtO3JEtx59NIjrGgngp0NTYf0atshF4xul44glvTk8sHiOgv2yhVSZLWibo0=
X-Google-Smtp-Source: AGHT+IG98qDgq7+Amex4wWejS8pPOgRolNQjxxTzpJQe5P33LtQlXOu8C59jZ+9jkMfUoA9BWBNUvQ==
X-Received: by 2002:a17:907:7da0:b0:a37:f6aa:99fb with SMTP id
 oz32-20020a1709077da000b00a37f6aa99fbmr3043794ejc.54.1707247291855; 
 Tue, 06 Feb 2024 11:21:31 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXRoeYGsxyvTzDoG96sZz7AOmTBkrYQxRIiIQcavE58ZpZq+LpjrS39UK4PtOydX8KD3mpHMXs5ROCauu4loig0ZVAiYgbnK6A5yhaQeHbAbbnJ535oMBUlD2Y=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a1709060e4b00b00a36cc8c1bcbsm1468476eji.173.2024.02.06.11.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 11:21:31 -0800 (PST)
Message-ID: <30da5b3b-6b4c-4639-b630-c02e1664821c@linaro.org>
Date: Tue, 6 Feb 2024 20:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/arm/mps3r: Initial skeleton for mps3-an536 board
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Peter,

On 6/2/24 14:29, Peter Maydell wrote:
> The AN536 is another FPGA image for the MPS3 development board. Unlike
> the existing FPGA images we already model, this board uses a Cortex-R
> family CPU, and it does not use any equivalent to the M-profile
> "Subsystem for Embedded" SoC-equivalent that we model in hw/arm/armsse.c.
> It's therefore more convenient for us to model it as a completely
> separate C file.
> 
> This commit adds the basic skeleton of the board model, and the
> code to create all the RAM and ROM. We assume that we're probably
> going to want to add more images in future, so use the same
> base class/subclass setup that mps2-tz.c uses, even though at
> the moment there's only a single subclass.
> 
> Following commits will add the CPUs and the peripherals.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |   3 +-
>   configs/devices/arm-softmmu/default.mak |   1 +
>   hw/arm/mps3r.c                          | 239 ++++++++++++++++++++++++
>   hw/arm/Kconfig                          |   5 +
>   hw/arm/meson.build                      |   1 +
>   5 files changed, 248 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/mps3r.c


> +static MemoryRegion *mr_for_raminfo(MPS3RMachineState *mms,
> +                                    const RAMInfo *raminfo)
> +{
> +    /* Return an initialized MemoryRegion for the RAMInfo. */
> +    MemoryRegion *ram;
> +
> +    if (raminfo->mrindex < 0) {
> +        /* Means this RAMInfo is for QEMU's "system memory" */
> +        MachineState *machine = MACHINE(mms);
> +        assert(!(raminfo->flags & IS_ROM));
> +        return machine->ram;
> +    }
> +
> +    assert(raminfo->mrindex < MPS3R_RAM_MAX);
> +    ram = &mms->ram[raminfo->mrindex];
> +
> +    memory_region_init_ram(ram, NULL, raminfo->name,

You are not using the parent=mms, is that deliberate?
(as in: easier to migrate eventually?)

> +                           raminfo->size, &error_fatal);
> +    if (raminfo->flags & IS_ROM) {
> +        memory_region_set_readonly(ram, true);
> +    }
> +    return ram;
> +}

