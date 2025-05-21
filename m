Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDC1C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHkvR-0000S4-VN; Wed, 21 May 2025 11:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHkvQ-0000Rm-FU
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHkvO-00086Z-Eu
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747839602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2+bUudZFD/KWZPaaRBq48VIcumxCnQ4DIOfBfdqdho=;
 b=a/uRsF26OTRrHsN13s6eugq9F+5gGIQcYSqMczl0xQWJTL33Eb9ixsljY1Nt7UMO/Vsmk2
 78vgrncYs/s9NHJDEXsTyUvU0pmeG13IkLlQVUTuS/an7zvSXGcV5CFiYd598xKvn/qCAV
 sRDKjA582SzS2ztuPtkj3grlXwCsxVo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-ae9Wc7B8PkyaX36vFG8mkA-1; Wed,
 21 May 2025 10:59:58 -0400
X-MC-Unique: ae9Wc7B8PkyaX36vFG8mkA-1
X-Mimecast-MFC-AGG-ID: ae9Wc7B8PkyaX36vFG8mkA_1747839597
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ABE419560B2; Wed, 21 May 2025 14:59:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.85])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C27030002C9; Wed, 21 May 2025 14:59:56 +0000 (UTC)
Date: Wed, 21 May 2025 10:59:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 1/4] docs/about: Belatedly document tightening of QMP
 device_add checking
Message-ID: <20250521145955.GB120766@fedora>
References: <20250521063711.29840-1-armbru@redhat.com>
 <20250521063711.29840-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZaZbMlMr8Q9GKG/A"
Content-Disposition: inline
In-Reply-To: <20250521063711.29840-2-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--ZaZbMlMr8Q9GKG/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 08:37:08AM +0200, Markus Armbruster wrote:
> Commit 4d8b0f0a9536 (v6.2.0) deprecate incorrectly typed device_add
> arguments.  Commit be93fd53723c (qdev-monitor: avoid QemuOpts in QMP
> device_add) fixed them for v9.2.0, but neglected to update
> documentation.  Do that now.
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/about/deprecated.rst       | 14 --------------
>  docs/about/removed-features.rst |  9 +++++++++
>  2 files changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZaZbMlMr8Q9GKG/A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgt6msACgkQnKSrs4Gr
c8ihQQgAk5osYMFSyyiA9blV5N0e0fjSwnJRbvTYuopgYQA6QiwN3Ja7E1AZgq+t
KnZTLPV+bOS/TneE0RjO43kfjRUUISC489pdUrDyEEnw1I357rK9PgHxZUCtgWLi
g/Ed1Pg6nXlJ4JjVq04c8SHQpxB0P2pSRVYRXNyW71RLiyQcXNCcXjx+k6I6UR9m
wLVzT2zF7gQSoN/MX90gP5/cpS69YelARPa9w3KtYrTm99OWszj6yAVsxpb1UsaR
5Z8j6W5O0/mByaFKzKnKtdRi+FkH+8nhoh/d3bFKvLCzoZ7OENVa41sDSV5g0PeK
u92gC+7tUoeUNleW/bk6wfMy5bhScQ==
=j+m5
-----END PGP SIGNATURE-----

--ZaZbMlMr8Q9GKG/A--


