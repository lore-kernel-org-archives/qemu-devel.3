Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A89C83F09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 07:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZlgz-0002HR-Pk; Thu, 10 Jul 2025 03:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZlgx-0002Ex-Ck; Thu, 10 Jul 2025 03:27:39 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZlgr-0000py-As; Thu, 10 Jul 2025 03:27:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bd5xS3VHrz6G9YN;
 Thu, 10 Jul 2025 15:26:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 8356A1404D8;
 Thu, 10 Jul 2025 15:27:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Jul 2025 09:27:11 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 10 Jul 2025 09:27:11 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v7 02/12] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Thread-Topic: [PATCH v7 02/12] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Thread-Index: AQHb8B7KpVQQobU9VEOlB+EJbl8SmrQolAuAgADMh6CAAPc4gIAAlyDw
Date: Thu, 10 Jul 2025 07:27:10 +0000
Message-ID: <88a55d63d54f4586bd9992b6bdff5729@huawei.com>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-3-shameerali.kolothum.thodi@huawei.com>
 <aG2GNcXW89stIZHa@Asurada-Nvidia>
 <92ca69322dea4a0b966ce9dd7eff0fb3@huawei.com>
 <aG8BKexuSHtSvySv@Asurada-Nvidia>
In-Reply-To: <aG8BKexuSHtSvySv@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, July 10, 2025 12:54 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; berrange@redhat.com; imammedo@redhat.com;
> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
> gustavo.romero@linaro.org; mst@redhat.com;
> marcel.apfelbaum@gmail.com; Linuxarm <linuxarm@huawei.com>;
> Wangzhou (B) <wangzhou1@hisilicon.com>; jiangkunkun
> <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH v7 02/12] hw/arm/smmu-common: Check SMMU has
> PCIe Root Complex association
>=20
> On Wed, Jul 09, 2025 at 08:08:49AM +0000, Shameerali Kolothum Thodi
> wrote:
> > > On Tue, Jul 08, 2025 at 04:40:45PM +0100, Shameer Kolothum wrote:
> > > > @@ -937,11 +939,32 @@ static void smmu_base_realize(DeviceState
> > > *dev, Error **errp)
> > > >                                       g_free, g_free);
> > > >      s->smmu_pcibus_by_busptr =3D g_hash_table_new(NULL, NULL);
> > >
> > > Although this is not introduced by this patch, is there a
> > > g_hash_table_remove() somewhere in the code?
> >
> > g_hash_table_remove()  is to remove a key/value pair, isn't it?
>=20
> Yes.
>=20
> > Or you meant
> > a corresponding free in case of failure here?
>=20
> Yes. But I saw the other two g_hash_table_new_full calls were not
> reverted in the exit path either. Then I saw smmu_base_reset_exit
> does the clean up of those two but not this smmu_pcibus_by_busptr.

Ok. I think that is by design. The insert for busptr cache happens during
early stages of Qemu through get_address_space() callback and
smmu_base_reset_exit() is called after that, just before the Guest boot.
So if you clean that cache at that time , you need to handle it differently
at a later stage. Also I don't think it makes much sense to clear busptr
before the Guest boot as it is not going to become stale unlike configs
and iotlb.

> > It's a realize() fn and errp is set
> > if something goes wrong and QEMU will exit. Not sure we need an explici=
t
> > free here.
> >
> > > > +    /*
> > > > +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie
> based
> > > extra
> > > > +     * root complexes to be associated with SMMU.
> > > > +     */
> > > > +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> > > > +        object_dynamic_cast(OBJECT(pci_bus)->parent,
> > > TYPE_PCI_HOST_BRIDGE)) {
> > > > +        /*
> > > > +         * For pxb-pcie, parent_dev will be set. Make sure it is
> > > > +         * pxb-pcie indeed.
> > > > +         */
> > > > +        if (pci_bus->parent_dev) {
> > > > +            if (!object_dynamic_cast(OBJECT(pci_bus),
> TYPE_PXB_PCIE_BUS)) {
> > >
> > > The pci_bus_is_express(pci_bus) at the top is equivalent to:
> > > 	object_dynamic_cast(OBJECT(pci_bus), TYPE_PCIE_BUS)
> > > Then here it is doing:
> > > 	object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)
> >
> > Yes.
>=20
> Hmm?
>=20
> We have these two types defined as two different strings, right?
>=20
> #define TYPE_PCIE_BUS "PCIE"
> #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
>=20
> So the first test is to make sure pci_bus string is "PCIE",
> then the second one testing the same pci_bus string will
> never be true?
>

It will be true.

static const TypeInfo pxb_pcie_bus_info =3D {
    .name          =3D TYPE_PXB_PCIE_BUS,
    .parent        =3D TYPE_PCIE_BUS,
    .instance_size =3D sizeof(PXBBus),
    .class_init    =3D pxb_bus_class_init,
};

TYPE_PXB_PCIE_BUS has a parent TYPE_PCIE_BUS. And the function
object_dynamic_cast() does the magic. It will return non-null for an
exact object type and also for its parents in the QOM hierarchy.

> > > So, this checks the same pci_bus but expects two different types?
>
> > In QEMU,  we can have three types of PCIe root complexes to be specifie=
d
> for
> > virt machine.
> >
> > 1. default pcie.0 (TYPE_GPEX_HOST --> TYPE_PCIE_HOST_BRIDGE -->
> TYPE_PCI_HOST_BRIDGE)
> > 2. pxb-pcie (TYPE_PXB_HOST  -->TYPE_PCI_HOST_BRIDGE)
> > 2. pxb-cxl (TYPE_PXB_CXL_HOST  --> TYPE_PCI_HOST_BRIDGE)
> >
> > The above first check is to see whether the bus is  PCIE && root bus &&
> parent
> > of type TYPE_PCI_HOST_BRIDGE. This will identify all the above three
> cases.
> >
> > Both pxb-pcie and pxb-cxl are special extra root complexes based on PCI
> > expansion bridges and has a parent_dev set(both has pcie.0 has parent
> bus).
> >
> > Hence we check to see parent_dev is set and make sure it is indeed
> > TYPE_PXB_PCIE_BUS to avoid attaching to pxb-cxl.
>=20
> I see. That's clear now. I think it'd help by writing:
> 		/*
> 		 * While pcie.0 doesn't set the parent_dev, either pxb-pcie
> or
> 		 * pxb-cxl does. Re-test the type to make sure it is pxb-pcie.
> 		 */

I think it is already captured in the comments in this patch.

Thanks,
Shameer

