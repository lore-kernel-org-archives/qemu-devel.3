Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB17C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 06:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJRup-0008Ug-TN; Tue, 18 Jun 2024 02:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJRuh-0008Rs-1K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 02:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJRue-0008Pg-93
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 02:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718690507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dzW5+CLl2xU46GPPrjz2Si01CzyPSnv4LE9zeeINKc=;
 b=D9bZmO8i+kGgYynRCdkc/ESnhLC2KF6+k86p338EcLfZSD293eWxVEzNEof1x8cYVqP5ef
 8EFdZzURUCkn7/cW/JV/Sx8Ca0UssYNzTuc26rdFJsGV3Mer4k02Yg8H1EtsUu5BlYGnuw
 ZiMnbZVNKteRzhYHeIskXPMMo5Kh2Ww=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-2OiraVZiM0CM_6EPVHF-9A-1; Tue, 18 Jun 2024 02:01:41 -0400
X-MC-Unique: 2OiraVZiM0CM_6EPVHF-9A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c0bfd6a89so3432231e87.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 23:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718690500; x=1719295300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dzW5+CLl2xU46GPPrjz2Si01CzyPSnv4LE9zeeINKc=;
 b=d8pQcSCX2ZDwWBEAzXv7Z8Ea0IE8kGC5pW72qEfM/dBc/mLWZWrSlfUUYRxW9mFtOx
 hw5aaNAOynGxzZjVNJtU6kIWhtS1lnBog6Vc1mEbQu0os18dd74yoYjAaBypTrsZy5qA
 m8OJYVPuR0o7xS3ZnypSNwQxRIFpAaNOR1UQmM2u+191HOIEAq8JEj5OQficGbdzfxUL
 YUKl5duaUi5ZRCCdO0Re/MLQaOHoXW7CdEN1WK4CSnlCA3Lrmc1aftkcfeX1Wjt8sCpS
 K9knO7YFAZpxOZ6yJi06ouK8hRrxKP4PJnpEywgQXZq4k1O9ZowC3kKzGpVnxT9m20F9
 d61Q==
X-Gm-Message-State: AOJu0Yw/3i0LTq3si+Wg/u5UZLRyzEvPUi/dGPKX2DXUwKRf+gPHZcf6
 7J6ga5H+MQwrq4qOADnEG+n6AcZAQF8GP/JMYD5eOnwbUxj1zSobdRRrDKkToJMhlg7UgvqJg4N
 mnXt8m1MdTjzBqyV1nfGNvZ6O4Nss31x4Tcuc34EdnEr0Z3XC9TX2X/vAz78DnpbahHJH0/FWsx
 E2ELOjdNHgzw3j6nF1j+HS2WGmcko=
X-Received: by 2002:a19:ac03:0:b0:52c:4cfa:c5a6 with SMTP id
 2adb3069b0e04-52ca6e6d56dmr5745485e87.34.1718690499906; 
 Mon, 17 Jun 2024 23:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo8eU9EGbQzuD7GTvNf4SbPWHCaaPY9OshuZ5yro6USCh592XxtrMWEY32UD3VD/s1nSOZnN6gUpqfnqFjWIg=
X-Received: by 2002:a19:ac03:0:b0:52c:4cfa:c5a6 with SMTP id
 2adb3069b0e04-52ca6e6d56dmr5745466e87.34.1718690499440; Mon, 17 Jun 2024
 23:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
 <f7vmg.s9przvzs9y9y@linaro.org>
 <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
 <f89qp.6kmlv39qhntz@linaro.org>
 <CABgObfYj3F6aoefBgcHcjkwDqK6kcDGUfPZtRbFzB5abXShfbA@mail.gmail.com>
 <f8v3w.uqub97dfqvvo@linaro.org>
In-Reply-To: <f8v3w.uqub97dfqvvo@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Jun 2024 08:00:00 +0200
Message-ID: <CABgObfbDJHp8bE7fTuOEHvq7m6tOjgYxmU6xUu26Lq9gKzATpw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

Il lun 17 giu 2024, 23:45 Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> ha scritto:
> Secondly, are you implying that these callbacks are not operated under
> the BQL?

No, I'm implying that if you had the following nested calls:

 unsafe read callback receives the opaque point
   -> cast to &mut to call safe read callback
     -> chardev function accessing the opaque value
       -> unsafe chardev callback receives the opaque pointer
         -> cast to & or &mut to call safe chardev callback

