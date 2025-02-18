Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE71CC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 06:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHTO-0003dA-Hf; Tue, 18 Feb 2025 01:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tkHTE-0003cS-5a; Tue, 18 Feb 2025 01:52:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tkHTB-0007TL-Il; Tue, 18 Feb 2025 01:52:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yxqrw2mHsz6M4P2;
 Tue, 18 Feb 2025 14:49:52 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 906881400DA;
 Tue, 18 Feb 2025 14:52:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Feb 2025 07:52:26 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 18 Feb 2025 07:52:26 +0100
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Donald Dutile <ddutile@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAAxlYAIAS3VEAgABWAvCAACxmsIAnKXxwgAFsm4A=
Date: Tue, 18 Feb 2025 06:52:26 +0000
Message-ID: <c975f6dfaa9243c5a2db9e37d592ea51@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
 <Z5HBJOgO4tUJApY+@nvidia.com> <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
 <SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744B3D96A98584525B0401292FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744B3D96A98584525B0401292FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.112]
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

Hi Zhenzhong,

> -----Original Message-----
> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Monday, February 17, 2025 9:17 AM
> To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Nicolin Chen
> <nicolinc@nvidia.com>; Donald Dutile <ddutile@redhat.com>
> Cc: eric.auger@redhat.com; Peter Maydell <peter.maydell@linaro.org>;
> Jason Gunthorpe <jgg@nvidia.com>; Daniel P. Berrang=E9
> <berrange@redhat.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org; Peng, Chao P <chao.p.peng@intel.com>
> Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
> nested SMMUv3
>=20
> Hi Shameer, Nicolin,
>=20
[...]

> >>Hi Zhenzhong,
> >>
> >>Just wondering what your plans are for the above patches.  If it make
> sense and
> >>you
> >>are fine with it, I think it is a good idea one of us can pick up those=
 from
> that
> >>series
> >>and sent out separately so that it can get some review and take it
> forward.
> >
> >Emulated series is merged, I plan to send Intel pass-through series afte=
r
> >Chinese festival vacation, but at least half a month later. So feel free=
 to
> >pick those patches you need and send for comments.
>=20
> I plan to send vtd nesting series out this week and want to ask about sta=
tus
> of "1) HWPT uAPI patches in backends/iommufd.c" series.
>=20
> If you had sent it out, I will do a rebase and bypass them to avoid dupli=
cate
> review effort in community. Or I can send them in vtd nesting series if y=
ou
> not yet.

No. It is not send out yet. Please include it in your vtd nesting series. T=
hanks.

I am currently working on refactoring the SMMUv3 accel series and the
"Add HW accelerated nesting support for arm SMMUv3" series
from Nicolin.

Thanks,
Shameer.



