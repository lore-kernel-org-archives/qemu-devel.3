Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F29D68B0B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZdS-0005vn-PW; Thu, 14 Nov 2024 08:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZdQ-0005vO-Ie
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZdP-0004qL-6K
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731589902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kh64F/XUjp6u/P1AuevFBKMTieTV/SfY3fs2H5/z6k=;
 b=Vw/2xVbkDGSd+hRk13ak1ThESdHIyUkNsktrq1NqTBuEaf2PfMnPOKZpfq6p7LLStoZccV
 1CagvxGTcKznt7VpXR8dgJAohYOBqiKT1FUZ/dA/uQHcsOaodFc7DUNmlGW0gHe4DuqiWI
 3LmeqrEd+6JfywlA9WnGJKeZ/JG6Sm4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-WOo_Bw_fPRGMU1taJvPH4g-1; Thu, 14 Nov 2024 08:11:40 -0500
X-MC-Unique: WOo_Bw_fPRGMU1taJvPH4g-1
X-Mimecast-MFC-AGG-ID: WOo_Bw_fPRGMU1taJvPH4g
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so364577f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731589899; x=1732194699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kh64F/XUjp6u/P1AuevFBKMTieTV/SfY3fs2H5/z6k=;
 b=erOVXwiEjazchcyn7nmFpF9eSbADFpU5Exc/DdA5Ew46yzbQVrlSkBNJi6SFJeG+RD
 dzMA3957RJXe1uwtihnjAafp53tF4sSKbsMuPjWfVcrs8e66m1V6pcUN9PeN1EYnJkRg
 qDTsyPu6w0Hv7xKgkel7qSzym3Jnhccwvk6x3j2UCkN9B+bNE8MzoGgGPLfHTWhDwihq
 P/XuedH09XIgk1rSJ5Zmp24OZNnrQ8ydIqBtdCSx+6RUcntA5pUApzq33g/ZGqaxHN3j
 CNWfQ9Pqv8CbmTvZ1mH/GsIdQOKvXBgz7+EcQgm2g+el4k32n57va9muGZrsXy2ipWoi
 aemw==
X-Gm-Message-State: AOJu0Yze9Cw011FRK9od0d+6awtZ+UmlLix4p9+YRi3niveQFjkogZYM
 w2llVRDeIaOiAxBeObCCkyvZY68dD8udgVx2BcbRJ5HeD0g10WXWfQ44SzZCLsCJktP6yuJ2HWx
 w1HlVX5tm7gsyzCBeSuKXnMlcv1fe27brHg/28L/W9e3zLOghuqfrvbJFiogtFWYCnwMUTgVmKL
 LOfaqHC+LOHp6ptl/4k1zS8F/sSd8=
X-Received: by 2002:a5d:5f46:0:b0:382:d79:842c with SMTP id
 ffacd0b85a97d-38218502c87mr1493095f8f.13.1731589899488; 
 Thu, 14 Nov 2024 05:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn/KC+1xSTcX2jwZta17AyiQlCKe1HFQ7ZN7LfzlYbzOsrgARJvNQnqmljcHlLaRP9yb9e0oLNWeoadgSVHRU=
X-Received: by 2002:a5d:5f46:0:b0:382:d79:842c with SMTP id
 ffacd0b85a97d-38218502c87mr1493072f8f.13.1731589899083; Thu, 14 Nov 2024
 05:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <87plmyrmjh.fsf@draig.linaro.org>
In-Reply-To: <87plmyrmjh.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Nov 2024 14:11:25 +0100
Message-ID: <CABgObfZT_jYJqKDnTAdrVjr9KdQXjNVEt2eQfDpoqrh6xEnVsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] rust: improved integration with cargo
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com, 
 junjie.mao@hotmail.com, zhao1.liu@intel.com, qemu-rust@nondevel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 14, 2024 at 2:07=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> > First, while it is currently possible to run cargo on the rust/ directo=
ry,
> > it has the issue that the bindings.rs must be placed by hand in
> > the build directory.  Therefore, this series starts by allowing
> > cargo to "just work" when run in a "meson devenv" environment:
> >
> >     meson devenv -w ../rust cargo clippy --tests
> >     meson devenv -w ../rust cargo fmt
>
> Is this meant to be the rust source root, or the root of the rust
> builddir:
>
> $ meson devenv ../../rust

rust/ in the source directory.  You also need to run "meson devenv"
from the root of the build directory.

In practice you can just use "make clippy" or similar.

> ERROR: Build data file './meson-private/build.dat' references functions o=
r classes that don't exist. This probably means that it was generated with =
an old version of meson. Try running from the source directory meson setup =
. --wipe
> =F0=9F=95=9913:05:22 alex@draig:qemu.git/builds/rust  on =EE=82=A0 review=
/rust-cargo-rfc [$!?] [=F0=9F=94=B4 ERROR]
> $ meson devenv rust

Your meson-private/ directory is stale.  Any "make" or "ninja" invocation w=
ill
fix it.

Paolo


