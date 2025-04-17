Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C2CC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Vgp-0004ch-Bn; Thu, 17 Apr 2025 16:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5Vgd-0004aO-H6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5Vgb-0008Fg-CP
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744921090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S169KlWxRQo9hncQNecpTrNwZ2FiQ516JGK2iYkkeN0=;
 b=VWy+z1gpFMd8XQokNkGgLfBRFbjqEgjjnn+Fr7odqGUpzgLtyOx3Hp5CYIyz8pwd0fE5fF
 dtq8iSxXYnVOdZr7yhv/PrPAJRIVWb3MxCY+srS/p2iMp9opQuI8Yrw4PLizRNb9O1BXT0
 YscfaZr4YDo+DktMw/fxKbKNQPF2Rn8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-wC4lPL8eNYai9q32KesD2g-1; Thu,
 17 Apr 2025 16:18:07 -0400
X-MC-Unique: wC4lPL8eNYai9q32KesD2g-1
X-Mimecast-MFC-AGG-ID: wC4lPL8eNYai9q32KesD2g_1744921085
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B0AC1955DCD; Thu, 17 Apr 2025 20:18:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB567180047F; Thu, 17 Apr 2025 20:17:56 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:17:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@dlhnet.de>,
 "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>,
 Ilya Dryomov <idryomov@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "open list:GLUSTER" <integration@gluster.org>
Subject: Re: [PATCH v2 01/11] block: Expand block status mode from bool to enum
Message-ID: <20250417201755.GA85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-14-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mYJMunW4mY2YGUIF"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-14-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--mYJMunW4mY2YGUIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:06PM -0500, Eric Blake wrote:
> This patch is purely mechanical, changing bool want_zero into a new
> enum BlockStatusMode.  As of this patch, all implementations are
> unchanged (the old want_zero=3D=3Dtrue is now mode=3D=3DBDRV_BSTAT_PRECIS=
E),
> but the callers in io.c are set up so that future patches will be able
> to differente between whether the caller cares more about allocation

differentiate

> or about reads-as-zero, for driver implementations that will actually
> want to behave differently for those more-specific hints.
>=20
> As for the background why this patch is useful: right now, the
> file-posix driver recognizes that if allocation is being queried, the
> entire image can be reported as allocated (there is no backing file to
> refer to) - but this throws away information on whether the entire
> image reads as zero (trivially true if lseek(SEEK_HOLE) at offset 0
> returns -ENXIO, a bit more complicated to prove if the raw file was
> created with 'qemu-img create' since we intentionally allocate a small
> chunk of all-zero data to help with alignment probing).  The next
> patches will add a generic algorithm for seeing if an entire file
> reads as zeroes, as well as tweak the file-posix driver to react to
> the new hints.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/coroutines.h               |  4 +--
>  include/block/block-common.h     | 26 ++++++++++++++++
>  include/block/block_int-common.h | 25 +++++++++-------
>  include/block/block_int-io.h     |  4 +--
>  block/io.c                       | 51 ++++++++++++++++----------------
>  block/blkdebug.c                 |  6 ++--
>  block/copy-before-write.c        |  4 +--
>  block/file-posix.c               |  4 +--
>  block/gluster.c                  |  4 +--
>  block/iscsi.c                    |  6 ++--
>  block/nbd.c                      |  4 +--
>  block/null.c                     |  6 ++--
>  block/parallels.c                |  6 ++--
>  block/qcow.c                     |  2 +-
>  block/qcow2.c                    |  6 ++--
>  block/qed.c                      |  6 ++--
>  block/quorum.c                   |  4 +--
>  block/raw-format.c               |  4 +--
>  block/rbd.c                      |  6 ++--
>  block/snapshot-access.c          |  4 +--
>  block/vdi.c                      |  4 +--
>  block/vmdk.c                     |  2 +-
>  block/vpc.c                      |  2 +-
>  block/vvfat.c                    |  6 ++--
>  tests/unit/test-block-iothread.c |  2 +-
>  25 files changed, 114 insertions(+), 84 deletions(-)
>=20
> diff --git a/block/coroutines.h b/block/coroutines.h
> index 79e5efbf752..c8323aa67e6 100644
> --- a/block/coroutines.h
> +++ b/block/coroutines.h
> @@ -47,7 +47,7 @@ int coroutine_fn GRAPH_RDLOCK
>  bdrv_co_common_block_status_above(BlockDriverState *bs,
>                                    BlockDriverState *base,
>                                    bool include_base,
> -                                  bool want_zero,
> +                                  enum BlockStatusMode mode,
>                                    int64_t offset,
>                                    int64_t bytes,
>                                    int64_t *pnum,
> @@ -78,7 +78,7 @@ int co_wrapper_mixed_bdrv_rdlock
>  bdrv_common_block_status_above(BlockDriverState *bs,
>                                 BlockDriverState *base,
>                                 bool include_base,
> -                               bool want_zero,
> +                               enum BlockStatusMode mode,
>                                 int64_t offset,
>                                 int64_t bytes,
>                                 int64_t *pnum,
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index 0b831ef87b1..619e75b9c8d 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -508,6 +508,32 @@ enum BdrvChildRoleBits {
>                                | BDRV_CHILD_PRIMARY,
>  };
>=20
> +/* Modes for block status calls */
> +enum BlockStatusMode {
> +    /*
> +     * Status should be as accurate as possible: _OFFSET_VALID
> +     * and_OFFSET_ZERO should each be set where efficiently possible,

"and _OFFSET_ZERO"

> +     * extents may be smaller, and iteration through the entire block
> +     * device may take more calls.
> +     */
> +    BDRV_BSTAT_PRECISE,
> +
> +    /*
> +     * The caller is primarily concerned about overall allocation:
> +     * favor larger *pnum, perhaps by coalescing extents and reporting
> +     * _DATA instead of _ZERO, and without needing to read data or
> +     * bothering with _OFFSET_VALID.
> +     */
> +    BDRV_BSTAT_ALLOCATED,
> +
> +    /*
> +     * The caller is primarily concerned about whether the device
> +     * reads as zero: favor a result of _ZERO, even if it requires
> +     * reading a few sectors to verify, without needing _OFFSET_VALID.
> +     */
> +    BDRV_BSTAT_ZERO,
> +};

I have trouble understanding what the exact semantics are of these modes
are. Would it be possible to pass flags to block status calls that can
be ORed together instead: WANT_OFFSET_VALID, WANT_ZERO, etc? The flags
would be orthogonal and easier to understand than modes that seem to
combine multiple flag behaviors.

Stefan

--mYJMunW4mY2YGUIF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBYfMACgkQnKSrs4Gr
c8gjTwf/SHYjMVDGRjAMdgGaz5sgreNZwnQk7OK9O3Hc4zat9RJICD63seLrlBry
5l6/d7joFMqqRP3dqJfimQyQV2StGQojxt227lwcZFXr79KsckcDWLCueSTAaiRT
Td4kDiTel//S/S9Hk4XSlLf+Nk0ocV722S0vyaFCNxumF+NTLPRmyVt8wRJJH16W
qZGfhLvBCNEq6mPh0lsoPH1RkFL0gerni9S2nriEW8wTZFvd8rDBEwcfKfdvzU9x
m2Df16kguJudmfYIulnLVPzG9GS9Lq/Xzhh/El7z4FaLavQ9JvAahaiowx6NTfC3
gNG6lGx74Z73Zr8TdmRh2kXop11Hug==
=70pb
-----END PGP SIGNATURE-----

--mYJMunW4mY2YGUIF--


