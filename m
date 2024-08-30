Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03058CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 09:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjyJO-0005Qt-Rj; Fri, 30 Aug 2024 05:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjyJH-0005Nf-Tl; Fri, 30 Aug 2024 05:52:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjyJE-00060r-Rb; Fri, 30 Aug 2024 05:52:51 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwCz8038Hz6K5q9;
 Fri, 30 Aug 2024 17:49:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A1083140736;
 Fri, 30 Aug 2024 17:52:31 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 10:52:31 +0100
Date: Fri, 30 Aug 2024 10:52:30 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <quic_llindhol@quicinc.com>, <peter.maydell@linaro.org>,
 <marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <chenbaozi@phytium.com.cn>, <wangyinfeng@phytium.com.cn>,
 <shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH 1/2] hw/arm/sbsa-ref: Enable CXL Host Bridge by pxb-cxl
Message-ID: <20240830105230.00002043@Huawei.com>
In-Reply-To: <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
 <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 Aug 2024 12:15:56 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> The memory layout places 1M space for 16 host bridge register regions
> in the sbsa-ref memmap. In addition, this creates a default pxb-cxl
> (bus_nr=3D0xfe) bridge with one cxl-rp on sbsa-ref.

If you are only supporting 1 host bridge you could reduce the space to just
fit that?

=46rom the command line example and code here it seems the pxb instances are =
hard
coded so you don't need to support the flexibility I needed for virt.

Otherwise, just superficial code comments inline.
Fixed setups are definitely easier to support :)

Jonathan


>=20
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  hw/arm/sbsa-ref.c | 54 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index ae37a92301..dc924d181e 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -41,7 +41,10 @@
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "hw/intc/arm_gicv3_its_common.h"
>  #include "hw/loader.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/usb.h"
>  #include "hw/usb/xhci.h"
> @@ -52,6 +55,8 @@
>  #include "qom/object.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"

Headers look to be alphabetical order.

> =20
>  #define RAMLIMIT_GB 8192
>  #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> @@ -94,6 +99,7 @@ enum {
>      SBSA_SECURE_MEM,
>      SBSA_AHCI,
>      SBSA_XHCI,
> +    SBSA_CXL_HOST,
>  };
> =20
>  struct SBSAMachineState {
> @@ -105,6 +111,9 @@ struct SBSAMachineState {
>      int psci_conduit;
>      DeviceState *gic;
>      PFlashCFI01 *flash[2];
> +    CXLState cxl_devices_state;
> +    PCIBus *bus;

Lot of buses in a system, I'd call the pcibus
or similar. However, see below - I don't think
it is necessary.


> +    PCIBus *cxlbus;
>  };
> =20
>  #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
> @@ -132,6 +141,8 @@ static const MemMapEntry sbsa_ref_memmap[] =3D {
>      /* Space here reserved for more SMMUs */
>      [SBSA_AHCI] =3D               { 0x60100000, 0x00010000 },
>      [SBSA_XHCI] =3D               { 0x60110000, 0x00010000 },
> +    /* 1M CXL Host Bridge Registers space (64KiB * 16) */
> +    [SBSA_CXL_HOST] =3D           { 0x60120000, 0x00100000 },

As below, can just leave space for however many you are creating.

>      /* Space here reserved for other devices */
>      [SBSA_PCIE_PIO] =3D           { 0x7fff0000, 0x00010000 },
>      /* 32-bit address PCIE MMIO space */
> @@ -631,6 +642,26 @@ static void create_smmu(const SBSAMachineState *sms,=
 PCIBus *bus)
>      }
>  }
> =20
> +static void create_pxb_cxl(SBSAMachineState *sms)
> +{
> +    CXLHost *host;
> +    PCIHostState *cxl;
> +
> +    sms->cxl_devices_state.is_enabled =3D true;
> +
> +    DeviceState *qdev;

I think qemu still sticks mostly to declarations at the top
of functions. So move this up.

> +    qdev =3D qdev_new(TYPE_PXB_CXL_DEV);
> +    qdev_prop_set_uint32(qdev, "bus_nr", 0xfe);

Ouch. That's not a lot of space in bus numbers.
Move it down a bit so there is room for switches etc
and not just a single root port.
Up to SBSA ref maintainers, but I'd use 0xc0 or something
like that.

> +
> +    PCIDevice *dev =3D PCI_DEVICE(qdev);

Declarations at the top I think.

> +    pci_realize_and_unref(dev, sms->bus, &error_fatal);
> +
> +    host =3D PXB_CXL_DEV(dev)->cxl_host_bridge;
> +    cxl =3D PCI_HOST_BRIDGE(host);
> +    sms->cxlbus =3D cxl->bus;
> +    pci_create_simple(sms->cxlbus, -1, "cxl-rp");

You want to enable at least some interleaving the HB so I'd
add at least 2 root ports.

> +}
> +
>  static void create_pcie(SBSAMachineState *sms)
>  {
>      hwaddr base_ecam =3D sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> @@ -682,12 +713,25 @@ static void create_pcie(SBSAMachineState *sms)
>      }
> =20
>      pci =3D PCI_HOST_BRIDGE(dev);
> +    sms->bus =3D pci->bus;

I'd carry on using pci->bus for this code to minimize changes
needed and set sms->bus at the end of the function, not the
start (see below - you can get rid of need to store pci->bus
I think).

> +
> +    pci_init_nic_devices(sms->bus, mc->default_nic);
> =20
> -    pci_init_nic_devices(pci->bus, mc->default_nic);
> +    pci_create_simple(sms->bus, -1, "bochs-display");
> =20
> -    pci_create_simple(pci->bus, -1, "bochs-display");
> +    create_smmu(sms, sms->bus);
> =20
> -    create_smmu(sms, pci->bus);
> +    create_pxb_cxl(sms);

Keep this similar to the others and pass in pci->bus even
though you are going to stash pci->bus

> +}


> =20
>  static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_si=
ze)
> @@ -823,6 +867,10 @@ static void sbsa_ref_init(MachineState *machine)
> =20
>      create_pcie(sms);
> =20
> +    create_cxl_host_reg_region(sms);
> +
> +    cxl_hook_up_pxb_registers(sms->bus, &sms->cxl_devices_state, &error_=
fatal);
> +

Fixed pxb instances certainly make this less of a dance than we need for pc=
 / virt
as the creation order is constrained in a way it isn't for those generic ma=
chines.

Given you know you only have one PXB-cxl and have it in sms->cxlbus
you could just call
pxb_cxl_hook_up_registers(&sms->cxl_devices_state, pci->cxlbus, &error_fata=
l)
I think and get same result without needed to add sms->bus to get hold of t=
he
pci bus.


>      create_secure_ec(secure_sysmem);
> =20
>      sms->bootinfo.ram_size =3D machine->ram_size;


