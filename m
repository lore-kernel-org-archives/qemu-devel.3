Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0533FCDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckAl-0007bj-81; Thu, 25 Jun 2026 09:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wckAj-0007bb-Nm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wckAh-0007G2-2k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782394269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8qfn1oKOjkgto7sZhNm764YsGcjOBZo3rCciDpPVZQ=;
 b=bdAK9IkMlBn+LQSYB50sK24dhy96/d3OjNePcjbI/4Hva6W7qHHkdxevwbYr4P1+N0qnSo
 E2LS1Pf0bpM4I+BGB44YJiASNlXGrBGtVeL2baAijVvk0i8XjyVnEr71asYKspYkvOxDA6
 rRVzowrfd7zijk5KKzcDYDRn2wB10rk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-NiwqrGrNNVugvPco0AudZA-1; Thu,
 25 Jun 2026 09:31:04 -0400
X-MC-Unique: NiwqrGrNNVugvPco0AudZA-1
X-Mimecast-MFC-AGG-ID: NiwqrGrNNVugvPco0AudZA_1782394263
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2A2719775E0; Thu, 25 Jun 2026 13:31:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.69])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90AC41771; Thu, 25 Jun 2026 13:31:01 +0000 (UTC)
Date: Thu, 25 Jun 2026 09:31:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 05/17] block/export: track IOThread reference in
 BlockExport
Message-ID: <20260625133100.GA148001@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-6-zhangckid@gmail.com>
 <20260624175143.GD109308@fedora>
 <CAK3tnvLhx9HipFENkMm-pdOqvLZUYDdF=VuFzQ=gyD4TV__eSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sqLJG18q53CvhdQE"
Content-Disposition: inline
In-Reply-To: <CAK3tnvLhx9HipFENkMm-pdOqvLZUYDdF=VuFzQ=gyD4TV__eSw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--sqLJG18q53CvhdQE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 07:06:26AM +0800, Zhang Chen wrote:
> On Thu, Jun 25, 2026 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Wed, Jun 24, 2026 at 03:08:39PM +0800, Zhang Chen wrote:
> > > Users currently lack visibility into which block exports
> > > are utilizing specific IOThreads. This patch integrates IOThread
> > > referencing into the BlockExport lifecycle.
> > >
> > > - Add iothreads array and holder_name to BlockExport struct.
> > > - Use iothread_ref_and_get_aio_context during export creation.
> > > - Implement proper cleanup in blk_exp_add fail path and blk_exp_delet=
e_bh.
> > > - Support both single and multi-iothread export configurations.
> > >
> > > This ensures IOThread 'holders' status correctly reflects active block
> > > exports for better debugging and resource tracking.
> > >
> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > ---
> > >  block/export/export.c  | 63 ++++++++++++++++++++++++++++++++++++----=
--
> > >  include/block/export.h |  6 ++++
> > >  2 files changed, 60 insertions(+), 9 deletions(-)
> >
> > If AI was used to generate this patch series, please see QEMU's AI
> > policy:
> > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-g=
enerated-content
> >
> > This feels like AI generated code in that it is verbose and has lots of
> > structure (e.g. commit messages that look like an AI summary of the code
> > change), but the details are not correct (misleading comments, leaks,
> > etc).
> >
> > I will pause my review at this patch and wait for your response.
>=20
> I used the AI for parts of commit messages.
> Please continue to review code parts and skip the commit message parts,
> I will remove all AI-generated commit messages in next version.

Okay, thanks. There is no need to enumerate the code changes in the
commit message unless there is some rationale or commentary you want to
share so that people understand why you did things in a certain way.

> Sorry, I just noticed the discussion:
> [PATCH v2] docs/devel: relax policy on AI-generated contributions

The new policy will allow some use of AI generated content when the
policy comes into effect. For now we still have to follow the existing
policy.

>=20
>=20
> >
> > >
> > > diff --git a/block/export/export.c b/block/export/export.c
> > > index b733f269f3..b6c07f69b5 100644
> > > --- a/block/export/export.c
> > > +++ b/block/export/export.c
> > > @@ -15,7 +15,6 @@
> > >
> > >  #include "block/block.h"
> > >  #include "system/block-backend.h"
> > > -#include "system/iothread.h"
> > >  #include "block/export.h"
> > >  #include "block/fuse.h"
> > >  #include "block/nbd.h"
> > > @@ -85,6 +84,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export=
, Error **errp)
> > >      AioContext *ctx;
> > >      AioContext **multithread_ctxs =3D NULL;
> > >      size_t multithread_count =3D 0;
> > > +    g_autofree IOThread **local_iothreads =3D NULL;
> > > +    const char *holder_name =3D NULL;
> > >      uint64_t perm;
> > >      int ret;
> > >
> > > @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *exp=
ort, Error **errp)
> > >              goto fail;
> > >          }
> > >
> > > -        new_ctx =3D iothread_get_aio_context(iothread);
> > > +        holder_name =3D bdrv_get_node_name(bs);
> > > +        IOThreadHolder holder =3D {
> > > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
> >
> > This is not a block node, this is a block export (a separate type of
> > object). Reporting the export as a node is confusing because users will
> > not know which block export id is assigned using this IOThread, they
> > will only know the block node (which could be doing other things too).
>=20
> OK, it looks need to change the type name from:
> IO_THREAD_HOLDER_KIND_BLOCK_NODE
> to:
> IO_THREAD_HOLDER_KIND_BLOCK_EXPORT

Yes.

--sqLJG18q53CvhdQE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo9LZQACgkQnKSrs4Gr
c8gLdAf7BMwaQTa5Gv6NAXNWcd7UnY0jBtsZWRN9SLmgFI+AQOJEX0xBaThm0YXw
DtrAkLLsl3DPrTScEszk7Ybn3ZvWwCpv7vBkevTE/xyIDq+m3PisUb6yGgO/ovUs
Y2dwZOgiMHC8KoL03s01fvvNYeY+vj7At4cgQvgOKQ23T0eTljrHJavqQQD7MCrC
3Wvl1ybfCS0y/L7tWYYYxewDiNqwr76LQM4pNl+CwNqUh8zKwNTwRTfw5UmIwGTH
nQGt5mUyDKtRxVfGXI4F3BrHyoTF2AZGaq/9j3nDpf87OMvmPn/OyRicqAJFB9aj
IMafkoouD+j3Ym3jLbW3Rs6fNngXDg==
=o84t
-----END PGP SIGNATURE-----

--sqLJG18q53CvhdQE--


