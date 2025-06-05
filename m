Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812D4C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9qT-0000JS-8B; Thu, 05 Jun 2025 08:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uN9qJ-0000FN-U7; Thu, 05 Jun 2025 08:37:13 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uN9qD-0008E2-U4; Thu, 05 Jun 2025 08:37:11 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bCkS5374nz6K9bj;
 Thu,  5 Jun 2025 20:35:17 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 37BA61402FE;
 Thu,  5 Jun 2025 20:36:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 14:36:53 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 5 Jun 2025 14:36:52 +0200
To: Igor Mammedov <imammedo@redhat.com>
CC: Shameer Kolothum via <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root Complex
 association
Thread-Topic: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root Complex
 association
Thread-Index: AQHb09UMySB7lOszwECrIiqSkZXavbP0R3UAgAAnHLD///BrgIAAJS4g
Date: Thu, 5 Jun 2025 12:36:52 +0000
Message-ID: <83a0966672fc4785817784dbdf08aef3@huawei.com>
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-2-shameerali.kolothum.thodi@huawei.com>
 <20250605125518.138f5172@imammedo.users.ipa.redhat.com>
 <065bbd4ee15442b58e15b298614cf5dd@huawei.com>
 <20250605141931.1704c6a5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250605141931.1704c6a5@imammedo.users.ipa.redhat.com>
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
> Sent: Thursday, June 5, 2025 1:20 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Shameer Kolothum via <qemu-devel@nongnu.org>; qemu-
> arm@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
> jgg@nvidia.com; nicolinc@nvidia.com; ddutile@redhat.com;
> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org
> Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root
> Complex association

[..]

> > > in QEMU with PCI, usually we specify bus to attach to with 'bus'
> property,
> > > wouldn't it better to rename "primary-bus" to 'bus' to be consistent
> with
> > > the rest of PCI code (and before "primary-bus" shows up as a CLI opti=
on,
> > > so far (before this series) it looks like it's an internal property)?
> >
> > That was tried in v2 and since SMMUv3 is not a pci device by itself(it =
is a
> > sysbus device) reusing the default "bus" property to establish an
> association
> > with a PCI bus created problems,
> > https://lore.kernel.org/qemu-devel/877c2ut0zk.fsf@pond.sub.org/
>=20
> that was an approach was trying to workaround by patching dc->bus_type,
> which is obviously wrong.
>=20
> I'm not talking about changing device type or something similar,
> but about renaming 'primary-bus' property name to 'bus'

I have tried that earlier and gets this,
-device arm-smmuv3,bus=3Dpcie.0,id=3Dsmmuv3.0: Device 'arm-smmuv3' can't go=
 on PCIE bus

IIRC, the above mentioned patched dc->bus_type =3D TYPE_PCIE_BUS was used=20
to avoid that.

Or am I missing something here?

> so it would be consistent interface wise with PCI or other QEMU devices
> that are attached to a bus.
>=20
> > > > +    if (!bus || !object_dynamic_cast(bus->parent,
> > > TYPE_PCI_HOST_BRIDGE)) {
> > > Also looking at smmu_base_realize, it has NULL pointer check already.
> > > Which also rises question, shouldn't smmu_base_realize check for
> > > TYPE_PCI_HOST_BRIDGE as well (aka can smmu be attached to anything
> > > else but a host bridge)?
> >
> > Not at the moment in Qemu. Though the SMMUv3 specification allows it
> to
> > be associated with non-pci devices as well.
>=20
> then perhaps move, the check to smmu_base_realize() for now?
>=20
> if smmu + non-pci ever materialize, it can be refactored at that time.

Ok.

Thanks,
Shameer

