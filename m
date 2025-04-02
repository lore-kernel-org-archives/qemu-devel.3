Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B5AC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 15:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u00Nq-0003wt-BC; Wed, 02 Apr 2025 11:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u00No-0003wF-9y
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u00Nm-0001xY-Lm
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743609121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIr8q62LoRIyviTx/pdZhEXZBPu89FdOIxFcN4LTFXc=;
 b=FuqbqXymw2u/JmdOfJKsM6+pCfboO4yLv43Zu5uDIJbb81f1RrgyxwmVxIkLbYKVwQc/vf
 AqjBCqrOFPiPOAp4Iek99QRGKkQPo+EoeBw48KOHsXhIlgyNQegeI1YCQgmuZYOpKmF8Hc
 RYNsj4cq1pR1E0jrbKqtj5lKwdH1f10=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-lzhqgkWsMT-DoKHHa1XaUQ-1; Wed,
 02 Apr 2025 11:51:58 -0400
X-MC-Unique: lzhqgkWsMT-DoKHHa1XaUQ-1
X-Mimecast-MFC-AGG-ID: lzhqgkWsMT-DoKHHa1XaUQ_1743609117
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0577D19560B7; Wed,  2 Apr 2025 15:51:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55E55195609D; Wed,  2 Apr 2025 15:51:53 +0000 (UTC)
Date: Wed, 2 Apr 2025 11:51:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, thuth@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
Message-ID: <20250402155152.GE304512@fedora>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cljUvCXO0cOjgEvH"
Content-Disposition: inline
In-Reply-To: <20250401172246.2688-1-alifm@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--cljUvCXO0cOjgEvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:
> Hi,
>=20
> Recently on s390x we have enabled mmap support for vfio-pci devices [1].

Hi Alex,
I wanted to bring this to your attention. Feel free to merge it through
the VFIO tree, otherwise I will merge it once you have taken a look.

Thanks,
Stefan

> This allows us to take advantage and use userspace drivers on s390x. Howe=
ver,
> on s390x we have special instructions for MMIO access. Starting with z15=
=20
> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which=
=20
> operate on virtually mapped PCI memory spaces, and can be used from users=
pace.
> On older platforms we would fallback to using existing system calls for M=
MIO access.
>=20
> This patch series introduces support the PCI MIO instructions, and enable=
s s390x
> support for the userspace NVMe driver on s390x. I would appreciate any re=
view/feedback
> on the patches.
>=20
> Thanks
> Farhan
>=20
> [1] https://lore.kernel.org/linux-s390/20250226-vfio_pci_mmap-v7-0-c5c0f1=
d26efd@linux.ibm.com/
>=20
> ChangeLog
> ---------
> v2 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06847.h=
tml
> v2 -> v3
>     - Update the PCI MMIO APIs to reflect that its PCI MMIO access on hos=
t=20
> as suggested by Stefan(patch 2)
>     - Move s390x ifdef check to s390x_pci_mmio.h as suggested by Philippe=
 (patch 1)
>     - Add R-bs for the respective patches.
>=20
> v1 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06596.h=
tml
> v1 -> v2
>     - Add 8 and 16 bit reads/writes for completeness (patch 1)
>     - Introduce new QEMU PCI MMIO read/write API as suggested by Stefan (=
patch 2)
>     - Update NVMe userspace driver to use QEMU PCI MMIO functions (patch =
3)
>=20
> Farhan Ali (3):
>   util: Add functions for s390x mmio read/write
>   include: Add a header to define host PCI MMIO functions
>   block/nvme: Use host PCI MMIO API
>=20
>  block/nvme.c                  |  37 +++++----
>  include/qemu/host-pci-mmio.h  | 116 ++++++++++++++++++++++++++
>  include/qemu/s390x_pci_mmio.h |  24 ++++++
>  util/meson.build              |   2 +
>  util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
>  5 files changed, 311 insertions(+), 16 deletions(-)
>  create mode 100644 include/qemu/host-pci-mmio.h
>  create mode 100644 include/qemu/s390x_pci_mmio.h
>  create mode 100644 util/s390x_pci_mmio.c
>=20
> --=20
> 2.43.0
>=20

--cljUvCXO0cOjgEvH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmftXRgACgkQnKSrs4Gr
c8hDkAf/Yst62QgRHVggfEY46uDPa9/J/rWPgTTcHaEAMNEyB59mlvDKqFqbL1c6
NA5eRSjyFNXhFO8OaiGjBnybRgW59sRXlPRwkei+RFybi35AQgXMZLijWn9Hq4ve
1UOdz+h9HcPMuPc6PdhoMS4EPSXHSrpdau3o/uQl0YE8hsm75S+bWTkYGmGrCJR/
uhzssvefWROcjiILxNeJrZsOVYlQPvu38gRWbvC6juimntJPPZVvVWTMM3Im3trF
4d8jli3zr64IeWgqi6zU73oE5sJvfIcyeen+uaf5kj1VEBV6dSo+r+f/C0T2GRLi
nNavlHkI7Rc7W0D57A/BnewXo8YwmA==
=Fv6j
-----END PGP SIGNATURE-----

--cljUvCXO0cOjgEvH--


