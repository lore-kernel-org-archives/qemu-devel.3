Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26C9C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA9Ye-0001Za-TG; Wed, 30 Apr 2025 11:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uA9YH-0001Ur-TG
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uA9YF-0000KJ-TR
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746027645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uR4VQpFdMZHzBhMx2zPsG4gB/Vh9PWvOzpFkxqD6GIw=;
 b=X+i7umGQBj3pGd0Y0xRKGeS0kfoiNKiEkvz7JcK2vXxXx07FQ8J1x4fUBI1x4ej4cMMDMO
 vtd17jGrKp/gcb9LkR40ZiB9ty2BKZNUxUavnqmw8e4NdT3h/yecbGlPEWdo1pZ7aIJhi6
 acHaEwhqbz17Svv3wYzOyjabk0dlhw8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-V4wUTwY1OfemsAk-ctZuAg-1; Wed,
 30 Apr 2025 11:40:41 -0400
X-MC-Unique: V4wUTwY1OfemsAk-ctZuAg-1
X-Mimecast-MFC-AGG-ID: V4wUTwY1OfemsAk-ctZuAg_1746027640
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0617F1956088; Wed, 30 Apr 2025 15:40:40 +0000 (UTC)
Received: from localhost (unknown [10.2.17.53])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BC5A19560A3; Wed, 30 Apr 2025 15:40:39 +0000 (UTC)
Date: Wed, 30 Apr 2025 11:40:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Fix crash on discard_granularity == 0
Message-ID: <20250430154038.GB56296@fedora>
References: <20250429155654.102735-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QUiktVEaVinzyY9a"
Content-Disposition: inline
In-Reply-To: <20250429155654.102735-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--QUiktVEaVinzyY9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 05:56:54PM +0200, Kevin Wolf wrote:
> Block devices that don't support discard have a discard_granularity of
> 0. Currently, this results in a division by zero when we try to make
> sure that it's a multiple of request_alignment. Only try to update
> bs->bl.pdiscard_alignment when we got a non-zero discard_granularity
> from sysfs.
>=20
> Fixes: f605796aae4 ('file-posix: probe discard alignment on Linux block d=
evices')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--QUiktVEaVinzyY9a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgSRHYACgkQnKSrs4Gr
c8hDiQf/XN5lASSSho/0wcz8wHHOivp6sjQwpBrcs1k72UgP4LzdPB+wAAj40Syf
oI6ZvvnjfjmusEhs31eB+zNAT80H2q2Ug5S96SFtkTrVoUN1SGQWy5osqXzX9I99
/ftpKL9CUq+CGZqAN+sd2lANj+6mXOxJFX0DvSLoRZKvhP5ue+jUt6NDpo51Ney2
CJRrVwT0fqPyV08nRBXkdGankMhi32K9BiI6K6RkJkGPBqZ6XTx7cBk7gYJXptGV
q96eQOkiHJOQjCeA5clcXEY9bEwi4CGQLXQDfngrwYN3GxbNs600+vJQ8MM2SeZP
MJPoXpXGDdw5bUCjWH8VMd+fRakm+A==
=KCoT
-----END PGP SIGNATURE-----

--QUiktVEaVinzyY9a--


