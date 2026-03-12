Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB6AFED2E1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ain-0006Ly-Qp; Thu, 12 Mar 2026 03:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0aij-0006LV-PL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0aih-0006y1-Nx
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773301474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9+Pe0Pca06GAKrXpbw8c3xGWys6Z9u+wcz813TvIrs=;
 b=Op4K2GYGt/ETDZsiP6N5PJGERFUNDzDipB91RViHxLCtaJIOwXwYpThHmNg0bBK4POCrNF
 nyLhMHjOv++21VsC8/NhwPzUwy5zgj88+A8ZXMAlFPEbWtghqCYD8DAPMbzNbuC8K+mdAj
 lYAWhCIxHfaicOaBcBS5TfB2pDQswrQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-F2-8mKk0MEeV2z-o1Ql4ew-1; Thu,
 12 Mar 2026 03:44:30 -0400
X-MC-Unique: F2-8mKk0MEeV2z-o1Ql4ew-1
X-Mimecast-MFC-AGG-ID: F2-8mKk0MEeV2z-o1Ql4ew_1773301469
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87A621800610; Thu, 12 Mar 2026 07:44:29 +0000 (UTC)
Received: from localhost (unknown [10.45.224.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46F7419540C2; Thu, 12 Mar 2026 07:44:27 +0000 (UTC)
Date: Thu, 12 Mar 2026 15:44:23 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
Message-ID: <20260312074423.GB129138@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora>
 <CAK3tnvKPvJjsNCcmuEi7OOfM5xkC_PuDEgNR9cKFpEUMioiOww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bNuazqpc9i+nntOr"
Content-Disposition: inline
In-Reply-To: <CAK3tnvKPvJjsNCcmuEi7OOfM5xkC_PuDEgNR9cKFpEUMioiOww@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


--bNuazqpc9i+nntOr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 03:05:55PM +0800, Zhang Chen wrote:
> On Thu, Mar 12, 2026 at 1:24=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, Mar 10, 2026 at 06:02:54PM +0800, Zhang Chen wrote:
> > > On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > > >
> > > > On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
> > > > > Update the usage of "iothread_get_aio_context()".
> > > > >
> > > > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > > > ---
> > > > >  blockdev.c | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/blockdev.c b/blockdev.c
> > > > > index 6e86c6262f..01ccf64b3f 100644
> > > > > --- a/blockdev.c
> > > > > +++ b/blockdev.c
> > > > > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const cha=
r *node_name, StrOrNull *iothread,
> > > > >              goto out;
> > > > >          }
> > > > >
> > > > > -        new_context =3D iothread_get_aio_context(obj);
> > > > > +        char *path =3D object_get_canonical_path(OBJECT(bs));
> > > >
> > > > CCing Kevin and Markus in case they have an opinion on this.
> > > >
> > > > BlockDriverState is not a QOM Object so using OBJECT(bs) is undefin=
ed
> > > > behavior and may crash.
> > > >
> > > > node_name is unique across block driver graph nodes and could be us=
ed.
> > > > Unfortunately it's not connected to the QOM Object hierarchy. Maybe=
 it's
> > > > best to build a holder name that is an invalid QOM path so there ca=
n be
> > > > no collisions between QOM paths and block driver graph nodes.
> > > >
> > > >   g_autofree char *holder =3D g_strdup_printf("BlockDriverState %s"=
, node_name);
> > > >
> > > > (A cleaner long-term solution would be making BlockDriverStates QOM
> > > > Objects so they have a proper path.)
> > >
> > > If no other comments, it's OK for me. This issue like I mentioned in
> > > patch 7 and 9.
> >
> > A thought about the QAPI interface:
> >
> > QAPI expresses as much information in the schema as possible, so I think
> > the right approach would be a {'union': 'IOThreadHolder',
> > 'discriminator': 'type', ...} that supports at least "qom" and
> > "block-node". That way there are proper types to encode QOM Object paths
> > vs block node-names. Let's avoid having a single string value that takes
> > on different meaning depending on the type of holder.
>=20
> In the iothread_get side:
> The same issue in the patch 8 (the node-name too), the point is
> qmp_xxxx_function input is a string.
> It's hard to track the QOM Object paths and the iothread. I will try
> to fill the gap.

I'm not sure if we are talking about the same thing, but when the QAPI
schema is modified to use an enum it would also be necessary to modify
the C API:

iothread_get_aio_context() and iothread_put_aio_context() would take a
struct IOThreadHolder instead of a const char *holder argument.

Stefan

--bNuazqpc9i+nntOr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmybtcACgkQnKSrs4Gr
c8g7+AgAoenwyWMe2mRCD7TvWm6tBltrvskzi7yNv53oAEnOQiyM9xPJoeL7nKM8
2Wgi/OPLGNC8PTNpa44XDPtVn5X5DRmdhOi9Q2mAHIG6v9CaRVXdmpU0aCKW0Tbh
tBP5iuzGlydq8RpW+kO2oeptQTH99C22GMRauDGaADXCM9FdUjYQzKk4wpQe5glp
gMlYgEauKPWzvHq57BwsYpTzsdbnKYKsT/7F/kxSw8mxVRf3xcOf2udqYOpqLnNI
+xc190kfBBCk6hmvR4jQ06gJ2oDZqPRCcqHg0d3QbiHq9QVWDSklvIW6x9YsU3mX
jKmpdsW3GN3gpLcxkAG5wegHVnCn/w==
=ghf/
-----END PGP SIGNATURE-----

--bNuazqpc9i+nntOr--


