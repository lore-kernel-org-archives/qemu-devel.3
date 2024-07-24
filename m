Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6003C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZLA-0005wp-4I; Wed, 24 Jul 2024 06:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWZL5-0005vu-0Q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWZL2-0000QO-1U
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721817314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Dcz0jkcgeBEvszNeBkU11UrpFXkznp5mSctsUeH2Io=;
 b=dqd/XBIohs7INyPoXFUSWcKCmPUeMyRkuvc2WBwnGuRGa1MkYj96s0IOyvv53C43yi8doy
 bCuoxnDom7d2pSOXmMCu+j0q6qejPUKkTo4/gzU8nCrHgJnAH3vywoEEgCFcxMIzoTlmZo
 pCh5dwS2xWGeMysfpNZ9FRTsVGVbur8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-7rxgPZ9VMBWLeH-NGtnaeg-1; Wed, 24 Jul 2024 06:34:58 -0400
X-MC-Unique: 7rxgPZ9VMBWLeH-NGtnaeg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36832c7023bso3856119f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 03:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721817297; x=1722422097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Dcz0jkcgeBEvszNeBkU11UrpFXkznp5mSctsUeH2Io=;
 b=WP+Kik4iKTSN1vuV0bV1h8NhAgau2/+iSFYkKqoYnK5OkdfycstkZpXA5E4nJnlEzD
 MEjNsP2REpTUlGlBjFXa21J1VagvXu5uXxHy85ygtUFTMRnB3oRWZWHYiRjLekVeCIoQ
 omt5adaPB2KySeN5IVZOPy+ceRnBy3Hk93bhrm1S1Lyf+Kb9pgiNxACgOKjKK3utl7iR
 DNu8QWPuN7EtqsqB4ZWvsxclVkwvgQVO8f4JwTxYij7NhzlXbZfY6fJCZskcWEdmX5rO
 fd0WjS8fgc/XzYd/QiEEc5kV2JmhVoDZygCORfWa8zGsb0aZmMa/dvz2DLyi2HJCsGyE
 tgBQ==
X-Gm-Message-State: AOJu0YyAXmmtkk3/T/poErMYzRmQZdSFYtpAPtIijJmHd4Uafc3npkuG
 lSnHavm4iECqDQLrhTtAdYeiD0EbKGtK4XKaweoQtNLJc2ct73dSyzN+pJhIc0VC/qJUyUVw9hb
 gZifWdZdT57IDVyqKpTH8UIsePWzKbBTNnq/zu07f6MmlxTQn3YFnvD4bWGlUQTBGpnL8H7mxr4
 3qkDT+DFumqA3/CsCKw+5nbqzfdYY=
X-Received: by 2002:adf:e641:0:b0:367:a4c7:a134 with SMTP id
 ffacd0b85a97d-369bae49780mr9589118f8f.40.1721817297033; 
 Wed, 24 Jul 2024 03:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpQ51Ydtha84hA2BYkYdw+tfnIWRcxrOkzLlfvsIY5lhnUL1jMJwfK9/Dp6+3vb2ogvU5zw1R153Cow2elMi0=
X-Received: by 2002:adf:e641:0:b0:367:a4c7:a134 with SMTP id
 ffacd0b85a97d-369bae49780mr9589093f8f.40.1721817296563; Wed, 24 Jul 2024
 03:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
In-Reply-To: <h4gxy.dr366knvycy@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Jul 2024 12:34:43 +0200
Message-ID: <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 24, 2024 at 11:58=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Hello Paolo, thank you for the thorough response,
>
> On Tue, 23 Jul 2024 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >On 7/22/24 13:43, Manos Pitsidianakis wrote:
> >> Changes from v4->v5:
> >> - Added CI patch from Alex Benee
> >> - Removed all cargo use, use meson rust support
> >> - Added Kconfig logic
> >
> >The following requests from the v4 review have also been evaluated (good=
!):
> >
> >=E2=9C=85 module structure should resemble the C part of the tree
>
> To expand on this, I tried really hard to make the rust code live along
> the c files

Yes, I don't think it's a requirement that they live along the C
files. Using rust/hw/... as you did is fine.

> I agree. I personally prefer using meson wraps and fetch the
> dependencies via network to be honest. While also providing Cargo.toml
> and Cargo.lock manifests for developers.

Ok, it's good that you agree because that's what I was worried about. :)

> >
> >In my opinion we should start with cargo workspaces as the
> >known-imperfect (but good enough) solution, so that it could be evolved
> >later.  It is important that any change that deviates from common Rust
> >conventions is documented, and v4 provided a nice basis to build upon,
> >with documentation coming as things settle.  This is why I explicitly
> >didn't include Kconfig in the TODO list in my review of v4.
>
> After working with the latest meson releases, it seems we will soon have
> a good enough way of handling all this with meson. It makes me sceptical
> of adding cargo wrappers and using a build system out of meson when we
> might be able to drop all that soonish. We might as well bite the bullet
> now to avoid working on something we know we will remove.

