Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E25ECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHQMx-00061I-Ow; Thu, 15 Oct 2026 14:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xHQMu-000610-4L
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xHQMr-0003v3-Sb
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792089590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LjQirsHZrA/VFR3YZGg2BtMWtzixNcgaqp7jQn9zKY=;
 b=cI+L3uyySsGEbLbrcCpiv8cHtiHZQWt8mN4xEteXFO+eorQIGiuJ5k6Xl8T5nROtYOmAHJ
 qI85l9asE66fACzrdjpjuBm6p1IXjA8M3KNBRgdwEpkOegkLDEjTNx9mXTDvTou2XqmAaJ
 z71LxKlEu9GGDtZ/1PmA8e7x2KubJMs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-569VhxWOPtyVjPBWTMzAIQ-1; Thu,
 15 Oct 2026 18:39:46 +0000
X-MC-Unique: 569VhxWOPtyVjPBWTMzAIQ-1
X-Mimecast-MFC-AGG-ID: 569VhxWOPtyVjPBWTMzAIQ_1792089585
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 516F8195604A; Thu, 15 Oct 2026 18:39:45 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79BBD1955F21; Thu, 15 Oct 2026 18:39:44 +0000 (UTC)
Date: Thu, 15 Oct 2026 14:39:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hector Cao <hector.cao@canonical.com>,
 Alex =?iso-8859-1?Q?Ram=EDrez?= <alex.ramirez@canonical.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 2/2] util/coroutine: Reduce default idle pool max size
Message-ID: <20261015183942.GB1504100@shajnocz.csb>
References: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
 <20261014-set-default-pool-size-v4-2-a3aff89b94f0@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I40o/0aa2RI9esXk"
Content-Disposition: inline
In-Reply-To: <20261014-set-default-pool-size-v4-2-a3aff89b94f0@canonical.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--I40o/0aa2RI9esXk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 04:55:46PM -0500, Wesley Hershberger wrote:
> If g_file_get_contents fails (AppArmor, etc), use a more conservative
> default max size for the idle coroutine pool.
>=20
> This avoids any possibility of the failure described in 86a637e48104
> unless the host kernel is configured with a lower-than-default
> vm.max_map_count.
>=20
> This change is motivated by a discussion of backport risk:
> https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8
>=20
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
>  util/qemu-coroutine.c | 73 ++++++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 46 insertions(+), 27 deletions(-)
>=20
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 5af61995437..b3312f7bf99 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -361,42 +361,61 @@ void qemu_coroutine_dec_pool_size(unsigned int remo=
ving_pool_size)
>      global_pool_max_size -=3D removing_pool_size;
>  }
> =20
> -static unsigned int get_global_pool_hard_max_size(void)
> -{
>  #ifdef __linux__
> -    g_autofree char *contents =3D NULL;
> -    int max_map_count;
> +/*
> + * include/linux/mm.h
> + */
> +#define DEFAULT_MAX_MAP_COUNT 65530
> =20
> -    /*
> -     * Linux processes can have up to max_map_count virtual memory areas
> -     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this li=
mit. We
> -     * must limit the coroutine pool to a safe size to avoid running out=
 of
> -     * VMAs.
> -     */
> -    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NUL=
L,
> -                            NULL)) {
> +static unsigned int get_max_map_count(void)
> +{
> +    g_autofree char *contents =3D NULL;
> +    int max_map_count =3D 0;
> +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents,
> +                            NULL, NULL)) {
>          /* contents has trailing newline, remove it before conversion */
>          g_strchomp(contents);
> -        if (qemu_strtoi(contents, NULL, 10, &max_map_count) !=3D 0) {
> -            return UINT_MAX;
> -        }
> -        /*
> -         * This is an upper bound that avoids exceeding max_map_count. L=
eave a
> -         * fixed amount for non-coroutine users like library dependencie=
s,
> -         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
> -         * remaining amount.
> -         */
> -        if (max_map_count > 5000) {
> -            return (max_map_count - 5000) / 2;
> -        } else {
> -            /* Disable the global pool but threads still have local pool=
s */
> -            return 0;
> +        if (qemu_strtoi(contents, NULL, 10, &max_map_count) =3D=3D 0) {
> +            return max_map_count;
>          }
>      }
> -#endif
> =20
> +    /*
> +     * Read from /proc might fail due to mandatory access control (AppAr=
mor,
> +     * SELinux, etc). Use the kernel's default in that case.
> +     */
> +    return DEFAULT_MAX_MAP_COUNT;
> +}
> +
> +/*
> + * Linux processes can have up to max_map_count virtual memory areas
> + * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit.=
 We
> + * must limit the coroutine pool to a safe size to avoid running out of
> + * VMAs.
> + */
> +static unsigned int get_global_pool_hard_max_size(void)
> +{
> +    int max_map_count =3D get_max_map_count();

get_max_map_count() returns an unsigned int and this function does too.
Make max_map_count unsigned int here too for consistency?

Other than that:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> +
> +    /*
> +     * This is an upper bound that avoids exceeding max_map_count. Leave=
 a
> +     * fixed amount for non-coroutine users like library dependencies,
> +     * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
> +     * remaining amount.
> +     */
> +    if (max_map_count > 5000) {
> +        return (max_map_count - 5000) / 2;
> +    } else {
> +        /* Disable the global pool but threads still have local pools */
> +        return 0;
> +    }
> +}
> +#else
> +static unsigned int get_global_pool_hard_max_size(void)
> +{
>      return UINT_MAX;
>  }
> +#endif
> =20
>  static void __attribute__((constructor)) qemu_coroutine_init(void)
>  {
>=20
> --=20
> 2.53.0
>=20

--I40o/0aa2RI9esXk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmrRHe4ACgkQnKSrs4Gr
c8jXkgf+JZZ+7MX72KvvUYFwPMbT9JUm9lRvykDwDSdoINK15OHWu39nykKIN460
U6L6Dz65En4V8LedrWjIkL5ALA6HIOh0IST+m4EMeiRPFtU/wL2S3NtMFx7vVMj9
NvLkys7X461hf2omw0tk02ZLW7X1F89S7VpiZY3fs3E/JZzqwGgqOmXGEOOExK2B
3exbxZY9VGi7k9qtj48oQ21aEwzu22c1rbOmCbcbIDo5TvycNyRZCq4L9gxx7DFZ
kYX+5+yG4YPlWn42WFeBABxmDKj2ooO9PSheI8z51aOOC03agKHhGAqm7Cg+uue6
y7hWjHsNME950lJ2b5IlCJ9S7XtoFA==
=qKST
-----END PGP SIGNATURE-----

--I40o/0aa2RI9esXk--


