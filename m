Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACB4C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM8e-0002cZ-M6; Thu, 19 Jun 2025 16:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM8a-0002cJ-9V
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:45:32 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM8Y-0005wh-8o
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:45:32 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-606fdbd20afso2145177a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750365928; x=1750970728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9KnfJF0GtfeIHdBW4SWyFU7ou9KaMEmwL/RqGTeWJXw=;
 b=iCehuIQPOPz90EOGfPPdrnth1xWkVSpUDAcsfEpIFD7bpV6HtOyAJbqNjWO8jWWvpO
 G1YcFlCnpYu58FZl1eR4VyCPsLf10U8dVSu0oR4hR7jd92u0/Zq6x1ZEx5RE8ATLk4ge
 MzAqr3RcBXRsp4WUl8B5TpfT8vvySvtHJQsNrbLqZCjytPHhHM+Fu+vAUALbYIf1Elbx
 rKcf8phlmPHdZ8C3UCK99vlw+0kqUB6gpfBMzXBbT7hLjPELnHAlzopQSqCEu8erkHJu
 chRtt/fV1JlrXtEbn7Xfg9eGffJlFLjrZRIJpZ7pdxN0moAUt1S32E+T/ehoBHobjWks
 bDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365928; x=1750970728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9KnfJF0GtfeIHdBW4SWyFU7ou9KaMEmwL/RqGTeWJXw=;
 b=IUco5Vy+vuiiTMI80Z25wMG3aiDNYF5ZOEQrOpfrOC5vr7bqwmbtxQ7DRBtsXrJsce
 enn5SHMRT2Gi+9gYDl0sRM4jkodZtFWff0bWN/zvqbdonUaOpFLj+k5dYNuassvV5lZx
 eSzN6xfu5p/hhV7wCZuo8OqdxIxQXBf2T7ylpWC7SKN0NXAXjNOIdB2iaa6+niaozuFj
 dYEMyHzYwGDiDjpqtVQmNdjHC3e/45/v73nHyf2/zgf2+W6cIyTA/qClhlDt+++uY5nD
 +sLBQzPQXX58Y/GoVJI11UF3vkhhPhEP2TDbrMNSkL+RqUdf9XzHDVC+ORY5zTdtsMby
 T2GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWapT2LOlCmdh1ZjGpRD7OapZRmbGMUFjus5y6VrYQQ5pHR+D1kAadcdRuQEf6imKU92Z+6JNE1F6/C@nongnu.org
X-Gm-Message-State: AOJu0Yx2sRYwV3ZqqA/MUwPpEcl3N8i4rjxgs/rnbiN7xiBOWfKBdWSE
 Q78ldndjQx3ZXT6k4nGLyECI0NUcivO3iivn1piziDPlp19ckGtaFFrs+oQ9aIsGADw=
X-Gm-Gg: ASbGnctBzWb1x+mwZgfnwhtF7HqQ7QhvFdMOSMeo053h7Be3ZQgEmRhEf9ul60pep9l
 +efwywke5F8FT7UZHwcXwtr/C8RvVfoBUPulPTk13zF+xbAju0by/BjR+2U6bcEa5aL2oR9PhTN
 bDkDKZuvsWhoVJ6cxD36IPJ4slJoFWjpgC/ozsypcawEgeA56BLCglLpOQj5upn+bJ7AO0j6Czw
 We0wqG4S2kuF5vJdB+XP+9Sa8c43Px1ZSn1r+Ebd4h227bXZ87ejY556fyyiiXtmjFEzNId+dOj
 tA/wvPFK0pPGTCzfryd87BIfrug090kDmz5P/aDnhdJFAx0R+rKo9rC2rPfLMkYkS2qycmprtBw
 sMvSCPaic2EBUCij4SuhfL1BzdDZgl5wh1nRmadga
X-Google-Smtp-Source: AGHT+IGT9UyDDNlAJOJjp/+oOZ1YsoIA5AnyrnpD2H84Q6hMOQq2FmURD5ftiD8lwc3qtmAAtlHEiw==
X-Received: by 2002:a05:6402:4413:b0:602:b6fd:150a with SMTP id
 4fb4d7f45d1cf-60a1cf37333mr373208a12.33.1750365928250; 
 Thu, 19 Jun 2025 13:45:28 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a18c94746sm396606a12.38.2025.06.19.13.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:45:27 -0700 (PDT)
Message-ID: <9d6f2917-a56b-4064-835b-effbb2cbde01@linaro.org>
Date: Thu, 19 Jun 2025 22:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] hw/i386: move isapc machine to separate isapc.c
 file
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-13-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-13-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> Now that pc_init_isa() is independent of any PCI initialisation, move it into a
> separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
> I440FX in hw/i386/Kconfig.
> 
> Note that as part of the move to a separate file we can see that the licence text
> is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
> ("VL license of the day is MIT/BSD") so we can be sure that this was the original
> intent. As a consequence we can update the file header to use a SPDX tag as per
> the current project contribution guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/Kconfig     |   3 -
>   hw/i386/isapc.c     | 145 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/i386/meson.build |   1 +
>   hw/i386/pc_piix.c   | 117 -----------------------------------
>   4 files changed, 146 insertions(+), 120 deletions(-)
>   create mode 100644 hw/i386/isapc.c


> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> new file mode 100644
> index 0000000000..74ffd19307
> --- /dev/null
> +++ b/hw/i386/isapc.c
> @@ -0,0 +1,145 @@
> +/*
> + * QEMU PC System Emulator
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/char/parallel-isa.h"
> +#include "hw/dma/i8257.h"
> +#include "hw/loader.h"
> +#include "hw/i386/pc.h"
> +#include "hw/ide/isa.h"
> +#include "hw/ide/ide-bus.h"
> +#include "system/kvm.h"
> +#include "hw/i386/kvm/clock.h"
> +#include "hw/xen/xen-x86.h"
> +#include "system/xen.h"
> +#include "hw/rtc/mc146818rtc.h"
> +#include "target/i386/cpu.h"
> +
> +static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
> +static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
> +static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
> +
> +
> +static void pc_init_isa(MachineState *machine)
> +{
> +    PCMachineState *pcms = PC_MACHINE(machine);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    X86MachineState *x86ms = X86_MACHINE(machine);
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *system_io = get_system_io();
> +    ISABus *isa_bus;
> +    GSIState *gsi_state;
> +    MemoryRegion *ram_memory;
> +    MemoryRegion *rom_memory = system_memory;
> +    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> +    uint32_t irq;
> +    int i;
> +
> +    /*
> +     * There is no RAM split for the isapc machine
> +     */
> +    if (xen_enabled()) {
> +        xen_hvm_init_pc(pcms, &ram_memory);
> +    } else {
> +        ram_memory = machine->ram;
> +
> +        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
> +        x86ms->above_4g_mem_size = 0;
> +        x86ms->below_4g_mem_size = machine->ram_size;
> +    }
> +
> +    x86_cpus_init(x86ms, pcmc->default_cpu_version);

Should we check the CPU is 32-bit or is it OK to use 64-bit CPUs?

