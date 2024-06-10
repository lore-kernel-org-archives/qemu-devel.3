Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C36C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 20:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGlvk-0005Mw-P8; Mon, 10 Jun 2024 16:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sGlvi-0005Mh-IR
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:47:50 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sGlvg-00035h-5J
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:47:50 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5b9778bb7c8so165782eaf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718052466; x=1718657266; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FlO9G4dVlhQdd8xNRAN49jicsXnu95KlQ2748b/u650=;
 b=V3cYcWm7S+y9Hw1ieWJpZkHhNER66oLcVAqxD5GGRqRbn/zKs5jZmCNwVGDmH3mVyD
 eRo0gAqBv76E/COtmRoFKQLkhEEAOKf8DtxhTLIhZjMENq7hREhtlk18HZGdm1KeiKiZ
 qTgH/Hua2E6liGbzO6McSop9rUJyoSEtg768JAKngAJSHL2tFgTDucmxecHf1apB+jkJ
 nQYacwVBOxSfPVbG0QRqNVQKEoD5cHb5lH9ymSU6u/wT+hqlx70MAnpKDZDjTrbSzykw
 kkuB3phA04yd17LpiU0MhejnUXXDAd4dtlmgjyR3t4w6Sxht2QjJTAfeoTSK48AdTPq7
 mi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718052466; x=1718657266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FlO9G4dVlhQdd8xNRAN49jicsXnu95KlQ2748b/u650=;
 b=oIzwtiFCsdgwS437CUJVfx2JTy513x/svTg65qErKtrJ8GZsbTJ+1RQk8Hl+oOJVYf
 5m7mUfkHVHqcN81f47rTW0AOluh7wR+NhaZw4C2Sp3a8r0G7/uAa9MnaiXEEGk8Ec2tz
 L0loZOPS0a0nTVAtB5itvc/909Gp1yszKs/1iadEtWmIimG5xaE7hATPXQm9x6juIz19
 eCpYXUPup2FnQnJQXn696SpH3CcdlHYhp22nMrWvTWlWmAkClbFO2iAcVvSsmkE4e8Gb
 wYDfKu+4WatTO+OEspXq7ZhO7tcg2PFrGWLBIW+vD5XdsrkiuUGsdAneBacs/rAhEwMZ
 2a7Q==
X-Gm-Message-State: AOJu0YzoY4cUpPQnNYXL1DhYj4eyuUHNU73pofkVn4jP0RnKhYuSeEnQ
 szK75KBpAJLAwkfu7/Vf0tdDqjIE4Nz2dG8tLLdSTWcT/L45suQMyrMq+Q5ds1RlzAHyoyog+Ew
 RDIWAG3+cpFd49QBCRIhBOEflrJo=
X-Google-Smtp-Source: AGHT+IG3CfhlcEx/oa7XhrmBOtxs8XP1hUtWzQd9vhFXOk4SV5vhzU+VS/qGcyOfuFEEKoElXh6uO52fDAQwbhCAcYg=
X-Received: by 2002:a05:6820:1c90:b0:5ba:e2cb:c853 with SMTP id
 006d021491bc7-5bae2cbd02cmr5202832eaf.5.1718052465257; Mon, 10 Jun 2024
 13:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
 <evsu7.aus3yo6r56i@linaro.org>
In-Reply-To: <evsu7.aus3yo6r56i@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Jun 2024 16:47:33 -0400
Message-ID: <CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 10 Jun 2024 at 16:27, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Mon, 10 Jun 2024 22:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >> What are the issues with not using the compiler, rustc, directly?
> >> -----------------------------------------------------------------
> >> [whataretheissueswith] Back to [TOC]
> >>
> >> 1. Tooling
> >>    Mostly writing up the build-sys tooling to do so. Ideally we'd
> >>    compile everything without cargo but rustc directly.
> >
> >Why would that be ideal?
>
> It remove the indirection level of meson<->cargo<->rustc. I don't have a
> concrete idea on how to tackle this, but if cargo ends up not strictly
> necessary, I don't see why we cannot use one build system.

The convenience of being able to use cargo dependencies without
special QEMU meson build system effort seems worth the overhead of
meson<->cargo<->rustc to me. There is a blog post that explores using
cargo crates using meson's wrap dependencies here, and it seems like
extra work:
https://coaxion.net/blog/2023/04/building-a-gstreamer-plugin-in-rust-with-meson-instead-of-cargo/

It's possible to use just meson today, but I don't think it's
practical when using cargo dependencies.

>
> >
> >>
> >>    If we decide we need Rust's `std` library support, we could
> >>    investigate whether building it from scratch is a good solution. This
> >>    will only build the bits we need in our devices.
> >
> >Whether or not to use std is a fundamental decision. It might be
> >difficult to back from std later on. This is something that should be
> >discussed in more detail.
> >
> >Do you want to avoid std for maximum flexibility in the future, or are
> >there QEMU use cases today where std is unavailable?
>
> For flexibility, and for being compatible with more versions.
>
> But I do not want to avoid it, what I am saying is we can do a custom
> build of it instead of linking to the rust toolchain's prebuilt version.

What advantages does a custom build of std bring?

