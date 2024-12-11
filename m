Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBECE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOX8-0003TO-3B; Wed, 11 Dec 2024 10:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tLOX4-0003Ns-6Q; Wed, 11 Dec 2024 10:21:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tLOX1-00086l-1y; Wed, 11 Dec 2024 10:21:45 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7fSD00Dfz6D9Bp;
 Wed, 11 Dec 2024 23:20:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 4ED4C1400DD;
 Wed, 11 Dec 2024 23:21:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 16:21:38 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 11 Dec 2024 16:21:38 +0100
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Thread-Topic: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Thread-Index: AQHbMd3CYnIzOIz3QUan4PDL8HOdprK8zVGAgAAjLhCAABtdAIAAIywQgAAmhYCAAus70IAAGD4AgAAU00CAARvsAIAei3YAgAE/FGA=
Date: Wed, 11 Dec 2024 15:21:37 +0000
Message-ID: <74114c0db34b420a90e9fe5bd991767e@huawei.com>
References: <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
 <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
 <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
 <0803ec1a010a46b9811543e1044c3176@huawei.com>
 <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
 <30ff8ac9ee9b4012aa6962c86ac06375@huawei.com>
 <41a67d4e-f7b8-4586-8d52-c32df400b675@redhat.com>
 <e13f2e9c0a6341e8b25b7945bc7bf413@huawei.com>
 <c14feb2934a0478180635bbdb27d5e53@huawei.com>
 <Z1ipHKP4L/++143Q@Asurada-Nvidia>
In-Reply-To: <Z1ipHKP4L/++143Q@Asurada-Nvidia>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Hi Nicolin,

> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, December 10, 2024 8:48 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org
> Subject: Re: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with
> multiple SMMU nodes
>=20


> > And now I think I know(hopefully) the reason why it is not working with
> > smmuv3-nested case. I think the root cause is this commit here,
> >
> > (series: " cover-letter: Add HW accelerated nesting support for arm
> SMMUv3")
>=20
> > This changes the way address space is returned for the devices.
> >
> > static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int
> devfn)
> > {
> >     SMMUState *s =3D opaque;
> >     SMMUPciBus *sbus =3D smmu_get_sbus(s, bus);
> >     SMMUDevice *sdev =3D smmu_get_sdev(s, sbus, bus, devfn);
> >
> >     /* Return the system as if the device uses stage-2 only */
> >     if (s->nested && !sdev->s1_hwpt) {
> >         return &sdev->as_sysmem;
> >     } else {
> >         return &sdev->as;
> >     }
> > }
> >
> > If we have entries in the SMMUv3 idmap for bus:devfn, then I think we
> should
> > return IOMMU address space here. But the logic above returns sysmem
> > address space for anything other than vfio/iommufd devices.
> >
> > The hot add works when I hacked the logic to return IOMMU address
> space
> > for pcie root port devices.
> That is to bypass the "if (memory_region_is_iommu(section->mr))"
> in vfio_listener_region_add(), when the device gets initially
> attached to the default container.

Right.=20
=20
> Once a device reaches to the pci_device_set_iommu_device() call,
> it should be attached to an IDENTIY/bypass proxy s1_hwpt, so the
> smmu_find_add_as() will return the iommu as.

Agree. The above situation you explained is perfectly fine with vfio-pci de=
v.

> So, the fact that your hack is working means the hotplug routine
> is likely missing a pci_device_set_iommu_device() call, IMHO, or
> probably it should do pci_device_iommu_address_space() after the
> device finishes pci_device_set_iommu_device() instead..

The problem is not with the hot added vfio-pci dev but with the
pcie-root-port device. When we hot add a vfio-pci to a root port,
Qemu will inject an interrupt for the Guest root port device and
that kick starts the vfio-pci device add process. This involves writing
to the MSI address the Guest  kernel configures for the root port dev.=20

As per the current logic, the root port dev will have sysmem address
space and in IORT we have root port dev id in smmu idmap. This
will not work as Guest kernel configures a translated IOVA for MSI.

I think we have discussed this issue of returning different address
spaces before here[0]. But that was in a different context though.
The hack mentioned in [0] actually works for this case as well, where
we add an extra check to see the dev is vfio-pci or not. But I am not
sure that is the best way to handle this.

Another option is to exclude all the root port devices from IORT idmap.
But that looks not an ideal one to me as it actually sits behind an SMMUv3
in this case.

Please let me know if you have any ideas.

Thanks,
Shameer

[0] https://lore.kernel.org/linux-iommu/02f3fbc5145d4449b3313eb802ecfa2c@hu=
awei.com/

=20


