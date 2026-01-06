Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352EFCE9D65
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Fj-0004XW-Fc; Tue, 06 Jan 2026 10:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vd9Fg-0004HZ-F8; Tue, 06 Jan 2026 10:45:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vd9Fd-00040t-4P; Tue, 06 Jan 2026 10:45:44 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwVD63sjzJ46k3;
 Tue,  6 Jan 2026 23:45:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 9BA9740570;
 Tue,  6 Jan 2026 23:45:26 +0800 (CST)
Received: from localhost (10.195.245.156) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 15:45:25 +0000
Date: Tue, 6 Jan 2026 15:45:22 +0000
To: <AlanoSong@163.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <cminyard@mvista.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <ani@anisinha.ca>,
 <pbonzini@redhat.com>, <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/virt: Add DesignWare I2C controller
Message-ID: <20260106154522.000046a6@huawei.com>
In-Reply-To: <20260106131253.16192-3-AlanoSong@163.com>
References: <20260106131253.16192-1-AlanoSong@163.com>
 <20260106131253.16192-3-AlanoSong@163.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.156]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  6 Jan 2026 21:12:53 +0800
AlanoSong@163.com wrote:

> From: Alano Song <AlanoSong@163.com>
> 
> Add DesignWare I2C controller onto virt board,
> and also an at24c eeprom for r/w operation.
> 
> Add these two devices into arm virt acpi table.
> 
> Confirmed with i2c-tools under v6.18 linux driver.
> 
Hi Alano,

> Signed-off-by: Alano Song <AlanoSong@163.com>

Perhaps a silly question but why do you want this on arm/virt?

I've been carrying a backed up version of the aspeed i2c but for
that we are using it with MCTP (I'm guessing this one isn't capable
enough) and devices on that are inherently discoverable unlike
normal I2C devices.  Even so I don't plan to upstream that as for
the CXL fabric stuff I can use MCTP over USB instead and don't
need to change arm/virt at all.

I'm not sure how useful an eeprom is beyond verifying your control emulation,
but perhaps that's all that is intended?


> ---
>  hw/arm/Kconfig           |  1 +
>  hw/arm/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  hw/arm/virt.c            | 38 +++++++++++++++++++++++++++++++++++++-
>  include/hw/arm/virt.h    |  1 +
>  4 files changed, 71 insertions(+), 1 deletion(-)

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 03b4342574..3d06356169 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -100,6 +100,34 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>      aml_append(scope, dev);
>  }
>  

An example of the AML blob would be useful in the patch description (or
the one updating the ACPI test tables).
I'd also expect a lot of bios test failures given you didn't change the
data files.  Run make check-qtest and see what blow up.

> +static void acpi_dsdt_add_i2c(Aml *scope, const MemMapEntry *i2c_memmap,
> +                               uint32_t i2c_irq)
> +{
> +    Aml *i2c_dev, *eprm_dev, *crs;
> +
> +    i2c_dev = aml_device("I2C0");
> +    aml_append(i2c_dev, aml_name_decl("_HID", aml_string("INT3433")));

That seems to be a valid intel PNP ID, but please add a reference to where it
came from (I'll guess the kernel driver rather than some document?)

> +    aml_append(i2c_dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_memory32_fixed(i2c_memmap->base,
> +                                       i2c_memmap->size, AML_READ_WRITE));
> +    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> +                                  AML_EXCLUSIVE, &i2c_irq, 1));
> +    aml_append(i2c_dev, aml_name_decl("_CRS", crs));
> +
> +    eprm_dev = aml_device("EPRM");
> +    aml_append(eprm_dev, aml_name_decl("_HID", aml_string("INT3499")));

Likewise, a reference for this PNP format ACPI ID would be good.

> +    aml_append(eprm_dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_i2c_serial_bus_device(0x50, "^"));

This is the bit that made me ask for a blob in the patch description.
I have very little idea what that actually does in AML :( (the "^"
in particular)

> +    aml_append(eprm_dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(i2c_dev, eprm_dev);
> +    aml_append(scope, i2c_dev);
> +}

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index fd0e28f030..8fd37126d1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -38,6 +38,8 @@
>  #include "hw/arm/boot.h"
>  #include "hw/arm/primecell.h"
>  #include "hw/arm/virt.h"
> +#include "hw/i2c/dw_i2c.h"
> +#include "hw/nvram/eeprom_at24c.h"
>  #include "hw/arm/machines-qom.h"
>  #include "hw/block/flash.h"
>  #include "hw/display/ramfb.h"
> @@ -193,7 +195,8 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
>      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> -    [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
> +    [VIRT_I2C] =                { 0x090c0000, 0x00001000 },
> +    [VIRT_ACPI_PCIHP] =         { 0x090d0000, ACPI_PCIHP_SIZE },

This breaks VM migration.  You need to put your new memory in a hole
in the memory map, not move things.

>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -245,6 +248,7 @@ static const int a15irqmap[] = {
>      [VIRT_GPIO] = 7,
>      [VIRT_UART1] = 8,
>      [VIRT_ACPI_GED] = 9,
> +    [VIRT_I2C] = 10,
>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> @@ -1016,6 +1020,36 @@ static void create_uart(const VirtMachineState *vms, int uart,
>      g_free(nodename);
>  }
>  
> +static void create_i2c(const VirtMachineState *vms, int i2c)
> +{
> +    char *nodename = NULL;

Always overridden so don't set initial value.  Maybe use a g_autofree
to avoid having to tidy it up on exit from the function. 

> +    hwaddr base = vms->memmap[i2c].base;
> +    hwaddr size = vms->memmap[i2c].size;
> +    int irq = vms->irqmap[i2c];
> +    MachineState *ms = MACHINE(vms);
> +    DeviceState *dev = sysbus_create_simple(TYPE_DW_I2C, base,
> +                                            qdev_get_gpio_in(vms->gic, irq));
> +    DWI2CState *s = DW_I2C(dev);
> +
> +    nodename = g_strdup_printf("/dw-i2c@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
> +                            "snps,designware-i2c");
> +    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
> +                                 2, base, 2, size);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +
> +    if (s && s->bus) {
> +        at24c_eeprom_init(s->bus, 0x50, 256);
> +    } else {
> +        fprintf(stderr, "Warning: DW I2C created but bus not available\n");
> +    }
> +
> +    g_free(nodename);
> +}


