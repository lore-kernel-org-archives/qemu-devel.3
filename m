Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECD1E6F068
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wUl-00022D-RZ; Fri, 01 Nov 2024 14:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t6wUj-00021a-NP; Fri, 01 Nov 2024 14:35:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t6wUg-00072r-Sn; Fri, 01 Nov 2024 14:35:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg8cM6jNwz6K6NM;
 Sat,  2 Nov 2024 02:32:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1B634140517;
 Sat,  2 Nov 2024 02:35:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 19:35:23 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 1 Nov 2024 19:35:23 +0100
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, "Andrea Bolognani" <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "arighi@nvidia.com" <arighi@nvidia.com>, "ianm@nvidia.com" <ianm@nvidia.com>, 
 "jan@nvidia.com" <jan@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>
Subject: RE: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Topic: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Thread-Index: AQHbLBPkDYWW/RlwrUqSJByfpx0jw7KisNtQ
Date: Fri, 1 Nov 2024 18:35:23 +0000
Message-ID: <cf4359b18f0d44f09b8901141b678a09@huawei.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
In-Reply-To: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


Hi Nicolin,

> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, November 1, 2024 4:09 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Eric Auger <eric.auger@redhat.com>; Mostafa Saleh
> <smostafa@google.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>; Jason
> Gunthorpe <jgg@nvidia.com>; Jean-Philippe Brucker <jean-
> philippe@linaro.org>; Moritz Fischer <mdf@kernel.org>; Michael Shavit
> <mshavit@google.com>; Andrea Bolognani <abologna@redhat.com>;
> Michael S. Tsirkin <mst@redhat.com>; Peter Xu <peterx@redhat.com>;
> Zhangfei Gao <zhangfei.gao@linaro.org>; nathanc@nvidia.com;
> arighi@nvidia.com; ianm@nvidia.com; jan@nvidia.com; mochs@nvidia.com
> Subject: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
>=20
> Hi,
>=20
> This is a continued discussion following previous month's:
> https://lore.kernel.org/qemu-devel/Zvr%2Fbf7KgLN1cjOl@Asurada-Nvidia/
>=20
> Kernel changes are getting closer to merge, as Jason's planning to
> take vIOMMU series and smmuv3_nesting series into the iommufd tree:
> https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
> https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
> https://lore.kernel.org/all/0-v4-9e99b76f3518+3a8-
> smmuv3_nesting_jgg@nvidia.com/
>=20
> So, I think it's probably a good time to align with each others and
> talk about kicking off some QEMU upstream work in the month ahead.
>=20
> @Shameer,
> Do you have some update on the pluggable smmuv3 module?

I have a bare minimum prototype code that works with a pluggable smmuv3.

...
-device pxb-pcie,id=3Dpcie.1,bus_nr=3D2,bus=3Dpcie.0 \
-device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1 \
-device arm-smmuv3-nested,id=3Dsmmuv1,pci-bus=3Dpcie.1 \
-device vfio-pci-nohotplug,host=3D0000:75:00.1,bus=3Dpcie.port1,iommufd=3Di=
ommufd0 \
-device pxb-pcie,id=3Dpcie.2,bus_nr=3D8,bus=3Dpcie.0 \
-device pcie-root-port,id=3Dpcie.port2,bus=3Dpcie.2,chassis=3D8 \
-device arm-smmuv3-nested,id=3Dsmmuv2,pci-bus=3Dpcie.2 \
-device vfio-pci-nohotplug,host=3D0000:7d:02.1,bus=3Dpcie.port2,iommufd=3Di=
ommufd0 \
...

Something like above can now boot a Guest with the latest kernel. But I am =
not
sure it actually works correctly. I need a bit more time to update this and=
 carry
out some tests. Will target that in Nov.

>=20
> Updates on my side:
> 1) I have kept uAPI updated to the latest version and verified too.
>    There should be some polishing changes depending on how the basic
>    nesting infrastructure would look like from Intel/Duan's work.
> 2) I got some help from NVIDIA folks for the libvirt task. And they
>    have done some drafting and are now verifying the PCI topology
>    with "iommu=3Dnone".
>=20
> Once the pluggable smmuv3 module is ready to test, we will make some
> change to libvirt for that and drop the auto-assigning patches from
> the VIRT code, so as to converge for a libvirt+QEMU test.

One query I have is, do Qemu still need to check whether the VFIO devices a=
re
assigned correctly behind the nested vSMMUv3 w.r.t the phys SMMUv3s or not?
Or we can just trust whatever the user/libvirt specifies?

(I think even if we don't explicitly check, at present  it will eventually =
fail in s2
HWPT attach  for the viommu if it belongs to a different phys SMMUv3).

Thanks,
Shameer

