Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C85AC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WJ4-0006qP-CW; Thu, 17 Apr 2025 16:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WJ2-0006q6-2s
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WJ0-0000Ju-Em
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744923473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=By0pqF9HHt1jfje6Gnvqecv6EzMnY1kW+Nvv25KMZRU=;
 b=JXfd3Wh+9f4mKvOz+/12OZPVQi0MWLD3VJluc3hjNqTf0xxUb5KPrJh0uGhRkyETqQB0G3
 MFlkR+bWb/PKuWiiuqkEnuUJDIsmHd8E8vpGtOQ3SSpu8Vx6mDMGeWozEdW9aIyXPhAMiZ
 dqUxgvu9ralt1S4hFcQKufXP9f9j9DQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-n6FWT4htPIeiXFsT1k5CUQ-1; Thu,
 17 Apr 2025 16:57:51 -0400
X-MC-Unique: n6FWT4htPIeiXFsT1k5CUQ-1
X-Mimecast-MFC-AGG-ID: n6FWT4htPIeiXFsT1k5CUQ_1744923470
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEAE31956048; Thu, 17 Apr 2025 20:57:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 361BD19560BA; Thu, 17 Apr 2025 20:57:48 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:57:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 11/11] mirror: Allow QMP override to declare target
 already zero
Message-ID: <20250417205746.GJ85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-24-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ujn3Q0f/nmaJ/vfQ"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-24-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--Ujn3Q0f/nmaJ/vfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:16PM -0500, Eric Blake wrote:
> QEMU's attempts to learn whether a destination file starts life with
> all zero contents are just a heuristic.  There may be cases where the
> caller is aware of information that QEMU cannot learn quickly, in
> which case telling QEMU what to assume about the destination can make
> the mirror operation faster.  Given our existing example of "qemu-img
> convert --target-is-zero", it is time to expose this override in QMP
> for blockdev-mirror as well.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json                   |  8 +++++++-
>  include/block/block_int-global-state.h |  3 ++-
>  block/mirror.c                         | 23 +++++++++++++++--------
>  blockdev.c                             | 18 +++++++++++-------
>  tests/unit/test-block-iothread.c       |  2 +-
>  5 files changed, 36 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ujn3Q0f/nmaJ/vfQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBa0oACgkQnKSrs4Gr
c8gyuQgAyLy17ad1fblZiOAjlqqbEaB2wMWByexXA+vle+dkJrA+BcnFOp8Hh+xY
H1XHUIYRNHVEVvajerdscn98YGUSkNHMplERH5MlB1snuLOYsu2Dj77CeGB7YF5E
/xnMq3fIGRZm4mOz2g7JpWHv5MBN+rCIk4wbyqMSU2XXsxKH0qZAh+4zdcMRdTtC
LtWlG4B/pqoqjCarWAa6yWT2UBNDL/DSeA4Wph8Rwi/B/KwxvWeQNzuQeEEeDAE1
kfGZBCJr7YEwJ+KWtVhZcqV2nVVEtBO9WBL28J9giI14crHxz+CjNBJWDGZmiPYX
rzjJ4I0s3SGPg/T5RJbWz165QMSahQ==
=iC6R
-----END PGP SIGNATURE-----

--Ujn3Q0f/nmaJ/vfQ--


