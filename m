Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2455ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyhU-0001Ts-JH; Tue, 09 Jun 2026 11:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWyhT-0001TL-BP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWyhR-0006Ax-Lr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781020149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63O4CPnqUaSEl63DsywwtcFQqV5DODFneFnvjsq9wLI=;
 b=PWNethTfHgXqACWS6MWc8cRs5DjSa/e+IA2ZXW6MW5eFqlut8W6V/7dC73UO5TEXYRIg2i
 fKKovoWiWz2Ly+Ny56fabb3AJMTrlj+47dxytzibPOM4IilCbTHap+Fn47Unm/1xlJb+Vt
 Mva1MCnNpSepEZ3JxCi2YNJr2RmmXyg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-QuZcLJzYOESu9ehiR4PMBA-1; Tue,
 09 Jun 2026 11:49:05 -0400
X-MC-Unique: QuZcLJzYOESu9ehiR4PMBA-1
X-Mimecast-MFC-AGG-ID: QuZcLJzYOESu9ehiR4PMBA_1781020144
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A86DA180A973; Tue,  9 Jun 2026 15:49:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.141])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5B5736535; Tue,  9 Jun 2026 15:49:03 +0000 (UTC)
Date: Tue, 9 Jun 2026 11:49:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Boudewijn van der Heide <boudewijn@delta-utec.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] block: switch to co_wrapper_mixed for blk_lock_medium()
 and blk_eject()
Message-ID: <20260609154900.GC57581@fedora>
References: <20260530175822.10321-1-boudewijn@delta-utec.com>
 <aiay6pgFEurQMtrx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vFodwuVgBO9vbVih"
