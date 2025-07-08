Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED2AC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 19:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEBq-0001g5-FP; Tue, 08 Jul 2025 15:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZBMH-0005uQ-5i
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:40:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZBLV-0007wQ-FQ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:39:24 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60c79bedc19so7132562a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751992486; x=1752597286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQnPm7OMUxUj9kgIE7V/5Xg89kaFsjsthn3fZVSeLuM=;
 b=bG6WcPR/ReTLZFc2ANM5Mdbahbv1x1KMYbQHGyUL08Uvar6aSwE060AOCKk5aZrkND
 nMaCNo7gcJAo0cAGywR8D6dwlLpsP14aaU/fC/bAD/yW2Vu69qzL1+9oN/qUF0UVww2k
 6kXgZrgERpvuZvlCOaU8W4Mkrb/uTvwD5EL4IIajpaZRqLeNnqTdkBbXZ1v4Pzs5gVnV
 +Et9rRsFjTziX5zSlGUfCsmK9ttaV25THEhVriVRq5EHxlPDRoKgEAl7D8Vfc6ECHDvP
 p1FfrTodXN2u8eMC7ZGmHUAGTndaEWNmXybsfB+10GD/RAwbQaXUL/I+7wTg9suTBaEV
 P4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751992486; x=1752597286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQnPm7OMUxUj9kgIE7V/5Xg89kaFsjsthn3fZVSeLuM=;
 b=qkytoMxTnCQ87Kqj/KO3Mgepci0DLZ2a9kHYnhH8XEmkMFTyKdjgweOfNyFCrIXGhX
 5bw1lVnS0yvnIYpOX5imU8fsWMy+HlU55KAxh8nK3hMknFbV1aimYHbHyfVzm0LWE6vo
 WGhoih9wX+tf6/IeqkGtKtiXnQ5yqPaKpeMdYt0WZS1Z+IV8Kn/xDUpJA56fAkeu3EWt
 PUO8SF1JzEooQzgGY88RDv3yARsyVS7xMRiBNTEdVzQ5/F72YrDuSNDZeakicbtRuQlD
 UsIS4zE9g4iphsyYfRcbTsxhLqckNUOXtR2zmzpwOk/S4kaUJ1Vai4WjLQJQCvx8Src4
 GYPA==
X-Gm-Message-State: AOJu0Yz7BOErznYdYDXJ1jt4rLYtMuq2SrIy56oNM41iEJuON6DnkIkn
 A8c3kpl7qGeZuPVQY6oSmBP3CE8xhmOJLCOtJccQjqW2B129YSNKoD6xq/8JQcuXPrIQ5+Mk2md
 tFfgWENx9av7f10rdXJsIgII/mCh9upiqMMGwMBQL5TLj+hCeGCL0hVfGqw==
X-Gm-Gg: ASbGncv+wuxYqmQKcBt47q0GCe72zRrTKm1Fe1I2cGoDjzGpSvSu4GjnzbdOIsZNJ0X
 kkR8Vfcr0/hQF+XFCxscZyUME7tUpxwc8EuvNQOdAXPC4AjdGcDY0cUzJbpEQ0K+ihgQibxlfUD
 1YL080imGGof3US/+98xxd8fbD2IpbeNnQl3zpKfc1GGE=
X-Google-Smtp-Source: AGHT+IFfpggFdOxj172OW8RoiRnOg8d7/ZBIpPvPeI6W60v/YNcVFVsXg4hutuy34RcOlZ+7dHMKG46fAMK1ZcNruGY=
X-Received: by 2002:a05:6402:51ce:b0:608:66ce:14d1 with SMTP id
 4fb4d7f45d1cf-60fd2f85538mr13613177a12.6.1751965911713; Tue, 08 Jul 2025
 02:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-1-cd5314bdf580@linaro.org>
 <591f8a81-2c8e-4e30-abf2-4571afed41b4@redhat.com>
In-Reply-To: <591f8a81-2c8e-4e30-abf2-4571afed41b4@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 8 Jul 2025 12:11:25 +0300
X-Gm-Features: Ac12FXxuB6uXlv8JaSfaIgQfWwvDlv35gmb2UGJcAEboo3yqOfQmRkMT69epVEo
Message-ID: <CAAjaMXZ3JziZ6gUHF67=nqvxzUF0M46SPqftRKgHOYYLaUxjJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust/memory: replace size arg with Bits enum
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, Jul 8, 2025 at 11:35=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> > We have the ability to make memory accesses use a typesafe access width
> > type in Rust, which the C API currently lacks as it does not use a
> > newtype wrapper for specifying the amount of bytes a memory access has;
> > it uses a plain 32-bit integer value instead.
>
> I find this both verbose and (ok, that's subjective) ugly due to the
> extra import, the underscore.

Yep, I agree on that, but I wasn't sure what name would be better.
Whatever type-level improvement this patch brings, it's small, though
nice-to-have. We can drop it, no problem.

>
> There are two parts on the patches:
>
> 1) the extra checking on impl_sizes and valid_sizes.  That's valuable,
> what about just adding something like this:
>
>          assert!(min =3D=3D 1 || min =3D=3D 2 || min =3D=3D 4 || min =3D=
=3D 8);
>          assert!(max =3D=3D 1 || max =3D=3D 2 || max =3D=3D 4 || max =3D=
=3D 8);
>          assert!(max >=3D min);
>
> It can be validated at compile time anyway, since the functions are
> pretty much always used in const context (in fact, for C code there's a
> scripts/checkpatch.pl check that they are declared as const).

Yes sounds good!

>
>
> 2) Passing Bits to the read and write callbacks.  The argument is
> ignored for pl011, and converted with "as u32" for HPET.  I find this to
> be worse than before, because it's very unobvious that _32 is defined to
> 4 rather than 32.

Maybe do a `Size` enum instead that has variants: 1 instead of 8, 2
instead of 16, 4 instead of 32, etc.?

>
> The main effect on generated code is to add an assert! to
> memory_region_ops_read_cb() and memory_region_ops_write_cb() that's
> similar to the above.  I'm not sure of its value, either: if the size is
> not 1/2/4/8, memory.c/physmem.c must have screwed up big.  It's not a
> safety concern, either, since the size is not used in any unsafe code.

Yep it's more of a guard rail since we can't have refined integer types.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

