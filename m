Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC97C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 21:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZz0f-0003XP-9C; Thu, 10 Jul 2025 17:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZz0c-0003VQ-H9; Thu, 10 Jul 2025 17:40:50 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZz0Y-0007zC-5z; Thu, 10 Jul 2025 17:40:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdSqF0Fhgz6L5C9;
 Fri, 11 Jul 2025 05:37:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 50C83140157;
 Fri, 11 Jul 2025 05:40:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Jul 2025 23:40:29 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 10 Jul 2025 23:40:29 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Thread-Topic: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Thread-Index: AQHb8B7pgOmyuAHGhEyK6x0wrBLpebQonB8AgADVIJCAAOn5gIAAnLIwgABtrwCAACdXkP//6DAAgABtbwA=
Date: Thu, 10 Jul 2025 21:40:28 +0000
Message-ID: <0ef59c7f11454954814501e41724f4fe@huawei.com>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
 <aG2M/BI3UAYxKCD3@Asurada-Nvidia>
 <741503f8f96148b389b875e6b6812c1a@huawei.com>
 <aG8ECVeOYXPzBEVB@Asurada-Nvidia>
 <3a51c0e0f3ce4c2580ff596008615439@huawei.com>
 <aef834e0-d6dc-40d0-a6aa-24ed44b77325@redhat.com>
 <f3bfc4cdb0ca47da8f3e4bc38b58d3b6@huawei.com>
 <aG/whNETIoHGnI5O@Asurada-Nvidia>
