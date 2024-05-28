Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06464C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwWD-0005AV-6J; Tue, 28 May 2024 09:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBwWB-00059l-Q7
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBwW9-0004AX-98
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716901528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=muclBu7mHExI3jVpgyN3t3v1bbJnJp/onIZttwCCQn4=;
 b=EfpcL4ZZSAo/ScvVyHVT6ZuJwuZDQ8U3e5D8CeFhnCmQLm5nUpDa9jQEbQlN9xtP/n/JNm
 jpiRGTQw7QsqIu/lztBOSQZb9VCmhQVkQ8fR4xNCenMlhDRVannFth6OqJ4Lph9sRZUEj7
 oEj6wSc3mRgaj7HVdnMS4a20RcZpTIM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-QA-GZdQaOQezhzX4dBzDUw-1; Tue, 28 May 2024 09:05:21 -0400
X-MC-Unique: QA-GZdQaOQezhzX4dBzDUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E08C812296;
 Tue, 28 May 2024 13:05:21 +0000 (UTC)
Received: from localhost (unknown [10.39.195.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 878C92026D68;
 Tue, 28 May 2024 13:05:20 +0000 (UTC)
Date: Tue, 28 May 2024 09:05:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Message-ID: <20240528130518.GA993828@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527195944.GA913874@fedora.redhat.com>
 <ZlV+Su4hziCFymVt@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ybV8HJEIOH+RVjI1"
Content-Disposition: inline
In-Reply-To: <ZlV+Su4hziCFymVt@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ybV8HJEIOH+RVjI1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 02:48:42PM +0800, Zhao Liu wrote:
> Hi Stefan,
>=20
> On Mon, May 27, 2024 at 03:59:44PM -0400, Stefan Hajnoczi wrote:
> > Date: Mon, 27 May 2024 15:59:44 -0400
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
> >=20
> > On Mon, May 27, 2024 at 04:14:15PM +0800, Zhao Liu wrote:
> > > Hi maintainers and list,
> > >=20
> > > This RFC series attempts to re-implement simpletrace.py with Rust, wh=
ich
> > > is the 1st task of Paolo's GSoC 2024 proposal.
> > >=20
> > > There are two motivations for this work:
> > > 1. This is an open chance to discuss how to integrate Rust into QEMU.
> > > 2. Rust delivers faster parsing.
> > >=20
> > >=20
> > > Introduction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Code framework
> > > --------------
> > >=20
> > > I choose "cargo" to organize the code, because the current
> > > implementation depends on external crates (Rust's library), such as
> > > "backtrace" for getting frameinfo, "clap" for parsing the cli, "rex" =
for
> > > regular matching, and so on. (Meson's support for external crates is
> > > still incomplete. [2])
> > >=20
> > > The simpletrace-rust created in this series is not yet integrated into
> > > the QEMU compilation chain, so it can only be compiled independently,=
 e.g.
> > > under ./scripts/simpletrace/, compile it be:
> > >=20
> > >     cargo build --release
> >=20
> > Please make sure it's built by .gitlab-ci.d/ so that the continuous
> > integration system prevents bitrot. You can add a job that runs the
> > cargo build.
>=20
> Thanks! I'll do this.
>=20
> > >=20
> > > The code tree for the entire simpletrace-rust is as follows:
> > >=20
> > > $ script/simpletrace-rust .
> > > .
> > > =E2=94=9C=E2=94=80=E2=94=80 Cargo.toml
> > > =E2=94=94=E2=94=80=E2=94=80 src
> > >     =E2=94=94=E2=94=80=E2=94=80 main.rs   // The simpletrace logic (s=
imilar to simpletrace.py).
> > >     =E2=94=94=E2=94=80=E2=94=80 trace.rs  // The Argument and Event a=
bstraction (refer to
> > >                   // tracetool/__init__.py).
> > >=20
> > > My question about meson v.s. cargo, I put it at the end of the cover
> > > letter (the section "Opens on Rust Support").
> > >=20
> > > The following two sections are lessons I've learned from this Rust
> > > practice.
> > >=20
> > >=20
> > > Performance
> > > -----------
> > >=20
> > > I did the performance comparison using the rust-simpletrace prototype=
 with
> > > the python one:
> > >=20
> > > * On the i7-10700 CPU @ 2.90GHz machine, parsing and outputting a 35M
> > > trace binary file for 10 times on each item:
> > >=20
> > >                       AVE (ms)       Rust v.s. Python
> > > Rust   (stdout)       12687.16            114.46%
> > > Python (stdout)       14521.85
> > >=20
> > > Rust   (file)          1422.44            264.99%
> > > Python (file)          3769.37
> > >=20
> > > - The "stdout" lines represent output to the screen.
> > > - The "file" lines represent output to a file (via "> file").
> > >=20
> > > This Rust version contains some optimizations (including print, regul=
ar
> > > matching, etc.), but there should be plenty of room for optimization.
> > >=20
> > > The current performance bottleneck is the reading binary trace file,
> > > since I am parsing headers and event payloads one after the other, so
> > > that the IO read overhead accounts for 33%, which can be further
> > > optimized in the future.
> >=20
> > Performance will become more important when large amounts of TCG data is
> > captured, as described in the project idea:
> > https://wiki.qemu.org/Internships/ProjectIdeas/TCGBinaryTracing
> >=20
> > While I can't think of a time in the past where simpletrace.py's
> > performance bothered me, improving performance is still welcome. Just
> > don't spend too much time on performance (and making the code more
> > complex) unless there is a real need.
>=20
> Yes, I agree that it shouldn't be over-optimized.
>=20
> The logic in the current Rust version is pretty much a carbon copy of
> the Python version, without additional complex logic introduced, but the
> improvements in x2.6 were obtained by optimizing IO:
>=20
> * reading the event configuration file, where I called the buffered
>   interface,
> * and the output formatted trace log, which I output all via std_out.lock=
()
>   followed by write_all().
>=20
> So, just the simple tweak of the interfaces brings much benefits. :-)
>=20
> > > Security
> > > --------
> > >=20
> > > This is an example.
> > >=20
> > > Rust is very strict about type-checking, and it found timestamp rever=
sal
> > > issue in simpletrace-rust [3] (sorry, haven't gotten around to digging
> > > deeper with more time)...in this RFC, I workingaround it by allowing
> > > negative values. And the python version, just silently covered this
> > > issue up.
> > >
> > > Opens on Rust Support
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Meson v.s. Cargo
> > > ----------------
> > >=20
> > > The first question is whether all Rust code (including under scripts)
> > > must be integrated into meson?
> > >=20
> > > If so, because of [2] then I have to discard the external crates and
> > > build some more Rust wheels of my own to replace the previous external
> > > crates.
> > >=20
> > > For the main part of the QEMU code, I think the answer must be Yes, b=
ut
> > > for the tools in the scripts directory, would it be possible to allow
> > > the use of cargo to build small tools/program for flexibility and
> > > migrate to meson later (as meson's support for rust becomes more
> > > mature)?
> >=20
> > I have not seen a satisfying way to natively build Rust code using
> > meson. I remember reading about a tool that converts Cargo.toml files to
> > meson wrap files or something similar. That still doesn't feel great
> > because upstream works with Cargo and duplicating build information in
> > meson is a drag.
> >=20
> > Calling cargo from meson is not ideal either, but it works and avoids
> > duplicating build information. This is the approach I would use for now
> > unless someone can point to an example of native Rust support in meson
> > that is clean.
> >=20
> > Here is how libblkio calls cargo from meson:
> > https://gitlab.com/libblkio/libblkio/-/blob/main/src/meson.build
> > https://gitlab.com/libblkio/libblkio/-/blob/main/src/cargo-build.sh
>=20
> Many thanks! This is a good example and I'll try to build similarly to
> it.
>=20
> > >=20
> > >=20
> > > External crates
> > > ---------------
> > >=20
> > > This is an additional question that naturally follows from the above
> > > question, do we have requirements for Rust's external crate? Is only =
std
> > > allowed?
> >=20
> > There is no policy. My suggestion:
> >=20
> > If you need a third-party crate then it's okay to use it, but try to
> > minimize dependencies. Avoid adding dependening for niceties that are
> > not strictly needed. Third-party crates are a burden for package
> > maintainers and anyone building from source. They increase the risk that
> > the code will fail to build. They can also be a security risk.
>=20
> Thanks for the suggestion, that's clear to me, I'll try to control the
> third party dependencies.
>=20
> > >=20
> > > Welcome your feedback!
> >=20
> > It would be easier to give feedback if you implement some examples of
> > TCG binary tracing before rewriting simpletrace.py. It's unclear to me
> > why simpletrace needs to be rewritten at this point. If you are
> > extending the simpletrace file format in ways that are not suitable for
> > Python or can demonstrate that Python performance is a problem, then
> > focussing on a Rust simpletrace implementation is more convincing.
> >=20
> > Could you use simpletrace.py to develop TCG binary tracing first?
>=20
> Yes, I can. :-)
>=20
> Rewriting in Rust does sound duplicative, but I wonder if this could be
> viewed as an open opportunity to add Rust support for QEMU, looking at
> the scripts directory to start exploring Rust support/build would be
> a relatively easy place to start.
>=20
> I think the exploration of Rust's build of the simpletrace tool under
> scripts parts can help with subsequent work on supporting Rust in other
> QEMU core parts.
>=20
> From this point, may I ask your opinion?
>=20
> Maybe later, Rust-simpletrace and python-simpletrace can differ, e.g.
> the former goes for performance and the latter for scalability.

