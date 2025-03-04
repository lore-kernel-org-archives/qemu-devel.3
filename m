Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA3C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 04:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpJs8-0000Vj-La; Mon, 03 Mar 2025 23:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tpJs6-0000VT-If
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 23:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tpJs4-0000if-IL
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 23:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741062426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nfCsRC1QWfN2xD4TP7KqVNHVjUTe37/1cmexLOyGHHE=;
 b=YsTDzehBK3dIBckJSOUQ5VoQnR9NZAsjot1CuJRP+PcuePkRgWavn9m8caspHUKovwerWj
 tA422mPh0vlVP3VbITcZgvuC3f3z5R70sz3bngddPJtHXr0mqRQ3egc9DSXYCK03W4CtQX
 oVsiaTTpICKNlFJ7HunCepQwTXkj62g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-ZUjP6BuiMz-gYKTAQImJKQ-1; Mon,
 03 Mar 2025 23:26:57 -0500
X-MC-Unique: ZUjP6BuiMz-gYKTAQImJKQ-1
X-Mimecast-MFC-AGG-ID: ZUjP6BuiMz-gYKTAQImJKQ_1741062416
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E8AB1801A1A; Tue,  4 Mar 2025 04:26:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F371180087D; Tue,  4 Mar 2025 04:26:53 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:26:50 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] scripts/checkpatch: Fix a typo
Message-ID: <20250304042650.GB223986@fedora>
References: <20250303172508.93234-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7KfH+LHOb+k48meZ"
Content-Disposition: inline
In-Reply-To: <20250303172508.93234-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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


--7KfH+LHOb+k48meZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 06:25:08PM +0100, Philippe Mathieu-Daud=E9 wrote:
> When running checkpatch.pl on a commit adding a file without
> SPDX tag we get:
>=20
>   Undefined subroutine &main::WARNING called at ./scripts/checkpatch.pl l=
ine 1694.
>=20
> The WARNING level is reported by the WARN() method. Fix the typo.
>=20
> Fixes: fa4d79c64da ("scripts: mandate that new files have SPDX-License-Id=
entifier")
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
> Possible candidate to apply on /master as buildfix
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to qemu.git/master!

Stefan

--7KfH+LHOb+k48meZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfGgQoACgkQnKSrs4Gr
c8hqVQf+NUHt+UnApirOzN6kVhgbALni3803Mb7lF5s5PtTEaAr0gNeEuGpPn+By
vZC2MzL1khKp87oG4ziC4cXTe9KPOqoTscho3HTrWoIH3ymziowzj2YYzRdg+1IJ
FBKWYfPfPZBWftK9O7OMNJ4Iu/ayIvxK+RICvx5ahzkIOVFiC6bUSPBbNXzoXC7D
rcf3X0usAweTdRcS5dMrSk+OE3wWEtYyPuCCmKzPFH+aRW7nQWihXKXg+jnJG7xN
uASkkZceAVpHe8BSs2GlgX9LOiQRU5b0/1/A5N9cW2MhwAHmJDoMoGjYB4riXBHB
HQx0vbMsc524wTmho3/mO4iVoUhHzw==
=EayY
-----END PGP SIGNATURE-----

--7KfH+LHOb+k48meZ--


