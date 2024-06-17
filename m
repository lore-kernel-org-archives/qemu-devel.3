Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CECEC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDPb-00010A-HM; Mon, 17 Jun 2024 10:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJDPZ-0000zm-Sb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJDPY-0005Wu-2c
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718634763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PMI77wN1aO8HYGzDjfuEOj5Yfpf4yjV4vsZZC5l5Tw=;
 b=TspX0F4bjzLhtwYVFNMACBPAZaKUo0BsWBdEDLf/Vrpd1GfwP1/OuFux7I7fG55QCq4ulN
 Lm+mtdDRudw+bHWyPhXJKFh7mQwlCeLfW77RDe5CSZkLE3WaUUcwTor7aWqLH07Aa3XDil
 YFdB4kBEHYsZlBKqUeCuBd+vhZIpm3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-SIgJi8SlPwSBoPzggkJ_lg-1; Mon, 17 Jun 2024 10:32:40 -0400
X-MC-Unique: SIgJi8SlPwSBoPzggkJ_lg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42196394b72so28251545e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718634759; x=1719239559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PMI77wN1aO8HYGzDjfuEOj5Yfpf4yjV4vsZZC5l5Tw=;
 b=YOzZMgQbryP+uVWrASznpdWI2mznt2IN4Otb/njqf9g2CNzNuz0hL5qtjLwjzSOH7a
 6xZrG3G5m3z+zVxTHub6FXj2IKTA0TsLd5KE7tHRVl4glAF+Ys0NH/ErM5TY5vudMDaT
 bSLK178C926foMob+zap34l47C2kdQNQRsDaZoKeDaGKsPV8WSjh5X0RoEcrD+u0H3o/
 BfBirzfxXvb43I5YA2k87dzxddZD4e8aj3t1+U1SD/NKNd3G7687D2mCQF5VThLx8hRQ
 vD/NRGA3ZtTQqg3JV81ycMfK2NgFJjHKBE1vML7U+8gHg4MEDqW0WZzZlxZf1Squ2laM
 5X9w==
X-Gm-Message-State: AOJu0YxfwXzlqAy9OLgG/vlHj13HRp2HXaNHECM00WwIWmG0OL8a/RZD
 XSvf+OsBfrjJMKQNHZKMNOZElFOLIJEvXxvP4SCybC1CWve+Um7o/gwY9gwGuoXC2ECMcNZXFPq
 /INv//BLYBJ6uK2S/duqHDStQlZd7EHQvHJzllfgcOHOod9m5oi4tZy3ewc/Ry28eShGadz6yuz
 dUdsKgZpjAKnSDB3Cbe9Ii4XKUB7M=
X-Received: by 2002:a05:600c:1c1c:b0:423:6b7:55eb with SMTP id
 5b1f17b1804b1-42306b7594dmr60940175e9.14.1718634759622; 
 Mon, 17 Jun 2024 07:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5fKXNh99tQQJhbMfKU9KouDyRUig+zImbfWn1voOmJVdsRzjVy4P9GyahD97VjVWEQLcnJ9msPmm61WQdhp0=
X-Received: by 2002:a05:600c:1c1c:b0:423:6b7:55eb with SMTP id
 5b1f17b1804b1-42306b7594dmr60939965e9.14.1718634759251; Mon, 17 Jun 2024
 07:32:39 -0700 (PDT)
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
In-Reply-To: <f89qp.6kmlv39qhntz@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Jun 2024 16:32:26 +0200
Message-ID: <CABgObfYj3F6aoefBgcHcjkwDqK6kcDGUfPZtRbFzB5abXShfbA@mail.gmail.com>
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
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Mon, Jun 17, 2024 at 4:04=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> I respectfully disagree and recommend taking another look at the code.
>
> The device actually performs all logic in non-unsafe methods and is
> typed instead of operating on raw integers as fields/state. The C stuff
> is the FFI boundary calls which you cannot avoid; they are the same
> things you'd wrap under these bindings we're talking about.

Indeed, but the whole point is that the bindings wrap unsafe code in
such a way that the safety invariants hold. Not doing this, especially
for a device that does not do DMA (so that there are very few ways
that things can go wrong in the first place), runs counter to the
whole philosophy of Rust.

