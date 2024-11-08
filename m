Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC39D5C0C3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Ofy-0002Ir-HQ; Fri, 08 Nov 2024 08:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t9Ofv-0002IQ-Ic; Fri, 08 Nov 2024 08:05:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1t9Ofs-00082D-Vt; Fri, 08 Nov 2024 08:05:19 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlK0y5n9gz6DBXr;
 Fri,  8 Nov 2024 21:05:06 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 3AB5E140B3C;
 Fri,  8 Nov 2024 21:05:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 14:05:11 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 8 Nov 2024 14:05:11 +0100
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
Thread-Index: AQHbLBPkDYWW/RlwrUqSJByfpx0jw7KisNtQgAAO5ACACqTPgA==
Date: Fri, 8 Nov 2024 13:05:11 +0000
Message-ID: <3e452b1e4d634e8da8e939e1ba89075e@huawei.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <cf4359b18f0d44f09b8901141b678a09@huawei.com>
 <ZyUsClNQwcIkjdZo@Asurada-Nvidia>
In-Reply-To: <ZyUsClNQwcIkjdZo@Asurada-Nvidia>
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, November 1, 2024 7:29 PM
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
> Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
>=20
> On Fri, Nov 01, 2024 at 06:35:23PM +0000, Shameerali Kolothum Thodi
> wrote:
> > > @Shameer,
> > > Do you have some update on the pluggable smmuv3 module?
> >
> > I have a bare minimum prototype code that works with a pluggable
> smmuv3.
> >
> > ...
> > -device pxb-pcie,id=3Dpcie.1,bus_nr=3D2,bus=3Dpcie.0 \
> > -device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1 \
> > -device arm-smmuv3-nested,id=3Dsmmuv1,pci-bus=3Dpcie.1 \
> > -device vfio-pci-
> nohotplug,host=3D0000:75:00.1,bus=3Dpcie.port1,iommufd=3Diommufd0 \
> > -device pxb-pcie,id=3Dpcie.2,bus_nr=3D8,bus=3Dpcie.0 \
> > -device pcie-root-port,id=3Dpcie.port2,bus=3Dpcie.2,chassis=3D8 \
> > -device arm-smmuv3-nested,id=3Dsmmuv2,pci-bus=3Dpcie.2 \
> > -device vfio-pci-
> nohotplug,host=3D0000:7d:02.1,bus=3Dpcie.port2,iommufd=3Diommufd0 \
> > ...
> >
> > Something like above can now boot a Guest with the latest kernel. But I
> am not
> > sure it actually works correctly. I need a bit more time to update this=
 and
> carry
> > out some tests. Will target that in Nov.
>=20
> That looks nice to me! Thanks for the update.

I have sent out an initial RFC here(Might have missed CC few in this email.=
 Apologies.),
https://lore.kernel.org/qemu-devel/20241108125242.60136-1-shameerali.koloth=
um.thodi@huawei.com/

Please take a look and let me know.

Thanks,
Shameer