Then you would violate the Rust invariant that there can only be one
active reference at a single time if it is &mut. The only exception is
that you can create an &mut UnsafeCell<T> for an active
&UnsafeCell<T>.

It doesn't matter if this cannot happen because of invariants in the
QEMU code. If you are writing safe Rust, every cast to &mut requires
very strong justification. The way you do it instead is to use
RefCell, and borrow_mut() instead of casting to &mut. This way, at
least, the invariant is checked at runtime.

And in fact this _can_ happen. I hadn't checked until now because I
was mostly worried about the conceptual problem, not any specific way
undefined behavior can happen. But here it is:

PL011State::read takes &mut
  -> qemu_chr_fe_accept_input
    -> mux_chr_accept_input
      -> pl011_can_receive
        -> creates & which is undefined behavior

You probably can write a 20 lines test case in pure Rust that miri
complains about.

Should we make it a requirement for v3, that all callback methods in
PL011State (read, write, can_receive, receive, event) take a &self and
achieve interior mutability through RefCell? Probably not, a comment
is enough even though technically this is _not_ valid Rust. But it is
a high priority task after the initial commit.

> Just say this directly instead of writing all these amounts of text

I said in the first review that the state should be behind a RefCell.

https://lore.kernel.org/qemu-devel/CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=3Dt=
6eoBcdACAE=3DNA@mail.gmail.com/

> Finally, this is Rust code. You cannot turn off the type system, you
> cannot turn off the borrow checker, you can only go around creating new
> types and references out of raw memory addresses and tell the compiler
> 'trust me on this'

I am sorry if this sounds condescending. But this is _exactly_ what
I'm complaining about: that there is too much trust placed in the
programmer.

Converting from * to & does not turn off the borrow checker, but still
you cannot trust anymore what the borrow checker says; and that's why
you do it inside an abstraction, not in each and every callback of
each and every device. This is what Marc-Andr=C3=A9 did for QAPI; and he
probably erred in the other direction for a PoC, but we _must_ agree
that something as complete as his work is the direction that we _have_
to take.

Again: I am sorry that you feel this way about my remark, because I
thought I had only praised your work. I didn't think I was being
condescending or dismissing. But I am worried that without the proper
abstractions this is going to be a technical debt magnet with only
marginal benefits over C.

And frankly I am saying this from experience. Check out CVE-2019-18960
which was an out of bounds access in Firecracker caused by not using
proper abstractions for DMA. And that's in a 100% Rust code base.
Since we're starting from and interfacing with C it's only going to be
worse; skimping on abstractions is simply something that we cannot
afford.

It's also the way Linux is introducing Rust in the code base. Whenever
something needs access to C functionality they introduce bindings to
it. It's slower, but it's sustainable.

> Ignoring that misses the entire point of Rust. The
> statement 'this is not Rust code but as good as C' is dishonest and
> misguided. Check for example the source code of the nix crate, which
> exposes libc and various POSIX/*nix APIs. Is it the same as C and not
> Rust code?

That's exactly my point. Libc provides mostly unsafe functions, which
is on the level of what bindgen generates. Other crates on top provide
*safe abstractions* such as nix's Dir
(https://docs.rs/nix/0.29.0/nix/dir/struct.Dir.html). If possible,
leaf crates use safe Rust (nix), and avoid unsafe (libc) as much as
possible.

Instead you're using the unsafe functions in the device itself. It's
missing an equivalent of nix.

> If you have specific scenarios in mind where such things exist in the
> code and end up doing invalid behavior please be kind and write them
> down explicitly and demonstrate them on code review.

It doesn't matter whether they exist or not. The point of Rust is that
the type system ensures that these invalid behaviors are caught either
at compile time or (with RefCell) at run time. As things stand, your
code cannot catch them and the language provides a false sense of
security.

On the other hand, I want to be clear agin that this is not a problem
at all=E2=80=94but only as long as we agree that it's not the desired final
state

> This approach of
> 'yes but no' is not constructive because it is not addressing any
> specific problems directly. Instead it comes out as vague dismissive FUD
> and I'm sure that is not what you or anyone else wants.
>
> Please take some time to understand my POV here, it'd help both of us
> immensely.

I can ask the same though. Please take the time to understand that I
am not being dismissive! My position is exactly "yes but no". Yes,
this is a great way to introduce Rust in the code base. No, this is
not a sustainable way to mix Rust and C=E2=80=94but I am willing to help.

Paolo

>
> Sincerely thank you in advance,
> Manos
>


