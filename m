Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BF0CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9FBg-0001qQ-AB; Thu, 16 Oct 2025 00:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9FBe-0001qH-Br
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:01:58 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9FBa-0001fD-RY
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:01:57 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63bfbbbdd0bso456718a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760587313; x=1761192113; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6pkQ5YIFwg+eyifuqyy7xVWr0mXZpDDd71g5EDNHDA=;
 b=HpS24SC2UOARoyqsJZJHovdJFVITmjOrB6V2Ebd4jDcaaC8eR4HwHOrGABnUW2KGAG
 ftl2MOC2zzh79EnW77NAU2F5kZfybvMPNa3PrfK6KC+fJgAQI6NUv7dbPzA1X2T9g5C5
 Vtl0Rucg0pZUxGx18LIVfNq1ikj6KLqHl+9jnal3fG5vHDSKB/iE9O8vPcSCnUqqMldd
 AlTpfLvL+CcrffhcGXQ9SrqSK4wKocAjzW1sxhqsbewzt6FFZ8isdjV47Xalfqa0UDfv
 1slZ9XQ/bY3etpm9kmHZlYLye9Vdc7+xArKYfA7F1zv9XoL7MT0anDhNesezFua/CKJJ
 mVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760587313; x=1761192113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6pkQ5YIFwg+eyifuqyy7xVWr0mXZpDDd71g5EDNHDA=;
 b=B0bJ1z94kneGb0iLWxSggOariYUooJdqkxSNEcBSCg3cuVIMeurWIsa9LQieiFQUqB
 0atnrVFWU4kh2q/2Jxkg547tAoYzzQ8hhlEgN75ijz1ms8P5guZK7H1p3BlSytLyPw6z
 ghLy/il66poNpDMBnrLhBfb2MxOykHd9g7X4WjRWSffkQr7YhyvqOCYDXF5kDBGLdqCa
 9fn67mncGYu+Oluew1GEhMm/PaWCpcF6IS/yR2FlUmDRagep9zhNM/ulZuGgoIVqsPn1
 UEds+s3nXWabZcaoMIMWsn8atKBYm8nNYvgnD3wJO1Q/6eQFpWfzxmcOvu+n+IpO/ntT
 AAHw==
X-Gm-Message-State: AOJu0YwjRAfs0GpB6rrrYbzDY1212cs67KHoT3PYEitINjSB6TgQRXBa
 g7HA/by8atq4LIa1D8WdTlz3bJrsgTiQ1qrkqVyp0/7Vfs82xp0Bwd6VXxpHjN3vXZYyCOr+eWe
 PrcybJdauLjf9NuKY1O4R5eCqhkOSZQRzaw==
X-Gm-Gg: ASbGncv6ZwERF+yr1LnEP0tWWHdRHPzeDok0k/G2cO1bviC7rOhs3WRpgQyrhG5aZGW
 20V58qsujg0VjmXFICa4qfsLuZ5CyyLhJw9A0vdBguBE73EniShVnB6EQXp6dOxiRXZCw7fGs2a
 NSmLtolr45brlVRUs2M8H+bFGZSOPQOB9bDwJ2clllu/KoBzoVJgIQMHMElS1LO+WopE0GHBQBT
 7iAUjvrAyCWBY2k1gY2J4SkKkGU57hzATynTzo1FydqHXTxd2IBfiyH7frm4Ok6fDlUs4OXflnc
 TLu+A6tc2NCxaVeoq4vLkp2l9g==
X-Google-Smtp-Source: AGHT+IELZjwpE4/zwf4KRecrmo3/6Yann814FtUIOySeHIAi9UFywdT63tvc0fPx9jZUU2ADB4ysx0n/FMh/8kiqvbM=
X-Received: by 2002:a05:6402:35ce:b0:637:ec31:be93 with SMTP id
 4fb4d7f45d1cf-639d5b5e449mr28741416a12.2.1760587312622; Wed, 15 Oct 2025
 21:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-5-anjo@rev.ng>
 <CAKmqyKMSViOs=knzH0bi7k776FvqUX2=XtnKmGrHaeG79=qYEw@mail.gmail.com>
 <vca6pziwhxzd3pliu3jggzy4e2slsmrea5luazwmz4vav23qwn@3fzj75kzprya>
 <CAKmqyKMyBMY88+6i5BdrXJtU8S9H_DcUG8O7yu5s9cE2Mv_s5g@mail.gmail.com>
 <7fngsrmp3rdo3hzra4rso5kwi4zejvdyl6xzc7swmmqji7wr44@vyallk4lkhe6>
