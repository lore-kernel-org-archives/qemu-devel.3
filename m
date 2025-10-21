Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E27CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBdq7-0003k5-QW; Wed, 22 Oct 2025 14:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vBdq6-0003jg-16
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vBdq3-0003x9-Et
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761158732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7sVJwq8AIMTVOWBAqQAhT67VxN7wBY1rp05biea7sI=;
 b=iKLgr5oGcLLk6Zd6hjFAP0awesJjKTqSyE0tnnxYCFuaW4cNPDOlDYFs2+hBiypVqdv95a
 CI6p35rxkw3+DoYaz0oJaprBuN0hZ6QCuUcevrkNEUuSqE6zDmTGRG5mFcrxFwGpXAKToQ
 7+bpdZ4rfQGsjZ32ZxzAP/+ZgWinLC0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-B5EM9PqJOLi4L67YGusecw-1; Wed,
 22 Oct 2025 14:45:28 -0400
X-MC-Unique: B5EM9PqJOLi4L67YGusecw-1
X-Mimecast-MFC-AGG-ID: B5EM9PqJOLi4L67YGusecw_1761158727
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA632180AE0D; Wed, 22 Oct 2025 18:45:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.231])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A07AB300019F; Wed, 22 Oct 2025 18:45:24 +0000 (UTC)
Date: Tue, 21 Oct 2025 16:42:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 06/12] aio: free AioContext when aio_context_new() fails
Message-ID: <20251021204240.GC4837@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-7-stefanha@redhat.com>
 <aOfdaCyxInxfoLhN@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n1ZuV0kBmG8838pc"
Content-Disposition: inline
In-Reply-To: <aOfdaCyxInxfoLhN@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--n1ZuV0kBmG8838pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 06:06:00PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
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
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> > v2:
> > - Fix spacing in aio_ctx_finalize() argument list [Eric]
> > ---
> >  include/block/aio.h |  3 +++
> >  util/async.c        | 14 +++++++++++---
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/block/aio.h b/include/block/aio.h
> > index 1657740a0e..2760f308f5 100644
> > --- a/include/block/aio.h
> > +++ b/include/block/aio.h
> > @@ -291,6 +291,9 @@ struct AioContext {
> >      gpointer epollfd_tag;
> > =20
> >      const FDMonOps *fdmon_ops;
> > +
> > +    /* Was aio_context_new() successful? */
> > +    bool initialized;
> >  };
> > =20
> >  /**
> > diff --git a/util/async.c b/util/async.c
> > index a39410d675..34aaab4e9e 100644
> > --- a/util/async.c
> > +++ b/util/async.c
> > @@ -363,12 +363,16 @@ aio_ctx_dispatch(GSource     *source,
> >  }
> > =20
> >  static void
> > -aio_ctx_finalize(GSource     *source)
> > +aio_ctx_finalize(GSource *source)
> >  {
> >      AioContext *ctx =3D (AioContext *) source;
> >      QEMUBH *bh;
> >      unsigned flags;
> > =20
> > +    if (!ctx->initialized) {
> > +        return;
> > +    }
>=20
> You had to move aio_context_setup() down in aio_context_new() to make
> sure that this doesn't leak things.
>=20
> How will we make sure that nobody adds another error path after
> allocating something after g_source_new()? g_source_new() doesn't seem
> to guarantee that AioContext starts zeroed, which is annoying if we
> wanted to just make aio_ctx_finalize() safe to be called from before the
> first error path.

Calling aio_ctx_finalize() in all cases was my first thought when
writing this patch, but not all of the cleanup code works even when
resources are NULL. That's why I took the ->initialized field approach.

I will add comments explaining how to handle resource cleanup and the
ordering with aio_context_setup().

Stefan

--n1ZuV0kBmG8838pc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj38EAACgkQnKSrs4Gr
c8h6fAf/WxZb7S/YmirQSQmLl+So5w6LjM6R7ZWp2fIr3zmkuIqmfP9Kj9wP3wwi
4ZidFgRUcUclvTC0XooUmlWMlsuqk+eNkjTZr+VKYWfVzPjj+JAfWpZQw95iKaJD
OOb/2Y0da7hqIJMOwBW+9oDnJPDgR3ybWMi2f6fbmaseUob70eEsvyIXTVw+VcQx
V0hvME3eUVcqqGTdf3wz5VOS6tN/EI4mBDneV15/mha8XUvQOkyTZIjl/N7fGwC5
plshgxazu4NcfN5xceReYZ1/JJ8DdRATA/mLouTjIIN5lUSDT4MgfFrTwHvB+BrO
AH8syV5rPwLJ+jnX1O7JXTWpq7D6Lg==
=TrRi
-----END PGP SIGNATURE-----

--n1ZuV0kBmG8838pc--


