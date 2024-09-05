Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8809CD5BC4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 12:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC20-000367-UL; Thu, 05 Sep 2024 08:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1smC1y-00031y-Mi; Thu, 05 Sep 2024 08:56:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1smC1u-000135-Lo; Thu, 05 Sep 2024 08:56:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wzzlb2CdJz6K98K;
 Thu,  5 Sep 2024 20:52:11 +0800 (CST)
Received: from lhrpeml100001.china.huawei.com (unknown [7.191.160.183])
 by mail.maildlp.com (Postfix) with ESMTPS id 508741400CA;
 Thu,  5 Sep 2024 20:55:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 13:55:53 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039; 
 Thu, 5 Sep 2024 13:55:52 +0100
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Mostafa Saleh <smostafa@google.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, "Andrea Bolognani" <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>
Subject: RE: nested-smmuv3 topic, Sep 2024
Thread-Topic: nested-smmuv3 topic, Sep 2024
Thread-Index: AQHa/21fMRq+vkBZBEO3I0aIbruIbrJJJAMQ
Date: Thu, 5 Sep 2024 12:55:52 +0000
Message-ID: <d0e3a60713da4ff1bb10245e789ecf24@huawei.com>
References: <ZtlrLJzZqpnUrZQf@Asurada-Nvidia>
In-Reply-To: <ZtlrLJzZqpnUrZQf@Asurada-Nvidia>
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
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thanks for the write up and task progress status.

> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, September 5, 2024 9:26 AM
> To: Eric Auger <eric.auger@redhat.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Mostafa Saleh
> <smostafa@google.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Peter Maydell
> <peter.maydell@linaro.org>; Jason Gunthorpe <jgg@nvidia.com>; Jean-
> Philippe Brucker <jean-philippe@linaro.org>; Moritz Fischer
> <mdf@kernel.org>; Michael Shavit <mshavit@google.com>; Andrea
> Bolognani <abologna@redhat.com>; Michael S. Tsirkin <mst@redhat.com>;
> Peter Xu <peterx@redhat.com>
> Subject: nested-smmuv3 topic, Sep 2024
>=20
> Hi all,
>=20
> Hope I didn't miss anybody who is related to the topic. Please,
> feel free to add!
>=20
> <--- Background --->
> As some of you know, there is an ongoing effort for nested-smmuv3
> support in QEMU on ARM, working with the kernel IOMMUFD uAPIs:
> [Nesting for vSTE]
> https://lore.kernel.org/linux-iommu/0-v2-621370057090+91fec-
> smmuv3_nesting_jgg@nvidia.com/
> [Nesting for invalidations]
> https://lore.kernel.org/linux-
> iommu/cover.1724776335.git.nicolinc@nvidia.com/
>=20
> The kernel patches are still under review. Jason and I are hoping
> them to get merged at next cycle for v6.13, which means the QEMU
> patches might start a review process as early as Nov/Dec?
>=20
> That being said, I think we are way behind the point that patches
> can get reviewed: most of the QEMU patches on my branches weren't
> touched very often, but merely updated to the latest kernel uAPIs
> for verification. So, I feel this might be a good point to gather
> folks together to discuss about the possible timeline and ask for
> help. I think this would potentially help folks who are going to
> attend the KVM forum (or LPC) to carry out a discussion. (Sorry,
> I won't make it due to some conflict..)
>=20
> <-- Task Breakdown --->
> I previously sent a RFCv1 series collecting comments/suggestions,
> for multi-vSMMU instance design in ARM Virt code:
> https://lore.kernel.org/qemu-
> devel/cover.1719361174.git.nicolinc@nvidia.com/
> (And thanks again for all the inputs!)
>=20
> The main takeaway from the discussion is to
> 1) Turn the vSMMU module into a pluggable one, like intel-iommu
> 2) Move the per-SMMU pxb bus and device auto-assign into libvirt
>=20
> Apart from the multi-vSMMU thing, there's basic nesting series:
> 0) Keep updating to the latest kernel uAPIs to support nesting

By this you mean the old HWPT based nested-smmuv3 support?

>=20
> I was trying to do all these three, but apparently too ambitious.
> The kernel side of work is still taking a lot of my bandwidth. So
> far I had almost-zero progress on task (1) and completely-zero on
> task (2).
>=20
> <-- Help Needed --->
> So, I'm wondering if anyone(s) might have some extra bandwidth in
> the following months helping these two tasks, either of which can
> be a standalone project I think.
>=20
> For task (0), I think I can keep updating the uAPI part, although
> it'd need some help for reviews, which I was hoping to occur after
> Intel sends the QEMU nesting backend patches. Once we know how big
> the rework is going to be, we may need to borrow some help at that
> point once again..

I might have some bandwidth starting October and can take a look at=20
task 1 above. I haven't gone through the VIOMMU API model completely
yet and plan to do that soon.

Also I am planning to attend KVM forum, so if there are anyone interested
to have  a chat on this, please let me know.

Thanks,
Shameer

