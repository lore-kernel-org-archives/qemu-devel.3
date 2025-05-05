Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5424AC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBs9U-00054O-3g; Mon, 05 May 2025 05:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBs9K-0004xa-48
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:30:10 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBs9G-0001lr-UT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:30:09 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5edc07c777eso5907754a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437403; x=1747042203; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnQzmi1Xy7uDy5QqPZ5mjja3cTUskZY+1A3H4oT6BXU=;
 b=eb4nWWzqTFqdtDMz0HiXA7w1QNkOgttA+pzS/tSu9gkrUA9l8tBYWEK5Why2qa0gQ9
 R8iprvI279qQg2+3x7sOWOskicrgbE9RkCan5Grq7nVtVR6mP2z431vbh9omoCt+sUw5
 k1f8Eb/7fjZj2cUdQ3/evCeBkFaxEApOoGQepIWt4nDwVnL5wWvxZzBdItpUF9fo32/Y
 TgGmKSchRPPTsSaCWqwW+73i0qwNx6G1lNteRhfjhcV7TrDc3OVEbV+Udxhjax08c1jf
 Hue3idt5JBhgpxtW4b9nXT7u7oMr/TeeAtQ8oeBJLmWmBtX02MnSXgDmoty10M8bh3aD
 aLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437403; x=1747042203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnQzmi1Xy7uDy5QqPZ5mjja3cTUskZY+1A3H4oT6BXU=;
 b=Nsow8CUCH1UXFjHKra8eceOPYRRPfjpUA+fbIUpOIC3zIuiCy4C0FQdPBsHGx7bLhw
 T9T5BU4ZsFSc+c0z2Tu4tdBuuxZ/JhJHsZim8PppwG5gwpNt8QYdj7mxSVJB9+7/zbEg
 O3jyoy50svwPZUL97JOLnYd3epLTx7fVnXGtI1ZjXObIqm+3Oaumo4GGNET6vyTgRhLC
 1kE4WvZgYfOZez6IxQQvgco2nCBLV5A9Kd6u2khLxoZQrkdf5c+yfmLmQp18Gx75c7tU
 0zO6djOBr2WjLIqkTnhMOvFeGCCrUxB2iYlnRvGz2Ote9NzEVm8NKZkseTSyZ4tecQqA
 Pplw==
X-Gm-Message-State: AOJu0YwVn+nU60fg7CC8nZGeLtIy+775wpE9tZSnOCxcoCogSr/32bkc
 P0XTY1xrURwMqHmGUBuUyZk8izWLO2aZie2ZKCnwmakLJADHSpc1FE55qaRIyzuszeicEZ/aQJx
 dim1XiTzk52WkByaiMJ6P4GigHXge6q9LZgmL7A==
X-Gm-Gg: ASbGncv9DbmP2wDwQU5QgN30tvcPJQT+K6INgm73k1Mg7rQ9wpwz0dvYMte0gSIPFM9
 h1B2umjG/1nrAg/8qass6qt2g6ETHXNnoQRcqPg6SJsKEhukFtrHuBDo9Z9tKkjYtQLxfTvJzmE
 1MBfa456YZHXhtd2T5ZwzdYwDdJZxS0Dw=
X-Google-Smtp-Source: AGHT+IHNaAsVgBa0jQgcIiXmicHpOCw28Zcz1LPA7CJ4QgxBuLEMzioanb9lohE4TrkfBh5J4oaqWyHl5XmJRQRQxGU=
X-Received: by 2002:a05:6402:354e:b0:5f4:5dfa:995f with SMTP id
 4fb4d7f45d1cf-5faa7f478e1mr6763309a12.13.1746437403277; Mon, 05 May 2025
 02:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-3-pbonzini@redhat.com>
In-Reply-To: <20250505090438.24992-3-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 5 May 2025 12:29:37 +0300
X-Gm-Features: ATxdqUGdO9dCWT8h3WNuNL-aPqxiTvfwXUVaBdQrbDyqZq8PPkK_941xQUsq0Tg
Message-ID: <CAAjaMXZovuEzZpenUbFpy3QtFnE5NR-KgXthAgGvQRs3ae-Tew@mail.gmail.com>
Subject: Re: [PATCH 02/11] meson, cargo: require Rust 1.77.0
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, May 5, 2025 at 12:04=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build      | 6 +++---
>  rust/Cargo.toml  | 2 +-
>  rust/clippy.toml | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 8ae70dbe45a..e77da3f9b75 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -94,12 +94,12 @@ have_rust =3D have_rust and add_languages('rust', nat=
ive: true,
>      required: get_option('rust').disable_auto_if(not have_system))
>  if have_rust
>    rustc =3D meson.get_compiler('rust')
> -  if rustc.version().version_compare('<1.63.0')
> +  if rustc.version().version_compare('<1.77.0')
>      if get_option('rust').enabled()
> -      error('rustc version ' + rustc.version() + ' is unsupported. Pleas=
e upgrade to at least 1.63.0')
> +      error('rustc version ' + rustc.version() + ' is unsupported. Pleas=
e upgrade to at least 1.77.0')
>      else
>        warning('rustc version ' + rustc.version() + ' is unsupported, dis=
abling Rust compilation.')
> -      message('Please upgrade to at least 1.63.0 to use Rust.')
> +      message('Please upgrade to at least 1.77.0 to use Rust.')
>        have_rust =3D false
>      endif
>    endif
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index 5ace47c69be..eda7980b31a 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -12,7 +12,7 @@ edition =3D "2021"
>  homepage =3D "https://www.qemu.org"
>  license =3D "GPL-2.0-or-later"
>  repository =3D "https://gitlab.com/qemu-project/qemu/"
> -rust-version =3D "1.63.0"
> +rust-version =3D "1.77.0"
>
>  [workspace.lints.rust]
>  unexpected_cfgs =3D { level =3D "deny", check-cfg =3D [
> diff --git a/rust/clippy.toml b/rust/clippy.toml
> index 5d190f91dec..933e46a2ffb 100644
> --- a/rust/clippy.toml
> +++ b/rust/clippy.toml
> @@ -1,2 +1,2 @@
>  doc-valid-idents =3D ["PrimeCell", ".."]
> -msrv =3D "1.63.0"
> +msrv =3D "1.77.0"
> --
> 2.49.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

