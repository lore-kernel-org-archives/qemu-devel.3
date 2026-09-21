Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D94C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kpW-0004Ne-3f; Mon, 21 Sep 2026 16:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8kpU-0004NB-PO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8kpS-0000hg-KN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790023293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aY2omwHZu245Aie8rA90aG7zZPUyYZQfnJeXZPJAWUE=;
 b=KAPj77J6hB1HDT/POVcnttZ3ksyNvtzY7YZRTAFSmR5EOiRL+d8Zn6YgzMSh24RvL2Gf+N
 3XyWi1mT5pTW9KTuM5HfcCyxtG8rEvX/woY961KxgkdjFeXeSrBoUPO1xXfCA9LNRXUGjx
 7a8LhJMHdI55WgHOwfIrQBAgQ7Kd7r0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-fFpw2nmuPXeRsynGSUi23Q-1; Mon,
 21 Sep 2026 16:41:29 -0400
X-MC-Unique: fFpw2nmuPXeRsynGSUi23Q-1
X-Mimecast-MFC-AGG-ID: fFpw2nmuPXeRsynGSUi23Q_1790023288
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 881FC195DE77; Mon, 21 Sep 2026 20:41:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B27BE1800446; Mon, 21 Sep 2026 20:41:27 +0000 (UTC)
Date: Mon, 21 Sep 2026 16:41:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <20260921204126.GC115897@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WGBazzBCdAK7vkRJ"
Content-Disposition: inline
In-Reply-To: <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--WGBazzBCdAK7vkRJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
> On 03.09.26 16:08, Stefan Hajnoczi wrote:
> > On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
> > > Based-on:<20260724152315.234183-1-hreitz@redhat.com>
> > >            [PATCH 0/6] hw/[block]: Fix missing accounting
> > >            Fri, 24 Jul 2026 17:23:09 +0200
> > >=20
> > > Hi,
> > >=20
> > > I=E2=80=99m told there are installations where storage is very slow, =
and some
> > > would like the VM stack to report this proactively.  To do so, we sho=
uld
> > > (via QAPI events) report on extremely slow I/O requests.
> > >=20
> > > We already have the latency histogram, but this is not deemed suffici=
ent
> > > because it is not proactively reporting and would require repeated
> > > querying.  Therefore, this series introduces the event still.
> > >=20
> > > Now, from a user's perspective, it would be nice if this event could =
be
> > > raised exactly when an I/O request crosses the user-defined threshold,
> > > but this would require keeping all active requests in a list and
> > > checking it periodically.  Now, if we used latency cookies for this
> > Did you consider a per-request timer? The QEMUTimerList active_timers
> > sorted list does not support efficient insertion, but improving it would
> > benefit all timer API users.
>=20
> I'm not sure how that would address the problem. Does that not just move =
the
> list elsewhere?
>=20
> I.e. it still has the problem that every request needs to be put into a l=
ist
> (starting a timer), and be removed when the request is done, or the timer
> will fire and the below problems would occur if the request is done but we
> failed to remove it (either use-after-free; or spurious events plus memory
> leaks on top of a heap allocation per request).

I wasn't thinking about the lifecycle here, but about the current
limitation that users aren't notified until request completion. Requests
can be stuck for a very long time or forever. Using a timer solves the
timeliness problem.

> > > (which makes sense), then that would require that every cookie set up=
 is
> > > also finalized when the request is done, because if we don't, results
> > > could well be catastrophic:
> > > - Either we use cookies as-is, which are often allocated on the stack=
 or
> > >    in some other structure managed by the device; then this would res=
ult
> > >    in use-after-free,
> > > - Or we allocate something specifically for this checking, so lingeri=
ng
> > >    requests would at most create spurious latency events and memory
> > >    leaks, but this would require an additional heap allocation per
> > >    request that we would probably want to avoid.
> > >=20
> > > So ideally we could use latency cookies and could statically verify t=
hat
> > > they are always finalized when the request is done, but doing this in=
 C
> > > may well be impossible.
> > I think you are saying that the cookie API is unsafe because cookie
> > lifetime is not bounded by the request lifetime?
>=20
> Yes, because it is not statically proven to be so.
>=20
> > Maybe the block_acct_*() API can be integrated into the actual request
> > so there is no way to leak the cookie. In other words, directly
> > associate requests with a BlockAcctStats and stop requiring the user to
> > manually manage a separate BlockAcctCookie.
>=20
> I don't follow what you mean concretely. If you are suggesting a list of
> requests in BlockAcctStats, then that is exactly what I had.

I meant that each I/O request should contain its own cookie and there is
never a need to create a cookie separately from the request. That way
the lifetime issue is solved.

This would require API changes because device emulation code currently
has some of the logic for cookies. Devices would no longer call
block_acct_done() once they have called blk_aio_pwritev(), for
example. I haven't looked in detail and am not sure if it's feasible.

> The problem is that if the destructor has to be called explicitly, we may
> forget to do so; and accounting is done on the device emulation level, so
> there is no central place where the pairing of constructor and destructor
> would be obvious and trivial to verify.

This is the part I'm asking about: can accounting be done by the block
layer? There might be cases that are purely handled in device emulation
code without a call into the block layer. In that case the accounting
still needs to be done in device emulation code. But when device
emulation calls blk_aio_*(), it should not do accounting itself.

