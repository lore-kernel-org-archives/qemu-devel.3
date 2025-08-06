Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A561C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1v5-0007I6-Ll; Thu, 07 Aug 2025 10:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk1v2-00079P-EC
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk1uz-0002ZE-0V
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754578110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysT8MU9AF31vkeEwfQ6HxOO/mP9++JBcUib7zXCTAVo=;
 b=SF4o/BwPWotVxhjkb72GKnbUCk9003ry+uucQfrxLXSHfs3ROjlKB8qMuo/1ddGfljlc5X
 3HnS6teaWosKOwXkcF0C4wzWwDiY3ULt9o7rL2uIDbMPtAiRLOm7RfeXtZ/JLRfAuCi2M9
 lHoPznw6U15rG7EW4m5Sn2KOQz37SSQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-Aq1QZt8lO_KFqxKI8tgN8g-1; Thu,
 07 Aug 2025 10:48:23 -0400
X-MC-Unique: Aq1QZt8lO_KFqxKI8tgN8g-1
X-Mimecast-MFC-AGG-ID: Aq1QZt8lO_KFqxKI8tgN8g_1754578089
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CCBC18004D4; Thu,  7 Aug 2025 14:48:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.191])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9D67180035C; Thu,  7 Aug 2025 14:48:06 +0000 (UTC)
Date: Wed, 6 Aug 2025 12:56:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH trivial] tests/qemu-iotests/tests/mirror-sparse: actually
 require O_DIRECT
Message-ID: <20250806165634.GC51368@fedora>
References: <20250806075635.3290-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b7AolTyeASpm/hW9"
Content-Disposition: inline
In-Reply-To: <20250806075635.3290-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--b7AolTyeASpm/hW9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 10:56:31AM +0300, Michael Tokarev wrote:
> Commit c0ddcb2cbc146e introduced the test which uses cache=3Ddirect
> mode, without checking if the scratch filesystem supports O_DIRECT.
> A subsequent commit, afeb002e0ad49d, tried to fix that issue, but
> instead of checking for o_direct, it checked for
> `_supported_cache_modes none directsync`, which is not what the
> original mirror-sparse test uses.  Fix both by actually checking
> for o_direct.
>=20
> Fixes: c0ddcb2cbc146e "tests: Add iotest mirror-sparse for recent patches"
> Fixes: afeb002e0ad49d "tests/qemu-iotests/tests/mirror-sparse: skip if O_=
DIRECT is not supported"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> This is what happens when rushing for last-minute
> pre-release fixes..  I'm sorry for this.
>=20
>  tests/qemu-iotests/tests/mirror-sparse | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please include this in a pull request for QEMU v10.1.0-rc3. Thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--b7AolTyeASpm/hW9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiTiUIACgkQnKSrs4Gr
c8j+fgf/a5//Dw5Oo+WWm1NPqUZzkxtzBsrLrVKCy0uyRuDuMQ81gN7XYL+c6uxs
H/0OIO0r3Chqv8Z7QVVb4Eh4WszWZIuebShi8DN1tqOYkyLDEwBWc+YtZDNUjuPx
Fsv4gLGKSBLdChNoK4k9lwlQ93maV9QAFhQ+mlbxvQ4W3xqiarGoNOgaE0BkmNFE
l08HOWDim+xx8yASfeA9uHWhDWDqq1zGSAgNIjIS7+zVNyjS8kdKv1JtIJIGGMM3
Tbaob8CsJHdnUE/AjAUcjZh5jb6bDjxM0KETrYHG9q25XAGOJ9QqOGP520V/o0aL
mSDw3Rv/SCtjr8FBRIYsO4b/usQNWA==
=qtbB
-----END PGP SIGNATURE-----

--b7AolTyeASpm/hW9--


