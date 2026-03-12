Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADF8FED2E0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0abZ-00050p-3t; Thu, 12 Mar 2026 03:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0abX-00050H-IZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0abN-0004fF-EU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773301009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTeFRk2AtKbGQCC/xhJKcrquSm4GowHWwwqcunHWk4M=;
 b=Qe71u9Bcyoe49mLq4YWupleK1DjyZv+56NIcKHMAyCw0VGXdYX4e3GUHM6fx2olip0YShr
 F1j+wqZxEi2mO6QFdAxSSDpyd7hli3wv0rWKDLXjZv7A5mxcpTtN5OPanEfQ2YCDtrDDK0
 puZgnXFZf8D+kN4R5eUDL6Gtq4qyxp8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-tojd1HI1M1SQqn3K5Kc35A-1; Thu,
 12 Mar 2026 03:36:36 -0400
X-MC-Unique: tojd1HI1M1SQqn3K5Kc35A-1
X-Mimecast-MFC-AGG-ID: tojd1HI1M1SQqn3K5Kc35A_1773300981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D964A1800281; Thu, 12 Mar 2026 07:36:20 +0000 (UTC)
Received: from localhost (unknown [10.45.224.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80F7919540C2; Thu, 12 Mar 2026 07:36:19 +0000 (UTC)
Date: Thu, 12 Mar 2026 15:36:16 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 07/13] net/colo: track IOThread references using
 path-based holder
Message-ID: <20260312073616.GA129138@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-8-zhangckid@gmail.com>
 <20260309084422.GG39949@fedora>
 <CAK3tnvJmGEdr93pDDZdFk=0jUYHYChgchR4xtP6JpDVxBv2MCA@mail.gmail.com>
 <20260312053601.GB116604@fedora>
 <CAK3tnvKfeKBxigGsS8B-PiBuq2w5i7Dp3sBfXzZKoaDFr4QBRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="teTHQc8XoEUn3bEc"
Content-Disposition: inline
In-Reply-To: <CAK3tnvKfeKBxigGsS8B-PiBuq2w5i7Dp3sBfXzZKoaDFr4QBRw@mail.gmail.com>
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


--teTHQc8XoEUn3bEc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 02:31:32PM +0800, Zhang Chen wrote:
> On Thu, Mar 12, 2026 at 1:36=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, Mar 10, 2026 at 06:15:16PM +0800, Zhang Chen wrote:
> > > On Mon, Mar 9, 2026 at 4:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > > >
> > > > On Thu, Mar 05, 2026 at 10:24:53PM +0800, Zhang Chen wrote:
> > > > > @@ -1434,11 +1436,17 @@ static void colo_compare_finalize(Object =
*obj)
> > > > >
> > > > >      qemu_bh_delete(s->event_bh);
> > > > >
> > > > > -    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > > > +    /*
> > > > > +     * Use the device's canonical path as the holder ID to track=
 IOThread
> > > > > +     * usage and ensure the AioContext remains valid during the =
device's
> > > > > +     * lifecycle.
> > > > > +     */
> > > > > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread, NU=
LL);
> > > >
> > > > Should NULL be path?
> > > >
> > >
> > > Yes, here code in the finalize function need to waiting for the
> > > coroutine to complete processing
> > > Or do you have any other suggestion?
> >
> > I'm not sure I understand. My question was about:
> >
> >   AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL);
> >                                                           ^^^^
> >
> > NULL is passed as the argument but this function has a 'path' local
> > variable. The path variable should be passed instead of NULL.
>=20
> Let me explain in detail.
> colo-compare have two real holders for the iothread,
> 1. colo_compare_timer_init.
> 2. worker_context for chardev handlers.
>=20
> I try to make them use one pair of iothread_get/put.

I suggest storing the AioContext pointer in a new CompareState field in
colo_compare_iothread() and and then using it in colo_compare_finalize()
instead of calling iothread_get_aio_context(s->iothread, NULL).

Stefan

--teTHQc8XoEUn3bEc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmybPAACgkQnKSrs4Gr
c8ijbgf/U10dLXtu/KF1TmzO7FvwKxpQlqMD8iFnx90TWCQYhjL4D53+vupHM9Bd
d3FUzQ8Uiq3HCN6D+hb0ZSDk7EuFTSvwjcpnUNt9kirnNkLePRFwxc1eIJtFtmH/
rmKcAa2qhzFBwzCZ3cJMRTN31AuHJYutMKpgXeUf9LdFG8xx468YKMYou4q6/XGB
cC+EmU8Kg7IFla/UBj1uHdcR+5sKs0G0Ywb/xnzItzyWE6SRuyLUnYOJD4oD2GUU
10Ik92eVw81JA5oOISKOfRYmUQWRE5j9tTQap02cBZSBCvu9uoLns4iCRY7ELD4m
gfc4t88kAe8th9uUcOhsdFH5PjjMrw==
=je5g
-----END PGP SIGNATURE-----

--teTHQc8XoEUn3bEc--


