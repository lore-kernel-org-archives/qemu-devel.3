Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DE6C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 13:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAq5I-0007UK-Ir; Fri, 02 May 2025 09:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAq5G-0007TM-1e
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:05:42 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAq5B-00047O-04
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:05:41 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so3859293a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746191134; x=1746795934; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpeubmXOH9YAEzoaHh+bQKvZl7yXSx9UCWkBzUJPnPo=;
 b=vw+w4V4AITYaVkotX9ua5Z/2dyJW/RDaAkMdibR5UEqlDA2vR//cjQOT1/u4LB2jlq
 16dXDXsE1mB+KQBMGVyxhEo3ox45zpZd0bE8r/L15lsorB6JXllNN94s+sg9dAUFX7Si
 ZQ/gw7aai2E8+CzgBpxUSpTQ7klWcStRURSLEX1vT733PNF/ddPDw+tV4kBR1qWFHAWa
 fYzHDrSccGEnWnEM0ljNxhCIWPIrBKo0hd8r4BJyJTGyyK4VL941PXozqCL3dN8wZMPT
 bIw2zHJOsblDahA3xtFOAa2bIijGQxobI5HKk8k2FufPOc4z/biqq+p3nvdfgLAgIpX8
 D1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746191134; x=1746795934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpeubmXOH9YAEzoaHh+bQKvZl7yXSx9UCWkBzUJPnPo=;
 b=CKuoLv5tXS7ZdSsvn+YFpr3L9e3JHNDbm0ysLtG6Qdh0Sefj9PiPRRhxdM7dNDu6SX
 GcJK1/or2QVR2Y3qGUQdEHFKz05LdxlakCsKv9CgRAfZCgC6gx+ex4yv8pvGzxFZ3Aap
 Ptz0O/RpUG5iUUfAgck3pXXijyV4DW4L8QxeBAShk8E/j97mXDcQZXESE0J8E3GI96IK
 WGZcJEGsMJGJdMzbux9B5LOIL6kAHZqGRGFRk7edrfHWS2VXHjM8UxejPxT/dbFI5fxE
 uULvd94sZkTZnLrZExu5bpD78W+Oi7lHxRZwXwdLKV7PQN7f5I8YBlC2nqeMsP7Sex/T
 Aztw==
X-Gm-Message-State: AOJu0YzNK61gO0DMvwaJ9H8zq04Xg/huaPowiKoIsOP5Oz5pJqOOIutb
 s8+mrS0wkT3EtCo9stSEkDBq/BO3IZuKW7Tt1x1WMkzRw8yiFKWcr/FvQ1SRZQXMJGCR8UEFVHS
 WbZD9qKFG0rAPhR3zTa+Us3fcIpyJtpql+UV65A==
X-Gm-Gg: ASbGncub3IHiz4Tj01mqzXBdgOVwyof+Izjxk2WJ+PZfNSF2glhuoN87yT5s62KWBBZ
 cnyxtoIujv2+zK8B+T25Ytta74BfsaP4J7V7qXDXL7aWJSgrmzXkh3T0W0me78FW7vFWWbyMBKO
 HQxPQm8IgdyGCcJEhXtWo=
X-Google-Smtp-Source: AGHT+IHQzIg+TUOl9yRWbX67CQQJrR7ArRMZZo1NfSt+jmD3emgNGdYYEC6bIyFpNW6bTxTlA71JL+YNgJvWmtWESUE=
X-Received: by 2002:a17:907:961f:b0:ace:d68c:2f88 with SMTP id
 a640c23a62f3a-ad17b5ac57dmr306986166b.20.1746191134292; Fri, 02 May 2025
 06:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-6-pbonzini@redhat.com>
 <svms9i.274a4or3m08g3@linaro.org>
 <efc7ef30-002f-4fe7-84dd-1daeedbafaa5@redhat.com>
In-Reply-To: <efc7ef30-002f-4fe7-84dd-1daeedbafaa5@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 2 May 2025 16:05:08 +0300
X-Gm-Features: ATxdqUHgegE00rsA3wYD-WqgC1XESBHRVEluC0vprGLXvq6T42TKMsVcpzoticc
Message-ID: <CAAjaMXb-28SOS7GyJTV6qRjRVramDHMN7JW-jzB-8Nu97GR4ng@mail.gmail.com>
Subject: Re: [PATCH 5/9] rust: use MaybeUninit::zeroed() in const context
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
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

On Fri, May 2, 2025 at 3:23=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 5/2/25 13:01, Manos Pitsidianakis wrote:
> > On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >> docs/devel/rust.rst              |   4 --
> >> rust/hw/timer/hpet/src/fw_cfg.rs |   6 +-
> >> rust/qemu-api/src/zeroable.rs    | 104 +++++--------------------------
> >> 3 files changed, 18 insertions(+), 96 deletions(-)
> >
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >
> > BTW There's this TODO in qom.rs, ObjectImpl trait
> >
> >>    /// `&mut T`.  TODO: add a bound of
> >>    //[`Zeroable`](crate::zeroable::Zeroable)
> >>    /// to T; this is more easily done once Zeroable does not require a=
 manual
> >>    /// implementation (Rust 1.75.0).
> >>    const CLASS_INIT: fn(&mut Self::Class);
>
> Yes, good point.  When I wrote the TODO, my idea here was to have some
> kind of
>
>         #[derive(Zeroable)]
>
> macro so that the compiler can "confirm" the safety of implementing
> Zeroable by hand.
>
> However, most of the time the class will be just a C-defined class
> (DeviceClass or SysBusDeviceClass), and then it's not even possible to
> add the derive attribute to the declaration.

Yes this makes sense. A benefit of having `#[derive(Zeroable)]` is
avoiding blanket unsafe impls of the trait, since the derive macro
would work only if all fields implement Zeroable (so in a sense, it's
safe as long as the individual field type impls are safe,
transitively). And we can still do manual unsafe impls for everything
from the FFI boundary.

>  So adding the bound to
> ObjectType::Class is feasible now that one can just add
>
>      unsafe impl Zeroable for bindings::ObjectClass {}
>      unsafe impl Zeroable for bindings::DeviceClass {}
>      unsafe impl Zeroable for bindings::SysBusDeviceClass {}
>      unsafe impl Zeroable for bindings::ResettableClass {}
>
> etc.; in fact it was already possible when Zhao added the impl_zeroed!
> macro in commit aaf3778baaa ("rust/zeroable: Implement Zeroable with
> const_zero macro", 2025-01-28).
>
> Paolo
>

