Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ACFC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 20:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roqfR-0005WQ-1q; Mon, 25 Mar 2024 16:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqfM-0005VW-6F
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqfK-0008Mv-Qf
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711397490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gd0zfUiNkTXQQQm0RoaqRI8yktkS9MRpro6pwekOP/U=;
 b=P+IK+wn83M9Qo3PnauqVsS0Nari2bQZPCU9ydYNey37U8mdLTjjFvUXSXbgj9PFD27XKP1
 fIEXEy4DiN3hKmc7V4rM3coGIBm/EqPmpn4xjTpPoHvjsWUJM31KAjinDBajKLE8Tshz8R
 BmfWNRGx9KKjcbUk7rmHmoWKinKMvY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-6mol4j2qPl6qHUNUcP_QWQ-1; Mon, 25 Mar 2024 16:11:24 -0400
X-MC-Unique: 6mol4j2qPl6qHUNUcP_QWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F60B101A523;
 Mon, 25 Mar 2024 20:11:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86FD2112132A;
 Mon, 25 Mar 2024 20:11:22 +0000 (UTC)
Date: Mon, 25 Mar 2024 16:11:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 0/4] fix two edge cases related to stream block jobs
Message-ID: <20240325201116.GE1944176@fedora>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HCxIsSCM8UjdhEUM"
Content-Disposition: inline
In-Reply-To: <20240322095009.346989-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--HCxIsSCM8UjdhEUM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:50:05AM +0100, Fiona Ebner wrote:
> Changes in v3:
>     * Also deal with edge case in bdrv_next_cleanup(). Haven't run
>       into an actual issue there, but at least the caller in
>       migration/block.c uses bdrv_nb_sectors() which, while not a
>       coroutine wrapper itself (it's written manually), may call
>       bdrv_refresh_total_sectors(), which is a generated coroutine
>       wrapper, so AFAIU, the block graph can change during that call.
>       And even without that, it's just better to be more consistent
>       with bdrv_next().
>=20
> Changes in v2:
>     * Ran into another issue while writing the IO test Stefan wanted
>       to have (good call :)), so include a fix for that and add the
>       test. I didn't notice during manual testing, because I hadn't
>       used a scripted QMP 'quit', so there was no race.
>=20
> Fiona Ebner (3):
>   block-backend: fix edge case in bdrv_next() where BDS associated to BB
>     changes
>   block-backend: fix edge case in bdrv_next_cleanup() where BDS
>     associated to BB changes
>   iotests: add test for stream job with an unaligned prefetch read
>=20
> Stefan Reiter (1):
>   block/io: accept NULL qiov in bdrv_pad_request
>=20
>  block/block-backend.c                         | 18 ++--
>  block/io.c                                    | 31 ++++---
>  .../tests/stream-unaligned-prefetch           | 86 +++++++++++++++++++
>  .../tests/stream-unaligned-prefetch.out       |  5 ++
>  4 files changed, 117 insertions(+), 23 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/stream-unaligned-prefetch
>  create mode 100644 tests/qemu-iotests/tests/stream-unaligned-prefetch.out

Looks good to me. I will wait until Thursday before merging in case
Hanna, Vladimir, or Kevin have comments. Thanks!

Stefan

--HCxIsSCM8UjdhEUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYB2mQACgkQnKSrs4Gr
c8i46Qf8Cy7+/fkNyP1UaliDUxPFJc6QWGI0k6Mh93MExsw2eMGwLEAilZcNr5AE
/zVrfkt5Uo5Bx99UL7wseZQPfiLH+8jbcwcxjmICdlHh9JLSqfe1nCiIjwGzF/gk
++l0lTuXA0dmIL8/G2DT6bECpqTsifv6qFrTlC09Gw8aQzmJ5SzvTLEk3MqGc+ez
iXB+QL6NsO7ulV9XM5kM5vo+aldjsSUk7LMJm+LONAkfUdcnWTnUjv6L9pJ4IiX+
jKrlPhNgUFXV9MJrMr6SRGIvixAF1eo6bVP1C6iiZqmvr5sWg6Fvjan0Nqs8B9hS
sTzhEiL87xB0OUhA2RwTUKUrabuh3Q==
=pyNh
-----END PGP SIGNATURE-----

--HCxIsSCM8UjdhEUM--


