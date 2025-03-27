Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AD9C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txogs-0000OC-2Q; Thu, 27 Mar 2025 10:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txogp-0000NL-RW
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txogo-0000xk-DV
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743087517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Co7/BkfzREiEGqat/M8uoLsQimdPPBKOnitp6q0GGaA=;
 b=MWauujMVeA2V3dHTMphuGPFMUYASlReft2kQB5DyX/wiRGK3Wd4seqxgjnfKbdh3t1Jsvs
 8iMaMLq8YEgyh683TFTYL/IGa5VU1qhb164sMOH9+A6WucGBONKz4sNJ84m1qHHzbyXdWy
 KT6HoDUJi5ZK613gd7wzieaw1hQ4/9k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-x8-kdy-XOgSzZuIAyfHVUA-1; Thu,
 27 Mar 2025 10:58:34 -0400
X-MC-Unique: x8-kdy-XOgSzZuIAyfHVUA-1
X-Mimecast-MFC-AGG-ID: x8-kdy-XOgSzZuIAyfHVUA_1743087513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC24D180049D; Thu, 27 Mar 2025 14:58:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6073130001A1; Thu, 27 Mar 2025 14:58:32 +0000 (UTC)
Date: Thu, 27 Mar 2025 10:58:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 06/15] fuse: Fix mount options
Message-ID: <20250327145831.GF37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jLEq2RzWW97G5dOw"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-5-hreitz@redhat.com>
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


--jLEq2RzWW97G5dOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:46PM +0100, Hanna Czenczek wrote:
> Since I actually took a look into how mounting with libfuse works[1], I
> now know that the FUSE mount options are not exactly standard mount
> system call options.  Specifically:
> - We should add "nosuid,nodev,noatime" because that is going to be
>   translated into the respective MS_ mount flags; and those flags make
>   sense for us.
> - We can set rw/ro to make the mount writable or not.  It makes sense to
>   set this flag to produce a better error message for read-only exports
>   (EROFS instead of EACCES).
>   This changes behavior as can be seen in iotest 308: It is no longer
>   possible to modify metadata of read-only exports.
>=20
> In addition, in the comment, we can note that the FUSE mount() system
> call actually expects some more parameters that we can omit because
> fusermount3 (i.e. libfuse) will figure them out by itself:
> - fd: /dev/fuse fd
> - rootmode: Inode mode of the root node
> - user_id/group_id: Mounter's UID/GID
>=20
> [1] It invokes fusermount3, an SUID libfuse helper program, which parses
>     and processes some mount options before actually invoking the
>     mount() system call.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c        | 14 +++++++++++---
>  tests/qemu-iotests/308     |  4 ++--
>  tests/qemu-iotests/308.out |  3 ++-
>  3 files changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jLEq2RzWW97G5dOw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflZ5cACgkQnKSrs4Gr
c8hvQQf/eS1UlkNP+sf9UtIBkzbUa0f+mfXiMIoKy8zi1wtsJIeJQ+8dOfqgLYTu
SMAyF5aH/md4rOv9NDFrLIodERmL4aE8ADUazFtpThaxi/Iqm0st6FM9A31EYdjG
WmOyE8iStL1sxX92u0x8mGlVXeddHIT/ylpWV6KhQMLPaDtXhGRgtS5/8kJpw4PQ
A7Skwngw265r26qkh5+JQDVCdfBU0MNYQXrjDyE2vPs4DmvnOcZlxecC0E42TeYx
/YokV+h3/zp28Ytp/h5voKJwIvmAODyODj0vAmYEKvRAtGxTWOM6zYvVZw3x1ERA
7A9R3+/YRzTtaXv3XJV1lyO3Pr2lGQ==
=yLOQ
-----END PGP SIGNATURE-----

--jLEq2RzWW97G5dOw--


