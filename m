Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21DFC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfzDG-0000XT-PG; Thu, 06 Feb 2025 05:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tfzDE-0000Wu-Cl; Thu, 06 Feb 2025 05:34:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tfzDB-0001TM-0y; Thu, 06 Feb 2025 05:34:24 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpYLk4TwZz6H8Vk;
 Thu,  6 Feb 2025 18:31:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 9F1D51408F9;
 Thu,  6 Feb 2025 18:34:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Feb 2025 11:34:15 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 6 Feb 2025 11:34:15 +0100
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "ddutile@redhat.com" <ddutile@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAI176AIAE12cAgAGBGYCAAGn5AIACTjRQ
Date: Thu, 6 Feb 2025 10:34:15 +0000
Message-ID: <8224c38797344d1a9c0f453774925db3@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
 <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
 <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
In-Reply-To: <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
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
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, PDS_BTC_ID=0.498,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 THREAD_INDEX_BAD=3.197 autolearn=no autolearn_force=no
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
> Sent: Wednesday, February 5, 2025 12:09 AM
> To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Eric Auger
> <eric.auger@redhat.com>
> Cc: ddutile@redhat.com; Peter Maydell <peter.maydell@linaro.org>; Jason
> Gunthorpe <jgg@nvidia.com>; Daniel P. Berrang=E9 <berrange@redhat.com>;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
> nested SMMUv3
>=20
> On Tue, Feb 04, 2025 at 06:49:15PM +0100, Eric Auger wrote:
> > > In summary, we will have the following series:
> > > 1) HWPT uAPI patches in backends/iommufd.c (Zhenzhong or Shameer)
> > >    https://lore.kernel.org/qemu-
> devel/SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.nam
> prd11.prod.outlook.com/
> > > 2) vIOMMU uAPI patches in backends/iommufd.c (I will rebase/send)
>=20
> > for 1 and 2, are you taking about the "Add VIOMMU infrastructure
> support
> > " series in Shameer's branch: private-smmuv3-nested-dev-rfc-v1.
> > Sorry I may instead refer to NVidia or Intel's branch but I am not sure
> > about the last ones.
>=20
> That "vIOMMU infrastructure" is for 2, yes.
>=20
> For 1, it's inside the Intel's series:
> "cover-letter: intel_iommu: Enable stage-1 translation for passthrough
> device"
>=20
> So, we need to extract them out and make it separately..
>=20
> > > 3) vSMMUv3 patches for HW-acc/nesting (Hoping Don/you could take
> over)
> > We can start sending it upstream assuming we have a decent test
> environment.
> >
> > However in
> >
> https://lore.kernel.org/all/329445b2f68a47269292aefb34584375@huawei.c
> om/
> >
> > Shameer suggested he may include it in his SMMU multi instance series.
> > What do you both prefer?
>=20
> Sure, I think it's good to include those patches,=20

One of the feedback I received on my series was to rename "arm-smmuv3-neste=
d"
to "arm-smmuv3-accel" and possibly rename function names to include "accel'=
 as well
and move those functions to a separate "smmuv3-accel.c" file. I suppose tha=
t applies to=20
the " Add HW accelerated nesting support for arm SMMUv3" series as well.=20

Is that fine with you?

Thanks,
Shameer


