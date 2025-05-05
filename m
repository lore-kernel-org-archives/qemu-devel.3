Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E95C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBuuW-0007Xy-CR; Mon, 05 May 2025 08:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBuuT-0007WV-LE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:27:01 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBuuN-00012t-Th
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:27:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5edc07c777eso6131994a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746448011; x=1747052811; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsjz82emGKzNzQDZyYLEwMR112qBhgO5Mg8R4fMgiV4=;
 b=VlawA2R5z96YymGdBMsodSBiFSSyN2HBBg6fQcP0Ev4VT7944ZBThSpRdw7sddFJ8/
 KVbXcPHxGt5g7a5h0dYPDByOj1Ez6X4Lx2NJEeYQUgMeAMcQ2aZ6dFWShfCEMdN0Jvh1
 Fvu412XkcTDHs5Zbmf/8E3CRFMwITCmp6zdLDD1QzTn9qDkUzUVzyb0PLoOP52VC26XJ
 Yi0Yv+B4LnsvD/8PEJ7GtM+RCT23MsZxYiYtwJurjL4lPt5E8yRkAP6Hksp7pyHcsE0R
 7wPB4E5O05AYm4ZtJNgwKVoxuqGTClx1eKY27KqO/JU8BK2/xHHWH15Zuto0uhzqt7Tg
 2tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746448011; x=1747052811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hsjz82emGKzNzQDZyYLEwMR112qBhgO5Mg8R4fMgiV4=;
 b=sUcO1H0dph1IoEhAbfljQqeeSRpaJRM03s+Lssu4b516xNw5V0CLxtgOxZii7b9PMO
 9UuIUuMr1BcajAwQNNWTyJSMDZPvgPoepA9/ZOJuWnxUNepJt7efbVbGH8kzbtZv/+Hd
 es1dz/6KbQABIT8TUS45l8RlHnLGc9YsStUwulmG7B1CtCJATZyHRBQvZRm6LhJ8djkV
 hiv8s/Z9I4okyPHKddh5qxni30WbeqyvbdsKAcK+iL0bTOOvdpeQeAbZppapcCOciFdt
 CWY81UItTh0V6poT4I6JohxoxC/eAMGKf4G9Q1OuT0vz0K8t0WwdpIBJd/GnvF5C8SKa
 qLcQ==
X-Gm-Message-State: AOJu0YxaU+qXun6xHKOGg73mo1OP95I0R6rvy/5EKKTu8gmj35ZWWz/B
 vbFHJyk3JXeQ0Wj5V9dbO28MHglXvIULgL3FQqEkgj0EGRaVcPKSa3aUZm/jn9UXGsotdFAdLN3
 Wy5E5VzxuNDPEgpR58AquQqIc3puHQo6+LvAPZA==
X-Gm-Gg: ASbGncuA4rpQVADuJakMWbCUqnrP6i7bMEK26jJlUEOEo0kTBGmXRGy4QfDqUX29KGd
 ZpGb684ZC9UAVeZE+cRZCXrdoI/lGgFbLP8DiYwWauSSlGfMmAzoeqAuhMNgK3MOWn4QcSWerE9
 PF20ZYKpW1K3R5yLe2J9GkXcKW
X-Google-Smtp-Source: AGHT+IG9Kmz2iaFsJEvnEV2zPWmLdzYSxbZVU+9MyAPRQ/TUSCBVs6sdNrdLas4raRWGcGjwR5wA7UeEhSRtjnvR7o8=
X-Received: by 2002:a05:6402:1e8f:b0:5f7:eaf0:8849 with SMTP id
 4fb4d7f45d1cf-5faa7f8ae95mr6716657a12.16.1746448010507; Mon, 05 May 2025
 05:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
