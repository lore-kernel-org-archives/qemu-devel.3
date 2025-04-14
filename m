Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC4BC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4LW7-0001Rh-GM; Mon, 14 Apr 2025 11:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4LW6-0001RP-Mn
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4LW4-0000Bv-Lo
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744643670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1bsXi8oPRLAMCFgyjWsFy8l/ZZ/943xdgV7leLmsOA=;
 b=iaGIm9UW72hsqUGR/Co1fQ+O7zZvwzitzeXthUAGPP5Dyv+BD8dkfEuBoX4pfhiDYf2hyO
 CDB1WkQ+jTuCNOjdXllfMXR9nOqREKIWtz+mlXCKnNy/2NHPpBnFE4lKwPc1WwtHdpcsVe
 d7Fb7e2mphxS2mcmaHHYszx3luXnPL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-rJ3QSnDENYmnuFhZqNTl4g-1; Mon,
 14 Apr 2025 11:14:29 -0400
X-MC-Unique: rJ3QSnDENYmnuFhZqNTl4g-1
X-Mimecast-MFC-AGG-ID: rJ3QSnDENYmnuFhZqNTl4g_1744643667
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FAC71800258; Mon, 14 Apr 2025 15:14:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83808180B487; Mon, 14 Apr 2025 15:14:24 +0000 (UTC)
Date: Mon, 14 Apr 2025 11:14:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: Re: [PATCH 0/2] fix record/replay on MacOS
Message-ID: <20250414151422.GB117758@fedora>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Xqw1WmH1ICH4/+WG"
Content-Disposition: inline
In-Reply-To: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--Xqw1WmH1ICH4/+WG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 03:55:48PM -0700, Pierrick Bouvier wrote:
> Recently, it was found that rr tests fail on MacOS, with a replay_mutex_u=
nlock()
> assertion. This is a recent regression, related to running qemu main even=
t loop
> in a separate thread, like first commit explain.
>=20
> We first fix the regression, by handling the qemu replay mutex in the sam=
e way
> we deal with BQL.
> Then, we reenable the disabled test.
>=20
> Pierrick Bouvier (2):
>   system/main: transfer replay mutex ownership from main thread to main
>     loop thread
>   tests/functional/test_aarch64_replay: reenable on macos
>=20
>  system/main.c                           | 4 ++++
>  tests/functional/test_aarch64_replay.py | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.39.5
>=20

Thanks, applied to my staging tree:
https://gitlab.com/stefanha/qemu/commits/staging

Stefan

--Xqw1WmH1ICH4/+WG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf9Jk4ACgkQnKSrs4Gr
c8jIaQf+JTbSrM6NUghrQTcmNLQ9vU+oERWn1fAMtCzkyTK44vck0QPKozvr18X4
7u/kgHO82VBlICxEKevRD7WhrhH2EetLXMbey+yOMbQWFLDeUGYVqbs9X6jyN8dX
d4M2dVpDYfZhCJ3seAlFygHgLSCVxmUN9ggRDrSGsFw69i2mAaZmcBozBLNq9rfc
1Frj6ZYHhQPimK+08xYBBfMxR5nT4eKTRLvMj7DsIcL9Xsu6OPL0vW0dbmOBtxWQ
eK+jXEuLdJao1BqgNaib2D/JoTxw/sNfzDMml/yStVHhs3DK1B2GoHc48yZc75tN
CDYawzrImPS68KR79HXN4YFnNOd9pA==
=Fq/j
-----END PGP SIGNATURE-----

--Xqw1WmH1ICH4/+WG--


