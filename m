Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE8C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 17:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcpVr-0005rH-Bl; Tue, 28 Jan 2025 12:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tcpVn-0005r7-Do
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:36:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tcpVi-0007Rh-96
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:36:29 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YjC7z2T3Tz6M4Lv;
 Wed, 29 Jan 2025 01:34:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9220D140A08;
 Wed, 29 Jan 2025 01:36:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 Jan 2025 18:36:11 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 28 Jan 2025 18:36:11 +0100
To: "Matthew R. Ochs" <mochs@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>
CC: "ddutile@redhat.com" <ddutile@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ankita@nvidia.com" <ankita@nvidia.com>
Subject: RE: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Topic: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Index: AQHbcZ4cYA4z6rsGGkubzpet1LJ8N7Msbd1g
Date: Tue, 28 Jan 2025 17:36:11 +0000
Message-ID: <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
References: <20250128160237.3379569-1-mochs@nvidia.com>
In-Reply-To: <20250128160237.3379569-1-mochs@nvidia.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Matthew R. Ochs <mochs@nvidia.com>
> Sent: Tuesday, January 28, 2025 4:03 PM
> To: qemu-devel@nongnu.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; nathanc@nvidia.com
> Cc: ddutile@redhat.com; eric.auger@redhat.com; nicolinc@nvidia.com;
> ankita@nvidia.com
> Subject: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
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
> 	-machine virt,gic-version=3D3,highmem-mmio-size=3D1099511627776

I guess you could do highmem-mmio-size=3D1024G as well.

>=20
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
>  docs/system/arm/virt.rst |  4 ++++
>  hw/arm/virt.c            | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>=20
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index e67e7f0f7c50..36344554788a 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -138,6 +138,10 @@ highmem-mmio
>    Set ``on``/``off`` to enable/disable the high memory region for PCI MM=
IO.
>    The default is ``on``.
>=20
> +highmem-mmio-size
> +  Set extended MMIO memory map size. Must be a power-of-2 and greater
> than
> +  the default size.
> +
>  gic-version
>    Specify the version of the Generic Interrupt Controller (GIC) to provi=
de.
>    Valid values are:
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 49eb0355ef0c..43d47ffedd9a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2773,6 +2773,35 @@ static void virt_set_highmem_mmio(Object *obj,
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
> +    if (!visit_type_size(v, name, &size, errp))
> +        return;

Qemu style mandates braces around.

> +
> +    if (!is_power_of_2(size)) {
> +        error_setg(errp, "highmem_mmio_size is not a power-of-2");
> +        return;
> +    }
> +
> +    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {

Not sure it is better to fallback to default size here instead of setting e=
rror.

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
> @@ -3446,6 +3475,13 @@ static void virt_machine_class_init(ObjectClass
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
> +                                          "Set extended MMIO memory map =
size");
> +

I think this probably needs backward compatibility to keep migration happy.
Isn't it? See the no_highmem_compact handling.

Thanks,
Shameer


