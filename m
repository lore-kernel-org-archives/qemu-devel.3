Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9ACCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 19:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4dW-0007wa-Oq; Mon, 17 Nov 2025 14:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vL4dV-0007wN-MY
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 14:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vL4dT-00030d-ML
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 14:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763406694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADzxFK0h8zP1pcI2qGnfJhpgvUHHbGKSC3nqvRMiLGg=;
 b=Nbk/erTkAeDpnCEeUzoIme0VWVeep3a7YFh+BuB7Qb3SskWk7uy1T34Mt3i9ERRMRw7kqp
 pMrv7Jx4ZNddfA/lTv7TvKzMtIWtYa0pZd/qPbOFHjdqPIcEW3fA9ufd6mFinIpujcjbZf
 1AjAPm/HE6jcL3ZKDwFfhIj9pHG6RLA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-2fGLfn92PO2Y1ctm7gswnw-1; Mon,
 17 Nov 2025 14:11:33 -0500
X-MC-Unique: 2fGLfn92PO2Y1ctm7gswnw-1
X-Mimecast-MFC-AGG-ID: 2fGLfn92PO2Y1ctm7gswnw_1763406691
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FAB71956057; Mon, 17 Nov 2025 19:11:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FD741800451; Mon, 17 Nov 2025 19:11:30 +0000 (UTC)
Date: Mon, 17 Nov 2025 14:11:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH v2 00/19] block: Some multi-threading fixes
Message-ID: <20251117191129.GA91711@fedora>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NvydyW1MgMnmDRpP"
Content-Disposition: inline
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--NvydyW1MgMnmDRpP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 04:48:35PM +0100, Hanna Czenczek wrote:
> Hi,
>=20
> See the v1 cover letter for a general overview:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2025-10/msg00501.html
>=20
> Changes in v2:
> - Kept `.ret =3D EINPGORESS`-style initializations where they already had
>   been (curl, nvme)
> - Dropped trivial BH waking code (i.e. which can be directly replaced by
>   aio_co_wake()) in iscsi, nfs, nvme
> - curl: Yield in curl_do_preadv() (former curl_setup_preadv()) and
>   curl_find_buf() instead of returning whether curl_co_preadv() has to
>   yield or not
> - nvme: Added a patch that annotates some functions (primarily BHs and
>   CBs) with which AioContext they (must) run in
> - qcow2 cache-cleaning timer: Run the timer as a coroutine instead of in
>   a timer CB; use a CoQueue to await it exiting instead of polling
>   (well, we still need to poll in case we don=E2=80=99t run in a coroutin=
e, but
>   that=E2=80=99s standard procedure, I believe)
>   - The need to initialize the CoQueue showed that there is a code path
>     in qcow2 that doesn=E2=80=99t initialize its CoMutex.  Added a patch =
to do
>     that.
>   - Also added a patch to have the timer use realtime instead of virtual
>     time.
>=20
>=20
> git backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/19:[----] [--] 'block: Note on aio_co_wake use if not yet yielding'
> 002/19:[----] [--] 'rbd: Run co BH CB in the coroutine=E2=80=99s AioConte=
xt'
> 003/19:[0019] [FC] 'iscsi: Run co BH CB in the coroutine=E2=80=99s AioCon=
text'
> 004/19:[0022] [FC] 'nfs: Run co BH CB in the coroutine=E2=80=99s AioConte=
xt'
> 005/19:[0060] [FC] 'curl: Fix coroutine waking'
> 006/19:[----] [--] 'gluster: Do not move coroutine into BDS context'
> 007/19:[----] [--] 'nvme: Kick and check completions in BDS context'
> 008/19:[0038] [FC] 'nvme: Fix coroutine waking'
> 009/19:[down] 'nvme: Note in which AioContext some functions run'
> 010/19:[----] [--] 'block/io: Take reqs_lock for tracked_requests'
> 011/19:[down] 'qcow2: Re-initialize lock in invalidate_cache'
> 012/19:[0145] [FC] 'qcow2: Fix cache_clean_timer'
> 013/19:[down] 'qcow2: Schedule cache-clean-timer in realtime'
> 014/19:[----] [--] 'ssh: Run restart_coroutine in current AioContext'
> 015/19:[----] [--] 'blkreplay: Run BH in coroutine=E2=80=99s AioContext'
> 016/19:[----] [--] 'block: Note in which AioContext AIO CBs are called'
> 017/19:[----] [--] 'iscsi: Create AIO BH in original AioContext'
> 018/19:[----] [--] 'null-aio: Run CB in original AioContext'
> 019/19:[----] [--] 'win32-aio: Run CB in original context'
>=20
>=20
> Hanna Czenczek (19):
>   block: Note on aio_co_wake use if not yet yielding
>   rbd: Run co BH CB in the coroutine=E2=80=99s AioContext
>   iscsi: Run co BH CB in the coroutine=E2=80=99s AioContext
>   nfs: Run co BH CB in the coroutine=E2=80=99s AioContext
>   curl: Fix coroutine waking
>   gluster: Do not move coroutine into BDS context
>   nvme: Kick and check completions in BDS context
>   nvme: Fix coroutine waking
>   nvme: Note in which AioContext some functions run
>   block/io: Take reqs_lock for tracked_requests
>   qcow2: Re-initialize lock in invalidate_cache
>   qcow2: Fix cache_clean_timer
>   qcow2: Schedule cache-clean-timer in realtime
>   ssh: Run restart_coroutine in current AioContext
>   blkreplay: Run BH in coroutine=E2=80=99s AioContext
>   block: Note in which AioContext AIO CBs are called
>   iscsi: Create AIO BH in original AioContext
>   null-aio: Run CB in original AioContext
>   win32-aio: Run CB in original context
>=20
>  block/qcow2.h                    |   5 +-
>  include/block/aio.h              |  15 ++++
>  include/block/block_int-common.h |   7 +-
>  block/blkreplay.c                |   3 +-
>  block/curl.c                     |  45 +++++++---
>  block/gluster.c                  |  17 ++--
>  block/io.c                       |   3 +
>  block/iscsi.c                    |  63 ++++++--------
>  block/nfs.c                      |  41 ++++-----
>  block/null.c                     |   7 +-
>  block/nvme.c                     | 113 ++++++++++++++++--------
>  block/qcow2.c                    | 145 ++++++++++++++++++++++++-------
>  block/rbd.c                      |  12 +--
>  block/ssh.c                      |  22 ++---
>  block/win32-aio.c                |  31 +++++--
>  15 files changed, 347 insertions(+), 182 deletions(-)
>=20
> --=20
> 2.51.1
>=20

I reviewed the nvme changes and the core block layer changes:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NvydyW1MgMnmDRpP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkbc2AACgkQnKSrs4Gr
c8gV6ggAqO5z3mFiPa3eutX9nXRheoa+vn1Uo1P9jXwetzmTCFM6lTMjCYpROhXR
+bUKh+/jRqnUuGWdbTq1dW3JDAAlUr6B4CyzU1lVdlc/LcsHk1JfOtP6K8I5OAXw
6zDHFMDHUq0vCA1jDvTiNbxbr3c+xGHn0c8nmL0sdzp3cMsDIurYkoxJ7JUvn8uX
utzAvJjj9R0F6xFMg+nm811n/3EAabrGR/DrcH2N0nilKeODtSp+Zt07IruMtrmn
q3Y00BIbXPvpkbsMLqadGrlH1WlytXQCBr5LOmsyEPtbMpczeHK9MJb6KJVsIgGG
Hmx/CLe9ZqSiDERkeu5h8lZ1U1FMKg==
=M+1e
-----END PGP SIGNATURE-----

--NvydyW1MgMnmDRpP--


