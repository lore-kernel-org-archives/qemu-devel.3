Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BC5D111A7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 21:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOMsv-0005Cy-M6; Wed, 26 Nov 2025 16:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vOMst-0005Cd-Kx
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vOMsr-0008Fg-44
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764191824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JkzSYjb35NVSF+sn4WHrcp9IOdSM/F0LSQQCAWiPMF0=;
 b=JraFL/3iyxRjXHUiMoC274Ipfcyec2l/KSOgcFZjYVUrSuKfV8CgCaFxL19onK36vmdML7
 dUxIOGe4cbDHyLx5IHnLkvk41vk40tWqDvbdhBEhcA7uxSnEPsQTymDIQyPQk9GGV2YlYQ
 wR+evpBTzkEUWIN73nTJ+NI5Oq7mQ+0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-CMOf2H7jOwuW8c9YMHN9CA-1; Wed,
 26 Nov 2025 16:17:00 -0500
X-MC-Unique: CMOf2H7jOwuW8c9YMHN9CA-1
X-Mimecast-MFC-AGG-ID: CMOf2H7jOwuW8c9YMHN9CA_1764191819
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47572195608D; Wed, 26 Nov 2025 21:16:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A05530044DB; Wed, 26 Nov 2025 21:16:57 +0000 (UTC)
Date: Wed, 26 Nov 2025 15:59:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: andrey.drobyshev@virtuozzo.com
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH 0/4] Fixes and improvements for scripts/qemugdb commands
Message-ID: <20251126205917.GB595594@fedora>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VTvqA1CHHCoe8Ivo"
Content-Disposition: inline
In-Reply-To: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--VTvqA1CHHCoe8Ivo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 04:21:01PM +0200, andrey.drobyshev@virtuozzo.com wr=
ote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>=20
> Commands 'qemu mtree' and 'qemu timers' are currently not working.
> Luckily, fixing them requires minimal effort.
>=20
> The most interesting part is adding '--detailed' option into 'qemu bt'
> and 'qemu coroutine' commands.  That is based on the previous downstream
> work by Vladimir.  As this approach is much heavier than the current
> stack unwinding, we add it as non-default behaviour.
>=20
> Andrey Drobyshev (4):
>   scripts/qemugdb: mtree: Fix OverflowError in mtree with 128-bit
>     addresses
>   scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
>   scripts/qemugdb: timers: Improve 'qemu timers' command readability
>   scripts/qemugdb: coroutine: Add option for obtaining detailed trace in
>     coredump
>=20
>  scripts/qemugdb/coroutine.py | 126 ++++++++++++++++++++++++++++++++---
>  scripts/qemugdb/mtree.py     |   2 +-
>  scripts/qemugdb/timers.py    |  54 ++++++++++++---
>  3 files changed, 162 insertions(+), 20 deletions(-)
>=20
> --=20
> 2.43.5
>=20

Aside from the question about script(1):
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VTvqA1CHHCoe8Ivo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmknaiUACgkQnKSrs4Gr
c8gBbwf+P3dbk4TAKeUIRFkuFlkXAIyxrwCw0TIcOhngUBO+MFBowL20C+91LN88
CAddnT8a5SPFL/Avt+SoGrPeYPZJkmaPX+Aw0Vj6KaQZxt2LNVAms4UrcbepJEBC
h8sNRtCkkgXibehY8x4qAlXabMnGzB8kyyAUcF/MPcfUFmfFkmwZbsyOrvF51AA1
pbUWwq/WlcT+CFES/ATtqIDnn2w7zY7c6va/j2i6wYHL8v9CtY/YWJ8kR11+FdGu
H0RKL36ZGJqHzIWT+/R6BTy5ha3vIgW5aPLMwPlvLc1lsRufVkZADUEuRS93sKAc
9EUu13qAMN49OU8Yv1eNTlbA4b6oTA==
=S3iV
-----END PGP SIGNATURE-----

--VTvqA1CHHCoe8Ivo--