>
> >
> >>
> >> 2. Rust dependencies
> >>    We could go without them completely. I chose deliberately to include
> >>    one dependency in my UART implementation, `bilge`[0], because it has
> >>    an elegant way of representing typed bitfields for the UART's
> >>    registers.
> >>
> >> [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
> >>      Crates.io page: https://crates.io/crates/bilge
> >>      Repository: https://github.com/hecatia-elegua/bilge
> >
> >I guess there will be interest in using rust-vmm crates in some way.
> >
> >Bindings to platform features that are not available in core or std
> >will also be desirable. We probably don't want to reinvent them.
>
>
> Agreed.
>
> >
> >>
> >> Should QEMU use third-party dependencies?
> >> -----------------------------------------
> >> [shouldqemuusethirdparty] Back to [TOC]
> >>
> >> In my personal opinion, if we need a dependency we need a strong
> >> argument for it. A dependency needs a trusted upstream source, a QEMU
> >> maintainer to make sure it us up-to-date in QEMU etc.
> >>
> >> We already fetch some projects with meson subprojects, so this is not a
> >> new reality. Cargo allows you to define "locked" dependencies which is
> >> the same as only fetching specific commits by SHA. No suspicious
> >> tarballs, and no disappearing dependencies a la left-pad in npm.
> >>
> >> However, I believe it's worth considering vendoring every dependency by
> >> default, if they prove to be few, for the sake of having a local QEMU
> >> git clone buildable without network access.
> >
> >Do you mean vendoring by committing them to qemu.git or just the
> >practice of running `cargo vendor` locally for users who decide they
> >want to keep a copy of the dependencies?
>
>
> Committing, with an option to opt-out. They are generally not big in
> size. I am not of strong opinion on this one, I'm very open to
> alternatives.

Fedora and Debian want Rust applications to use distro-packaged
crates. No vendoring and no crates.io online access. It's a bit of a
pain because Rust developers need to make sure their code works with
whatever version of crates Fedora and Debian provide.

The `cargo vendor` command makes it easy for anyone wishing to collect
the required dependencies for offline builds (something I've used for
CentOS builds where vendoring is allowed).

I suggest not vendoring packages in qemu.git. Users can still run
`cargo vendor` for easy offline builds.

>
>
> >>
> >> Should QEMU provide wrapping Rust APIs over QEMU internals?
> >> -----------------------------------------------------------
> >> [qemuprovidewrappingrustapis] Back to [TOC]
> >>
> >> My personal opinion is no, with the reasoning being that QEMU internals
> >> are not documented or stable. However I do not see why creating stable
> >> opt-in interfaces is bad. It just needs someone to volunteer to maintain
> >> it and ensure there are no breakages through versions.
> >
> >Rust code will need to interface with QEMU's C APIs, so Rust wrappers
> >seem unavoidable. Using a protocol like vhost-user might be possible
> >in some cases. It separates the two codebases so they can both be
> >native and without bindings, but that won't work for all parts of the
> >QEMU source tree.
> >
> >Stable APIs aren't necessary if most developers in the QEMU community
> >are willing to work in both languages. They can adjust both C and Rust
> >code when making changes to APIs. I find this preferable to having
> >Rust maintainers whose job is to keep wrappers up-to-date. Those Rust
> >maintainers would probably burn out. This seems like a question of
> >which approach the developer community is comfortable with.
>
>
> Me too.
>
> >
> >>
> >> Will QEMU now depend on Rust and thus not build on my XYZ platform?
> >> -------------------------------------------------------------------
> >> [qemudependonrustnotbuildonxyz] Back to [TOC]
> >>
> >> No, worry about this in some years if this experiment takes off. Rust
> >> has broad platform support and is present in most distro package
> >> managers. In the future we might have gcc support for it as well.
> >>
> >> For now, Rust will have an experimental status, and will be aimed to
> >> those who wish to try it. I leave it to the project leaders to make
> >> proper decisions and statements on this if necessary.
> >
> >This can be discussed in a separate email thread if you prefer, but I
> >do think it needs agreement soon so that people have the confidence to
> >invest their time in writing Rust. They need to know that the code
> >they develop will be available on most platforms where QEMU is
> >available and that others in the community won't object or insist on a
> >C implementation for platform support reasons.
>
> Definitely, also it's out of scope for this RFC since we're not writing
> and rules/guidelines yet.
>
> >
> >>
> >>
> >> How is the compilation structured?
> >> ==================================
> >> [howisthecompilationstructured] Back to [TOC]
> >>
> >> First, a meson target that runs `bindgen` on a bunch of header files
> >> (defined in `rust/wrapper.h`) is created as a target and as a dependency
> >> for any rust hardware device that needs it. You can see the generated
> >> bindings by running
> >>
> >>   ninja generated.rs
> >>
> >> inside your build directory.
> >>
> >> The devices are defined as dictionaries in rust/meson.build because they
> >> depend on the bindgen dependency, which is available much later in the
> >> meson process (when the static qemu lib and target emulator executables
> >> are defined).
> >>
> >> A cargo wrapper python script under scripts/ exists to build the crate
> >> library, by providing the path to the generated.rs bindings via the
> >> environment. Then, the qemu-system-aarch64 binary links against the
> >> staticlib archive (i.e. libpl011.a)
> >>
> >> The generated.rs rust file includes a bunch of junk definitions?
> >> ================================================================
> >> [generatedrsincludesjunk] Back to [TOC]
> >>
> >> Yes, bindgen allows you to block certain types and identifiers from
> >> being generated but they are simply too many. I have trimmed some of the
> >> fat but vast improvements can be made.
> >>
> >> The staticlib artifact contains a bunch of mangled .o objects?
> >> ==============================================================
> >> [staticlibmangledobjects] Back to [TOC]
> >>
> >> Yes, until we compile without the `std` module library or we compile it
> >> manually instead of linking it, we will have some junk in it.
> >
> >What is the consequence of this? As long as the linker is bringing in
> >.o files from the .a only through symbol dependencies, then unused .o
> >files in the .a won't be linked into the final QEMU binary.
>
> No consequence, I just want to warn anyone peeking into the rust output
> (not the final qemu binary) to expect junk.

Okay, cool!

