Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B56C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riA9t-0001Bx-F0; Thu, 07 Mar 2024 04:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riA9o-0001Am-PP; Thu, 07 Mar 2024 04:35:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riA9g-00082f-0D; Thu, 07 Mar 2024 04:35:20 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr3td5vtXz6K5Z2;
 Thu,  7 Mar 2024 17:30:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 1D1B9140736;
 Thu,  7 Mar 2024 17:35:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 09:35:06 +0000
Date: Thu, 7 Mar 2024 09:35:05 +0000
To: Ankit Agrawal <ankita@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, "Uday Dhoke" <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20240307093505.000000fc@Huawei.com>
In-Reply-To: <SA1PR12MB71997549A6120677BEDF2287B0202@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240306123317.4691-1-ankita@nvidia.com>
 <20240306123317.4691-3-ankita@nvidia.com>
 <20240306135847.00007876@Huawei.com>
 <SA1PR12MB71997549A6120677BEDF2287B0202@SA1PR12MB7199.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 7 Mar 2024 03:03:02 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >>
> >> [1] ACPI Spec 6.3, Section 5.2.16.6
> >> [2] ACPI Spec 6.3, Table 5.80
> >>
> >> Cc: Jonathan Cameron <qemu-devel@nongnu.org>
> >> Cc: Alex Williamson <alex.williamson@redhat.com>
> >> Cc: Cedric Le Goater <clg@redhat.com>
> >> Signed-off-by: Ankit Agrawal <ankita@nvidia.com> =20
> >
> > I guess we gloss over the bisection breakage due to being able to add
> > these nodes and have them used in HMAT as initiators before we have
> > added SRAT support.=A0 Linux will moan about it and not use such an HMAT
> > but meh, it will boot.
> >
> > You could drag the HMAT change after this but perhaps it's not worth bo=
thering. =20
>=20
> Sorry this part isn't clear to me. Are you suggesting we keep the HMAT
> changes out from this patch?

No - don't drop them. Move them from patch 1 to either patch 2, or to a
patch 3 if that ends up looking clearer.  I think patch 2 is the
right choice though as that enables everything at once.

It's valid to have SRAT containing GI entries without the same in HMAT
(as HMAT doesn't have to be complete), it's not valid to have HMAT refer
to entries that aren't in SRAT.

Another thing we may need to do add in the long run is the _OSC support.
That's needed for DSDT entries with _PXM associated with a GI only node
so that we can make them move node depending on whether or not the
Guest OS supports GIs and so will create the nodes.  Requires a bit of
magic AML to make that work.

It used to crash linux if you didn't do that, but that's been fixed
for a while I believe.

For now we aren't adding any such _PXM entries though so this is just
one for the TODO list :)


>=20
> > Otherwise LGTM
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
>=20
> Thanks!
>=20
> > Could add x86 support (posted in reply to v7 this morning)
> > and sounds like you have the test nearly ready which is great. =20
>=20
> Ok, will add the x86 part as well. I could reuse what you shared
> earlier.
>=20
> https://gitlab.com/jic23/qemu/-/commit/ccfb4fe22167e035173390cf147d9c2269=
51b9b6
Excellent - thanks!

Jonathan

>=20
>=20
>=20


