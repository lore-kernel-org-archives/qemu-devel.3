Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36029C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umB46-00073Q-QN; Wed, 13 Aug 2025 08:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <broonie@kernel.org>)
 id 1umAxY-0004ST-TV
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:52:06 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <broonie@kernel.org>)
 id 1umAxO-0001ni-R4
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:52:04 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 193904327B;
 Wed, 13 Aug 2025 12:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3288CC4CEEB;
 Wed, 13 Aug 2025 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755089483;
 bh=UMjaZSS4sd8UG4kwOViWpJphe7Bwr3FK+8uuEvptObY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JsZ+37HBd8CyLifn1Zgw1gjmmahHJ/PUjqGvPg/A/GugA+FnkH3U3P9C7LOuwSSy3
 Fsuhxkz+47NJqpf0hpdFHW6Scew12iDmedLeXW7B+PCArEXcXtqRyJhsUtdSZoQ4wv
 TvNWjTY7kqttCbgxhGu3GBoaWfrW35eHQGet4JTdgjhegOZM+aFJ9g5R1jppHZwbZj
 sV5udSiONnk839IrMB5r8E/SX0WdpPfTM9RRhzLEfT72HTwb+ff81cJIg1pR3+EHfh
 MQGo7gCZkySDY+MQEcqEFD62yI0jxMD0ZOEpo8FgLCNaxyofJXQDN9IpcJB1gFPfpd
 ay7k8QWarr0lw==
Date: Wed, 13 Aug 2025 13:51:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, achill@achill.org, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
Mail-Followup-To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, achill@achill.org,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org,
 Zhang Yi <yi.zhang@huaweicloud.com>,
 Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-ext4 <linux-ext4@vger.kernel.org>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jpbELjH1qfe0Wb2r"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
X-Cookie: Turn the other cheek.
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=broonie@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 13 Aug 2025 08:58:36 -0400
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


--jpbELjH1qfe0Wb2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman

> The following list of LTP syscalls failure noticed on qemu-arm64 with
> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=3Dy build configuration.
>=20
> Most failures report ENOSPC (28) or mkswap errors, which may be related
> to disk space handling in the 64K page configuration on qemu-arm64.
>=20
> The issue is reproducible on multiple runs.
>=20
> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
>=20
>   - fallocate04
>   - fallocate05
>   - fdatasync03
>   - fsync01
>   - fsync04
>   - ioctl_fiemap01
>   - swapoff01
>   - swapoff02
>   - swapon01
>   - swapon02
>   - swapon03
>   - sync01
>   - sync_file_range02
>   - syncfs01

I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
still running but I suspect given the error message:

epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of =
nesting is 5 expected EINVAL: ELOOP (40)

that it might be:

# bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbou=
nded recursion

which already got tested, or something adjacent.

--jpbELjH1qfe0Wb2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmicij4ACgkQJNaLcl1U
h9CPsgf/Zm8iW2xqCXTg33TAp9VCD0jKTGbQODneT3brIHHC/UoNghK+9mMfsEn6
SQQlgHE0a6ZGj+K7TQchCqcoaN87Mghuxa9RZlBnnu5nGG6FbY0RG05FAbrkPbkz
+47tdqfnsePdRTgKlgMUBFlTXJAlQu+xosyM9AaVZbisvUFd9gAayCNTvRNmMYQA
XUGFqqqc2K2z/9UvbkZ5rFAp7MfwZUk9dEeVspaTLScb8nQOkk3EiqvxJ/JGvHNN
QOG0n41MlgWguQ9swGbUdaemvLZHkx5jAkLMYoOH8g1/sL/IM6mwmQfj5QA51SZW
rjvQmjeNodIoT5+qzsyvvKz8qHav3w==
=zk6G
-----END PGP SIGNATURE-----

--jpbELjH1qfe0Wb2r--