Ehh, as you say below it's complicated. Sometimes worse is better.
Personally I wouldn't have minded keeping the v4 approach as a "known
evil"; but if you can make the Cargo subprojects work, that would be
fine for me. What I don't like is the vendoring and handwritten (I
think?) meson.build, I think that's worse than the v4.

> >Also, of the code changes (as opposed to the build system changes) that
> >I had asked for in the review of v4, almost none of them have been
> >applied.  I'm copying them here for future reference:
>
> Thanks, this helps a lot.
>
> >=E2=9D=8C TODO comments when the code is doing potential undefined behav=
ior
>
> Do you mean like Rust's safety comments?

No I meant comments where we have known instances of undefined
behavior. The two I had in my emails are

(in pl011_init):
// TODO: this assumes that "all zeroes" is a valid state for all fields of
// PL011State. This is not necessarily true of any #[repr(Rust)] structs,
// including bilge-generated types. It should instead use MaybeUninit.

(before the call to qemu_chr_fe_accept_input):
// TODO: this causes a callback that creates another "&mut self".
// This is forbidden by Rust aliasing rules and has to be fixed
// using interior mutability.

> https://std-dev-guide.rust-lang.org/policy/safety-comments.html
>
> These can be required by lints which is really helpful. At this point
> the UART library has safety comments (which needs to be reviewed for
> validity). I plan on adding some at the macros in qemu-api as well.
>
> >
> >=E2=9D=8C a trait to store the CStr corresponding to the structs
>
> I don't know yet if that is helpful in our usecase, because the strings
> must be visible from C, thus be (rust, not c) statics, unmangled and
> marked as #[used] for the linker. It makes sense from the Rust POV but
> must also be FFI-accessible.

Why do they have to be #[used]? You have

+                #[used]
+                static TYPE_NAME: &::core::ffi::CStr =3D $tname;
+                $tname.as_ptr()

but since the cstr crate (and c"" literal) promise to return a
&'static CStr, I thought it could be just

    $tname.as_ptr()

About traits, I meant something like

pub unsafe trait ObjectType: Sized {
     const TYPE_NAME: &'static CStr;
}

So that you can put the trait declaration in the pl011 crate and the
type_info! macro can do

<$t as ObjectType>::TYPE_NAME.as_ptr()

(also for the parent).

> >=E2=9D=8C a trait to generate all-zero structs without having to type "u=
nsafe {
> >MaybeUninit::zeroed().assume_init() }"
>
> Traits cannot have const fns at the moment (traits cannot have
> type-level effects like const or async but it's WIP to get them into
> rustc), so this cannot be used for statics and consts.

Ah, I see. Anyhow, I've been looking at the Linux kernel's pinned-init
crate (https://rust-for-linux.com/pinned-init) and it provides a
Zeroable macro including #[derive] support. So that has gone lower in
my priority.

> >=E2=9D=8C I'd like to use ctor instead of non-portable linker magic,
>
> The linker sections are pretty much standard and in fact ctor uses the
> same linker attributes. Would writing our own constructor macro be a
> solution for you? My reasoning is that 1) we support our own specific
> platforms and it's better for portability to reflect that in our source
> tree and 2) it avoids the external dependency, linker sections do not
> change so any ctor update would be in the API or adding more platform
> support,  not fixes in what we target.

I'd still like to give someone else the burden. :) Writing our own
constructor macro would be more work for little gain.

> >and the cstr crate instead of CStr statics or c""
>
> Oh yes, the c"" literals must be replaced. The cstr! macro is the same,
> semantically, can you explain what you mean by "CStr statics"?

Ah, I meant that it applies to both direct use:

pub static CLK_NAME: &CStr =3D c"clk";

and arguments to macros (for example type_info).

> >My suggestion is to do one of the following, or both:
> >
> >- start from this version; try using Cargo subproject support in 1.5.0
> >and see if it works, so that vendoring can be dropped.  We can require
> >Meson 1.5.0 to work on Rust support.  In this case it's okay not to do
> >any further code changes (the four that were marked =E2=9D=8C above).
>
> This is my preference as stated above, if everyone also agrees.

I think it's worth trying it anyway.

> >- go back to the build system integration of v4, and do *only* the
> >changes that were requested during review (in this case, all of them
> >except link_whole, with you checked it does not work).
> >
> >If you try using Cargo subproject support, please provide the running
> >time for configure and make, for both "v4" and "v5+subproject".  When I
> >tried it, the processing of the subprojects was very slow.
>
> Hmmm thanks for mentioning that, I did not notice any slow times
> locally. Will check.

Ok, thanks!

Paolo


