Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2915C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhlF-0007eO-B7; Mon, 11 Mar 2024 11:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rjhlD-0007e8-KV
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rjhlB-0007UI-SJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710171616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QI6nAQnl1KYFDj169Yn3zr50d67w33gak1crerE+Qxg=;
 b=YzcKm6zLXydWpqvmGU1rfW5zgZeYI8casMRH/V3TagS94OvJfC2z4qVGKAvODau1n6wgnN
 uEKWPQr1AuoDzwGBpTFfje9zHabVFuJDMI66k4+TQZQWnIbDknSFiUhBIEz5bDyEbil6bS
 R0P/9v/sUMM4nncO1DKHPxK6VbRcc3M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-r0WrAGjxP-umSmR0gaqbHA-1; Mon,
 11 Mar 2024 11:40:09 -0400
X-MC-Unique: r0WrAGjxP-umSmR0gaqbHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 366003CBDF6A;
 Mon, 11 Mar 2024 15:40:09 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6400C2166AE4;
 Mon, 11 Mar 2024 15:40:06 +0000 (UTC)
Date: Mon, 11 Mar 2024 16:40:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <Ze8l1fzr0oxIFxO1@redhat.com>
References: <20240311054333.1264776-1-ppandit@redhat.com>
 <20240311130908.GA327967@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xuyqRwusJGxmgjxR"
Content-Disposition: inline
In-Reply-To: <20240311130908.GA327967@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--xuyqRwusJGxmgjxR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.03.2024 um 14:09 hat Stefan Hajnoczi geschrieben:
> On Mon, Mar 11, 2024 at 11:13:33AM +0530, Prasad Pandit wrote:
> > From: Prasad Pandit <pjp@fedoraproject.org>
> >=20
> > Libaio defines IO_CMD_FDSYNC command to sync all outstanding
> > asynchronous I/O operations, by flushing out file data to the
> > disk storage.
> >=20
> > Enable linux-aio to submit such aio request. This helps to
> > reduce latency induced via pthread_create calls by
> > thread-pool (aio=3Dthreads).
> >=20
> > Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> > ---
> >  block/file-posix.c | 12 ++++++++++++
> >  block/linux-aio.c  |  5 ++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >=20
> > v2: if IO_CMD_FDSYNC is not supported by the kernel,
> >     fallback on thread-pool flush.
> >   -> https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg01986.=
html
> >=20
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 35684f7e21..4f2195d01d 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2599,6 +2599,18 @@ static int coroutine_fn raw_co_flush_to_disk(Blo=
ckDriverState *bs)
> >      if (raw_check_linux_io_uring(s)) {
> >          return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH);
> >      }
> > +#endif
> > +#ifdef CONFIG_LINUX_AIO
> > +    if (raw_check_linux_aio(s)) {
> > +        ret =3D laio_co_submit(s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
> > +        if (ret >=3D 0) {
> > +            /*
> > +             * if AIO_FLUSH is supported return
> > +             * else fallback on thread-pool flush.
> > +             */
> > +            return ret;
> > +        }
>=20
> Falling back every time on an older host kernel might be a noticeable
> performance regression. That can be avoided with a variable that keeps
> track of whether -EINVAL was seen before and skips Linux AIO in that
> case.
>=20
> However, it appears that popular distributions starting from Debian 10,
> Ubuntu 20.04, Fedora 27, CentOS 8, and OpenSUSE Leap 15.5 have the
> necessary minimum Linux 4.18 kernel:
> https://repology.org/project/linux/versions
>=20
> Fallback should be very rare, so I don't think it needs to be optimized:
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

We might need this approach for a different reason: This is an
io_submit() error, so while we retry the flush with the fallback path,
other requests in the same batch may incorrectly return errors. This
probably explains the errors Prasad saw in the guest when the kernel
doesn't have support for flush in Linux AIO.

So in order to avoid this, we'll probably have to send one flush just to
probe (while making sure that no other request is pending - maybe
immediately when opening the image?) and then remember whether it
worked.

Or we'd have to change the error handling around io_submit(), so that we
don't always fail the first request in the batch, but first fail any
flushes and only then the rest of the requests.

Kevin

--xuyqRwusJGxmgjxR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmXvJdUACgkQfwmycsiP
L9Z8wQ/+ITchV432x8ZwZQYJaNkgVYrUSEhfgI2Jp+72kJqikSUaFNmRwW2JHBU1
fkn+eKH8ebSwFVWUpklWvXvWLLdOurQUw6LB8gmhIdkeeijbYAqqBWs547FdpDjA
7R1rxvdRtts19qLu25e7s/A1FZhQ0TFsswIUr4qbUR2dhhSK6OT26NxBR4FCa8nM
B4sry4GMBfGudbypoxpc9LPXI7RrQvPNWTuPg1di/aojd6GMj9ElDPKy1C7uOffw
f1GIWH7LvA/Y+F3vkvUjOtXDOJUScknvip1gvn2yDaf9PgZMn74BDosgR7klNsOs
VwffOKh1Tb3z6a2Eis4dQrxh4Pnrdx/hECgihbiNdcCf1+kFMfK9iskgu1uT1McI
DLxCWLr4qJ5pQPb97l4VoMwuEe0YeShUKTGgr72XZyjyaIFw8XydBONwLAH2AftY
ohCLJeRw4/KPedNH4ybHyrtlg3n5dyiCd52OtSq66Mv+VUBTD67tTTaqRzV6dthc
fuF2HCWqCfr5pQytiQe6nr7kYbBDAFEPUWdGPaE2Y5V8QVtmF+yD/l/qfgepprlb
RIViXQQ2fgXIzD8FZyrrFixbkKlqN+xePoaBbvZXRRa6lVeFZ/FNfhTnwvT/XD2o
EziA8/UYAu7dqRBrcmPNmbPMIip4o+pU6xArVOtYvL39mXEulBo=
=6+lZ
-----END PGP SIGNATURE-----

--xuyqRwusJGxmgjxR--


