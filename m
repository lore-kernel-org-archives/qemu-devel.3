Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B52C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfB4l-00029o-UX; Thu, 02 Jul 2026 02:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfB4j-00029W-DA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfB4h-0000we-Kz
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782974341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j7SL5CEvD98QcULUB0zdryGEYU8QSu71OH0KsfciTKw=;
 b=bibMBCyYVhVKPLzYW/wL5bL9KWW6RRg17mTE3WOInZ43L6uj9cCMls5VXb6voCc5P7heOb
 T9B994yD1sVRTSdLoguDzaoHnA8ZjKaeq99aMP8vEUfW084UXmqrAaKedDb+miVkM0n9VE
 SuS1kznOxXkYLU6HDNALl3IPjPVl4wc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-pKfK4izLPjarThdE_AuXRQ-1; Thu,
 02 Jul 2026 02:38:58 -0400
X-MC-Unique: pKfK4izLPjarThdE_AuXRQ-1
X-Mimecast-MFC-AGG-ID: pKfK4izLPjarThdE_AuXRQ_1782974337
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 874BF1945CB3; Thu,  2 Jul 2026 06:38:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AFB8180056E; Thu,  2 Jul 2026 06:38:54 +0000 (UTC)
Date: Wed, 1 Jul 2026 18:10:03 +0200
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
Message-ID: <20260701161003.GA413397@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-6-zhangckid@gmail.com>
 <20260624175143.GD109308@fedora>
 <CAK3tnvLhx9HipFENkMm-pdOqvLZUYDdF=VuFzQ=gyD4TV__eSw@mail.gmail.com>
 <20260625151608.GA160758@fedora>
 <CAK3tnvL5=SoBPV-WQ22AM4xaneqBU=BbAAbUyhXodFiFD=dYJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r5VBOiqxIbBpz3U0"
Content-Disposition: inline
In-Reply-To: <CAK3tnvL5=SoBPV-WQ22AM4xaneqBU=BbAAbUyhXodFiFD=dYJQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--r5VBOiqxIbBpz3U0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 02:01:04PM +0800, Zhang Chen wrote:
> On Thu, Jun 25, 2026 at 11:16=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
=2Ecom> wrote:
> >
> > On Thu, Jun 25, 2026 at 07:06:26AM +0800, Zhang Chen wrote:
> > > On Thu, Jun 25, 2026 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > >
> > > > On Wed, Jun 24, 2026 at 03:08:39PM +0800, Zhang Chen wrote:
> > > > > Users currently lack visibility into which block exports
> > > > > are utilizing specific IOThreads. This patch integrates IOThread
> > > > > referencing into the BlockExport lifecycle.
> > > > >
> > > > > - Add iothreads array and holder_name to BlockExport struct.
> > > > > - Use iothread_ref_and_get_aio_context during export creation.
> > > > > - Implement proper cleanup in blk_exp_add fail path and blk_exp_d=
elete_bh.
> > > > > - Support both single and multi-iothread export configurations.
> > > > >
> > > > > This ensures IOThread 'holders' status correctly reflects active =
block
> > > > > exports for better debugging and resource tracking.
> > > > >
> > > > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > > > ---
> > > > >  block/export/export.c  | 63 ++++++++++++++++++++++++++++++++++++=
------
> > > > >  include/block/export.h |  6 ++++
> > > > >  2 files changed, 60 insertions(+), 9 deletions(-)
> > > >
> > > > If AI was used to generate this patch series, please see QEMU's AI
> > > > policy:
> > > > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-=
ai-generated-content
> > > >
> > > > This feels like AI generated code in that it is verbose and has lot=
s of
> > > > structure (e.g. commit messages that look like an AI summary of the=
 code
> > > > change), but the details are not correct (misleading comments, leak=
s,
> > > > etc).
> > > >
> > > > I will pause my review at this patch and wait for your response.
> > >
> > > I used the AI for parts of commit messages.
> > > Please continue to review code parts and skip the commit message part=
s,
> > > I will remove all AI-generated commit messages in next version.
> > >
> > > Sorry, I just noticed the discussion:
> > > [PATCH v2] docs/devel: relax policy on AI-generated contributions
> >
> > By the way, the existing policy already allows using AI for code review.
> > I recommend doing this before sending patches.
>=20
> OK, I will use AI for basic code review before sending the next version.
> By the way, do you have any design comments for other patches?

I'm working my way through the series and will send feedback one patch
at a time. You're welcome to send a new revision if you like, there's no
need to wait for me to finish all patches if you have been working on
code changes.

Stefan

--r5VBOiqxIbBpz3U0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpFO9sACgkQnKSrs4Gr
c8iXPAf9Hlq/xKiVtZzHFNGQlt6GgY0ZXF4y8s6s8+7dJSRBYoNrQ/CnFxPLlN4T
I2Va3/tu3l66r0Hv8RvzinPqKPOa5O5l2XoU0LbRTo1yOZdik2g7dE/Ur5crghum
MCnryyPddzIR2VcmS2s1wOFC8bOnC3pwXx+9jCblO5kAYHqlhwMubzCMd2I5KpWN
skqr++KsOWT6BCL1n0cAfanKYpjdEqTL1wUO1uNTiCklxbLFiUwPXf4N1731FNyX
jOvh83h/6ptdQEfnVOnUb4iDqrdLo3SFLwB/LHGK29oJgOpHbqr4Ip7ZKjDVuidS
RA/bK7hJBEZx0/UtCQvzTrPBFolAZA==
=Wcn5
-----END PGP SIGNATURE-----

--r5VBOiqxIbBpz3U0--


