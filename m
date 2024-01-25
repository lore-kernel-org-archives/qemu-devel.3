Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AECFC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURYx-0006Pt-G9; Mon, 29 Jan 2024 08:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rURYm-0006Om-Ea
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rURYd-0003cQ-WB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706534411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DoYxf9eAqdbLBQUbOoVCUDzlRnQxmjWEbO2MdKIkEGU=;
 b=Tvj89DBbkvlW8pU0OM8ObHjyz0d2LTFOyANFLqmGBuLLFz3ZW0cCJPUA2IOXnzx1Y3M11o
 V14REMi21CocG4jIYi8DedHoeb7sIn8PU9qUFH/AIgHX0hekXlmXSNau5B/ADFApZz9EGF
 pe0rYJ1ZiENPI5BvGMxcpt2kXWijQ44=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-qdUXk2kqOtitbi11Yl18zw-1; Mon, 29 Jan 2024 08:20:06 -0500
X-MC-Unique: qdUXk2kqOtitbi11Yl18zw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4425A85A597;
 Mon, 29 Jan 2024 13:20:06 +0000 (UTC)
Received: from localhost (unknown [10.39.193.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7A2B400F364;
 Mon, 29 Jan 2024 13:20:05 +0000 (UTC)
Date: Thu, 25 Jan 2024 15:50:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] iotests/iothreads-stream: Use the right TimeoutError
Message-ID: <20240125205038.GA54178@fedora>
References: <20240125152150.42389-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZDk4Lb+Cw3dkz8Kc"
Content-Disposition: inline
In-Reply-To: <20240125152150.42389-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--ZDk4Lb+Cw3dkz8Kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 04:21:50PM +0100, Kevin Wolf wrote:
> Since Python 3.11 asyncio.TimeoutError is an alias for TimeoutError, but
> in older versions it's not. We really have to catch asyncio.TimeoutError
> here, otherwise a slow test run will fail (as has happened multiple
> times on CI recently).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/tests/iothreads-stream | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZDk4Lb+Cw3dkz8Kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWyyZ4ACgkQnKSrs4Gr
c8i9HAf+P7vd8VsK/qzn2zzos7pUOfztsaLoNbjs6GqaRdBteqqNz511gLrpUc2G
HXZ8GCPbSyvZOPunu8Qzbm1YQN85YzYN47t5pksLTDv34D6lcdYtUoCaSFq6TYvb
bSGODb/bgza3wizT6ja8pv2HLY8ja9FL4yRjru4b04X4Td5Lf1gEDnLA9A5iTB2L
djBZ+VSyuvNDRoWlCR17W5CWl77Pl3aAZMUyxuWgssKgb7PLnahXbY0pj/rL0ev/
eFPUL5z58+pV7mejxX9AWunQ/LzFyggwNAej3pvOLpL0/L8U+eTzPxFjp+hat61u
gtKSm7PsVQfW9BY+zuJFNaR8r4MJWA==
=ZVp0
-----END PGP SIGNATURE-----

--ZDk4Lb+Cw3dkz8Kc--


