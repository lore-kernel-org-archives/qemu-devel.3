Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A24CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcloT-0001da-4q; Thu, 25 Jun 2026 11:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcloR-0001dJ-3D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcloP-0006wr-JF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782400575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ijmkcJLwfy7WXVzwajK3zF/OHNAh6AIbhYrV6rOlwpc=;
 b=CD/E0dMiAACTS5fqPD+fDq3GIL6brXfxGUrM9hJB7omwZRF2O5J7UfwzXHIG/0I2aFuC1X
 pHO6kw2IY3D+QojpA1iri14trsmZI5kWA7A4WWk3ZQyQb30nNgEFefLWppM4KXLcKlwncb
 db5qw8wC5279LuwB7hBIQkBhh25pqTI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-OHqg7XEbM9upf5J-FVX9xg-1; Thu,
 25 Jun 2026 11:16:14 -0400
X-MC-Unique: OHqg7XEbM9upf5J-FVX9xg-1
X-Mimecast-MFC-AGG-ID: OHqg7XEbM9upf5J-FVX9xg_1782400573
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5CD01805A2D; Thu, 25 Jun 2026 15:16:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.255])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEEE6195608C; Thu, 25 Jun 2026 15:16:11 +0000 (UTC)
Date: Thu, 25 Jun 2026 11:16:08 -0400
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
Message-ID: <20260625151608.GA160758@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-6-zhangckid@gmail.com>
 <20260624175143.GD109308@fedora>
 <CAK3tnvLhx9HipFENkMm-pdOqvLZUYDdF=VuFzQ=gyD4TV__eSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="78rTaFhkzbaqydzB"
Content-Disposition: inline
In-Reply-To: <CAK3tnvLhx9HipFENkMm-pdOqvLZUYDdF=VuFzQ=gyD4TV__eSw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--78rTaFhkzbaqydzB
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
>=20
> Sorry, I just noticed the discussion:
> [PATCH v2] docs/devel: relax policy on AI-generated contributions

By the way, the existing policy already allows using AI for code review.
I recommend doing this before sending patches.

Stefan

--78rTaFhkzbaqydzB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo9RjgACgkQnKSrs4Gr
c8jaGgf/Xt0I5bzK6R6TDK8vkNI2R+n3PANEIgRPBzwp/S9afYynBxilnJ9f3d+8
qBK95OOQOaal5B7UessnjyespZq81tBINgqOTx5PZOL+DtMYUMIYA8RFEpJZwmFe
ixoocnhY4A+NB4Sjr7UDKLc01FUdTG5sK0hmCDx5Iml5+Kun7IHz/G/dddQkNqYl
8ASPJWKO3FXY7GmcUo3PdZpwOpQ7mDb2QP5Z8l9pzEfsZo49afmIQ9dHT9EaCp4t
pTjBhJI8HY0fm7d364Pc0/0pJjgbbZ4gZgWnYbC5BUad1g3DgHyK+DeaWbRawwyz
HcEAv3jwng1fkL6afA9R8XqPPwP0eA==
=3L/S
-----END PGP SIGNATURE-----

--78rTaFhkzbaqydzB--


