Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D58AC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4vOC-0003gj-UT; Wed, 16 Apr 2025 01:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4vOA-0003fs-M1; Wed, 16 Apr 2025 01:32:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1u4vO7-0005sQ-Fg; Wed, 16 Apr 2025 01:32:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcqLt07wfz6M4ct;
 Wed, 16 Apr 2025 13:28:38 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CAD1140144;
 Wed, 16 Apr 2025 13:32:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 07:32:36 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Apr 2025 07:32:36 +0200
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
Subject: RE: [PATCH 1/5] hw/arm/smmuv3: Introduce SMMUv3 device
Thread-Topic: [PATCH 1/5] hw/arm/smmuv3: Introduce SMMUv3 device
Thread-Index: AQHbrd4wHiQuJHoKEkaF+k+tUIN96LOlhaaAgAA/jIA=
Date: Wed, 16 Apr 2025 05:32:36 +0000
Message-ID: <5de48a047d6b4076b033cbe4fa10a803@huawei.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <20250415081104.71708-2-shameerali.kolothum.thodi@huawei.com>
 <Z/8m8cFLY1vEjHpA@Asurada-Nvidia>
In-Reply-To: <Z/8m8cFLY1vEjHpA@Asurada-Nvidia>
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
> Sent: Wednesday, April 16, 2025 4:42 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
> mochs@nvidia.com; smostafa@google.com; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH 1/5] hw/arm/smmuv3: Introduce SMMUv3 device
>=20
> On Tue, Apr 15, 2025 at 09:11:00AM +0100, Shameer Kolothum wrote:
> > +static int smmuv3_dev_pcie_bus(Object *obj, void *opaque)
> > +{
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
> > +        return 1;
>=20
> Return 1 would break the caller's foreach. And I guess that's what
> we want since "primary-bus" should only be set once?

Yes. It will only set once and once you get it no need to iterate again.
>=20
> Maybe better to add a line of comments to explain that a bit?
Ok.

>=20
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void smmuv3_dev_realize(DeviceState *d, Error **errp)
> > +{
> > +    SMMUv3DevState *s_nested =3D ARM_SMMUV3_DEV(d);
> > +    SMMUv3DevClass *c =3D ARM_SMMUV3_DEV_GET_CLASS(s_nested);
>=20
Oops...that's probably from a prototype code I had earlier!.=20

Thanks,
Shameer

