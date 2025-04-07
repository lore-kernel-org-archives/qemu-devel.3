Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D24CC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 14:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1n4A-0005MY-L9; Mon, 07 Apr 2025 10:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u1n48-0005Lj-Ss
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 10:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u1n47-0002e7-1l
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 10:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744034585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TOgPKDUAdodxd6JvGuArTiJybA8kn8tReY5B5XGHS1k=;
 b=GUfC7Vg2+sMyKJk2RR7/vkhW16CroZcZGYLexKoXDAOh4iMCcFoyIfHAnEID95bAGBLTvk
 aiFYyMZ38KlbZ+yOPRQVfInYgmJSiv89lF4BtN4mfaDWXbi6ZionFfIMGzPV8tCV+tjS0u
 sHoY1Nosco2+kYFb/+PfmNbVJYwnHBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-XpSzWCXeNpSOF_0fPBNpxQ-1; Mon,
 07 Apr 2025 10:02:52 -0400
X-MC-Unique: XpSzWCXeNpSOF_0fPBNpxQ-1
X-Mimecast-MFC-AGG-ID: XpSzWCXeNpSOF_0fPBNpxQ_1744034572
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDB03195609E; Mon,  7 Apr 2025 14:02:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68E5E1828AA8; Mon,  7 Apr 2025 14:02:50 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:02:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <20250407140249.GC473226@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <20250327155557.GN37458@fedora>
 <c3f70137-afd2-448b-8aa9-de14bef25224@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Lfw85ssTqC+z3tS6"
Content-Disposition: inline
In-Reply-To: <c3f70137-afd2-448b-8aa9-de14bef25224@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Lfw85ssTqC+z3tS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 02:49:08PM +0200, Hanna Czenczek wrote:
> On 27.03.25 16:55, Stefan Hajnoczi wrote:
> > On Tue, Mar 25, 2025 at 05:06:54PM +0100, Hanna Czenczek wrote:
> > > FUSE allows creating multiple request queues by "cloning" /dev/fuse F=
Ds
> > > (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
> > >=20
> > > We can use this to implement multi-threading.
> > >=20
> > > Note that the interface presented here differs from the multi-queue
> > > interface of virtio-blk: The latter maps virtqueues to iothreads, whi=
ch
> > > allows processing multiple virtqueues in a single iothread.  The
> > > equivalent (processing multiple FDs in a single iothread) would not m=
ake
> > > sense for FUSE because those FDs are used in a round-robin fashion by
> > > the FUSE kernel driver.  Putting two of them into a single iothread w=
ill
> > > just create a bottleneck.
> > This text might be outdated. virtio-blk's new iothread-vq-mapping
> > parameter provides the "array of iothreads" mentioned below and a way to
> > assign virtqueues to those IOThreads.
>=20
> Ah, yes.=C2=A0 The difference is still that with FUSE, there is no such
> assignment, because it wouldn=E2=80=99t make sense.=C2=A0 But I can chang=
e s/maps
> virtqueues/allows mapping virtqueues/, and s/differs from/is only a subset
> of/, if that=E2=80=99s alright.

Sure, thanks!

> > > Therefore, all we need is an array of iothreads, and we will create o=
ne
> > > "queue" (FD) per thread.
> > >=20
> > > These are the benchmark results when using four threads (compared to a
> > > single thread); note that fio still only uses a single job, but
> > > performance can still be improved because of said round-robin usage f=
or
> > > the queues.  (Not in the sync case, though, in which case I guess it
> > > just adds overhead.)
> > Interesting. FUSE-over-io_uring seems to be different from
> > FUSE_DEV_IOC_CLONE here. It doesn't do round-robin. It uses CPU affinity
> > instead, handing requests to the io_uring context associated with the
> > current CPU when possible.
>=20
> Do you think that should have implications for the QAPI interface?

It would be helpful to document the behavior so users know when
round-robin or CPU affinity are used, but the parameter itself would be
unchanged: an array of IOThreads.

>=20
> [...]
>=20
> > >   qapi/block-export.json |   8 +-
> > >   block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++-----=
---
> > >   2 files changed, 179 insertions(+), 43 deletions(-)
> > >=20
> > > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > > index c783e01a53..0bdd5992eb 100644
> > > --- a/qapi/block-export.json
> > > +++ b/qapi/block-export.json
> > > @@ -179,12 +179,18 @@
> > >   #     mount the export with allow_other, and if that fails, try aga=
in
> > >   #     without.  (since 6.1; default: auto)
> > >   #
> > > +# @iothreads: Enables multi-threading: Handle requests in each of the
> > > +#     given iothreads (instead of the block device's iothread, or the
> > > +#     export's "main" iothread).  For this, the FUSE FD is duplicate=
d so
> > > +#     there is one FD per iothread.  (since 10.1)
> > This option isn't FUSE-specific but FUSE is the first export type to
> > support it. Please add it to BlockExportOptions instead and refuse
> > export creation when the export type only supports 1 IOThread.
>=20
> Makes sense.=C2=A0 I=E2=80=99ll try to go with what Kevin suggested, i.e.=
 have @iothread
> be an alternate type.
>=20
> Hanna
>=20
> >=20
> > Eric: Are you interested in implementing support for multiple IOThreads
> > in the NBD export? I remember some time ago we talked about NBD
> > multi-conn support, although maybe that was for the client rather than
> > the server.
>=20

--Lfw85ssTqC+z3tS6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfz2wgACgkQnKSrs4Gr
c8jREQf+LKWndOm2cQIIFDNyDxoBOFdgROpHNo2POuwRNQ5ySsyMWhFViMMr4+uH
GRjOvxKlUZuRWWRZu+uvqjW0fGre2jaqFWPAeMovuzXeYqQRP5LGU/UPfKA8cyhz
KB8b1UJBoojFZChAVZx9Qi9TC82gvvjJkYBBZZmCOvgCz0Ws07+E/iyUx7hLxN2m
uHUSxGkRhxb9LGbdjMiOPCXJ9OlekJ/fBlqxL7MONSiTiRWQ4tNy/x0773P4UqCF
K7dNNcUUOu0CWhBMtO5Krb96sf0jrA0sgN1Yfu8/OiJ+v3oxMBlbLqU5oyMqD1+5
/NpEB5/odXLIW+6vIrE9LTL20uHu0A==
=M8D4
-----END PGP SIGNATURE-----

--Lfw85ssTqC+z3tS6--


