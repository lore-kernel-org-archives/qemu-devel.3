Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C3C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJXJP-0006OU-IK; Tue, 18 Jun 2024 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXJM-0006OC-3Z
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:47:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXJK-0003Ol-Br
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:47:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4217d808034so47259915e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718711256; x=1719316056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gyWVYjqU/kSDHPvII+VjMQSDjmPWlMk5TFRwViXidxw=;
 b=oSCQDcbMcqh8+vwjRZN5aYM8NOW0K0lMW4bxYXjxrNy8XvJLd4dTTaSlc/mEmXFe7A
 LBuzyZaQwWsqQxxNg+SYYg0NWDrHVmBmjMnXjCxqaVueQTtT/Mk3Flsajvt3LFQ9n8wR
 rmqMOMgg7QL13MPev6lwnVKpv37SrbjLAL7rhATGQhQ5Tsp6lfsEM5FQThPXcszdfO85
 t4Gv4i1etY3onDQ1jIINELQGrUX24wLYq0fVi5SKkQJpOVBPH1B7YAqxcAFW78i1N03Q
 +Rnox0jar6Nw5m84vY3nLbV8Zt+D3LzcB5sat/QGahDnbmORDzbKTH+cF8E4uU06AnDL
 y3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711256; x=1719316056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gyWVYjqU/kSDHPvII+VjMQSDjmPWlMk5TFRwViXidxw=;
 b=XLwzbv7rb0/Vac0SI+TUtA5zgj0YSwZnOSwxslcouZmEaCbEvdQ12BjcqRUDxu6yQd
 6xNIvKEW1OqmIBfQ2HF85cLSxTEYQM9BDKjRG09NTxESrtsBC7lg9vfC8FNCZJ9eEClx
 flnlySdKbTY/0aU1orwQLTqCbp/0/the+nUHU8WU5F7OP4sH4FZ635hXaIJHUmzitbcq
 RAykAGPMKaCc0d5tbqsNJIKFNJevOdXnEMoyv4hrwT4BACK2ML2BJTEWnXC2ONnu0K3e
 45ZxOL+4ROqMuymWwjDJ2SCft0edTqNxhsUjU4OWglELRrSzD3x8YBpkfGsW3txYu3Ro
 tfXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+pYlp9xTfmNRU5OCKb2gj8cABM35nLV6mukIOzmBOjIYaexUZSxptL6RWc6AYrQRPhZ+iIjFQCop9s4sK2yWNUER5bNU=
X-Gm-Message-State: AOJu0Ywo9UaaN/C27UC19LC45+HTUe3cIQm2lAoiNShaa46wd74XCndk
 uJLb528ni8ssdMWYWsVGAFlf6I48zH8KoK+SDkR4qMzcwiBcUU3mhLCDNOwferE=
X-Google-Smtp-Source: AGHT+IGExoTvYZPCBrSWfTBdjp+uk7Z7Z/8gT5gfjw7bKD+trceDCWgbew9ErfYJ2DtsKjtAQANmuQ==
X-Received: by 2002:a05:600c:705:b0:424:6c83:a78e with SMTP id
 5b1f17b1804b1-4246c83a808mr28981545e9.40.1718711256565; 
 Tue, 18 Jun 2024 04:47:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602efdesm186806365e9.17.2024.06.18.04.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:47:36 -0700 (PDT)
Message-ID: <150942af-8727-4594-a817-c53c5bb8e04f@linaro.org>
Date: Tue, 18 Jun 2024 13:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/m68k/virt: Add a pflash controller for BIOS
 firmware
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
 <20240527-m68k-bios-v1-3-6de26552fa77@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527-m68k-bios-v1-3-6de26552fa77@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Jiaxun,

On 27/5/24 19:15, Jiaxun Yang wrote:
> Add a 8 MiB pflash controller for BIOS firmware, and boot
> from it if possible.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/m68k/Kconfig                                   |  1 +
>   hw/m68k/virt.c                                    | 44 +++++++++++++++++++++++
>   include/standard-headers/asm-m68k/bootinfo-virt.h |  1 +
>   3 files changed, 46 insertions(+)
> 
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index 4501da56ff6d..f233a5948f19 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -42,6 +42,7 @@ config M68K_VIRT
>       select M68K_IRQC
>       select FW_CFG_DMA
>       select VIRT_CTRL
> +    select PFLASH_CFI01
>       select GOLDFISH_PIC
>       select GOLDFISH_TTY
>       select GOLDFISH_RTC
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 7590e6515ac3..a2eebc0f2243 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/datadir.h"
>   #include "qemu/units.h"
>   #include "qemu/guest-random.h"
>   #include "sysemu/sysemu.h"
> @@ -28,6 +29,7 @@
>   #include "sysemu/runstate.h"
>   #include "sysemu/reset.h"
>   
> +#include "hw/block/flash.h"
>   #include "hw/intc/m68k_irqc.h"
>   #include "hw/misc/virt_ctrl.h"
>   #include "hw/char/goldfish_tty.h"
> @@ -97,6 +99,10 @@
>   #define VIRT_XHCI_MMIO_BASE 0xff020000    /* MMIO: 0xff020000 - 0xff023fff */
>   #define VIRT_XHCI_IRQ_BASE  PIC_IRQ(1, 2) /* PIC: #1, IRQ: #2 */
>   
> +#define VIRT_PFLASH_MMIO_BASE 0xff800000      /* MMIO: 0xff800000 - 0xffffffff */
> +#define VIRT_PFLASH_SIZE      0x800000        /* 8 MiB */

