Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E7C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 15:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZY6S-0003Fs-OK; Mon, 12 Feb 2024 10:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rZY6R-0003FV-FC
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:20:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rZY6P-0007xa-UE
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707751212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rll9G1m1BxcDWXtKfQvsKeBBENU4oGX69BR76QQEuz0=;
 b=aF8eH1tlEwKjwtdsj1V608Sq1yIAJOc4sbg9w8vqJaF8WGS+VtwukqAwQFLue3qQYD2hUH
 JVspNvG041Vj+mLiyOwzcD1NiNhDyL3JOuSueu8UN5CVFI6G2KskhKFU0WXblzwIR6f41m
 sjcaSS5Sxd35NtcfAzGis5aWaQAGmdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-IpWVyaAmP6C1cVYmT7tUbA-1; Mon, 12 Feb 2024 10:20:08 -0500
X-MC-Unique: IpWVyaAmP6C1cVYmT7tUbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD883859701;
 Mon, 12 Feb 2024 15:20:07 +0000 (UTC)
Received: from localhost (unknown [10.39.195.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 483A5112131D;
 Mon, 12 Feb 2024 15:20:06 +0000 (UTC)
Date: Mon, 12 Feb 2024 10:20:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, hreitz@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] iotests: Make 144 deterministic again
Message-ID: <20240212152005.GA879395@fedora>
References: <20240209173103.239994-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Iw4ueGqgniJttu0s"
Content-Disposition: inline
In-Reply-To: <20240209173103.239994-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--Iw4ueGqgniJttu0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 06:31:03PM +0100, Kevin Wolf wrote:
> Since commit effd60c8 changed how QMP commands are processed, the order
> of the block-commit return value and job events in iotests 144 wasn't
> fixed and more and caused the test to fail intermittently.
>=20
> Change the test to cache events first and then print them in a
> predefined order.
>=20
> Waiting three times for JOB_STATUS_CHANGE is a bit uglier than just
> waiting for the JOB_STATUS_CHANGE that has "status": "ready", but the
> tooling we have doesn't seem to allow the latter easily.
>=20
> Fixes: effd60c878176bcaf97fa7ce2b12d04bb8ead6f7
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2126
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/144     | 12 +++++++++++-
>  tests/qemu-iotests/144.out |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)

Thank you!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Iw4ueGqgniJttu0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXKNyUACgkQnKSrs4Gr
c8g3Vgf/W+rFhXAlF03+rdvERsU9VHs3oTEwxxebN1oTLNH2+EKLD5fnd3XSx6Sx
wsyt2xSgeWXac20Bz8lBEZ10drizZ7hUu3BKLSQ2Es7yVqOJj/4t9YhyHW9op0uA
T+Y0xBTwLLWPHxki/6F/w3MTikDhCrZszbiQN5Pli7kDLXsJvv8+GZSVyJUc/ae6
K42tNI8kHoefYwN7B8a/Al+1p8WcdBl0CxxjEgF1eCYUJAsofZIHkygbMQ2rmsNP
5Dvwrw9NighDzrcX3qXN9uMivfKZGILVuypzHhl34kM+V9JLQ/rAF6ajIQww76Xw
J5tqiZZA7S9hBS/9XrfG5JLmkNwuaA==
=3zmt
-----END PGP SIGNATURE-----

--Iw4ueGqgniJttu0s--


