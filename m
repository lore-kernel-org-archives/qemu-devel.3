Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE788C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTyvU-0002lS-2M; Tue, 24 Jun 2025 04:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uTyvR-0002kV-Bd
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:22:41 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uTyvP-000468-Fh
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:22:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60794c43101so274348a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750753357; x=1751358157; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miC1MCUaLvgBOaA5C5NrvIB/IopI0t5ylwKTe+JN9YM=;
 b=Arfobx0nYvFR4kX2ihX1RSVNRoqAJPheXAx/DWt0GWVZsqyPAq+Kv617WfDlA2kKvo
 hWDheaeBeOJOkZkCewsmutBU4b0UjGK5uQVUO5CNrITx0uKG2gi8YNxKIdgGeNlpxYzv
 u5GDipr5P1T/sB38kkfyx6K3j0oXsjNn54kxYmktwPpcZHCDHb8oaAJVZcPe8/0R3NUs
 /nV/COckAHwMO1j11erLjsjkvJzdXmQcJN5WzH3c+SdCMjoaD+zHqbydIUFpOhMZJwyR
 6hE/I60DwxfcGg/cAqPmH2jPrJf3EMvtpZv/3jCcYiRBzVVBd/J0RuKt4Roa9VR/gTxb
 Ovuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750753357; x=1751358157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miC1MCUaLvgBOaA5C5NrvIB/IopI0t5ylwKTe+JN9YM=;
 b=PEvLIk+JRXropwltVdg4mRtGZ1Ohly7tV51G5n1//sOSTXWFNb1X1wZO6sFpqT1BM9
 FM+r5Aad7fTCJvx+jS7g4mvyGDyFB7xgdIK46fChtHcqmHKZndUIS0uf152KTt4ydVa4
 KJbikEaC7iZaCaZKiRTUvshWpNFpZ2nh2yISsPrM6D1HqAUtJNdWOFOCVGRM1Gqh7XVN
 swHtIl0T52HzNmEO9+Z8IFsGza7dRDcW/rO3u8TKtHwvqWfh7CFzL/3K3imjxUyhR5lI
 ak/whhL7xYMdBaANIgBXpZtHUf4WkJJ7OFv47F8QQLBlx+j0XcuzIcYL49bJAOqPCKXm
 CA/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLfh8N8OADgtjZgXowl64YjaJ3Do6m0FgIFMZxLBSFDn68rPIs47GlIp6JD+aWfmlV/zl7ItJmEO5S@nongnu.org
X-Gm-Message-State: AOJu0YxRUS4m7P0mI9sT6sC/j2LSWowpm83BJH8PYe6cVriUfiau+QhL
 wcLiD12QMWh6N0jH00X0pTYXqv+3Ir3hsoFdwqONyrDjqk6Ls+A9Rqspj/+kUc0QSFjXvVcpqYW
 b6uBaMLpwSv7e935u94dnSZWPorrt9bFyFZXhkc274A==
X-Gm-Gg: ASbGnctz2SbWUpDVa0d7wd/tqj5upm77Sq7pdGYyTGUIJ8mgjHY4x06ayznHZdHcYaC
 PvmZ+FqLb6HZ3zDdRh9rTCjd1+md0JKb1BXlF1/vOXHREBOjSVFZ3y06f8IjrZxJtTsp5mHyV8o
 xghoIU+r66t6Ubb9hoFPsmB0hWT1AQiIDVPEhD3wEkEcU=
X-Google-Smtp-Source: AGHT+IHtfevvSKLGfx1E86073HZu19TuwWA5yNc3SaxLzv6VIzXlsBIyBZG39cQScgwHwv1JoCxSRcbb1yLDEBg0HB4=
X-Received: by 2002:a05:6402:42c3:b0:607:4c8e:514d with SMTP id
 4fb4d7f45d1cf-60a1cd1a8afmr14505536a12.6.1750753356705; Tue, 24 Jun 2025
 01:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250617081213.115329-1-pbonzini@redhat.com>
 <aFpR7+RMBlgt5DTD@intel.com>
In-Reply-To: <aFpR7+RMBlgt5DTD@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 24 Jun 2025 11:22:10 +0300
X-Gm-Features: AX0GCFsFbz5FGOd9V6PgvCbZrCu_lIp5hQq9cx_VTsecnaJ-tEfQkur6ZkCEmVM
Message-ID: <CAAjaMXZvi7FxdOgC8xpw5O1sQD3ncZSpRQpNEetNDMR3MdfhvA@mail.gmail.com>
Subject: Re: [PATCH] rust: log: implement io::Write
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, shentey@gmail.com
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

On Tue, Jun 24, 2025 at 10:00=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> >  /// A macro to log messages conditionally based on a provided mask.
> > @@ -24,6 +96,8 @@ pub enum Log {
> >  /// log level and, if so, formats and logs the message. It is the Rust
> >  /// counterpart of the `qemu_log_mask()` macro in the C implementation=
.
> >  ///
> > +/// Errors from writing to the log are ignored.
> > +///
> >  /// # Parameters
> >  ///
> >  /// - `$mask`: A log level mask. This should be a variant of the `Log`=
 enum.
> > @@ -62,12 +136,9 @@ macro_rules! log_mask_ln {
> >          if unsafe {
> >              (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::=
raw::c_int)) !=3D 0
> >          } {
> > -            let formatted_string =3D format!("{}\n", format_args!($fmt=
 $($args)*));
> > -            let c_string =3D std::ffi::CString::new(formatted_string).=
unwrap();
> > -
> > -            unsafe {
> > -                ::qemu_api::bindings::qemu_log(c_string.as_ptr());
> > -            }
> > +            #[allow(unused_must_use)]
>
> I found this doesn't work :-( :
>
> error: unused `Result` that must be used
>    --> ../rust/hw/char/pl011/src/device.rs:281:21
>     |
> 281 |                     log_mask_ln!(Log::Unimp, "pl011: DMA not implem=
ented");
>     |                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^
>     |
>     =3D note: this `Result` may be an `Err` variant, which should be hand=
led
>     =3D note: `-D unused-must-use` implied by `-D warnings`
>     =3D help: to override `-D warnings` add `#[allow(unused_must_use)]`
>     =3D note: this error originates in the macro `log_mask_ln` (in Nightl=
y builds, run with -Z macro-backtrace for more info)
>
> I understand meson sets `-D warings` so that `allow` can't work...
>
> What about just ignoring the return value? Afterall pl011 doesn't care
> the returned value.
>
> @@ -136,8 +137,7 @@ macro_rules! log_mask_ln {
>          if unsafe {
>              (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::ra=
w::c_int)) !=3D 0
>          } {
> -            #[allow(unused_must_use)]
> -            ::qemu_api::log::LogGuard::log_fmt(
> +            let _ =3D ::qemu_api::log::LogGuard::log_fmt(
>                  format_args!("{}\n", format_args!($fmt $($args)*)));
>          }
>      }};


Just `_ =3D ::qemu_api::log::LogGuard::log_fmt(...);` is sufficient, no
`let` needed.

Paolo: I haven't tested it to see the warning Zhao did (busy
lately...), but LGTM, as well. With that fixed,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

