Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29EDF94CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 19:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHDz-0003IK-1J; Tue, 21 Apr 2026 15:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFHDx-0003Hn-7E
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 15:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFHDu-0006mx-SY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 15:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776801448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHYz/4QsY/KGeyY5wljzZ7re6nmspMhzUIggKdlvWSE=;
 b=B1k6qVRn6QfFwO3IsWUrhZJxWAyS2zLQ5MpLZZiikng6yM/kgsCGYSbqID8wpM7iL0NEuD
 hSzMM8ABzWf+D+S+KcarGdDkLQIRHZEhqY5HgKn50K0W4CuWAqeca+pNEm0pPkKtzwGFgO
 acRyjio5IwKvKsHADHWV5YiFdVbnYdM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-Dtvjyj0LM7qO15oI8f4Fow-1; Tue,
 21 Apr 2026 15:57:26 -0400
X-MC-Unique: Dtvjyj0LM7qO15oI8f4Fow-1
X-Mimecast-MFC-AGG-ID: Dtvjyj0LM7qO15oI8f4Fow_1776801445
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98A931956089; Tue, 21 Apr 2026 19:57:25 +0000 (UTC)
Received: from localhost (unknown [10.44.32.90])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 656FC180045E; Tue, 21 Apr 2026 19:57:24 +0000 (UTC)
Date: Tue, 21 Apr 2026 15:57:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jorge Moreira <jemoreira@google.com>, hreitz@redhat.com,
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260421195722.GA466778@fedora>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <CAGxU2F65wzpNJYgpjMbnc5iK8oNNsL3niF3pVmXhVU5PM34baA@mail.gmail.com>
 <CAJi--PNdP+OxT6XAE7fjp01o5nX-bZPjBMmuaONrg1Gn_65qQA@mail.gmail.com>
 <CAGxU2F5y5omgvSUV+JQCAsUQVSQVkdzXhsS5QYysETerDjVkdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4zTUmT6UpuYLZBuD"
Content-Disposition: inline
In-Reply-To: <CAGxU2F5y5omgvSUV+JQCAsUQVSQVkdzXhsS5QYysETerDjVkdA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--4zTUmT6UpuYLZBuD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 06:49:32PM +0200, Stefano Garzarella wrote:
> On Tue, 21 Apr 2026 at 18:06, Jorge Moreira <jemoreira@google.com> wrote:
> >
> > > Do you know other backends we should check?
> >
> > CrosVm's: https://github.com/google/crosvm/tree/main/devices/src/virtio=
/vhost_user_backend
>=20
> Which do exactly the same
> https://github.com/google/crosvm/blob/b49e336de56d6353ae06245de0c7fabec3d=
b2d5e/devices/src/virtio/vhost_user_backend/handler.rs#L596
>=20
> No?

To round this out, I looked at DPDK, one of the most popular vhost-user
back-end implementations.

The DPDK back-end starts/stops the rings in the vhost-user message
handler rather than upon reading the kick fd:
https://github.com/DPDK/dpdk/blob/main/lib/vhost/vhost_user.c#L3274

I think it would be nice to update the spec since it seems
implementations aren't actually waiting for the kick fd. However, it is
not central to the original discussion, so feel free to skip it if you
want.

Stefan

--4zTUmT6UpuYLZBuD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnn1qEACgkQnKSrs4Gr
c8hWNAf/abatDMDU8EqyiSojC//fSxC4xPiejn6aCDITvFVtL4dp1eoW4+hW4rxm
5y/NCph2jgNW0bI+O0B/Chjibm9uaWRUmtDUeLAnyNN8/tYJLT9Kv+io8VHD46fw
y7mGm08yq+/0/jFHwU+NG+jUT/cFjGn5UCHOfMOFzBA69XgQMCcJqcA1l0pMYun0
vlmKLZD0Di7V/vBg2v5uZQOSKF2kAkKWUcu6Y+ta/ldgi9fmYky1mC0/mtp9gTIB
oL1NmkKlRRuW/b2SeVASyis734bLBwxtL20qCnVCkTAE7wr06NRMRvUKkgaRnKfB
a1bWWILMgCAgUc3ZaOVhcQafJmT67Q==
=PJPM
-----END PGP SIGNATURE-----

--4zTUmT6UpuYLZBuD--


