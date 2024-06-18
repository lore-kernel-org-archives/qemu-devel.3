Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D1AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 06:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJRtj-000862-PY; Tue, 18 Jun 2024 02:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJRtY-00084H-I4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 02:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJRtT-0008Iv-Rq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 02:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718690434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVcSj2L9Fq6vtS6hm5eyXed+fpcTqcgRvy4jVoQ81+c=;
 b=MwUWX12C9VDKPks82lKJ1eo/mBmbpK6nThfSI7ADAXzKmYEEkJxoCqGKHurYayGNq1MLP0
 T3QWWzD6TiR80lr6c3WSnMr4QD06JvxhdKaDzzPVRH1qvQx+AQHKKusgOpL27yL39L347Y
 ed4MttKnpMKA0tPtWEkcBnEq9qjK8q0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-PW18B3yMPCiLJmx_jSiElg-1; Tue, 18 Jun 2024 02:00:31 -0400
X-MC-Unique: PW18B3yMPCiLJmx_jSiElg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35f1f358e59so2581507f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 23:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718690430; x=1719295230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVcSj2L9Fq6vtS6hm5eyXed+fpcTqcgRvy4jVoQ81+c=;
 b=bwBuptiyj3ItBg2aHhR1upTQjmYeg4D0qJ9V+uqGcFvI7kazL3hDnaHEZSTQ/qgYdt
 r/sAONNAYv7tBcbQ8q2yBJj4E019Q1sOucF4bswKB4WqtzHtunh0aJx+dhFTo5ltCPOf
 UFImCB0uBKI2mkugK1c90PDpDLseLr4JBje099TgqGqmxOBbXHHhK6tERsW6b+Y4p4QW
 8kpwFfaBZc/9byLb0rZGcq0w9ckMQha2P+1L0D2ZdsjvzanGWTvkiKmGqvpRcfx7L3NA
 lsrlqb63gMoLYG1Am2z9Iif/v2z8rIzmOFIztlzwBDtwvgyEuynhibIcAgWO2NGSDco7
 JbaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHyLj3kNJnVCbtffYI+6ttL4Uu7486cY+/2z9vGURerDdon5niX+B7d1qwn1VQqMqPcxX7vCp5P43MRhSnBcERruqHFXY=
X-Gm-Message-State: AOJu0YzXT0q2F20w8Qzun/ZHUugfKzKW9tcD3pU/yvgi3iHLI/TnGhz7
 VzTwvN8F0kHXT6iZYVbkm05HMwAuBzfcW+DshKcluWB2bj5wmYf6vRB2LGXn8os43X7c5FJQGTs
 ldVexSWnTS77tR7rBnaP7WYcObRXrbmoeejSRKki6mVOkh6mB2bczr2V2+x0WTFdRplDinIngFj
 uXRRyMJGh/b+0vYdWSp6ZeDf11tCE=
X-Received: by 2002:a5d:608a:0:b0:35f:24d9:e7dc with SMTP id
 ffacd0b85a97d-3609ea6c570mr1166396f8f.19.1718690430525; 
 Mon, 17 Jun 2024 23:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXDy09Wde0AOJRTaZegDwUJUhJjZhS664JccpJRofWuKNe9pBnuWmQUq8rJTfeYaUwjZiRmSPef/789sdfrto=
X-Received: by 2002:a5d:608a:0:b0:35f:24d9:e7dc with SMTP id
 ffacd0b85a97d-3609ea6c570mr1166358f8f.19.1718690430131; Mon, 17 Jun 2024
 23:00:30 -0700 (PDT)
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
 <24ee6724-a7d4-47eb-8f89-939a2699bd6a@linaro.org>
In-Reply-To: <24ee6724-a7d4-47eb-8f89-939a2699bd6a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Jun 2024 08:00:00 +0200
Message-ID: <CABgObfY4BeuDC9XXhe-JLH_pOk2Sid5P_WvDgtWzYRv0-0EyHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Marc=2DAndr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 rowan.hart@intel.com
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

