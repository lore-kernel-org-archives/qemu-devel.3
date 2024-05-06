Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A73DC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s42m7-00052a-VR; Mon, 06 May 2024 14:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s42m6-00051u-2y
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s42m4-0007q9-5s
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715018954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7O6dUPFkwmDle7Dj1o3ADQtOM4cQu1Ei0/mYQVeDaQ=;
 b=ie5GN0TsdO8GtRnMVkx0LNthx6kt//VQ65e/pSpkMEFasCpGkuxKbDuOh79DdtWlCiz2/W
 grrpnXz+vbPfAukZvWWVbfR03PwYsgSESkyVGtxIwlvQpkmHyMpyJqcEWTpW3bHu6pmZcU
 03g29nMZxYESgCW2uLGPH/mOoInqxBA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-3avuUD9MMSW9EKpNO5NYeQ-1; Mon,
 06 May 2024 14:09:10 -0400
X-MC-Unique: 3avuUD9MMSW9EKpNO5NYeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B7D73C025D2;
 Mon,  6 May 2024 18:09:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93DE21C060D1;
 Mon,  6 May 2024 18:09:09 +0000 (UTC)
Date: Mon, 6 May 2024 14:09:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 5/5] monitor: use aio_co_reschedule_self()
Message-ID: <20240506180908.GB7375@fedora.redhat.com>
References: <20240206190610.107963-1-stefanha@redhat.com>
 <20240206190610.107963-6-stefanha@redhat.com>
 <ZjUf3TkiBO1N264C@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ykADY2Nf4leySL0I"
Content-Disposition: inline
In-Reply-To: <ZjUf3TkiBO1N264C@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ykADY2Nf4leySL0I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 07:33:17PM +0200, Kevin Wolf wrote:
> Am 06.02.2024 um 20:06 hat Stefan Hajnoczi geschrieben:
> > The aio_co_reschedule_self() API is designed to avoid the race
> > condition between scheduling the coroutine in another AioContext and
> > yielding.
> >=20
> > The QMP dispatch code uses the open-coded version that appears
> > susceptible to the race condition at first glance:
> >=20
> >   aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
> >   qemu_coroutine_yield();
> >=20
> > The code is actually safe because the iohandler and qemu_aio_context
> > AioContext run under the Big QEMU Lock. Nevertheless, set a good example
> > and use aio_co_reschedule_self() so it's obvious that there is no race.
> >=20
> > Suggested-by: Hanna Reitz <hreitz@redhat.com>
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qapi/qmp-dispatch.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> > index 176b549473..f3488afeef 100644
> > --- a/qapi/qmp-dispatch.c
> > +++ b/qapi/qmp-dispatch.c
> > @@ -212,8 +212,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCom=
mandList *cmds, QObject *requ
> >               * executing the command handler so that it can make progr=
ess if it
> >               * involves an AIO_WAIT_WHILE().
> >               */
> > -            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_sel=
f());
> > -            qemu_coroutine_yield();
> > +            aio_co_reschedule_self(qemu_get_aio_context());
>=20
> Turns out that this one actually causes a regression. [1] This code is
> =C5=95un in iohandler_ctx, aio_co_reschedule_self() looks at the new cont=
ext
> and compares it with qemu_get_current_aio_context() - and because both
> are qemu_aio_context, it decides that it has nothing to do. So the
> command handler coroutine actually still runs in iohandler_ctx now,
> which is not what we want.
>=20
> We could just revert this patch because it was only meant as a cleanup
> without a semantic difference.
>=20
> Or aio_co_reschedule_self() could look at qemu_coroutine_self()->ctx
> instead of using qemu_get_current_aio_context(). That would be a little
> more indirect, though, and I'm not sure if co->ctx is always up to date.
>=20
> Any opinions on what is the best way to fix this?

If the commit is reverted then similar bugs may be introduced again in
the future. The qemu_get_current_aio_context() API is unaware of
iohandler_ctx and this can lead to unexpected results.

I will send patches to revert the commit and add doc comments explaining
iohandler_ctx's special behavior. This will reduce, but not eliminate,
the risk of future bugs.

Modifying aio_co_reschedule_self() might be better long-term fix, but
I'm afraid it will create more bugs because it will expose the subtle
distinction between the current coroutine AioContext and non-coroutine
AioContext in new places. I think the root cause is that iohandler_ctx
isn't a full-fledged AioContext with its own event loop. iohandler_ctx
is a special superset of qemu_aio_context that the main loop monitors.

Stefan

>=20
> Kevin
>=20
> [1] https://issues.redhat.com/browse/RHEL-34618
>=20

--ykADY2Nf4leySL0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY5HMMACgkQnKSrs4Gr
c8hH/wgAmn/13IKYo0t3wak8vgOxDpo8DW4rCulzL3SjY6dphWHKXS2gqfEX3lDD
7nkRmFEbBSP4LNS9S5b4KuK14mvVMhG8z5yY4FyIM3rRYG59xTbQoP2TbhFLcIp8
+vRICJwtMzBwjGTkgthperC5pXD7dzBQGHMbCbdI8mfea6CjcGlPNSaxPK4H5coE
vVtpkJqkJTLXH3AOJL1aF1S1aTyfohpCVlVuHRVGVgsZ1XE6crMTzNbjFf3b8Sm8
j/nO13fyHJkIsddqOsrQLY3Efhg5iaNY6bl42ZU8R6eJ4iwuHEpbYnRWya4OG1kC
wWXo9yS0GuYXzXHniqPTKthcJNJCpA==
=Vr0K
-----END PGP SIGNATURE-----

--ykADY2Nf4leySL0I--


