Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D07C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlsBy-0000Ui-Vr; Mon, 20 Jul 2026 13:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlsBw-0000MF-V6
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlsBu-0004Cb-Oh
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784570049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cK7ZZ/BScUKpnlmdOTRjAl/kvtXn7rIhrgA5SKRDWzg=;
 b=JGNeZOlakO4rIeCv4UFMyRNJsZoXukgJ/V5MLo45C0KA17kR8cQ36GePdffV4KEzpd1Qtz
 7HysQQxdeMsbcT5Wzz/XOeUpCH20d/RuO4AONndEyQw6WLbwB4xQikXdUjVssi163npmET
 WyGZuQjTcrKA4t8vRSUdUAlBjz0stLE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-k4vJYB0kNnmfM3IQu3f7Mg-1; Mon,
 20 Jul 2026 13:54:05 -0400
X-MC-Unique: k4vJYB0kNnmfM3IQu3f7Mg-1
X-Mimecast-MFC-AGG-ID: k4vJYB0kNnmfM3IQu3f7Mg_1784570044
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 317691953988; Mon, 20 Jul 2026 17:54:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.104])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD12E195422E; Mon, 20 Jul 2026 17:54:03 +0000 (UTC)
Date: Mon, 20 Jul 2026 13:54:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] iotests/108: avoid leaking FUSE mount
Message-ID: <20260720175402.GA67869@fedora>
References: <20260611125438.194479-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KAQe0kP0+dxUCu0w"
Content-Disposition: inline
In-Reply-To: <20260611125438.194479-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--KAQe0kP0+dxUCu0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 08:54:38AM -0400, Stefan Hajnoczi wrote:
> The QEMU s390x CI gitlab-runner recently broke because qemu-iotests 108
> FUSE mount leaked and prevented the setup of the gitlab-runner
> environment:
>=20
>   chmod: cannot access '/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-proje=
ct/qemu/build/scratch/qcow2-file-108/fuse-export': Transport endpoint is no=
t connected
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/14796143507#L11
>=20
> Always umount the FUSE export when cleaning up to prevent the leak.
>=20
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3541
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/108 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--KAQe0kP0+dxUCu0w
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpeYLoACgkQnKSrs4Gr
c8gVKAgAyv6FEJUSuGKebL0vSnPYW2wGig0oFMkokpYrOOj4xPugPc+18+MiDS/6
UqmWFwkuUo673+OryOB5B8K8Ls9lI3HbyAdc7g5k8ep+qMkaRfOBDoX7MDpv2pah
YiCwgnB91PBNGkw5ZLd9JhNaEOhiz+wZIJj3ibkdlLfz9HbhN36gM4wb7yDB2IDd
i6aY++Yn4pTZ/d5q/YlAJbIRdc0+/lBJxpR0nOCiXcKeAH2M9IpOzw0oWAXPaAhG
XJfwxHWH6CMp6BCHRrrw49dTaO/Q+iYa3/PYwzqOgaoI6NVHHipbAhY4LN4eMepe
Em+/dalZ+ojNrQFRKiHzid0I/IdGOw==
=XliX
-----END PGP SIGNATURE-----

--KAQe0kP0+dxUCu0w--


