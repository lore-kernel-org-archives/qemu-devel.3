Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DDAC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txovN-0004iI-Nv; Thu, 27 Mar 2025 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txovI-0004gL-N2
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txovG-00039l-Kx
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743088413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HALGRbcIvilTPhZHuPBukIe7uMLffB+rZlOxjH/Udwo=;
 b=BGmxpitqEW65DQaMO5sEuD6AOjpg9lU/usc1gyrC3NeR/73H8dNlpwOusp0sB917JyO6BA
 0GH2YtXMIrirn9E+PYOaFfnJ6p3ya0bCQ8LWt9LykjBxnfgJaci7DFnPAO8H8UE9g124zs
 66CTp0gkiJNA7cED2zCO8n9Xb79xSiU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-TPF60DOuOZiLXn2Z8NtEdg-1; Thu,
 27 Mar 2025 11:13:32 -0400
X-MC-Unique: TPF60DOuOZiLXn2Z8NtEdg-1
X-Mimecast-MFC-AGG-ID: TPF60DOuOZiLXn2Z8NtEdg_1743088411
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6017A180AF55; Thu, 27 Mar 2025 15:13:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D22CA30001A1; Thu, 27 Mar 2025 15:13:30 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:13:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 09/15] fuse: Introduce fuse_{inc,dec}_in_flight()
Message-ID: <20250327151329.GI37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-8-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ucUKzKvMRHspKP7g"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-8-hreitz@redhat.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ucUKzKvMRHspKP7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:49PM +0100, Hanna Czenczek wrote:
> This is how vduse-blk.c does it, and it does seem better to have
> dedicated functions for it.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ucUKzKvMRHspKP7g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflaxkACgkQnKSrs4Gr
c8gs9QgAinII9z8GJiAhu+O0CO/BLT5BGmGOM7AiND4sR4R2iz/RYFjRCVHZQRcv
Y5KZasEOsrcXXJ2hvWDb7XyS7KANORXBn4bQwS03qnREPsRKcW0WZoXXVXlhtV9j
OCgBRO/S9VIdpwKWvntUmMhHUqUUiq9YQSFU/9h8YrQLUdLb/xuxr9VTJZpg/H5t
dTEi2Q1Njd3Q3Ja44vNhd/QJYx2L5hWySwqJwl9x1BJm9hspxOeiGzDDzTbinaQ+
ECK1WIj/DMsGrsobJoFm2yejYzaDNPEIHQvBjS2VlvC0zLs1wDkOJYKvbMhmrM6v
PJdiJW/K7w6IldNbpBvRzAfCTAaxNw==
=0jCq
-----END PGP SIGNATURE-----

--ucUKzKvMRHspKP7g--