> I.e. it=E2=80=99s not like our functions current look like
>=20
> ````
> run_co_ide_request() {
> =C2=A0 =C2=A0 start_cookie();
> =C2=A0 =C2=A0 run_co_request();
> =C2=A0 =C2=A0 finalize_cookie();
> }
> ```
>=20
> Where the pairing of start and finalize are obvious; instead, start and s=
top
> are in very different parts of the code, in all device emulation code.
>=20
> > The API is already weird because devices use:
> >=20
> >    block_acct_failed(blk_get_stats(s->blk), &req->acct);
> >=20
> > i.e. why does the device have to reach into s->blk to access the stats?
> > If the stats belong to s->blk, then s->blk should do the accounting
> > during the request lifetime.
> >=20
> > This would require a redesign of not just the cookie API, but also the
> > error policy API. There is also a wrinkle in that virtio-blk merges I/O
> > requests and accounts the merges.
> >=20
> > > So, because it is basically impossible (or at least it would be very
> > > hard, and presumably require a large refactoring) to guarantee, witho=
ut
> > > additional heap allocations, that a list of active requests won=E2=80=
=99t run
> > > into catastrophic use-after-frees, this series does the much simpler
> > > version first, which is to just raise an event when a request *finish=
es*
> > > and took more than a user-defined latency threshold.
> > Does this achieve the goal of warning when requests exceed a threshold?
>=20
> According to
> https://redhat.atlassian.net/browse/RHEL-141617?focusedCommentId=3D181273=
33
> (and the following two comments), yes.

The issue says one purpose of this feature is to pause the guest to
avoid BSODs. This won't work if the request has to finish first, because
the BSOD occurs sometime after the treshold is reached but before QEMU
or any other component can react to the QMP event.

>=20
> > When an I/O request hangs for a long time, the management tool will be
> > unable to detect that the threshold has been exceeded in a timely
> > manner.
>=20
> Yes. But why would that be a real problem?
>=20
> Given the request so far is only to notify users of their storage block
> showing problematic latencies at all, there is no need to provide the ale=
rts
> in actual real time.

What does the current approach solve that is not already possible with
the block latency histogram?

Libvirt could add an API to notify when a particular threshold is
reached without any QEMU changes.

Stefan

>=20
> Hanna
>=20
> > > (PS: The nice thing about throwing an alert while the request is still
> > > going on would be that it could allow us to also stop the VM in case =
of
> > > excessive latency, before the request completes, so the guest would be
> > > shielded from such excessive latency.  This might be useful for Windo=
ws
> > > guests that just have a maximum request lantency before throwing a
> > > BSOD.)
> > >=20
> > >=20
> > > Hanna Czenczek (9):
> > >    block/accounting: Add offset to BlockAcctCookie
> > >    qapi/block: Add IoAccountingOperation enum
> > >    qapi/block: Add BLOCK_IO_DELAY event
> > >    block-backend: Public blk_get_attached_dev_path()
> > >    block/accounting: Add BB field to latency checker
> > >    block/accounting: Emit BLOCK_IO_DELAY event
> > >    block: Add delay-alert-ms property
> > >    block/accounting: Move latency_ns override down
> > >    iotests: Add delay-alert test
> > >=20
> > >   qapi/block.json                          |  52 +++++++++
> > >   include/block/accounting.h               |  20 +++-
> > >   include/hw/block/block.h                 |   5 +-
> > >   include/system/block-backend-io.h        |   9 ++
> > >   include/system/dma.h                     |   2 +-
> > >   block/accounting.c                       |  60 ++++++++--
> > >   block/block-backend.c                    |   8 +-
> > >   blockdev.c                               |  16 ++-
> > >   hw/block/block.c                         |   4 +-
> > >   hw/block/dataplane/xen-block.c           |   4 +-
> > >   hw/block/virtio-blk.c                    |  15 +--
> > >   hw/ide/ahci.c                            |   6 +-
> > >   hw/ide/atapi.c                           |   9 +-
> > >   hw/ide/core.c                            |   9 +-
> > >   hw/ide/macio.c                           |  15 ++-
> > >   hw/nvme/ctrl.c                           |  43 ++++---
> > >   hw/nvme/dif.c                            |   8 +-
> > >   hw/scsi/scsi-disk.c                      |  28 +++--
> > >   qemu-io-cmds.c                           |  14 +--
> > >   system/dma-helpers.c                     |   4 +-
> > >   tests/unit/test-block-accounting.c       |   2 +-
> > >   tests/qemu-iotests/172.out               |  38 +++++++
> > >   tests/qemu-iotests/tests/delay-alert     | 136 ++++++++++++++++++++=
+++
> > >   tests/qemu-iotests/tests/delay-alert.out |  46 ++++++++
> > >   24 files changed, 472 insertions(+), 81 deletions(-)
> > >   create mode 100755 tests/qemu-iotests/tests/delay-alert
> > >   create mode 100644 tests/qemu-iotests/tests/delay-alert.out
> > >=20
> > > --=20
> > > 2.55.0
> > >=20
>=20

--WGBazzBCdAK7vkRJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqxlnYACgkQnKSrs4Gr
c8jQ1AgAgXUY/H8VArflaLSfAv29oFm9u0jUcv1UuSloSpUlkhPus8M9fY6BP4T6
NikZCIRSZNOQghdR7pU4CWyFPn6RI/+3Ap3WwUNMPZba6EsjvjPgSDX2I/H/uUwV
gje/AzpoodG1I5kjOnxVAL9si73J6zmPG04YJjaIe5n8dF3Nv3BkM+n9uqNIm8KS
IWSPLGWT7nTr9yxETAEFACOjEaUKXfnX4qk+wuM4MJNiiQR2U16XAC8mQr2N9qSO
c5XC47xMK0vLEBiu8l1vXusJ5iWs6iTP/Ajf0TfJPuCS4Qvqv50+7YMJ7cHpzw4a
UpIsdkvO+My2Dcq7c6v3dEw4qtO4+Q==
=xOW4
-----END PGP SIGNATURE-----

--WGBazzBCdAK7vkRJ--