Content-Disposition: inline
In-Reply-To: <aiay6pgFEurQMtrx@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--vFodwuVgBO9vbVih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 02:17:46PM +0200, Kevin Wolf wrote:
> [Cc: Paolo, Stefan]
>=20
> Am 30.05.2026 um 19:58 hat Boudewijn van der Heide geschrieben:
> > scsi_disk_emulate_command() can be called from a coroutine;
> > when req->cmd.buf[0] is ALLOW_MEDIUM_REMOVAL, the synchronous
> > blk_lock_medium() is called, which hits assert(!qemu_in_coroutine()),
> > and crashes:
> >=20
> > 	qemu-system-hppa: block/block-gen.c:1692: blk_lock_medium:
> > 	Assertion `!qemu_in_coroutine()' failed.
> >=20
> > blk_eject() has the same problem, it can be called from coroutine,
> > because the same vtable entry (SCSIReqOps.send_command,
> > scsi_disk_emulate_command() here) calls blk_eject when req->cmd.buf[0]
> > is START_STOP.
> >=20
> > Fix by switching to co_wrapper_mixed for blk_lock_medium() and
> > blk_eject() instead of just co_wrapper.
> >=20
> > Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>
>=20
> Yes, that will fix your immediate symptoms. I'm not completely sure if
> that's the level where we want to fix things, though, which is why I
> added Paolo and Stefan to Cc.
>=20
> > ---
> > Observed crash on fedora qemu-10.1.5-1.fc43 on x86_64 host using qemu-s=
ystem-hppa.
> >=20
> > trace:
> >=20
> > Thread 1 (...):
> >         # 5 __assert_fail (...) at assert.c
> >         # 6 blk_lock_medium (...) at block/block-gen.c
> >         # 7 scsi_disk_emulate_command (...) at ../hw/scsi/scsi-disk.c
> >         # 8 scsi_req_enqueue (...) at ../hw/scsi/scsi-bus.c
> >         # 9 lsi_do_command (...) at ../hw/scsi/lsi53c895a.c
> >         # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c
> >         # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c
> >         # 12 blk_aio_complete (...) at ../block/block-backend.c
> >         # 14 blk_aio_read_entry (...) at ../block/block-backend.c
> >         # 15 in coroutine_trampoline (...) at ../util/coroutine-ucontex=
t.c
> >=20
> > blk_eject() has the same path, but req->cmd.buf[0] is START_STOP instead
> > of ALLOW_MEDIUM_REMOVAL inside scsi_disk_emulate_command(),
> > so fix that aswell.
>=20
> This would be useful information to have in the commit message proper.
>=20
> The step from #10 to #11 seems to be a rather big one that left out
> intermediate function calls, so I'm not sure if I fully understand it.
>=20
> Either way, I don't think lsi_execute_script() and the functions called
> by it were ever written with the intention to run in a coroutine. I'm
> almost sure that problems can be in more than just the two functions
> you're changing here. So my question is mostly, should the path involve
> a BH somewhere to break out of coroutine context, instead of making one
> or two specific cases work?

The code path in this bug is from the block layer (blk_aio_read_entry ->
blk_aio_complete) to scsi-disk (scsi_read_complete_noio) into the LSI
device (probably lsi_command_complete -> lsi_resume_script ->
lsi_execute_script).

I'm not sure if the LSI device, which is unaware of coroutines, should
have to work around this. It seems cleaner for blk_aio_preadv() to
invoke cb() from outside coroutine context since that API does not say
anything about coroutine contexts.

On the other hand, there will be a performance overhead for leaving
coroutine context even when it would be fine to run in a coroutine...

> If the general feeling is that we do want to make essentially all of the
> SCSI code coroutine_mixed_fn and are prepared to fix any issues arising
> from it, then this patch is fine as far as I am concerned.
>=20
> Kevin
>=20
> > ---
> >  include/system/block-backend-io.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/system/block-backend-io.h b/include/system/block-b=
ackend-io.h
> > index fd84723d9d..7368ad5c09 100644
> > --- a/include/system/block-backend-io.h
> > +++ b/include/system/block-backend-io.h
> > @@ -81,10 +81,10 @@ bool coroutine_fn GRAPH_RDLOCK blk_co_is_available(=
BlockBackend *blk);
> >  bool co_wrapper_mixed_bdrv_rdlock blk_is_available(BlockBackend *blk);
> > =20
> >  void coroutine_fn blk_co_lock_medium(BlockBackend *blk, bool locked);
> > -void co_wrapper blk_lock_medium(BlockBackend *blk, bool locked);
> > +void co_wrapper_mixed blk_lock_medium(BlockBackend *blk, bool locked);
> > =20
> >  void coroutine_fn blk_co_eject(BlockBackend *blk, bool eject_flag);
> > -void co_wrapper blk_eject(BlockBackend *blk, bool eject_flag);
> > +void co_wrapper_mixed blk_eject(BlockBackend *blk, bool eject_flag);
> > =20
> >  int64_t coroutine_fn blk_co_getlength(BlockBackend *blk);
> >  int64_t co_wrapper_mixed blk_getlength(BlockBackend *blk);
> > --=20
> > 2.54.0
> >=20
>=20

--vFodwuVgBO9vbVih
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmooNewACgkQnKSrs4Gr
c8gPFQf9FGq+hLl1Z4Mcaned4d8YsSmEHmdQD7yrddO+74dSS7+MZkdwaQ56aKP6
tFiki/u97wxlx/mURGP/WjVS/+6rgaQUOoL7xLnJFg9D9YGcJ2yC3UgrCgIg12Ny
7EZNFMrPh0fZmTiF/NKXqsBlSStXFY1kz+Qzdsks0U0FlvCu2yXcn4XyY8+HekDZ
p/re5KBcIF9cm3DxQXBugB4FBNGrR8bMHJgQ3CgRIS5IrZX9stRGbKlryfAOB9JN
z0aO2tslpkJ5CLVk1DoLN3LfO2qbJIjThb9sCKT8n81CAPGIP3jIlUz6cpim3eqX
3z8Oq7/7Y+cMlzO7veNXfI+7iAPV7A==
=dqJE
-----END PGP SIGNATURE-----

--vFodwuVgBO9vbVih--


