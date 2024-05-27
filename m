Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B2C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBgVy-0001Aw-Qq; Mon, 27 May 2024 16:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBgVx-00015p-Eo
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBgVg-0007i4-TD
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716839995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vX16Lb+KX6PlkWB14XtuaFIFbAsBN5f/2riaTwvVFxY=;
 b=F+JGoQcexppU1qWzI4vKUeRtRbEBAtW3WeDbFjb3qMUnQEVj+XMsiZxr7ZPabgjXRw0K4b
 PylfQJWXh1y+F4SkFMtk/X6jjIiWURSxPbE/cSBObQHBhUlgTWs/cfFF0Wf9OOwh3jGzei
 Nd6EszC1KT55mjbG1bA5EKmbC+8A1AU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Cb9X1QW1MJaRyzS9xbsnAQ-1; Mon, 27 May 2024 15:59:52 -0400
X-MC-Unique: Cb9X1QW1MJaRyzS9xbsnAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 754FC185A780;
 Mon, 27 May 2024 19:59:52 +0000 (UTC)
Received: from localhost (unknown [10.39.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6B5310004FE;
 Mon, 27 May 2024 19:59:51 +0000 (UTC)
Date: Mon, 27 May 2024 15:59:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Message-ID: <20240527195944.GA913874@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tzEjQmygOqqM+YVM"
Content-Disposition: inline
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--tzEjQmygOqqM+YVM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 04:14:15PM +0800, Zhao Liu wrote:
> Hi maintainers and list,
>=20
> This RFC series attempts to re-implement simpletrace.py with Rust, which
> is the 1st task of Paolo's GSoC 2024 proposal.
>=20
> There are two motivations for this work:
> 1. This is an open chance to discuss how to integrate Rust into QEMU.
> 2. Rust delivers faster parsing.
>=20
>=20
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Code framework
> --------------
>=20
> I choose "cargo" to organize the code, because the current
> implementation depends on external crates (Rust's library), such as
> "backtrace" for getting frameinfo, "clap" for parsing the cli, "rex" for
> regular matching, and so on. (Meson's support for external crates is
> still incomplete. [2])
>=20
> The simpletrace-rust created in this series is not yet integrated into
> the QEMU compilation chain, so it can only be compiled independently, e.g.
> under ./scripts/simpletrace/, compile it be:
>=20
>     cargo build --release

Please make sure it's built by .gitlab-ci.d/ so that the continuous
integration system prevents bitrot. You can add a job that runs the
cargo build.

>=20
> The code tree for the entire simpletrace-rust is as follows:
>=20
> $ script/simpletrace-rust .
> .
> =E2=94=9C=E2=94=80=E2=94=80 Cargo.toml
> =E2=94=94=E2=94=80=E2=94=80 src
>     =E2=94=94=E2=94=80=E2=94=80 main.rs   // The simpletrace logic (simil=
ar to simpletrace.py).
>     =E2=94=94=E2=94=80=E2=94=80 trace.rs  // The Argument and Event abstr=
action (refer to
>                   // tracetool/__init__.py).
>=20
> My question about meson v.s. cargo, I put it at the end of the cover
> letter (the section "Opens on Rust Support").
>=20
> The following two sections are lessons I've learned from this Rust
> practice.
>=20
>=20
> Performance
> -----------
>=20
> I did the performance comparison using the rust-simpletrace prototype with
> the python one:
>=20
> * On the i7-10700 CPU @ 2.90GHz machine, parsing and outputting a 35M
> trace binary file for 10 times on each item:
>=20
>                       AVE (ms)       Rust v.s. Python
> Rust   (stdout)       12687.16            114.46%
> Python (stdout)       14521.85
>=20
> Rust   (file)          1422.44            264.99%
> Python (file)          3769.37
>=20
> - The "stdout" lines represent output to the screen.
> - The "file" lines represent output to a file (via "> file").
>=20
> This Rust version contains some optimizations (including print, regular
> matching, etc.), but there should be plenty of room for optimization.
>=20
> The current performance bottleneck is the reading binary trace file,
> since I am parsing headers and event payloads one after the other, so
> that the IO read overhead accounts for 33%, which can be further
> optimized in the future.

Performance will become more important when large amounts of TCG data is
captured, as described in the project idea:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGBinaryTracing

While I can't think of a time in the past where simpletrace.py's
performance bothered me, improving performance is still welcome. Just
don't spend too much time on performance (and making the code more
complex) unless there is a real need.

> Security
> --------
>=20
> This is an example.
>=20
> Rust is very strict about type-checking, and it found timestamp reversal
> issue in simpletrace-rust [3] (sorry, haven't gotten around to digging
> deeper with more time)...in this RFC, I workingaround it by allowing
> negative values. And the python version, just silently covered this
> issue up.
>
> Opens on Rust Support
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Meson v.s. Cargo
> ----------------
>=20
> The first question is whether all Rust code (including under scripts)
> must be integrated into meson?
>=20
> If so, because of [2] then I have to discard the external crates and
> build some more Rust wheels of my own to replace the previous external
> crates.
>=20
> For the main part of the QEMU code, I think the answer must be Yes, but
> for the tools in the scripts directory, would it be possible to allow
> the use of cargo to build small tools/program for flexibility and
> migrate to meson later (as meson's support for rust becomes more
> mature)?

I have not seen a satisfying way to natively build Rust code using
meson. I remember reading about a tool that converts Cargo.toml files to
meson wrap files or something similar. That still doesn't feel great
because upstream works with Cargo and duplicating build information in
meson is a drag.

Calling cargo from meson is not ideal either, but it works and avoids
duplicating build information. This is the approach I would use for now
unless someone can point to an example of native Rust support in meson
that is clean.

Here is how libblkio calls cargo from meson:
https://gitlab.com/libblkio/libblkio/-/blob/main/src/meson.build
https://gitlab.com/libblkio/libblkio/-/blob/main/src/cargo-build.sh

>=20
>=20
> External crates
> ---------------
>=20
> This is an additional question that naturally follows from the above
> question, do we have requirements for Rust's external crate? Is only std
> allowed?

There is no policy. My suggestion:

If you need a third-party crate then it's okay to use it, but try to
minimize dependencies. Avoid adding dependening for niceties that are
not strictly needed. Third-party crates are a burden for package
maintainers and anyone building from source. They increase the risk that
the code will fail to build. They can also be a security risk.

>=20
> Welcome your feedback!

It would be easier to give feedback if you implement some examples of
TCG binary tracing before rewriting simpletrace.py. It's unclear to me
why simpletrace needs to be rewritten at this point. If you are
extending the simpletrace file format in ways that are not suitable for
Python or can demonstrate that Python performance is a problem, then
focussing on a Rust simpletrace implementation is more convincing.

Could you use simpletrace.py to develop TCG binary tracing first?

Stefan

>=20
>=20
> [1]: https://wiki.qemu.org/Google_Summer_of_Code_2024
> [2]: https://github.com/mesonbuild/meson/issues/2173
> [3]: https://lore.kernel.org/qemu-devel/20240509134712.GA515599@fedora.re=
dhat.com/
>=20
> Thanks and Best Regards,
> Zhao
>=20
> ---
> Zhao Liu (6):
>   scripts/simpletrace-rust: Add the basic cargo framework
>   scripts/simpletrace-rust: Support Event & Arguments in trace module
>   scripts/simpletrace-rust: Add helpers to parse trace file
>   scripts/simpletrace-rust: Parse and check trace recode file
>   scripts/simpletrace-rust: Format simple trace output
>   docs/tracing: Add simpletrace-rust section
>=20
>  docs/devel/tracing.rst                 |  35 ++
>  scripts/simpletrace-rust/.gitignore    |   1 +
>  scripts/simpletrace-rust/.rustfmt.toml |   9 +
>  scripts/simpletrace-rust/Cargo.lock    | 370 +++++++++++++++
>  scripts/simpletrace-rust/Cargo.toml    |  17 +
>  scripts/simpletrace-rust/src/main.rs   | 633 +++++++++++++++++++++++++
>  scripts/simpletrace-rust/src/trace.rs  | 339 +++++++++++++
>  7 files changed, 1404 insertions(+)
>  create mode 100644 scripts/simpletrace-rust/.gitignore
>  create mode 100644 scripts/simpletrace-rust/.rustfmt.toml
>  create mode 100644 scripts/simpletrace-rust/Cargo.lock
>  create mode 100644 scripts/simpletrace-rust/Cargo.toml
>  create mode 100644 scripts/simpletrace-rust/src/main.rs
>  create mode 100644 scripts/simpletrace-rust/src/trace.rs
>=20
> --=20
> 2.34.1
>=20

--tzEjQmygOqqM+YVM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZU5jAACgkQnKSrs4Gr
c8h2TAf+PmsIAi0FDK6tFMgnccCwbROM3Z9VBCcezpxqOuw7e98Mta72N97Ab/c1
zeWMNJTLqbCt0fyHHV3QI4oSnYxiTl+A+l6F9sPln/P0yQm1+RqfZAaj873X+/SV
lDDQQ5DP34uL0Tk0uSiqfb+v7BrLKi7lV5q2z7fNgwez/TTmHKlrUIiFQIeM0Kj+
+K/czjWyT2DY5o/I3JqAstNgEYoUFWyxOhECnMTxGhpvs2ZU6tvXkkt8OKtKxwuM
YGfbcwj1xwxHt/AxvNSkwy5fIzqVIhvvlzcpEa8pQFeUlUtHPVZCZm17Z8YwLZh5
Z9t7Kgc3/PVRYVNorTBXha0H/pmcEg==
=w/qL
-----END PGP SIGNATURE-----

--tzEjQmygOqqM+YVM--


