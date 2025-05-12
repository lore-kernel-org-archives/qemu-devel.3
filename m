Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FD2C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEY8H-0007G0-9T; Mon, 12 May 2025 14:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEY8F-0007Fc-IH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEY8D-0004uc-7f
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747075444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXRPBDqzjRm/zedQ6rp12iLcVe+5Vh2wax2x3N0XscA=;
 b=I2fW5884SlPbIFbLwDfigUZrawal0A3o+T5sc0CjoKiWih8eAHVj2S+w9imqCUFVbRznn3
 1M7Fp+KeCdO2dzqydWA41QN8E3vB4awOzE79GK74SZfm1SCk1ruX/DdiPLo4rSGijnl7QD
 VdIeEp3y8TqBO+Fpb2ox9+NLiqhbaAA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-eVo9Bj8tMHyoipeknrYL-Q-1; Mon,
 12 May 2025 14:43:58 -0400
X-MC-Unique: eVo9Bj8tMHyoipeknrYL-Q-1
X-Mimecast-MFC-AGG-ID: eVo9Bj8tMHyoipeknrYL-Q_1747075437
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7A5D180087C; Mon, 12 May 2025 18:43:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35AF718001DA; Mon, 12 May 2025 18:43:57 +0000 (UTC)
Date: Mon, 12 May 2025 14:43:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sunnyzhyy@qq.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 11/13] mirror: Skip writing zeroes when target is
 already zero
Message-ID: <20250512184356.GG141177@fedora>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-26-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Wo7MzqttkZNFKV9"
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-26-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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


--0Wo7MzqttkZNFKV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:40:28PM -0500, Eric Blake wrote:
> When mirroring, the goal is to ensure that the destination reads the
> same as the source; this goal is met whether the destination is sparse
> or fully-allocated (except when explicitly punching holes, then merely
> reading zero is not enough to know if it is sparse, so we still want
> to punch the hole).  Avoiding a redundant write to zero (whether in
> the background because the zero cluster was marked in the dirty
> bitmap, or in the foreground because the guest is writing zeroes) when
> the destination already reads as zero makes mirroring faster, and
> avoids allocating the destination merely because the source reports as
> allocated.
>=20
> The effect is especially pronounced when the source is a raw file.
> That's because when the source is a qcow2 file, the dirty bitmap only
> visits the portions of the source that are allocated, which tend to be
> non-zero.  But when the source is a raw file,
> bdrv_co_is_allocated_above() reports the entire file as allocated so
> mirror_dirty_init sets the entire dirty bitmap, and it is only later
> during mirror_iteration that we change to consulting the more precise
> bdrv_co_block_status_above() to learn where the source reads as zero.
>=20
> Remember that since a mirror operation can write a cluster more than
> once (every time the guest changes the source, the destination is also
> changed to keep up), and the guest can change whether a given cluster
> reads as zero, is discarded, or has non-zero data over the course of
> the mirror operation, we can't take the shortcut of relying on
> s->target_is_zero (which is static for the life of the job) in
> mirror_co_zero() to see if the destination is already zero, because
> that information may be stale.  Any solution we use must be dynamic in
> the face of the guest writing or discarding a cluster while the mirror
> has been ongoing.
>=20
> We could just teach mirror_co_zero() to do a block_status() probe of
> the destination, and skip the zeroes if the destination already reads
> as zero, but we know from past experience that extra block_status()
> calls are not always cheap (tmpfs, anyone?), especially when they are
> random access rather than linear.  Use of block_status() of the source
> by the background task in a linear fashion is not our bottleneck (it's
> a background task, after all); but since mirroring can be done while
> the source is actively being changed, we don't want a slow
> block_status() of the destination to occur on the hot path of the
> guest trying to do random-access writes to the source.
>=20
> So this patch takes a slightly different approach: any time we have to
> track dirty clusters, we can also track which clusters are known to
> read as zero.  For sync=3DTOP or when we are punching holes from
> "detect-zeroes":"unmap", the zero bitmap starts out empty, but
> prevents a second write zero to a cluster that was already zero by an
> earlier pass; for sync=3DFULL when we are not punching holes, the zero
> bitmap starts out full if the destination reads as zero during
> initialization.  Either way, I/O to the destination can now avoid
> redundant write zero to a cluster that already reads as zero, all
> without having to do a block_status() per write on the destination.
>=20
> With this patch, if I create a raw sparse destination file, connect it
> with QMP 'blockdev-add' while leaving it at the default "discard":
> "ignore", then run QMP 'blockdev-mirror' with "sync": "full", the
> destination remains sparse rather than fully allocated.  Meanwhile, a
> destination image that is already fully allocated remains so unless it
> was opened with "detect-zeroes": "unmap".  And any time writing zeroes
> is skipped, the job counters are not incremented.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> v3: also skip counters when skipping I/O [Sunny]
> v4: rebase to earlier changes
> ---
>  block/mirror.c | 107 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 93 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0Wo7MzqttkZNFKV9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiQWsACgkQnKSrs4Gr
c8hOoAgAvg9HHIh2M7FZZm4OTJMqS9k0ZubRyEND6SGD2gPvpipSl3q9Ftshwq8+
PQh5YHetrbJ7bOJi3sHwYiVfHWvLQEXaFelSxQbjqKywK2dDMTe4Fng52Yvn7ddH
mFXusnV3PTlu47+13fU5fX4u0VY4jCjN7DCfS9y20BWpn97y13ikNflF8I+WXYI1
GtgWNzD2eBtnyf3+2fctvSwVAk4MVT+wWhIT/VfdORPa12JAiMDSks4r5ell0tc6
pOSGeLXDxr6NyjJIM2WxfTTUFkN5bxgB3NEbyQ1bHl58pRB7N6W74LtuGoDdQD/h
wJVYZDwXNmZmA9QZ9690LGNiX+Ia4g==
=J8K5
-----END PGP SIGNATURE-----

--0Wo7MzqttkZNFKV9--


