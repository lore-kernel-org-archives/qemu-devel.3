Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8440C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLFw-0002rx-HN; Thu, 17 Jul 2025 05:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucKlO-00065u-C2
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:18:51 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucKlM-0007tX-7t
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:18:50 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so1346171a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752743926; x=1753348726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p83N9iznizlLrpKVZKN311F6+lziC9z7tiai8l7HG/Q=;
 b=KT4DMBbYDO6B9CqYbJok1fV95PKBclnD4buf86CRIUApmkOSBdZ8eiP7kAG47p4C1/
 hEinu+P1iXqRO/mA22ovUjh6tYxalZPKuXvK7uqFuUo1D4iO6k06/vmi08OPNExIMeam
 XvJ4M0Ce8ayAzEdxBhncJI3CDCtmhu2Adhwo27PqsVXz1k7756ZRgzXA89sX6tCPnI8R
 iAHZIRT3mUZ+4Xup+LYeuNzD2FR43X6K2K1BsJ8zRjgxbiWk3PcZlli1k1LJo3ar3p8N
 9/75vmZQs1nNRb1aN7fotRNecaYuj6jhWmmR/ClB1ynVY5tg7NcrmRZpR8zHSIC5WTF1
 LPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752743926; x=1753348726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p83N9iznizlLrpKVZKN311F6+lziC9z7tiai8l7HG/Q=;
 b=hVmEmhxXzdmTtyEGgQ4Dvd+E+gmUrGUWxSS5qC+V1Wn3nWiuTqbkQIicc7JEatdWYM
 hntla/XHI6e8K1DZdqqCTgTLjLB8ALJvsGg2TBT+099sh41vBZ9LyyUUXcRh4sZjFYPS
 Itedm2HRMLX6ozyUYV4M62UCUqjq+IDuMNZBMFHU3fiAtobfVfMHeHYR3k+G+A6+atFr
 tNhtbV9izIv2PfouJARGKc1iIDHppWHDdLad92YZ6tS+TYVj0gGe8lpAWnKj3BLXN+EJ
 od0Vcc0AQDS56eURyn8ffn5xD53UbZhTth9JxtRq4BZwuchE7fl9qp8UsPUJaHXzwGu+
 MkqA==
X-Gm-Message-State: AOJu0YzCD2oERKUr59RzCokWI4HNL2/kfOUtrhHZY1jF1evbGWdgWnAN
 mJ2QAoMshf3fj+9Tc6GjMHUofX93A2seuhB3WB3zgsLckrIk+mSIOqSXA2rCVFQZz5Azr2RZVgh
 0aSdCZTGrfmvFx4b6FWgLyee7KIS7rKS+b2Ec0uNkmw==
X-Gm-Gg: ASbGncs4C7Nd+UiQH2ytsYRAVmd82seo7UMPBgZk0Bb2ohecpGcztlv55SShqJWauSc
 z1GJ26OFnZXgIJ9Bf+DymYeAQaRJ5fWbCyoAmwnX2tLMj7u3TqXYF7CEtgnJ4teaUt/BlwTEp1x
 I0KGWOqIza4wJmDAtxLWgLN5v3lorIvzeEK7w0j2n3cvytEYWeOKTd7jLhNTYyBc9R4RvDmOrMj
 1BGZw==
X-Google-Smtp-Source: AGHT+IGfnHzWwwTD+wTMdMCWAjSwh/IXuANqP0093/5w/acU+62L+Ts9uGNL7U+SXGXux4T2Uw1HN7DGQsV4JbxVqAo=
X-Received: by 2002:a05:6402:3552:b0:605:2990:a9e7 with SMTP id
 4fb4d7f45d1cf-61281ecb648mr5784101a12.13.1752743925548; Thu, 17 Jul 2025
 02:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250717062727.305466-1-pbonzini@redhat.com>
In-Reply-To: <20250717062727.305466-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 12:18:18 +0300
X-Gm-Features: Ac12FXwaWOKdAh757fc3LKoaaKHEGAwWnFeMuYvDshArDnYVsVxf1FCCZsf3_Is
Message-ID: <CAAjaMXauWy1sk+JkjTRzAf8yA72Xk=Qbt4+yw7XNPfx=q4WTZg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] rust: use attrs crate to parse #[property]
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
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

On Thu, Jul 17, 2025 at 9:27=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> This needs a bit of preparation, but it simplifies the handwritten parsin=
g
> code down to approximately 10 lines, and slightly improves the error
> messages too.  All the scaffolding will be shared by future uses of
> procedural macros.
>
> Thanks to the author of the attrs crate, Aatif Syed, for accepting to low=
er
> his crate's minimum supported Rust version to 1.83.
>
> Paolo
>
> Paolo Bonzini (4):
>   subprojects: update proc-macro2 and syn
>   subprojects: add attrs crate
>   rust: qemu-api-macros: support matching more than one error
>   rust: qemu-api-macros: switch #[property] parsing to use combinators
>
>  rust/Cargo.lock                               | 19 ++++-
>  rust/meson.build                              |  2 +
>  rust/qemu-api-macros/Cargo.toml               |  1 +
>  rust/qemu-api-macros/meson.build              |  1 +
>  rust/qemu-api-macros/src/lib.rs               | 84 +++++++------------
>  rust/qemu-api-macros/src/tests.rs             | 14 ++--
>  scripts/archive-source.sh                     |  2 +-
>  scripts/make-release                          |  2 +-
>  subprojects/.gitignore                        |  5 +-
>  subprojects/attrs-0.2-rs.wrap                 |  7 ++
>  .../packagefiles/attrs-0.2-rs/meson.build     | 32 +++++++
>  .../packagefiles/proc-macro2-1-rs/meson.build |  2 +-
>  subprojects/packagefiles/syn-2-rs/meson.build |  2 +-
>  subprojects/proc-macro2-1-rs.wrap             |  8 +-
>  subprojects/syn-2-rs.wrap                     |  8 +-
>  15 files changed, 111 insertions(+), 78 deletions(-)
>  create mode 100644 subprojects/attrs-0.2-rs.wrap
>  create mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
>
> --
> 2.50.1
>

Looks OK to me but are we sure it's necessary? This dependency is just
a syn::parse wrapper under the hood. Even serde's derive macros use
syn directly: https://github.com/serde-rs/serde/blob/babafa54d283fb087fa94f=
50a2cf82fa9e582a7c/serde_derive/src/internals/attr.rs#L276

I'm not against dependencies mind you, but this replaces just a few
lines of code.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

