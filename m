Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A81C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 11:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riuyQ-00078j-Vy; Sat, 09 Mar 2024 06:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1riuyP-00078S-Lh; Sat, 09 Mar 2024 06:34:41 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1riuyN-0006UD-J3; Sat, 09 Mar 2024 06:34:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D12C54E6005;
 Sat,  9 Mar 2024 12:34:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id V839Bh-F5IYA; Sat,  9 Mar 2024 12:34:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D81494E6004; Sat,  9 Mar 2024 12:34:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D68F47456B4;
 Sat,  9 Mar 2024 12:34:30 +0100 (CET)
Date: Sat, 9 Mar 2024 12:34:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Subject: Re: [PATCH] hw/ppc/sam460ex: Support short options for adding drives
In-Reply-To: <20240305225721.E9A404E6005@zero.eik.bme.hu>
Message-ID: <894f71b9-8e03-7459-1946-c95d24efee72@eik.bme.hu>
References: <20240305225721.E9A404E6005@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024, BALATON Zoltan wrote:
> Having to use -drive if=none,... and -device ide-[cd,hd] is
> inconvenient. Add support for shorter convenience options such as
> -cdrom and -drive media=disk. Also adjust two nearby comments for code
> style.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Ping for freeze? (Forgot to cc qemu-ppc, now adding that too.)

> ---
> hw/ppc/sam460ex.c | 24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 7e34b6c5e0..d42b677898 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -33,6 +33,7 @@
> #include "hw/char/serial.h"
> #include "hw/i2c/ppc4xx_i2c.h"
> #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/ide/pci.h"
> #include "hw/usb/hcd-ehci.h"
> #include "hw/ppc/fdt.h"
> #include "hw/qdev-properties.h"
> @@ -449,15 +450,27 @@ static void sam460ex_init(MachineState *machine)
>
>     /* PCI devices */
>     pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
> -    /* SoC has a single SATA port but we don't emulate that yet
> +    /*
> +     * SoC has a single SATA port but we don't emulate that
>      * However, firmware and usual clients have driver for SiI311x
> -     * so add one for convenience by default */
> +     * PCI SATA card so add one for convenience by default
> +     */
>     if (defaults_enabled()) {
> -        pci_create_simple(pci_bus, -1, "sii3112");
> +        PCIIDEState *s = PCI_IDE(pci_create_simple(pci_bus, -1, "sii3112"));
> +        DriveInfo *di;
> +
> +        di = drive_get_by_index(IF_IDE, 0);
> +        if (di) {
> +            ide_bus_create_drive(&s->bus[0], 0, di);
> +        }
> +        /* Use index 2 only if 1 does not exist, this allows -cdrom */
> +        di = drive_get_by_index(IF_IDE, 1) ?: drive_get_by_index(IF_IDE, 2);
> +        if (di) {
> +            ide_bus_create_drive(&s->bus[1], 0, di);
> +        }
>     }
>
> -    /* SoC has 4 UARTs
> -     * but board has only one wired and two are present in fdt */
> +    /* SoC has 4 UARTs but board has only one wired and two described in fdt */
>     if (serial_hd(0) != NULL) {
>         serial_mm_init(get_system_memory(), 0x4ef600300, 0,
>                        qdev_get_gpio_in(uic[1], 1),
> @@ -531,6 +544,7 @@ static void sam460ex_machine_init(MachineClass *mc)
> {
>     mc->desc = "aCube Sam460ex";
>     mc->init = sam460ex_init;
> +    mc->block_default_type = IF_IDE;
>     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
>     mc->default_ram_size = 512 * MiB;
>     mc->default_ram_id = "ppc4xx.sdram";
>

