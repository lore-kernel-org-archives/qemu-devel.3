Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BE1C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4vTg-0005TX-V3; Wed, 16 Apr 2025 01:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4vTd-0005RE-AJ; Wed, 16 Apr 2025 01:38:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4vTZ-0006oL-VQ; Wed, 16 Apr 2025 01:38:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcqT710dFz6K9JW;
 Wed, 16 Apr 2025 13:34:03 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 7C85E140144;
 Wed, 16 Apr 2025 13:38:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 07:38:16 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Apr 2025 07:38:16 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH 2/5] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Topic: [PATCH 2/5] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Index: AQHbreNBEYF963kYiE+YQb+tZRxE6rOlkCuAgAA2DlA=
Date: Wed, 16 Apr 2025 05:38:15 +0000
Message-ID: <8a76f317aa3048bfb7262b670629f43b@huawei.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <20250415081104.71708-3-shameerali.kolothum.thodi@huawei.com>
 <Z/8vzf/q24sZOdBG@Asurada-Nvidia>
In-Reply-To: <Z/8vzf/q24sZOdBG@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.152.164]
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 16, 2025 5:19 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
> mochs@nvidia.com; smostafa@google.com; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH 2/5] hw/arm/virt-acpi-build: Update IORT for multiple
> smmuv3 devices
>=20
> On Tue, Apr 15, 2025 at 09:11:01AM +0100, Shameer Kolothum wrote:
> > +static int get_smmuv3_device(Object *obj, void *opaque)
> > +{
> > +    GArray *sdev_blob =3D opaque;
> > +    int min_bus, max_bus;
> > +    VirtMachineState *vms;
> > +    PlatformBusDevice *pbus;
> > +    SysBusDevice *sbdev;
> > +    SMMUv3Device sdev;
> > +    hwaddr base;
> > +    int irq;
> > +    PCIBus *bus;
>=20
> In a reverse christmas tree order? Or we could at least group
> those similar types together.

Yeah. Reverse will look better I guess.
>=20
> > +    vms =3D VIRT_MACHINE(qdev_get_machine());
> > +    pbus =3D PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> > +    sbdev =3D SYS_BUS_DEVICE(obj);
> > +    base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0);
> > +    irq =3D platform_bus_get_irqn(pbus, sbdev, 0);
> > +
> > +    base +=3D vms->memmap[VIRT_PLATFORM_BUS].base;
> > +    irq +=3D vms->irqmap[VIRT_PLATFORM_BUS];
> > +
> > +    pci_bus_range(bus, &min_bus, &max_bus);
> > +    sdev.smmu_idmap.input_base =3D min_bus << 8;
> > +    sdev.smmu_idmap.id_count =3D (max_bus - min_bus + 1) << 8;
> > +    sdev.base =3D base;
> > +    sdev.irq =3D irq + ARM_SPI_BASE;
>=20
> Hmm, these base/irq local variables don't look necessary.
>=20
> > +    g_array_append_val(sdev_blob, sdev);
> > +    return 0;
> > +}
> > +
> >  /*
> >   * Input Output Remapping Table (IORT)
> >   * Conforms to "IO Remapping Table System Software on ARM
> Platforms",
> > @@ -275,25 +330,42 @@ static void
> >  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState
> *vms)
> >  {
> >      int i, nb_nodes, rc_mapping_count;
> > -    size_t node_size, smmu_offset =3D 0;
> > +    size_t node_size, *smmu_offset =3D NULL;
> >      AcpiIortIdMapping *idmap;
> > +    int num_smmus =3D 0;
> >      uint32_t id =3D 0;
> >      GArray *smmu_idmaps =3D g_array_new(false, true,
> sizeof(AcpiIortIdMapping));
> >      GArray *its_idmaps =3D g_array_new(false, true,
> sizeof(AcpiIortIdMapping));
> > +    GArray *smmuv3_devices =3D g_array_new(false, true,
> sizeof(SMMUv3Device));
> >
> >      AcpiTable table =3D { .sig =3D "IORT", .rev =3D 3, .oem_id =3D vms=
->oem_id,
> >                          .oem_table_id =3D vms->oem_table_id };
> >      /* Table 2 The IORT */
> >      acpi_table_begin(&table, table_data);
> >
> > -    if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
> > -        AcpiIortIdMapping next_range =3D {0};
> > -
> > +    nb_nodes =3D 2; /* RC, ITS */
> > +    if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3_DEV) {
> > +        object_child_foreach_recursive(object_get_root(),
> > +                                       get_smmuv3_device, smmuv3_devic=
es);
> > +         /* Sort the smmuv3-devices by smmu idmap input_base */
> > +        g_array_sort(smmuv3_devices, smmuv3_dev_idmap_compare);
> > +        /*  Fill smmu idmap from sorted smmuv3 devices array */
> > +        for (i =3D 0; i < smmuv3_devices->len; i++) {
> > +            SMMUv3Device *s =3D &g_array_index(smmuv3_devices,
> SMMUv3Device, i);
> > +            g_array_append_val(smmu_idmaps, s->smmu_idmap);
> > +        }
> > +        num_smmus =3D smmuv3_devices->len;
> > +    } else if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
> >          object_child_foreach_recursive(object_get_root(),
> >                                         iort_host_bridges, smmu_idmaps)=
;
> >
> >          /* Sort the smmu idmap by input_base */
> >          g_array_sort(smmu_idmaps, iort_idmap_compare);
>=20
> VIRT_IOMMU_SMMUV3 seems to fit the struct SMMUv3Device very well,
> given that it has base, irq, and smmu_idmaps too?

