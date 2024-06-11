Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E499BC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 13:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH1K1-0008Re-UX; Tue, 11 Jun 2024 09:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH1K0-0008Pl-2v
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH1Jx-0008MJ-T7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718111632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSoVD+HWHz3z3mBYxCXNT/DvFCGFl6jxXBW8Y3QFPDQ=;
 b=g9GjB1/0fI//KhSOqi5i+tzZjyG4BmqGGYaMwrroA1oOKKBhq35awEGAFwhJ1EcSx3qj29
 uvCagCOXXoF+UtPXP+DNmVSlQGVv4J/4MZ6l8ZnTTZ0xQe5Zxq092ZcElDibwW8GkJ4AVb
 /N/WbMNw/uUjVc+p9hL/lwD54YCo1C8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-FEJLj5aDN0-2DXtpGc1OvA-1; Tue, 11 Jun 2024 09:13:50 -0400
X-MC-Unique: FEJLj5aDN0-2DXtpGc1OvA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f0b9c5bd4so539188f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 06:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718111628; x=1718716428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSoVD+HWHz3z3mBYxCXNT/DvFCGFl6jxXBW8Y3QFPDQ=;
 b=O3GBDlZIxD+zKMlNUKflatiAvvdnxmafcqVPm+tM9oWQdbeeF9xYPUd6BXdt//jW3w
 R9AGdsxe1vEcajLIzoJhdlEiaRbaOQL2V8eRCexOHvyoVk7GmCpfTyfCXGMTOX3oTzL6
 XlAyTPtcB6Vqvm4SnMIRlfwzPFttDn4cnUmlKa/upPDxlLneLsf9ONnLG4To/vc45ST7
 qa0MAT/huUhZM0nI8QirCgolBy3MsH1+7LdnR8MLbnHZ2DRzdR3DdMJZ63rp3Aqe+vtG
 lwDKEpFmw23NddRBdyOqRBwEKu1X8DhC4MiOvcSZGF7eqI/okGycIUi0M8gv0r/gj76S
 RhsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYoXzfInMsYprb1tS+vxQh20pXKcusilCa7ZrvwUqbhTOsQGeMih7j+fwNyqm8gvjknHBM/uUyHKAcCiwANmjY5PILlPc=
X-Gm-Message-State: AOJu0Yw1lBO+6zNxTs6m3lvhzJNPeNdfclADvS2ITA55nh4j1rt6pWwg
 +zIvEI1ztfRqnSO6Pf92N3dfmlIIuj86QexAtK/YwY1Nt6OuB0aNFLkKriovExcYb1iWTuXG/4P
 FnH5gcFTMvxgXtWERC8yN6OBlnYq1uQ1w9aQ2zrarGWXVHCA/B8SFDNxD0ZsRpCk4o/YcDIKeab
 LyPpCSUca1GVOb3sfP6qzV0BuEuQQ=
X-Received: by 2002:a5d:648f:0:b0:35e:83c0:82cb with SMTP id
 ffacd0b85a97d-35efedf8b16mr13073759f8f.70.1718111627886; 
 Tue, 11 Jun 2024 06:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG02BZJ2myERgrXw98rePshDSgPpZ6V1dQwmZMTnyKrM8LnDQEOkJ7QwjgLJdGrFAIs6xhdjsAJi0RUCEuDc7c=
X-Received: by 2002:a5d:648f:0:b0:35e:83c0:82cb with SMTP id
 ffacd0b85a97d-35efedf8b16mr13073730f8f.70.1718111627526; Tue, 11 Jun 2024
 06:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
 <evsu7.aus3yo6r56i@linaro.org>
 <CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com>
In-Reply-To: <CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Jun 2024 15:13:36 +0200
Message-ID: <CABgObfa1VfpyQJY4SdQfOt8BwPC5KDNrNVkXA3HgjEPipGNGUg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Mon, Jun 10, 2024 at 10:47=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> On Mon, 10 Jun 2024 at 16:27, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Mon, 10 Jun 2024 22:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >> What are the issues with not using the compiler, rustc, directly?
> > >> -----------------------------------------------------------------
> > >> [whataretheissueswith] Back to [TOC]
> > >>
> > >> 1. Tooling
> > >>    Mostly writing up the build-sys tooling to do so. Ideally we'd
> > >>    compile everything without cargo but rustc directly.
> > >
> > >Why would that be ideal?
> >
> > It remove the indirection level of meson<->cargo<->rustc. I don't have =
a
> > concrete idea on how to tackle this, but if cargo ends up not strictly
> > necessary, I don't see why we cannot use one build system.
>
> The convenience of being able to use cargo dependencies without
> special QEMU meson build system effort seems worth the overhead of
> meson<->cargo<->rustc to me. There is a blog post that explores using
> cargo crates using meson's wrap dependencies here, and it seems like
> extra work:
> https://coaxion.net/blog/2023/04/building-a-gstreamer-plugin-in-rust-with=
-meson-instead-of-cargo/

The worst part of using cargo from meson (like in libblkio) is the
lack of integration with Rust tests, but otherwise it's a much better
experience. IIUC Meson's cargo subprojects do not support build.rs,
which is a problem if one of your dependencies (for example libc)
needs it.

https://mesonbuild.com/Wrap-dependency-system-manual.html#cargo-wraps

On the other hand, I think it's possible, possibly even clearer, to
invoke bindgen from meson. I would prefer to have many small .rs files
produced by bindgen, to be imported via "use", and I would prefer an
allowlist approach that excludes symbols from system headers.

> > >I guess there will be interest in using rust-vmm crates in some way.

Yes, especially the ByteValued, VolatileMemory and Bytes traits.

One complication in that respect is that anything that does DMA
depends on either RCU or the BQL. We could, at least at the beginning,
introduce a dummy guard that simply enforces at run-time that the BQL
is taken.

Paolo


