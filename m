Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B1C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUOB-0001Jl-HS; Mon, 10 Feb 2025 09:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thUO9-0001J4-Jm; Mon, 10 Feb 2025 09:03:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thUO5-0002oS-QL; Mon, 10 Feb 2025 09:03:52 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dc9f3cc80so1094701f8f.0; 
 Mon, 10 Feb 2025 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739196226; x=1739801026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVgu/fILx4R18MQcKmjH6ia1JsG6VZu624mhx+Fx/DA=;
 b=V2C2mdQUxNDTGQbXyDVm41xKYmlvUZZvPbdEF+miGiD94uhR+MGFMhRgYaWEFGOE+g
 2ljGWPAnPa95budUEI90KWHALKO6nOqdLjyLwic+31ccnWdeBRsNq81KwF5hiL+5vunC
 ISXqI4BEdwaqxWhTy7obVF5Ga+IwZc/ui0k6+dS1vGuOhh6pr5QZ8KX9i7n2pQpMcrK/
 0y5aECyThHONK+1mrFoc3tpHSiaUMIaQntbwAgln0eVJzZ7wkxwrBqqFFWUqDeII0bvi
 dJYflmhi4ZxkYPtJTvIxquWp8gQkzOylZn9aurK1rRlMZd0VK3AvAr6ijx8iymuSHc0O
 BA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739196226; x=1739801026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVgu/fILx4R18MQcKmjH6ia1JsG6VZu624mhx+Fx/DA=;
 b=H6awFttD0NOg9OmG8gs78v7W8hbrimAl6YM7Z4UE3nx7rloy2xndjLLVBoTF+goytU
 KSQI/LhLri+utwsYgRvz4Gt+gjg42srwhm4HQ+9oJvFVgI8fbwYTdGm4rzBVF8HNhuhv
 LRS6LldMTzvtQ9D9K2QVvjR9T9XWVDdvD3pRawXHalmTmuLahF/0XdzPm1OvUdT/+BL5
 +65/UCjTN+TVPsqnGi7TPyC/6G0QugjWO9CxE+IZTdEk/R7r113+sH+1/qQwlE/Xe7JG
 baolivw7j5fwrnWzv6E1HQwqL6nocFvmVxC2V9Psznek2u2gXKLG4uBeEAj2emdunNRy
 pYZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeTF57BM54n5xEwkkZJzoGMrgn921Yy6Gxdkr/KxyBfjFC778oC1CQpBgWeMJ4njPViiHCGwQ5eRU=@nongnu.org
X-Gm-Message-State: AOJu0YycQcZEjC5K80pR8wlsqp64rKCGWwDoWeDJBWOVk+CglIBn7ZB7
 oR/jeu0fB5iscWZsrZuiMYT/UVV3SNGIH8VGm2lkI/7aH8Z/hUe8vrp5hH3OO7Xz7+TXdlBBSIW
 GEi7bxW3EGPhJWbZp9Sb5m4JRDYI=
X-Gm-Gg: ASbGncu9ynyH8yG8sZzSIpDMCRw3XDx6Vh2tq/XEy8V2oPwZ+At0SanbPUcRoEEmwTF
 Rpu/O0BuY2V3eyra7XuYkaM3wUcMY0PLWlKTDJHepghflkgTn+bmwAFP/smdHm/jZBfCc+3E=
X-Google-Smtp-Source: AGHT+IGK9JkzRMIMNsFjJuRyRwvUq0cFmRXhNyOeL0bCDwyHrSUwheotVeNi5Qc4lr8zudLoCuXuB3LuIZGXPwV9Xy8=
X-Received: by 2002:a5d:4443:0:b0:38d:b57e:7202 with SMTP id
 ffacd0b85a97d-38dc90f0df1mr6971949f8f.31.1739196224544; Mon, 10 Feb 2025
 06:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20250207143952.2486587-1-pbonzini@redhat.com>
In-Reply-To: <20250207143952.2486587-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Feb 2025 09:03:32 -0500
X-Gm-Features: AWEUYZmfijj4wz7RGWM7lc_qzBGGAYeiBpUXepzQFr2N4_KZX7QLl8t4M07Sus0
Message-ID: <CAJSP0QXEhD-4UF15kOxcPZvVSwpcgjFZM9x3HxnfpjvH4WM8Pg@mail.gmail.com>
Subject: Re: [PATCH] rust: pl011: use default set of lints
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Feb 7, 2025 at 9:40=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Being the first crate added to QEMU, pl011 has a rather restrictive
> Clippy setup.  This can be sometimes a bit too heavy on its suggestions,
> for example
>
> error: this could be a `const fn`
>    --> hw/char/pl011/src/device.rs:382:5
>     |
> 382 | /     fn set_read_trigger(&mut self) {
> 383 | |         self.read_trigger =3D 1;
> 384 | |     }
>     | |_____^
>
> Just use the standard set that is present in rust/Cargo.toml, with
> just a small adjustment to allow upper case acronyms which are used
> for register names.
>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/lib.rs | 9 ---------
>  1 file changed, 9 deletions(-)

(I'm late, don't worry if my R-b gets lost.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.r=
s
> index 88452dc888c..1bf46c65af2 100644
> --- a/rust/hw/char/pl011/src/lib.rs
> +++ b/rust/hw/char/pl011/src/lib.rs
> @@ -12,16 +12,7 @@
>  //! See [`PL011State`](crate::device::PL011State) for the device model t=
ype and
>  //! the [`registers`] module for register types.
>
> -#![deny(
> -    clippy::correctness,
> -    clippy::suspicious,
> -    clippy::complexity,
> -    clippy::perf,
> -    clippy::nursery,
> -    clippy::style
> -)]
>  #![allow(clippy::upper_case_acronyms)]
> -#![allow(clippy::result_unit_err)]
>
>  use qemu_api::c_str;
>
> --
> 2.48.1
>
>

