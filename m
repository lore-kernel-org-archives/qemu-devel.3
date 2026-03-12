Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CF3FED2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 05:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0YXH-00058Z-3f; Thu, 12 Mar 2026 01:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0YXF-00058C-Me
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0YXC-0005eh-Sl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773293072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3s4Ei7XEG4pfhS0nEUBENCvEmVE4MV5py3gy5vhQr/s=;
 b=iXSsnhGJK55PDHmzmsD5P+Xg5zjqBjOb08a19M5khCEwIJL6a2V1d0js+fKCymHOwS+rxQ
 O3JPDshGD8G7JMSUV0bblbYPdHCJEtPHth0gxcT0S0z74i/6c9jXaTc37GaFH9O/O36AN0
 JWQHf4HsOgJS3YdgeY88GZC/j/LynTc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-ir9t-z4MNFKkziHaUf-RQQ-1; Thu,
 12 Mar 2026 01:24:28 -0400
X-MC-Unique: ir9t-z4MNFKkziHaUf-RQQ-1
X-Mimecast-MFC-AGG-ID: ir9t-z4MNFKkziHaUf-RQQ_1773293067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4560E1800365; Thu, 12 Mar 2026 05:24:27 +0000 (UTC)
Received: from localhost (unknown [10.45.224.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2EF61800361; Thu, 12 Mar 2026 05:24:25 +0000 (UTC)
Date: Thu, 12 Mar 2026 13:24:22 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
Message-ID: <20260312052422.GA116604@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eZjPKKTMoS/syLBn"
Content-Disposition: inline
In-Reply-To: <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--eZjPKKTMoS/syLBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 06:02:54PM +0800, Zhang Chen wrote:
> On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> >
> > On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
> > > Update the usage of "iothread_get_aio_context()".
> > >
> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > ---
> > >  blockdev.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/blockdev.c b/blockdev.c
> > > index 6e86c6262f..01ccf64b3f 100644
> > > --- a/blockdev.c
> > > +++ b/blockdev.c
> > > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const char *n=
ode_name, StrOrNull *iothread,
> > >              goto out;
> > >          }
> > >
> > > -        new_context =3D iothread_get_aio_context(obj);
> > > +        char *path =3D object_get_canonical_path(OBJECT(bs));
> >
> > CCing Kevin and Markus in case they have an opinion on this.
> >
> > BlockDriverState is not a QOM Object so using OBJECT(bs) is undefined
> > behavior and may crash.
> >
> > node_name is unique across block driver graph nodes and could be used.
> > Unfortunately it's not connected to the QOM Object hierarchy. Maybe it's
> > best to build a holder name that is an invalid QOM path so there can be
> > no collisions between QOM paths and block driver graph nodes.
> >
> >   g_autofree char *holder =3D g_strdup_printf("BlockDriverState %s", no=
de_name);
> >
> > (A cleaner long-term solution would be making BlockDriverStates QOM
> > Objects so they have a proper path.)
>=20
> If no other comments, it's OK for me. This issue like I mentioned in
> patch 7 and 9.

A thought about the QAPI interface:

QAPI expresses as much information in the schema as possible, so I think
the right approach would be a {'union': 'IOThreadHolder',
'discriminator': 'type', ...} that supports at least "qom" and
"block-node". That way there are proper types to encode QOM Object paths
vs block node-names. Let's avoid having a single string value that takes
on different meaning depending on the type of holder.

--eZjPKKTMoS/syLBn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmyTgYACgkQnKSrs4Gr
c8hEqAf/U1iG5A6KHZDrNMVBqjC6o87r4RfR82J1UQDi12N634XXuQGUcfxcEbNI
Kdu0+kxssOStw7NK3TRTnlNvWxCNJz/5Ugx6BvByhcCLvf6c8vL+61eIkB4D3Lsa
1jzWUW/+0e8crtFt7wqxzX7BeEgyWqiZyXRhxGCQQPKxk6mCE2IsbBo5lMKOYf2Y
0hQyzJrA7gCuwOVuT3pprsvZbo1smurmSXjfA0ntKe7kd0r9XQhQ+U/0fxzVezGN
2A89sRCsokUFOlm9MwkAbTR76uvtg3atA3vzaF9+azIWuBSwSKy6pRoyrJwiFlMi
TWecfg+e/3iu1fXYHFx//uP9J0NxLA==
=9D2v
-----END PGP SIGNATURE-----

--eZjPKKTMoS/syLBn--


