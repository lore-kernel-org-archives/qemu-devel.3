Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D592C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 19:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txsmw-0001Rc-Jx; Thu, 27 Mar 2025 15:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txsmp-0001RH-Rd
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 15:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txsmn-0002SI-D6
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 15:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743103261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTDHA4j5rrBO4tuTzusDxcnLwIaDBOjt1UrR4Y1i1M8=;
 b=Pe4lhQw8ufB4NDfynojQWtQq0a0LDR3dVinzTaMeDfvyNT58u6wArZjwQZEgJGpCBL4x7Z
 +zbkyKNrkfCYCL0YOroMIYjnKrpTRjLOolQb9/3sJESk0WYHY+/1OwaCoEDMBVe3QWKfBD
 0pAp8ZMtB8/S2UhvJCgkGrFKMMmlw5U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-z6kY8zATMKqtRJ9FHXxIng-1; Thu,
 27 Mar 2025 15:20:57 -0400
X-MC-Unique: z6kY8zATMKqtRJ9FHXxIng-1
X-Mimecast-MFC-AGG-ID: z6kY8zATMKqtRJ9FHXxIng_1743103256
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3182819560BA; Thu, 27 Mar 2025 19:20:55 +0000 (UTC)
Received: from localhost (unknown [10.2.17.98])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26A5B1956095; Thu, 27 Mar 2025 19:20:53 +0000 (UTC)
Date: Thu, 27 Mar 2025 15:20:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
Subject: Re: [PATCH v1 1/2] util: Add functions for s390x mmio read/write
Message-ID: <20250327192052.GC46883@fedora>
References: <20250326181007.1099-1-alifm@linux.ibm.com>
 <20250326181007.1099-2-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nf4qM+rI8ZlVQaik"
Content-Disposition: inline
In-Reply-To: <20250326181007.1099-2-alifm@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--Nf4qM+rI8ZlVQaik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:10:06AM -0700, Farhan Ali wrote:
> Starting with z15 (or newer) we can execute mmio
> instructions from userspace. On older platforms
> where we don't have these instructions available
> we can fallback to using system calls to access
> the PCI mapped resources.
>=20
> This patch adds helper functions for mmio reads
> and writes for s390x.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  include/qemu/s390x_pci_mmio.h |  17 ++++++
>  util/meson.build              |   2 +
>  util/s390x_pci_mmio.c         | 105 ++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 include/qemu/s390x_pci_mmio.h
>  create mode 100644 util/s390x_pci_mmio.c
>=20
> diff --git a/include/qemu/s390x_pci_mmio.h b/include/qemu/s390x_pci_mmio.h
> new file mode 100644
> index 0000000000..be61b5ae29
> --- /dev/null
> +++ b/include/qemu/s390x_pci_mmio.h
> @@ -0,0 +1,17 @@
> +/*
> + * s390x PCI MMIO definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef S390X_PCI_MMIO_H
> +#define S390X_PCI_MMIO_H
> +
> +uint64_t s390x_pci_mmio_read_64(const void *ioaddr);
> +uint32_t s390x_pci_mmio_read_32(const void *ioaddr);
> +void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val);
> +void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val);
> +
> +#endif
> diff --git a/util/meson.build b/util/meson.build
> index 780b5977a8..acb21592f9 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -131,4 +131,6 @@ elif cpu in ['ppc', 'ppc64']
>    util_ss.add(files('cpuinfo-ppc.c'))
>  elif cpu in ['riscv32', 'riscv64']
>    util_ss.add(files('cpuinfo-riscv.c'))
> +elif cpu =3D=3D 's390x'
> +  util_ss.add(files('s390x_pci_mmio.c'))
>  endif
> diff --git a/util/s390x_pci_mmio.c b/util/s390x_pci_mmio.c
> new file mode 100644
> index 0000000000..2e0825d617
> --- /dev/null
> +++ b/util/s390x_pci_mmio.c
> @@ -0,0 +1,105 @@
> +/*
> + * s390x PCI MMIO definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include "qemu/osdep.h"

This should be the first #include in the file. From
docs/devel/style.rst:

  Include directives
  ------------------
 =20
  Order include directives as follows:
 =20
  .. code-block:: c
 =20
      #include "qemu/osdep.h"  /* Always first... */
      #include <...>           /* then system headers... */
      #include "..."           /* and finally QEMU headers. */

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Nf4qM+rI8ZlVQaik
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflpRQACgkQnKSrs4Gr
c8g5SggAhwprjKa88lmd9IEXvOOvTam0DpM4GBr//Fyoe2DIaJR+oAgmQu3O89Hz
TfoEG2ng3IDCVGnn4agLwoqIHjv9ta9es2HptcZO+upOXJmzMhCiTrVw3hyhlVI7
qKt1NkV/btXaMT5pPgXmRIFQB4lUXC1VHrKO9JJJCd1jNqZfnozKk84W9cOMip/+
Z4Qd0EMk1lVLdgYEYWVfSnfBwIBtCqGJ6PiFkCP+UCrTI6NOXvX6rOvRzK0b+nYS
Wi1oVQCRHZGFGPNA7cShLtLKmufdklh6NtO21XLeCuucGUKW6e2a4nhmAc9nx7lT
Zx55tqoy3L7gMxrkX7PdTHm4aiP8rQ==
=43y3
-----END PGP SIGNATURE-----

--Nf4qM+rI8ZlVQaik--


