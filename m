Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398EDCEFCE7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdBkb-0003h3-Ay; Tue, 06 Jan 2026 13:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vdBkY-0003go-PI
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vdBkV-0006md-Pt
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767723942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TwRJoFRSitRzN9HI4DwvLuKCAa7C5OtBgphQUXvIZss=;
 b=aoVFaB+nY5SqnF80FCRhzldlP5UTtsKRcQSCMEmkQk6c+acL3UuMNEGCIHqea35l4B/KoN
 1Fzgot2z2jrAusf/m5PZkPtXF06ZrbyvUhOB2ii92XQ3aWnjNOJjCd3XikIL41lDPIfroi
 K2bCnGjQcTXqWvcqREosou/LJdubLpM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-PuJxPF0WOYKEG0et2d70cw-1; Tue,
 06 Jan 2026 13:25:41 -0500
X-MC-Unique: PuJxPF0WOYKEG0et2d70cw-1
X-Mimecast-MFC-AGG-ID: PuJxPF0WOYKEG0et2d70cw_1767723940
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A798B18002C1; Tue,  6 Jan 2026 18:25:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D551180044F; Tue,  6 Jan 2026 18:25:38 +0000 (UTC)
Date: Tue, 6 Jan 2026 13:25:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH v3 0/4] Fixes and improvements for scripts/qemugdb commands
Message-ID: <20260106182537.GA123256@fedora>
References: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JKOtNYY37FfzrvBy"
Content-Disposition: inline
In-Reply-To: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--JKOtNYY37FfzrvBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 12:50:15PM +0200, Andrey Drobyshev wrote:
> v2 -> v3:
>=20
>   * Use atexit.register() instead of gdb.events.exited.connect() for
>     registering a cleanup callback.  That way it's called upon both
>     normal and abnormal exit;
>   * Wrap code in invoke() methods in try-finally block, so that
>     restore_regs() is called unconditionally even we caught an exception;
>   * Restore registers in cleanup;
>   * Set dirty flag early on in patch_regs() to make sure registers get
>     restored if we failed while patching.
>=20
> v1 -> v2:
>=20
>   * Use pty module instead of script(1) for producing colored output;
>   * Patch coredump file in place instead of full copy;
>   * Save and restore original pt_regs values in a separate file;
>   * Wrap this logic in a separate class.
>=20
> v2: https://lore.kernel.org/qemu-devel/20251202163119.363969-1-andrey.dro=
byshev@virtuozzo.com/
> v1: https://lore.kernel.org/qemu-devel/20251125142105.448289-1-andrey.dro=
byshev@virtuozzo.com/
>=20
> Andrey Drobyshev (4):
>   scripts/qemugdb: mtree: Fix OverflowError in mtree with 128-bit
>     addresses
>   scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
>   scripts/qemugdb: timers: Improve 'qemu timers' command readability
>   scripts/qemugdb: coroutine: Add option for obtaining detailed trace in
>     coredump
>=20
>  scripts/qemugdb/coroutine.py | 257 +++++++++++++++++++++++++++++++++--
>  scripts/qemugdb/mtree.py     |   2 +-
>  scripts/qemugdb/timers.py    |  54 ++++++--
>  3 files changed, 289 insertions(+), 24 deletions(-)
>=20
> --=20
> 2.43.5
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--JKOtNYY37FfzrvBy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmldU6EACgkQnKSrs4Gr
c8h6hAf+LF5LvYqzPMJuQ53Btaa5WrQ8digQOrRhfE3gPBRC/rpdfTOIiApipS/v
bpPZz5uZpRmsu+ehhidL/B8gXFohcEdqk6cur8Kcvwj/+cN9w42Ye5WY33H7fv2j
W601btaN+NgH4jjF6ipsLCfWab/ExL3EBy9CqqbF88AjYX9xy9tS915z2euIwRUu
to/7UqLqmuZkOVD7tvUB/9T30Sg6tSeJmpy7q3V3Phe9TgWBjMCEeFSN0qxhp1eE
rMuXJa3lJHPbCA7aCvFwoPNBeD+R+TLEC4MRwAShnR4nT7LpvO1aUjUii4I8TQ1P
dWhJPjFFabKqGiuq80v8+s8VwbR0Mw==
=hM9H
-----END PGP SIGNATURE-----

--JKOtNYY37FfzrvBy--


