Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C26CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjaU-00004v-M5; Tue, 12 May 2026 05:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMjaR-0008PQ-M0
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:35 -0400
Received: from smtpout3.mo533.mail-out.ovh.net ([46.105.35.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMjaM-00051G-Kz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:35 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gFBPn3hPGz60NF;
 Tue, 12 May 2026 09:39:25 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 12 May 2026 09:39:25 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.169])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gFBPn2pmVz1y2p; Tue, 12 May 2026 09:39:25 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A94C212E3553;
 Tue, 12 May 2026 09:39:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0023abb1609-697b-48f9-8c91-1b67f30bd685,
 39874C6F3F9F68F15966500C6FBBDB0B53A96BD7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <089c31b4-d592-495c-90dd-ced4ce363423@kaod.org>
Date: Tue, 12 May 2026 11:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/arm: Remove fby35 machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Peter Delevoryas <me@pjd.dev>
References: <20260510165704.2935316-1-clg@redhat.com>
 <20260510165704.2935316-5-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260510165704.2935316-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17675784113802882072
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE+EFz5kuWMPEZMStzQ06eaGYUmTGuM9u3FbnDXH9T1PsyzZ2WIaOzQG/M3sNIAZ6S1qxsWRiYQWTcE50yYm/YJgR+AB6FR2BXYORYFvZiTOeECIs3btAI9xSn1/WzGhPBUkEfOgv5a5he8ENy24VHWpJK5yUpuzdrM6I+jm4kGTcSkVZTMRGzxYkGnN0nLuEoTPTD00idyzuwQYib23G+RMGhPb0EmfEMjD0pf3okDKpLZ2hmGHksuOxVaECZ7mJcVdUK+tO5QnbB3jD/lTp4Q/SwVdX2cwkAMg6Hn2oCyFBU+tJ0CNQDgO3e22++UmWkdzLcxNn1S/3dvSUelgFYbKzy9Fmrvkx8l4R62210mENiKpQR9fFSAFbQ2ebuIHFhmn/7B4eBkjuk/AWjjWhEZHXwED8S7XHLK4TujQh9ktA3msgFGPtBSynPZEyIciHOh/qynax3RkHI/7zvtOy7ZfbH1PVMXU9YkHlrjdG0+yVQ6uzy5tMA9qXcSSj+H5F+m+hnRaBHfvolMmuDh50kuGPnen59f6ADsKEATR0CpHxu80bcvspp2lZLJRIlEGkXVVYy+pA5TRM9LSRseTBV6VsxcEBlZWQO0FGA3r7hsKF0hLY8/fy1eMi26AgLgTlI3x3fLEC92cxPOQAMt6OSv/xc1kubE/WJQe1+Fyxf2EA
DKIM-Signature: a=rsa-sha256; bh=w1CLMt/UpNfzst7NJL7R+R4XHVrprNvr2LW6Tm+3V7c=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778578767; v=1;
 b=fcq/sIgD42htaNKpLiUcIaUmm39NRZqYkN7Ia1iCslZiw1RdzKkmNePetQ5BBbWjbwccALEC
 oaRpnIZiG2kGVxO+rPa7ZWZtzMDpl8YP4xgR5cS3TujZwRZfH+GkHTzuX8qpogKjhCaqtomvKxL
 mzo38j8tSOtVvr+Zd5vcuMfNYz5TJZkF7l+ZildtIyaNaQHkAB//hJkea4ICnbRVcOch2xIoSRP
 MuPRGPjHxgAeYshG76L3yOYNxrUQIKROakK1njqUXs0phWUPdu73JjkGyZUXsg9nyCCxKn/n2MD
 Pdc9aCQTuI8Fo4cxNkEjSuiySJycGreb654mJixrrS6VA==
Received-SPF: pass client-ip=46.105.35.92; envelope-from=clg@kaod.org;
 helo=smtpout3.mo533.mail-out.ovh.net
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