One difference though is the legacy VIRT_IOMMU_SMMUV3 one is a global
Machine wide one nad can be associated with multiple PCIe root complexes
which will result in smmu_idmaps array. See the iort_host_bridges() fn.

>=20
> Maybe we could generalize the struct SMMUv3Device to store both
> cases. Perhaps just SMMUv3AcpiInfo? And then ..

Could do. But then you have to have  a smmu_idmaps array and then check
the length of it to cover legacy SMMUv3 case I guess.

 > > @@ -341,10 +413,20 @@ build_iort(GArray *table_data, BIOSLinker
> *linker, VirtMachineState *vms)
> >      /* GIC ITS Identifier Array */
> >      build_append_int_noprefix(table_data, 0 /* MADT translation_id */,
> 4);
> >
> > -    if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
> > -        int irq =3D  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> > +    for (i =3D 0; i < num_smmus; i++) {
> > +        hwaddr base;
> > +        int irq;
> > +
> > +        if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3_DEV) {
> > +            SMMUv3Device *s =3D &g_array_index(smmuv3_devices,
> SMMUv3Device, i);
> > +            base =3D s->base;
> > +            irq =3D s->irq;
> > +        } else {
> > +            base =3D vms->memmap[VIRT_SMMU].base;
> > +            irq =3D vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> > +        }
>=20
> .. we wouldn't need two paths here.
>=20
> > @@ -404,15 +486,26 @@ build_iort(GArray *table_data, BIOSLinker
> *linker, VirtMachineState *vms)
> >      build_append_int_noprefix(table_data, 0, 3); /* Reserved */
> >
> >      /* Output Reference */
> > -    if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
> > +    if (num_smmus) {
> >          AcpiIortIdMapping *range;
> >
> >          /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS
> */
> >          for (i =3D 0; i < smmu_idmaps->len; i++) {
> > +            size_t offset;
> > +            if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3_DEV) {
> > +                offset =3D smmu_offset[i];
> > +            } else {
> > +                /*
> > +                 * For legacy VIRT_IOMMU_SMMUV3 case, one machine wide
> > +                 * smmuv3 may have multiple smmu_idmaps.
> > +                 */
> > +                offset =3D smmu_offset[0];
> > +            }
>=20
> And I think we can eliminate this too if we stuff an smmu_offset
> in struct AcpiIortIdMapping ..
>=20
> >              range =3D &g_array_index(smmu_idmaps, AcpiIortIdMapping, i=
);
> >              /* output IORT node is the smmuv3 node */
> >              build_iort_id_mapping(table_data, range->input_base,
> > -                                  range->id_count, smmu_offset);
> > +                                  range->id_count, offset);
>=20
> ... and here it would be range->offset.

I will give it a try and if that simplifies things will include it in next =
respin.

Thanks,
Shameer


