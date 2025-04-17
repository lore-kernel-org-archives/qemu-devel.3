Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD45CC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5W4n-0001Bw-Dx; Thu, 17 Apr 2025 16:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5W4i-0001BM-Jd
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5W4g-0005jX-EE
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744922585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IM6oBhdbly2ZbAwLQaOv68tPhbTFfV9Er8VWK51lPBE=;
 b=FxIQeJDBneMCRQ9jgweKH1gkYHMWKoep3nsHh6WyFePL0lLpp4hjP7kkIF10I3GVun0KqG
 J4dlZ5mGGFJ5N0m/BgX3k09A55aBeg+YrNymJnaAQqDS+45bn7AbyHy9WKG8bS29Jk1HBs
 1joFCnVbfxV/Go0hXW8M3gkCKT3r/2o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-9ppgBuRFO1OjyhNodnv6pg-1; Thu,
 17 Apr 2025 16:43:01 -0400
X-MC-Unique: 9ppgBuRFO1OjyhNodnv6pg-1
X-Mimecast-MFC-AGG-ID: 9ppgBuRFO1OjyhNodnv6pg_1744922580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91CB5195609F; Thu, 17 Apr 2025 20:43:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA01230002C2; Thu, 17 Apr 2025 20:42:59 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:42:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 06/11] mirror: Minor refactoring
Message-ID: <20250417204258.GE85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-19-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F6ol0q2B0aeeelG1"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-19-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--F6ol0q2B0aeeelG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:11PM -0500, Eric Blake wrote:
> Commit 5791ba52 (v9.2) pre-initialized ret in mirror_dirty_init to
> silence a false positive compiler warning, even though in all code
> paths where ret is used, it was guaranteed to be reassigned
> beforehand.  But since the function returns -errno, and -1 is not
> always the right errno, it's better to initialize to -EIO.
>=20
> An upcoming patch wants to track two bitmaps in
> do_sync_target_write(); this will be easier if the current variables
> related to the dirty bitmap are renamed.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/mirror.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--F6ol0q2B0aeeelG1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBZ9IACgkQnKSrs4Gr
c8j3HQf/cIiPKSfOQFZrZRKDnualgPLApc+BMlTFA94tuVWl/VcUGU2elgicE2oy
GUNUwL8IgMXFpaLwIQyQRNaxVuVUhjY7JKoRbjLFBw7fG+VBrwEb0EV4CHeoCZb1
SHr+DBUgTUe/IwRSDafQsd2asLVNah+HVkTquzpKGo2UVJVQ6OBx3SwXw4O38+2o
tZ3iQyMPvNTcBhQHaWjEmd55H7KLHWofBTgUA+RnF7tSqIMa7yGXaH8cUbymL+Sy
0wuQxVxyz6R4YFFuc8DkhWkGff5Qi0KmD3pnJGBLhFuMs85uo2siKi5+wkrrxUNu
2rSVVWGytOv3j2JVGyo0MRc0FNaYNg==
=AWzA
-----END PGP SIGNATURE-----

--F6ol0q2B0aeeelG1--


