Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F94C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Eqr-0002BL-9B; Tue, 22 Apr 2025 10:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7Eqa-00025j-Uv
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7EqV-0003ir-HF
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745333013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jkL2V9419yMeK1+XcMOW0QLFLhU3+lLeJyoPYUa49xc=;
 b=KJ6P44PVpGPWMuTXA41jD7Hka/J0G9wu+S64yaRaWTBsRnV9YvF0V/GoNqtgrpEFWzmYJh
 S6sXwrm93qAZD2KXs5e+2OEonCKyBXzfKUr/l+sI7bfKU/AT/kSc4/G1iC0ACbaFo/woVW
 hGQGFlyHdaYPDFSRdiD6ecFLNlzaY1s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-7TwHLpKzPFO4cVYhA8Oi9Q-1; Tue,
 22 Apr 2025 10:43:27 -0400
X-MC-Unique: 7TwHLpKzPFO4cVYhA8Oi9Q-1
X-Mimecast-MFC-AGG-ID: 7TwHLpKzPFO4cVYhA8Oi9Q_1745333005
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 370D819560A6; Tue, 22 Apr 2025 14:43:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A764180087B; Tue, 22 Apr 2025 14:43:20 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:43:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@dlhnet.de>,
 "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>,
 Ilya Dryomov <idryomov@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "open list:GLUSTER" <integration@gluster.org>
Subject: Re: [PATCH v2.5 01/11] block: Expand block status mode from bool to
 flags
Message-ID: <20250422144319.GE301197@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250418215412.404558-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i+AaB1GnSKgogai5"
Content-Disposition: inline
In-Reply-To: <20250418215412.404558-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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


--i+AaB1GnSKgogai5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 04:52:46PM -0500, Eric Blake wrote:
> This patch is purely mechanical, changing bool want_zero into an
> unsigned int for bitwise-or of flags.  As of this patch, all
> implementations are unchanged (the old want_zero=3D=3Dtrue is now
> mode=3D=3DBDRV_WANT_PRECISE which is a superset of BDRV_WANT_ZERO); but
> the callers in io.c that used to pass want_zero=3D=3Dfalse are now
> prepared for future driver changes that can now distinguish bewteen
> BDRV_WANT_ZERO vs. BDRV_WANT_ALLOCATED.  The next patch will actually
> change the file-posix driver along those lines, now that we have
> more-specific hints.
>=20
> As for the background why this patch is useful: right now, the
> file-posix driver recognizes that if allocation is being queried, the
> entire image can be reported as allocated (there is no backing file to
> refer to) - but this throws away information on whether the entire
> image reads as zero (trivially true if lseek(SEEK_HOLE) at offset 0
> returns -ENXIO, a bit more complicated to prove if the raw file was
> created with 'qemu-img create' since we intentionally allocate a small
> chunk of all-zero data to help with alignment probing).  Later patches
> will add a generic algorithm for seeing if an entire file reads as
> zeroes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> In response to Stefan's ask for what it would look like as a bitmask
> of flags instead of an enum.  Only the first two patches of the series
> change.
>=20
>  block/coroutines.h               |  4 +--
>  include/block/block-common.h     | 11 +++++++
>  include/block/block_int-common.h | 27 +++++++++--------
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
>  25 files changed, 99 insertions(+), 86 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--i+AaB1GnSKgogai5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgHqwcACgkQnKSrs4Gr
c8hU7gf4i+x+hP9RlPTiWMI+hTnKzlZBAWNaFL+UuNln1OjCyHn0/R+s9+306Pet
XtHAyTNj/dl59fcEaYKT69YbN5UR7+go/TC+YG54yCLPhyKbw7FUBcVb+I2JA/Mi
o/uMLvIfF1KXKZHwzBT6uMuJ/nFlbTRiH77E/LViuaVFLYfyMwQ3WKpvoeMtAviR
2u8l2ZDaHRHbmMvQfEv6LQCGO6OARxqPstvByukwuhF01XSrdPa2Ae84mdapFU+F
x2rwUqbtMPdbYgYz3rKfYZSOknfKGEbSgZflsKi90vhLqsVyJ7Ifr2ifdOOn+Pfr
0gCMMTTrWO+qXtVtr6f33LbdaorQ
=00rF
-----END PGP SIGNATURE-----

--i+AaB1GnSKgogai5--


