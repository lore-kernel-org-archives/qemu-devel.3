Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE54C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WFy-0004Cm-Pb; Thu, 17 Apr 2025 16:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WFr-00048Y-R6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WFq-0007x9-2n
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744923277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9I5y8wdSZnY5u744I96ti0yfp5de6MGaqJ1JgZBz12k=;
 b=JERB1svfsl2kSj8VRIb7pRa6LOXSwYm6Jiyu2PX/eMYojndArMhWs94PpDWqm4mrV1eCy/
 EOwRXv0r0di15M7ZbkzEe6/VVi4TT5HSoM4pqshRJPUg2fVhTgv1VkhlozFQVjUO0aM3Fw
 0AnHmhcxp2XUrRdaealPjQXr/tG4Ya4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-gKG6zq9WPxi9nWOulH-2eA-1; Thu,
 17 Apr 2025 16:54:35 -0400
X-MC-Unique: gKG6zq9WPxi9nWOulH-2eA-1
X-Mimecast-MFC-AGG-ID: gKG6zq9WPxi9nWOulH-2eA_1744923274
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC08F1956086; Thu, 17 Apr 2025 20:54:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76DE71954B00; Thu, 17 Apr 2025 20:54:32 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:54:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 09/11] iotests/common.rc: add disk_usage function
Message-ID: <20250417205431.GH85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-22-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bfZ1RRbqfpXaHPeQ"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-22-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--bfZ1RRbqfpXaHPeQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:14PM -0500, Eric Blake wrote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>=20
> Move the definition from iotests/250 to common.rc.  This is used to
> detect real disk usage of sparse files.  In particular, we want to use
> it for checking subclusters-based discards.
>=20
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Message-ID: <20240913163942.423050-6-andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 6 ++++++
>  tests/qemu-iotests/250       | 5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bfZ1RRbqfpXaHPeQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBaocACgkQnKSrs4Gr
c8gMbQf/SRkSw212HeQ6UVd0FAdnSTR/5lshgC0aC9KDrmnnKHgmIr3cci3pZqdt
d65lOH285jzMqsByiRg809fUWS2Ll1v8YG5T03LrBHMxmGvqlCtgLr3Cuwua+J+c
7pGcIXJ+gZq4tGuBnQUqZtzKaoItGtzrWkWoyYefLrAsTT8NAYl+eNvDdgeqYzfU
iflH0X1ctZyjAKaIBWYhWo3x/jCV49XdFWvMUrvkKXF/n6iskjI0KPb/8VyjnUIG
5PY44qpFr0UQvSqvWUFu0f3TBNur2t+Uz/zdnBu9HpGLQP2KRtzfdbiVKMMSWd+T
kFI/gdWhqNeODZCa81FkGQ/I73HgxA==
=+34c
-----END PGP SIGNATURE-----

--bfZ1RRbqfpXaHPeQ--


