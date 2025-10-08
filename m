Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565EFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 18:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Ycu-0000cV-38; Wed, 08 Oct 2025 14:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6Ycq-0000bH-9M
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6Ycg-00008n-QF
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759947044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1nH2+nUzweI6t3+wa7bugJC+afKvLW8GULs1OcjVCU=;
 b=RZpNK5quxwEV1LE5gSJoAbT7+EPl9wnpaPcreB7Lz/xfSN6SHxxvNxycXGNpYWhM8jMdyE
 nbWaVp4PLnLEvb+UEni+M2hrsIjsW9FczB0LgnZxvLSZGachsOphnp8lZGgZ5NURmXBZFM
 NN+XjphchOuhAGVSeCD0gDSTWfMkO80=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-vOGdjC3kOY6aTdCPqksOWg-1; Wed,
 08 Oct 2025 14:10:40 -0400
X-MC-Unique: vOGdjC3kOY6aTdCPqksOWg-1
X-Mimecast-MFC-AGG-ID: vOGdjC3kOY6aTdCPqksOWg_1759947039
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AE2819560B0; Wed,  8 Oct 2025 18:10:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 055461800452; Wed,  8 Oct 2025 18:10:38 +0000 (UTC)
Date: Wed, 8 Oct 2025 14:10:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 5/6] tracetool: complete typing annotations
Message-ID: <20251008181037.GF181748@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wE93var0Z3kgcOuY"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-6-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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


--wE93var0Z3kgcOuY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:35:44AM +0200, Paolo Bonzini wrote:
> Add more annotations so that "mypy --strict".  These have to be done
> manually due to limitations of RightTyper.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py         | 30 +++++++++++++--------------
>  scripts/tracetool/backend/__init__.py |  2 +-
>  scripts/tracetool/format/log_stap.py  |  2 +-
>  3 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wE93var0Z3kgcOuY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjmqR0ACgkQnKSrs4Gr
c8jP2ggAuF194zCJp6TtSqjiuZzP3H7Svrv5RWurlYF7heuXagoOw2T/U2GnNWZs
WMjAG1+wVi9Thfgk1cqFFwVFwvHbGqNEbdYGhxeQHoqfd7sHhpbugnZ4uvXvpwf3
xe173nX2Yjv8bejp7aN1Ae/JcQadGXu+HYDhnJGRK7FciACFpyHP3odNt3IRN1am
S9VdpDnY/YvzyNNtCICzFQ6iNFs4esMwWm17oh0NFWt4NZJwL+Wm3GnodpI/F1qd
2ZGthEbru59wfndEc3uYSdVdIgSQHPb89ucdvedO/Pctn8s2/Rb3rh02WDC0NImH
27Cgea/KV8WhVtXFN0BeuPZ0K+ifOQ==
=7KN0
-----END PGP SIGNATURE-----

--wE93var0Z3kgcOuY--


