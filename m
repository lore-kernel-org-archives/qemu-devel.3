Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B17C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 10:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhQ61-0004lT-BH; Thu, 31 Jul 2025 06:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uhQ5q-0004c9-7L; Thu, 31 Jul 2025 06:00:59 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uhQ5m-0002Dx-VB; Thu, 31 Jul 2025 06:00:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt4Kw6z17z6D971;
 Thu, 31 Jul 2025 17:59:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4C3E01402F4;
 Thu, 31 Jul 2025 18:00:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 12:00:37 +0200
Date: Thu, 31 Jul 2025 11:00:36 +0100
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 <qemu-arm@nongnu.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
Message-ID: <20250731110036.00003a0a@huawei.com>
In-Reply-To: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 30 Jul 2025 15:21:41 +0300
Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:

> NVDIMM is used for fast rootfs with EROFS, for example by kata
> containers. To allow booting with static NVDIMM memory, add them to the
> device tree in arm virt machine.
>=20
> This allows users to boot directly with nvdimm memory devices without
> having to rely on ACPI and hotplug.
>=20
> Verified to work with command invocation:
>=20
> ./qemu-system-aarch64 \
>   -M virt,nvdimm=3Don \
>   -cpu cortex-a57 \
>   -m 4G,slots=3D2,maxmem=3D8G \
>   -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3D/tmp/nvdimm=
,size=3D4G,readonly=3Doff \
>   -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1,unarmed=3Doff \
>   -drive file=3D./debian-12-nocloud-arm64-commited.qcow2,format=3Dqcow2 \
>   -kernel ./vmlinuz-6.1.0-13-arm64 \
>   -append "root=3D/dev/vda1 console=3DttyAMA0,115200 acpi=3Doff"
>   -initrd ./initrd.img-6.1.0-13-arm64 \
>   -nographic \
>   -serial mon:stdio
>=20
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

+CC shameer who might be able to remember how the nvdimm stuff works in ACP=
I better
than I can.  I think this is fine but more eyes would be good.

> ---
>  hw/arm/boot.c | 39 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/virt.c |  8 +++++---
>  2 files changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d391cd01bb1b92ff213e69b84e5a69413b36c4f8..a0c1bcdf946ca98bb5da63f1a=
518018eb578dd81 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -25,6 +25,7 @@
>  #include "hw/boards.h"
>  #include "system/reset.h"
>  #include "hw/loader.h"
> +#include "hw/mem/memory-device.h"
>  #include "elf.h"
>  #include "system/device_tree.h"
>  #include "qemu/config-file.h"
> @@ -515,6 +516,26 @@ static void fdt_add_psci_node(void *fdt, ARMCPU *arm=
cpu)
>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>  }
> =20
> +static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t scells,
> +                             int64_t mem_base, int64_t size, int64_t nod=
e)
> +{
> +    int ret;
> +
> +    g_autofree char *nodename =3D g_strdup_printf("/pmem@%" PRIx64, mem_=
base);
> +
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
> +    ret =3D qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells,
> +                                       mem_base, scells, size);

I'd burn some lines to avoid a comment covering unrelated ret handling

	if (ret)
		return ret;

	if (node >=3D 0) {
		return qem_fdt_setprop_cell()
	}

	return 0;

> +    /* only set the NUMA ID if it is specified */
> +    if (!ret && node >=3D 0) {
> +        ret =3D qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
> +                                    node);
> +    }
> +
> +    return ret;
> +}
> +
>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                   hwaddr addr_limit, AddressSpace *as, MachineState *ms,
>                   ARMCPU *cpu)
> @@ -525,6 +546,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>      unsigned int i;
>      hwaddr mem_base, mem_len;
>      char **node_path;
> +    g_autofree MemoryDeviceInfoList *md_list =3D NULL;
>      Error *err =3D NULL;
> =20
>      if (binfo->dtb_filename) {
> @@ -628,6 +650,23 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
>          }
>      }
> =20
> +    md_list =3D qmp_memory_device_list();
> +    for (MemoryDeviceInfoList *m =3D md_list; m !=3D NULL; m =3D m->next=
) {
> +        MemoryDeviceInfo *mi =3D m->value;
> +
> +        if (mi->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM) {
> +            PCDIMMDeviceInfo *di =3D mi->u.nvdimm.data;
> +
> +            rc =3D fdt_add_pmem_node(fdt, acells, scells,
> +                                   di->addr, di->size, di->node);
> +            if (rc < 0) {
> +                fprintf(stderr, "couldn't add NVDIMM /pmem@%"PRIx64" nod=
e\n",
> +                        di->addr);
> +                goto fail;
> +            }
> +        }
> +    }
> +
>      rc =3D fdt_path_offset(fdt, "/chosen");
>      if (rc < 0) {
>          qemu_fdt_add_subnode(fdt, "/chosen");
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef6be3660f5fb38da84235c32dc2d13a5c61889c..910f5bb5f66ee217a9140f912=
8804a5b9f69b5b6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2917,7 +2917,7 @@ static void virt_memory_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>      const MachineState *ms =3D MACHINE(hotplug_dev);
>      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
> =20
> -    if (!vms->acpi_dev) {
> +    if (!vms->acpi_dev && !(is_nvdimm && !dev->hotplugged)) {
>          error_setg(errp,
>                     "memory hotplug is not enabled: missing acpi-ged devi=
ce");
>          return;
> @@ -2949,8 +2949,10 @@ static void virt_memory_plug(HotplugHandler *hotpl=
ug_dev,
>          nvdimm_plug(ms->nvdimms_state);
>      }
> =20
> -    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> -                         dev, &error_abort);
> +    if (vms->acpi_dev) {
> +        hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> +                             dev, &error_abort);
> +    }
>  }
> =20
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>=20
> ---
> base-commit: 9b80226ece693197af8a981b424391b68b5bc38e
> change-id: 20250730-nvdimm_arm64_virt-931a764bbe0c
>=20
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>=20
>=20


