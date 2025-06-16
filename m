Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6163C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 11:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR7v2-0006GQ-V7; Mon, 16 Jun 2025 07:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uR7v1-0006Fw-7y; Mon, 16 Jun 2025 07:22:27 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uR7uz-0005IS-Ec; Mon, 16 Jun 2025 07:22:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLSGQ4mj4z6L5PD;
 Mon, 16 Jun 2025 19:20:14 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id B836E140119;
 Mon, 16 Jun 2025 19:22:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 13:22:21 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 16 Jun 2025 13:22:21 +0200
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm
 <linuxarm@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, "Wangzhou
 (B)" <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v4 3/7] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Topic: [PATCH v4 3/7] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Index: AQHb3HIk563rOMpuqEagBYqLye3hgbQFf90AgAAo1gA=
Date: Mon, 16 Jun 2025 11:22:21 +0000
Message-ID: <a7591aab15e646c08e03636061175bb1@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-4-shameerali.kolothum.thodi@huawei.com>
 <20250616115502.000030d5@huawei.com>
In-Reply-To: <20250616115502.000030d5@huawei.com>
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Monday, June 16, 2025 11:55 AM
> To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH v4 3/7] hw/arm/virt-acpi-build: Update IORT for
> multiple smmuv3 devices
>=20
> On Fri, 13 Jun 2025 15:44:45 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > With the soon to be introduced user-creatable SMMUv3 devices for
> > virt, it is possible to have multiple SMMUv3 devices associated
> > with different PCIe root complexes.
> >
> > Update IORT nodes accordingly.
> >
> > An example IORT Id mappings for a Qemu virt machine with two
> > PCIe Root Complexes each assocaited with a SMMUv3 will
> > be something like below,
> >
> >   -device arm-smmuv3,primary-bus=3Dpcie.0,id=3Dsmmuv3.0
> >   -device arm-smmuv3,primary-bus=3Dpcie.1,id=3Dsmmuv3.1
> >   ...
> >
> >   +--------------------+           +--------------------+
> >   |   Root Complex 0   |           |   Root Complex 1   |
> >   |                    |           |                    |
> >   |  Requestor IDs     |           |  Requestor IDs     |
> >   |  0x0000 - 0x00FF   |           |  0x0100 - 0x01FF   |
> >   +---------+----------+           +---------+----------+
> >             |                               |
> >             |                               |
> >             |       Stream ID Mapping       |
> >             v                               v
> >   +--------------------+          +--------------------+
> >   |    SMMUv3 Node 0   |          |    SMMUv3 Node 1   |
> >   |                    |          |                    |
> >   | Stream IDs 0x0000- |          | Stream IDs 0x0100- |
> >   | 0x00FF mapped from |          | 0x01FF mapped from |
> >   | RC0 Requestor IDs  |          | RC1 Requestor IDs  |
> >   +--------------------+          +--------------------+
> >             |                                |
> >             |                                |
> >             +----------------+---------------+
> >                              |
> >                              |Device ID Mapping
> >                              v
> >               +----------------------------+
> >               |       ITS Node 0           |
> >               |                            |
> >               | Device IDs:                |
> >               | 0x0000 - 0x00FF (from RC0) |
> >               | 0x0100 - 0x01FF (from RC1) |
> >               | 0x0200 - 0xFFFF (No SMMU)  |
> >               +----------------------------+
> >
> > Tested-by: Nathan Chen <nathanc@nvidia.com>
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> Seems fine to me.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>=20
> Other than needs a bios table test :)

Sure, Will add one.

Thanks,
Shameer


