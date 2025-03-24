Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A2C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkKI-0004g4-52; Mon, 24 Mar 2025 12:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1twkK1-0004cC-NW; Mon, 24 Mar 2025 12:06:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1twkJx-0004RT-EQ; Mon, 24 Mar 2025 12:06:40 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZLyWv73plz6K9WH;
 Tue, 25 Mar 2025 00:03:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4084D140723;
 Tue, 25 Mar 2025 00:06:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Mar 2025 17:06:33 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 24 Mar 2025 17:06:33 +0100
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Thread-Topic: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie
 bus
Thread-Index: AQHbkps6in4QB/PMZUednFRw1zRmILN5b66AgADGVyCAAgfGgIAFxokwgABCuACAAC8TgIAAERjQ
Date: Mon, 24 Mar 2025 16:06:32 +0000
Message-ID: <85fe1320d25b46189721f2a796f7da22@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
 <Z9xKL49nOenvQIsW@Asurada-Nvidia>
 <2f84490d309440a4a2ac56fd893ddab8@huawei.com>
 <ad0b5fac-2a7f-4978-9f6b-0f7b1df14a35@redhat.com>
 <Z+GB7c0ME//DhS3R@nvidia.com>
In-Reply-To: <Z+GB7c0ME//DhS3R@nvidia.com>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
> Sent: Monday, March 24, 2025 4:02 PM
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Donald Dutile
> <ddutile@redhat.com>; qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> peter.maydell@linaro.org; jgg@nvidia.com; berrange@redhat.com;
> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
> pcie bus
>=20
> On Mon, Mar 24, 2025 at 02:13:20PM +0100, Eric Auger wrote:
> > >> If VM has an emulated device and a passthrough device:
> > >>  attach the emulated device to PCIE.0 <=3D> vSMMU bypass (or
> accel=3Doff?)
> > >>  attach the passthrough device to pxb-pcie <=3D> vSMMU0 (accel=3Don)
> > > This can be other way around as well:
> > > ie,
> > > pass-through to pcie.0(accel=3Don) and emulated to any other pxb-pcie
> with accel =3D off.
> > +1
> > >
> > > I think the way bus numbers are allocated in Qemu for pcie.0 and pxb-
> pcie allows
> > > us to support this in IORT ID maps.
> > One trouble we may get into is possible bus reordering by the guest. I
> > don't know the details but I remember that in certain conditions the
> > guest can reorder the bus numbers.
>=20
> Hmm, that sounds troublesome. IORT mappings are done using the bus
> number, which is fixed to a vSMMU. Can we disable that reordering?

DSM 5# is actually a way to do that. But I don't think we need that as host
kernel also will have the same issues with IORT if re enumeration happens.
I think the iommu_fwspec mechanism is to take care of this. I need to doubl=
e
check though.
=20
Thanks,
Shameer

