Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D469C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 09:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujac2-0001f8-9Q; Wed, 06 Aug 2025 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujaYL-0007er-Ai
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:35:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujaYI-0004Wv-8n
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:35:21 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61576e33ce9so1438470a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754472912; x=1755077712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LD2lCNsd6lEHCWwKnmUA2r4S+PwKO82t2CW4LjzUN68=;
 b=a2ejkzbyPRGryWj0+ABieI/14xSmwQEglVzLZ6zHFvZ7HzVVYT1N7A2R7M+F/tBykl
 3GM8ZWXDIn+P/pGUFHRcXK7UE9G2xEr9tK2zFoRjnbw52rlNNC09QPyKijAMOzOhJn1x
 8UmGImQyeRjlIJgyjsYMGpYKyQQ3E0wb7qBYP+ek7pimTA/GKMtPmgbKyDwkfhnQH4Xp
 HlJKYWzUuYhQRQF5bHnXkj+Gm8mDXbo18JJpREzOA56/L1ul1BM01/6dIG4qeJpCiaPh
 yrco8XJ7niqC5HJBNswKnOzJfcmmR1Zr3Qo1IJeXBQSgxvRxKAHjYDN8qVBrxFRCa6dL
 KkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754472912; x=1755077712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LD2lCNsd6lEHCWwKnmUA2r4S+PwKO82t2CW4LjzUN68=;
 b=TPDN39/fF33RWUgPUc4TcD3ddLUCkZzZm19rl1SVeXwo0IBFJVazawbuKsxJka0psN
 4MKXA1gRZ8wdp/i1WdK32e060qAMvbvUEQ/wqIac/YweXcKq7K/5naUtZQtVq1Hg/s8q
 juszKtadOfK542UEjTkwSCbImYUU3msUVx5Vx90z1VpJzZY/WhPJ5FZwuHnSS26hW/ud
 XOEFjoSdueTvqNvDvGMzy3IhmiiSTiI0s9rLpukAVGwei8wAHNPzUkdO8B8YFg9TMc2Y
 ZgNfVuxIFgNv3KLXtmxpljYEKwJbByfaZeZ/xyuD/Onote3qWb0hCz0RZidpd/QehJfd
 OAVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkaUuxHdd6CHMW1v2kQ2mZgBnQxleTTsUfj5gfrCcKmJIi44n6nn0HvP7JxcNoYKKJF9FRiajrDqCv@nongnu.org
X-Gm-Message-State: AOJu0Yw8CR9bLWZs+Lg6Mb7IPQ3W3+BHLuNAinhVIFbuf0Apdx/3aba7
 TYd2W8E0d7gJ/wUa7nHuvhSc3esx/qjGlQbQ1Dum+S+bKJLR2FbWuAnvfHT0WHjmcI32+nIOE0O
 Go2fU1mA264LEdHc23CIx74J8eW2ly9Ikq8fBf8NPFg==
X-Gm-Gg: ASbGncsR6I1/LkRP1Bp6/J0tXvCX+x5jwmeprZg14k1srFhHN6QG4O6tIoXDKz8cX+S
 6eSRbytFZd12fetGxEONtfKGEyisTczlyFMnracgt76hPuh6BR8/XEiNOkPYaITSN82E7I29Xyv
 GAFbe5SS798Hff9CmPNxFzQJUD9d9HbSCM6D8HYjEemU2R8+b43MOESBCoiqdZ8MMB8y6VDm9J1
 UBBXZGj3OtWdi/PtpY=
X-Google-Smtp-Source: AGHT+IEKXARD6CvRBGO6+mg556UaWV4tJq0L/HOMux+j3HAa8rDx9Pmy34HwdfoXXdUsv6wlAMWdtIQe1qeSAENgLNo=
X-Received: by 2002:a05:6402:50cb:b0:613:5257:6cad with SMTP id
 4fb4d7f45d1cf-61796e6635emr1580776a12.11.1754472911537; Wed, 06 Aug 2025
 02:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
 <aJI0mr5HDgtE9HIc@redhat.com>
 <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
 <aJJFVgkt7R49ZwIF@redhat.com>
 <CAAjaMXYhWsWPoDdfoNyTGrJSRfiYJDqBkv8fC87+Zi3YCtU06Q@mail.gmail.com>
 <ad404bb4-93fb-4a27-995f-734e647c1da0@redhat.com>
 <aJMeKejagnSK9s2_@redhat.com>
