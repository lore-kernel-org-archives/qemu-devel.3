Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91733C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tran3-00006o-VV; Mon, 10 Mar 2025 06:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tran0-000060-P7
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tramy-0005vb-66
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741604115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tL5WNKLgGpSIn+AAYHINLiZSnJVUQi5ki/U8rmYyIdg=;
 b=LwZ3tD0kjDcgNNU0uL/3m6TQ0cKaHqSg6Vt69/dzZ1Tl1ILk8M1ag+FEvq9/L5AtNW53G8
 cnKxP6zVqYp/rsjAKJnakhiyvJ2UpIwnZU5AJ3P2ipDejReAp68nvdLnni/e1lJdCnrj6a
 MJTEyhGz1i6Lv54p6PtvBVYcR3Jy0hU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-gOKCEyT2MRGBI-ucCNJwHQ-1; Mon,
 10 Mar 2025 06:55:11 -0400
X-MC-Unique: gOKCEyT2MRGBI-ucCNJwHQ-1
X-Mimecast-MFC-AGG-ID: gOKCEyT2MRGBI-ucCNJwHQ_1741604110
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EA421956048; Mon, 10 Mar 2025 10:55:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C356019560AD; Mon, 10 Mar 2025 10:55:09 +0000 (UTC)
Date: Mon, 10 Mar 2025 18:55:07 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] aio: Create AioPolledEvent
Message-ID: <20250310105507.GD359802@fedora>
References: <20250307221634.71951-1-kwolf@redhat.com>
 <20250307221634.71951-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/1m5I+7Eq5pMh/K1"
Content-Disposition: inline
In-Reply-To: <20250307221634.71951-4-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--/1m5I+7Eq5pMh/K1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 11:16:32PM +0100, Kevin Wolf wrote:
> As a preparation for having multiple adaptive polling states per
> AioContext, move the 'ns' field into a separate struct.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/aio.h |  6 +++++-
>  util/aio-posix.c    | 31 ++++++++++++++++---------------
>  util/async.c        |  3 ++-
>  3 files changed, 23 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/1m5I+7Eq5pMh/K1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfOxQsACgkQnKSrs4Gr
c8h9tQf8CEpkCwpTYOeXVauxMNh6rxc3eUwQF0QZkdS/0urgLgvtrMPIbdTvrNTT
HFBIlBcIXflgZxh9ili8MoutXcKta/XORc2FLHzd0Uyg7np396Eob3Ngw2tJfsry
1lvrivGy5J+OmtXNADjF/EsJ7/goReLqnkRqw3Q5R54iKHmLFTCfEjWOvArnvyba
DalN+sLEbnbVb2LwWTVMVYjeG1BVKgoMVDBbtOccM/4RBaRvcP1I/isZgjCU8b6d
iACUljmVgz41UlCG7mArqpa43hw4R8TZRA0hZG8D+tmg5f4p0LDVoEaELDDcxD3m
MifhGF8WROj3SzNZ7oTh9GdmAjfxIg==
=+46P
-----END PGP SIGNATURE-----

--/1m5I+7Eq5pMh/K1--


