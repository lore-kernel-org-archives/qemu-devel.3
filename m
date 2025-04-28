Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859EAC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Tkr-0001Co-Ee; Mon, 28 Apr 2025 15:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u9Tkp-0001AI-Nx
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:02:59 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u9Tkn-0004MP-JW
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:02:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 98EEAA4B69B;
 Mon, 28 Apr 2025 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEE3C4CEEC;
 Mon, 28 Apr 2025 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745866973;
 bh=WLSZhBBT9gkPhkRBnZaRPmPwo+8i+anFn+XKZTQ39pg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ok2qtl+yZUlwzge+hTG+tcRB/yhNFK+h8GRHiiCOd3z0L3z2V53uQQBOKvO9Io1CZ
 JYivaOk3PfEiJKzhVVnmt0QcyJTVa/b33OmaGTW98y4WARb7R3h6LBJNMGEO6cxdcZ
 8D41MP3GLiMf4Pj3U6gHNGmY7DdrX9zVb6kzJKU0Rn1I1DQbKo/Cp6TW7MGevtJHFt
 ey2BXlm3H7fdLCwRGFzz+CiOAE2/QfMBYkqpzs3xKTFmQr5o7FgoiWrd81rhx2Y3OD
 3uTTXtIHBcHwCbjk9OfpEumdezuSh2nhkYZKGQXo2HeUcqrlUTTYxBOF7tEThRBkrx
 ZNzCEE5uw5v4Q==
Date: Mon, 28 Apr 2025 21:02:26 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] scripts: nixify archive-source.sh
Message-ID: <6mef3aim5bxvvvq3z5m7pz7sfpcyvipxqlxoqcbpc6a36spast@ky5oyciosoqb>
References: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
 <20250408-jag-sysctl-v1-1-3f4f38b751be@kernel.org>
 <4f64f6a8-2e4a-4e20-b2c8-8f87b8b7900c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jnswfay337qfci37"
Content-Disposition: inline
In-Reply-To: <4f64f6a8-2e4a-4e20-b2c8-8f87b8b7900c@redhat.com>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=joel.granados@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--jnswfay337qfci37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 02:18:01PM +0200, Paolo Bonzini wrote:
> On 4/8/25 22:14, Joel Granados wrote:
> > Use "#!/usr/bin/env bash" instead of "#!/bin/bash". This is necessary
> > for nix environments as they only provide /usr/bin/env at the standard
> > location.
>=20
> I am confused, how does this not break everything else?  All the test
> scripts in tests/docker/test-* have "#!/bin/bash", and configure has
> "/bin/sh".
Not sure what "break" means here, but the "env" shebang should just work
in distros that follow (or try to) POSIX. AFAIK, to be POSIX compliant,
you need to provide an "env" for command invocation [1]. The two
previous changes that I know of [2], [3] have not had any adverse
effects that I'm aware of.

> How is the environment that runs scripts/archive-source.sh
> different, and why should it be fixed in scripts/archive-source.sh?
It is different from the other files in that I hit the issue only on
that file. I'm happy to provide a treewide change if it would make more
sense.

>=20
> These are genuine questions - it would help if the commit message explain=
ed
> those...
I can weave the explanation into the commit for V2.

> In fact, what is a nix overlay and why would you use
> scripts/archive-source.sh to prepare one? :)
I now realize that mentioning a nix overlay in the commit message might
be to far from a general context. How about if I change the commit
message of the second patch to:

```
  The archive-source script appends everything directly on the tar root
  making it unsuitable for cases where a different directory structure
  is expected, like during nix packages customization.

  Add a "-d|--dir" argument that places all files under a custom root.
  Behaviour is unchanged when the argument is not given.
```

To answer the question of what an nix overlay is: It is a way of
customizing nix packages. I use it to override specific elements from a
nix package and replace them with my stuff [4]. I am working with the qemu
package and am overriding the qemu tarbal.

Best

[1] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/env.html
[2] https://lore.kernel.org/all/20250122-jag-nix-ify-v1-1-addb3170f93c@kern=
el.org/
[3] https://lore.kernel.org/all/20240817215025.161628-1-kent.overstreet@lin=
ux.dev/
[4] https://nixos.wiki/wiki/Overlays
--=20

Joel Granados

--jnswfay337qfci37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmgP0KUACgkQupfNUreW
QU9D2wv9GWk6u/p9a5A5j+UjishgB18Ct1QlyvRM+dBTTAgCGf4fHQ27FJfs4KC/
hT7pwmcG7FjmEHaiAKA68Razj81ux9WmzHn8LfMyzEukHPMELAkQ1s3tSs9mjdFd
IHP7kd7dCe0LbvkWdvIgngEHLQZ+MSOPt9DhqH2SGPRra8D9MPp+Q+YoIjnd58+j
+SZvIXF6pyoWowQw4iXkDwUqaH6njNf2X5JuYVhK7WT1S6Kj19Tg9/Zh90pOslUu
maYaIRzMAZnFmfw9t/0Z8kEYh1h2kK4xqxgKDB0aOeC4HAGRlRXM/X7TB9JD+5Lg
3zhanPqiVQLTUcKUQO6OHeC//oF3WKntTk4xeZzvvbUW4BFieu3JPYp8WCHwp0KH
/MHsuD+RJQ48eAFd1D/PAfYiXWwR60WC24CPFai9+iHrqAlcO+VFerSDVZgHnfCH
cbuegN3+YxIyArtKuwp5PHKuE8ZM2jiOEploatBNi6eZCKX7tU+aSU+Lgd42r9EN
+e1GSrYD
=2ANN
-----END PGP SIGNATURE-----

--jnswfay337qfci37--

