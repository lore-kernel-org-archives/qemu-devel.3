Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE998E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5FK-0000n1-3q; Thu, 19 Feb 2026 09:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vt5FA-0000gD-TO
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vt5F8-0005ej-Vo
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771512181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0/8bAJPuc5qPPjQqgeoLkRIKKh0ILgUF7L06opXEnM=;
 b=Gg8sCCU8+8Eq3m0uiD7+kVbz5xKMZ4BZA50wdXmGOTFhIx37n4HzXmMaF1FNmC0/52T+52
 IhMrS8QgaOIjtFAM/gkX+Mjz9twafSSFvcaX7A/SBwRM0gySsKI21fcSjWnM6Rfr/C+ts+
 484eU/uA3ATiHFoAw831OMUYMcEBY1k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-2ycyINBsMYGHEg18sVkN5Q-1; Thu,
 19 Feb 2026 09:43:00 -0500
X-MC-Unique: 2ycyINBsMYGHEg18sVkN5Q-1
X-Mimecast-MFC-AGG-ID: 2ycyINBsMYGHEg18sVkN5Q_1771512179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A34251800464; Thu, 19 Feb 2026 14:42:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.138])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F62C1800361; Thu, 19 Feb 2026 14:42:56 +0000 (UTC)
Date: Thu, 19 Feb 2026 09:42:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, bernd@bsbernd.com
Subject: Re: [Patch v4 2/7] fuse: io_uring mode init
Message-ID: <20260219144256.GD817358@fedora>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-3-hibriansong@gmail.com>
 <20260211205611.GB234157@fedora>
 <C001D79E-6269-4DC7-ABD3-AE86B8122909@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GhB6ap+U3t/EsKwD"
Content-Disposition: inline
In-Reply-To: <C001D79E-6269-4DC7-ABD3-AE86B8122909@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--GhB6ap+U3t/EsKwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 05:03:23PM +0800, Brian Song wrote:
>=20
>=20
> > On Feb 12, 2026, at 04:56, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >=20
> > On Sat, Feb 07, 2026 at 08:08:56PM +0800, Brian Song wrote:
> >> +typedef struct FuseUringEnt {
> >> +    /* back pointer */
> >> +    FuseUringQueue *rq;
> >> +
> >> +    /* commit id of a fuse request */
> >> +    uint64_t req_commit_id;
>=20
> [...]
>=20
> >> +
> >> +/**
> >> + * Distribute uring queues across FUSE queues in the round-robin mann=
er.
> >> + * This ensures even distribution of kernel uring queues across user-=
specified
> >> + * FUSE queues.
> >> + *
> >> + * num_uring_queues > num_fuse_queues: Each IOThread manages multiple=
 uring
> >> + * queues (multi-queue mapping).
> >> + * num_uring_queues < num_fuse_queues: Excess IOThreads remain idle w=
ith no
> >> + * assigned uring queues.
> >> + */
> >> +static void fuse_uring_setup_queues(FuseExport *exp, size_t bufsize)
> >> +{
> >> +    int num_uring_queues =3D get_nprocs_conf();
> >> +
> >> +    exp->num_uring_queues =3D num_uring_queues;
> >> +    exp->uring_queues =3D g_new(FuseUringQueue, num_uring_queues);
> >> +
> >> +    for (int i =3D 0; i < num_uring_queues; i++) {
> >> +        FuseUringQueue *rq =3D &exp->uring_queues[i];
> >> +        rq->rqid =3D i;
> >> +        rq->ent =3D g_new(FuseUringEnt, exp->uring_queue_depth);
> >> +
> >> +        for (int j =3D 0; j < exp->uring_queue_depth; j++) {
> >> +            FuseUringEnt *ent =3D &rq->ent[j];
> >> +            ent->rq =3D rq;
> >> +            ent->req_payload_sz =3D bufsize - FUSE_BUFFER_HEADER_SIZE;
> >> +            ent->req_payload =3D g_malloc0(ent->req_payload_sz);
> >=20
> > I don't see a corresponding g_free() in this patch? Exports can be
> > deleted at runtime, so this memory must be freed.
> >=20
>=20
> ent->req_payload is deleted in fuse_export_delete_uring() in a later patc=
h.
> Should we merge patch 5 into this one?

Unless there is a strong reason why the free needs to be deferred to a
later, it's safer to include it in the same patch that allocates the
memory. It makes code review easier and backporting patches safer (no
chance of forgetting to backport the other patch that frees the memory).

Stefan

--GhB6ap+U3t/EsKwD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmXIXAACgkQnKSrs4Gr
c8gH4Af/Rnmx/L/kftTCX1bVw2TcbFHh0V9escjbp8hF7vLOIYy/hX6wi9qX6b+D
613XNeVN2e1pmTF/ybBl7/LvJdnNRjZe7Pt+c7oY6YiTTCKNgTkg3R5u2g4kLLs1
79pu6LzvbUY/lb0WfwsEcL+TBfqG6fd+MNBRG1XtZxE4BbPINxZTcJcSNgn9ArND
u7gPWlB7HUf9OiQSzxeI5BDBnKy1RO2cctSMmmjcBp4F2pDWyYkcmJ3MYMb9iKjf
jkTgNL5frfNw0t9DjeLrcHaQxaESWBwO1nrPVdzTwLZa4VCCHgDt0GnqKi/6OU38
LJPq2rEXJiEx9jFVnLJEkpn2pETS6Q==
=QT+f
-----END PGP SIGNATURE-----

--GhB6ap+U3t/EsKwD--