In-Reply-To: <7fngsrmp3rdo3hzra4rso5kwi4zejvdyl6xzc7swmmqji7wr44@vyallk4lkhe6>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 14:01:25 +1000
X-Gm-Features: AS18NWCN3r2_sojAAfPTkHKkg9rAq7i3bA6pQBfz5ZKzA98tlJ5MyEJFdHUdrCU
Message-ID: <CAKmqyKPHVAKqOPQgD5J95TcnG=Gro5JBWTURmaqGr=ksVy5Q9g@mail.gmail.com>
Subject: Re: [PATCH v2 04/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Wed, Oct 15, 2025 at 7:55=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote=
:
>
> On 15/10/25, Alistair Francis wrote:
> > On Tue, Oct 7, 2025 at 9:06=E2=80=AFPM Anton Johansson <anjo@rev.ng> wr=
ote:
> > >
> > > On 03/10/25, Alistair Francis wrote:
> > > > On Wed, Oct 1, 2025 at 5:43=E2=80=AFPM Anton Johansson via
> > > > <qemu-devel@nongnu.org> wrote:
> > > > >
> > > > > From my understanding the upper_half argument only indicates whet=
her the
> > > > > upper or lower 32 bits should be returned, and upper_half will on=
ly ever
> > > > > be set when MXLEN =3D=3D 32.  However, the function also uses upp=
er_half to
> > > > > determine whether the inhibit flags are located in mcyclecfgh or
> > > > > mcyclecfg, but this misses the case where MXLEN =3D=3D 32, upper_=
half =3D=3D false
> > > > > for TARGET_RISCV32 where we would also need to read the upper hal=
f field.
> > > >
> > > > If MXLEN =3D=3D 32, upper_half =3D=3D false then we want to read mc=
yclecfg,
> > > > which the code today seems to be doing correctly.
> > >
> > > Hi again, I might be missing something then, when would this function=
 need
> > > to access mcyclecfg for MXLEN =3D=3D 32?  AFAIU mcyclecfg and mcyclec=
fgh are
> > > modeled separately for MXLEN =3D=3D 32, even when sizeof(target_ulong=
) =3D=3D 8.
> > > Since this function only checks inhibit flags wouldn't we always want=
 to
> > > access mcyclecfgh for MXLEN =3D=3D 32?
> >
> > When MXLEN =3D=3D 32 mcyclecfg is the bottom 32-bits of the mcyclecfg C=
SR
> > and mcyclecfgh is the top 32-bits of the CSR. The idea is that
> > target_ulong will be 32-bits (sizeof(target_ulong) =3D=3D 4). It doesn'=
t
> > really matter if target_ulong is 64-bits though, as the registers
> > should just be treated as 32-bit registers anyway.
>
> Appreciate the explanation, this makes sense to me.  But the function
> only uses cfg_val to check inhibit flags in the top 32 bits, so accessing=
 the
> lower 32 bits when upper_half =3D=3D false and MXLEN =3D=3D 32 would be i=
ncorrect
> then?

Well a guest can still access the lower 32-bits and although there is
nothing there now there might be in the future.

>
> Your comment below is what's tripping me up, since the behaviour of
> accesing the lower 32 bits for MXLEN =3D=3D 32 is not retained when
> mcyclecfgh and mcyclecfg are merged to a single 64 bit field

I don't follow what you mean here

Alistair

>
> > >      if (counter_idx =3D=3D 0) {
> > > -        cfg_val =3D upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
> > > +        cfg_val =3D rv32 ? ((uint64_t)env->mcyclecfgh << 32) :
> >
> > This doesn't look right.
> >
> > RV32 will want to access both mcyclecfgh and mcyclecfg, but this
> > change restricts access to mcyclecfg as rv32 will always be true.
> >
> > I don't think there is anything wrong with the current code.
>
> //Anton

