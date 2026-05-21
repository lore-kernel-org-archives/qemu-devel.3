Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA6ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5ke-0004OS-GP; Thu, 21 May 2026 11:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ5kc-0004OB-ON
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ5kZ-0000ff-JR
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779378954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUW/lVGZulHXtLM2bPVK9LU7GBcNTfA51pNLyxsrQyU=;
 b=K4RBYdAfKMjGiR7h9B+fB2SmOxo/doxlIrpXnbKUd7kMZ9S39zE6ZSN7BWDe990vd1FUmo
 VtLZ9/BTlliCD2WYfDeunLXRK0MJax1YfRAPj6WcRV5YKiPH9EYL9mc+Xd6Il3YYedD+vQ
 XeKz+0sMnK1QrVP6ELNqPIlap3M9eD0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-R0y86qUIOXOwxft6lhjNbQ-1; Thu,
 21 May 2026 11:55:16 -0400
X-MC-Unique: R0y86qUIOXOwxft6lhjNbQ-1
X-Mimecast-MFC-AGG-ID: R0y86qUIOXOwxft6lhjNbQ_1779378915
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42349195609D; Thu, 21 May 2026 15:55:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92EDA1800347; Thu, 21 May 2026 15:55:14 +0000 (UTC)
Date: Thu, 21 May 2026 11:55:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v3 0/1] block/linux-aio: fix reproducible SIGSEGV from
 unbounded ioq_submit() recursion
Message-ID: <20260521155511.GA647779@fedora>
References: <20260520142503.251959-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5KH7WOo2H2AIXt45"
Content-Disposition: inline
In-Reply-To: <20260520142503.251959-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--5KH7WOo2H2AIXt45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 04:25:02PM +0200, Denis V. Lunev via qemu developme=
nt wrote:
> Observed in production where a cached-I/O backup path was driven
> through aio=3Dnative, making io_submit(2) complete synchronously and
> closing the recursion cycle.  On the supported aio=3Dnative + cache=3Dnone
> + qcow2 configuration the cycle stays bounded by accident rather than
> by construction; this patch bounds it explicitly.
>=20
> Bisect:
>=20
>   v8.1.0 (forward edge only)      no crash / 20
>   84d61e5f36^                     no crash / 20
>   84d61e5f36 (backward edge in)   crash at attempt 17
>   v8.2.0                          crash at attempt  4
>   master + this patch             no crash / 80
>=20
> The closing commit is 84d61e5f36 ("virtio: use defer_call() in
> virtio_irqfd_notify()").
>=20
> No iotest: crash rate is 6..17 per 20 on unpatched master; a formal
> test would be flaky.  The vmdk + aio=3Dnative + cache=3Dnone shape is
> not otherwise exercised by the suite.
>=20
> --- gen-workload.py -----------------------------------------------
> #!/usr/bin/env python3
> import random, sys
> REGION  =3D 32 * 1024 * 1024
> CLUSTER =3D 64 * 1024
> SEED    =3D 0xC0FFEE
> def main(out):
>     r =3D random.Random(SEED); ops =3D []
>     for _ in range(10000):
>         off =3D r.randrange(0, REGION - 4096) & ~4095
>         ops.append("aio_write -q %d 4k" % off)
>     for i in range(10000):
>         size, n =3D ("64k", 65536) if i < 5000 else ("128k", 131072)
>         off =3D r.randrange(0, REGION - n) & ~(CLUSTER - 1)
>         ops.append("aio_write -q -z -u %d %s" % (off, size))
>     r.shuffle(ops); ops.append("aio_flush")
>     open(out, "w").write("\n".join(ops) + "\n")
> if __name__ =3D=3D "__main__":
>     main(sys.argv[1] if len(sys.argv) > 1 else "t.cmds")
> -------------------------------------------------------------------
>=20
> --- repro.sh ------------------------------------------------------
> #!/bin/bash
> set -u
> qimg=3D$1; qio=3D$2; label=3D$3; attempts=3D${4:-20}
> cmds=3D${5:-$(dirname "$0")/t.cmds}
> vmdk=3D/tmp/t.$label.vmdk; log=3D/tmp/repro_$label.log
> : > "$log"
> for i in $(seq 1 "$attempts"); do
>     rm -f "$vmdk"
>     "$qimg" create -f vmdk "$vmdk" 256M >/dev/null 2>&1
>     "$qio" -f vmdk -n --cache=3Dnone --aio=3Dnative "$vmdk" < "$cmds" \
>         >>"$log" 2>&1
>     rc=3D$?
>     [ $rc -ge 128 ] && { echo "CRASH attempt $i rc=3D$rc" >>"$log"; break=
; }
> done
> echo "DONE $label rc=3D$rc attempt=3D$i" >> "$log"
> -------------------------------------------------------------------
>=20
>   python3 gen-workload.py t.cmds
>   ./repro.sh /path/to/qemu-img /path/to/qemu-io test 20
>=20
> Notes:
>=20
>  * IOQ_SUBMIT_MAX_DEPTH =3D 8.  Round headroom over the bounded depth
>    of the supported async-completion path.
>  * Per-thread __thread counter, matching util/defer-call.c's storage.
>    A per-LinuxAioState field would let multiple devices on one
>    thread recurse independently.
>=20
> Changes from v2:
> * moved depth guard to struct qemu_laiocb (suggestion from Stefan)
>=20
> Changes from v1:
> * removed all downstream marks
>=20
> Denis V. Lunev (1):
>   block/linux-aio: bound ioq_submit() recursion depth
>=20
>  block/linux-aio.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> --
> 2.51.0
>=20
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--5KH7WOo2H2AIXt45
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoPKt8ACgkQnKSrs4Gr
c8iRWggAvje+tYpTaVBRvbPtiR15N+vrGIjuWZOM0hsVP1oqhz9ttnexoueKEDjy
+zBZIRA3KJc9caqawAVsK+9rh1i6fKDPOb9d7NPxRzHvRajLkGwQdji4r5pLXJQa
+rdV5cB09Uc8mWmNPuWd1IkKKItgKB7c0EwHbquhtNCki1xaXKysyNh5+uMrwMnw
8i8528PupP635WUlN2LsahaMtwJMJDKXEnrruPZgqvie64TR55OxI1w4RKCwGgIC
geERBY+77NOfPmokuiu7WHFHufb50MU1HQaGMw/+IM8eENA6F6DC1PV/YJjwdE5b
ldLhFjhEyNtmcqQZKbI2zNuzXhQKfQ==
=/Urw
-----END PGP SIGNATURE-----

--5KH7WOo2H2AIXt45--