Do you need a real RW pflash or a ROM would be enough?

> +#define VIRT_PFLASH_SECTOR_SIZE (128 * KiB)   /* 64 KiB */
> +
>   typedef struct {
>       M68kCPU *cpu;
>       hwaddr initial_pc;
> @@ -139,6 +145,7 @@ static void virt_init(MachineState *machine)
>       const char *initrd_filename = machine->initrd_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       hwaddr parameters_base;
> +    DriveInfo *dinfo;
>       DeviceState *dev;
>       DeviceState *irqc_dev;
>       DeviceState *pic_dev[VIRT_GF_PIC_NB];
> @@ -165,6 +172,8 @@ static void virt_init(MachineState *machine)
>       cpu = M68K_CPU(cpu_create(machine->cpu_type));
>   
>       reset_info->cpu = cpu;
> +    reset_info->initial_pc = VIRT_PFLASH_MMIO_BASE;
> +    reset_info->initial_stack = ram_size;
>       qemu_register_reset(main_cpu_reset, reset_info);
>   
>       /* RAM */
> @@ -253,6 +262,39 @@ static void virt_init(MachineState *machine)
>                           PIC_GPIO(VIRT_XHCI_IRQ_BASE));
>       }
>   
> +    /* pflash */
> +    dinfo = drive_get(IF_PFLASH, 0, 0);
> +    pflash_cfi01_register(VIRT_PFLASH_MMIO_BASE,
> +                          "virt.pflash0",
> +                           VIRT_PFLASH_SIZE,
> +                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                           VIRT_PFLASH_SECTOR_SIZE, 4,
> +                           0x89, 0x18, 0, 0, 1);
> +
> +    if (machine->firmware) {
> +        char *fn;
> +        int image_size;
> +
> +        if (drive_get(IF_PFLASH, 0, 0)) {
> +            error_report("The contents of the first flash device may be "
> +                         "specified with -bios or with -drive if=pflash... "
> +                         "but you cannot use both options at once");
> +            exit(1);
> +        }
> +        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
> +        if (!fn) {
> +            error_report("Could not find ROM image '%s'", machine->firmware);
> +            exit(1);
> +        }
> +        image_size = load_image_targphys(fn, VIRT_PFLASH_MMIO_BASE,
> +                                         VIRT_PFLASH_SIZE);
> +        g_free(fn);
> +        if (image_size < 0) {
> +            error_report("Could not load ROM image '%s'", machine->firmware);
> +            exit(1);
> +        }
> +    }
> +
>       if (kernel_filename) {
>           CPUState *cs = CPU(cpu);
>           uint64_t high;
> @@ -311,6 +353,8 @@ static void virt_init(MachineState *machine)
>           }
>           BOOTINFO2(param_ptr, BI_VIRT_FW_CFG_BASE,
>                     VIRT_FW_CFG_MMIO_BASE, VIRT_FW_CFG_IRQ_BASE);
> +        BOOTINFO2(param_ptr, BI_VIRT_PFLASH_BASE,
> +                    VIRT_PFLASH_MMIO_BASE, 0);
>   
>           if (kernel_cmdline) {
>               BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
> diff --git a/include/standard-headers/asm-m68k/bootinfo-virt.h b/include/standard-headers/asm-m68k/bootinfo-virt.h
> index 7f90be1aa7bd..21c9a98d2912 100644
> --- a/include/standard-headers/asm-m68k/bootinfo-virt.h
> +++ b/include/standard-headers/asm-m68k/bootinfo-virt.h
> @@ -18,6 +18,7 @@
>   
>   #define BI_VIRT_XHCI_BASE	0x8007
>   #define BI_VIRT_FW_CFG_BASE	0x8008
> +#define BI_VIRT_PFLASH_BASE	0x8009
>   
>   #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
>   
> 


