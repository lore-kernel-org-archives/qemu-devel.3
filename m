Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C7CC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskeG-00048o-K7; Thu, 13 Mar 2025 11:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tskeF-00048Z-OR
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:39:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tskeD-0004Lx-TC
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:39:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223959039f4so24139635ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741880340; x=1742485140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10s1kh6LxDeEKRR1+yf4kN8vq+idkH6USo34XE6tcOE=;
 b=XuDi0qhEIUp7Xa5fxYgSbcDq4BtgEHOswFSofOYNOPdkMUWPpX6Gmvdjm3NAsxH/1M
 h13J3iZuGK5na0pjrrLe3/8w4xgXc6vVU8bGpRdJjzii3Vb6hi3AEDgu92L4FAzHwZ0H
 E8tWkPALTx6CVR/Zw6Gq5uTGtugVj+pp/mgbZpYKyE6IESGkIAd1k7xywN5l3KoieAV9
 Vt7F1FYJXiFgE6pquIO4iCtvfJd+T13CUi/4YJALIk+frkJPT4w+2peGbEXf7e7lReu4
 9rtc9FAF44Tqc+QTI2EoLrIWNZwYRI8KLHu/p9mc/PcvqPH+AXe2w89xCyogCCG7/tmf
 A72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741880340; x=1742485140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10s1kh6LxDeEKRR1+yf4kN8vq+idkH6USo34XE6tcOE=;
 b=MZX76ol35Xe2k8jCYRWsNd8s5oGjo7TNyV0rXETSowY0H+uamJZuZ3IM/8bry0ifUi
 UR24dwaRUezFBt6tBNDAeIJVapxyTdm4M694g1vrC9faqkOGNKTaaLPwd4y71aoVZmxG
 61UEZb6teR1WElif4N4/8XSEonEcaojj3/6bMl1E/MGm/bSTXHKyjlxHtJJtaSNtzq7H
 ZvMHJDBntEAwxXoZJGhllMvwBIzmfP7NX5l59BnccAzYE0AeYM0pr8H/FOajuhUqFlve
 srIlaVY6mO01vNQ0hB0JbPXYt9s7JuTHO1XGMStS5b2Be95YUNClGxsYpOjpwBIER946
 RZhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQMYo5o2N7LFgaHwZD7DFRAhbO8wg8QKvvOqQcogdriMFnKEM8dFjOvVdU2eZ0ILs4/iADaytS4ID5@nongnu.org
X-Gm-Message-State: AOJu0YxxMVelx/3I3Opt2KCG8jG9rgv5nGOQKAbrBVbR6TkPUPVUtgdB
 GaB5hK7bOTkcAVriImO2csy0Mou+867QnitosoSneVC0lNcyz28HrJvGO9jg9h0=
X-Gm-Gg: ASbGnctIWqeU9KnUZ3sHi/SC0b45f1Wnhn00TMvIdpie0Z480Y3f9dJmzYpXSRmV1uU
 smnWETMG3gIp9IFVrF1ACksUaAwMC78w80/CUnATh1oE/z87noGDAHZfpIMAtrpfDPXHSwol3hI
 3dmLe9P8W6C1rc+k4aIiqw9tf3yMrsauCLpnkwuXCy5V0WHwwzc1wWypT/pBx0tczZf+y/WDGLm
 +UNsxzEcSZLo6+u+9mfa94tjE8Ed1AVV1mHtTHBkoZLosz/XvVmW7CFCAXKN8aLFFqbMQmJDM/S
 hOmO9xseaj8ocy4Hz9bkVsWqnv65l8UyLeAmD1/9zJokfcq2rdB1hcQQlJPoKzPrgPb8Fg==
X-Google-Smtp-Source: AGHT+IEwUYYWYC1thHsGouISnY/KWxKKz+p3kkTBarBYkJGdgPdqfR5sJaGdgQfycn6ePhORaNkH2A==
X-Received: by 2002:a17:902:fc4c:b0:21f:7077:2aaf with SMTP id
 d9443c01a7336-22428bf1715mr463473935ad.44.1741880339624; 
 Thu, 13 Mar 2025 08:38:59 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba70f3sm14698555ad.157.2025.03.13.08.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 08:38:59 -0700 (PDT)
Message-ID: <85cb962d-7e18-4c4d-b056-f543df778555@ventanamicro.com>
Date: Thu, 13 Mar 2025 12:38:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/riscv: Allow direct start of kernel for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair23@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
 <20250225005446.13894-5-sebastian.huber@embedded-brains.de>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250225005446.13894-5-sebastian.huber@embedded-brains.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 2/24/25 9:54 PM, Sebastian Huber wrote:
> Further customize the -bios and -kernel options behaviour for the
> microchip-icicle-kit machine.  If "-bios none -kernel filename" is
> specified, then do not load a firmware and instead only load and start
> the kernel image.
> 
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>   hw/riscv/microchip_pfsoc.c | 57 ++++++++++++++++++++++++++------------
>   1 file changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 844dc0545c..df902c8667 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -578,29 +578,45 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>       }
>   
>       /*
> -     * We follow the following table to select which payload we execute.
> +     * We follow the following table to select which firmware we use.
>        *
> -     *  -bios |    -kernel | payload
> -     * -------+------------+--------
> -     *      N |          N | HSS
> -     *      Y | don't care | HSS
> -     *      N |          Y | kernel
> -     *
> -     * This ensures backwards compatibility with how we used to expose -bios
> -     * to users but allows them to run through direct kernel booting as well.
> +     * -bios         | -kernel    | firmware
> +     * --------------+------------+--------
> +     * none          |          N | error
> +     * none          |          Y | kernel
> +     * NULL, default |          N | BIOS_FILENAME


This change is breaking the following test:

---------

$ QTEST_QEMU_BINARY=./build/qemu-system-riscv64 ./build/tests/qtest/qom-test
(...)
# slow test /riscv64/qom/amd-microblaze-v-generic executed in 2.28 secs
# starting QEMU: exec ./build/qemu-system-riscv64 -qtest unix:/tmp/qtest-1361875.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1361875.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine microchip-icicle-kit -accel qtest
**
ERROR:../hw/riscv/boot.c:164:riscv_load_firmware: assertion failed: (firmware_filename != NULL)
Bail out! ERROR:../hw/riscv/boot.c:164:riscv_load_firmware: assertion failed: (firmware_filename != NULL)
Broken pipe

---------

The reason is that, with the default machine settings (no -bios and no -kernel
options), firmware_name is now defaulted to BIOS_FILENAME (hss.bin). But we're not
distributing 'hss.bin' in pc-bios:

$ ls pc-bios/ |  grep hss
$

Then, in the following code, 'filename' will be NULL and riscv_load_firmware() will
g_assert():


> +    if (firmware_name) {
> +        const char *filename = riscv_find_firmware(firmware_name, NULL);
> +        firmware_end_addr = riscv_load_firmware(filename, &firmware_load_addr,
> +                                                NULL);
> +    }


Possible solutions:

- package hss.bin in QEMU so it can be used as a default firmware;

- redo the logic to allow the board to run (even if inactive) with absent
-bios and -kernel to allow QEMU model tests to run.



Thanks,

Daniel

> +     * NULL, default |          Y | RISCV64_BIOS_BIN
> +     * other         | don't care | other
>        */
> +    if (machine->firmware && !strcmp(machine->firmware, "none")) {
> +        if (!machine->kernel_filename) {
> +            error_report("for -bios none, a kernel is required");
> +            exit(1);
> +        }
>   
> -    if (machine->kernel_filename) {
> -        firmware_name = RISCV64_BIOS_BIN;
> -        firmware_load_addr = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> +        firmware_name = NULL;
> +        firmware_load_addr = RESET_VECTOR;
> +    } else if (!machine->firmware || !strcmp(machine->firmware, "default")) {
> +        if (machine->kernel_filename) {
> +            firmware_name = RISCV64_BIOS_BIN;
> +            firmware_load_addr = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> +        } else {
> +            firmware_name = BIOS_FILENAME;
> +            firmware_load_addr = RESET_VECTOR;
> +        }
>       } else {
> -        firmware_name = BIOS_FILENAME;
> +        firmware_name = machine->firmware;
>           firmware_load_addr = RESET_VECTOR;
>       }
>   
> -    /* Load the firmware */
> -    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
> -                                                     &firmware_load_addr, NULL);
> +    /* Load the firmware if necessary */
> +    if (firmware_name) {
> +        const char *filename = riscv_find_firmware(firmware_name, NULL);
> +        firmware_end_addr = riscv_load_firmware(filename, &firmware_load_addr,
> +                                                NULL);
> +    } else {
> +        firmware_end_addr = firmware_load_addr;
> +    }
>   
>       riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
>       if (machine->kernel_filename) {
> @@ -638,8 +654,15 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>               fdt_load_addr = 0;
>           }
>   
> +        hwaddr start_addr;
> +        if (firmware_name) {
> +            start_addr = firmware_load_addr;
> +        } else {
> +            start_addr = kernel_entry;
> +        }
> +
>           /* Load the reset vector */
> -        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load_addr,
> +        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, start_addr,
>                                     memmap[MICROCHIP_PFSOC_ENVM_DATA].base,
>                                     memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
>                                     kernel_entry, fdt_load_addr);