In-Reply-To: <aG/whNETIoHGnI5O@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.153.84]
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
> Sent: Thursday, July 10, 2025 5:56 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Donald Dutile <ddutile@redhat.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
> jgg@nvidia.com; berrange@redhat.com; imammedo@redhat.com;
> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
> gustavo.romero@linaro.org; mst@redhat.com;
> marcel.apfelbaum@gmail.com; Linuxarm <linuxarm@huawei.com>;
> Wangzhou (B) <wangzhou1@hisilicon.com>; jiangkunkun
> <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH v7 07/12] hw/pci: Introduce
> pci_setup_iommu_per_bus() for per-bus IOMMU ops retrieval
>=20
> On Thu, Jul 10, 2025 at 04:21:41PM +0000, Shameerali Kolothum Thodi
> wrote:
> > > >> On Wed, Jul 09, 2025 at 08:20:35AM +0000, Shameerali Kolothum
> Thodi
> > > >> wrote:
> > > >>>> On Tue, Jul 08, 2025 at 04:40:50PM +0100, Shameer Kolothum
> wrote:
> > > >>>>> @@ -2909,6 +2909,19 @@ static void
> > > >>>> pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> > > >>>>>               }
> > > >>>>>           }
> > > >>>>>
> > > >>>>> +        /*
> > > >>>>> +         * When multiple PCI Express Root Buses are defined us=
ing
> > > >>>>> + pxb-
> > > >>>> pcie,
> > > >>>>> +         * the IOMMU configuration may be specific to each roo=
t
> bus.
> > > >>>> However,
> > > >>>>> +         * pxb-pcie acts as a special root complex whose paren=
t
> > > >>>>> + is
> > > >>>> effectively
> > > >>>>> +         * the default root complex(pcie.0). Ensure that we re=
trieve
> the
> > > >>>>> +         * correct IOMMU ops(if any) in such cases.
> > > >>>>> +         */
> > > >>>>> +        if (pci_bus_is_express(iommu_bus) &&
> > > >>>> pci_bus_is_root(iommu_bus)) {
> > > >>>>> +            if (!iommu_bus->iommu_per_bus && parent_bus-
> > > >>>>> iommu_per_bus) {
> > > >>>>> +                break;
> > > >>>>
> > > >>>> Mind elaborating why the current bus must unset iommu_per_bus
> > > >> while
> > > >>>> its parent sets iommu_per_bus?
> > > >>>>
> > > >>>> My understanding is that for a pxb-pcie we should set
> > > iommu_per_bus
> > > >>>> but for its parent (the default root complex) we should unset it=
s
> > > >>>> iommu_per_bus?
> > > >>>
> > > >>> Well, for new arm-smmuv3 dev you need an associated pcie root
> > > >>> complex. Either the default pcie.0 or a pxb-pcie one. And as I
> > > >>> mentioned in my reply to the other thread(patch #2) and commit
> log
> > > >> here,
> > > >>> the pxb-pcie is special extra root complex in Qemu which has pcie=
.0
> > > >>> has parent bus.
> > > >>>
> > > >>> The above pci_device_get_iommu_bus_devfn() at present, iterate
> over
> > > >> the
> > > >>> parent_dev if it is set and returns the parent_bus IOMMU ops even
> if
> > > >>> the associated pxb-pcie bus doesn't have any IOMMU. This creates
> > > >>> problem for a case that is described here in the cover letter her=
e,
> > > >>> https://lore.kernel.org/qemu-devel/20250708154055.101012-1-
> > > >> shameerali.kolothum.thodi@huawei.com/
> > > >>>
> > > >>> (Please see "Major changes from v4:" section)
> > > >>>
> > > >>> To address that issue, this patch introduces an new helper functi=
on
> > > >>> to
> > > >> specify that
> > > >>> the IOMMU ops are specific to the associated root
> > > >> complex(iommu_per_bus) and
> > > >>> use that to return the correct IOMMU ops.
> > > >>>
> > > >>> Hope with that context it is clear now.
> > > >>
> > > >> Hmm, I was not questioning the context, I get what the patch is
> > > >> supposed to do.
> > > >>
> > > >> I was asking the logic that is unclear to me why it breaks when:
> > > >>      !pxb-pcie->iommu_per_bus && pcie.0->iommu_per_bus
> > > >>
> > > >> Or in which case pcie.0 would be set to iommu_per_bus=3Dtrue?
> > > >
> > > > Yes. Consider the example I gave in cover  letter,
> > > >
> > > > -device arm-smmuv3,primary-bus=3Dpcie.0,id=3Dsmmuv3.1 \ -device
> > > > virtio-net-pci,bus=3Dpcie.0,netdev=3Dnet0,id=3Dvirtionet.0 \ -devic=
e
> > > > pxb-pcie,id=3Dpcie.1,bus_nr=3D8,bus=3Dpcie.0 \ -device
> > > > arm-smmuv3,primary-bus=3Dpcie.1,id=3Dsmmuv3.2 \ -device
> > > > pcie-root-port,id=3Dpcie.port1,chassis=3D2,bus=3Dpcie.1 \ -device
> > > > virtio-net-pci,bus=3Dpcie.port1,netdev=3Dnet1,id=3Dvirtionet.1
> > > >
> > > > pcie.0 is behind new SMMUv3 dev(smmuv3.1) and has
> iommu_per_bus
> > > set.
> > > > pcie.1 has no SMMv3U and iommu_per_bus is not set for it.
> > > pcie.1 doesn't?   then what is this line saying/meaning?:
> > >   -device arm-smmuv3,primary-bus=3Dpcie.1,id=3Dsmmuv3.2 \
> > >
> > > I read that as an smmuv3 attached to pcie.1, with an id of smmuv3.2;
> just
> > > as I read this config:
> > >   -device arm-smmuv3,primary-bus=3Dpcie.0,id=3Dsmmuv3.1 \ as an smmuv=
3
> > > attached to pcie.0 iwth id smmuv3.1
> >
> > Oops..I forgot to delete that from the config:
> > This is what I meant,
> >
> > -device arm-smmuv3,primary-bus=3Dpcie.0,id=3Dsmmuv3.1 \
> > -device virtio-net-pci,bus=3Dpcie.0,netdev=3Dnet0,id=3Dvirtionet.0 \
> > -device pxb-pcie,id=3Dpcie.1,bus_nr=3D8,bus=3Dpcie.0 \
> > -device pcie-root-port,id=3Dpcie.port1,chassis=3D2,bus=3Dpcie.1 \
> > -device virtio-net-pci,bus=3Dpcie.port1,netdev=3Dnet1,id=3Dvirtionet.1 =
\
>=20
> So, the logic is trying to avoid:
>         "iommu_bus =3D parent_bus;"
> for a case that parent_bus (pcie.0) having its own IOMMU.
>=20
> But shouldn't it be just "if (parent_bus->iommu_per_bus)"?
>=20
> Why does the current iommu_bus->iommu_per_bus has to be unset?

I think that !iommu_bus->iommu_per_bus check will be always true as=20
it enters the while loop only if !iommu_bus->iommu_ops case,

while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {

}

So yes, I think that can be removed. I will double check though as I cant
recollect why I added that now.

>=20
> I think "iommu_bus =3D parent_bus" should be avoided too even if
> the current iommu_bus has its own IOMMU, i.e. iommu_per_bus is
> set?

Why? Not clear to me. It only enters the loop if the current iommu_bus
doesn't have Iommu_ops set which in turn means iommu_per_bus is not set.=20
Isn't it? . Do you have a particular configuration in mind where it will fa=
il
otherwise?

Thanks,
Shameer

