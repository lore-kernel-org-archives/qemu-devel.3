Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F123DEFD210
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBHf-0002KN-3s; Wed, 25 Feb 2026 04:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvBHP-0002IO-IE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvBHL-0005Hl-Mh
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772012038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0clAZJTl2shOgEGG1XvRrxH6BNkbNFn2M4RdpEvsF9E=;
 b=IsQ9UYCuTiIVPgp4JpHiZ6z5GaCfQUZ9pxnBM7MadPkszxGZnEhhAxpvAz7z1C6UeMRi8A
 Ez8mKB76yB4aWN7hyqYCoLRSD93HDgbgp6S6J2pDZIlep+34T7HI7fSeaBxe0NCO+4cbOj
 Rrvc1EedE1fM3gqktgaZIFx5VVzA3SQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-mJIWLE42NN6Kn3PsioPaRw-1; Wed,
 25 Feb 2026 04:33:54 -0500
X-MC-Unique: mJIWLE42NN6Kn3PsioPaRw-1
X-Mimecast-MFC-AGG-ID: mJIWLE42NN6Kn3PsioPaRw_1772012034
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 676991955F3B; Wed, 25 Feb 2026 09:33:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 582571955F43; Wed, 25 Feb 2026 09:33:51 +0000 (UTC)
Date: Wed, 25 Feb 2026 17:33:49 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/4] aio-posix: enable IORING_SETUP_COOP_TASKRUN |
 IORING_SETUP_TASKRUN_FLAG
Message-ID: <20260225093349.GA1653802@fedora>
References: <20260225081336.1639325-1-stefanha@redhat.com>
 <20260225081336.1639325-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zimaJ5iwlIoeIkOO"
Content-Disposition: inline
In-Reply-To: <20260225081336.1639325-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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


--zimaJ5iwlIoeIkOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 04:13:35PM +0800, Stefan Hajnoczi wrote:
> The IORING_SETUP_COOP_TASKRUN flag reduces interprocessor interrupts
> when an io_uring event occurs on a different CPU. The idea is that the
> QEMU thread will wait for a CQE anyway, so there is no need to interrupt
> the CPU that it is on.
>=20
> The IORING_SETUP_TASKRUN_FLAG ensures that QEMU's io_uring CQ ring
> polling still works with COOP_TASKRUN. The kernel will set a flag in the
> SQ ring (this is not a typo, the flag is located in the SQ ring even
> though it pertains to the CQ ring) that can be polled from userspace.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Hi Jens,
I noticed liburing's io_uring_cq_ready() does not check the
IORING_SQ_TASKRUN flag. Maybe QEMU's fdmon_io_uring_gsource_check()
needs to check it here so that io_uring_enter(2) will be called with
IORING_ENTER_GETEVENTS in the glib event loop?

(This is a similar idea to your recent patch but needed when
IORING_SETUP_TASKRUN_FLAG is enabled.)

I tried to benchmark this but couldn't observe a difference in IOPS:

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 652d269e03..ef4257924b 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -356,7 +356,8 @@ static bool fdmon_io_uring_gsource_check(AioContext *ct=
x)
      * the main loop can miss completions and sleep in ppoll() until the
      * next timer fires.
      */
-    return io_uring_cq_ready(&ctx->fdmon_io_uring);
+    return io_uring_cq_ready(&ctx->fdmon_io_uring) ||
+           (IO_URING_READ_ONCE(*ctx->fdmon_io_uring.sq.kflags) & IORING_SQ=
_TASKRUN);
 }

 /* Dispatch CQE handlers that are ready */

--zimaJ5iwlIoeIkOO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmewf0ACgkQnKSrs4Gr
c8js8wf/SBVwExoSRqEB9D/yFxm2dUyui4SWKM9wA9odyplgdiYV1yrJS/lZ9tbp
S2d7zuKzOEaRjFWYwxQvwEqY8IX8iL2mz+dsM/gYSB6bw5CzH8rnoP3lsMEmXOOp
dpJOgwDXJ1ZXGz0O8lvE6Ck9YJ/HxuT4eLmkz45PVSwF5smaDHZIs/Rdfui4bHAT
npaCsMwVaWxlLpfuqYRZfxhUNQn/V3qPWwBIk7/2vrhfDUGb2mFcP4tnzhcBrz/H
U1hJWU8D7muw/fuKyy6uR8E7ZGa7VUWACn+GF02/t5fz5snAL4zGPMl5MUajejy2
XA/KZF5M+CCAFMYUOxpJ0BEepzXn1Q==
=/Zx8
-----END PGP SIGNATURE-----

--zimaJ5iwlIoeIkOO--


