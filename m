Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E99C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDrd-0001ii-4A; Tue, 06 May 2025 04:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uCDrY-0001iB-8s
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:41:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uCDrV-000653-VN
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:41:16 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5edc07c777eso7516997a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746520871; x=1747125671; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/0cjWunnrGrhtWlE6dY566h4QS4Hb4N2QIVLHUo47Y=;
 b=BYr2a/uhUs4PT57U/EB/EzobHLTi4bhLAYX6/Fc+71j3xaWm7eU7kaV1kr9TqTdH0R
 9SzlGmU/CeLGFWpDyJmU8P3K3tPE0e5GOplifk4WbiSI1LQKpy6eR0sOl2GWyffdvvj2
 HD2WjORv6Su7UGhwcDDh8L0lLCSJ5NaEqsFwfvrXNXckFvz7tsC1aVqxFSe/NWoS9g2j
 3eM5G2L5Qc1Q0TEMlqCHhBUP0XeoyVgpF4RRZR7m2LwteMzLCDBy+SdX951apPRtrhW/
 hyY+q5WDuSwdpJHOwEo9KSFmkcCKnN2uwpFZYq/KlbE9UfL2uWs+ijGXJ+WYrEHQZDZT
 1CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746520871; x=1747125671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/0cjWunnrGrhtWlE6dY566h4QS4Hb4N2QIVLHUo47Y=;
 b=ZQtbskftMMeBoyHYw4LrESn/HxRvOA0tOzK0hYlePp58Pmf7lYOOdqUsGl5VJpai14
 W1/wX0E50dR6TLk4BLPcDT6W7KaCIQ6i9XREzz5v4Fz22/v1R50o61vk3/lmCR74P3c/
 KYtUpjaG4ny1uv0uiTd3A3jsDYc49lemANnjUQtzZF+N6dolWuPL3HBffsVLbJOLXZg8
 xvtmwYqTb3mIq/LUKP/vE3KFm1HeGJgiRIiQNFwgtylSTNRnmUVExB7kcEhkXq5HsrH+
 Ice9inEhBRZyQ6w8U8ruJxXihBK44YEMvAc7dfhE4USNPc1w8GxUv/c978CGaCwD8jaq
 HflA==
X-Gm-Message-State: AOJu0YxFzx/Gb3h/8XaCEpSx2nzMtx5YKWKkVgZumHkc3gPPneEfitXh
 0FcxvPoyNPFOM0GFyiMuNJr7IlGUXJz3PUBpSKps37B5pkPyb+bdOM0L1pwyZlUiqrSsTwK6IBm
 Tr65MYmBpqH81HyDF5glhxkG9zNd4ZivQ+M9q1A==
X-Gm-Gg: ASbGncshj+/I07RCwQQS2a81D36X577yDLBeR0hxErwzjjyTalLJeSu/mgsaV1E72R/
 n2mfC01JmiXqjBGdeB6yXP0Xs++nlDwaSRTSAvWufPVYLpf/k45zOxHkzuBo36N4ly4Mwung+HY
 gdLYfv8STxvnU3o93rexSd2eio
X-Google-Smtp-Source: AGHT+IHs7ForXW1FBanjKlpJdX8Vlr8GQR7Cym32B5dhkzgbrzYP5EgfbEoPTcORqLMfDsUq1JJEra9Ql3HSwr5casE=
X-Received: by 2002:a05:6402:3581:b0:5ee:486:9d4a with SMTP id
 4fb4d7f45d1cf-5fb70d52f80mr1970716a12.33.1746520871358; Tue, 06 May 2025
 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <CAAjaMXZhq_uv-w_9TT3++HAcO7r_OhriJA0RKWs8YqY_ryjK4w@mail.gmail.com>
 <7101782c-f642-41e6-8f3a-7061ca722c99@gnu.org>
