Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B569CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKeSm-0005sX-4x; Wed, 06 May 2026 11:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKeSj-0005rO-TX
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKeSP-0002sz-LF
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778082325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYrqJ5jFCYdNfvR8DEcmOY5jDQP/5hW1uZkiAaUlf9U=;
 b=QEoNweo1roVgZhRl56+ru7W2wU2+l0IshaMM37mvSharH7Hl58Rq6x8PbW3FIhKGFbNLII
 1mfvX8HLCFDLkxQmLYX/ECb70498j6Z515rAT/7Oj5v+S2NwYZCGzSk05Uibjv538mGysu
 drXU1Vu8aewpbt4ZU1g4cvRK6hqddvM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-OzTgXlEhNjqezad2lODPbA-1; Wed,
 06 May 2026 11:40:15 -0400
X-MC-Unique: OzTgXlEhNjqezad2lODPbA-1
X-Mimecast-MFC-AGG-ID: OzTgXlEhNjqezad2lODPbA_1778082014
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F5ED19560B2; Wed,  6 May 2026 15:40:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43CF4195394A; Wed,  6 May 2026 15:40:13 +0000 (UTC)
Date: Wed, 6 May 2026 11:40:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: mr-083 <matthieu@minio.io>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, its@irrelevant.dk, kbusch@kernel.org,
 berrange@redhat.com, mr-083 <matthieu@min.io>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] block: add blockdev-attach QMP command
Message-ID: <20260506154012.GB94695@fedora>
References: <20260415173905.71224-1-matthieu@min.io>
 <20260423162927.GA529033@fedora> <877bphf4qg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hCVMPgSnW6xogKK3"
Content-Disposition: inline
In-Reply-To: <877bphf4qg.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--hCVMPgSnW6xogKK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 08:10:15AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Wed, Apr 15, 2026 at 07:39:05PM +0200, mr-083 wrote:
> >> Add a blockdev-attach QMP command that attaches a block driver state
> >> tree to a device's block backend.  Unlike blockdev-insert-medium, this
> >> works for non-removable devices such as NVMe namespaces.
> >>=20
> >> After drive_del removes a device's backing store, the BlockBackend
> >> remains attached to the guest device but has no BlockDriverState.
> >> blockdev-attach reconnects a block node (previously created with
> >> blockdev-add) to the device's BlockBackend via blk_insert_bs().
> >>=20
> >> This separates the two concerns as recommended: blockdev-add creates
> >> the block node, blockdev-attach associates it with the device.
> >>=20
> >> Example usage with NVMe namespace hot-swap:
> >>   drive_del drv0
> >>   blockdev-add node-name=3Dnode0 driver=3Dqcow2 file.driver=3Dfile \
> >>                file.filename=3Ddisk.qcow2
> >>   blockdev-attach id=3Dns0 node-name=3Dnode0
> >
> > Hi Matthieu,
> > I came across a quirk here:
> >
> >   $ qemu-system-x86_64 \
> >       --blockdev file,filename=3Dmy-lun.img,node-name=3Ddrive1 \
> >       --device nvme,serial=3Dnvme0 \
> >       --device nvme-ns,id=3Dnvme-ns0,drive=3Ddrive1
> >   (qemu) drive_del drive1
> >   Error: drive drive1 is in use
>=20
> I see "Error: Node drive1 is in use".
>=20
> It's from qmp_blockdev_del():
>=20
>     bs =3D bdrv_find_node(node_name);
>     if (!bs) {
>         error_setg(errp, "Failed to find node with node-name=3D'%s'", nod=
e_name);
>         return;
>     }
>     if (bdrv_has_blk(bs)) {
>         error_setg(errp, "Node %s is in use", node_name);
>         return;
>     }
>=20
> Called from hmp_drive_del():
>=20
>     bs =3D bdrv_find_node(id);
>     if (bs) {
>         qmp_blockdev_del(id, &err);
>         goto unlock;
>     }
>=20
> > But when I change --blockdev to --drive, it succeeds. I think this
> > second scenario is the one that you have been testing.
>=20
> I *guess* you changed it to something like
>=20
>     -drive if=3Dnone,file=3Dtest.img,id=3Ddrive1

