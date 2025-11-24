Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5EECFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 13:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNX3H-0005Gg-V1; Mon, 24 Nov 2025 08:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vNX39-0005AW-UX
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:56:17 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vNX36-00043B-I6
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:56:15 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F1625969F6;
 Mon, 24 Nov 2025 14:56:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id d0wat7bi0so9; Mon, 24 Nov 2025 14:56:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7A80B5969F7; Mon, 24 Nov 2025 14:56:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7880D5969F4;
 Mon, 24 Nov 2025 14:56:05 +0100 (CET)
Date: Mon, 24 Nov 2025 14:56:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-for-11.0 2/2] hw/pci: Rename PCIDeviceClass::exit() ->
 PCIDeviceClass::unrealize()
In-Reply-To: <20251124103244.78932-3-philmd@linaro.org>
Message-ID: <9f13fc0a-c5d8-3e73-0ec9-a6d3498888ce@eik.bme.hu>
References: <20251124103244.78932-1-philmd@linaro.org>
 <20251124103244.78932-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1542710788-1763992565=:46144"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1542710788-1763992565=:46144
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 24 Nov 2025, Philippe Mathieu-Daudé wrote:
> Commit 7ee6c1e182c ("pci: Permit incremental conversion of
> device models to realize") renamed:
>
>  PCIDeviceClass::init() -> PCIDeviceClass::realize()
>
> Finish the conversion by renaming the counter part
>
>  PCIDeviceClass::exit() PCIDeviceClass::unrealize()
>
> This clarifies the handler is called during the DeviceUnrealize
> path, not during Object destruction in instance_finalize().
>
> Manual change adapting style when needed.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/pci/pci.h                |  1 -
> include/hw/pci/pci_device.h         |  3 ++-
> hw/audio/ac97.c                     |  8 ++++----
> hw/audio/es1370.c                   |  8 ++++----
> hw/audio/intel-hda.c                |  8 ++++----
> hw/audio/via-ac97.c                 |  4 ++--
> hw/char/diva-gsp.c                  |  6 +++---
> hw/char/serial-pci-multi.c          |  8 ++++----
> hw/char/serial-pci.c                |  4 ++--
> hw/cxl/switch-mailbox-cci.c         |  4 ++--
> hw/display/ati.c                    |  8 ++++----
> hw/display/bochs-display.c          |  4 ++--
> hw/display/vga-pci.c                |  4 ++--
> hw/ide/cmd646.c                     |  4 ++--
> hw/ide/ich.c                        |  4 ++--
> hw/ide/piix.c                       |  6 +++---
> hw/ide/via.c                        |  4 ++--
> hw/mem/cxl_type3.c                  |  4 ++--
> hw/misc/edu.c                       |  4 ++--
> hw/misc/ivshmem-pci.c               |  4 ++--
> hw/misc/pci-testdev.c               |  5 ++---
> hw/net/can/can_kvaser_pci.c         |  4 ++--
> hw/net/can/can_mioe3680_pci.c       |  4 ++--
> hw/net/can/can_pcm3680_pci.c        |  4 ++--
> hw/net/can/ctucan_pci.c             |  4 ++--
> hw/net/e1000.c                      |  5 ++---
> hw/net/e1000e.c                     |  4 ++--
> hw/net/eepro100.c                   |  8 ++++----
> hw/net/igb.c                        |  4 ++--
> hw/net/igbvf.c                      |  4 ++--
> hw/net/ne2000-pci.c                 |  4 ++--
> hw/net/pcnet-pci.c                  |  4 ++--
> hw/net/rocker/rocker.c              |  4 ++--
> hw/net/rtl8139.c                    |  4 ++--
> hw/net/sungem.c                     |  4 ++--
> hw/net/tulip.c                      |  4 ++--
> hw/net/vmxnet3.c                    |  4 ++--
> hw/nvme/ctrl.c                      |  4 ++--
> hw/pci-bridge/cxl_downstream.c      |  4 ++--
> hw/pci-bridge/cxl_root_port.c       |  2 +-
> hw/pci-bridge/cxl_upstream.c        |  4 ++--
> hw/pci-bridge/gen_pcie_root_port.c  |  2 +-
> hw/pci-bridge/pci_bridge_dev.c      |  4 ++--
> hw/pci-bridge/pci_expander_bridge.c |  8 ++++----
> hw/pci-bridge/pcie_pci_bridge.c     |  4 ++--
> hw/pci-bridge/pcie_root_port.c      |  4 ++--
> hw/pci-bridge/simba.c               |  2 +-
> hw/pci-bridge/xio3130_downstream.c  |  4 ++--
> hw/pci-bridge/xio3130_upstream.c    |  4 ++--
> hw/pci-host/designware.c            |  2 +-
> hw/pci-host/xilinx-pcie.c           |  2 +-
> hw/pci/pci.c                        |  4 ++--
> hw/remote/proxy.c                   |  4 ++--
> hw/riscv/riscv-iommu-pci.c          |  4 ++--
> hw/scsi/esp-pci.c                   |  4 ++--
> hw/scsi/lsi53c895a.c                |  4 ++--
> hw/scsi/megasas.c                   |  4 ++--
> hw/scsi/mptsas.c                    |  4 ++--
> hw/scsi/vmw_pvscsi.c                | 10 ++++------
> hw/sd/sdhci-pci.c                   |  4 ++--
> hw/ufs/ufs.c                        |  4 ++--
> hw/usb/hcd-ehci-pci.c               |  4 ++--
> hw/usb/hcd-ohci-pci.c               |  8 ++++----
> hw/usb/hcd-uhci.c                   |  4 ++--
> hw/usb/hcd-xhci-pci.c               |  4 ++--
> hw/vfio/pci.c                       |  4 ++--
> hw/virtio/virtio-pci.c              |  4 ++--
> hw/watchdog/wdt_i6300esb.c          |  4 ++--
> hw/xen/xen_pt.c                     |  4 ++--
> 69 files changed, 151 insertions(+), 155 deletions(-)
>
[...]
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f7c0006a879..6b9f06b6b36 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -948,7 +948,7 @@ static const MemoryRegionOps ati_mm_ops = {
>     .endianness = DEVICE_LITTLE_ENDIAN,
> };
>
> -static void ati_vga_realize(PCIDevice *dev, Error **errp)
> +static void ati_vga_pci_realize(PCIDevice *dev, Error **errp)

Why rename this?

> {
>     ATIVGAState *s = ATI_VGA(dev);
>     VGACommonState *vga = &s->vga;
> @@ -1032,7 +1032,7 @@ static void ati_vga_reset(DeviceState *dev)
>     s->mode = VGA_MODE;
> }
>
> -static void ati_vga_exit(PCIDevice *dev)
> +static void ati_vga_pci_unrealize(PCIDevice *dev)

Can you just call it ati_vga_unrealize like in other devices?

Regards,
BALATON Zoltan

> {
>     ATIVGAState *s = ATI_VGA(dev);
>
> @@ -1064,8 +1064,8 @@ static void ati_vga_class_init(ObjectClass *klass, const void *data)
>     k->vendor_id = PCI_VENDOR_ID_ATI;
>     k->device_id = PCI_DEVICE_ID_ATI_RAGE128_PF;
>     k->romfile = "vgabios-ati.bin";
> -    k->realize = ati_vga_realize;
> -    k->exit = ati_vga_exit;
> +    k->realize = ati_vga_pci_realize;
> +    k->unrealize = ati_vga_pci_unrealize;
> }
>
> static void ati_vga_init(Object *o)
--3866299591-1542710788-1763992565=:46144--

