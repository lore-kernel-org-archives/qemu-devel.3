Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4516FC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Nd-0006ZO-JG; Tue, 27 Feb 2024 12:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rf1Nb-0006Ye-Ge; Tue, 27 Feb 2024 12:36:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rf1NT-0004DC-D0; Tue, 27 Feb 2024 12:36:35 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tkl0d1mq7z6K5kl;
 Wed, 28 Feb 2024 01:32:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 92C8314058E;
 Wed, 28 Feb 2024 01:36:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:36:22 +0000
Date: Tue, 27 Feb 2024 17:36:21 +0000
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Ankit Agrawal
 <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, "Matt Ochs" <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, "Kirti Wankhede"
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20240227173621.00003694@Huawei.com>
In-Reply-To: <20240227171115.00004c7b@Huawei.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71992ECFBF9FA3EE3C350EA8B0592@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240227171115.00004c7b@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 27 Feb 2024 17:11:15 +0000
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Tue, 27 Feb 2024 08:37:15 +0000
> Ankit Agrawal <ankita@nvidia.com> wrote:
>=20
> > Thanks Jonathan for reviewing the change.
> >=20
> > Comments inline.
> >  =20
> > >> The structure needs a PCI device handle [2] that consists of the dev=
ice BDF.
> > >> The vfio-pci device corresponding to the acpi-generic-initiator obje=
ct is
> > >> located to determine the BDF.
> > >>
> > >> [1] ACPI Spec 6.3, Section 5.2.16.6
> > >> [2] ACPI Spec 6.3, Table 5.80
> > >>
> > >> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>   =20
> > >Hi Ankit,
> > >
> > > As the code stands the use of a list seems overkill.   =20
> >=20
> > Yeah, I will try out your suggestion.
> >  =20
> > > Otherwise looks good to me.=A0 I need Generic Ports support for CXL
> > > stuff so will copy your approach for that as it's ended up nice
> > > and simple.
> > >=20
> > > Jonathan   =20
> >=20
> > Nice, would be good to have uniform implementations. =20
>=20
> I've been messing around with this today.
>=20
> They differ only very trivially.
> 2 Options.
> 1) Have acpi-generic-port inherit from acpi-generic-initiator.
>    Works but implies a relationship that isn't really true.
> 2) Add an abstract base class. I've called it acpi-generic-node
>    and have bother acpi-generic-initiator and acpi-generic-port
>    inherit from it.
>=20
> The second feels more natural but is a tiny bit more code (a few
> more empty init / finalize functions.
>=20
> If we are going to end up with an abstract base 'object' it
> will be cleaner to do this all as one series if you don't mind
> carrying the generic port stuff as well? Or I can smash the
> two series together and send out an updated version that hopefully
> meets both our requirements (+ tests etc).
>=20
> I'm just running tests against the CXL qos / generic port code
> but assuming all goes well can share my additional changes
> in next day or two.
>=20
> Jonathan

One more thing.  Right now we can't use Generic Initiators as
HMAT initiators.  That also wants fixing given that's their
normal usecase rather than what you are using them for so it
should 'work'.

Jonathan

>=20
>=20
>=20


