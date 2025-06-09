Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7596C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOgzT-0004Tv-BZ; Mon, 09 Jun 2025 14:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOgzN-0004RH-3D
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOgzL-0001yD-CQ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749492762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5N6p7qjhKBFxXAb7dlNih2Kt605S7+IPmS0G9hpypvQ=;
 b=KQmPTfzrLZVXjBPUufRLhxUEqCKIJrBDc4LMK7zby6BUGR7ZVoDkUF4RvqVeuknWcqfbMJ
 rKgav+5QE17HLbqKMYF2j+8FRQy4pVkojyxobgkWrwbM9x1PnaERo0x3Td19sSsQh9t5/u
 i6SDYewS5tKXe1lvjp3ppPw7Z9Qs/wg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-gNeUr1kZO2Kt7h4bJJpHBQ-1; Mon,
 09 Jun 2025 14:12:38 -0400
X-MC-Unique: gNeUr1kZO2Kt7h4bJJpHBQ-1
X-Mimecast-MFC-AGG-ID: gNeUr1kZO2Kt7h4bJJpHBQ_1749492757
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5500A1801BD8; Mon,  9 Jun 2025 18:12:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C58B8195608D; Mon,  9 Jun 2025 18:12:36 +0000 (UTC)
Date: Mon, 9 Jun 2025 14:12:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 20/21] iotests/308: Add multi-threading sanity test
Message-ID: <20250609181235.GK29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-21-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N4E0O6P6x9ERIXka"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-21-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--N4E0O6P6x9ERIXka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:28:12PM +0200, Hanna Czenczek wrote:
> Run qemu-img bench on a simple multi-threaded FUSE export to test that
> it works.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/308     | 51 ++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/308.out | 56 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--N4E0O6P6x9ERIXka
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhHJBMACgkQnKSrs4Gr
c8hpMgf6AjFClHmht+WUybC0veQl4OJGY/X5GNO48YjXvSQa1FBecRNg4UjUfnqB
SOlxsUF/fQue+nI2ighOeXi4zQi91vc5ryaLislGIdlWMko74yg1Enq1RA2YNuPT
6IkidSO8FUZCMedSuLSKuHlOaeaeeWeDcLPiefxB/xgnJJZIQvYHmXcKxqc5aw5L
o8KOmeG9YEV6jOrj441gi6z6rBE5jXdWXmzNx15epHYbg3iGyEfw9mFYyWCorIPH
o3hvBWDOvi/t2wLgT7zE8g3fbXkFhnLz0n1reeh7I/Klsq0DMeYvW8jHQwnDh6P4
TtJvuGc3a3ythCDBhM7GUejtCxvy3g==
=6DoP
-----END PGP SIGNATURE-----

--N4E0O6P6x9ERIXka--


