Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF08D16279
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MIY-0002Uc-LE; Mon, 14 Oct 2024 10:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0MIX-0002U6-0e
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0MIV-0003tP-NL
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728917026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFvo3l3T1rLdjDScIu9Kdd6ZyJ4HqiVyYkdpex5m6tM=;
 b=eWm0BuT4DIRL3/ywJa1Vp5AJGjBi9evIpsKHDxgH0JkqN7VDofJXeLcNOj0uE8+LmgpW3V
 GA0mS+du6fUPzvmG16BQmSSIXEQkBQvavopvJFVUZ9wZtsXZbjJCyDeDt54d7daUNFfs0e
 /LAke1nF6R2atsMqYKbV8Oa7uH73FNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-vAt-DVsyMAaEVB0CbBIetA-1; Mon, 14 Oct 2024 10:43:44 -0400
X-MC-Unique: vAt-DVsyMAaEVB0CbBIetA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d504759d0so2328392f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728917022; x=1729521822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zFvo3l3T1rLdjDScIu9Kdd6ZyJ4HqiVyYkdpex5m6tM=;
 b=lzMuPS1s5ACGSaJDPonwaiuJ4yyRwUsD5gvC5xnUWNY830wE00W1xTuCZUnAnB+Fzz
 n8sq4dv5+WcOtIYP7dHuI2jIuROrDgBRvCKNSzhaa/xlLo73qrC5Yf4+Ja/9z+CJ4Qsz
 xHNJ3ictSA4XueYyVWbOdTlxVpfr/LDQ6I+sQw+Kf6mALfnMwAAwRxB/EPII+RsJ5sL3
 0qB/OTm9AaMp84UuWMx6GFPvBtrTF2rsGit5DrKD1Wcb0BAlmsGsSecHg/6++zUfBDCR
 3o0wZ79+BNheYoBYKQlQxO+4rfar+Qq5Ls/dNdce8N4LEtyBk3yPl09MpOGx85fwuB87
 CFZw==
X-Gm-Message-State: AOJu0YyG9gSfpfe3DqP3h2QSgsf9goznpJIAAy+VwzRCNGOwfwfq6DFU
 W2t4nauXMf0VaOzveC45aDhNV7YwMlrlRAxHXUBPXOlnZ50ID9YgD6u8L/QG/lV7cc07iBpAjdz
 Lqf8AttHJmJ4AmAViWtE19RadC2I/aQj7WbxENjvXDCv5++oTsR8ky/6oAzfLi2PcK1D9iNnLjV
 W2y3gTdSA5Mg6gcFcdJoev/6FTBDusZEZorwhEFqZs
X-Received: by 2002:a5d:45c9:0:b0:374:c658:706e with SMTP id
 ffacd0b85a97d-37d600d2ffamr8027381f8f.39.1728917022510; 
 Mon, 14 Oct 2024 07:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmP+MxmymBFdgGCKcC8IHRbXzAX0tfS38tyEiyEu7+ha2HPIu76jY1tQ4i34lxNHllo2dZvNtGNv4qbRyZ2Rg=
X-Received: by 2002:a5d:45c9:0:b0:374:c658:706e with SMTP id
 ffacd0b85a97d-37d600d2ffamr8027372f8f.39.1728917022198; Mon, 14 Oct 2024
 07:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241014143640.196735-1-pbonzini@redhat.com>
 <CAFEAcA_GgntHgo9tP70L1tHVhxXcsgJ0hne-sqHHH2-B+E4oCQ@mail.gmail.com>
 <CAFEAcA80D0D1Yjb6d8TkLi6zmP2gX8NSF_j3uenZrN=tfv9KoA@mail.gmail.com>
In-Reply-To: <CAFEAcA80D0D1Yjb6d8TkLi6zmP2gX8NSF_j3uenZrN=tfv9KoA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Oct 2024 16:43:29 +0200
Message-ID: <CABgObfa-0BzG=q+WPCp47RPeeoXr8HZuweS-J0TyhA9MVfqAdw@mail.gmail.com>
Subject: Re: [PATCH] meson: check in main meson.build for native Rust compiler
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 14, 2024 at 4:41=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 14 Oct 2024 at 15:38, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Mon, 14 Oct 2024 at 15:36, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > >
> > > A working native Rust compiler is always needed in order to compile R=
ust
> > > code, even when cross compiling, in order to build the procedural mac=
ros
> > > that QEMU uses.
> > >
> > > Right now, the check is done in rust/qemu-api-macros/meson.build, but=
 this
> > > has two disadvantages.  First, it makes the build fail when the Meson=
 "rust"
> > > option is set to "auto" (instead, Rust support should be disabled).  =
Second,
> > > add_languages() is one of the few functions that are executed even by
> > > "meson introspect", except that "meson introspect" executes both bran=
ches
> > > of "if" statements!  Therefore, "meson introspect" tries to look for =
a
> > > Rust compiler even if the option is disabled---and then fails because
> > > the compiler is required by rust/qemu-api-macros/meson.build.  This i=
s
> > > visible for example if the compilation host has a stale
> > > scripts/meson-buildoptions.sh and no rustc installed.
> > >
> > > Both issues can be fixed by moving the check to the main meson.build,
> > > together with the check for the cross compiler.
> > >
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >  meson.build                      | 3 ++-
> > >  rust/qemu-api-macros/meson.build | 2 --
> > >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > Missing Signed-off-by: line ?

Ugh, yes (my OpenBSD VM does not have the usual git hooks :)).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> Oh, and is there any better order in which to apply this
> patch and your other fix, or does it not matter?

It's not super important but I guess this one could go first, since it
affects non-incremental builds (as in CI) as well.

Paolo


