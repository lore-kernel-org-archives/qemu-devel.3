Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20456C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Td7-0006rf-Ox; Wed, 23 Sep 2026 16:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9Tct-0006qw-BQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9Tcs-0004qF-2K
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790195492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4mYMgKzLEsr8WAUP5CrOgfkBbumbjbpedjGmN2OZu9k=;
 b=QNTV1AMZZupGBSwC9j1uwy7s8Qk4meRB1ZVnj1riGFoYsrUZrWRQTNWydXrrkk4CXTv8bZ
 m7fSc/I4/4WBJdeXtAIKIyIOUAO1OhpN/pzUkVXHCAwoGIzDcWRYfal/P2WnzrjbRntSzs
 LZxwnrfrbynrAbBO8ufSyRqtnJcag6E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-GfK8mUGnNhyAodMdnaB7NA-1; Wed,
 23 Sep 2026 16:31:31 -0400
X-MC-Unique: GfK8mUGnNhyAodMdnaB7NA-1
X-Mimecast-MFC-AGG-ID: GfK8mUGnNhyAodMdnaB7NA_1790195489
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BD651925255; Wed, 23 Sep 2026 20:30:57 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B693754; Wed, 23 Sep 2026 20:30:56 +0000 (UTC)
Date: Wed, 23 Sep 2026 16:30:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 49/88] qemu-iotests/028: migrate away from HMP
Message-ID: <20260923203055.GA2936489@fedora>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
 <20260923-nohmp-v1-49-ebc029d4bd80@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O95WSDeS6TB6dAz3"
Content-Disposition: inline
In-Reply-To: <20260923-nohmp-v1-49-ebc029d4bd80@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--O95WSDeS6TB6dAz3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:17:56AM +0400, Marc-Andr=E9 Lureau wrote:
> Replace HMP drive_backup, info block-jobs, and quit with their QMP
> equivalents (drive-backup, query-block-jobs, quit). Capture
> BLOCK_JOB_COMPLETED and JOB_STATUS_CHANGE events during polling
> to keep the output clean.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qemu-iotests/028     | 27 ++++++++++++++++++++-------
>  tests/qemu-iotests/028.out | 17 +++++++++++++----
>  2 files changed, 33 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O95WSDeS6TB6dAz3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmq0Nv8ACgkQnKSrs4Gr
c8jCjQf8DqOgvMWSVqmGBPwWudJZuH5hwmyiqdRO8nheDeARvuFuhqo4Zw32XApj
i+T3GSXbPUfVjk1Zs2nVkdiRVaf17EZduBRhj0yUz65S85VJ3IQ8ps//dV4uGZky
bepYKJjV70/TNTJA2k9yU/VT/lL+lthZHtYO3V5VcaJmv7y/3XEHksFIrzkKfawI
buR0tf1D9sRavb52Y1BAaCYa7Whqhz2fDz+axbhdkWrjJHKzgex7bZn3KAnQcI1W
ZhrvRZ8z+Amh+AaqIAiLnC0ftdKej00eHDb2UmAb8h2oU0SfJ2I/uEkpp5DbJIQ4
tZusE3i1ztAeacRkurOmINg+uAiCsg==
=QODM
-----END PGP SIGNATURE-----

--O95WSDeS6TB6dAz3--


