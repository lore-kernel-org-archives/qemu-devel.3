Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DDBC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOe25-0006Pr-Td; Mon, 09 Jun 2025 11:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOe1w-0006Ny-L0
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOe1u-0002v7-5w
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749481397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ebaWM8LDMAhvO11U8ObZgocVzRhMNHWfUiUufJWdeVY=;
 b=TinAQK+WeCZkcdALQvuxom/D/FfCgE8xLjnDvnekeEo4hXcKb6OSCN4Bdzx9f0K+uA7E9V
 G867pipGgzCOLdBBkWy4aNJFDq/nul8luq1rpMp71dkDmnXyWtgYgiaHiYoSFDiBRdLHgx
 KGQcsyOfLijX0iMV0UNHbDq2FJe/sL4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-5ekLP5UdON-vIfWTN2_bhg-1; Mon,
 09 Jun 2025 11:03:13 -0400
X-MC-Unique: 5ekLP5UdON-vIfWTN2_bhg-1
X-Mimecast-MFC-AGG-ID: 5ekLP5UdON-vIfWTN2_bhg_1749481392
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 140C31800298; Mon,  9 Jun 2025 15:03:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FBC518003FC; Mon,  9 Jun 2025 15:03:11 +0000 (UTC)
Date: Mon, 9 Jun 2025 11:03:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 12/21] block: Move qemu_fcntl_addfl() into osdep.c
Message-ID: <20250609150310.GF29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-13-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R/sC28YuqQrhXtg8"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-13-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--R/sC28YuqQrhXtg8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:28:04PM +0200, Hanna Czenczek wrote:
> Move file-posix's helper to add a flag (or a set of flags) to an FD's
> existing set of flags into osdep.c for other places to use.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/qemu/osdep.h |  1 +
>  block/file-posix.c   | 17 +----------------
>  util/osdep.c         | 18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 16 deletions(-)

I was curious if putting POSIX fcntl(2) in osdep.c would work on
Windows. It does not:

x86_64-w64-mingw32-gcc -m64 -Ilibqemuutil.a.p -I. -I.. -Iqapi -Itrace -Iui =
-Iui/shader -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/us=
r/x86_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include -fdiagnostics-colo=
r=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-=
strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security=
 -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -=
Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style=
-declaration -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wst=
rict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-in=
clude-dirs -Wno-psabi -Wno-shift-negative-value -iquote . -iquote /home/ste=
fanha/qemu -iquote /home/stefanha/qemu/include -iquote /home/stefanha/qemu/=
host/include/x86_64 -iquote /home/stefanha/qemu/host/include/generic -iquot=
e /home/stefanha/qemu/tcg/i386 -mms-bitfields -mms-bitfields -mcx16 -msse2 =
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-alia=
sing -fno-common -fwrapv -fno-pie -no-pie -ftrivial-auto-var-init=3Dzero -f=
zero-call-used-regs=3Dused-gpr -mms-bitfields -mms-bitfields -pthread -mms-=
bitfields -MD -MQ libqemuutil.a.p/util_osdep.c.obj -MF libqemuutil.a.p/util=
_osdep.c.obj.d -o libqemuutil.a.p/util_osdep.c.obj -c ../util/osdep.c
=2E./util/osdep.c: In function 'qemu_fcntl_addfl':
=2E./util/osdep.c:625:13: error: implicit declaration of function 'fcntl' [=
-Wimplicit-function-declaration]
  625 |     flags =3D fcntl(fd, F_GETFL);
      |             ^~~~~
=2E./util/osdep.c:625:13: error: nested extern declaration of 'fcntl' [-Wer=
ror=3Dnested-externs]
=2E./util/osdep.c:625:23: error: 'F_GETFL' undeclared (first use in this fu=
nction)
  625 |     flags =3D fcntl(fd, F_GETFL);
      |                       ^~~~~~~
=2E./util/osdep.c:625:23: note: each undeclared identifier is reported only=
 once for each function it appears in
=2E./util/osdep.c:629:19: error: 'F_SETFL' undeclared (first use in this fu=
nction)
  629 |     if (fcntl(fd, F_SETFL, flags | flag) =3D=3D -1) {
      |                   ^~~~~~~
cc1: all warnings being treated as errors

>=20
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 96fe51bc39..49b729edc1 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -774,6 +774,7 @@ static inline void qemu_reset_optind(void)
>  }
> =20
>  int qemu_fdatasync(int fd);
> +int qemu_fcntl_addfl(int fd, int flag);
> =20
>  /**
>   * qemu_close_all_open_fd:
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 9b5f08ccb2..045e94d54d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1047,21 +1047,6 @@ static int raw_handle_perm_lock(BlockDriverState *=
bs,
>      return ret;
>  }
> =20
> -/* Sets a specific flag */
> -static int fcntl_setfl(int fd, int flag)
> -{
> -    int flags;
> -
> -    flags =3D fcntl(fd, F_GETFL);
> -    if (flags =3D=3D -1) {
> -        return -errno;
> -    }
> -    if (fcntl(fd, F_SETFL, flags | flag) =3D=3D -1) {
> -        return -errno;
> -    }
> -    return 0;
> -}
> -
>  static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
>                                   int *open_flags, uint64_t perm, Error *=
*errp)
>  {
> @@ -1100,7 +1085,7 @@ static int raw_reconfigure_getfd(BlockDriverState *=
bs, int flags,
>          /* dup the original fd */
>          fd =3D qemu_dup(s->fd);
>          if (fd >=3D 0) {
> -            ret =3D fcntl_setfl(fd, *open_flags);
> +            ret =3D qemu_fcntl_addfl(fd, *open_flags);
>              if (ret) {
>                  qemu_close(fd);
>                  fd =3D -1;
> diff --git a/util/osdep.c b/util/osdep.c
> index 770369831b..ce5c6a7f59 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -613,3 +613,21 @@ int qemu_fdatasync(int fd)
>      return fsync(fd);
>  #endif
>  }
> +
> +/**
> + * Set the given flag(s) (fcntl GETFL/SETFL) on the given FD, while reta=
ining
> + * other flags.
> + */
> +int qemu_fcntl_addfl(int fd, int flag)
> +{
> +    int flags;
> +
> +    flags =3D fcntl(fd, F_GETFL);
> +    if (flags =3D=3D -1) {
> +        return -errno;
> +    }
> +    if (fcntl(fd, F_SETFL, flags | flag) =3D=3D -1) {
> +        return -errno;
> +    }
> +    return 0;
> +}
> --=20
> 2.49.0
>=20

--R/sC28YuqQrhXtg8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhG964ACgkQnKSrs4Gr
c8iRMgf/WJSd6+2f8LrVdWTH5crT0UubctE2kLj4U2TD9dMPLMyy8YVNjPUM5jTm
O+bJbWFCulh4gd7xp3B5xJIJjHTiNIeiKxA49s5Rpo2XWtsZL9LnKT7lc7YBQ3O/
kRNcZojX/obOxdIL3Z3+G3NdFls/9a14BmCGKDY4Ffb6LfWuYZPLAi9E5VEh+51g
UuaWSuUGUAUN0346k7JjpgnwMTb6IJznQ8++VFyp9JDJAn7SaqCTfEjT1/z/qbeO
ERu1pdhjappNF4byFZ7d6IjSpBwx3ZuiH66mYCsYiPSr6jhraFVI8cimgkFkH69H
ETls42TaYN7UU+uE87HPKUt38rqzOA==
=+t5X
-----END PGP SIGNATURE-----

--R/sC28YuqQrhXtg8--


