Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CD2C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasa8-00014S-WF; Thu, 23 Jan 2025 03:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tasa7-00014G-1x; Thu, 23 Jan 2025 03:28:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tasa0-0003m3-LL; Thu, 23 Jan 2025 03:28:54 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YdvGS72Sbz6HJbD;
 Thu, 23 Jan 2025 16:28:16 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F2C2140498;
 Thu, 23 Jan 2025 16:28:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 Jan 2025 09:28:34 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 23 Jan 2025 09:28:34 +0100
To: Nicolin Chen <nicolinc@nvidia.com>, Donald Dutile <ddutile@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAAxlYAIAS3VEAgABWAvA=
Date: Thu, 23 Jan 2025 08:28:34 +0000
Message-ID: <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
 <Z5HBJOgO4tUJApY+@nvidia.com>
In-Reply-To: <Z5HBJOgO4tUJApY+@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.043, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, January 23, 2025 4:10 AM
> To: Donald Dutile <ddutile@redhat.com>
> Cc: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; eric.auger@redhat.com; Peter
> Maydell <peter.maydell@linaro.org>; Jason Gunthorpe <jgg@nvidia.com>;
> Daniel P. Berrang=E9 <berrange@redhat.com>; qemu-arm@nongnu.org;
> qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; Wangzhou
> (B) <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org
> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
> nested SMMUv3
>=20
> Hi Don,
>=20
> On Fri, Jan 10, 2025 at 11:05:24PM -0500, Donald Dutile wrote:
> > On 1/8/25 11:45 PM, Nicolin Chen wrote:
> > > On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi
> wrote:
> > > > And patches prior to this commit adds that support:
> > > > 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for arm
> > > > SMMUv3")
> > > >
> > > > Nicolin is soon going to send out those for review. Or I can includ=
e
> > > > those in this series so that it gives a complete picture. Nicolin?
> > >
> > > Just found that I forgot to reply this one...sorry
> > >
> > > I asked Don/Eric to take over that vSMMU series:
> > > https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
> > > (The majority of my effort has been still on the kernel side:
> > >   previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
> > >
> > > Don/Eric, is there any update from your side?
> > >
> > Apologies for delayed response, been at customer site, and haven't been
> keeping up w/biz email.
> > Eric is probably waiting for me to get back and chat as well.
> > Will look to reply early next week.
>=20
> I wonder if we can make some progress in Feb? If so, we can start
> to wrap up the iommufd uAPI patches for HWPT, which was a part of
> intel's series but never got sent since their emulated series is
> seemingly still pending?

I think these are the  5 patches that we require from Intel pass-through se=
ries,

vfio/iommufd: Implement [at|de]tach_hwpt handlers
vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
HostIOMMUDevice: Introduce realize_late callback
vfio/iommufd: Add properties and handlers to TYPE_HOST_IOMMU_DEVICE_IOMMUFD
backends/iommufd: Add helpers for invalidating user-managed HWPT

See the commits from here,
https://github.com/hisilicon/qemu/commit/bbdc65af38fa5723f1bd9b026e29273090=
1f57b5

[CC  Zhenzhong]

Hi Zhenzhong,

Just wondering what your plans are for the above patches.  If it make sense=
 and you
are fine with it, I think it is a good idea one of us can pick up those fro=
m that series
and sent out separately so that it can get some review and take it forward.

Thanks,
Shameer
=20


