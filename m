Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED70C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMRT-0000ol-5e; Tue, 04 Feb 2025 12:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfMRR-0000kg-F2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfMRO-0007x1-QD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738689025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eo56kqI9RFZN4mo2tuDJUvj1RvEQmn9uqOWBYZe8RLQ=;
 b=Rf1fGEUbWJodjrXPW7FnhKlX8H+rj2PyzJtfFckV+SKl+fZZCZ7FaWgu89y2cXcUND27E1
 1Ka7hIJNfPTkvKN2ze6X+Pl+Pa/NH0bPxmXLe4mZb+5o0AulEhlJ0SY82afuKSCEVhBPqV
 1VZlsWi0/gzR1rUihJnRLrEL4adSnts=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-I0nYnLpxO-2h8wWxay5tnQ-1; Tue,
 04 Feb 2025 12:10:23 -0500
X-MC-Unique: I0nYnLpxO-2h8wWxay5tnQ-1
X-Mimecast-MFC-AGG-ID: I0nYnLpxO-2h8wWxay5tnQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5870918009D5; Tue,  4 Feb 2025 17:10:22 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.100])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB0D419560AD; Tue,  4 Feb 2025 17:10:18 +0000 (UTC)
Date: Tue, 4 Feb 2025 18:10:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/15] nbd/server: Support inactive nodes
Message-ID: <Z6JJ-LCeD4TK7EZu@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-3-kwolf@redhat.com>
 <20250203191925.GN268514@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AKZdfmTrW88JvEAI"
Content-Disposition: inline
In-Reply-To: <20250203191925.GN268514@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--AKZdfmTrW88JvEAI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.02.2025 um 20:19 hat Stefan Hajnoczi geschrieben:
> On Fri, Jan 31, 2025 at 10:50:48AM +0100, Kevin Wolf wrote:
> > In order to support running an NBD export on inactive nodes, we must
> > make sure to return errors for any operations that aren't allowed on
> > inactive nodes. Reads are the only operation we know we need for
> > inactive images, so to err on the side of caution, return errors for
> > everything else, even if some operations could possibly be okay.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  nbd/server.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >=20
> > diff --git a/nbd/server.c b/nbd/server.c
> > index f64e47270c..2076fb2666 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -2026,6 +2026,7 @@ static void nbd_export_delete(BlockExport *blk_ex=
p)
> >  const BlockExportDriver blk_exp_nbd =3D {
> >      .type               =3D BLOCK_EXPORT_TYPE_NBD,
> >      .instance_size      =3D sizeof(NBDExport),
> > +    .supports_inactive  =3D true,
> >      .create             =3D nbd_export_create,
> >      .delete             =3D nbd_export_delete,
> >      .request_shutdown   =3D nbd_export_request_shutdown,
> > @@ -2920,6 +2921,22 @@ static coroutine_fn int nbd_handle_request(NBDCl=
ient *client,
> >      NBDExport *exp =3D client->exp;
> >      char *msg;
> >      size_t i;
> > +    bool inactive;
> > +
> > +    WITH_GRAPH_RDLOCK_GUARD() {
> > +        inactive =3D bdrv_is_inactive(blk_bs(exp->common.blk));
> > +        if (inactive) {
> > +            switch (request->type) {
> > +            case NBD_CMD_READ:
> > +                /* These commands are allowed on inactive nodes */
> > +                break;
> > +            default:
> > +                /* Return an error for the rest */
> > +                return nbd_send_generic_reply(client, request, -EPERM,
> > +                                              "export is inactive", er=
rp);
> > +            }
> > +        }
> > +    }
>=20
> Hmm...end of lock guard. What prevents the race where inactive changes
> before the request is performed?

That's a good question. Probably nothing. Extending the lock guard to
cover the rest of the function wouldn't prevent it either because
inactivating doesn't change the structure of the graph and therefore
also doesn't take the writer lock.

We should probably drain nodes around setting BDRV_O_INACTIVE. Generally
the expectation has always been that the block node is idle when we try
to inactivate an image. With exports, this isn't automatically true any
more, but draining gives us the guarantee we need.

This seems to also fix a qed crash I noticed with the new test cases
where the timer still wants to write to the image after we set the
inactive flag. Draining cancels the timer.

Kevin

diff --git a/block.c b/block.c
index 7eeb8d076e..1601b25f66 100644
--- a/block.c
+++ b/block.c
@@ -7032,7 +7032,9 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool to=
p_level)
         return -EPERM;
     }

+    bdrv_drained_begin(bs);
     bs->open_flags |=3D BDRV_O_INACTIVE;
+    bdrv_drained_end(bs);

     /*
      * Update permissions, they may differ for inactive nodes.

--AKZdfmTrW88JvEAI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmeiSfgACgkQfwmycsiP
L9Z9KRAAr4FhlVQRpnefhOZliYTMpUlNtTRN+uPMm3CllYfMTVPmENfPWRZxuKlh
nwMUk1vC23lMWkwDHVjC/LXwhEPlKoEzEUTrg1RGCrPstFFEqY2n2cFcpvZZh0FB
z+9BpHbKfMj6gqHuGrJ+Zz95wWFxS7zLVjPcHC/yAlEebNNDOXJQPF/h5tcU2DHg
XB7tAVhtYT3iLuopjwYblZYCjF6M1dnFZMyjiTVl5nqriiDiiL/Use0PR9xY7UR6
+qY40aEMjFmF0PX3fZtJI0P5FLlDLuRBXD8BYgVJBkNeCXQv60Eu8MCHIrU2Z5GL
ZbFDZK4N29bQ3Qd3hQ7MWL83U9wzTaTodHSeURcYPm/cC6dG7Jhu49tmfqk7MjlT
MpOD9WHa2eY9tFsrNx9AHkeZSBWXhp7kYzTCoV7s5s7dLXaq9y6BO9xhQ/X4EvEB
YlTgkCNEOSmRS9W1uH/lx0RfEncsdJ2RAJwCaB4oJfgsp781iu+olNe8rCw1809A
vXZInaGUePnS94ne4LkxYMVgZElheY+BOlLG+Ims0bM1amzwpTvkBk+J+HV+H6hn
r+DPHBF1pPWcRyslJBEZ/CIg6ZrxGBBlU8mWr+pVmYFwZEeiUFAMjVBRg8O6g8Bj
OWjElH0FV/UZbZ7ljjeyz19ELZ+1fCfwgrRkaSof9QTlss+eDzM=
=3B+f
-----END PGP SIGNATURE-----

--AKZdfmTrW88JvEAI--


