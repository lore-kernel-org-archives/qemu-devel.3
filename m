Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A944C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmD8c-0005Ze-VF; Mon, 18 Mar 2024 09:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmD8X-0005YK-SY
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmD8V-0007OT-WF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710768882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0xFnVCfl9MWzspn5fY1/cewfW/JMRMMrbdvTBOCtTWA=;
 b=YC6vkxx8y83gkxvPBBjKiXB558Mdukibzd2pzUGSaEm+72DMvC4h857yAyzRMvKw0pDqJ2
 dYVchmP5LEKozutaFwb6X96xcwcSV++ij3Bfly0oLdKCe7xPxPlGe+SgrujqRduwkRUxQF
 uL24XSJXIeumcxuCAdblYjjdIVlWQWA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-uGWT5k2fMEyLz8je0HvplA-1; Mon,
 18 Mar 2024 09:34:38 -0400
X-MC-Unique: uGWT5k2fMEyLz8je0HvplA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F808285F9A3;
 Mon, 18 Mar 2024 13:34:38 +0000 (UTC)
Received: from localhost (unknown [10.39.194.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97A01492BC4;
 Mon, 18 Mar 2024 13:34:37 +0000 (UTC)
Date: Mon, 18 Mar 2024 09:28:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 aliang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0 0/2] nbd: Fix server crash on reset with iothreads
Message-ID: <20240318132836.GB908758@fedora>
References: <20240314165825.40261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PsVtNzOAO4/yBwgx"
Content-Disposition: inline
In-Reply-To: <20240314165825.40261-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--PsVtNzOAO4/yBwgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 05:58:23PM +0100, Kevin Wolf wrote:
> Kevin Wolf (2):
>   nbd/server: Fix race in draining the export
>   iotests: Add test for reset/AioContext switches with NBD exports
>=20
>  nbd/server.c                                  | 15 ++---
>  tests/qemu-iotests/tests/iothreads-nbd-export | 66 +++++++++++++++++++
>  .../tests/iothreads-nbd-export.out            | 19 ++++++
>  3 files changed, 92 insertions(+), 8 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/iothreads-nbd-export
>  create mode 100644 tests/qemu-iotests/tests/iothreads-nbd-export.out
>=20
> --=20
> 2.44.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PsVtNzOAO4/yBwgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX4QYMACgkQnKSrs4Gr
c8iSSAgAyRhOU4cHEpLdoDvLJlCuznBTZJVWvSMZRss3dhkqb+rKMlgGDKSKcjJx
LTdy3cHISlghHuZzPBFzkvfx/Wp76v2cYbdyT058nV1Hb/9cNahSw8wSAZvurau3
8bUSepocWDflGT63aXw9/74qJWCkmB8aOMzrh7q44yKJDaO2jRTZqLq/IwOj1gbo
QqKz4h2j9TxXAoZOV6AhUHDb0TY3EKS1Dmmq5IIPmp62Z2KeZNabETsaztM6M0+S
tkQSBTyPAGZA1/BnG1EMVI1S5d2tveFuU6BVMzxUjzn9wUHbsgjRAgOHGFN+oAnX
xj6s4rlkS7vGXVEgo7G6UEIxzuL9YA==
=/9/t
-----END PGP SIGNATURE-----

--PsVtNzOAO4/yBwgx--