In-Reply-To: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 5 May 2025 15:26:23 +0300
X-Gm-Features: ATxdqUFKC9hcFc-SqyJaywNw2vKh-bdFAHZUbwIvjQRWofKSENMkqYcdg77QmmA
Message-ID: <CAAjaMXZhq_uv-w_9TT3++HAcO7r_OhriJA0RKWs8YqY_ryjK4w@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Paolo Bonzini <bonzini@gnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, May 2, 2025 at 3:13=E2=80=AFPM Paolo Bonzini <bonzini@gnu.org> wrot=
e:
>
> It's been roughly three months since my previous update on the Rust in
> QEMU project.  Support for Rust remains experimental, with most of the
> past three months spent cleaning up the bindings and making more
> functionality available from safe Rust.
>
> As before, this mostly covers what I have looked at, which is making
> it possible to write devices in safe Rust.  Topics such as QAPI and
> async (block devices) are missing for this reason.
>
> Overall, I'd say the progress is good: most of the missing features
> mentioned in the previous update have been fixed or at least have a
> plan for the next few months.
>
> Table of contents
> '''''''''''''''''
>
> * Status in QEMU 10.0
> * Build system
> * Feature parity for devices
> * Remaining unsafe code
> * Rust version requirements
> * A coding style for devices
> * Next steps
>
>
> Status in QEMU 10.0
> '''''''''''''''''''
>
> QEMU when built with ``--enable-rust`` compiles on all supported
> build platforms.  It passes CI and ``make check-unit`` runs tests for
> rust/qemu-api.  ``make check-qtests`` covers the Rust pl011 and HPET
> device models, including migration of the former.  pl011 is entirely
> implemented using safe code (minus migration and qdev properties).
> HPET uses unsafe in some small and fairly well confined cases (see
> below).
>
> Since the previous update, some mistakes in the early bindings code
> have become apparent; in particular, orphan rules made it too hard
> to implement classes outside the qemu_api crate, and in general to
> split the qemu_api crate in multiple parts---for example, parts that
> are of interest to tools and parts that are only used by system
> emulators.  Another important change is the separation between
> bindgen-generated types and the structs that are actually used by
> Rust code.  This allows traits such as Send, Sync or Zeroable to be
> specified independently for C and Rust structs.
>
> Thanks to Kevin Wolf's work on the block layer a new module appeared
> to convert between C success/-errno conventions and ``io::Result``.
> This module is also used in character device bindings.
>
>
> Build system
> ''''''''''''
>
> Developers can use ninja to easily access clippy, rustfmt and rustdoc.
> Meson 1.8 supports clippy and rustdoc natively (including doctests),
> but due to some regressions in 1.8.0 this will have to wait for the
> next stable release.  This update to Meson will also make it possible
> to use --enable-modules and --enable-rust together.
>
> Rust is still not enabled and its presence is not checked for by
> default.  The main reason is that Rust staticlibs also link statically
> to the Rust standard library, thus bloating the resulting executable
> (and making distros hate us as well).  A pending Meson pull request[1]
> will fix this, as long as system/main.c is rewritten or wrapped in Rust.
>
> .. [1] https://github.com/mesonbuild/meson/pull/14224
>
>
> Feature parity for devices
> ''''''''''''''''''''''''''
>
> Support for HPET live migration is ready to be merged.
>
> As before, some recent pl011 commits are missing in the Rust version.
>
> Logging and tracing were proposed as a project for Google Summer of
> Code.
>
>
> Remaining unsafe code
> '''''''''''''''''''''
>
> qdev bindings cover basic classes and interfaces, including
> GPIO pins, timers, clocks and MemoryRegionOps.  VMState
> still needs unsafe callbacks for pre_save/post_load, with
> the final version waiting for a bump of the minimum supported
> Rust version to 1.83.0.
>
> Apart from VMState, the remaining instances of `unsafe` blocks in the
> pl011 and HPET code can all be removed without bumping the language
> version.
>
> HPET does some very simple memory accesses; a good safe solution
> for this may be the ``vm-memory`` crate.  While I have not looked into
> using it, ``vm-memory`` and ``vm-virtio`` were written with QEMU's
> use cases in mind.
>
> The ``instance_init`` method is using unsafe code.  There are multiple
> solutions to this: the one I planned for was to use a crate such as
> `pin_init <https://docs.rs/pin_init/>`__ or
> `pinned_init <https://docs.rs/pinned_init/>`__, but
> I have also worked for self-education on a simpler version based on
> ``std::mem::MaybeUninit`` field projections.  This one removes ``unsafe``
> only from the implementation and not from the ``instance_init`` method
> itself, but it is less invasive and could be a possibility in the
> short term.
>
> The amount of functionality available from safe Rust is enough that
> including new devices should be possible, even if they need some unsafe
> code for parts of QEMU that do not have bindings yet.  Most devices
> added to QEMU are simple and do not do any complex DMA; while such
> simple devices have very little benefit from *rewriting* them in Rust,
> there will be a substantial benefit to writing *new* devices in Rust as
> soon as tracing and logging are supported.  Even though unsafe code in
> migration and ``instance_init`` would count as technical debt for every
> Rust device that is added to QEMU, I don't expect a flood of Rust devices
> in the next few months such that this would be a problem.
>
> There is still no interoperability between QEMU's C data structure and
> Rust counterparts has no news either.  As before, we'll figure it out
> as soon as we need a realize() implementation that can fail, or when
> tackling QAPI.
>
>
> Rust version requirements
> '''''''''''''''''''''''''
>
> Patches are on the list (and have mostly been reviewed) to bump the
> minimum supported Rust version to 1.77.0.  However, there will probably
> be at least one more bump to support references to statics in constants,
> which are stable in 1.83.0 and are important for migration support in
> safe Rust.
>
> This will require dropping support for ``--enable-rust`` on Debian
> bookworm with a distro-provided compiler.  If any devices are contributed
> that are written in Rust and do not have a C counterpart, it may be
> worth splitting "enable Rust" from "enable all devices written in Rust".
> This way, the C versions of the pl011 and HPET devices remain available
> on bookworm.
>
>
> A coding style for devices
> ''''''''''''''''''''''''''
>
> pl011 and HPET were developed independently and sometimes have different
> idioms that could be unified.  Peter Maydell made several observations:
>
>    Something I do notice is that there's some inconsistency in
>    how we've structured things between the two devices, e.g.:
>
>    * the pl011 main source file is device.rs, but the hpet one
>      is hpet.rs
>
>    * some places we use the actual names of bits in registers
>      (eg Interrupt's OE, BE, etc consts), and some places we
>      seem to have renamed them (e.g. pl011 Flags has clear_to_send
>      not CTS, etc)
>
>    * pl011 has defined named fields for its registers, but hpet does
>      things like::
>
>         self.config.get() & (1 << HPET_CFG_LEG_RT_SHIFT) !=3D 0
>
>    * pl011 has a split between PL011State and PL011Registers,
>      but HPET does not. As I mentioned in an email thread a
>      little while back, I feel like the State/Registers split
>      is something we should either make a more clear deliberate
>      formalised separation that's part of how we recommend
>      device models should be designed
>
>    [...]
>
>    I think it would be good to figure out what we think is the
>    right, best style, for writing this kind of thing, and be
>    consistent. We have long standing problems in the C device
>    models where there are multiple different styles for how
>    we write them, and it would be good to try to aim for
>    more uniformity on the Rust side.

The pl011 stuff was deliberate decisions:

- device.rs vs pl011.rs: the device was written as a crate, so it's
essentially its own library, plus pl011/src/pl011.rs would be
redundant :)
  That said, it's not important, we can choose either convention. I
