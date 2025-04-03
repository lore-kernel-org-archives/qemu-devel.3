Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A206C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MkX-0007S2-73; Thu, 03 Apr 2025 11:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0MkV-0007RX-DS
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0MkT-0006lm-2W
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743695094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCUmXe4lQw8kwpcV1m9kKrzOANsdo+ZWJUAnR/xsczo=;
 b=BIQGICd9+WYUvA0CVfK45uo8Tp9vFkBWWvbpwtg3eOZgJJ17s0QTO5qPTbIKNF0yjDbQPa
 Si9v5q2KOOjc884bC9giM7kX1Kv2uvon6NpFmPYAF2cK76m1NAHVBj8UzPhhbbDI4wkVaZ
 aEJsFnzfIH8lQe1yyuXxb9fsCIjEcYA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-C1NQWgsBN5iwopNFnswA0g-1; Thu,
 03 Apr 2025 11:44:53 -0400
X-MC-Unique: C1NQWgsBN5iwopNFnswA0g-1
X-Mimecast-MFC-AGG-ID: C1NQWgsBN5iwopNFnswA0g_1743695091
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5A3A19560B7; Thu,  3 Apr 2025 15:44:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.203])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB3BC1801752; Thu,  3 Apr 2025 15:44:43 +0000 (UTC)
Date: Thu, 3 Apr 2025 11:44:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, mjrosato@linux.ibm.com, Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
Message-ID: <20250403154442.GA349582@fedora>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GGcO0VCXMIAbRXJV"
Content-Disposition: inline
In-Reply-To: <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--GGcO0VCXMIAbRXJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:
> On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:
> > On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:
> > > Hi,
> > >=20
> > > Recently on s390x we have enabled mmap support for vfio-pci devices [=
1].
> >=20
> > Hi Alex,
> > I wanted to bring this to your attention. Feel free to merge it through
> > the VFIO tree, otherwise I will merge it once you have taken a look.
> >=20
> > Thanks,
> > Stefan
> >=20
> > > This allows us to take advantage and use userspace drivers on s390x. =
However,
> > > on s390x we have special instructions for MMIO access. Starting with =
z15=20
> > > (and newer platforms) we have new PCI Memory I/O (MIO) instructions w=
hich=20
> > > operate on virtually mapped PCI memory spaces, and can be used from u=
serspace.
> > > On older platforms we would fallback to using existing system calls f=
or MMIO access.
> > >=20
> > > This patch series introduces support the PCI MIO instructions, and en=
ables s390x
> > > support for the userspace NVMe driver on s390x. I would appreciate an=
y review/feedback
> > > on the patches.
> > >=20
> > > Thanks
> > > Farhan
>=20
> Hi Stefan,
>=20
> the kernel patch actually made it into Linus' tree for v6.15 already as
> commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
> for ISM devices") plus prerequisites. This went via the PCI tree
> because they included a change to struct pci_dev and also enabled
> mmap() on PCI resource files. Alex reviewed an earlier version and was
> the one who suggested to also enable mmap() on PCI resources.

The introduction of a new QEMU API for accessing MMIO BARs in this
series is something Alex might be interested in as QEMU VFIO maintainer.
That wouldn't have been part of the kernel patch review.

If he's aware of the new API he can encourage other VFIO users to use it
in the future so that you won't need to convert them to work on s390x
again.

Stefan

>=20
> Thanks,
> Niklas
>=20
> > >=20
> > > [1] https://lore.kernel.org/linux-s390/20250226-vfio_pci_mmap-v7-0-c5=
c0f1d26efd@linux.ibm.com/
> > >=20
> > > ChangeLog
> > > ---------
> > > v2 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg068=
47.html
> > > v2 -> v3
> > >     - Update the PCI MMIO APIs to reflect that its PCI MMIO access on=
 host=20
> > > as suggested by Stefan(patch 2)
> > >     - Move s390x ifdef check to s390x_pci_mmio.h as suggested by Phil=
ippe (patch 1)
> > >     - Add R-bs for the respective patches.
> > >=20
> > > v1 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg065=
96.html
> > > v1 -> v2
> > >     - Add 8 and 16 bit reads/writes for completeness (patch 1)
> > >     - Introduce new QEMU PCI MMIO read/write API as suggested by Stef=
an (patch 2)
> > >     - Update NVMe userspace driver to use QEMU PCI MMIO functions (pa=
tch 3)
> > >=20
> > > Farhan Ali (3):
> > >   util: Add functions for s390x mmio read/write
> > >   include: Add a header to define host PCI MMIO functions
> > >   block/nvme: Use host PCI MMIO API
> > >=20
> > >  block/nvme.c                  |  37 +++++----
> > >  include/qemu/host-pci-mmio.h  | 116 ++++++++++++++++++++++++++
> > >  include/qemu/s390x_pci_mmio.h |  24 ++++++
> > >  util/meson.build              |   2 +
> > >  util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++=
++
> > >  5 files changed, 311 insertions(+), 16 deletions(-)
> > >  create mode 100644 include/qemu/host-pci-mmio.h
> > >  create mode 100644 include/qemu/s390x_pci_mmio.h
> > >  create mode 100644 util/s390x_pci_mmio.c
> > >=20
> > > --=20
> > > 2.43.0
> > >=20
>=20

--GGcO0VCXMIAbRXJV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfurOoACgkQnKSrs4Gr
c8g2Wwf/Y1tZB5CWtKRBtQZUvzBYOa3EoNSH5lNM9E209q90jHRkpKYfAa3A+IL8
TAnwSNOj2gbtZyQvzWc0iLbY9qMtYzvyvf8bKubQV8BwnJEPCrkVyqtq6TBXmlhP
izurNiNGX+CbxMffAqv5vEaQHo/NlPWNOmEkpk2s77lxLFsINcr5Etrb87Yx26/k
7yWi8cjVWtWV8a72Bw/IhB9bVUALaEATcGLUoOwgPeQQyE0Sk//Dxl3V7eVAV8VP
w4ZiHYLWzxVf85+NfwdLXWCcJPL69lRFZ/HK4YsOKae8dgPlJe+y5CZkWWguOPEP
ssAphlnBtSF56yqXPYU2hYvEgFg9Qw==
=K74s
-----END PGP SIGNATURE-----

--GGcO0VCXMIAbRXJV--


