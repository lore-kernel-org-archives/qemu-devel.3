Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433EAC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHffi-0005fk-P3; Wed, 21 May 2025 05:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHffh-0005fG-8i
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:23:33 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHffe-0007w9-OA
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:23:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-601fb2b7884so4632337a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747819409; x=1748424209; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfIOo8IDzgQ3SnejEatqubQzae4yfAZCjfO8jfxjoxE=;
 b=y3K6hiMLmFjsqdKrHzYfF/asA547KEvHziQ5KjC5Q2QEtbAVQF5AhkJPupKJJmU3nd
 dyh7E4Q8PQM+ASbaeRFc4lqqZyY6AX0zKpzMwGpuAZZX7kHJi/gbwku2OiKVKcoApIpU
 Cqurx3Sk+OmT3yMjm2Cnqv6540NZW971zXdR9ZLI+X8picK0hsFZUFV+SNx+MJ25Awfc
 gad982Na/ZQn7QnP2AJxD+Za+ImC512+wAX7rt2xN+nkDVsjAwfzr44TABjduLpHPLIf
 9vvjbSovrV/o4Isrpl0y0bcAmpaIfRbKTZWjFK57vEy8/HkEdM1H/vwyKqrichIjrm1O
 LUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747819409; x=1748424209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfIOo8IDzgQ3SnejEatqubQzae4yfAZCjfO8jfxjoxE=;
 b=I7K5mGSPDw6u+X2tzZqIC0YJYqBa38JnuOuzjT3ugtYOIuA47VmadkqGRCAKGtbSU6
 iUhueg+OZZqg5Wg4MtRaRXLH1bMod2gBO7nyFFmL4H8iDYPn/Nlcon9e62OHnPEpnYTC
 xz/EvibtmU3r5rSbeAvGx6xJ2zzwUoHdqgo9tIop/9yxpmiyHdTY3anvcb5k76SKc2NS
 lA3tFzRFJjz8cqkiP8pkigtRhwnHzbLnPJ7IewtEZ7ZeL8YDESsQJG0RG/37BEX69Dpe
 ayUU9gTYFBaNsKACiT9fgOpfbkcce93TpZOqLaIX8p+p8zyZIYemzciZhp5JLZDxxRch
 PWkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7NY2c/uYycpWmVWzO20AipZBsj4+5qZLy+L4RRA9qBckCB4825XlcNCnxGk9t5NCTVLNDllDCwqvN@nongnu.org
X-Gm-Message-State: AOJu0YxmKaxb0ahhaAHnAif3Ix4JbcEcms0OTjur1vdZ4JhSb7e6IFm5
 U3M8tWZ60qsFrs7cVHxvlgt6W30zXr2ASX/19B6a4PxntNaSqL/1BTW00T3CEHvh+44eQZ1w1Rz
 VQk3quboZVVDlInd2WZx0A00s/Wi9Q17VsBID4jarlA==
X-Gm-Gg: ASbGncvcNdUOa18vjLk0dULpsP1qe+cS3vFPifvBIVtPGkPSVpxIacbdsElJ+vMSIH8
 1FyTqhPd8/ZofpAEX+HfSC+/Mh/I/xtHhM/4p866gkJBHiSF1I86r53Nb6FC84ztYWR0WfiW+GQ
 uaG4Cro2zTLDuBcED8B/s4ElEvWnU2
X-Google-Smtp-Source: AGHT+IH4vUBZ78nVMTwecwnMF/FcXMpOh7ksyMkAstIv+1vtkovVY7H1DMlMspTMlh+RxIIvb4vmDBv9Rm7QfwyaAtI=
X-Received: by 2002:a17:907:9408:b0:ad5:28a4:8205 with SMTP id
 a640c23a62f3a-ad536bc9cd5mr1742791366b.15.1747819408703; Wed, 21 May 2025
 02:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250521081845.496442-1-pbonzini@redhat.com>
 <20250521081845.496442-2-pbonzini@redhat.com>
 <aC2O0iNVZZMQUpjQ@redhat.com>
In-Reply-To: <aC2O0iNVZZMQUpjQ@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 21 May 2025 12:23:02 +0300
X-Gm-Features: AX0GCFsNaSUxYKPjR1sdqQEHbT7S3RzFpy8oWRN-8o6mV7CeUbSRstpRM3cjNNo
Message-ID: <CAAjaMXbuCFh3pY+Q=u1r5vGVf_a1kveyoeVgSOEPa8zwRicj_A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] rust: add "bits", a custom bitflags implementation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, May 21, 2025 at 11:29=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Wed, May 21, 2025 at 10:18:40AM +0200, Paolo Bonzini wrote:
> > One common thing that device emulation does is manipulate bitmasks, for=
 example
