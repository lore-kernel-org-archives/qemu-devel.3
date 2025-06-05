Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673ECC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN8nh-0004LK-Bi; Thu, 05 Jun 2025 07:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uN8nU-0004Ag-Qw; Thu, 05 Jun 2025 07:30:19 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uN8nP-0006lm-VW; Thu, 05 Jun 2025 07:30:11 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bCj0T1DzLz6K91p;
 Thu,  5 Jun 2025 19:29:45 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id A6B2E1402CB;
 Thu,  5 Jun 2025 19:29:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 13:29:59 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 5 Jun 2025 13:29:59 +0200
To: Igor Mammedov <imammedo@redhat.com>, Shameer Kolothum via
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root Complex
 association
Thread-Topic: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root Complex
 association
Thread-Index: AQHb09UMySB7lOszwECrIiqSkZXavbP0R3UAgAAnHLA=
Date: Thu, 5 Jun 2025 11:29:59 +0000
Message-ID: <065bbd4ee15442b58e15b298614cf5dd@huawei.com>
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-2-shameerali.kolothum.thodi@huawei.com>
 <20250605125518.138f5172@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250605125518.138f5172@imammedo.users.ipa.redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Thursday, June 5, 2025 11:55 AM
> To: Shameer Kolothum via <qemu-devel@nongnu.org>
> Cc: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root
> Complex association
>=20
> On Mon, 2 Jun 2025 16:41:05 +0100
> Shameer Kolothum via <qemu-devel@nongnu.org> wrote:
>=20
> > Although this change does not affect functionality at present, it is
> > required when we add support for user-creatable SMMUv3 devices in
> > future patches.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  hw/arm/smmuv3.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index ab67972353..7e934336c2 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -24,6 +24,7 @@
> >  #include "hw/qdev-properties.h"
> >  #include "hw/qdev-core.h"
> >  #include "hw/pci/pci.h"
> > +#include "hw/pci/pci_bridge.h"
> >  #include "cpu.h"
> >  #include "exec/target_page.h"
> >  #include "trace.h"
> > @@ -1881,6 +1882,13 @@ static void smmu_realize(DeviceState *d, Error
> **errp)
> >      SMMUv3Class *c =3D ARM_SMMUV3_GET_CLASS(s);
> >      SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
> >      Error *local_err =3D NULL;
> > +    Object *bus;
> > +
> > +    bus =3D object_property_get_link(OBJECT(d), "primary-bus",
> &error_abort);
> I'd replace this with direct field access like in smmu_base_realize

Ok.
=20
> in QEMU with PCI, usually we specify bus to attach to with 'bus' property=
,
> wouldn't it better to rename "primary-bus" to 'bus' to be consistent with
> the rest of PCI code (and before "primary-bus" shows up as a CLI option,
> so far (before this series) it looks like it's an internal property)?

That was tried in v2 and since SMMUv3 is not a pci device by itself(it is a=
=20
sysbus device) reusing the default "bus" property to establish an associati=
on
with a PCI bus created problems,
https://lore.kernel.org/qemu-devel/877c2ut0zk.fsf@pond.sub.org/

=20
> > +    if (!bus || !object_dynamic_cast(bus->parent,
> TYPE_PCI_HOST_BRIDGE)) {
> Also looking at smmu_base_realize, it has NULL pointer check already.
> Which also rises question, shouldn't smmu_base_realize check for
> TYPE_PCI_HOST_BRIDGE as well (aka can smmu be attached to anything
> else but a host bridge)?

Not at the moment in Qemu. Though the SMMUv3 specification allows it to
be associated with non-pci devices as well.

Thanks,
Shameer

