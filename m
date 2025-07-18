Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ACBC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgMT-0003lA-52; Fri, 18 Jul 2025 04:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ucgMI-0003fA-Pg; Fri, 18 Jul 2025 04:22:23 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ucgMF-0002Ng-FV; Fri, 18 Jul 2025 04:22:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk2mj1X36z6L54R;
 Fri, 18 Jul 2025 16:20:53 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id DE61A1402F6;
 Fri, 18 Jul 2025 16:22:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Jul 2025 10:22:09 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 18 Jul 2025 10:22:09 +0200
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
Subject: RE: [PATCH v8 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Thread-Topic: [PATCH v8 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Thread-Index: AQHb8l0bM38DEvQAn02aSOaRjdl7LrQ3LnQAgABc6VD//+XDAIAAIhdg
Date: Fri, 18 Jul 2025 08:22:09 +0000
Message-ID: <028e156593614a5cb8493304e1c6a447@huawei.com>
References: <20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com>
 <20250711084749.18300-9-shameerali.kolothum.thodi@huawei.com>
 <aHnJ+qUsVyu+eFaT@Asurada-Nvidia>
 <f793c36c2cf145b7842eb72795553824@huawei.com>
 <aHoB6HvXgkmkMQnv@Asurada-Nvidia>
In-Reply-To: <aHoB6HvXgkmkMQnv@Asurada-Nvidia>
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
> Sent: Friday, July 18, 2025 9:12 AM
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
> Subject: Re: [PATCH v8 08/12] hw/arm/virt: Allow user-creatable SMMUv3
> dev instantiation
>=20
> On Fri, Jul 18, 2025 at 08:01:22AM +0000, Shameerali Kolothum Thodi
> wrote:
> > > > +    int irq =3D platform_bus_get_irqn(pbus, sbdev, 0);
> > > > +    hwaddr base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0);
> > > > +    MachineState *ms =3D MACHINE(vms);
> > > > +
> > > > +    if (!(vms->bootinfo.firmware_loaded &&
> virt_is_acpi_enabled(vms))
> > > &&
> > > > +        strcmp("pcie.0", bus->qbus.name)) {
> > > > +        warn_report("SMMUv3 device only supported with pcie.0 for
> DT");
> > > > +        return;
> > > > +    }
> > > > +    base +=3D vms->memmap[VIRT_PLATFORM_BUS].base;
> > > > +    irq +=3D vms->irqmap[VIRT_PLATFORM_BUS];
> > >
> > > The code is fine.
> > >
> > > Just a related question here:
> > >
> > > Do you know where we define the number of IRQs and the range of
> > > MMIO for the SysBusDevice?
> > >
> > > SMMU has four IRQs. And I see multiple vSMMU instances do have
> > > correct intervals to their IRQ numbers, but I cannot find where
> > > the magic is done.
> >
> > Look for,
> > #define PLATFORM_BUS_NUM_IRQS 64
> >
> > So in theory we could have around 16 vSMMU per VM. It depends on
> > other platform devices specified as well. Do you see a need for more
> > on a per VM basis? I know there are host systems with large number of
> > SMMUv3s, but how many a VM will get assigned realistically?
>=20
> Hmm, I was asking how platform bus knows that SMMU only has four
> IRQs. But I think number of 16 might not be enough in some cases.
>=20
> So, my question was: where do we set the number of 4 to the sbdev?
> As platform_bus_get_irqn() returned very correctly with 0, 4, 8,
> and so on..

See smmu_realize() --> smmu_init_irq()

And then in virt_machine_plug_cb() --> platform_bus_link_device()

Thanks,
Shameer

