Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6342C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFUA-0004gS-Jq; Mon, 31 Mar 2025 09:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzFTx-0004fB-P3
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzFTu-00015n-20
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743428830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ryzNhrfeki9G2uOfkinWL8llLZe4Cg4Q2i67J4a28Ws=;
 b=hX7O2wXRjtxqkupzroPyQvF//nDQTVjokl47PRJq4PhpkoYHlHTBJ+LoGA+sSekoI6/b4A
 ndlWAlEcO9Nwrg3PR97bozUf/uriLa08xka9lLhehTsd6sMdagCnrCBqMle+GpEHRpYjF1
 XOhI9SLYxFpRbGRcFvMpiWFriOCXVxI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-V9gr6DP4NW6IsXB4hGysig-1; Mon,
 31 Mar 2025 09:47:05 -0400
X-MC-Unique: V9gr6DP4NW6IsXB4hGysig-1
X-Mimecast-MFC-AGG-ID: V9gr6DP4NW6IsXB4hGysig_1743428824
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05F15195608A; Mon, 31 Mar 2025 13:46:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67D7B1801752; Mon, 31 Mar 2025 13:46:57 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:46:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
Subject: Re: [PATCH v2 2/3] include: Add a header to define PCI MMIO functions
Message-ID: <20250331134656.GC190936@fedora>
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-3-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+zMIgSSGKgDsimyF"
Content-Disposition: inline
In-Reply-To: <20250328190627.3025-3-alifm@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--+zMIgSSGKgDsimyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 12:06:26PM -0700, Farhan Ali wrote:
> Add a generic QEMU API for PCI MMIO reads/writes.
> The functions access little endian memory and returns
> the result in host cpu endianness.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  include/qemu/pci-mmio.h | 116 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 include/qemu/pci-mmio.h
>=20
> diff --git a/include/qemu/pci-mmio.h b/include/qemu/pci-mmio.h
> new file mode 100644
> index 0000000000..2ef92455b1
> --- /dev/null
> +++ b/include/qemu/pci-mmio.h
> @@ -0,0 +1,116 @@
> +/*
> + * QEMU PCI MMIO API

QEMU also emulates PCI devices that handle MMIO accesses. It is easy to
get confused between host PCI MMIO accesses and emulated guest PCI MMIO
accesses if the name is just "PCI MMIO API".

Please update the commit message, filenames, function names, and doc
comments to make it clear that this is only for host PCI MMIO accesses
(e.g. Linux VFIO BAR accesses).

For example "qemu/host-pci-mmio.h", "API for host PCI MMIO accesses
(e.g. Linux VFIO BARs)", and host_pci_mmio_read_8().

> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_PCI_MMIO_H
> +#define QEMU_PCI_MMIO_H
> +
> +#ifdef __s390x__
> +#include "s390x_pci_mmio.h"
> +#endif
> +
> +static inline uint8_t qemu_pci_mmio_read_8(const void *ioaddr)
> +{
> +    uint8_t ret =3D 0;
> +#ifdef __s390x__
> +    ret =3D s390x_pci_mmio_read_8(ioaddr);
> +#else
> +    /* Prevent the compiler from optimizing away the load */
> +    ret =3D *((volatile uint8_t *)ioaddr);
> +#endif
> +
> +    return ret;
> +}
> +
> +static inline uint16_t qemu_pci_mmio_read_16(const void *ioaddr)
> +{
> +    uint16_t ret =3D 0;
> +#ifdef __s390x__
> +    ret =3D s390x_pci_mmio_read_16(ioaddr);
> +#else
> +    /* Prevent the compiler from optimizing away the load */
> +    ret =3D *((volatile uint16_t *)ioaddr);
> +#endif
> +
> +    return le16_to_cpu(ret);
> +}
> +
> +static inline uint32_t qemu_pci_mmio_read_32(const void *ioaddr)
> +{
> +    uint32_t ret =3D 0;
> +#ifdef __s390x__
> +    ret =3D s390x_pci_mmio_read_32(ioaddr);
> +#else
> +    /* Prevent the compiler from optimizing away the load */
> +    ret =3D *((volatile uint32_t *)ioaddr);
> +#endif
> +
> +    return le32_to_cpu(ret);
> +}
> +
> +static inline uint64_t qemu_pci_mmio_read_64(const void *ioaddr)
> +{
> +    uint64_t ret =3D 0;
> +#ifdef __s390x__
> +    ret =3D s390x_pci_mmio_read_64(ioaddr);
> +#else
> +    /* Prevent the compiler from optimizing away the load */
> +    ret =3D *((volatile uint64_t *)ioaddr);
> +#endif
> +
> +    return le64_to_cpu(ret);
> +}
> +
> +static inline void qemu_pci_mmio_write_8(void *ioaddr, uint8_t val)
> +{
> +
> +#ifdef __s390x__
> +    s390x_pci_mmio_write_8(ioaddr, val);
> +#else
> +    /* Prevent the compiler from optimizing away the store */
> +    *((volatile uint8_t *)ioaddr) =3D val;
> +#endif
> +}
> +
> +static inline void qemu_pci_mmio_write_16(void *ioaddr, uint16_t val)
> +{
> +    val =3D cpu_to_le16(val);
> +
> +#ifdef __s390x__
> +    s390x_pci_mmio_write_16(ioaddr, val);
> +#else
> +    /* Prevent the compiler from optimizing away the store */
> +    *((volatile uint16_t *)ioaddr) =3D val;
> +#endif
> +}
> +
> +static inline void qemu_pci_mmio_write_32(void *ioaddr, uint32_t val)
> +{
> +    val =3D cpu_to_le32(val);
> +
> +#ifdef __s390x__
> +    s390x_pci_mmio_write_32(ioaddr, val);
> +#else
> +    /* Prevent the compiler from optimizing away the store */
> +    *((volatile uint32_t *)ioaddr) =3D val;
> +#endif
> +}
> +
> +static inline void qemu_pci_mmio_write_64(void *ioaddr, uint64_t val)
> +{
> +    val =3D cpu_to_le64(val);
> +
> +#ifdef __s390x__
> +    s390x_pci_mmio_write_64(ioaddr, val);
> +#else
> +    /* Prevent the compiler from optimizing away the store */
> +    *((volatile uint64_t *)ioaddr) =3D val;
> +#endif
> +}
> +
> +#endif
> --=20
> 2.43.0
>=20

--+zMIgSSGKgDsimyF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfqnM8ACgkQnKSrs4Gr
c8jhJwf+LFiDyrfjCOHzUJ3Jtzaqn4gbZuMJ9ilVlbxg7QDAUXE2FEfJBO9KqLNQ
lQyhkdeQHTb7EkcLxh+IcoD4r3lIGh1xhPHSekrOKqHAyRZ/cRzYb0VKBuwvHl/6
cgva6u/joD7TNwNehoLBk5Vpha5i/4zBLv25ks9VWel7M2kfUl5emQ9UUrMpiPvD
DAmIqThPx1yDa2Iw8EQ9UIsrN92D76JRv8shmYTNfdcObagmAD6OgKhs4IItn4YU
jsp/O6Gd29arDcZrwQmaM1we98x4hb6m+3VdR+sr0tHWSdlROMAu1H+6C0GJk2Eo
EImvZLyzzgi1B2ZVvD8MxJEvEHNDdg==
=IS8k
-----END PGP SIGNATURE-----

--+zMIgSSGKgDsimyF--


