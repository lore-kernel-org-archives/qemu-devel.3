Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DE6C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 19:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLpkI-0008Cx-Hf; Mon, 24 Jun 2024 15:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sLpkF-0008Cl-O0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:52:55 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sLpkE-0007WQ-1n
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:52:55 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5c20995d038so477563eaf.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719258772; x=1719863572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MrM8afd6V05dl66GYjtEvLL8qUzmv9WggHpJgV/aLM=;
 b=Ev7r0MMQzqJKc+ZlTgS9tlnvWzSmn0xkUXlBOnEF9UABEWwYKXlkhctWiDYU8DwlrM
 jDNL57ZDS7Ul6uUTj7I8QGOkeUQh3yn9icfUSakko/Nq2afJyMkvjyW3fUw9G7Mit8XP
 8wxB6COSXQ9slAAzXrPETEBYdBqEXYUK12eV8/OR1xGbc8YeJa/+R70bp/cXC/uLp+0X
 sH7phkxL8+rlU2Vz5jkuONGAOszjs7Tu/084GY64ovD7uAupxDiXceS8pbcKONrHh8wf
 HM0FeJlIG4P1PXw/JkjIYCVW5TWGGPS6kKjzhoEsa5Q1gNYFvcb//TulA7SPrzfUt1Um
 jHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719258772; x=1719863572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MrM8afd6V05dl66GYjtEvLL8qUzmv9WggHpJgV/aLM=;
 b=jF9V8edha6vak7vxHrFMBHpI5iLXhOho+J0egi5JPi2ZuTYQVDEYQITZvI5eJs78dC
 ohh77tXOSaS5Y8xlO8op/COFclCdVObatlzo3CKsjL1JqklYd4WqZIufhq1xpntdJPZ5
 cQ/mDRLVScGF2ANJmd6InPUEwcwjlB6BJSqxcn3V8b0jI+h7Axd6KftXudNYr4KRq1cU
 wzdhT+Ax/6fO0pdoenzbr1QabrsCCT1zIDpdKeB8fdhpWc1r12lzsiGom6mO8AgDruiF
 mVVHQh9UfN1wPs8ppZ9eD9SeFt6C0R//bimbbel5vwE8t+AEUUqjNklfUvYt0m7A6B9U
 wv1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDH3Q8l8BL6z8mkhItszfr1BRN8JMyjbUU8aUMpGpj8Htm+fHA2n56x8SjxkbBRXwNb4696Vv0jqZGKmA6Ad8R0dYuhAM=
X-Gm-Message-State: AOJu0YyElazzWH56k/BMiZQ6fKEphksxO/PZO30dSCDHomEoVLbGDkng
 kPioJrL/FZYXgUV8Q2bDhPTcqL5GrJclOE0W2tWZKc6/F30huEVl4HCqCUYZJ941fAl/7U4TaPR
 y/TaY51c4H5IlNUjxFMpCCcxZP2Q=
X-Google-Smtp-Source: AGHT+IE1AciMn0NRGqnWop/mDqGLyC74HKRWJWsbubk1xDs6TvIvOdEha9UnU8ihoO/NriwtgDFbdB1VI8XR5+SzdHU=
X-Received: by 2002:a05:6820:2b0d:b0:5c1:eee6:6ed5 with SMTP id
 006d021491bc7-5c1eee66f99mr5400695eaf.2.1719258772128; Mon, 24 Jun 2024
 12:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <8734p7dcbq.fsf@draig.linaro.org> <fe6ax.yk8b6hjo7ezl@linaro.org>
In-Reply-To: <fe6ax.yk8b6hjo7ezl@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 24 Jun 2024 15:52:40 -0400
Message-ID: <CAJSP0QUdvJEy308dm0jvcVaETrMZfus+9U7mSZDDd=U+rsHQPg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
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

On Thu, 20 Jun 2024 at 14:35, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, 20 Jun 2024 15:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> >Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >
> >> Add mechanism to generate rust hw targets that depend on a custom
> >> bindgen target for rust bindings to C.
> >>
> >> This way bindings will be created before the rust crate is compiled.
> >>
> >> The bindings will end up in BUILDDIR/{target}-generated.rs and have th=
e same name
> >> as a target:
> >>
> >> ninja aarch64-softmmu-generated.rs
> >>
> ><snip>
> >> +
> >> +
> >> +rust_targets =3D {}
> >> +
> >> +cargo_wrapper =3D [
> >> +  find_program(meson.global_source_root() / 'scripts/cargo_wrapper.py=
'),
> >> +  '--config-headers', meson.project_build_root() / 'config-host.h',
> >> +  '--meson-build-root', meson.project_build_root(),
> >> +  '--meson-build-dir', meson.current_build_dir(),
> >> +  '--meson-source-dir', meson.current_source_dir(),
> >> +]
> >
> >I'm unclear what the difference between meson-build-root and
> >meson-build-dir is?
>
> Build-dir is the subdir of the current subdir(...) meson.build file
>
> So if we are building under qemu/build, meson_build_root is qemu/build
> and meson_build_dir is qemu/build/rust
>
> >
> >We also end up defining crate-dir and outdir. Aren't these all
> >derivable from whatever module we are building?
>
> Crate dir is the source directory (i.e. qemu/rust/pl011) that contains
> the crate's manifest file Cargo.toml.
>
> Outdir is where to put the final build artifact for meson to find. We
> could derive that from the build directories and package names somehow
> but I chose to be explicit instead of doing indirect logic to make the
> process less magic.
>
> I know it's a lot so I'm open to simplifications. The only problem is
> that all of these directories, except the crate source code, are defined
> from meson and can change with any refactor we do from the meson side of
> things.

Expanding the help text for these command-line options would make it
easier to understand. It would be great to include an example path
too.

Stefan

