Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F45C3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzy1T-0004v9-Qx; Wed, 02 Apr 2025 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzy1Q-0004uS-7H
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzy1O-0001KY-FF
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743600044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wrbYu/6m/yQgT/rLDPyd9sxal+2ETNvihbenNPduwHE=;
 b=cd+SPQvm/EezBN0mTNi1G/0RSnQM5ebV9NdHpPAB3asls6lNtw9osfv+3MxYsoATXFMZpe
 9fNLEoaDQ8MBCosyi0qj2emS9n7OVqvEFTKO0jmGJc5oFF49Vr4vgmSWs8qCtwd6jMxqJo
 lZt6qTMXVjy+OjvfHzXQdHcxfl/+BNI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-zcSQpY5APyuxlZOnJuv-CQ-1; Wed,
 02 Apr 2025 09:20:41 -0400
X-MC-Unique: zcSQpY5APyuxlZOnJuv-CQ-1
X-Mimecast-MFC-AGG-ID: zcSQpY5APyuxlZOnJuv-CQ_1743600040
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A84D1956048; Wed,  2 Apr 2025 13:20:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DBE919560AD; Wed,  2 Apr 2025 13:20:39 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:20:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <20250402132033.GA304512@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <20250327155557.GN37458@fedora>
 <hd3fxmjcwp5nvaqtv6sgxftkmlvvrobgvyd5w25jlklimjvdja@gboyi4q4ggks>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PB4aLiG9iaEv2z2s"
Content-Disposition: inline
In-Reply-To: <hd3fxmjcwp5nvaqtv6sgxftkmlvvrobgvyd5w25jlklimjvdja@gboyi4q4ggks>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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


--PB4aLiG9iaEv2z2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 03:36:40PM -0500, Eric Blake wrote:
> On Thu, Mar 27, 2025 at 11:55:57AM -0400, Stefan Hajnoczi wrote:
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
> >=20
> > This text might be outdated. virtio-blk's new iothread-vq-mapping
> > parameter provides the "array of iothreads" mentioned below and a way to
> > assign virtqueues to those IOThreads.
> >=20
>=20
> > > +++ b/qapi/block-export.json
> > > @@ -179,12 +179,18 @@
> > >  #     mount the export with allow_other, and if that fails, try again
> > >  #     without.  (since 6.1; default: auto)
> > >  #
> > > +# @iothreads: Enables multi-threading: Handle requests in each of the
> > > +#     given iothreads (instead of the block device's iothread, or the
> > > +#     export's "main" iothread).  For this, the FUSE FD is duplicate=
d so
> > > +#     there is one FD per iothread.  (since 10.1)
> >=20
> > This option isn't FUSE-specific but FUSE is the first export type to
> > support it. Please add it to BlockExportOptions instead and refuse
> > export creation when the export type only supports 1 IOThread.
> >=20
> > Eric: Are you interested in implementing support for multiple IOThreads
> > in the NBD export? I remember some time ago we talked about NBD
> > multi-conn support, although maybe that was for the client rather than
> > the server.
>=20
> The NBD server already supports clients that make requests through
> multiple TCP sockets, but right now, that server is not taking
> advantage of iothreads to spread the TCP load.
>=20
> And yes, I am in the middle of working on adding client NBD multi-conn
> support (reviving Rich Jones' preliminary patches on what it would
> take to have qemu open parallel TCP sockets to a supporting NBD
> server), which also will use a round-robin approach (but here, the
> round-robin is something we would code up in qemu, rather than the
> behavior handed to us by the FUSE kernel layer).  Pinning specific
> iothreads to a specific TCP socket may or may not make sense, but I
> definitely want to have support for handing a pool of iothreads to an
> NBD client that will be using multi-conn.

Here I'm asking Hanna to make the "iothreads" export parameter generic
for all export types (not just for FUSE). Do you think that the NBD
export will be able to use the generic parameter or would you prefer an
NBD-specific export parameter?

Stefan

--PB4aLiG9iaEv2z2s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmftOaEACgkQnKSrs4Gr
c8imzggAx3c2cHttyuLEfmFhCLEPIkGNRltURb7pUOYduk7iI8zpqh3UlpM5Axu0
xjHh5pgv+pcqxG9+hQF/1zKhZzYL17I2TUAiqtDQ/zFQk3wyYrclHnEJk+Pe56qC
pZ/dOkWamEUH97WY+pXhej3u02IVJ7ZO+g0GW5KLynAdwgPKfSrAEcmmWuF/7aaV
FGMT0ParZ+ctVkcaf5BHsJjwywnfU5oZCuUC1oA0jcgFQUqybHYBhGq5AFQRgAjS
q6XznI5i+4+HD1d0SgcmEJcQ9aT48UfEo/3mIMYsfySYKaEsMc9WTSna+1ebqU7h
zuTvYiDAxjfStYRBlKYW/LlLVAEx2A==
=tqDk
-----END PGP SIGNATURE-----

--PB4aLiG9iaEv2z2s--


