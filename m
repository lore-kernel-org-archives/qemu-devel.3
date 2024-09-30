Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19335CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDuX-0007Mh-6Q; Mon, 30 Sep 2024 06:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1svDuU-0007La-DW; Mon, 30 Sep 2024 06:45:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1svDuR-00072r-K0; Mon, 30 Sep 2024 06:45:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XHHgB1rhQz6LD6x;
 Mon, 30 Sep 2024 18:41:26 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 1E038140155;
 Mon, 30 Sep 2024 18:45:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 12:45:31 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 30 Sep 2024 12:45:31 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, "Andrea Bolognani" <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>
Subject: RE: nested-smmuv3 topic, Sep 2024
Thread-Topic: nested-smmuv3 topic, Sep 2024
Thread-Index: AQHa/21fMRq+vkBZBEO3I0aIbruIbrJJJAMQgABy+wCAJrBFsA==
Date: Mon, 30 Sep 2024 10:45:31 +0000
Message-ID: <e06e0a8a89d74d88b653d4f49d0b08fe@huawei.com>
References: <ZtlrLJzZqpnUrZQf@Asurada-Nvidia>
 <d0e3a60713da4ff1bb10245e789ecf24@huawei.com> <ZtoWVjmSXfQStlkF@nvidia.com>
In-Reply-To: <ZtoWVjmSXfQStlkF@nvidia.com>
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
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
> Sent: Thursday, September 5, 2024 9:37 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Eric Auger <eric.auger@redhat.com>; Mostafa Saleh
> <smostafa@google.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>; Jason
> Gunthorpe <jgg@nvidia.com>; Jean-Philippe Brucker <jean-
> philippe@linaro.org>; Moritz Fischer <mdf@kernel.org>; Michael Shavit
> <mshavit@google.com>; Andrea Bolognani <abologna@redhat.com>;
> Michael S. Tsirkin <mst@redhat.com>; Peter Xu <peterx@redhat.com>
> Subject: Re: nested-smmuv3 topic, Sep 2024
>=20
> Hi Shameer,
>=20
> Thanks for the reply!
>=20
> On Thu, Sep 05, 2024 at 12:55:52PM +0000, Shameerali Kolothum Thodi
> wrote:
> > > The main takeaway from the discussion is to
> > > 1) Turn the vSMMU module into a pluggable one, like intel-iommu
> > > 2) Move the per-SMMU pxb bus and device auto-assign into libvirt
> > >
> > > Apart from the multi-vSMMU thing, there's basic nesting series:
> > > 0) Keep updating to the latest kernel uAPIs to support nesting
> >
> > By this you mean the old HWPT based nested-smmuv3 support?
>=20
> HWPT + vIOMMU. The for-viommu/virq branches that I shared in my
> kernel series have those changes. Invalidations is done via the
> vIOMMU infrastructure.
>=20
> > >
> > > I was trying to do all these three, but apparently too ambitious.
> > > The kernel side of work is still taking a lot of my bandwidth. So
> > > far I had almost-zero progress on task (1) and completely-zero on
> > > task (2).
> > >
> > > <-- Help Needed --->
> > > So, I'm wondering if anyone(s) might have some extra bandwidth in
> > > the following months helping these two tasks, either of which can
> > > be a standalone project I think.
> > >
> > > For task (0), I think I can keep updating the uAPI part, although
> > > it'd need some help for reviews, which I was hoping to occur after
> > > Intel sends the QEMU nesting backend patches. Once we know how big
> > > the rework is going to be, we may need to borrow some help at that
> > > point once again..
> >
> > I might have some bandwidth starting October and can take a look at
> > task 1 above. I haven't gone through the VIOMMU API model completely
> > yet and plan to do that soon.
>

I had  an initial look at this and also had some discussions with Eric at K=
VM
Forum(Thanks Eric!).

Going through the code, is it ok to introduce a "pci-bus" for the proposed
nested SMMUv3 device which will create the link between the SMMUv3 dev=20
and the associated root complex(pxb-pcie).

Something like below,

-device pxb-pcie,id=3Dpcie.1,bus_nr=3D2,bus=3Dpcie.0 \
-device arm-nested-smmuv3,pci-bus=3Dpcie.1 \
-device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1 \
-device vfio-pci,host=3D0000:75:00.1, bus=3Dpcie.port1 \
...
-device pxb-pcie,id=3Dpcie.2,bus_nr=3D8,bus=3Dpcie.0 \
-device arm-nested-smmuv3,pci-bus=3Dpcie.2 \
-device pcie-root-port,id=3Dpcie.port2,bus=3Dpcie.2 \
-device vfio-pci,host=3D0000:75:00.2, bus=3Dpcie.port2 \

This way we can invoke the pci_setup_iommu() with the=20
right PCIBus during the nested SMMUv3 device realize fn.

Please let me know, if this works/scales with all the use cases we have.

Also Eric mentioned that when he initially added the support for SMMUv3,
the initial approach was -device based solution, but later changed to machi=
ne
option instead based on review comments. I managed to find the link where
this change was proposed(by Peter),

https://lore.kernel.org/all/CAFEAcA_H+sraWNVhEZc48eS11n6dC9CyEwTL44tPERiPBO=
+hbw@mail.gmail.com/

I hope the use cases we now have make it reasonable to introduce a "-device=
 arm-nested-smmuv3" model.
Please let me know if there are still objections to going this way.

Thanks,
Shameer