In-Reply-To: <7101782c-f642-41e6-8f3a-7061ca722c99@gnu.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 6 May 2025 11:40:45 +0300
X-Gm-Features: ATxdqUHe3krC8YsQKLDnKhz9DHVmCbYu-CfX_huZ_XOgicSVG0CgqCrK82tszCk
Message-ID: <CAAjaMXbLUG1jsDZVcwKQV5+UfaCZUWTi4o5KFNJRowLbQ67yqQ@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Paolo Bonzini <bonzini@gnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, May 5, 2025 at 4:45=E2=80=AFPM Paolo Bonzini <bonzini@gnu.org> wrot=
e:
>
> On 5/5/25 14:26, Manos Pitsidianakis wrote:
> >>     Something I do notice is that there's some inconsistency in
> >>     how we've structured things between the two devices, e.g.:
> >>
> >>     * the pl011 main source file is device.rs, but the hpet one
> >>       is hpet.rs
> >>
> >>     * some places we use the actual names of bits in registers
> >>       (eg Interrupt's OE, BE, etc consts), and some places we
> >>       seem to have renamed them (e.g. pl011 Flags has clear_to_send
> >>       not CTS, etc)
> >>
> >>     * pl011 has defined named fields for its registers, but hpet does
> >>       things like::
> >>
> >>          self.config.get() & (1 << HPET_CFG_LEG_RT_SHIFT) !=3D 0
> >>
> >>     * pl011 has a split between PL011State and PL011Registers,
> >>       but HPET does not. As I mentioned in an email thread a
> >>       little while back, I feel like the State/Registers split
> >>       is something we should either make a more clear deliberate
> >>       formalised separation that's part of how we recommend
> >>       device models should be designed
> >>
> >>     [...]
> >>
> >>     I think it would be good to figure out what we think is the
> >>     right, best style, for writing this kind of thing, and be
> >>     consistent. We have long standing problems in the C device
> >>     models where there are multiple different styles for how
> >>     we write them, and it would be good to try to aim for
> >>     more uniformity on the Rust side.
> >
> > The pl011 stuff was deliberate decisions:
> >
> > - device.rs vs pl011.rs: the device was written as a crate, so it's
> > essentially its own library, plus pl011/src/pl011.rs would be
> > redundant :)
>
> Right, I think Peter's comment was more about moving hpet.rs to
> device.rs, and merging PL011's device_class.rs into its device.rs.
>
> >    That said, it's not important, we can choose either convention. I
> > like the less redundancy and separation of concerns: if pl011 gets
> > converted into a module in a future refactor, it could keep its
> > functionality split into different submodules and `pl011.rs` or
> > `pl011/mod.rs` would be the device module.
>
> I think it's okay to decide that Rust devices will have mini
> directories: it's just the style of the language and Cargo more or less
> relies on having lib.rs.
>
> In a vacuum I would prefer to have hw/char/pl011.rs for what is now
> rust/hw/char/pl011/lib.rs, and place the other files in hw/char/pl011;
> IIRC rustc accepts that style.  However we still rely on Cargo for some
> things(*), and as long as we do there's not much we can do about it.
>
>      (*) notably "cargo fmt".  Everything else is more or less handled
>          by Meson starting with 1.8.0.
>
> > - Using typed registers instead of constants: yes coming from C I can
> > understand it can feel unfamiliar. I specifically wanted to make the
> > register fields typed to avoid making the implementation a "C port",
> > and I think it's worthwhile to use the type system as much as
> > possible.
>
> Peter's comments (especially the second and third) were about two kinds
> of inconsistencies:
>
> 1) HPET not using bilge.  This was because Zhao looked at HPET from the
> opposite direction compared to what you did on pl011, namely avoiding
> unsafe and modeling the BQL properly, and sacrificed a bit the usage of
> idiomatic code like what bilge provides.
>
> I think that you made the right choice for the first device and he made
> the right choice for the second device.  But now someone should look at
> HPET and do the work that you did to adopt bilge.
>
> 2) The choice between bilge on one side, and bitflags or integers on the
> other.  For pl011 you kept interrupt bits as integers for example, and
> this is related to the topic of (non-)availability of const in traits...

Oh right.

>
> >    A straight C port would result into integer constants with integer
> > typed fields everywhere for registers/flags.
> >    Yes, From/Into aren't const, at least yet, but it's not really a
> > hotpath performance wise. I think non-dynamically dispatched trait
> > methods can be inlined by annotating the `fn from(..)` impl with a
> > `#[inline(always)]` hint but I haven't confirmed this, just
> > speculation.
>
> It's not about hot paths, it's more that 1) you cannot use From/Into in
> a "static"'s initializer 2) bilge relies a lot on non-const methods in
> its internal implementation, which makes it quite messy to use it in
> some places.  See for example this thing for which I take all the blame:

Yeah it's not nice that we can't use it in static/const initializers.

>
>      impl Data {
>          // bilge is not very const-friendly, unfortunately
>          pub const BREAK: Self =3D Self { value: 1 << 10 };
>      }
>
> and the same would be true of interrupt constants and the IRQMASK array.
>
> The separate bilge and bitflags worlds are what bothers me the most in
> the experimental devices.  I can see why they would be very confusing
> for someone who's not had much experience with Rust, and therefore
> doesn't know *why* they are separate.
>
> >    Again, no strong opinions here. I like the "everything is typed"
> > approach and I think it's worth it to explore it because it allows us
> > to "make invalid/illegal states unrepresentable" as one sage article
> > goes.
>
> I agree, and it's why I think you made the right choice using it for
> pl011.  With all the unsafe code that you had to use, strong-typing at
> least showed *something* that Rust could provide compared to C(*).  And
> I like the strong typing too, even if I'm not sure I like bilge's
> *implementation* that much anymore.

It has its pros and cons that's for sure... there are many crates that
let you define typed bitfields, I haven't looked into the current
state of the art lately. We should definitely move on to something
better if it exists now or in the future.

> I'm not really up for rewriting it, but then I've also done more stupid
> rewrites in the past. :)
>
>     (*) when we were discussing safety vs. unsafety last summer, I may
>         have sounded dismissive of this kind of benefit.  My point at the
>         time was that unsafe code was so much more complex than C, that
>         the benefit of strong-typing wasn't enough to *offset* the
>         complexity of unsafe code.  But it is absolutely present.
>
> >> Related to this I have found recently the `attrs crate
> >> <https://docs.rs/attrs/>`__, which provides an easy way to parse the
> >> contents of attributes in a procedural macro.
> >
> > I actually have some WIP patches for this I put a pause on and can
> > continue e.g. https://gitlab.com/epilys/rust-for-qemu/-/commit/c2c97caa=
af03273fabc14aee5a4d1499668ddbe3
>
> The repository is private, but I look forward to seeing it!  If you want
> to post an RFC without even any code, just to show what the device code
> looks like, that would be helpful as it will catch stuff like lack of
> type safety.

Oops, I forgot I had archived it because I moved development to
https://gitlab.com/epilys/qemu . I made it public again. Bear in mind
this was a WIP, basically my git stash but committed.

>
> BTW, if you need it to model reflection better I think it is acceptable
> to assume const_refs_to_static is present.
>
> Paolo

