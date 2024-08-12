Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8669C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 15:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdXBW-00077m-5e; Mon, 12 Aug 2024 11:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdXBU-000778-9F
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdXBO-0002Xq-3h
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723477325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dcc7xznDVu0xtVlEsjSVnh2UxWOWqpDQ4Gl7++J9Bb8=;
 b=eElBp12PrIXBbHOh3fGb71tdGyEIeBtTOpnuYYfEhYO2Pa+FDFALcWM0n5lBcSKiuHm0wK
 7uOPL5tut9MZI5BGe74oXoTAg5oq9bRtinyC7Mv2Hnu+VYNwZOm1oq+NWRH7FCLjOEaHcb
 pCOEh1ZBIdhjlZndbs0POh7GDsLpPGM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-vJdHMbq_PBCZ3kAGtrgYmg-1; Mon,
 12 Aug 2024 11:42:03 -0400
X-MC-Unique: vJdHMbq_PBCZ3kAGtrgYmg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 542F118EB222; Mon, 12 Aug 2024 15:42:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A07319560A3; Mon, 12 Aug 2024 15:41:59 +0000 (UTC)
Date: Mon, 12 Aug 2024 11:41:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] block/blkio: use FUA flag on write zeroes only if
 supported
Message-ID: <20240812154158.GA69160@fedora.redhat.com>
References: <20240808080545.40744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p5BcWXyBVGWj3Gvo"
Content-Disposition: inline
In-Reply-To: <20240808080545.40744-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--p5BcWXyBVGWj3Gvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 10:05:45AM +0200, Stefano Garzarella wrote:
> libblkio supports BLKIO_REQ_FUA with write zeros requests only since
> version 1.4.0, so let's inform the block layer that the blkio driver
> supports it only in this case. Otherwise we can have runtime errors
> as reported in https://issues.redhat.com/browse/RHEL-32878
>=20
> Fixes: fd66dbd424 ("blkio: add libblkio block driver")
> Cc: qemu-stable@nongnu.org
> Buglink: https://issues.redhat.com/browse/RHEL-32878
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  meson.build   | 2 ++
>  block/blkio.c | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--p5BcWXyBVGWj3Gvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAma6LUYACgkQnKSrs4Gr
c8jSZwf9GQUGmqOikQfErIUuhRJ0ZlY4IiqPZXy9R7pzT/C824FlnhLYeu2EFS8J
Tnp05bWO5pbNdyIrETw7HWsAK0Jyz79rXDGcmmA6iDSmo7dhHzK7J2wxlmcCG5cb
osoRoXbGgKaBWt4RRLsF02/zD8tLn1iACEF3gOaP5uKujI5JYJVr2KduDW769fhT
Sp3KbaiUiMGW6G8hwaO704QzsvF3HHjI6Eu2OSZx+GbQiQj9GYJ5Xu2JRYDLKfi9
XbspWkgbr92Mzx7usK6jcTO/G9BA48S1ug2aEzV6D4WG8bRAdlqVYep+xEot/PLy
eDISsqxun8HJjvIv61iFGGt2/vuq+A==
=B6OI
-----END PGP SIGNATURE-----

--p5BcWXyBVGWj3Gvo--


