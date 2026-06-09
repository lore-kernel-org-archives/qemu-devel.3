Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD08CD98C7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWytx-0008GM-9C; Tue, 09 Jun 2026 12:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWytH-0007rO-2E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWytF-0002OH-5d
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781020880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HbEhzR3w+VT/yrCc91Dhls7UOhos+JUAD6zG6kqCOHI=;
 b=IsKZhPSzBwg/OFzdTMgC+dtf6UfAhb3g7uEz8ehUrP4++oNyD+X7TNbYoHLCCqSfg/sX3R
 yRMVrs06OebrsIjxaUHoQaJCOg7ZVZICdHs4mVjjwtv6MLbJiIOlebYMtE4c2BiblpqvTK
 8cURDH6PzcWzdswxmnPVCXdwFlcfAGs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-2YweMuPLNcOsqCMUuwQ2sw-1; Tue,
 09 Jun 2026 12:01:16 -0400
X-MC-Unique: 2YweMuPLNcOsqCMUuwQ2sw-1
X-Mimecast-MFC-AGG-ID: 2YweMuPLNcOsqCMUuwQ2sw_1781020874
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580D518501EC; Tue,  9 Jun 2026 16:01:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.141])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AEB23008B3E; Tue,  9 Jun 2026 16:01:13 +0000 (UTC)
Date: Tue, 9 Jun 2026 12:01:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v11 3/5] virtio-blk: do not merge writes across a zone
 boundary
Message-ID: <20260609160112.GD57581@fedora>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
 <20260601214405.252818-4-faithilikerun@gmail.com>
 <20260603204150.GD78072@fedora> <aiauw3nKDRHXJESV@ryzen>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h2F5mzGpUKY/8kpT"
Content-Disposition: inline
In-Reply-To: <aiauw3nKDRHXJESV@ryzen>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--h2F5mzGpUKY/8kpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 02:00:03PM +0200, Niklas Cassel wrote:
> Hello Stefan,
>=20
> On Wed, Jun 03, 2026 at 04:41:50PM -0400, Stefan Hajnoczi wrote:
> > On Mon, Jun 01, 2026 at 11:44:03PM +0200, Sam Li wrote:
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 9cb9f1fb2b..285db19ac7 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -303,17 +306,34 @@ static void virtio_blk_submit_multireq(VirtIOBl=
ock *s, MultiReqBuffer *mrb)
> > >      for (i =3D 0; i < mrb->num_reqs; i++) {
> > >          VirtIOBlockReq *req =3D mrb->reqs[i];
> > >          if (num_reqs > 0) {
> > > +            zone_cross =3D false;
> > > +
> > > +            /*
> > > +             * On zoned backends, a single backend write must not sp=
an a zone
> >=20
> > This code handles both reads and writes but the comment only mentions
> > writes. I think reads are allowed to span zones, so should there be a
> > check that mrb->is_write?
>=20
> From the Virtual I/O Device (VIRTIO) Version 1.4 specification:
>=20
> "If a VIRTIO_BLK_T_ZONE_APPEND request, a VIRTIO_BLK_T_IN request or a
> VIRTIO_BLK_T_OUT request issued to a SWR zone has the range that has
> sectors in more than one zone, then the request SHALL be completed with
> VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field status."
>=20
>=20
> Thus, while this is allowed to read past the zone boundary in many zoned
> specifications, e.g. in both ZAC and ZBC, when the "Read Across Zone
> Boundaries bit" is set, is seems like it is never allowed to do so in
> VIRTIO.

Hi Niklas,
Thanks for pointing this out. So no change is needed here.

I noticed that NVMe has a Read Across Zone Boundaries bit to indicate
whether or not this is allowed. virtio-blk could add a feature bit to
offer the same functionality in the future. This would come in handy if
existing applications depend on reading across zones.

Stefan

--h2F5mzGpUKY/8kpT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmooOMgACgkQnKSrs4Gr
c8h7ewgAjT3X93XPV778PidRgHc2BXDS1HyyWi2ggsibIyQm4po+uTdi8uiJcibF
sJPrlPuI8kQal+q2BB5qZQm2BvKmBU/oS5+xTJ8pBqZpZeg4p9aAL9NdlyqVQpJS
hbZvxP6TcUvkF5Hy6wT3DWo3gHJebc737qH6m6bosnrizKEixo6w5+XPCa5FsQE5
OcPstVbruoF66c+D9ClAjrOuHT0VSJemYrpku2JBANGObkm8UwVgrGq31WefbtMp
yNDTtiZFQeX8FmB4F3LaRnV6VYbB/kI4B3kybePsOj+XPNW3QJXHoCcf/rTQ6+21
o+XiWE5ehpgP+/5rdyeSudpPLu8ebw==
=5Ri2
-----END PGP SIGNATURE-----

--h2F5mzGpUKY/8kpT--


