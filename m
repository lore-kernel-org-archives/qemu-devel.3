Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D087C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traav-0003Au-Rh; Mon, 10 Mar 2025 06:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1traau-0003AZ-G1
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1traat-00040x-2Q
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741603366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u8msCwZvVAnTLAhYTTjqnE1Q1SMJj0JDDXoLv6QBdAk=;
 b=crpIGfZfiEdwN3MK2N9d0U6E9+yJWkCO+x5DHHOS6gQVLT1vhE0SFA6Ah1JSwSBjKl/Pp9
 Ot7bFEbkBZXk/OCkLVxbDPtRFJzeF6TAFAR/5aWgKXOUSr9J+BBqCjah2dvt64xbAup0zL
 RcTLZsr0bIU1nR/FrhbmLq/Isp1zZPQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-qGtXyHd_P_uYHIFtIYdvXQ-1; Mon,
 10 Mar 2025 06:42:44 -0400
X-MC-Unique: qGtXyHd_P_uYHIFtIYdvXQ-1
X-Mimecast-MFC-AGG-ID: qGtXyHd_P_uYHIFtIYdvXQ_1741603363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D6AA19560A1; Mon, 10 Mar 2025 10:42:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CA641800366; Mon, 10 Mar 2025 10:42:41 +0000 (UTC)
Date: Mon, 10 Mar 2025 18:42:39 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] block/io: Ignore FUA with cache.no-flush=on
Message-ID: <20250310104239.GB359802@fedora>
References: <20250307221634.71951-1-kwolf@redhat.com>
 <20250307221634.71951-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qsS913IkBXkuEdEQ"
Content-Disposition: inline
In-Reply-To: <20250307221634.71951-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--qsS913IkBXkuEdEQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 11:16:31PM +0100, Kevin Wolf wrote:
> For block drivers that don't advertise FUA support, we already call
> bdrv_co_flush(), which considers BDRV_O_NO_FLUSH. However, drivers that
> do support FUA still see the FUA flag with BDRV_O_NO_FLUSH and get the
> associated performance penalty that cache.no-flush=3Don was supposed to
> avoid.
>=20
> Clear FUA for write requests if BDRV_O_NO_FLUSH is set.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qsS913IkBXkuEdEQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfOwh8ACgkQnKSrs4Gr
c8hD2QgAkDYouRvufFeZtfZTsLXvYarjDb+wCkex9HxoUQm0l1sLXjwGIz872tCH
xv4UFXpscYCrCxu5+FsLzJuoSwYPBD4f9PqLfwxr9k92BI4zdJD33VMdhnwCfih5
cWCEj9RZSO3cs0PXWnsyBdHE+gk9o+Jzpv64+yG4pE8i9i9wXb1CYvPKgwvcaDpq
WtpWtsArZex1d0IXx31OawGYrksjn7oUDatW99ptfe75awdchgCeM+Ox2AY7144s
OqNS2jSmL5CCHOAsZ+TT8hejDRJVSz7xLTLBJxja9o9fyIP9ChzFGAMqTP0Gc2pY
cNrWSgoYJxFZsal59dwY2vj0gUd2KQ==
=KUAy
-----END PGP SIGNATURE-----

--qsS913IkBXkuEdEQ--