like the less redundancy and separation of concerns: if pl011 gets
converted into a module in a future refactor, it could keep its
functionality split into different submodules and `pl011.rs` or
`pl011/mod.rs` would be the device module.
  Rust's concept of files being either a leaf module or parent module
does not translate to C's "every file is a compilation unit" cleanly.
- Using typed registers instead of constants: yes coming from C I can
understand it can feel unfamiliar. I specifically wanted to make the
register fields typed to avoid making the implementation a "C port",
and I think it's worthwhile to use the type system as much as
possible.
  A straight C port would result into integer constants with integer
typed fields everywhere for registers/flags.
  Yes, From/Into aren't const, at least yet, but it's not really a
hotpath performance wise. I think non-dynamically dispatched trait
methods can be inlined by annotating the `fn from(..)` impl with a
`#[inline(always)]` hint but I haven't confirmed this, just
speculation.
  Again, no strong opinions here. I like the "everything is typed"
approach and I think it's worth it to explore it because it allows us
to "make invalid/illegal states unrepresentable" as one sage article
goes.

>
> One thing that I noticed is that in Rust QEMU code I tend to rely on
> ``const`` and ``static`` a lot, and several crates are not friendly
> to this style, including the ``bilge`` crate that we use for named
> fields and others such as ``bitflags``.  In both cases, this is
> related to Rust not having const traits, e.g. for ``from()``/into()``
> or operator overloading).  I already have a prototype of a bitflags-like
> macro that is more const friendly, and we also need to make a decision
> on whether to keep using ``bilge``, fork it, rewrite it or whatever.
>
>
> Next steps
> ''''''''''
>
> With respect to missing functionality, tracepoints and logging remain
> the highest-priority missing feature, perhaps together with DMA, and the
> main blocker before implementing new devices in Rust can be encouraged.
> Hopefully this hole will be closed over the summer.
>
> On the experimental side, if anybody wants to play with the ``vm-memory``
> crate for DMA that would be very interesting.  However, the next steps
> I am suggesting are mostly along the lines of cleaning up what is there,
> ensuring that we're ready for more widespread usage of Rust in QEMU.
>
> If someone like menial work, splitting the ``qemu_api`` crate is now
> possible and a good thing to do.
>
> If someone has good taste, they might go over the code with Peter's
> above remarks in mind, cleaning up things so that pl011 and HPET both
> provide good examples of Rust code in QEMU.
>
> I also believe it's time to look again at using procedural macros to
> simplify declaring QOM/qdev classes.  For example::
>
>      #[derive(qemu_api_macros::Object(class_name=3D"pl011", class=3DPL011=
Class))]
>      #[derive(qemu_api_macros::Device(vmsd=3DVMSTATE_HPET))
>      pub struct PL011State {
>          pub parent_obj: ParentField<SysBusDevice>,
>          pub iomem: MemoryRegion,
>          pub regs: BqlRefCell<PL011Registers>,
>          pub interrupts: [InterruptSource; IRQMASK.len()],
>          pub clock: Owned<Clock>,
>
>          #[qemu_api_macros::property(name=3D"chr")]
>          pub char_backend: CharBackend,
>
>          #[qemu_api_macros::property(name=3D"migrate-clk", default=3Dtrue=
)]
>          pub migrate_clock: bool,
>      }
>
> Related to this I have found recently the `attrs crate
> <https://docs.rs/attrs/>`__, which provides an easy way to parse the
> contents of attributes in a procedural macro.

I actually have some WIP patches for this I put a pause on and can
continue e.g. https://gitlab.com/epilys/rust-for-qemu/-/commit/c2c97caaaf03=
273fabc14aee5a4d1499668ddbe3

