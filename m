Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6339AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 17:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNEiX-0000jb-37; Thu, 05 Jun 2025 13:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNEiQ-0000ic-Ob
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNEiO-0002rR-Ff
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749145759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ruLWNn3OaOztSi0DqWoo4GPDkcB5fYhKH0YrKTQdEQ=;
 b=AmvVSi5SvA9MjXxz9juequzfGiTyoiSzhtchDtrwou+azTpvIdAk0GGk1oKXymYM4iaAzE
 dlnromXjL5eoa+CaZ2Et7crCEWI9ej/RHp6+SzvzJWYIAzsdkRqXeIrSoMishxA1nsYoqd
 HJENy2LZ6zu+RvuISf3AY7K+hBIyvKY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-Ib303LL6MS6DEeZKqBapdQ-1; Thu,
 05 Jun 2025 13:49:16 -0400
X-MC-Unique: Ib303LL6MS6DEeZKqBapdQ-1
X-Mimecast-MFC-AGG-ID: Ib303LL6MS6DEeZKqBapdQ_1749145754
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 033221808847; Thu,  5 Jun 2025 17:49:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E61418003FD; Thu,  5 Jun 2025 17:49:09 +0000 (UTC)
Date: Thu, 5 Jun 2025 13:49:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 06/11] aio: free AioContext when aio_context_new() fails
Message-ID: <20250605174902.GA480967@fedora>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-7-stefanha@redhat.com>
 <bsrzx5um4n7s4prcebziybzhxum3fjler6y7od4rbswhctiqpr@jtkwa4iu6rmc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+sbna+kv1wWdLlSs"
Content-Disposition: inline
In-Reply-To: <bsrzx5um4n7s4prcebziybzhxum3fjler6y7od4rbswhctiqpr@jtkwa4iu6rmc>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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


--+sbna+kv1wWdLlSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 04:06:13PM -0500, Eric Blake wrote:
> On Wed, May 28, 2025 at 03:09:11PM -0400, Stefan Hajnoczi wrote:
> > g_source_destroy() only removes the GSource from the GMainContext it's
> > attached to, if any. It does not free it.
> >=20
> > Use g_source_unref() instead so that the AioContext (which embeds a
> > GSource) is freed. There is no need to call g_source_destroy() in
> > aio_context_new() because the GSource isn't attached to a GMainContext
> > yet.
> >=20
> > aio_ctx_finalize() expects everything to be set up already, so introduce
> > the new ctx->initialized boolean and do nothing when called with
> > !initialized. This also requires moving aio_context_setup() down after
> > event_notifier_init() since aio_ctx_finalize() won't release any
> > resources that aio_context_setup() acquired.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/block/aio.h |  3 +++
> >  util/async.c        | 12 ++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >=20
>=20
> > +++ b/util/async.c
> > @@ -369,6 +369,10 @@ aio_ctx_finalize(GSource     *source)
>=20
> While you're here, is it worth cleaning up that odd spacing in the
> function parameter list?

Yes.

Stefan

--+sbna+kv1wWdLlSs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhB2I4ACgkQnKSrs4Gr
c8iRwgf/f4C9/6zIgOBWAbFn6Dmw25N/1rY5tmbdGda5t1zxH9YqB6upHosyT9bz
lAEqMrJz88NlHx32kvxI8bphC1ZPHTBgdfmo/0RWFvyiIjClbSpoTWwQWJDf8VYQ
8ttfdljJyA1X104QJySh8I8klM3ALWjOHpui1o4xKJLAj4FMu5MLDCnSDHGbsSQ1
zd1tWHH4vZnE8YpK4AUdj/LTthIvmqunGMGuhu2M/5lRZnbMbRpISmhm81DAPlVb
12JqVxcDRbELthZ3TLbArWVjIbAifztajQY6sx8zRwXfuGnrvUT1LcTbtHiJihfa
B54XmnUf/9alvutmsGNPlMJF+PZn0g==
=Rfbn
-----END PGP SIGNATURE-----

--+sbna+kv1wWdLlSs--


