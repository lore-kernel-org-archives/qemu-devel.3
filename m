Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567E3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd79Z-0005Af-Fh; Fri, 26 Jun 2026 10:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79W-0005AR-2U
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79U-0006x2-EK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782482607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BlnmO0n2Jc6BZuVFz+69sxbi2XAVcE7eTuHnatwl8og=;
 b=HJWQHvnuGBcsRdd/AuYiuizB3t4EBK9Uc53qsoE22Lco8OmuedrSktqKzlwu2doMjDwLWF
 1QKY6KJk5QFFvq6xB6jySD851khc1ceXZLc//ptaEajQB3MkxYczrxbAu37Kt/Ld/3FyIJ
 P3oSFfTDZWekWxhJvjK15Xir2uWWYX4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-v1RQ9aNCPim_UG95AzkwmQ-1; Fri,
 26 Jun 2026 10:03:24 -0400
X-MC-Unique: v1RQ9aNCPim_UG95AzkwmQ-1
X-Mimecast-MFC-AGG-ID: v1RQ9aNCPim_UG95AzkwmQ_1782482602
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6BA4180ACDB; Fri, 26 Jun 2026 14:03:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.186])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44FF130001A7; Fri, 26 Jun 2026 14:03:22 +0000 (UTC)
Date: Thu, 25 Jun 2026 19:00:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] tests/docker: bump emsdk-wasm64-cross zlib version to
 1.3.2
Message-ID: <20260625230016.GA279735@fedora>
References: <20260625193320.260312-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rEj79LXoP2OJ8naR"
Content-Disposition: inline
In-Reply-To: <20260625193320.260312-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--rEj79LXoP2OJ8naR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 03:33:20PM -0400, Stefan Hajnoczi wrote:
> Container image builds have started failing because zlib.net no longer
> hosts the 1.3.1 tarball. Move to the 1.3.2 release from February 17,
> 2026.
>=20
>   $ make docker-image-emsdk-wasm64-cross
>   changing dir to build for make "docker-image-emsdk-wasm64-cross"...
>   make[1]: Entering directory 'qemu/build'
>     BUILD   emsdk-wasm64-cross
>   ...
>   xz: (stdin): File format not recognized
>   tar: Child returned status 1
>   tar: Error is not recoverable: exiting now
>   Error: building at STEP "RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSI=
ON.tar.xz |     tar xJC /zlib --strip-components=3D1": while running runtim=
e: exit status 2
>   make[1]: *** [qemu/tests/docker/Makefile.include:43: docker-image-emsdk=
-wasm64-cross] Error 2
>   make[1]: Leaving directory 'qemu/build'
>   make: *** [GNUmakefile:6: build] Error 2
>=20
> Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied:
https://gitlab.com/stefanha/qemu/commits/master

Stefan

--rEj79LXoP2OJ8naR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo9swAACgkQnKSrs4Gr
c8i0TAf/ZoREL+Xf/xd2VzvHyCD92i0Fas2XP9oJZxRyU0k93/2wG3G1gi2XWyuI
2eD0Ivp1OyLjXXHVUrjEZQw0bvE/oArt3f55CN5OgoPX8ZWaQckgl2i+OJsPWnQo
d9ReAGLjf6xD+XrH+ji2YvBHDGuupQ+aud+D4/ReV3DhXYYoq3NsyXVfU6VQSL8F
e+M/3/bzRwrgAZv7QS4nXBp3QDoonz4OQOH595nYXFzIvgHo7AEdrNoDMTv6Nl6g
PHVN0EpQh7ylO7szNVQWneSr6tfXeAXijAPr7BtnslP9z0PFGEb5EzyY1lMoFPB3
gjdQFikeRLdoLfQbnYXli7VnHFaaNQ==
=+8f7
-----END PGP SIGNATURE-----

--rEj79LXoP2OJ8naR--