For example, you have:

    pub fn realize(&mut self) {
        unsafe {
            qemu_chr_fe_set_handlers(
                addr_of_mut!(self.char_backend),
                Some(pl011_can_receive),
                Some(pl011_receive),
                Some(pl011_event),
                None,
                addr_of_mut!(*self).cast::<c_void>(),
                core::ptr::null_mut(),
                true,
            );
        }
    }

where you are implicitly relying on the fact that pl011_can_receive(),
pl011_receive(), pl011_event() are never called from the
MemoryRegionOps read() and write() callbacks. Otherwise you'd have two
mutable references at the same time, one as an argument to the
callbacks:

   pub fn read(&mut self, offset: hwaddr, ...

and one from e.g. "state.as_mut().put_fifo()" in pl011_receive().

This is not Rust code. It makes no attempt at enforcing the whole
"shared XOR mutable" which is the basis of Rust's reference semantics.
In other words, this is as safe as C code---sure, it can use nice
abstractions for register access, it has "unsafe" added in front of
pointer dereferences, but it is not safe.

Again, I'm not saying it's a bad first step. It's *awesome* if we
treat it as what it is: a guide towards providing safe bindings
between Rust and C (which often implies them being idiomatic). But if
we don't accept this, if there is no plan to make the code safe, it is
a potential huge source of technical debt.

> QEMU calls the device's FFI callbacks with its pointer and arguments,
> the pointer gets dereferenced to the actual Rust type which qemu
> guarantees is valid, then the Rust struct's methods are called to handle
> each functionality. There is nothing actually unsafe here, assuming
> QEMU's invariants and code are correct.

The same can be said of C code, can't it? There is nothing unsafe in C
code, assuming there are no bugs...

Paolo

> >
> >I think we're actually in a great position. We have a PoC from Marc-Andr=
=C3=A9,
> >plus the experience of glib-rs (see below), that shows us that our goal =
of
> >idiomatic bindings is doable; and a complementary PoC from you that will
> >guide us and let us reach it in little steps. The first 90% of the work =
is
> >done, now we only have to do the second 90%... :) but then we can open t=
he
> >floodgates for Rust code in QEMU.
> >
> >For what it's worth, in my opinion looking at glib-rs for inspiration is
> >> a bad idea, because that project has to support an immutable public
> >> interface (glib) while we do not.
> >>
> >
> >glib-rs includes support for GObject, which was itself an inspiration fo=
r
> >QOM (with differences, granted).
> >
> >There are a lot of libraries that we can take inspiration from: in addit=
ion
> >to glib-rs, zbus has an interesting approach to
> >serialization/deserialization for example that could inform future work =
on
> >QAPI. It's not a coincidence that these libraries integrate with more
> >traditional C code, because we are doing the same. Rust-vmm crates will
> >also become an interesting topic sooner or later.
> >
> >There's more to discuss about this topic which I am open to continuing
> >> on IRC instead!
> >>
> >
> >Absolutely, I will try to post code soonish and also review the build
> >system integration.
> >
> >Thanks,
> >
> >Paolo
> >
> >
> >> -- Manos Pitsidianakis
> >> Emulation and Virtualization Engineer at Linaro Ltd
> >>
> >> >
> >> >One thing that would be very useful is to have an Error
> >> >implementation. Looking at what Marc-Andr=C3=A9 did for Error*
> >> >(
> >> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@red=
hat.com/20210907121943.3498701-13-marcandre.lureau@redhat.com/
> >> ),
> >> >his precise implementation relies on his code to go back and forth
> >> >between Rust representation, borrowed C object with Rust bindings and
> >> >owned C object with Rust bindings. But I think we can at least have
> >> >something like this:
> >> >
> >> >// qemu::Error
> >> >pub struct Error {
> >> >    msg: String,
> >> >    /// Appends the print string of the error to the msg if not None
> >> >    cause: Option<Box<dyn std::error::Error>>,
> >> >    location: Option<(String, u32)>
> >> >}
> >> >
> >> >impl std::error::Error for Error { ... }
> >> >
> >> >impl Error {
> >> >  ...
> >> >  fn into_c_error(self) -> *const bindings::Error { ... }
> >> >}
> >> >
> >> >// qemu::Result<T>
> >> >type Result<T> =3D Result<T, Error>;
> >> >
> >> >which can be implemented without too much code. This way any "bool
> >> >f(..., Error *)" function (example: realize :)) could be implemented
> >> >as returning qemu::Result<()>.
> >>
> >>
>


