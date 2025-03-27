Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF25C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txorJ-0002nE-5p; Thu, 27 Mar 2025 11:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txorF-0002lp-6A
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txorC-0002Qs-0X
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743088159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P4udPMiKQtCEeWjCKY9oSrHgXovXsBCV4VlVbhdKBZo=;
 b=D/8cEwSpIHvGtN92pLJaQHYS+EvzFyQeOWpVwGxR/jeK/18Z5E7nRSYs3/u+ALMplqNmQE
 LGTbmDwVJawti5OnaK8MOMX/TbUJWoRH///IjMlL9kbES/awZt46Ssq0MI0oQtmiuo6rXy
 G1oyh/4si1WhcQbg8HlRxzFwMks8XeQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-swcFJ4XBPNCDgDx9kM_Jcw-1; Thu,
 27 Mar 2025 11:09:13 -0400
X-MC-Unique: swcFJ4XBPNCDgDx9kM_Jcw-1
X-Mimecast-MFC-AGG-ID: swcFJ4XBPNCDgDx9kM_Jcw_1743088152
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AE9E180035C; Thu, 27 Mar 2025 15:09:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE725192C7D7; Thu, 27 Mar 2025 15:09:11 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:09:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 07/15] fuse: Set direct_io and parallel_direct_writes
Message-ID: <20250327150909.GG37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-6-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zswM7nqzRXNUsW+L"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-6-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--zswM7nqzRXNUsW+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:47PM +0100, Hanna Czenczek wrote:
> In fuse_open(), set these flags:
> - direct_io: We probably actually don't want to have the host page cache
>   be used for our exports.  QEMU block exports are supposed to represent
>   the image as-is (and thus potentially changing).
>   This causes a change in iotest 308's reference output.
>=20
> - parallel_direct_writes: We can (now) cope with parallel writes, so we
>   should set this flag.  For some reason, it doesn't seem to make an
>   actual performance difference with libfuse, but it does make a
>   difference without it, so let's set it.
>   (See "fuse: Copy write buffer content before polling" for further
>   discussion.)
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c        | 2 ++
>  tests/qemu-iotests/308.out | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zswM7nqzRXNUsW+L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflahUACgkQnKSrs4Gr
c8htCggAms4k9WgmjwsQCuIqcAyZaWZmBtzv646ymcHKRhlTSPdNMpDHYDE9MSne
cLn6vVODmqKc8pcUe+Mdf6+S70s8naAEV/e6guy6VcUY0xpoq0p35n+WAAbOzAcq
ubN492ySFZTS5wWDcZ/kEla37ev70vud2vtrhxrCOrZsQDgnNbJApOau+MgnxK4/
8PTKhIaD8jVR3z5fomfnQtIk8R34Ybr5Oo48hhYSLyhjY/lKXm73zWbZQmpAFhSZ
2E2io9fag/klb9Wyc9FWM//MjToj0eKsZAFwurXOfu/mWR7heavuaqhx79SlnF+/
kSkuuLqoQkuX0aVFMvgGY/ZOyrCjJQ==
=qIAo
-----END PGP SIGNATURE-----

--zswM7nqzRXNUsW+L--


