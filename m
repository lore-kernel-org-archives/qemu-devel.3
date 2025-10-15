Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C1ACCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rgn-00042g-Ez; Tue, 14 Oct 2025 22:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rgl-00042X-Rp
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:56:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rgj-0007JJ-6W
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:56:31 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6318855a83fso13569270a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760496984; x=1761101784; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSOyUOfcRgwCLQjHz3KGvCyxbJuRpakhwxIp0fdtB+4=;
 b=RW5ksoIN5/GNT6djN2VYbbZ0d6107nPku59VM8GDX3nMZJllSKOB/spUkql2e9zO/6
 YZ3pzqiP1SKMI/fX5AyXHa64h0zp8i2Sg8OfjO4oiu2Bcc3BmmK5/RtpFKd3D20xHc0S
 YVhbFPp3c1gP8VZ/Sx0FRB2xnv4RbA8/IkEGe7IYvHCnZ9Yt9bvFwWnUHiNokO3jJ2a5
 Uc2ZnRif1gMPAX9UOcPf7GLwQ7n2MWIIiMpRl30vbPhRPESVgGBEp83JKMuWtMcFh63f
 3E93WY7zV5BD2O999SV/1rN9JR3O7oVesEk0C9i4noL4KIFdsnLr8WG1T5k7TgJ0SFaP
 aTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760496984; x=1761101784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSOyUOfcRgwCLQjHz3KGvCyxbJuRpakhwxIp0fdtB+4=;
 b=F4mb0JFg8swf++eTflHNGRgRwf4c/MCLue2JXDN+FARUHwlyBh0tz0N/X1fVWxpCRd
 S/tFz82yDu8jJlTyg1xV7UbxozvwhquqqxnBVkMt/wUsOBs7uMcux0OtU6aO8EbzPequ
 0hlXKGV2eOTw4Hq+YgsGlBsM88G8RewB5lwNe1o/4FwnOumfuy6QY9t9wzpvWIQ2/ohT
 ZvHwo45aY7ZtJYWavwp7z2HtKU+7AO83PaUOR8L2K7X5S9Tt5HaKaxZbU0pfT2w4MUx5
 hssaYcELs8va34iME3xTAdR+NDCRtlbtCHYQRdTa+El58nhMq5KHHMSOX/3eS4NpexhK
 /FJg==
X-Gm-Message-State: AOJu0YxC67g9VbO6NsR2siBLO7hcikTjM6gfzy0gdlpz76nTYiCnedD0
 jnXfF41yl8QT0GvKzVVg6IJMIMKSloJMfAmyR8u3NvWVabjgH+ab00rQFxc48BIUc39v4mV7+Hp
 eOgsmyM1sIGhTUc3koqHyrArtbuHDctY=
X-Gm-Gg: ASbGnctXARtXWXmXfu3Nc5trGr9i5atsYw0EfMBgE42PnSeH5WKWXO49rkbYrL/RBWh
 iA7WYyDIa9UVvUY4Z2s+Y7MGbsjDYKmeRpCSvPYpLCxfYBxua3T+vUge186SW5E58r/bBiGwclx
 GciDpqP65jHZpvA+xAOhYDfuMxNr38CkzlOPoH5g87KiUU5jIj3dKGzxqE2hqtnxqiFK773Z6ex
 rtG3yqJ07bXoYjHEPiSmSqnwiEVtSP/3yvkFUwFQyPFwz90F9MGpxLWJxXjJXgKcKE=
X-Google-Smtp-Source: AGHT+IELUTvtMNW2SvI+R8O95u7W9p0mAJVenJ3px34A5l7JtkGxA806AIlowQx5qcEBrCDwq9xhwuJjE6bkpv0Ugn4=
X-Received: by 2002:a05:6402:278b:b0:639:e11d:6529 with SMTP id
 4fb4d7f45d1cf-639e11d6e8cmr23439796a12.5.1760496984064; Tue, 14 Oct 2025
 19:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-5-anjo@rev.ng>
 <CAKmqyKMSViOs=knzH0bi7k776FvqUX2=XtnKmGrHaeG79=qYEw@mail.gmail.com>
 <vca6pziwhxzd3pliu3jggzy4e2slsmrea5luazwmz4vav23qwn@3fzj75kzprya>
In-Reply-To: <vca6pziwhxzd3pliu3jggzy4e2slsmrea5luazwmz4vav23qwn@3fzj75kzprya>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 12:55:57 +1000
X-Gm-Features: AS18NWAwR91iTsJyMihsjC1n80Oiz3NuBsMCLnSbNBFvHCQ4X_tBHwVDqDceFxI
Message-ID: <CAKmqyKMyBMY88+6i5BdrXJtU8S9H_DcUG8O7yu5s9cE2Mv_s5g@mail.gmail.com>
Subject: Re: [PATCH v2 04/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Oct 7, 2025 at 9:06=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote:
>
> On 03/10/25, Alistair Francis wrote:
> > On Wed, Oct 1, 2025 at 5:43=E2=80=AFPM Anton Johansson via
> > <qemu-devel@nongnu.org> wrote:
> > >
> > > From my understanding the upper_half argument only indicates whether =
the
> > > upper or lower 32 bits should be returned, and upper_half will only e=
ver
> > > be set when MXLEN =3D=3D 32.  However, the function also uses upper_h=
alf to
> > > determine whether the inhibit flags are located in mcyclecfgh or
> > > mcyclecfg, but this misses the case where MXLEN =3D=3D 32, upper_half=
 =3D=3D false
> > > for TARGET_RISCV32 where we would also need to read the upper half fi=
eld.
> >
> > If MXLEN =3D=3D 32, upper_half =3D=3D false then we want to read mcycle=
cfg,
> > which the code today seems to be doing correctly.
>
> Hi again, I might be missing something then, when would this function nee=
d
> to access mcyclecfg for MXLEN =3D=3D 32?  AFAIU mcyclecfg and mcyclecfgh =
are
> modeled separately for MXLEN =3D=3D 32, even when sizeof(target_ulong) =
=3D=3D 8.
> Since this function only checks inhibit flags wouldn't we always want to
> access mcyclecfgh for MXLEN =3D=3D 32?

When MXLEN =3D=3D 32 mcyclecfg is the bottom 32-bits of the mcyclecfg CSR
and mcyclecfgh is the top 32-bits of the CSR. The idea is that
target_ulong will be 32-bits (sizeof(target_ulong) =3D=3D 4). It doesn't
really matter if target_ulong is 64-bits though, as the registers
should just be treated as 32-bit registers anyway.

Combining mcyclecfg and mcyclecfgh into one 64-bit register for MXLEN
=3D=3D 32 makes sense though. For MXLEN =3D=3D 64 there is no mcyclecfgh an=
d
mcyclecfg it always 64-bit.

Alistair

>
> //Anton

