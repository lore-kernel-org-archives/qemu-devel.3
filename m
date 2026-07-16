Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDAEC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLTq-000356-SH; Thu, 16 Jul 2026 08:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wkLTn-00034c-6h
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wkLTl-0000Hk-0A
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784205974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GWa9hq75vE3Hqv+HwFkfmYVArnpqB4LXceg64Y9la1Y=;
 b=BcUxEwSf6Q4Qx7JguJb3oW1z5oI15NwxOMwmVkBTmmAl+TUPcm2NUJuTzXOBQn+MdbSrjg
 Wirh+i3HnmdZuP7trCWJY6RblWdQstcVfG5Ff0ry1RBwfdxrxt4rNQw8c4CB9xZ2E9Ir8J
 fvcbu+M5rJJLdGQEfhFFC4wP8Y7N8Lk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448--Zf57DRIPXqKdRMTAvKcwA-1; Thu,
 16 Jul 2026 08:46:11 -0400
X-MC-Unique: -Zf57DRIPXqKdRMTAvKcwA-1
X-Mimecast-MFC-AGG-ID: -Zf57DRIPXqKdRMTAvKcwA_1784205970
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B06B3180066A; Thu, 16 Jul 2026 12:46:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9041C3003EFC; Thu, 16 Jul 2026 12:46:08 +0000 (UTC)
Date: Thu, 16 Jul 2026 10:22:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 08/17] monitor: switch to
 iothread_unsafe_get_aio_context()
Message-ID: <20260716092207.GA741667@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-9-zhangckid@gmail.com>
 <20260701161642.GB413397@fedora>
 <CAK3tnv+qwj9=rgg3-pF-GYDQm9LbxCOrcr9EkO1dNtk0kBw8oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+N0s3hZWqlS6Hx6n"
Content-Disposition: inline
In-Reply-To: <CAK3tnv+qwj9=rgg3-pF-GYDQm9LbxCOrcr9EkO1dNtk0kBw8oA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--+N0s3hZWqlS6Hx6n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 04:59:30PM +0800, Zhang Chen wrote:
> On Thu, Jul 2, 2026 at 2:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> >
> > On Wed, Jun 24, 2026 at 03:08:42PM +0800, Zhang Chen wrote:
> > > Since previous patches introduced explicit monitor tracking and refer=
ence
> > > counting via IOThreadHolder during initialization, standard global ca=
lls
> > > to iothread_get_aio_context() are no longer appropriate for raw conte=
xt
> > > fetches.
> > >
> > > Switch the remaining fallback sites in monitor_suspend(), monitor_res=
ume(),
> > > and monitor_init_qmp() to use iothread_unsafe_get_aio_context(). This=
 aligns
> > > with the new safe ref/unref lifecycles introduced for monitor trackin=
g.
> >
> > Why is the unsafe API used here? monitor_data_init() now takes a
> > reference and gets the AioContext. Can you use that AioContext here
> > instead of fetching it with iothread_unsafe_get_aio_context()?
>=20
> Because we have some comments from this series V8 patches:
> https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg00375.html
>=20
> If OK, I will back to the V8 code and follow the [PATCH V9 06/17] comment=
s,
> https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07323.html
> based on Daniel's series for monitor parts in V10.

Markus had no objection to using safe ref/unref APIs. I think he didn't
like the additional AioContext pointer that the caller needed to manage.

Using the safe APIs is important because the risk of bugs is high with
an unsafe API. If the new safe API is too inconvenient to use, then
let's find a different API design.

Here is a variation of the API that requires the caller to hold just 1
thing - the ref:

IOThreadRef *iothread_ref_get(IOThread *iothread, const IOThreadHolder *hol=
der);
void iothread_ref_put(IOThreadRef *ref);
AioContext *iothread_ref_get_aio_context(IOThreadRef *ref);

The caller can call iothread_ref_get_aio_aio_context() multiple times,
so they no longer need to store the AioContext pointer.

Since iothread_ref_put() takes IOThreadRef, the caller doesn't need to
build a new IOThreadHolder when releasing the reference.

What do you think?

Stefan

--+N0s3hZWqlS6Hx6n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpYor8ACgkQnKSrs4Gr
c8i94Qf/Q+o/nxkjVRbTM2+5TmSz255WtADM21j25NDb++SFVKyAWbQcKC76rYwb
qD7aEKyuCIX2fh5+vMM0TxoA2dQN2J+ivH9sUX+F/qlXQzLVY6MLTviQjEHINpNa
ZLmKZrUKYPKxjxja05byDzLeFDSYqKhvYK6pJDbOwC0oZLimfCroAYbT0GjwEx45
0Xv4OI7M0GgVfjLuz2S4mSdXxGHBPuRK3Wl6+CBkao15A0J6OmzQqKv2j2Y15OlT
roON4o13gTRgElRnJUyXeFHp/wO7m57kIylHxedaUvPwvk/z9aRcp2Nrsy9Uxhun
QG7FD0QuCh80bs6uW2LPDqcVRBqkWw==
=ToXw
-----END PGP SIGNATURE-----

--+N0s3hZWqlS6Hx6n--


