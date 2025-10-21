Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62676CCD1B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHcb-00058P-IG; Tue, 21 Oct 2025 15:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vBHcV-00057o-O5
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vBHcS-0006PC-Jn
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761073321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O61Nif8BfKMVGQfy7vPSgNkmPPeLl4TBOuvYtPpTPk8=;
 b=QSYZtLjIXfnfc8c9EesKsJ7E3P/EmmjwBDGKGt4094tIMkvLFlBUVNI9ZgzDTS46py++RQ
 FITlkD01I42u8AdjhO+b16Z20iyZI7BAQKULl4CvmnBRUGRecFbvXf4f7NKC/e3MB1H/dq
 k1985KhxhgSDe5uyVYOcA3dWRwwSFfo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-ChbvzOFdNReq35gvo-jEiw-1; Tue,
 21 Oct 2025 15:01:58 -0400
X-MC-Unique: ChbvzOFdNReq35gvo-jEiw-1
X-Mimecast-MFC-AGG-ID: ChbvzOFdNReq35gvo-jEiw_1761073317
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56D191954200; Tue, 21 Oct 2025 19:01:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0030180057D; Tue, 21 Oct 2025 19:01:54 +0000 (UTC)
Date: Tue, 21 Oct 2025 15:01:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 05/12] aio: remove aio_context_use_g_source()
Message-ID: <20251021190153.GA4837@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-6-stefanha@redhat.com>
 <aOfY8TgysdujAL-l@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s2bZkVaog2rBsx80"
Content-Disposition: inline
In-Reply-To: <aOfY8TgysdujAL-l@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--s2bZkVaog2rBsx80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 05:46:57PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > There is no need for aio_context_use_g_source() now that epoll(7) and
> > io_uring(7) file descriptor monitoring works with the glib event loop.
> > AioContext doesn't need to be notified that GSource is being used.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> We should probably mention in the commit message that this causes the
> default fdmon on Linux to change from poll to io_uring. It's a small
> code change, but it makes QEMU use a completely different code path by
> default.
>=20
> With this added: Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Will fix.

> > diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested=
-aio-poll.c
> > index 45484e745b..d13ecccd8c 100644
> > --- a/tests/unit/test-nested-aio-poll.c
> > +++ b/tests/unit/test-nested-aio-poll.c
> > @@ -83,12 +83,6 @@ static void test(void)
> >      /* Enable polling */
> >      aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
> > =20
> > -    /*
> > -     * The GSource is unused but this has the side-effect of changing =
the fdmon
> > -     * that AioContext uses.
> > -     */
> > -    aio_get_g_source(td.ctx);
> > -
> >      /* Make the event notifier active (set) right away */
> >      event_notifier_init(&td.poll_notifier, 1);
> >      aio_set_event_notifier(td.ctx, &td.poll_notifier,
>=20
> I wonder if it wouldn't make sense to squash this hunk into patch 3
> ('tests/unit: skip test-nested-aio-poll with io_uring').

Sure, I will move it.

--s2bZkVaog2rBsx80
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj32KAACgkQnKSrs4Gr
c8hOQQf+LoV8mDbdX6CnApWyuKH6EZLUbGLb8J+egNBTRQ4TlsmSj0TfU0aHX9N5
o2XoH5KjAjF6yu2L8z850C+zSD0Q5GxeGR0+EOlaT9RiaCM8AXFq3LwGCQ8zzXvP
SGiunI/EVCS7tBjLayCSzKNoTNuW0Up5FLdsO0fIOe4bVCgzEEUWr4Xq9GBGB6Nm
cnH/LFdIi27i9m58abYvYLuuieJohhlwIGyY64kpdiXHg5H30GJJQ6Ot5DbdSfE7
UAExtbx6TZB7MejPVWPvW4bgRDjLVLlso/9M1hG+PdGT1P1OIRP3FQrJo7P+jUDy
dkcH30kpe+Yan9VqqPs6yUEpdvV7cQ==
=8nCs
-----END PGP SIGNATURE-----

--s2bZkVaog2rBsx80--


