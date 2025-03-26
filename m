Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A061C3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSCp-0007jl-Sb; Wed, 26 Mar 2025 10:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txSCo-0007i5-2q
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txSCm-0001ra-H3
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743001087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iCgd6qABCsBo8wKBo4Fp4nb65vMu6ZhUrL8xx2jyCfA=;
 b=cg7/Y1CfXUt8ZpXejEZKywqkc52swZ5LiqqX37UBP8lbcgkbdhnWWqJoLf3qtP/JgI4QBn
 J8XAbeATA7cizokU8rXUCJQTqAIbGsi9R+quyp6MPiAHBc1iHXHiZaUyTZYZqzGcVT005E
 8uRe88dxn7LYCiGGygd05BB8o1TAoEI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-Owo8tfEdONmwyxOg5e24jA-1; Wed,
 26 Mar 2025 10:58:04 -0400
X-MC-Unique: Owo8tfEdONmwyxOg5e24jA-1
X-Mimecast-MFC-AGG-ID: Owo8tfEdONmwyxOg5e24jA_1743001083
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A71C4196B377; Wed, 26 Mar 2025 14:58:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.113])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 365A81956095; Wed, 26 Mar 2025 14:58:01 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:57:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: ~h0lyalg0rithm <surajshirvankar@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH qemu 1/1] Add IOURING_SETUP_SINGLE_ISSUER flag to improve
 iouring performance
Message-ID: <20250326145759.GC783416@fedora>
References: <174293621917.22751.11381319865102029969-0@git.sr.ht>
 <174293621917.22751.11381319865102029969-1@git.sr.ht>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L3dtV/1I1Uq+fdFo"
Content-Disposition: inline
In-Reply-To: <174293621917.22751.11381319865102029969-1@git.sr.ht>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--L3dtV/1I1Uq+fdFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 09:49:38PM +0100, ~h0lyalg0rithm wrote:
> From: Suraj Shirvankar <surajshirvankar@gmail.com>
>=20

Please include the rationale for this change in the commit description.
This way anyone reading the git log will be able to understand the
intent behind this change. Something like:

  IORING_SETUP_SINGLE_ISSUER enables optimizations in the kernel for
  applications that only access the io_uring context from one thread.
  QEMU calls io_uring_enter(2) from one AioContext, so it is safe to
  enable this flag.

> Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
> ---
>  util/fdmon-io_uring.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

`make check` fails with this patch applied because aio_context_new()
(which calls fdmon_io_uring_setup()) is called before the thread is
created. When fdmon_io_uring_wait() is called the io_uring context is
now being used by another thread:

  qemu-system-x86_64: ../util/fdmon-io_uring.c:330: fdmon_io_uring_wait: As=
sertion `ret >=3D 0' failed.

Once this hurdle is overcome it should be possible to use
IORING_SETUP_SINGLE_ISSUER. Two ideas:

1. Modify aio_context_new() callers so they create the AioContext inside
   the thread.

2. Defer io_uring context creation until it is needed. It's probably
   still a good idea to create a temporary io-uring context early during
   startup to check that io_uring is available (and then destroy it
   right away).

I slightly prefer the first option.

>=20
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index b0d68bdc44..235837abcb 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -324,8 +324,14 @@ static const FDMonOps fdmon_io_uring_ops =3D {
>  bool fdmon_io_uring_setup(AioContext *ctx)
>  {
>      int ret;
> +    unsigned int flags =3D 0;
> =20
> -    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_u=
ring, 0);
> +    /* This improves performance but can be skipped on old hosts */
> +#ifdef IORING_SETUP_SINGLE_ISSUER
> +    flags |=3D IORING_SETUP_SINGLE_ISSUER

The semicolon is missing at the end of the line.

> +#endif
> +
> +    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_u=
ring, flags);
>      if (ret !=3D 0) {
>          return false;
>      }
> --=20
> 2.45.3
>=20

--L3dtV/1I1Uq+fdFo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfkFfcACgkQnKSrs4Gr
c8igDQf+IQF7ysaQzhm+KfVr2vpl9id3mkQ7mvo1uq1dRvOEEoivS0bpTHXDauE3
u1jdMzeGOjw8kYctgxZYDmaWxR+LsuEjhc+zkmSHbPUbf0TJIKXwfWv5o8kueGhE
3sCccdDRIwXGx0ldKiaBmGWVo8ZD96R4gdX8rR/1NNI5YZDAKtk6S9po3k3nzxBr
LtRQ5IBWF2EPhKp4CDs6ZItV5HYWFfG+v2VKIcV2xGKATsIbrkPkFdPOX6hUUEFZ
hMk7+d4DW99X7EGYGBCk2ZZ4fCADB7JXdWkLb+2sE/bE5Ac1+LEPIbeBXr0xs4ZI
jdoOxEoFPXYvYf6MeR9tipZDJyRmmw==
=5M7O
-----END PGP SIGNATURE-----

--L3dtV/1I1Uq+fdFo--


