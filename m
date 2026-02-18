Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DECE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 15:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsjvP-00034o-JD; Wed, 18 Feb 2026 10:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsjvM-00034d-Ub
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:57:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsjvK-00085B-Ur
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771430229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHPEd4ZGCCS4VRsexvLF3jlCkJFr9LgsQkWl7sCQ7tI=;
 b=ghcz4cPl7ZJ524DBxCCAqVfwHdnvrhUB2Nf6lWU5rpv4vrs5aXNOkmy/sY+YGa2sgUhK3P
 wEKDWdCWnSNmv6JS2y1x0gNdXYduH5KCZptsmI9quvubr8Mi+nO46NHp9Dv/WgvzOxYO8C
 rUxAK19eUc+xStc8MexwOMcLEx7Zcvs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-vrMRnQyKPYufVy4ke7iC6g-1; Wed,
 18 Feb 2026 10:57:05 -0500
X-MC-Unique: vrMRnQyKPYufVy4ke7iC6g-1
X-Mimecast-MFC-AGG-ID: vrMRnQyKPYufVy4ke7iC6g_1771430224
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F10B319772F8; Wed, 18 Feb 2026 15:56:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 507F91956095; Wed, 18 Feb 2026 15:56:46 +0000 (UTC)
Date: Wed, 18 Feb 2026 10:56:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, fam@euphon.net, f.ebner@proxmox.com
Subject: Re: [PATCH 1/2] fdmon-io_uring: notify main loop when SQEs are queued
Message-ID: <20260218155645.GA587447@fedora>
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-2-axboe@kernel.dk>
 <aY9Lj1BTVRCFyfic@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wQDz+gXlfEIO6rhs"
Content-Disposition: inline
In-Reply-To: <aY9Lj1BTVRCFyfic@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--wQDz+gXlfEIO6rhs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 05:04:31PM +0100, Kevin Wolf wrote:
> Am 13.02.2026 um 15:26 hat Jens Axboe geschrieben:
> > When a vCPU thread handles MMIO (holding BQL), aio_co_enter() runs the
> > block I/O coroutine inline on the vCPU thread because
> > qemu_get_current_aio_context() returns the main AioContext when BQL is
> > held. The coroutine calls luring_co_submit() which queues an SQE via
> > fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only happens
> > in gsource_prepare() on the main loop thread.
>=20
> Ouch! Yes, looks like we completely missed I/O submitted in vCPU threads
> in the recent changes (or I guess worker threads in theory, but I don't
> think there any that actually make use of aio_add_sqe()).

Worker threads don't have an AioContext, so they cannot call
aio_add_sqe().

Stefan

--wQDz+gXlfEIO6rhs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmV4TwACgkQnKSrs4Gr
c8gmGgf/eJ6ayH+F1bSXjposRX5K96cbx6UhH8bej9kIXfThRphFhRjn82MMnVP8
iQYsSRq+FQ6eOB5xRP4mX9GhVGDBcFom09QDt3AW+8+HKBSo2q6FUyFxPha7JyC6
j+tusMar+Ve/HeD6XdQsB4T/tuaD///q4Kg/hdlXMZ3QDUq+LeRY3ekFBCOmSqB9
5LzARLzV5LjHYOxkpbtag1KvUFOCnYtulsXx2LGltiehm6iheS3dcNoeo3wXKsUU
h/8Ilasy4V9jXsoWHYt7/FAhgjPtKakdsJlKMSqy6RzoCVXhyTvwVSWq73Dc0we3
TM/WyFxmEDL9f+753lh/cNWANkjPBw==
=s6ts
-----END PGP SIGNATURE-----

--wQDz+gXlfEIO6rhs--


