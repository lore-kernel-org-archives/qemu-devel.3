Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC960C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDRj-0007kv-HN; Tue, 06 May 2025 04:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDRg-0007jT-N7; Tue, 06 May 2025 04:14:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDRe-0002Z9-DF; Tue, 06 May 2025 04:14:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zs9zn4gKzz6M53T;
 Tue,  6 May 2025 16:09:57 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id E469F1402ED;
 Tue,  6 May 2025 16:14:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 10:14:26 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 6 May 2025 10:14:26 +0200
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
Subject: RE: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Topic: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Index: AQHbu1V0fvNxmQCU0kS/eGPfhGB2G7O/dXYAgAXRX2A=
Date: Tue, 6 May 2025 08:14:26 +0000
Message-ID: <ce59282671674258a6dacd38fe09207c@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <aBT/DKnSpdV1SEmb@Asurada-Nvidia>
In-Reply-To: <aBT/DKnSpdV1SEmb@Asurada-Nvidia>
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
> Sent: Friday, May 2, 2025 6:23 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
> mochs@nvidia.com; smostafa@google.com; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a
> PCIe RC
>=20
> On Fri, May 02, 2025 at 11:27:02AM +0100, Shameer Kolothum wrote:
> > Although this change does not affect functionality at present, it lays
> > the groundwork for enabling user-created SMMUv3 devices in future
> > patches
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>=20
> With some nits:
>=20
> > ---
> >  hw/arm/smmuv3.c | 26 ++++++++++++++++++++++++++
> >  hw/arm/virt.c   |  3 ++-
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c index
> > ab67972353..605de9b721 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -24,6 +24,7 @@
> >  #include "hw/qdev-properties.h"
> >  #include "hw/qdev-core.h"
> >  #include "hw/pci/pci.h"
> > +#include "hw/pci/pci_bridge.h"
>=20
> Could probably replace the pci.h since pci_bridge.h includes it.

I think it is best not to as it is indirect inclusion.

>=20
> > +static int smmuv3_pcie_bus(Object *obj, void *opaque) {
> > +    DeviceState *d =3D opaque;
> > +    PCIBus *bus;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
> > +        return 0;
> > +    }
> > +
> > +    bus =3D PCI_HOST_BRIDGE(obj)->bus;
> > +    if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus-
> >name)) {
> > +        object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus)=
,
> > +                                 &error_abort);
> > +        /* Return non-zero as we got the bus and don't need further
> > + iteration.*/
>=20
> Missing a space behind the '.'

Sure.

>=20
> > +        return 1;
> > +    }
> > +    return 0;
> > +}
>=20
> > @@ -1442,7 +1443,7 @@ static void create_smmu(const
> VirtMachineState *vms,
> >      }
> >      object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
> >                               &error_abort);
> > -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
>=20
> Could add a line of note in the commit message for this change?

Will do.=20

Thanks,
Shameer

