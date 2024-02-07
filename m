Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232C7C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXhol-0006ms-VK; Wed, 07 Feb 2024 08:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhoj-0006h0-Sd
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:18:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhoi-0004bn-3y
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:18:21 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6849E4E601E;
 Wed,  7 Feb 2024 14:18:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id UtmF7b-j1Wu7; Wed,  7 Feb 2024 14:18:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 76BAB4E6006; Wed,  7 Feb 2024 14:18:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 755137456B4;
 Wed,  7 Feb 2024 14:18:16 +0100 (CET)
Date: Wed, 7 Feb 2024 14:18:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, shentey@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v2 8/8] mips: do not list individual devices from configs/
In-Reply-To: <20240207111411.115040-9-pbonzini@redhat.com>
Message-ID: <d218b1b0-3436-6120-55bc-f629ee1d667e@eik.bme.hu>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Wed, 7 Feb 2024, Paolo Bonzini wrote:
> Add new "select" and "imply" directives if needed.  The resulting
> config-devices.mak files are the same as before.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> configs/devices/mips-softmmu/common.mak      | 28 +++-----------------
> configs/devices/mips64el-softmmu/default.mak |  3 ---
> hw/mips/loongson3_virt.c                     |  5 ++--
> hw/display/Kconfig                           |  2 +-
> hw/mips/Kconfig                              | 20 +++++++++++++-
> 5 files changed, 27 insertions(+), 31 deletions(-)
>
> diff --git a/configs/devices/mips-softmmu/common.mak b/configs/devices/mips-softmmu/common.mak
> index 1a853841b27..416a5d353e8 100644
> --- a/configs/devices/mips-softmmu/common.mak
> +++ b/configs/devices/mips-softmmu/common.mak
> @@ -1,28 +1,8 @@
> # Common mips*-softmmu CONFIG defines
>
> -CONFIG_ISA_BUS=y
> -CONFIG_PCI=y
> -CONFIG_PCI_DEVICES=y
> -CONFIG_VGA_ISA=y
> -CONFIG_VGA_MMIO=y
> -CONFIG_VGA_CIRRUS=y
> -CONFIG_VMWARE_VGA=y
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
> -CONFIG_PARALLEL=y
> -CONFIG_I8254=y
> -CONFIG_PCSPK=y
> -CONFIG_PCKBD=y
> -CONFIG_FDC=y
> -CONFIG_I8257=y
> -CONFIG_IDE_ISA=y
> -CONFIG_PFLASH_CFI01=y
> -CONFIG_I8259=y
> -CONFIG_MC146818RTC=y
> -CONFIG_MIPS_CPS=y
> -CONFIG_MIPS_ITU=y
> +# Uncomment the following lines to disable these optional devices:
> +# CONFIG_PCI_DEVICES=n
> +# CONFIG_TEST_DEVICES=n
> +
> CONFIG_MALTA=y
> -CONFIG_PCNET_PCI=y
> CONFIG_MIPSSIM=y
> -CONFIG_SMBUS_EEPROM=y
> -CONFIG_TEST_DEVICES=y
> diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
> index d5188f7ea58..88a37cf27f1 100644
> --- a/configs/devices/mips64el-softmmu/default.mak
> +++ b/configs/devices/mips64el-softmmu/default.mak
> @@ -3,8 +3,5 @@
> include ../mips-softmmu/common.mak
> CONFIG_FULOONG=y
> CONFIG_LOONGSON3V=y
> -CONFIG_ATI_VGA=y
> -CONFIG_RTL8139_PCI=y
> CONFIG_JAZZ=y
> -CONFIG_VT82C686=y
> CONFIG_MIPS_BOSTON=y
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 33eae01eca2..da47af2fa71 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -447,8 +447,9 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>
>     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
>         pci_create_simple(pci_bus, -1, "pci-ohci");
> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> +        Object *usb_bus = object_resolve_path_type("", TYPE_USB_BUS, NULL);
> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
>     }
>
>     for (i = 0; i < nb_nics; i++) {

Is this hunk supposed to be in this patch?

Regards,
BALATON Zoltan

> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1aafe1923d2..5b2b3840f7a 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -55,7 +55,7 @@ config VGA_MMIO
>
> config VMWARE_VGA
>     bool
> -    default y if PCI_DEVICES && PC_PCI
> +    default y if PCI_DEVICES && (PC_PCI || MIPS)
>     depends on PCI
>     select VGA
>
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index e57db4f6412..5c83ef49cf6 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -1,8 +1,15 @@
> config MALTA
>     bool
> +    imply PCNET_PCI
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
>     select FDC37M81X
>     select GT64120
> +    select MIPS_CPS
>     select PIIX
> +    select PFLASH_CFI01
> +    select SERIAL
> +    select SMBUS_EEPROM
>
> config MIPSSIM
>     bool
> @@ -31,17 +38,26 @@ config JAZZ
>
> config FULOONG
>     bool
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
> +    imply ATI_VGA
> +    imply RTL8139_PCI
>     select PCI_BONITO
> +    select SMBUS_EEPROM
>     select VT82C686
>
> config LOONGSON3V
>     bool
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
> +    imply VIRTIO_PCI
> +    imply VIRTIO_NET
>     imply VIRTIO_VGA
>     imply QXL if SPICE
> +    imply USB_OHCI_PCI
>     select SERIAL
>     select GOLDFISH_RTC
>     select LOONGSON_LIOINTC
> -    select PCI_DEVICES
>     select PCI_EXPRESS_GENERIC_BRIDGE
>     select MSI_NONBROKEN
>     select FW_CFG_MIPS
> @@ -53,6 +69,8 @@ config MIPS_CPS
>
> config MIPS_BOSTON
>     bool
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
>     select FITLOADER
>     select MIPS_CPS
>     select PCI_EXPRESS_XILINX
>

