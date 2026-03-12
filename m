Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D43FED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 05:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0YiW-0006oT-C2; Thu, 12 Mar 2026 01:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0YiU-0006oK-10
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w0YiR-0005Id-Jf
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773293769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zevKu7OLUpX6P3LsJwFybIsMJ+57Togts55ZBU5WfA=;
 b=CXIb4QYmDorUm/vIjO/w26X2LaRIrD/2FZQIPtdQkK8dWV16C//HRisyxaE3G/Tb6NLGRI
 iquuDcAzMLtemqMYf7HWKgbW4CRBdv9MEs++2Yy2XYOv8Y1TfeanB3//BL2Ib1aNcvTk2W
 MocH8CJUqGCxM4VKpr9tVF+xbOAV6nE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-wrmpyusZMSCnu2M5l8mrMQ-1; Thu,
 12 Mar 2026 01:36:08 -0400
X-MC-Unique: wrmpyusZMSCnu2M5l8mrMQ-1
X-Mimecast-MFC-AGG-ID: wrmpyusZMSCnu2M5l8mrMQ_1773293767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6046180044D; Thu, 12 Mar 2026 05:36:06 +0000 (UTC)
Received: from localhost (unknown [10.45.224.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C633195410D; Thu, 12 Mar 2026 05:36:04 +0000 (UTC)
Date: Thu, 12 Mar 2026 13:36:01 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 07/13] net/colo: track IOThread references using
 path-based holder
Message-ID: <20260312053601.GB116604@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-8-zhangckid@gmail.com>
 <20260309084422.GG39949@fedora>
 <CAK3tnvJmGEdr93pDDZdFk=0jUYHYChgchR4xtP6JpDVxBv2MCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DqidoBD3+bFlJ4Kl"
Content-Disposition: inline
In-Reply-To: <CAK3tnvJmGEdr93pDDZdFk=0jUYHYChgchR4xtP6JpDVxBv2MCA@mail.gmail.com>
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


--DqidoBD3+bFlJ4Kl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 06:15:16PM +0800, Zhang Chen wrote:
> On Mon, Mar 9, 2026 at 4:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> >
> > On Thu, Mar 05, 2026 at 10:24:53PM +0800, Zhang Chen wrote:
> > > @@ -1434,11 +1436,17 @@ static void colo_compare_finalize(Object *obj)
> > >
> > >      qemu_bh_delete(s->event_bh);
> > >
> > > -    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > +    /*
> > > +     * Use the device's canonical path as the holder ID to track IOT=
hread
> > > +     * usage and ensure the AioContext remains valid during the devi=
ce's
> > > +     * lifecycle.
> > > +     */
> > > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL);
> >
> > Should NULL be path?
> >
>=20
> Yes, here code in the finalize function need to waiting for the
> coroutine to complete processing
> Or do you have any other suggestion?

I'm not sure I understand. My question was about:

  AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL);
                                                          ^^^^

NULL is passed as the argument but this function has a 'path' local
variable. The path variable should be passed instead of NULL.

Stefan

--DqidoBD3+bFlJ4Kl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmyUMEACgkQnKSrs4Gr
c8iN2Qf+OCOYWMi/ponmFlfECsI8wQTFhuiEJ2n4m6l/1E9wH3h/9v2hR1WTNr39
T1m5yxkkVmsNDxLN/IYe7/7a9rYX+kL8ruw8iC77bCkC4b4FkYOWdDX9SvFHmfSu
KPpClmVd0x17ovNAdRU9fU8QrGMuamVEqLWKJSCWCJYhvHwtM4+G2lICpaaPgZmP
4TO3nDHcQG84R315UJV8zy6lDZwfCvJA3uyVKWmuDE6NO0qifGKVfdiW9ptAOZko
GXg5RsMHHRHfsq8/4I9b3NQjOaM1B1wcVKwOZf+5kXm6z6p0uhVqB/hc8PtFHK44
1bDQygAZgRcGcI7QqmNjg0uPlhceLA==
=0uPU
-----END PGP SIGNATURE-----

--DqidoBD3+bFlJ4Kl--


