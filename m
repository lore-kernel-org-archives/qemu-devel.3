Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A6EC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 08:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thlPW-0000MC-Lx; Tue, 11 Feb 2025 03:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1thlPU-0000Ly-Tg; Tue, 11 Feb 2025 03:14:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1thlPR-00040G-MF; Tue, 11 Feb 2025 03:14:24 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YsZ1y4mJCz6K9BY;
 Tue, 11 Feb 2025 16:12:54 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id E66A11400CB;
 Tue, 11 Feb 2025 16:14:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 09:14:06 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 11 Feb 2025 09:14:06 +0100
To: "Matthew R. Ochs" <mochs@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ankita@nvidia.com" <ankita@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "gshan@redhat.com"
 <gshan@redhat.com>
Subject: RE: [PATCH v3] hw/arm/virt: Support larger highmem MMIO regions
Thread-Topic: [PATCH v3] hw/arm/virt: Support larger highmem MMIO regions
Thread-Index: AQHbeaAcYLReEf7WUEKnd1RoayHpjbNBxTUQ
Date: Tue, 11 Feb 2025 08:14:06 +0000
Message-ID: <6d12b4beb35a4afbb7e06bb3bde1fbb6@huawei.com>
References: <20250207203722.304621-1-mochs@nvidia.com>
In-Reply-To: <20250207203722.304621-1-mochs@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Matthew R. Ochs <mochs@nvidia.com>
> Sent: Friday, February 7, 2025 8:37 PM
> To: qemu-devel@nongnu.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; nathanc@nvidia.com
> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org;
> ddutile@redhat.com; eric.auger@redhat.com; nicolinc@nvidia.com;
> ankita@nvidia.com; philmd@linaro.org; gshan@redhat.com
> Subject: [PATCH v3] hw/arm/virt: Support larger highmem MMIO regions
>=20
> The MMIO region size required to support virtualized environments with
> large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
> For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed
> through
> requires more MMIO memory than the amount provided by
> VIRT_HIGH_PCIE_MMIO
> (currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
> new parameter, highmem-mmio-size, that specifies the MMIO size required
> to support the VM configuration.
>=20
> Example usage with 1TB MMIO region size:
> 	-machine virt,gic-version=3D3,highmem-mmio-size=3D1T
>=20
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
> v3: - Updated highmem-mmio-size description
> v2: - Add unit suffix to example in commit message
>     - Use existing "high memory region" terminology
>     - Resolve minor braces nit
>=20
>  docs/system/arm/virt.rst |  4 ++++
>  hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>=20
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index e67e7f0f7c50..20b14c22b659 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -138,6 +138,10 @@ highmem-mmio
>    Set ``on``/``off`` to enable/disable the high memory region for PCI MM=
IO.
>    The default is ``on``.
>=20
> +highmem-mmio-size
> +  Set the high memory region size for PCI MMIO. Must be a power-of-2 and
> +  greater than or equal to the default size.

Nit: May be good to specify the default size.

> +
>  gic-version
>    Specify the version of the Generic Interrupt Controller (GIC) to provi=
de.
>    Valid values are:
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 49eb0355ef0c..d8d62df43f04 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2773,6 +2773,36 @@ static void virt_set_highmem_mmio(Object *obj,
> bool value, Error **errp)
>      vms->highmem_mmio =3D value;
>  }
>=20
> +static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const
> char *name,
> +                          void *opaque, Error **errp)
> +{
> +    uint64_t size =3D extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
> +
> +    visit_type_size(v, name, &size, errp);
> +}
> +
> +static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const ch=
ar
> *name,
> +                          void *opaque, Error **errp)
> +{
> +    uint64_t size;
> +
> +    if (!visit_type_size(v, name, &size, errp)) {
> +        return;
> +    }
> +
> +    if (!is_power_of_2(size)) {
> +        error_setg(errp, "highmem_mmio_size is not a power-of-2");
> +        return;
> +    }
> +
> +    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
> +        error_setg(errp, "highmem_mmio_size is less than the default (%l=
u)",
> +                   extended_memmap[VIRT_HIGH_PCIE_MMIO].size);
> +        return;
> +    }
> +
> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].size =3D size;
> +}
>=20
>  static bool virt_get_its(Object *obj, Error **errp)
>  {
> @@ -3446,6 +3476,14 @@ static void virt_machine_class_init(ObjectClass
> *oc, void *data)
>                                            "Set on/off to enable/disable =
high "
>                                            "memory region for PCI MMIO");
>=20
> +    object_class_property_add(oc, "highmem-mmio-size", "size",
> +                                   virt_get_highmem_mmio_size,
> +                                   virt_set_highmem_mmio_size,
> +                                   NULL, NULL);
> +    object_class_property_set_description(oc, "highmem-mmio-size",
> +                                          "Set the high memory region si=
ze "
> +                                          "for PCI MMIO");
> +

Assuming the migration compatibility scenario discussed in v1 is not a prob=
lem
and is expected to be handled by user/libvirt,

Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Thanks,
Shameer

