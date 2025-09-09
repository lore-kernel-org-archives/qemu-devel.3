Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F4BCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0F7-0000h9-MX; Tue, 09 Sep 2025 11:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uw0Ev-0000fA-D2
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uw0Eq-00047C-Ql
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757431589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cmbOJUV8XT5+HBw7vOgxEIAr4kdFuA/8o4ZBcBUiT8Y=;
 b=LadEQ/p9N9hlpaabO7mgAI17AXcG7hQiUqVV0BPychLI5QV8oUwe+zUeyEZHOOGFDT/p26
 rZdFmVp7L/jNbasXpOGo1PRGdDkEs6cIrREpj7ba73uYvY4/yfCwgi85FKkfSmhHCaVnLO
 I0yE1CIZEJpPCTtfJASnu49HCVirPdY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-L8dPjtfxP7uF94aboyFTBg-1; Tue,
 09 Sep 2025 11:26:25 -0400
X-MC-Unique: L8dPjtfxP7uF94aboyFTBg-1
X-Mimecast-MFC-AGG-ID: L8dPjtfxP7uF94aboyFTBg_1757431584
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BCDF18002C2; Tue,  9 Sep 2025 15:26:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82292300018D; Tue,  9 Sep 2025 15:26:23 +0000 (UTC)
Date: Tue, 9 Sep 2025 11:26:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
Message-ID: <20250909152621.GD218449@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-3-hibriansong@gmail.com>
 <20250903115108.GD106431@fedora>
 <d5550d6c-d3cb-440a-b806-80dd11887dd8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gtUz9tpMqT/67K7E"
Content-Disposition: inline
In-Reply-To: <d5550d6c-d3cb-440a-b806-80dd11887dd8@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--gtUz9tpMqT/67K7E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 03:09:57PM -0400, Brian Song wrote:
>=20
>=20
> On 9/3/25 7:51 AM, Stefan Hajnoczi wrote:
> > On Fri, Aug 29, 2025 at 10:50:23PM -0400, Brian Song wrote:
> > > https://docs.kernel.org/filesystems/fuse-io-uring.html
> > >=20
> > > As described in the kernel documentation, after FUSE-over-io_uring
> > > initialization and handshake, FUSE interacts with the kernel using
> > > SQE/CQE to send requests and receive responses. This corresponds to
> > > the "Sending requests with CQEs" section in the docs.
> > >=20
> > > This patch implements three key parts: registering the CQE handler
> > > (fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
> > > process_request), and sending response results (fuse_uring_send_
> > > response). It also merges the traditional /dev/fuse request handling
> > > with the FUSE-over-io_uring handling functions.
> > >=20
> > > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Brian Song <hibriansong@gmail.com>
> > > ---
> > >   block/export/fuse.c | 457 ++++++++++++++++++++++++++++++-----------=
---
> > >   1 file changed, 309 insertions(+), 148 deletions(-)
> > >=20
> > > diff --git a/block/export/fuse.c b/block/export/fuse.c
> > > index 19bf9e5f74..07f74fc8ec 100644
> > > --- a/block/export/fuse.c
> > > +++ b/block/export/fuse.c
> > > @@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops=
 =3D {
> > >   };
> > >   #ifdef CONFIG_LINUX_IO_URING
> > > +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *=
ent);
> > > +
> > > +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaqu=
e)
> >=20
> > This function appears to handle exactly one cqe. A singular function
> > name would be clearer than a plural: co_fuse_uring_queue_handle_cqe().
> >=20
> > > +{
> > > +    FuseRingEnt *ent =3D opaque;
> > > +    FuseExport *exp =3D ent->rq->q->exp;
> > > +
> > > +    /* Going to process requests */
> > > +    fuse_inc_in_flight(exp);
> >=20
> > What is the rationale for taking a reference here? Normally something
> > already holds a reference (e.g. the request itself) and it will be
> > dropped somewhere inside a function we're about to call, but we still
> > need to access exp afterwards, so we temporarily take a reference.
> > Please document the specifics in a comment.
> >=20
> > I think blk_exp_ref()/blk_exp_unref() are appropriate instead of
> > fuse_inc_in_flight()/fuse_dec_in_flight() since we only need to hold
> > onto the export and don't care about drain behavior.
> >=20
>=20
> Stefan:
>=20
> When handling FUSE requests, we don=E2=80=99t want the FuseExport to be a=
ccidentally
> deleted. Therefore, we use fuse_inc_in_flight in the CQE handler to
> increment the in_flight counter, and when a request is completed, we call
> fuse_dec_in_flight to decrement it. Once the last request has been
> processed, fuse_dec_in_flight brings the in_flight counter down to 0,
> indicating that the export can safely be deleted. The usage of in_flight
> follows the same logic as in traditional FUSE request handling.
>=20
> Since submitted SQEs for FUSE cannot be canceled, once we register or com=
mit
> them we must wait for the kernel to return a CQE. Otherwise, the kernel m=
ay
> deliver a CQE and invoke its handler after the export has already been
> deleted. For this reason, we directly call blk_exp_ref and blk_exp_unref
> when submitting an SQE and when receiving its CQE, to explicitly control =
the
> export reference and prevent accidental deletion.
>=20
> The doc/comment for co_fuse_uring_queue_handle_cqe:
>=20
> Protect FuseExport from premature deletion while handling FUSE requests. =
CQE
> handlers inc/dec the in_flight counter; when it reaches 0, the export can=
 be
> freed. This follows the same logic as traditional FUSE.
>=20
> Since FUSE SQEs cannot be canceled, a CQE may arrive after commit even if
> the export is deleted. To prevent this, we ref/unref the export explicitly
> at SQE submission and CQE completion.

I looked at your "final" branch on GitHub and the refcount changes there
match what I was thinking of.

In case it helps for writing comments, I'll try to describe my mental
model of the refcounts:

- fuse_inc_in_flight()/fuse_dec_in_flight() must wrap the lifecycle of
  FUSE requests that the server is processing. This ensures that the
  block layer's drain operation waits for requests to complete and that
  the export cannot be deleted while the requests are still in progress.

- blk_exp_ref()/blk_exp_unref() prevents the export from being deleted
  while something that still depends on it remains outstanding.

How this maps to FUSE-over-io_uring:

- When an SQE is submitted blk_exp_ref() must be called. After the CQE
  has been processed, blk_exp_unref() must be called. This way the
  export cannot be deleted before all CQEs have been handled.

- The coroutine that processes a FUSE request must call
  fuse_inc_in_flight() before processing begins and fuse_dec_in_flight()
  after processing ends.

Thanks,
Stefan

--gtUz9tpMqT/67K7E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjARx0ACgkQnKSrs4Gr
c8hXIQf/XmHtcYtAqaQhZLk+YgrGJ7YBKpFhsw12Xesr8/s2HGd1nPdYOEhCfLsY
drJQAql4Gv8KwgSa/Qa3uUqhR2aiXoAGFk9Q+4fJA2y5qTC26J4dNf/b3GaFR8mX
QeNzGeQXheF0wSsxQJizxYlypsl+AV99tco7vckfWT5W2otNKW2K22HlxE5DwDhB
3Agz56W9e7+e5zuRQmFPjxaArh/DcfNHPnhA3FCHCxQ12xsAYiUWFlYn13Nn9kLR
3c11Ze/NkKLc8rvEU9ux1oI4FxpOnkw3rB5Can5pAmkdDiUJEUJgWFzJM9ANS0Sj
O+zh1yeOMmz1f2BVVUWCfFewQT5q8g==
=E+ZS
-----END PGP SIGNATURE-----

--gtUz9tpMqT/67K7E--


