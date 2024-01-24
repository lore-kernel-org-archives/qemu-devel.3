Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B877C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSlBU-0007Xt-3f; Wed, 24 Jan 2024 16:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSlBT-0007Xd-46
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:53:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSlBR-0001Xa-6y
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706133199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DWa/IoUkwLkto2ITjDrFXmaJstOZTnRKnZeHnNxF2yE=;
 b=HkklSaTuZTTdcSZMcPZXgmaafSH5d2eOVW5spn8BWgzmyxwhFl94Qs3su+BkYUbfxY4H2P
 NtAQAzaO6CLJgF62I8QAqkn82Ds5Oe7OF95ms02uK1ocwN726NFYfDu1z1xQ5VFNuLMrb3
 Ij9VHixG+Y2UaVxr/+xlFlWjlo1Bayk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-nBt5zck7PeiYIMOa8aL2SA-1; Wed,
 24 Jan 2024 16:53:17 -0500
X-MC-Unique: nBt5zck7PeiYIMOa8aL2SA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C65DF1C03387;
 Wed, 24 Jan 2024 21:53:16 +0000 (UTC)
Received: from localhost (unknown [10.39.192.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45C19492BFA;
 Wed, 24 Jan 2024 21:53:15 +0000 (UTC)
Date: Wed, 24 Jan 2024 16:53:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <20240124215314.GC609846@fedora>
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <dcaea54b-f3de-4ba6-8ae6-313778689f74@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dv4nhE5Hic2Aselu"
Content-Disposition: inline
In-Reply-To: <dcaea54b-f3de-4ba6-8ae6-313778689f74@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--dv4nhE5Hic2Aselu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 01:12:47PM +0100, Hanna Czenczek wrote:
> On 23.01.24 18:10, Kevin Wolf wrote:
> > Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
> > > On 21.12.23 22:23, Kevin Wolf wrote:
> > > > From: Stefan Hajnoczi<stefanha@redhat.com>
> > > >=20
> > > > Stop depending on the AioContext lock and instead access
> > > > SCSIDevice->requests from only one thread at a time:
> > > > - When the VM is running only the BlockBackend's AioContext may acc=
ess
> > > >     the requests list.
> > > > - When the VM is stopped only the main loop may access the requests
> > > >     list.
> > > >=20
> > > > These constraints protect the requests list without the need for lo=
cking
> > > > in the I/O code path.
> > > >=20
> > > > Note that multiple IOThreads are not supported yet because the code
> > > > assumes all SCSIRequests are executed from a single AioContext. Lea=
ve
> > > > that as future work.
> > > >=20
> > > > Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> > > > Reviewed-by: Eric Blake<eblake@redhat.com>
> > > > Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
> > > > Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> > > > ---
> > > >    include/hw/scsi/scsi.h |   7 +-
> > > >    hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------=
------
> > > >    2 files changed, 131 insertions(+), 57 deletions(-)
> > > My reproducer forhttps://issues.redhat.com/browse/RHEL-3934  now brea=
ks more
> > > often because of this commit than because of the original bug, i.e. w=
hen
> > > repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd de=
vice,
> > > this tends to happen when unplugging the scsi-hd:
> > >=20
> > > {"execute":"device_del","arguments":{"id":"stg0"}}
> > > {"return": {}}
> > > qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_contex=
t:
> > > Assertion `ctx =3D=3D blk->ctx' failed.
>=20
> [...]
>=20
> > I don't know anything about the problem either, but since you already
> > speculated about the cause, let me speculate about the solution:
> > Can we hold the graph writer lock for the tran_commit() call in
> > bdrv_try_change_aio_context()? And of course take the reader lock for
> > blk_get_aio_context(), but that should be completely unproblematic.
>=20
> I tried this, and it=E2=80=99s not easy taking the lock just for tran_com=
mit(),
> because some callers of bdrv_try_change_aio_context() already hold the wr=
ite
> lock (specifically bdrv_attach_child_common(),
> bdrv_attach_child_common_abort(), and bdrv_root_unref_child()[1]), and
> qmp_x_blockdev_set_iothread() holds the read lock.=C2=A0 Other callers do=
n=E2=80=99t hold
> any lock[2].
>=20
> So I=E2=80=99m not sure whether we should mark all of bdrv_try_change_aio=
_context()
> as GRAPH_WRLOCK and then make all callers take the lock, or really only t=
ake
> it for tran_commit(), and have callers release the lock around
> bdrv_try_change_aio_context(). Former sounds better to na=C3=AFve me.
>=20
> (In any case, FWIW, having blk_set_aio_context() take the write lock, and
> scsi_device_for_each_req_async_bh() take the read lock[3], does fix the
> assertion failure.)

I wonder if a simpler solution is blk_inc_in_flight() in
scsi_device_for_each_req_async() and blk_dec_in_flight() in
scsi_device_for_each_req_async_bh() so that drain
waits for the BH.

There is a drain around the AioContext change, so as long as
scsi_device_for_each_req_async() was called before blk_set_aio_context()
and not _during_ aio_poll(), we would prevent inconsistent BB vs BDS
aio_contexts.

Stefan

>=20
> Hanna
>=20
> [1] bdrv_root_unref_child() is not marked as GRAPH_WRLOCK, but it=E2=80=
=99s callers
> generally seem to ensure that the lock is taken when calling it.
>=20
> [2] blk_set_aio_context() (evidently), blk_exp_add(),
> external_snapshot_abort(), {blockdev,drive}_backup_action(),
> qmp_{blockdev,drive}_mirror()
>=20
> [3] I=E2=80=99ve made the _bh a coroutine (for bdrv_graph_co_rdlock()) an=
d replaced
> the aio_bh_schedule_oneshot() by aio_co_enter() =E2=80=93 hope that=E2=80=
=99s right.

--dv4nhE5Hic2Aselu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWxhsoACgkQnKSrs4Gr
c8idnAf/UjwlhMYTyjcqRv9vhKc/UBWfli+s+yRHof325Nxz9mRCiPQjr8yKv+Uk
r8WdsJNpYOTMNx00yC0Z7oPxfeTQWJHuiuzH2GLd5A3NpOFIgJsRF7N16fFedrEW
1+k70Y+6249FD0uIbuO/Ia8ImE1Ty7wq+idDPyiuRcBhj62pB3Qz7o9KEkql7DuG
if2KjctGLQGimfo335Dshj7fZWuAgELu5YrJLiYP2bwG/SxtESClc+PwVmPuGBXv
RnxezmqVjo6Nvmu8D0MlhMuIK6SvUPAp8YHKKvclGTLyx/AAErsWYhkbS9uKZxnH
PeQr/MSxY88wGzp0Hd5gzhEbYTCJAQ==
=mfUY
-----END PGP SIGNATURE-----

--dv4nhE5Hic2Aselu--