Rewriting an existing, maintained component without buy-in from the
maintainers is risky. Mads is the maintainer of simpletrace.py and I am
the overall tracing maintainer. While the performance improvement is
nice, I'm a skeptical about the need for this and wonder whether thought
was put into how simpletrace should evolve.

There are disadvantages to maintaining multiple implementations:
- File format changes need to be coordinated across implementations to
  prevent compatibility issues. In other words, changing the
  trace-events format becomes harder and discourages future work.
- Multiple implementations makes life harder for users because they need
  to decide between implementations and understand the trade-offs.
- There is more maintenance overall.

I think we should have a single simpletrace implementation to avoid
these issues. The Python implementation is more convenient for
user-written trace analysis scripts. The Rust implementation has better
performance (although I'm not aware of efforts to improve the Python
implementation's performance, so who knows).

I'm ambivalent about why a reimplementation is necessary. What I would
like to see first is the TCG binary tracing functionality. Find the
limits of the Python simpletrace implementation and then it will be
clear whether a Rust reimplementation makes sense.

If Mads agrees, I am happy with a Rust reimplementation, but please
demonstrate why a reimplementation is necessary first.

Stefan

--ybV8HJEIOH+RVjI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZV1o4ACgkQnKSrs4Gr
c8jW9wgAvm4+S6rN4MzpZkkQ0m5l598uEapDzRTgXr0aT48A63eNDmKY62JToqol
voEI/QWDCj/d9/ihAQbNva5aTzFV0szZuHq1Y3jlTN3iEnI4hwKinfwVTjkPBgRb
D78D0UxGYQ8R1Rm1rezAnNuSBP2KEL/HdKCqsoDaY1rvE5cL2Q1tnMteEORpo8eD
kDDVhD7cxbJfxNTMsB7D/Nni9hcV40gB+n3TOBD6wSrNNkBOGJggsyImHLTPO2G/
g8AI2cEfmEdBVv04LUdlGb2GwR8q3LoRAblOljXvfN7kv0RKmRWHQRoeivz/kLA1
ZZaTVPf5meQ989pt/QPyTmhRW155VA==
=LcOd
-----END PGP SIGNATURE-----

--ybV8HJEIOH+RVjI1--


