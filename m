Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA78CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92kL-0001kb-V9; Wed, 15 Oct 2025 10:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92kJ-0001jW-7M
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92k6-0006ca-AE
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760539478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+zwNTG5KpNvxHJXWOPGAz3XgQimlMKcBwAd8hXXKuY=;
 b=dmYVZj4KG89r1dO1jqw6ak9wgrFcWE87QccioNwaQsolO+AeBy5E86cMvaCH+k4qYccbz3
 NmS61P150veW3EoEbpRlVu3kV/gRCFcng4DyRm8PWyF+bhMIE+8N1yGgb/2aTcAb+r4Wn0
 vSDiFXCnqIRfTXeoIU0XZNobFJhz8TU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-L2yeouLAON67Mm3OqcM2HA-1; Wed,
 15 Oct 2025 10:44:33 -0400
X-MC-Unique: L2yeouLAON67Mm3OqcM2HA-1
X-Mimecast-MFC-AGG-ID: L2yeouLAON67Mm3OqcM2HA_1760539472
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1CFC19541AD; Wed, 15 Oct 2025 14:44:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D3E71800451; Wed, 15 Oct 2025 14:44:31 +0000 (UTC)
Date: Tue, 14 Oct 2025 15:49:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 08/12] aio-posix: gracefully handle
 io_uring_queue_init() failure
Message-ID: <20251014194909.GG18850@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-9-stefanha@redhat.com>
 <aOfgg0rhCUcpgObo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lWKLPmS9f8JJWvXd"
Content-Disposition: inline
In-Reply-To: <aOfgg0rhCUcpgObo@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--lWKLPmS9f8JJWvXd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 06:19:15PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > io_uring may not be available at runtime due to system policies (e.g.
> > the io_uring_disabled sysctl) or creation could fail due to file
> > descriptor resource limits.
> >=20
> > Handle failure scenarios as follows:
> >=20
> > If another AioContext already has io_uring, then fail AioContext
> > creation so that the aio_add_sqe() API is available uniformly from all
> > QEMU threads. Otherwise fall back to epoll(7) if io_uring is
> > unavailable.
> >=20
> > Notes:
> > - Update the comment about selecting the fastest fdmon implementation.
> >   At this point it's not about speed anymore, it's about aio_add_sqe()
> >   API availability.
> > - Uppercase the error message when converting from error_report() to
> >   error_setg_errno() for consistency (but there are instances of
> >   lowercase in the codebase).
> > - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> > @@ -369,7 +370,7 @@ static const FDMonOps fdmon_io_uring_ops =3D {
> >      .gsource_dispatch =3D fdmon_io_uring_gsource_dispatch,
> >  };
> > =20
> > -bool fdmon_io_uring_setup(AioContext *ctx)
> > +void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
> >  {
> >      int ret;
>=20
> Same as in the previous patch, it would be more conventional to keep the
> bool return code in addition to the Error **. Either way:

Will fix in v5.

>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>=20

--lWKLPmS9f8JJWvXd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjuqTUACgkQnKSrs4Gr
c8hYRAf+K3ZZadPQjwDQNtOxmBSp8j8p99H57ILX8D0jbpMi3+JukdgHZGbaW8Ru
kWyCoA/si3qX69i5eSXvwtqEwtkrGhM8dPz6uQZT9OhjHZuvyJ1oD6kMh9nLbt80
1vJf2l5E0DdXf0MRQ6ttInEBiFcsNIasW1rHqLKpz0QABoQm1Pjn9Im9JIGh8y1i
v/m7/N9bHap9ZDScIIKUpq83mGCNI5DAFJBJya4JyVlwSHD4oEs0Xa3D5imt0uiQ
5TMM5sq6J+feutlMDe5vg3hfN/EHl+Y7TZy1THs5/N5Riko9ta0c/urRSo60DY6p
GpeRf20SNHl7MBGAZnDsiILmZ6g6WA==
=kOBp
-----END PGP SIGNATURE-----

--lWKLPmS9f8JJWvXd--


