Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1C5C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7Bp-0000Rv-19; Thu, 22 May 2025 10:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uI7Bh-0000Qo-RO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uI7Bb-00037t-CV
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747925175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=teEKCvIeXu/n2+atKvJmpPNGg5ONV3xXKdmVjYApXRQ=;
 b=SgtRjQjPdtctlG6vlWW8/WCyrwm48A3nEYLoBer9Ec7+G7CKK/I2cTvXbtAGGDQEdV+anx
 juiZKz9HhdRkCKwDob1jFb7SZZJhx1izHeqLbz5IV3rXLPdCzjE/y7jtXa3OFqw0UeWkXP
 ukGafou7t/msKIUQHRu7JHsLTz7Od9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-DDdNTN1TNHOU28P5Km7tvw-1; Thu,
 22 May 2025 10:46:11 -0400
X-MC-Unique: DDdNTN1TNHOU28P5Km7tvw-1
X-Mimecast-MFC-AGG-ID: DDdNTN1TNHOU28P5Km7tvw_1747925170
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F8F719560BB; Thu, 22 May 2025 14:46:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.192])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3EAF1800570; Thu, 22 May 2025 14:46:08 +0000 (UTC)
Date: Thu, 22 May 2025 10:46:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, bmarzins@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <20250522144607.GA258433@fedora>
References: <20250522130803.34738-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/cP+Wp3x2lclgAbk"
Content-Disposition: inline
In-Reply-To: <20250522130803.34738-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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


--/cP+Wp3x2lclgAbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 03:08:03PM +0200, Kevin Wolf wrote:
> When scsi-block is used on a host multipath device, it runs into the
> problem that the kernel dm-mpath doesn't know anything about SCSI or
> SG_IO and therefore can't decide if a SG_IO request returned an error
> and needs to be retried on a different path. Instead of getting working
> failover, an error is returned to scsi-block and handled according to
> the configured error policy. Obviously, this is not what users want,
> they want working failover.
>=20
> QEMU can parse the SG_IO result and determine whether this could have
> been a path error, but just retrying the same request could just send it
> to the same failing path again and result in the same error.
>=20
> With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> block devices (queued in the device mapper tree for Linux 6.16), we can
> tell the kernel to probe all paths and tell us if any usable paths
> remained. If so, we can now retry the SG_IO ioctl and expect it to be
> sent to a working path.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> v2:
> - Add a comment to explain retry scenarios [Stefan]
> - Handle -EAGAIN returned for suspended devices [Ben]
>=20
>  block/file-posix.c | 115 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ec95b74869..569f4ca472 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -41,6 +41,7 @@
> =20
>  #include "scsi/pr-manager.h"
>  #include "scsi/constants.h"
> +#include "scsi/utils.h"
> =20
>  #if defined(__APPLE__) && (__MACH__)
>  #include <sys/ioctl.h>
> @@ -72,6 +73,7 @@
>  #include <linux/blkzoned.h>
>  #endif
>  #include <linux/cdrom.h>
> +#include <linux/dm-ioctl.h>
>  #include <linux/fd.h>
>  #include <linux/fs.h>
>  #include <linux/hdreg.h>
> @@ -138,6 +140,22 @@
>  #define RAW_LOCK_PERM_BASE             100
>  #define RAW_LOCK_SHARED_BASE           200
> =20
> +/*
> + * Multiple retries are mostly meant for two separate scenarios:
> + *
> + * - DM_MPATH_PROBE_PATHS returns success, but before SG_IO completes, a=
nother
> + *   path goes down.
> + *
> + * - DM_MPATH_PROBE_PATHS failed all paths in the current path group, so=
 we have
> + *   to send another SG_IO to switch to another path group to probe the =
paths in
> + *   it.
> + *
> + * Even if each path is in a separate path group (path_grouping_policy s=
et to
> + * failover), it's rare to have more than eight path groups - and even t=
hen
> + * pretty unlikely that only bad path groups would be chosen in eight re=
tries.
> + */
> +#define SG_IO_MAX_RETRIES 8
> +
>  typedef struct BDRVRawState {
>      int fd;
>      bool use_lock;
> @@ -165,6 +183,7 @@ typedef struct BDRVRawState {
>      bool use_linux_aio:1;
>      bool has_laio_fdsync:1;
>      bool use_linux_io_uring:1;
> +    bool use_mpath:1;
>      int page_cache_inconsistent; /* errno from fdatasync failure */
>      bool has_fallocate;
>      bool needs_alignment;
> @@ -4264,15 +4283,105 @@ hdev_open_Mac_error:
>      /* Since this does ioctl the device must be already opened */
>      bs->sg =3D hdev_is_sg(bs);
> =20
> +    /* sg devices aren't even block devices and can't use dm-mpath */
> +    s->use_mpath =3D !bs->sg;
> +
>      return ret;
>  }
> =20
>  #if defined(__linux__)
> +#if defined(DM_MPATH_PROBE_PATHS)
> +static bool sgio_path_error(int ret, sg_io_hdr_t *io_hdr)
> +{
> +    if (ret < 0) {
> +        switch (ret) {
> +        case -ENODEV:
> +            return true;
> +        case -EAGAIN:
> +            /*
> +             * The device is probably suspended. This happens while the =
dm table
> +             * is reloaded, e.g. because a path is added or removed. Thi=
s is an
> +             * operation that should complete within 1ms, so just wait a=
 bit and
> +             * retry.
> +             *
> +             * If the device was suspended for another reason, we'll wai=
t and
> +             * retry SG_IO_MAX_RETRIES times. This is a tolerable delay =
before
> +             * we return an error and potentially stop the VM.
> +             */
> +            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);

sgio_path_error() is missing coroutine_fn.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/cP+Wp3x2lclgAbk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgvOK8ACgkQnKSrs4Gr
c8gdoQf8D4MgHU+SKZuJ/+fjYn5vxvHpOa76eZn/HOgv1wNEAchMTyRNr8SREptb
nbtzH3G+EWTGlaK7AmV/Zpw5Qviq90TOamYiULbxyt2nAx+CLh18r5cmlWDaiAhA
zR/7S5+MK42ZoaY/Zw4W+euosM53vY7o+tjy3KhkzqiSt07KJr66oX/OnKV9CvOs
b+sMipZp1fMGMMqB1N3YMTNkOSTT7F1oKLLin+5cPNxU5kTwdsCyuSpGL9cd+wMc
i3Loc5L0FAYHhi4zIYx8B5BhlYCTXrsQV6pz2ysIQn+rmgRDzYTj1E1ssJIEC3XS
IfSa9ek1Kra6e/uv5+tWGl7gqZE+/g==
=ArY6
-----END PGP SIGNATURE-----

--/cP+Wp3x2lclgAbk--


