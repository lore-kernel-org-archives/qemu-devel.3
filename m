Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06CAEEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbp1-00042P-0H; Thu, 12 Feb 2026 13:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbov-0003z3-RY
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbou-0004BZ-DF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2LNQx2oHx8j+kjlw1YUed5BZ6izs6nZlyAKitsKwZtY=;
 b=RVuvugRS3AcdtZci544iOih7zWihReH+b70KoR9yN48rTc891DLWQE3GqR93q4R9oYaBEw
 Cq0phykiLm5KAYt1wPistWIBOxgToWLl+pLdPDwtgQsMN8Qw+xbAIfBo41DSRKYOPK0A0n
 LSBAlWL7qWgnwM4t4k5bRU5DXTnvTaY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-JjKt5VNROUiumIsj7NdhfA-1; Thu,
 12 Feb 2026 13:53:38 -0500
X-MC-Unique: JjKt5VNROUiumIsj7NdhfA-1
X-Mimecast-MFC-AGG-ID: JjKt5VNROUiumIsj7NdhfA_1770922417
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CB431800464; Thu, 12 Feb 2026 18:53:37 +0000 (UTC)
Received: from localhost (unknown [10.2.17.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DE7B1800352; Thu, 12 Feb 2026 18:53:36 +0000 (UTC)
Date: Wed, 11 Feb 2026 16:53:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, bernd@bsbernd.com
Subject: Re: [Patch v4 7/7] fuse: add io_uring test support
Message-ID: <20260211215359.GF234157@fedora>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-8-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4g0VCOkKxzK5UWEq"
Content-Disposition: inline
In-Reply-To: <20260207120901.17222-8-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--4g0VCOkKxzK5UWEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 08:09:01PM +0800, Brian Song wrote:
> This patch adds support for testing FUSE-over-io_uring. It can be
> enabled by setting the environment variable FUSE_OVER_IO_URING=3D1.
>=20
>     $ FUSE_OVER_IO_URING=3D1 ./check -fuse
>=20
> Additionally, the unmount detection logic is switched from `df` to
> `mount`. Using `df` triggers `statfs()`, which attempts to communicate
> with the FUSE daemon. During test teardown (when the daemon is being
> killed), this often fails or returns stale data, causing the test to
> misjudge the mount status.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  tests/qemu-iotests/check     |  2 ++
>  tests/qemu-iotests/common.rc | 47 +++++++++++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4g0VCOkKxzK5UWEq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmM+ncACgkQnKSrs4Gr
c8gzAAgAmd11jUYOBDYHtbnpXyO12fdIEblTTZJeGBXQ8tEAFBk/9v5Ers+d2u8P
VU9PauatJKSsCTvsBSv8LhMjvtFUPpmtFj29ougLMci5twkPvPIzLhaYN/Ma82eY
woBz1DwqtqCbATnVYnCpaalnNYHFW0PLFRs0XP/M+WUlUj2vluZOKrboree0XTZJ
cHGViLjrWsNYlvyJ2HbctCKEM4k6rVZUCxL6j4qlTkufgkNkkkp9ZEDjkKDpOUm5
ELLlk7fUi9mCrY+Qd/BRuJiEktGqKbQ/nY7yHgoNbg78zc8QiZjBy8S3JQrgG1MJ
3wZslYd1id+1NJRTahCFq+ESXwRgkw==
=wyof
-----END PGP SIGNATURE-----

--4g0VCOkKxzK5UWEq--


