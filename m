Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0C6C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjme3-0002QA-P8; Sun, 16 Feb 2025 16:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tjme1-0002Pj-O7
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:57:45 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tjme0-00059D-AF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:57:45 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fc3fa00323so3084176a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739743062; x=1740347862; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=29ohFVoq1dQ5+/n/BYcPH4DiZOvjm5L5WHaJJbfevog=;
 b=OD2MLiTTp972zpNGfty4ZCDcbvpUyjtJdWgwwCbYFGMiLUrYh5NHYz2vebRqvyA70B
 kkR32hM2SJfSe3pVcnPlB2ZO0akXCxSq0GHKej/5nlLfp+EfaXJVKCIuIWWyTruu2ID4
 vHQSBGYYX/CGa3MjaKRR7FjIXkEgJAAUyw+nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739743062; x=1740347862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29ohFVoq1dQ5+/n/BYcPH4DiZOvjm5L5WHaJJbfevog=;
 b=PsLvbRr6VcRS3pzyRhhiXHUjT68WIQETJDYcuVP5jKeIWrDlehSg8MmbK9tZWp/a97
 da/3cLlQe+Pdrod+en7ZsnakCgztyqb4ncGwgVbz43hE30berWjh7ymHvZ0oqmWnGFSU
 fKsShfni5ElId3x9CrNwIiQePlNO9Ocz5BhjD3rvKCnK3LbL5kK3DdMICuDU2lyRYmIR
 SX4z9bK2Jtc+H2EnjghzUhRAE8dZ36Aff5SdRz8bUFabqWPFJX3Zr6y71t8OgSKwP46B
 uzI5kVd/S3pJ3UpWe+CpQFnvVZpRi5jFFH6kGTIHBP7cF+Fz5pJyuu9qEElGEnjKK+VW
 ruag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPkoZeF/x8VouipA0G/4VO0s9JSU1oUwgrCoDuR9WPX4T2t9tr1pcLIwaNlRoe7nYFkqFvfIzzgslm@nongnu.org
X-Gm-Message-State: AOJu0YwNd2TSoTL24qta+b2s4SKemiTXBKQAnYJ+IOTT7wb5kIb418sc
 d3wBxHpWpJaEeCkoQ8trwHldtMov429VACmH26HonULrJPUoLTDfDYY3iKMJEOA=
X-Gm-Gg: ASbGncs1GL1zDnCaxYsBqWttX22ccTujuMNS9ZaJLaDmgMpXI28Pag/1vj6S7GDfMvi
 hNrokXbhb6UitSCrlQmsmAPvg3T3a8LXj/chAbWhK9ihyjBpd8fX/saXODW4vtHrs/hEtDx7WFM
 qm94Qy+6pSiaNKiWb1Wc6HSVPPxieX3wHJNotUhKp33yPxHx6QSYmPR8r2XzDu1ak5ra4C/xwWR
 NJ3PP9MJOq2s15pbBT70JnfibIrOKZInDTWA/RSud3R/PiHuJwn+nfja9bZKFc1hAPrsOrwlJap
 Zxa8BSrcPbiUQw==
X-Google-Smtp-Source: AGHT+IHysfB83LhJmODtNdD7fcd6LgrJTa8iuL7pEmYdLirQ9fYlsSJ8lwYPelpgh8YdiYYFGXChpg==
X-Received: by 2002:a17:90b:2fc3:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2fc40f21c49mr10622367a91.19.1739743062489; 
 Sun, 16 Feb 2025 13:57:42 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13aafebesm6636582a91.4.2025.02.16.13.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 13:57:41 -0800 (PST)
Date: Sun, 16 Feb 2025 15:57:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
Message-ID: <20250216215738.GF1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nufO17mhAZ95TcDn"
Content-Disposition: inline
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=trini@konsulko.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--nufO17mhAZ95TcDn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 01:43:45PM -0700, Simon Glass wrote:

> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
>=20
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
>=20
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.
>=20
> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
>=20
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64

This seems needlessly not against mainline.

--=20
Tom

--nufO17mhAZ95TcDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeyX1IACgkQFHw5/5Y0
tyynAQv/Yw3vjXT5Tlq1/yRP1uPrvljHSWE9HJFfP/9yfKrxMqy5PQtys0gYUc9f
inD90JPn+OJfjcAkPWg4BI3v03+Izyb5/YMWPXK298MBniOURrMkEUBeRyDda8bk
1Z7jorHyefwj7HpNuYvh5tmalygJprWIOjwZrgaVQ2kMe3vUNHTlNXToD5yfPxJ6
sTD0qH+evlI+Qw/nbrehnH1uZfViOz+/e7KOkrYUPr3Z8ytaa8CIn+Lgo3FTVdBj
bhI/+1V6YYMVI4yv1PfphcrPV/oDd7mXYxvH/oMlfNWrdPpjaEAn860sQx1yxyYS
T/O+7f3bqNGzlMi3OocEkT4v36OnwR4l5PHllbfENHd6qLKuNgorHfH6UubUUf7J
B+Az6i02L8Hus2OB2rl1PRT57Wex0GvXsbwuT5f0DTI38PGdMSUyxGagS0UlOvQJ
+LUM6gkMddqbDbuLbJHpoxRGBiu8J7HDPZTHW9V0QIimEvFMsFQChV22Fw12y2vh
ZGoEZ2RY
=qeLp
-----END PGP SIGNATURE-----

--nufO17mhAZ95TcDn--

