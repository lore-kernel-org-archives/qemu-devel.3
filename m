Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C21C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDeq-0005FI-1E; Fri, 11 Jul 2025 09:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uaDei-0005Ev-Si
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:19:14 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uaDee-0003SW-7S
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:19:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdshb3795z6M4kK;
 Fri, 11 Jul 2025 21:17:51 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id E2EC3140279;
 Fri, 11 Jul 2025 21:18:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Jul 2025 15:18:59 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 11 Jul 2025 15:18:59 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Donald Dutile <ddutile@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHb7/hbxXAwWQdQikCUUQpuT+n2ZLQo0noAgAEhcgCAABeeAIAA9YLQgAB6HICAAXFAAA==
Date: Fri, 11 Jul 2025 13:18:59 +0000
Message-ID: <b7853ab73c7e41d987d8f62f7e0b8560@huawei.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
 <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
 <b3787ed4219743e2a65edd13ff44d9b9@huawei.com>
 <aG/1U0qUq3lg0Dij@Asurada-Nvidia>
In-Reply-To: <aG/1U0qUq3lg0Dij@Asurada-Nvidia>
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, July 10, 2025 6:16 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Donald Dutile <ddutile@redhat.com>; Zhenzhong Duan
> <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org;
> alex.williamson@redhat.com; clg@redhat.com; eric.auger@redhat.com;
> mst@redhat.com; jasowang@redhat.com; peterx@redhat.com;
> jgg@nvidia.com; joao.m.martins@oracle.com; clement.mathieu--
> drif@eviden.com; kevin.tian@intel.com; yi.l.liu@intel.com;
> chao.p.peng@intel.com
> Subject: Re: [PATCH v3 02/20] hw/pci: Introduce
> pci_device_get_viommu_cap()
>=20
> On Thu, Jul 10, 2025 at 08:11:28AM +0000, Shameerali Kolothum Thodi
> wrote:
> > > So I suggested:
> > >      /* hardware-accelerated nested stage-1 page table support */
> > >     VIOMMU_CAP_NESTED_S1 =3D BIT_ULL(0),
> > >
> > > which it should be clear IMHO.
> > >
> > > If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
> >
> > I am not sure the _S1 part makes much sense in ARM case. It doesn't
> matter
> > whether the Guest SMMUv3 is configured in s1/s2 or nested for this CAP.
> > With the new SMMUv3 dev support, the user can pretty much specify,
> >
> > -device arm-smmuv3,primary-
> bus=3Dpcie.0,id=3Dsmmuv3.1,accel=3Don,stage=3D{stage1|stage2|nested}
> >
> > And I think it will work with a host SMMUv3 nested configuration in all
> the
> > above cases. Unless I am missing something and
> [...]
> > we need to restrict its
> > use with stage=3Dstage1 only.
>=20
> I think we do..
>=20
> The HW nesting works when we forward the s1ctxptr and make sure
> that "stage-1" is the last stage, in other word, the only stage.
>=20
> Otherwise how can we support stage2/nested in a HW nesting case?

Yep. That's right. Stage 2 is a no. But nesting may work if the Guest only
uses S1. But its better to restrict it to S1.

Thanks,
Shameer