> > to check whether two bitmaps have common bits.  One example in the pl01=
1 crate
> > is the checks for pending interrupts, where an interrupt cause correspo=
nds to
> > at least one interrupt source from a fixed set.
> >
> > Unfortunately, this is one case where Rust *can* provide some kind of
> > abstraction but it does so with a rather Perl-ish There Is More Way To
> > Do It.  It is not something where a crate like "bilge" helps, because
> > it only covers the packing of bits in a structure; operations like "are
> > all bits of Y set in X" almost never make sense for bit-packed structs;
> > you need something else, there are several crates that do it and of cou=
rse
> > we're going to roll our own.
> >
> > In particular I examined three:
> >
> > - bitmask (https://docs.rs/bitmask/0.5.0/bitmask/) does not support con=
st
> >   at all.  This is a showstopper because one of the ugly things in the
> >   current pl011 code is the ugliness of code that defines interrupt mas=
ks
> >   at compile time:
> >
> >     pub const E: Self =3D Self(Self::OE.0 | Self::BE.0 | Self::PE.0 | S=
elf::FE.0);
> >
> >   or even worse:
> >
> >     const IRQMASK: [u32; 6] =3D [
> >       Interrupt::E.0 | Interrupt::MS.0 | Interrupt::RT.0 | Interrupt::T=
X.0 | Interrupt::RX.0,
> >       ...
> >     }
> >
> >   You would have to use roughly the same code---"bitmask" only helps wi=
th
> >   defining the struct.
> >
> > - bitmask_enum (https://docs.rs/bitmask-enum/2.2.5/bitmask_enum/) does =
not
> >   have a good separation of "valid" and "invalid" bits, so for example =
"!x"
> >   will invert all 16 bits if you choose u16 as the representation -- ev=
en if
> >   you only defined 10 bits.  This makes it easier to introduce subtle b=
ugs
> >   in comparisons.
> >
> > - bitflags (https://docs.rs/bitflags/2.6.0/bitflags/) is generally the =
most
> >   used such crate and is the one that I took most inspiration from with
> >   respect to the syntax.  It's a pretty sophisticated implementation,
> >   with a lot of bells and whistles such as an implementation of "Iter"
> >   that returns the bits one at a time.
> >
> > The main thing that all of them lack, however, is a way to simplify the
> > ugly definitions like the above.  "bitflags" includes const methods tha=
t
> > perform AND/OR/XOR of masks (these are necessary because Rust operator
> > overloading does not support const yet, and therefore overloaded operat=
ors
> > cannot be used in the definition of a "static" variable), but they beco=
me
> > even more verbose and unmanageable, like
> >
> >   Interrupt::E.union(Interrupt::MS).union(Interrupt::RT).union(Interrup=
t::TX).union(Interrupt::RX)
> >
> > This was the main reason to create "bits", which allows something like
> >
> >   bits!(Interrupt: E | MS | RT | TX | RX)
> >
> > and expands it 1) add "Interrupt::" in front of all identifiers 2) conv=
ert
> > operators to the wordy const functions like "union".  It supports boole=
an
> > operators "&", "|", "^", "!" and parentheses, with a relatively simple
> > recursive descent parser that's implemented in qemu_api_macros.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/Cargo.lock                  |   7 +
> >  rust/Cargo.toml                  |   1 +
> >  rust/bits/Cargo.toml             |  19 ++
> >  rust/bits/meson.build            |  12 +
> >  rust/bits/src/lib.rs             | 441 +++++++++++++++++++++++++++++++
> >  rust/meson.build                 |   1 +
> >  rust/qemu-api-macros/src/bits.rs | 227 ++++++++++++++++
> >  rust/qemu-api-macros/src/lib.rs  |  12 +
> >  8 files changed, 720 insertions(+)
> >  create mode 100644 rust/bits/Cargo.toml
> >  create mode 100644 rust/bits/meson.build
> >  create mode 100644 rust/bits/src/lib.rs
> >  create mode 100644 rust/qemu-api-macros/src/bits.rs
>
> > diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
> > new file mode 100644
> > index 00000000000..d80a6263f1e
> > --- /dev/null
> > +++ b/rust/bits/src/lib.rs
> > @@ -0,0 +1,441 @@
>
> This (and other new .rs files) needs SPDX-License-Identifier

We should probably lint for this in .rs files.


--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