In-Reply-To: <aJMeKejagnSK9s2_@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 6 Aug 2025 12:34:44 +0300
X-Gm-Features: Ac12FXwfoxNyqhYdRvUtf6s6P8U3hgSBbuiO5eFGVSvISfVWPDnd7GJ-nqg3FW8
Message-ID: <CAAjaMXbBfB6+xnxSA=Aq9LeGY6pSqa-jbvQ92Ww9eD6tAt08FA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 6, 2025 at 12:21=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Aug 06, 2025 at 11:02:53AM +0200, Paolo Bonzini wrote:
> > On 8/5/25 22:06, Manos Pitsidianakis wrote:
> > > > If you're thinking this is all rather complicated, you'd be right,
> > > > which is why for initial feature parity I figured the simplest is
> > > > likely to just wrap the existing QEMU inline probe function, so
> > > > Rust doesn't need to know about the different backends... yet...
> >
> > It's not too hard to add individual backends (other than dtrace---see
> > below--and ust which doesn't build for me(*) and I wanted to deprecate)=
.
> > Tanish is pretty close to being able to post initial work.
>
> If we want to drop some backends that's fine, as IMHO we've got
> needlessly many there.
>
> > > Yes, that indeed makes sense.  Generated C trace headers statically
> > > linked to a standalone trace crate library for each subsystem, that
> > > rust qemu crates can link to in return is the cleanest solution for
> > > this approach IMHO, because doing this kind of codegen via macros
> > > needs interaction with meson to generate the C sources and then run
> > > bindgen all while compiling this one crate which is a single meson li=
b
> > > target.
> > >
> > > It might be possible to generate the equivalent of the C code for eac=
h
> > > backend just like this RFC generates only the log backend code, I'll
> > > take a look out of curiosity...
> > >
> > > > FWIW, the original DTrace authors created a Rust crate with native
> > > > rust integration of dynamic probes.
> > > >
> > > >    https://github.com/oxidecomputer/usdt
> > > >
> > > > I think that (somehow) we probably want to integrate that with QEMU
> > > > and its tracetool.
> >
> > This unfortunately only works for macOS and Solaris.  It also has quite=
 a
> > few dependencies (~25) on other crates.  There is also a "probe" crate
> > (https://github.com/cuviper/probe-rs) that is minimal and (currently)
> > specific to Linux, which is what I planned to use.
> >
> > By the way, while I like the idea of using Rust format strings, there a=
re
> > parts of tracetool (e.g. format/log_stap.py) that need the printf strin=
gs,
> > and also backends (e.g. backend/syslog.py) that call into libc and ther=
eforepar
> > need to use printf format strings.  So I think we're stuck.
>
> Note, I would describe our format strings as printf-like/light. We certai=
nly
> do NOT allow the full range of C library formats, because we need to be a=
ble
> to pass the format strings to systemtap, which is likewise merely printf-=
like.

That simplifies things in a major way (printf specifiers are so
complex they are turing complete). It'd be trivial to parse and
convert into equivalent Rust formatting if you constraint specifiers
like you say.

>
> Do don't really do any significant upfront validation on the format speci=
fiers
> beyond checking for invalid %m and newlines. In practical terms though th=
e
> only things we can use are
>
>   %x %u %d %s %p
>
> with optional 'l', 'll' or 'z' modifiers and digit precision for the int
> formats. Anything beyond that will likely fail with systemtap. We ought
> to move validation for this to the parsing phase to strongly enforce this
> limited syntax.
>
> IOW, in any tracetool format generator for rust, we could fairly easily
> translate the format string from printf-like to rust style.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

