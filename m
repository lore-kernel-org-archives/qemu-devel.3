Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFACCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXF64-0001Kj-3g; Wed, 10 Jun 2026 05:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXF61-0001KK-8h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXF5z-0007Fn-Jc
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781083174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZiIbcAe7HOT2y9jnZh45Ut8CECG0t8YVbo++JEXlZ2U=;
 b=dMyS7ZDiFD7lBeLTnQB4tN1hh7MQnzmFFmJCSVZVDOk38JtKzQdh2enF0+dR3oq86T4qqU
 1wqT+KsGsR1KcN2k6bAIotBIcevQ6cjIXAYTspPQTiuVAk1XKND7QU63U2GzVpQWYSdLqN
 A8QjqwyX+t3LyjjR2TyfqXkKCdzbz0A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-yD-DmEO5OBOwjmVzZqG5zw-1; Wed,
 10 Jun 2026 05:19:33 -0400
X-MC-Unique: yD-DmEO5OBOwjmVzZqG5zw-1
X-Mimecast-MFC-AGG-ID: yD-DmEO5OBOwjmVzZqG5zw_1781083172
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E10E19352E2; Wed, 10 Jun 2026 09:19:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.216])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 104A31954112; Wed, 10 Jun 2026 09:19:29 +0000 (UTC)
Date: Wed, 10 Jun 2026 11:19:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Boudewijn van der Heide <boudewijn@delta-utec.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] block: switch to co_wrapper_mixed for blk_lock_medium()
 and blk_eject()
Message-ID: <aiksHyfQnJIs_1OH@redhat.com>
References: <20260530175822.10321-1-boudewijn@delta-utec.com>
 <aiay6pgFEurQMtrx@redhat.com> <20260609154900.GC57581@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CBmt52kjtlu3iVKi"
