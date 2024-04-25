Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C9AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztOL-0004N3-0Q; Thu, 25 Apr 2024 03:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rztOJ-0004Mq-1Q
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:19:35 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rztOH-0001Y5-Bk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:19:34 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso114486066b.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714029570; x=1714634370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bvr+7vBnokuzFRKMkvufFwUQkzSJ7NtoaaYjJ2wVyE8=;
 b=Yhf6MvXXjQDqAxVQKH+WyPAi/jtDMpESYRgSOmP8dSJ/OZwwWsETSdOzIJOzfqvDfU
 ZLze46xviiu6RL6HdksguL+aVVSTceoOXtZn8crn33QByYxviatjgmme0AyvASB6qRIH
 84TKWw7UhlqgpqcVTiqviNVT9reboTC21TV09opOHflsQQObrNkzCYT8X1P+QsBHlKeM
 ziu/Ky3IDnQYSe0qAGBHHbOcFN+l1CmTPhXHjZVl7SkY67XyJMs0asN/oDPC+WUjPfDj
 XnjiAhQcKcgdueXg80nmX9gdHvSwCqRq+rZ+G3RqPdgIEBA8e7UWz3fyRX57tET1b/1F
 krdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714029570; x=1714634370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bvr+7vBnokuzFRKMkvufFwUQkzSJ7NtoaaYjJ2wVyE8=;
 b=IGSnO8pVeoKnZ7PiR9VGhe2PSRHn1JB5U5M+aluwuLAkX5yqcJKWTPOnH7ET+PFRCt
 gZ613HD1LK+gdpZaZyyXhxqndNO8DVVd2LWHRAa10MufhsIWB9VPNp0CtuWOBX421t+C
 myo777mG04akElzKIdsfzCD/glQ64Z8cwogBXErS43HZr/eodw2jXDPV+asu+UGmgl8o
 Nws2EGetEkqXZaCfkC85npISuWc6DmdpudssMM7RaYUyVuCjav6JN6BbSR2O5B2Gybze
 maXVWM6rCIdg0zIr6XpJhD53eZLhbHWTGLPPC4HP3vUcEeUrxxEtek14dd5mjAqJnHXG
 BERQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeAzX1x0lkL2ieS6K8+7ZB3GJyBz9LG3Z4CTyIia4+1cO1/k2pcLajsr1MdkYVwNk9PKSpMfZvTicjAL6uULGmZ00Acrg=
X-Gm-Message-State: AOJu0YyLqQugjtGxzZpA/WYvzutFAMmMpMtrc9GE0scsSBt57GNYFj7t
 qAEiIKOlUIxMx/WnAFjIbZXSsImPBWz4hsCMIV4aMEmbLwu1V+Kpln3sV4lK2doxaZblLXx2Ux0
 v
X-Google-Smtp-Source: AGHT+IH3jUzxqJ0yzGazLcXBsSyHHQ4ts5NxpiOAILjntaHM2x3rJGAh+XfrUMmrziadH7UmDplASg==
X-Received: by 2002:a17:906:b283:b0:a55:9574:48a6 with SMTP id
 q3-20020a170906b28300b00a55957448a6mr2043233ejz.30.1714029570207; 
 Thu, 25 Apr 2024 00:19:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.201])
 by smtp.gmail.com with ESMTPSA id
 h26-20020a17090619da00b00a588729de82sm2330590ejd.142.2024.04.25.00.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 00:19:29 -0700 (PDT)
Message-ID: <dc0ccf20-fa3f-4882-a179-17798ebe5106@linaro.org>
Date: Thu, 25 Apr 2024 09:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/i386: Consolidate isa-bios creation
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
 <20240422200625.2768-5-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422200625.2768-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Hi Bernhard,

On 22/4/24 22:06, Bernhard Beschow wrote:
> Now that the -bios and -pflash code paths work the same it is possible to have a
> common implementation.
> 
> While at it convert the magic number 0x100000 (== 1MiB) to increase readability.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/x86.h |  2 ++
>   hw/i386/pc_sysfw.c    | 28 ++++------------------------
>   hw/i386/x86.c         | 29 ++++++++++++++++++-----------
>   3 files changed, 24 insertions(+), 35 deletions(-)


> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 6e89671c26..e529182b48 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -28,7 +28,6 @@
>   #include "sysemu/block-backend.h"
>   #include "qemu/error-report.h"
>   #include "qemu/option.h"
> -#include "qemu/units.h"
>   #include "hw/sysbus.h"
>   #include "hw/i386/x86.h"
>   #include "hw/i386/pc.h"
> @@ -40,27 +39,6 @@
>   
>   #define FLASH_SECTOR_SIZE 4096
>   
> -static void pc_isa_bios_init(MemoryRegion *rom_memory,
> -                             MemoryRegion *flash_mem)
> -{
> -    int isa_bios_size;
> -    MemoryRegion *isa_bios;
> -    uint64_t flash_size;
> -
> -    flash_size = memory_region_size(flash_mem);
> -
> -    /* map the last 128KB of the BIOS in ISA space */
> -    isa_bios_size = MIN(flash_size, 128 * KiB);
> -    isa_bios = g_malloc(sizeof(*isa_bios));
> -    memory_region_init_alias(isa_bios, NULL, "isa-bios", flash_mem,
> -                             flash_size - isa_bios_size, isa_bios_size);
> -    memory_region_add_subregion_overlap(rom_memory,
> -                                        0x100000 - isa_bios_size,
> -                                        isa_bios,
> -                                        1);
> -    memory_region_set_readonly(isa_bios, true);
> -}


> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 32cd22a4a8..7366b0cee4 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -1136,13 +1136,28 @@ void x86_load_linux(X86MachineState *x86ms,
>       nb_option_roms++;
>   }
>   
> +void x86_isa_bios_init(MemoryRegion *rom_memory, MemoryRegion *bios,
> +                       bool isapc_ram_fw)
> +{
> +    int bios_size = memory_region_size(bios);
> +    int isa_bios_size = MIN(bios_size, 128 * KiB);
> +    MemoryRegion *isa_bios;
> +
> +    isa_bios = g_malloc(sizeof(*isa_bios));

Pre-existing, but we shouldn't leak MR like that.

Probably better to pass pre-allocated as argument,
smth like:

   /**
    * x86_isa_bios_init: ... at fixed addr ...
    * @isa_bios: MR to initialize
    * @isa_mr: ISA bus
    * @bios: BIOS MR to map on ISA bus
    * @read_only: Map the BIOS as read-only
    */
   void x86_isa_bios_init(MemoryRegion *isa_bios,
                          const MemoryRegion *isa_mr,
                          const MemoryRegion *bios,
                          bool read_only);

> +    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
> +                             bios_size - isa_bios_size, isa_bios_size);
> +    memory_region_add_subregion_overlap(rom_memory, 1 * MiB - isa_bios_size,
> +                                        isa_bios, 1);
> +    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
> +}


