Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10798C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ray38-0000PQ-TX; Fri, 16 Feb 2024 08:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ray31-0000KP-IW
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:14:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ray2x-0002mB-3B
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:14:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so1729184f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708089269; x=1708694069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UQW2XTOIXxEEpn1sQycYmvx33WMOBULqAV/EMMlI01o=;
 b=kHa5rl8WGdkbLLhiyugXWLxBteF2q8zfvcoOGmXl08QsuZt2Q/0eGSt8/INqWiNuBB
 7obZXhKlhIa8gPa0UtWKj72Wu3gQ6n9AhvL7g1qW9wgrgyZLdIOGWf4dB61XYkbYZrxC
 Nrt4w3CrhzuGeuLn6cX+mKVEBYv1wBNhGvroS7xIygsjOiFXJ0/lZykU6FAPs2Dor3Xh
 URJQKM8PvLUQ1BCVMcD9UPv2O2a0AOznJbUgugnsw3BP8e0l/PdX/niFND5ZOyTCZqOL
 VV/KMAiogiDQ2sZfRfw4Y/bvwJRKfrci64aTMhSdc5Lgot0lHIjBbXw9mYREl/V0DnM3
 iJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089269; x=1708694069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQW2XTOIXxEEpn1sQycYmvx33WMOBULqAV/EMMlI01o=;
 b=s3eSpJYyWE6UHHqEULHeQIYP051Um23jY8/fj7H1y7KzdcRyD8ZEe28NdRI05CL/Mq
 wP82XeXD+c4ck5b7gCFnVN+th5UQvbOu7dmJu8HGiqBrO7HkwtV3SOuE28JtJ9DAPLHF
 N/LpJh5yNkOx6o3X4I2cFfQQ3Lr+EhXIEWsHADG0Z809KrwmIihpvvsdkt6cmAnhLfKP
 COONHFapvvxreNLgGNSLZJlzPnCdnc9Ze2R6UombcxeRlITJsQgWbW10inzrI3GtFu2g
 nrSzngpphpOYY4Cy2K1yeCGmwAhWCemrM3YfssR45NI6OQk8nNIfm5RLy/+Y53Q9ThHh
 HGiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/GNCF/9SaeC252pznaUKY5MdCYZ9APco84cqJ1ln/XwK+2XLp1Adr0oo4zApjjiyX7yB62uDO7n2EdjLyK2x1wPul+BM=
X-Gm-Message-State: AOJu0YyUShpqHDGILzgy7r/HcAlwJVBUWbjnBASSnji009yLkyWthk6R
 AR7sVPv83niPKSKOOlXP8IgcMrwArVvkto5Rnfwf9/bdVivJ+X6EHNpujaE/rAY=
X-Google-Smtp-Source: AGHT+IGM9GJvAvpeIikXUhpgCit7dtIQ3MT61p1XzS97ahtKgrb3AYnH5XonfeiDsV5qaro8VSb3hw==
X-Received: by 2002:adf:efd2:0:b0:33d:201f:ea9d with SMTP id
 i18-20020adfefd2000000b0033d201fea9dmr1214769wrp.2.1708089268931; 
 Fri, 16 Feb 2024 05:14:28 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a05600c378a00b0040fdc7f4fcdsm2262733wmr.4.2024.02.16.05.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 05:14:28 -0800 (PST)
Message-ID: <9dcd14bf-6ccd-4ed5-91c2-f0af96774b8c@linaro.org>
Date: Fri, 16 Feb 2024 14:14:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Add ivshmem-flat device
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: thuth@redhat.com
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
 <20231127052024.435743-2-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127052024.435743-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 27/11/23 06:20, Gustavo Romero wrote:
> Add a new device, ivshmem-flat, which is similar to the ivshmem PCI but
> does not require a PCI bus. It's meant to be used on machines like those
> with Cortex-M MCUs, which usually lack a PCI/PCIe bus, e.g. lm3s6965evb
> and mps2-an385.
> 
> The device currently only supports the sysbus bus.
> 
> The following is an example on how to create the ivshmem-flat device on
> a Stellaris machine:
> 
> $ qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic
>                    -net none -chardev stdio,id=con,mux=on
>                    -serial chardev:con -mon chardev=con,mode=readline
>                    -chardev socket,path=/tmp/ivshmem_socket,id=ivf
>                    -device ivshmem-flat,x-irq-qompath=/machine/unattached/device[1]/nvic/unnamed-gpio-in[0],x-bus-qompath="/sysbus",chardev=ivf
>                    -kernel zephyr_qemu.elf
> 
> The new device, just like the ivshmem PCI device, supports both peer
> notification via hardware interrupts and shared memory.
> 
> The IRQ QOM path for the target machine can be determined by creating
> the VM without the ivshmem-flat device, going to the QEMU console and
> listing the QOM nodes with 'info qom-tree'. In the Stellaris example
> above the input IRQ is in the NVIC IC.
> 
> The MMRs for status and control (notification) are mapped to the MMIO
> region at 0x400FF000 (default), whilst the shared memory region start
> is mapped at addr. 0x40100000 (default), but both addresses can be set
> when creating the device by using 'x-bus-address-{mmr,shmem}' options,
> respectively.
> 
> The device shared memory size can be set using the 'shmem-size' option
> and it defaults to 4 MiB, which is the default size of shmem allocated
> by the ivshmem server.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   docs/system/devices/ivshmem-flat.rst |  89 +++++
>   hw/arm/mps2.c                        |   2 +
>   hw/arm/stellaris.c                   |   5 +-
>   hw/arm/virt.c                        |   2 +
>   hw/core/sysbus-fdt.c                 |   1 +
>   hw/misc/Kconfig                      |   5 +
>   hw/misc/ivshmem-flat.c               | 477 +++++++++++++++++++++++++++
>   hw/misc/meson.build                  |   2 +
>   hw/misc/trace-events                 |  18 +
>   include/hw/misc/ivshmem-flat.h       |  72 ++++
>   10 files changed, 672 insertions(+), 1 deletion(-)
>   create mode 100644 docs/system/devices/ivshmem-flat.rst
>   create mode 100644 hw/misc/ivshmem-flat.c
>   create mode 100644 include/hw/misc/ivshmem-flat.h


> diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
> new file mode 100644
> index 0000000000..2f6f7462f6
> --- /dev/null
> +++ b/include/hw/misc/ivshmem-flat.h
> @@ -0,0 +1,72 @@
> +/*
> + * Inter-VM Shared Memory Flat Device
> + *
> + * SPDX-FileCopyrightText: 2023 Linaro Ltd.
> + * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef IVSHMEM_FLAT_H
> +#define IVSHMEM_FLAT_H
> +

I had to include the following headers:

  #include "qemu/queue.h"
  #include "qemu/event_notifier.h"
  #include "chardev/char-fe.h"
  #include "exec/memory.h"
  #include "qom/object.h"
  #include "hw/sysbus.h"

in order to fix:

include/hw/misc/ivshmem-flat.h:50:19: error: field has incomplete type 
'EventNotifier' (aka 'struct EventNotifier')
     EventNotifier event_notifier;
                   ^
include/hw/misc/ivshmem-flat.h:55:5: error: type name requires a 
specifier or qualifier
     QTAILQ_ENTRY(IvshmemPeer) next;
     ^
include/hw/misc/ivshmem-flat.h:62:5: error: unknown type name 'SysBusDevice'
     SysBusDevice parent_obj;
     ^
include/hw/misc/ivshmem-flat.h:70:5: error: unknown type name 'CharBackend'
     CharBackend server_chr;
     ^
include/hw/misc/ivshmem-flat.h:76:18: error: field has incomplete type 
'MemoryRegion' (aka 'struct MemoryRegion')
     MemoryRegion iomem;
                  ^

> +#define IVSHMEM_MAX_VECTOR_NUM 64
> +
> +#define TYPE_IVSHMEM_FLAT "ivshmem-flat"
> +typedef struct IvshmemFTState IvshmemFTState;
> +
> +DECLARE_INSTANCE_CHECKER(IvshmemFTState, IVSHMEM_FLAT, TYPE_IVSHMEM_FLAT)
> +
> +/* Ivshmem registers. See ./docs/specs/ivshmem-spec.txt for details. */
> +enum ivshmem_registers {
> +    INTMASK = 0,
> +    INTSTATUS = 4,
> +    IVPOSITION = 8,
> +    DOORBELL = 12,
> +};
> +
> +typedef struct VectorInfo {
> +    EventNotifier event_notifier;
> +    uint16_t id;
> +} VectorInfo;
> +
> +typedef struct IvshmemPeer {
> +    QTAILQ_ENTRY(IvshmemPeer) next;
> +    VectorInfo vector[IVSHMEM_MAX_VECTOR_NUM];
> +    int vector_counter;
> +    uint16_t id;
> +} IvshmemPeer;
> +
> +struct IvshmemFTState {
> +    SysBusDevice parent_obj;
> +
> +    uint64_t msg_buf;
> +    int msg_buffered_bytes;
> +
> +    QTAILQ_HEAD(, IvshmemPeer) peer;
> +    IvshmemPeer own;
> +
> +    CharBackend server_chr;
> +
> +    char *bus_qompath;
> +
> +    /* IRQ */
> +    qemu_irq irq;
> +    char *irq_qompath;
> +
> +    /* MMRs */
> +    MemoryRegion iomem;
> +    uint64_t bus_address_mmr;
> +    uint32_t intmask;
> +    uint32_t intstatus;
> +    uint32_t ivposition;
> +    uint32_t doorbell;
> +
> +    /* Shared memory */
> +    MemoryRegion shmem;
> +    int shmem_fd;
> +    uint32_t shmem_size;
> +    uint64_t bus_address_shmem;
> +};
> +
> +#endif /* IVSHMEM_FLAT_H */