Content-Disposition: inline
In-Reply-To: <20260609154900.GC57581@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--CBmt52kjtlu3iVKi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.06.2026 um 17:49 hat Stefan Hajnoczi geschrieben:
> On Mon, Jun 08, 2026 at 02:17:46PM +0200, Kevin Wolf wrote:
> > [Cc: Paolo, Stefan]
> >=20
> > Am 30.05.2026 um 19:58 hat Boudewijn van der Heide geschrieben:
> > > scsi_disk_emulate_command() can be called from a coroutine;
> > > when req->cmd.buf[0] is ALLOW_MEDIUM_REMOVAL, the synchronous
> > > blk_lock_medium() is called, which hits assert(!qemu_in_coroutine()),
> > > and crashes:
> > >=20
> > > 	qemu-system-hppa: block/block-gen.c:1692: blk_lock_medium:
> > > 	Assertion `!qemu_in_coroutine()' failed.
> > >=20
> > > blk_eject() has the same problem, it can be called from coroutine,
> > > because the same vtable entry (SCSIReqOps.send_command,
> > > scsi_disk_emulate_command() here) calls blk_eject when req->cmd.buf[0]
> > > is START_STOP.
> > >=20
> > > Fix by switching to co_wrapper_mixed for blk_lock_medium() and
> > > blk_eject() instead of just co_wrapper.
> > >=20
> > > Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>
> >=20
> > Yes, that will fix your immediate symptoms. I'm not completely sure if
> > that's the level where we want to fix things, though, which is why I
> > added Paolo and Stefan to Cc.
> >=20
> > > ---
> > > Observed crash on fedora qemu-10.1.5-1.fc43 on x86_64 host using qemu=
-system-hppa.
> > >=20
> > > trace:
> > >=20
> > > Thread 1 (...):
> > >         # 5 __assert_fail (...) at assert.c
> > >         # 6 blk_lock_medium (...) at block/block-gen.c
> > >         # 7 scsi_disk_emulate_command (...) at ../hw/scsi/scsi-disk.c
> > >         # 8 scsi_req_enqueue (...) at ../hw/scsi/scsi-bus.c
> > >         # 9 lsi_do_command (...) at ../hw/scsi/lsi53c895a.c
> > >         # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c
> > >         # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c
> > >         # 12 blk_aio_complete (...) at ../block/block-backend.c
> > >         # 14 blk_aio_read_entry (...) at ../block/block-backend.c
> > >         # 15 in coroutine_trampoline (...) at ../util/coroutine-ucont=
ext.c
> > >=20
> > > blk_eject() has the same path, but req->cmd.buf[0] is START_STOP inst=
ead
> > > of ALLOW_MEDIUM_REMOVAL inside scsi_disk_emulate_command(),
> > > so fix that aswell.
> >=20
> > This would be useful information to have in the commit message proper.
> >=20
> > The step from #10 to #11 seems to be a rather big one that left out
> > intermediate function calls, so I'm not sure if I fully understand it.
> >=20
> > Either way, I don't think lsi_execute_script() and the functions called
> > by it were ever written with the intention to run in a coroutine. I'm
> > almost sure that problems can be in more than just the two functions
> > you're changing here. So my question is mostly, should the path involve
> > a BH somewhere to break out of coroutine context, instead of making one
> > or two specific cases work?
>=20
> The code path in this bug is from the block layer (blk_aio_read_entry ->
> blk_aio_complete) to scsi-disk (scsi_read_complete_noio) into the LSI
> device (probably lsi_command_complete -> lsi_resume_script ->
> lsi_execute_script).
>=20
> I'm not sure if the LSI device, which is unaware of coroutines, should
> have to work around this. It seems cleaner for blk_aio_preadv() to
> invoke cb() from outside coroutine context since that API does not say
> anything about coroutine contexts.
>=20
> On the other hand, there will be a performance overhead for leaving
> coroutine context even when it would be fine to run in a coroutine...

Yes, I don't think it should be done by the block layer when most
callbacks are just fine with running in a coroutine. I was thinking that
maybe something in the SCSI layer should do it, or even scsi-disk
specifically. Though of course, if virtio-scsi doesn't have the problem
(does it?), taking the performance overhead for fixing LSI is probably
also not what we want.

Another, more radical solution, could be to move SCSI requests as a
whole into coroutines, changing the assumption everywhere from
no_coroutine_fn to coroutine_fn without bothering with mixed functions
at all. The SCSI state machine is quite complex and I often find the
control flow in the current callback-based code hard to understand, so I
think this has the potential to improve the code, though of course it
would also be a big change.

Or, of course, we just take this patch, and keep fixing instances of
the problem as they come up.

Kevin

> > If the general feeling is that we do want to make essentially all of the
> > SCSI code coroutine_mixed_fn and are prepared to fix any issues arising
> > from it, then this patch is fine as far as I am concerned.
> >=20
> > Kevin
> >=20
> > > ---
> > >  include/system/block-backend-io.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/system/block-backend-io.h b/include/system/block=
-backend-io.h
> > > index fd84723d9d..7368ad5c09 100644
> > > --- a/include/system/block-backend-io.h
> > > +++ b/include/system/block-backend-io.h
> > > @@ -81,10 +81,10 @@ bool coroutine_fn GRAPH_RDLOCK blk_co_is_availabl=
e(BlockBackend *blk);
> > >  bool co_wrapper_mixed_bdrv_rdlock blk_is_available(BlockBackend *blk=
);
> > > =20
> > >  void coroutine_fn blk_co_lock_medium(BlockBackend *blk, bool locked);
> > > -void co_wrapper blk_lock_medium(BlockBackend *blk, bool locked);
> > > +void co_wrapper_mixed blk_lock_medium(BlockBackend *blk, bool locked=
);
> > > =20
> > >  void coroutine_fn blk_co_eject(BlockBackend *blk, bool eject_flag);
> > > -void co_wrapper blk_eject(BlockBackend *blk, bool eject_flag);
> > > +void co_wrapper_mixed blk_eject(BlockBackend *blk, bool eject_flag);
> > > =20
> > >  int64_t coroutine_fn blk_co_getlength(BlockBackend *blk);
> > >  int64_t co_wrapper_mixed blk_getlength(BlockBackend *blk);
> > > --=20
> > > 2.54.0
> > >=20
> >=20



--CBmt52kjtlu3iVKi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmopLB8ACgkQfwmycsiP
L9Ym/w//dEVUFuaWQwd96hyYgMc3ml8cWzbSF0Z09EbsuX8PMAZ7osds83lh1agc
6HSbFAv9DkDZk+EkSrVB/2kQZSPbGjyWCtS+l7JM/HQ/YE34HSZj7RZ3SGv+lEsu
6LdKKFEWWvdurFYFDeWtb9b0nTeVcLSAoJnrHyJCyjwyNwpbZOGJ0B6iRLtBAeK1
Urb7CTTpRJSAOpdS2mEOfiJWuvEFDoZoVpCVjSZZVBUa2jr5CCpgZwM7vqRF01S5
KylF0tgs8Cv8/KaH5S0dI98WTgxfgicvIZUX902cw1vEgPCMBvldma/28631UGEM
bfaRpi3gxXNjF6eKAbfLrFo41POKcPdAHGVHLCU5KpjmPCELH3El70u92oz7pnGs
EVoykAuo9Z8VoMtW8QeMUsZczn8JZiP0qjS9iSZAznCGRTT4hDosUvx+TKb6iKDU
ayY49/nZ69u54gR42jHbMXQFrnQBeRDLIW2e/3bYTL+HzIRJRhCjDqdJcl5PMTbd
U5BnfAyVDV7EMDeWYIo21A5Q2t1Le2UW/p27DWKEcbXvYMkei1RAw0qW7v8FQmgp
fPfYywuoiAnSHPYFnZtIHfwp2iMxzTQvV2dntV0rEqO3XdywrY6qHAK8dzNRwJ3p
X+9qsfViFpbuU2fCliaw5FItobazT/QQi1ksX72X9WOIhRmc6wk=
=I/kf
-----END PGP SIGNATURE-----

--CBmt52kjtlu3iVKi--


