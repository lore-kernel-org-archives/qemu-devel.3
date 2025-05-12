Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0C5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV0X-0004UP-RN; Mon, 12 May 2025 11:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEV0T-0004Tb-WB
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEV0Q-0005RN-8Q
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747063429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gscezb5QgZqGhOMfE+kFKqb4xZnqEqSCQzFjzrTcV4w=;
 b=VxMzdPDqzdEuvuLgTwAfkxutb+oNjuR/ssDU3jqigjrL5JYHMSau/mhFhYfslpYXSgqcPw
 46QwhIKgJ7ov2OqfK8dDRueTCMD+yG0TTxFVI7OTS29sWPUwOpLLDzjE8ya1BftU9ri4Wa
 zp1BvXwOp0U0TjNdUaxPejSYxgvEeH4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-tSTN8fTONqykSAt0tXS0gw-1; Mon,
 12 May 2025 11:23:45 -0400
X-MC-Unique: tSTN8fTONqykSAt0tXS0gw-1
X-Mimecast-MFC-AGG-ID: tSTN8fTONqykSAt0tXS0gw_1747063424
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DE25180048E; Mon, 12 May 2025 15:23:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AF2C180045B; Mon, 12 May 2025 15:23:43 +0000 (UTC)
Date: Mon, 12 May 2025 11:23:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sunnyzhyy@qq.com,
 vsementsov@yandex-team.ru, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 08/13] mirror: Allow QMP override to declare target
 already zero
Message-ID: <20250512152342.GD141177@fedora>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ymMvCg225MA3I9DL"
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-23-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--ymMvCg225MA3I9DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:40:25PM -0500, Eric Blake wrote:
> QEMU has an optimization for a just-created drive-mirror destination
> that is not possible for blockdev-mirror (which can't create the
> destination) - any time we know the destination starts life as all
> zeroes, we can skip a pre-zeroing pass on the destination.  Recent
> patches have added an improved heuristic for detecting if a file
> contains all zeroes, and we plan to use that heuristic in upcoming
> patches.  But since a heuristic cannot quickly detect all scenarios,
> and there may be cases where the caller is aware of information that
> QEMU cannot learn quickly, it makes sense to have a way to tell QEMU
> to assume facts about the destination that can make the mirror
> operation faster.  Given our existing example of "qemu-img convert
> --target-is-zero", it is time to expose this override in QMP for
> blockdev-mirror as well.
>=20
> This patch results in some slight redundancy between the older
> s->zero_target (set any time mode=3D=3DFULL and the destination image was
> not just created - ie. clear if drive-mirror is asking to skip the
> pre-zero pass) and the newly-introduced s->target_is_zero (in addition
> to the QMP override, it is set when drive-mirror creates the
> destination image); this will be cleaned up in the next patch.
>=20
> There is also a subtlety that we must consider.  When drive-mirror is
> passing target_is_zero on behalf of a just-created image, we know the
> image is sparse (skipping the pre-zeroing keeps it that way), so it
> doesn't matter whether the destination also has "discard":"unmap" and
> "detect-zeroes":"unmap".  But now that we are letting the user set the
> knob for target-is-zero, if the user passes a pre-existing file that
> is fully allocated, it is fine to leave the file fully allocated under
> "detect-zeroes":"on", but if the file is open with
> "detect-zeroes":"unmap", we should really be trying harder to punch
> holes in the destination for every region of zeroes copied from the
> source.  The easiest way to do this is to still run the pre-zeroing
> pass (turning the entire destination file sparse before populating
> just the allocated portions of the source), even though that currently
> results in double I/O to the portions of the file that are allocated.
> A later patch will add further optimizations to reduce redundant
> zeroing I/O during the mirror operation.
>=20
> Since "target-is-zero":true is designed for optimizations, it is okay
> to silently ignore the parameter rather than erroring if the user ever
> sets the parameter in a scenario where the mirror job can't exploit it
> (for example, when doing "sync":"top" instead of "sync":"full", we
> can't pre-zero, so setting the parameter won't make a speed
> difference).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>=20
> ---
>=20
> v4: hoist earlier in series. QMP design is unchanged, but logic in
> mirror_dirty_init is different (in many aspects simpler, but now
> catering to "detect-zeroes":"unmap") so Acked-by on QMP kept, but
> Reviewed-by dropped.
> ---
>  qapi/block-core.json                   |  8 +++++++-
>  include/block/block_int-global-state.h |  3 ++-
>  block/mirror.c                         | 27 ++++++++++++++++++++++----
>  blockdev.c                             | 18 ++++++++++-------
>  tests/unit/test-block-iothread.c       |  2 +-
>  5 files changed, 44 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ymMvCg225MA3I9DL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiEn4ACgkQnKSrs4Gr
c8iOUAf9GAdekIXZNR0L6fMkdpic96LdBDk0PJb6Wej5i18irXcpHAiEBRE1sZiI
gyx2uBV/oScT/HO1X8C88GJhTCc14qjlnY3+LC7nTKLxpV64eROXdjfMW0V7CxRY
Skm6nxn+RBIoFDYTW2mZuyNjSVSEYSvMd1du6U8yEs7TCyxN4kcrvdyoZGcc6Ipi
2vqSqp3aIMHlqMc/M/Hfs7vQVBAxUcVs14e/AF//WTUEGFmB1zbOESk0osF+xLCi
WAJSMUwD8ttTKrhvsijW0MjQwwxoEjVTVzHAeDNUBwj0Yi59BPJRRQ9QIYQ55Np/
hlp8sHIf+XhqasbY1q7dkX5aLlZZoQ==
=aTcJ
-----END PGP SIGNATURE-----

--ymMvCg225MA3I9DL--


