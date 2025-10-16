Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB5DCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Slp-0005if-MO; Thu, 16 Oct 2025 14:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9Slh-0005hU-36
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9SlV-0007lm-BD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760639507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qb8t6Qby26hpNXCU48A40qXxxDxnbHF7MUsuqqJ6Rkc=;
 b=LjWFxtqkgYgK+TLY5bF+DRQ/HS+Z2EDEZMl1WzXOcKciwVCJEE02GOJNQCNptDeIlceeUx
 WN2MR7ZUTI/+nya7WugNTrbH90c3E6jEBUeVr9gzIdfYvGS9iN9EAMt8E2Y6Bs04EiV0Jn
 4Qa2LNAOKje/JYphEv3xKmDnko4IAVE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-1dHO7HzyMR-5G341X05PFg-1; Thu,
 16 Oct 2025 14:31:44 -0400
X-MC-Unique: 1dHO7HzyMR-5G341X05PFg-1
X-Mimecast-MFC-AGG-ID: 1dHO7HzyMR-5G341X05PFg_1760639502
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F08A19560A3; Thu, 16 Oct 2025 18:31:42 +0000 (UTC)
Received: from localhost (unknown [10.2.17.104])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D31CE1800452; Thu, 16 Oct 2025 18:31:40 +0000 (UTC)
Date: Thu, 16 Oct 2025 14:31:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 hi@alyssa.is, david@redhat.com, jasowang@redhat.com,
 dbassey@redhat.com, stevensd@chromium.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com,
 manos.pitsidianakis@linaro.org
Subject: Re: [PATCH v10 1/7] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <20251016183139.GB1179082@fedora>
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
 <CADSE00Ln3fjBhhs5W2YXiM7M6u6kg2=5r6Nx+d03bkinsX15BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q6+uOURu45m0yoDL"
Content-Disposition: inline
In-Reply-To: <CADSE00Ln3fjBhhs5W2YXiM7M6u6kg2=5r6Nx+d03bkinsX15BA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Q6+uOURu45m0yoDL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 05:18:45PM +0200, Albert Esteve wrote:
> On Thu, Oct 16, 2025 at 4:38=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> > @@ -1836,6 +2054,19 @@ static gboolean backend_read(QIOChannel *ioc, GI=
OCondition condition,
> >          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->op=
aque, ioc,
> >                                                               &hdr, &pa=
yload);
> >          break;
> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > +        /* Handler manages its own response, check error and close con=
nection */
> > +        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &paylo=
ad,
> > +                                                fd ? fd[0] : -1) < 0) {
> > +            goto err;
> > +        }
> > +        break;
> > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > +        /* Handler manages its own response, check error and close con=
nection */
> > +        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &pay=
load) < 0) {
> > +            goto err;
> > +        }
> > +        break;
>=20
> Once this patch lands:
> https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg03932.html
> These two handlers will need a `reply_ack =3D false;` before being
> invoked. What's the best way to proceed in this case?
>=20
> If I can chose, I'd prefer to integrate this one first and then I can
> rebase the one I linked and set the reply_ack where needed.

You can rebase ahead of time and add "Based-on: <message-id>" to the
cover letter so the maintainer knows there is a dependency between the
patch series.

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#id35

When sending the series that depends on another series, be careful to
specify only the commit range from the end of the other series so that
you don't include all the commits from the other series. That way
reviewers aren't distracted by a bunch of other commits that are not
part of this series.

Summarizing:
1. Rebase your other series on this one.
2. Carefully send a new revision of your other series with only its
   commits (not the commits from this series) and add "Based-on:
   <message-id>" referencing this patch series by its Message-Id.

Stefan

--Q6+uOURu45m0yoDL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjxOgsACgkQnKSrs4Gr
c8hsIQgAlhrm3IxTzxa87kzP/NUklnlN9tky05tZLPCvz/DrKztO7aqdahge49z/
hL73G72SFrfbgMy0wlEYYGFFnnaBQNI3UEe/DKs+d0XGQy9bATMsCtJd6ApxoGqO
XR70R9Z8Q2F5Ukw+AG1h0NBJjc5W55ftwJGjqf5Db2hFmfGkZr64S6O2OLPATClm
ULSo+4ZgoeY21Vv8dQBekQzh8gXh3J7U1jSGhnwt6CrF/k/fCfzN/WhtF4gd3Qkt
8AWnYGw4Jqd1MTBZTZg0/y2in0ybn1uw7dyXP0hDXqrlm+FrvejOnBUrxIAmAP+z
EiYuDmFn3ctK+UzOZRPZM0HiOADAPg==
=uVJT
-----END PGP SIGNATURE-----

--Q6+uOURu45m0yoDL--


