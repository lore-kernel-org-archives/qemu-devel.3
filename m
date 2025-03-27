Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF09C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoxY-0006DX-HB; Thu, 27 Mar 2025 11:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txoxN-0006C3-T5
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txoxL-0003ec-AE
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743088542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Thk88y6erEr4AK1UygtRKbPgcRfcwnG0JVQ/JvoL94Y=;
 b=h+rRWLD4+lROJa5SMiX2skiI0H9BSv1YPDHzaOhYeGkU4b/s8E2Ac2x9EZwznt2268j1ef
 OAiV0OxztPWav2bslryL/9s1cgxpHPPKLiIFQMKZm20V5Y/BJ8qi9qz0Thr2r+2AQfA8Bb
 NomeqO/1X25urkhTithf/eagHlEg/cc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-_rIXQvJVOHyPTfyBsDAXGQ-1; Thu,
 27 Mar 2025 11:15:38 -0400
X-MC-Unique: _rIXQvJVOHyPTfyBsDAXGQ-1
X-Mimecast-MFC-AGG-ID: _rIXQvJVOHyPTfyBsDAXGQ_1743088537
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1E5F18EBE8F; Thu, 27 Mar 2025 15:15:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67D8530001A1; Thu, 27 Mar 2025 15:15:37 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:15:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 10/15] fuse: Add halted flag
Message-ID: <20250327151536.GJ37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-9-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+ss1bv7OqIf6O+Xr"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-9-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--+ss1bv7OqIf6O+Xr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:50PM +0100, Hanna Czenczek wrote:
> This is a flag that we will want when processing FUSE requests
> ourselves: When the kernel sends us e.g. a truncated request (i.e. we
> receive less data than the request's indicated length), we cannot rely
> on subsequent data to be valid.  Then, we are going to set this flag,
> halting all FUSE request processing.
>=20
> We plan to only use this flag in cases that would effectively be kernel
> bugs.
>=20
> (Right now, the flag is unused because libfuse still does our request
> processing.)
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+ss1bv7OqIf6O+Xr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfla5gACgkQnKSrs4Gr
c8g2bAf/eecpB7rKiWIsxJKbVRqvIUNcgSJ+wsCgh7brnFVgrnXwNzIJxvAeC5pc
HlbUs1fLlkp4FO7aFRCfiVK+m4KDSuGKjVyCEruQK2twkMIeJ6Gm7GxSaMMKfklV
Y3Ktw4sM3Ir/l0EnvE4bpKxpA6yTW8TE83bfBB21+n0hsk65fKAOWE3fFbqHv9zS
74cy0EGqHAWgG6oMUGotSIGiREZYfAvM77RJnnAF7LGBdvCoQyJQIzUDJSWj8jin
ji7CDSZAKfcHyYgNJCoQ0X732tEpQLumzZ2G0KdiO39Xu8NGYhHj3TA15FrIrIJZ
qMqmsU1XJ7ymrz9abw6P9bHb7SrBxg==
=ed34
-----END PGP SIGNATURE-----

--+ss1bv7OqIf6O+Xr--


