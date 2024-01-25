Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70D6C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSzjJ-0004fI-G9; Thu, 25 Jan 2024 08:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSzjH-0004em-Nq
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSzjF-0006Xm-Ks
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706189112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ecWuUtBAsglqQyy+lPNys4U0SKBcoVkhmIGDDsRDZlo=;
 b=LzS+JgoWxXZF2lUtUTFfnfBiVz/95NxjGTQJt9Et9B49OraZXLh7ym1iNMrtVfrCS+M6hy
 vKjkv1g9+CnwQMxVv1ogsKTGh9jrIQq67UX6hg+mEMnKg2n6tfm8Xsk6lUkXOihjE0SWmi
 +83ui+lRMuQo50vM7NmVCGVOi7hOgvs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-2QVsqgGDP9mvqNYd-iJKxA-1; Thu, 25 Jan 2024 08:25:10 -0500
X-MC-Unique: 2QVsqgGDP9mvqNYd-iJKxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C2FD84AC64;
 Thu, 25 Jan 2024 13:25:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A63D01C060B1;
 Thu, 25 Jan 2024 13:25:09 +0000 (UTC)
Date: Thu, 25 Jan 2024 08:25:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <20240125132507.GA640116@fedora>
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <dcaea54b-f3de-4ba6-8ae6-313778689f74@redhat.com>
 <20240124215314.GC609846@fedora>
 <dce73220-50a8-4339-a430-dcf13f9170ba@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eLr+K23twWoP1RAD"
Content-Disposition: inline
In-Reply-To: <dce73220-50a8-4339-a430-dcf13f9170ba@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--eLr+K23twWoP1RAD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:06:51AM +0100, Hanna Czenczek wrote:
> On 24.01.24 22:53, Stefan Hajnoczi wrote:
> > On Wed, Jan 24, 2024 at 01:12:47PM +0100, Hanna Czenczek wrote:
> > > On 23.01.24 18:10, Kevin Wolf wrote:
> > > > Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
> > > > > On 21.12.23 22:23, Kevin Wolf wrote:
> > > > > > From: Stefan Hajnoczi<stefanha@redhat.com>
> > > > > >=20
> > > > > > Stop depending on the AioContext lock and instead access
> > > > > > SCSIDevice->requests from only one thread at a time:
> > > > > > - When the VM is running only the BlockBackend's AioContext may=
 access
> > > > > >      the requests list.
> > > > > > - When the VM is stopped only the main loop may access the requ=
ests
> > > > > >      list.
> > > > > >=20
> > > > > > These constraints protect the requests list without the need fo=
r locking
> > > > > > in the I/O code path.
> > > > > >=20
> > > > > > Note that multiple IOThreads are not supported yet because the =
code
> > > > > > assumes all SCSIRequests are executed from a single AioContext.=
 Leave
> > > > > > that as future work.
> > > > > >=20
> > > > > > Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> > > > > > Reviewed-by: Eric Blake<eblake@redhat.com>
> > > > > > Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
> > > > > > Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> > > > > > ---
> > > > > >     include/hw/scsi/scsi.h |   7 +-
> > > > > >     hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++--=
-----------
> > > > > >     2 files changed, 131 insertions(+), 57 deletions(-)
> > > > > My reproducer forhttps://issues.redhat.com/browse/RHEL-3934  now =
breaks more
> > > > > often because of this commit than because of the original bug, i.=
e. when
> > > > > repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-h=
d device,
> > > > > this tends to happen when unplugging the scsi-hd:
> > > > >=20
> > > > > {"execute":"device_del","arguments":{"id":"stg0"}}
> > > > > {"return": {}}
> > > > > qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_co=
ntext:
> > > > > Assertion `ctx =3D=3D blk->ctx' failed.
> > > [...]
> > >=20
> > > > I don't know anything about the problem either, but since you alrea=
dy
> > > > speculated about the cause, let me speculate about the solution:
> > > > Can we hold the graph writer lock for the tran_commit() call in
> > > > bdrv_try_change_aio_context()? And of course take the reader lock f=
or
> > > > blk_get_aio_context(), but that should be completely unproblematic.
> > > I tried this, and it=E2=80=99s not easy taking the lock just for tran=
_commit(),
> > > because some callers of bdrv_try_change_aio_context() already hold th=
e write
> > > lock (specifically bdrv_attach_child_common(),
> > > bdrv_attach_child_common_abort(), and bdrv_root_unref_child()[1]), and
> > > qmp_x_blockdev_set_iothread() holds the read lock.=C2=A0 Other caller=
s don=E2=80=99t hold
> > > any lock[2].
> > >=20
> > > So I=E2=80=99m not sure whether we should mark all of bdrv_try_change=
_aio_context()
> > > as GRAPH_WRLOCK and then make all callers take the lock, or really on=
ly take
> > > it for tran_commit(), and have callers release the lock around
> > > bdrv_try_change_aio_context(). Former sounds better to na=C3=AFve me.
> > >=20
> > > (In any case, FWIW, having blk_set_aio_context() take the write lock,=
 and
> > > scsi_device_for_each_req_async_bh() take the read lock[3], does fix t=
he
> > > assertion failure.)
> > I wonder if a simpler solution is blk_inc_in_flight() in
> > scsi_device_for_each_req_async() and blk_dec_in_flight() in
> > scsi_device_for_each_req_async_bh() so that drain
> > waits for the BH.
> >=20
> > There is a drain around the AioContext change, so as long as
> > scsi_device_for_each_req_async() was called before blk_set_aio_context()
> > and not _during_ aio_poll(), we would prevent inconsistent BB vs BDS
> > aio_contexts.
>=20
> Actually, Kevin has suggested on IRC that we drop the whole drain. :)
>=20
> Dropping the write lock in our outside of bdrv_try_change_aio_context() f=
or
> callers that have already taken it seems unsafe, so the only option would=
 be
> to make the whole function write-lock-able.=C2=A0 The drained section can=
 cause
> problems with that if it ends up wanting to reorganize the graph, so AFAIU
> drain should never be done while under a write lock.=C2=A0 This is alread=
y a
> problem now because there are three callers that do call
> bdrv_try_change_aio_context() while under a write lock, so it seems like =
we
> shouldn=E2=80=99t keep the drain as-is.
>=20
> So, Kevin suggested just dropping that drain, because I/O requests are no
> longer supposed to care about a BDS=E2=80=99s native AioContext anymore a=
nyway, so
> it seems like the need for the drain has gone away with multiqueue.=C2=A0=
 Then we
> could make the whole function GRAPH_WRLOCK.

Okay.

Stefan

--eLr+K23twWoP1RAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWyYTMACgkQnKSrs4Gr
c8gNSAgAllacCDalF3F0JL+tNf9ZwodmuoVxHG9Xyyd4jtBs5vfdl/hpwWxMOCBU
05/4SU+SK6KvjwE0W3uljMHp3KP1ylVKBdmhksFLgEPJMR1y8eTEpQf5cOtoPpZb
HW64uX50KZaPV+5CNj8e+hQ6IS/tQ1k8/3qTfqPI4gYFkbMwAmw1bJZhdvXGhQbg
a+RayNJkoz/pCLz9hW8J7TK4yWAiyzXZ6b4i1W3/roX2BwEQsQSApoMKQ9yc0hmt
qV/TM/XlgdOq/q1BoLGUUbID+X3ClyzzEwA6BEw8zEXh+SuGbK2xtGPM1qh9DnQU
DaKhlPqlen9sIzO3Rn3OQRJ7Lc6oVA==
=cfTW
-----END PGP SIGNATURE-----

--eLr+K23twWoP1RAD--


