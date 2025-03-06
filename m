Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B133BC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 02:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0ry-00040Q-1t; Wed, 05 Mar 2025 21:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tq0rv-0003yY-NV
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:21:51 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tq0rt-0003j5-4e
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:21:51 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2235189adaeso2908395ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 18:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741227707; x=1741832507; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=joAi8Ar1rtiamHhjK7HlApgRlQgYqjDCr2cjt4iizTk=;
 b=hE5ClbasNvwztaGcUWwwUckB7+RKV9JnLa8chXAeLfiD7OEZAU1Zu9km6E11klVUdX
 t5IvpjC9r2tZTYYtufVr1wFft8DN/omPZr4gcge6LjTT1k9j6ZSgt29QJ7O6uzmfKoe1
 SZtTJaOhuFmK9VCmwGasQCa4yIuiaVT8scEnsrn2lsKe1yy+kY/NxtoDa6gOgXfdtHzx
 epbGVLQBnzixWCaJAV2pKSNmxpT5qndlXXjBzvNoiDOw17+MGOrqVR5IJfpvDLK8FG6v
 RNw8dvOg/kzrJUUPQj4wQZcnMGP3bazSgxRQ7Ayjp6bCtSCth0kCJTPBJJ5yxIhJ/Dk/
 6YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741227707; x=1741832507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joAi8Ar1rtiamHhjK7HlApgRlQgYqjDCr2cjt4iizTk=;
 b=qJgAusRRMjKKTgxwo59Ye+R2sMHqoUNTtMvp+3fIq7IH6WqTNvbgE5hQR/3osvzuXq
 7R+ItAgAoxm7wNGEwyzwOvTWV8VVaB8mTgWxVL7t49e5SN8kcsuFXwXJTToefM+5IqUZ
 SHDyZHVHsS6DcvYX3O0wqCVZPRsnEN8wtl6q1d7xg/y1GczpeVzWMqkWOAYheLlg3e5d
 vkZW1zLeyxsyVPZ8QJ4KsqmKqNqW8JiV38AIE/BEAENgFnDhB8p4E9+4EQFB3zvVvsjh
 7cRYzArOmPi6cKAsYjvMfxHsLQQbdC3FVxyiCpsSIKU4eUN/2E5S0sqeOTyqjQyX9EEq
 QIpQ==
X-Gm-Message-State: AOJu0YxLG6HIiDwVi3cPK9elLSwefgsJIJ/tThjy0MVh+SplF1lpJtVx
 1MRGBdweYzAxu6RLSKEcSXpMPaCqHOCBGXNOZXcerdAIWy+VpH0J5EzrfVJt
X-Gm-Gg: ASbGncvtx3rwmFyHWJeQ9qut6hPrAyljEMmGhjZcZTLM9dKgmXPITm2Ao4xH2GRj6LJ
 brpomNMcGzO8si87NqwcbQ9Cbt9ay4FcSA73FYUUwe+REUrHY2fWhz8tNnArjy3JWTw8KSxZsgL
 fqvwDTuiprRM9sg3OROETisQpVoCADYR0HWVoMmthVyg34Uh05tevlEb9cbo5xDDWtZOMK15fDR
 NEhu1DR+KHjbDvcL+0zSwXiXHjaMSMdcHYtm1JAThtGpO0bkOrSjhRaEUYUIhmUlAGIq88z9qCX
 SWFpDMeD7rzyVnWsmLY0RiQy61S7nvLup4FXApqQdcZezC833gA3hfUL1LbtLog=
X-Google-Smtp-Source: AGHT+IEsx4HehqBVbmG7+WqYtK/tMORPQcqmUn71w2mi56KY1S8KtYivvIrDzocw+qgAShZ0KlltIw==
X-Received: by 2002:a17:902:ec89:b0:224:3d:2ffd with SMTP id
 d9443c01a7336-22409476105mr26039125ad.17.1741227707225; 
 Wed, 05 Mar 2025 18:21:47 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410ac0794sm1103925ad.259.2025.03.05.18.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 18:21:45 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Thu, 6 Mar 2025 10:21:42 +0800
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] block/qed: fix use-after-free by nullifying timer
 pointer after free
Message-ID: <20250306022142.GA304567@fedora>
References: <20250304083927.37681-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TdyAfxLMLbPNptpR"
Content-Disposition: inline
In-Reply-To: <20250304083927.37681-1-gerben@altlinux.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--TdyAfxLMLbPNptpR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 11:39:10AM +0300, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
>=20
> This error was discovered by fuzzing qemu-img.
>=20
> In the QED block driver, the need_check_timer timer is freed in
> bdrv_qed_detach_aio_context, but the pointer to the timer is not
> set to NULL. This can lead to a use-after-free scenario
> in bdrv_qed_drain_begin().
>=20
> The need_check_timer pointer is set to NULL after freeing the timer.
> Which helps catch this condition when checking in bdrv_qed_drain_begin().
>=20
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2852
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  block/qed.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--TdyAfxLMLbPNptpR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfJBrYACgkQnKSrs4Gr
c8jhlQf/R998gniVgBTb8TRUBwXcabW0YJZ2gRyy6bvFAWxiIGjOS/Wc1m46mjyH
akEes7uPm6M9dH7s0ToBQ5dAp5KANhCgAnokBuWGKGt1FrOzLcpkcKwaoPO8HvCN
FAEOFF+N+Hg7qTy4UKdeRVXZxpe/RvXyIEpJICv5gaYd6AZ95T8IDifR7MLxp2G1
aNxr6WdhYX6FuZH8flK5QlzadAw0EkZ2i/zb0CZOXPDwEvqOAo9F0AkFw6zc17sl
l7HK7K95R2Nx3ZzVAdKbRJM2OGuA8Vvva3B9FhTmRcNBpES8dEWOih/7ulTI+5+y
pD2dBhZDgrjEVGHf49R7tHGVvnOTiQ==
=x0Lc
-----END PGP SIGNATURE-----

--TdyAfxLMLbPNptpR--