On Tue, Jun 18, 2024 at 1:33=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 6/17/24 14:04, Manos Pitsidianakis wrote:
> > On Mon, 17 Jun 2024 17:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> On Mon, Jun 17, 2024 at 4:04=E2=80=AFPM Manos Pitsidianakis
> >> <manos.pitsidianakis@linaro.org> wrote:
> >>> I respectfully disagree and recommend taking another look at the code=
.
> >>>
> >>> The device actually performs all logic in non-unsafe methods and is
> >>> typed instead of operating on raw integers as fields/state. The C stu=
ff
> >>> is the FFI boundary calls which you cannot avoid; they are the same
> >>> things you'd wrap under these bindings we're talking about.
> >>
> >> Indeed, but the whole point is that the bindings wrap unsafe code in
> >> such a way that the safety invariants hold. Not doing this, especially
> >> for a device that does not do DMA (so that there are very few ways
> >> that things can go wrong in the first place), runs counter to the
> >> whole philosophy of Rust.
> >>
> >> For example, you have:
> >>
> >>     pub fn realize(&mut self) {
> >>         unsafe {
> >>             qemu_chr_fe_set_handlers(
> >>                 addr_of_mut!(self.char_backend),
> >>                 Some(pl011_can_receive),
> >>                 Some(pl011_receive),
> >>                 Some(pl011_event),
> >>                 None,
> >>                 addr_of_mut!(*self).cast::<c_void>(),
> >>                 core::ptr::null_mut(),
> >>                 true,
> >>             );
> >>         }
> >>     }
> >>
> >> where you are implicitly relying on the fact that pl011_can_receive(),
> >> pl011_receive(), pl011_event() are never called from the
> >> MemoryRegionOps read() and write() callbacks. Otherwise you'd have two
> >> mutable references at the same time, one as an argument to the
> >> callbacks:
> >>
> >>    pub fn read(&mut self, offset: hwaddr, ...
> >>
> >> and one from e.g. "state.as_mut().put_fifo()" in pl011_receive().
> >>
> >> This is not Rust code. It makes no attempt at enforcing the whole
> >> "shared XOR mutable" which is the basis of Rust's reference semantics.
> >> In other words, this is as safe as C code---sure, it can use nice
> >> abstractions for register access, it has "unsafe" added in front of
> >> pointer dereferences, but it is not safe.
> >>
> >> Again, I'm not saying it's a bad first step. It's *awesome* if we
> >> treat it as what it is: a guide towards providing safe bindings
> >> between Rust and C (which often implies them being idiomatic). But if
> >> we don't accept this, if there is no plan to make the code safe, it is
> >> a potential huge source of technical debt.
> >>
> >>> QEMU calls the device's FFI callbacks with its pointer and arguments,
> >>> the pointer gets dereferenced to the actual Rust type which qemu
> >>> guarantees is valid, then the Rust struct's methods are called to han=
dle
> >>> each functionality. There is nothing actually unsafe here, assuming
> >>> QEMU's invariants and code are correct.
> >>
> >> The same can be said of C code, can't it? There is nothing unsafe in C
> >> code, assuming there are no bugs...
> >
> > Paolo, first please tone down your condescending tone, it's incredibly
> > offensive. I'm honestly certain this is not on purpose otherwise I'd no=
t
> > engage at all.
>
> The best compliment you had was "I'm not saying it's a bad first step",
> and I would say this differently: It's a great first step!

Don't quote me out of context; I said It's an "awesome" first step,
though I qualified that we should treat it as "a guide towards
providing safe bindings between Rust and C". That is, as long as we
agree that it is not production quality code. Which it doesn't have to
be!

> We should have a first version where we stick to the C API, with all the
> Rust code being as Rusty as possible: benefit from typed enums, error
> handling, bounds checking and other nice things.
>
> It's useless to iterate/debate for two years on the list before landing
> something upstream. We can start with this, have one or two devices that
> use this build system, and then focus on designing a good interface for
> this.

I never said that I want perfection before landing upstream. I want _a path=
_.

When I read "there was consensus in the community call that we won't
be writing Rust APIs for internal C QEMU interfaces; or at least,
that's not the goal"[1], then sorry but I think that it's better to
stick with C.

On the other hand, if there is a path towards proper, maintainable
Rust, then I am even okay even with committing something that
technically contains undefined behavior.

[1] https://lore.kernel.org/qemu-devel/ez270.x96k6aeu0rpw@linaro.org/

> As I mentioned in my previous answer, this device already makes a good
> progress: it eliminates a whole class of memory errors, and the only
> issue brought by unsafe code is concurrency issues. And this should be
> our focus once we get the build infrastructure done!

Let's not exaggerate the benefits: no pointers were converted to RAII
(Box<> or Rc<>) in the course of writing the Rust code; so there are
no memory errors that can be eliminated by the rewrite. In fact, new
memory errors can also be introduced, because safe Rust has stricter
aliasing rules than C.

This is not a problem! It's just that we need to be realistic to
understand where to focus next and why. To build our path.

(Also, a small correction so that we're on the same page on the fix:
it's reentrancy, not concurrency).

Paolo