Hi,

+ Peter for awareness. Forgot to add you, sorry about that.

It would be nice to have an Ack for this removal.

Thanks,

C.

On 5/10/26 18:57, Cédric Le Goater wrote:
> The fby35 machine was deprecated in QEMU 10.2 and is now removed in
> QEMU 11.1.
> 
> This multi-SoC machine was added as an example of heterogeneous
> systems, but the models never evolved and no public firmware is
> available to boot it. Users needing multi-SoC emulation should use the
> ast2700fc machine instead, which is based on newer AST2700 SoCs with
> better support.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS                     |   2 -
>   docs/about/deprecated.rst       |  10 --
>   docs/about/removed-features.rst |  10 ++
>   docs/system/arm/fby35.rst       |  52 --------
>   docs/system/target-arm.rst      |   1 -
>   hw/arm/fby35.c                  | 203 --------------------------------
>   hw/arm/meson.build              |   3 +-
>   7 files changed, 11 insertions(+), 270 deletions(-)
>   delete mode 100644 docs/system/arm/fby35.rst
>   delete mode 100644 hw/arm/fby35.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3d64595370..14c8fe0da402 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1276,12 +1276,10 @@ F: include/hw/*/*aspeed*
>   F: hw/net/ftgmac100.c
>   F: include/hw/net/ftgmac100.h
>   F: docs/system/arm/aspeed.rst
> -F: docs/system/arm/fby35.rst
>   F: docs/specs/aspeed*
>   F: tests/functional/*/*aspeed*
>   F: tests/*/*aspeed*
>   F: tests/*/*ast2700*
> -F: hw/arm/fby35.c
>   F: pc-bios/ast27x0_bootrom.bin
>   F: roms/vbootrom
>   
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e416f3d8a74b..bf6182d61c6e 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -250,16 +250,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>   better reflects the way this property affects all random data within
>   the device tree blob, not just the ``kaslr-seed`` node.
>   
> -Arm ``fby35`` machine (since 10.2)
> -''''''''''''''''''''''''''''''''''
> -
> -The ``fby35`` machine was originally added as an example of a
> -multi-SoC system, with the expectation the models would evolve over
> -time in an heterogeneous system. This hasn't happened and no public
> -firmware is available to boot it. It can be replaced by the
> -``ast2700fc``, another multi-SoC machine based on the newer AST2700
> -SoCs which are excepted to receive better support in the future.
> -
>   
>   RISC-V default machine option (since 10.0)
>   ''''''''''''''''''''''''''''''''''''''''''
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 2da8283d0e1e..9bd83b183f46 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1213,6 +1213,16 @@ models, it can be replaced by the ``ast2500-evb`` machine using the
>   ``fmc-model`` option to specify the flash type. The I2C devices
>   connected to the board can be defined via the QEMU command line.
>   
> +Arm ``fby35`` machine (removed in 11.1)
> +'''''''''''''''''''''''''''''''''''''''
> +
> +The ``fby35`` machine was originally added as an example of a
> +multi-SoC system, with the expectation the models would evolve over
> +time in an heterogeneous system. This hasn't happened and no public
> +firmware is available to boot it. It can be replaced by the
> +``ast2700fc``, another multi-SoC machine based on the newer AST2700
> +SoCs which are excepted to receive better support in the future.
> +
>   linux-user mode CPUs
>   --------------------
>   
> diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
> deleted file mode 100644
> index e19274e75c81..000000000000
> --- a/docs/system/arm/fby35.rst
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -Facebook Yosemite v3.5 Platform and CraterLake Server (``fby35``)
> -==================================================================
> -
> -Facebook has a series of multi-node compute server designs named
> -Yosemite. The most recent version released was
> -`Yosemite v3 <https://www.opencompute.org/documents/ocp-yosemite-v3-platform-design-specification-1v16-pdf>`__.
> -
> -Yosemite v3.5 is an iteration on this design, and is very similar: there's a
> -baseboard with a BMC, and 4 server slots. The new server board design termed
> -"CraterLake" includes a Bridge IC (BIC), with room for expansion boards to
> -include various compute accelerators (video, inferencing, etc). At the moment,
> -only the first server slot's BIC is included.
> -
> -Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
> -can be fit into a chassis. See `here <https://www.opencompute.org/products-chiplets/237/wiwynn-yosemite-v3-server>`__
> -for an example.
> -
> -In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC
> -runs `OpenBMC <https://github.com/facebook/openbmc>`__, and the BIC runs
> -`OpenBIC <https://github.com/facebook/openbic>`__.
> -
> -Firmware images can be retrieved from the Github releases or built from the
> -source code, see the README's for instructions on that. This image uses the
> -"fby35" machine recipe from OpenBMC, and the "yv35-cl" target from OpenBIC.
> -Some reference images can also be found here:
> -
> -.. code-block:: bash
> -
> -    $ wget https://github.com/facebook/openbmc/releases/download/openbmc-e2294ff5d31d/fby35.mtd
> -    $ wget https://github.com/peterdelevoryas/OpenBIC/releases/download/oby35-cl-2022.13.01/Y35BCL.elf
> -
> -Since this machine has multiple SoC's, each with their own serial console, the
> -recommended way to run it is to allocate a pseudoterminal for each serial
> -console and let the monitor use stdio. Also, starting in a paused state is
> -useful because it allows you to attach to the pseudoterminals before the boot
> -process starts.
> -
> -.. code-block:: bash
> -
> -    $ qemu-system-arm -machine fby35 \
> -        -drive file=fby35.mtd,format=raw,if=mtd \
> -        -device loader,file=Y35BCL.elf,addr=0,cpu-num=2 \
> -        -serial pty -serial pty -serial mon:stdio \
> -        -display none -S
> -    $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
> -    $ screen /dev/tty1
> -    $ (qemu) c		   # Start the boot process once screen is setup.
> -
> -This machine model supports emulation of the boot from the CE0 flash device by
> -setting option ``execute-in-place``. When using this option, the CPU fetches
> -instructions to execute by reading CE0 and not from a preloaded ROM
> -initialized at machine init time. As a result, execution will be slower.
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index c57102a4149f..e34492402f0a 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -87,7 +87,6 @@ Board-specific documentation
>      arm/cubieboard
>      arm/emcraft-sf2
>      arm/exynos
> -   arm/fby35
>      arm/musicpal
>      arm/kzm
>      arm/nrf
> diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
> deleted file mode 100644
> index d3bfd2c7d26a..000000000000
> --- a/hw/arm/fby35.c
> +++ /dev/null
> @@ -1,203 +0,0 @@
> -/*
> - * Copyright (c) Meta Platforms, Inc. and affiliates. (http://www.meta.com)
> - *
> - * This code is licensed under the GPL version 2 or later. See the COPYING
> - * file in the top-level directory.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/units.h"
> -#include "qapi/error.h"
> -#include "system/system.h"
> -#include "system/block-backend.h"
> -#include "hw/core/boards.h"
> -#include "hw/core/qdev-clock.h"
> -#include "hw/arm/aspeed_soc.h"
> -#include "hw/arm/boot.h"
> -#include "hw/arm/machines-qom.h"
> -
> -#define TYPE_FBY35 MACHINE_TYPE_NAME("fby35")
> -OBJECT_DECLARE_SIMPLE_TYPE(Fby35State, FBY35);
> -
> -struct Fby35State {
> -    MachineState parent_obj;
> -
> -    MemoryRegion bmc_memory;
> -    MemoryRegion bmc_dram;
> -    MemoryRegion bmc_boot_rom;
> -    MemoryRegion bic_memory;
> -    Clock *bic_sysclk;
> -
> -    Aspeed2600SoCState bmc;
> -    Aspeed10x0SoCState bic;
> -
> -    bool mmio_exec;
> -};
> -
> -#define FBY35_BMC_RAM_SIZE (2 * GiB)
> -#define FBY35_BMC_FIRMWARE_ADDR 0x0
> -
> -static void fby35_bmc_write_boot_rom(DriveInfo *dinfo, MemoryRegion *mr,
> -                                     hwaddr offset, size_t rom_size,
> -                                     Error **errp)
> -{
> -    BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
> -    g_autofree void *storage = NULL;
> -    int64_t size;
> -
> -    /*
> -     * The block backend size should have already been 'validated' by
> -     * the creation of the m25p80 object.
> -     */
> -    size = blk_getlength(blk);
> -    if (size <= 0) {
> -        error_setg(errp, "failed to get flash size");
> -        return;
> -    }
> -
> -    if (rom_size > size) {
> -        rom_size = size;
> -    }
> -
> -    storage = g_malloc0(rom_size);
> -    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
> -        error_setg(errp, "failed to read the initial flash content");
> -        return;
> -    }
> -
> -    /* TODO: find a better way to install the ROM */
> -    memcpy(memory_region_get_ram_ptr(mr) + offset, storage, rom_size);
> -}
> -
> -static void fby35_bmc_init(Fby35State *s)
> -{
> -    AspeedSoCState *soc;
> -    AspeedSoCClass *sc;
> -
> -    object_initialize_child(OBJECT(s), "bmc", &s->bmc, "ast2600-a3");
> -    soc = ASPEED_SOC(&s->bmc);
> -    sc = ASPEED_SOC_GET_CLASS(soc);
> -
> -    memory_region_init(&s->bmc_memory, OBJECT(&s->bmc), "bmc-memory",
> -                       UINT64_MAX);
> -    memory_region_add_subregion(get_system_memory(), 0, &s->bmc_memory);
> -    memory_region_init_ram(&s->bmc_dram, OBJECT(&s->bmc), "bmc-dram",
> -                           FBY35_BMC_RAM_SIZE, &error_abort);
> -
> -    object_property_set_int(OBJECT(&s->bmc), "ram-size", FBY35_BMC_RAM_SIZE,
> -                            &error_abort);
> -    object_property_set_link(OBJECT(&s->bmc), "memory", OBJECT(&s->bmc_memory),
> -                             &error_abort);
> -    object_property_set_link(OBJECT(&s->bmc), "dram", OBJECT(&s->bmc_dram),
> -                             &error_abort);
> -    object_property_set_int(OBJECT(&s->bmc), "hw-strap1", 0x000000C0,
> -                            &error_abort);
> -    object_property_set_int(OBJECT(&s->bmc), "hw-strap2", 0x00000003,
> -                            &error_abort);
> -    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_base,
> -                            sc->uarts_num, serial_hd(0));
> -    qdev_realize(DEVICE(&s->bmc), NULL, &error_abort);
> -
> -    aspeed_board_init_flashes(&soc->fmc, "n25q00", 2, 0);
> -
> -    /* Install first FMC flash content as a boot rom. */
> -    if (!s->mmio_exec) {
> -        DriveInfo *mtd0 = drive_get(IF_MTD, 0, 0);
> -
> -        if (mtd0) {
> -            uint64_t rom_size = memory_region_size(&soc->spi_boot);
> -
> -            memory_region_init_rom(&s->bmc_boot_rom, NULL, "aspeed.boot_rom",
> -                                   rom_size, &error_abort);
> -            memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
> -                                                &s->bmc_boot_rom, 1);
> -
> -            fby35_bmc_write_boot_rom(mtd0, &s->bmc_boot_rom,
> -                                     FBY35_BMC_FIRMWARE_ADDR,
> -                                     rom_size, &error_abort);
> -        }
> -    }
> -}
> -
> -static void fby35_bic_init(Fby35State *s)
> -{
> -    AspeedSoCState *soc;
> -    AspeedSoCClass *sc;
> -
> -    s->bic_sysclk = clock_new(OBJECT(s), "SYSCLK");
> -    clock_set_hz(s->bic_sysclk, 200000000ULL);
> -
> -    object_initialize_child(OBJECT(s), "bic", &s->bic, "ast1030-a1");
> -    soc = ASPEED_SOC(&s->bic);
> -    sc = ASPEED_SOC_GET_CLASS(soc);
> -
> -    memory_region_init(&s->bic_memory, OBJECT(&s->bic), "bic-memory",
> -                       UINT64_MAX);
> -
> -    qdev_connect_clock_in(DEVICE(&s->bic), "sysclk", s->bic_sysclk);
> -    object_property_set_link(OBJECT(&s->bic), "memory", OBJECT(&s->bic_memory),
> -                             &error_abort);
> -    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_base,
> -                            sc->uarts_num, serial_hd(1));
> -    qdev_realize(DEVICE(&s->bic), NULL, &error_abort);
> -
> -    aspeed_board_init_flashes(&soc->fmc, "sst25vf032b", 2, 2);
> -    aspeed_board_init_flashes(&soc->spi[0], "sst25vf032b", 2, 4);
> -    aspeed_board_init_flashes(&soc->spi[1], "sst25vf032b", 2, 6);
> -}
> -
> -static void fby35_init(MachineState *machine)
> -{
> -    Fby35State *s = FBY35(machine);
> -
> -    fby35_bmc_init(s);
> -    fby35_bic_init(s);
> -}
> -
> -
> -static bool fby35_get_mmio_exec(Object *obj, Error **errp)
> -{
> -    return FBY35(obj)->mmio_exec;
> -}
> -
> -static void fby35_set_mmio_exec(Object *obj, bool value, Error **errp)
> -{
> -    FBY35(obj)->mmio_exec = value;
> -}
> -
> -static void fby35_instance_init(Object *obj)
> -{
> -    FBY35(obj)->mmio_exec = false;
> -}
> -
> -static void fby35_class_init(ObjectClass *oc, const void *data)
> -{
> -    MachineClass *mc = MACHINE_CLASS(oc);
> -
> -    mc->desc = "Meta Platforms fby35";
> -    mc->deprecation_reason = "For a multi-soc machine, use 'ast2700fc' instead";
> -    mc->init = fby35_init;
> -    mc->no_floppy = 1;
> -    mc->no_cdrom = 1;
> -    mc->auto_create_sdcard = true;
> -    mc->min_cpus = mc->max_cpus = mc->default_cpus = 3;
> -
> -    object_class_property_add_bool(oc, "execute-in-place",
> -                                   fby35_get_mmio_exec,
> -                                   fby35_set_mmio_exec);
> -    object_class_property_set_description(oc, "execute-in-place",
> -                           "boot directly from CE0 flash device");
> -}
> -
> -static const TypeInfo fby35_types[] = {
> -    {
> -        .name = MACHINE_TYPE_NAME("fby35"),
> -        .parent = TYPE_MACHINE,
> -        .class_init = fby35_class_init,
> -        .instance_size = sizeof(Fby35State),
> -        .instance_init = fby35_instance_init,
> -        .interfaces = arm_machine_interfaces,
> -    },
> -};
> -
> -DEFINE_TYPES(fby35_types);
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 063abf2cf654..80068f70bb9c 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -62,8 +62,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_ast2600_gb200nvl.c',
>     'aspeed_ast2600_rainier.c',
>     'aspeed_ast10x0.c',
> -  'aspeed_ast10x0_evb.c',
> -  'fby35.c'))
> +  'aspeed_ast10x0_evb.c'))
>   arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
>     'aspeed_ast1700.c',
>     'aspeed_ast27x0.c',