Yes.

>=20
> hmp_drive_del()'s call of bdrv_find_node() then fails, and we take a
> completely different path, which succeeds:
>=20
>     (qemu) info block
>     drive1 (#block195): test.img (raw)
>         Attached to:      nvme-ns0
>         Cache mode:       writeback
>     (qemu) drive_del drive1
>     (qemu) info block
>     nvme-ns0: [not inserted]
>         Attached to:      nvme-ns0
>=20
> This rips nvme-ns0's drive right off.  Feels *unsafe*: the frontend
> (here: nvme-ns) may reasonably assume that a non-removable medium stays
> put, use it without checking it's still there, and crash.

I/O requests fail with -ENOMEDIUM when blk->root.bs is NULL but it's
still a bit concerning that the medium can be removed without the device
emulation being aware.

>=20
> > I also tried the QMP blockdev-del command together with --blockdev, and
> > it fails:
> >
> >   $ qemu-system-x86_64 ... \
> >       -qmp unix:/tmp/qmp.sock,server=3Don,wait=3Doff
> >   $ qmp-shell /tmp/qmp.sock
> >   (QEMU) blockdev-del node-name=3Ddrive1
> >   {"error": {"class": "GenericError", "desc": "Node drive1 is in use"}}
> >
> > It seems logical that a disk image that's in use by NVMe emulation
> > cannot be removed. So now I'm wondering if there is a bug or a
> > historical reason why drive_del allows drives to the removed at runtime
> > even when media change is not supported.
> >
> > CCing Kevin Wolf and Markus Amrbruster as they may know the answer.
>=20
> I suspect this is simply a bug, and likely a regression.  Can you find
> out?

Okay. I thought maybe there is some backwards compatibility reason that
requires -drive if=3Dnone to behave like this.

It's a long-standing bug:

v3.0.0  Affected
v4.0.0  Affected
v6.0.0  Affected
v8.0.0  Affected
master  Affected

I didn't go back beyond v3.0.0 because Python 2 is required to build
really old versions of QEMU.

Stefan

>=20
> > Depending on the answer this may influence the test workflow in this
> > patch. It's unclear to me what is being tested here since this does not
> > simulate a real error that a physical NVMe drive could raise?
> >
> > I think the intention is to fail I/O so a test can simulate a period
> > where the drive is down. QEMU has the blkdebug driver which could be
> > inserted into the block graph to fail I/O requests - maybe that is
> > appropriate for your test and may not require new monitor commands (see
> > blkdebug examples in tests/)?
> >
> > Stefan
> >
> >>=20
> >> An HMP wrapper is included for convenience.
> >>=20
> >> Signed-off-by: Matthieu <matthieu@min.io>
>=20

--hCVMPgSnW6xogKK3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7YNwACgkQnKSrs4Gr
c8h5YggApjHx43BjmFLWB5wK4bo9JQL7KARyrcz8jCHd8O/HCy3x8jZ/tBK9ZC4W
yqmylCOJ+eE3M9uddTDEFCcpHtGj8PavHhMPPMwhm+kBnVqnf0UsDvueOxuYKHhJ
B/25lBxdtctUNiZH1RvLWwM5BWn04Po7ntr5Wp5LyhnR1/8YbPoUYKk43oZQhtAm
SeP/nUSNvY4ds1TJeQZHwWDDc0V0GG3Pe05jrQXahJwQjC3BcW07CBnKkNfd0YnD
L4tvYO9vhM+gp1wGfJcfCKuklvhH4DEFgjH3pTAEn1kcY9xjyygZzmUjC33wv/hz
zkqLsZz6e5Gr4y+ODEfIG8A38jr09Q==
=HmAm
-----END PGP SIGNATURE-----

--hCVMPgSnW6xogKK3--


