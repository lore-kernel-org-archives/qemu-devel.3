Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E067CCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 01:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBkXK-000892-6c; Wed, 22 Oct 2025 21:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBkXI-00088t-It
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 21:54:40 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBkXG-0000NW-BO
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 21:54:40 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so73171566b.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761184476; x=1761789276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTU1GdVDQEoxIEWW2DcDN15sBXCJE59RoqYxUU1Z8pY=;
 b=gntCzMyHUEzokhIEvi2nROW/PBEp8lb7fuq8O1HO8ffgjQVGEESx2ietsRh7wfnBVD
 wG4dA6/4YKqe43rs/HR8+BRje3TXsIqqudgxeZ/tR7zEcq3tG6BhNKUf7iz0oTvgrQG8
 Mh+XQatWkv69cwdlCyIbSaQsAc/secc1X7j4Sy5qPzNBIvHhK7QSSt4LR1Yogim4X/o1
 kBZ4I5S3bDb8lhH4iV8sMYmBCR1kZAUwvxYTPH/ofrHanIwUhhzcqSZereOYnPTxyhcR
 EM1f8QpmjH49SQkufWgr0ls5DFVp4EHKoNah/cBWLrW2JXJ4Dg7iUTRtZqXzVWQvr1FP
 IqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761184476; x=1761789276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTU1GdVDQEoxIEWW2DcDN15sBXCJE59RoqYxUU1Z8pY=;
 b=hkIsDsQq9KbauTIzIfW6g+RAq3eD2O81tTqZx0nylqAmZV17qURwGWPLD6p8vkvFnT
 REygSFdsakTzp+RExkXmz3y7RlqI3BnvEKQBDQchf/D4p4Jm1mq319PM9bpyYrxTJP3u
 r/+xnBfC1WeeBDr2RLEpAw8we9jLD7emthcIdzzByph+DjvuHRS4qpK2g6VCaX+fi5d4
 VkcbZtWknJZT2nwzcBzis9RNHv7AplLInhWdoAqy7x2Bbiq6HNgybGalukPLG3SMTwku
 PQFSnWtuH2aOGRTC9iHWRbTIU8i7n68xCCcg9jfqwn/xKNiLCZfw5SiACO0KXxGvEvbf
 AjHA==
X-Gm-Message-State: AOJu0Yz09XWXLXbyCxQkMUSP3Sb0q+5Iom+LLFf8cdegtcXEZd8n4YM0
 zA7gPQgVlEBiLCpZRNebQ4Jlq/Q9yG9RwmWtQZ3Zb9x/aAFIyZEqOWYSmauA9G2CzxIjv5cyo4c
 oRkpKosstuXdMf0dLcxyyX/YWPjXYRQQ=
X-Gm-Gg: ASbGnculUk56MjK5xWC+yiQeSiEucpMFU7+fadzR16fQx3kqdAciqQTlxypBW2O3RGN
 GWDFgzuLQ+UKzyPPnHQU1LiSPFIrMtqAEhBtOywE0jkT+cYyOaEX8VGpZzoF4mMFa17dkwhqUqW
 YHEEKHgUUjGv4pN9yFMZcTIcDHSS1nCSpfQ7SrP914vhANn09eNJsjmzTk0PnuzgOD+s5P83NSb
 jWkKBfb2qXQULzjlNjaT1i1wqvR80vHFz7Ubq3RUK6todoy11jTr3o0OEGODwfGSneNaGWQXckU
 aadYossqjRQDu6vz4isrDarjUA==
X-Google-Smtp-Source: AGHT+IHGvdR6ZGFy0GlDJfV5Wk9clwu29V+2IdVqfhA6NuOBEdl1a70o9nLFKg4rqroCuN8P9tkCuFtZgDON4QKdFxw=
X-Received: by 2002:a17:906:7308:b0:b04:5e64:d7cd with SMTP id
 a640c23a62f3a-b647423d570mr2972540166b.46.1761184475552; Wed, 22 Oct 2025
 18:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-5-anjo@rev.ng>
 <CAKmqyKMSViOs=knzH0bi7k776FvqUX2=XtnKmGrHaeG79=qYEw@mail.gmail.com>
 <vca6pziwhxzd3pliu3jggzy4e2slsmrea5luazwmz4vav23qwn@3fzj75kzprya>
 <CAKmqyKMyBMY88+6i5BdrXJtU8S9H_DcUG8O7yu5s9cE2Mv_s5g@mail.gmail.com>
 <7fngsrmp3rdo3hzra4rso5kwi4zejvdyl6xzc7swmmqji7wr44@vyallk4lkhe6>
 <CAKmqyKPHVAKqOPQgD5J95TcnG=Gro5JBWTURmaqGr=ksVy5Q9g@mail.gmail.com>
 <dj72zr4f7ais3vdgvthvpdfpbnjblbbqdfjg7yhqzthpo67x4p@5wdd4ii7yhda>
In-Reply-To: <dj72zr4f7ais3vdgvthvpdfpbnjblbbqdfjg7yhqzthpo67x4p@5wdd4ii7yhda>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 11:54:09 +1000
X-Gm-Features: AS18NWAs-NYaQg-jEmUNbffYMaGVH_sVNP0cbTdYm2HIpGLOyqHqFkfHBzjKIlo
Message-ID: <CAKmqyKN5WcqDjmPQ0ewbSMvj=Z8OwgNKjKtg9uNgPJRNNe2zTA@mail.gmail.com>
Subject: Re: [PATCH v2 04/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Sat, Oct 18, 2025 at 12:22=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrot=
e:
>
> On 16/10/25, Alistair Francis wrote:
> > On Wed, Oct 15, 2025 at 7:55=E2=80=AFPM Anton Johansson <anjo@rev.ng> w=
rote:
> > >
> > > On 15/10/25, Alistair Francis wrote:
> > > > On Tue, Oct 7, 2025 at 9:06=E2=80=AFPM Anton Johansson <anjo@rev.ng=
> wrote:
> > > > >
> > > > > On 03/10/25, Alistair Francis wrote:
> > > > > > On Wed, Oct 1, 2025 at 5:43=E2=80=AFPM Anton Johansson via
> > > > > > <qemu-devel@nongnu.org> wrote:
> > > > > > >
> > > > > > > From my understanding the upper_half argument only indicates =
whether the
> > > > > > > upper or lower 32 bits should be returned, and upper_half wil=
l only ever
> > > > > > > be set when MXLEN =3D=3D 32.  However, the function also uses=
 upper_half to
> > > > > > > determine whether the inhibit flags are located in mcyclecfgh=
 or
> > > > > > > mcyclecfg, but this misses the case where MXLEN =3D=3D 32, up=
per_half =3D=3D false
> > > > > > > for TARGET_RISCV32 where we would also need to read the upper=
 half field.
> > > > > >
> > > > > > If MXLEN =3D=3D 32, upper_half =3D=3D false then we want to rea=
d mcyclecfg,
> > > > > > which the code today seems to be doing correctly.
> > > > >
> > > > > Hi again, I might be missing something then, when would this func=
tion need
> > > > > to access mcyclecfg for MXLEN =3D=3D 32?  AFAIU mcyclecfg and mcy=
clecfgh are
> > > > > modeled separately for MXLEN =3D=3D 32, even when sizeof(target_u=
long) =3D=3D 8.
> > > > > Since this function only checks inhibit flags wouldn't we always =
want to
> > > > > access mcyclecfgh for MXLEN =3D=3D 32?
> > > >
> > > > When MXLEN =3D=3D 32 mcyclecfg is the bottom 32-bits of the mcyclec=
fg CSR
> > > > and mcyclecfgh is the top 32-bits of the CSR. The idea is that
> > > > target_ulong will be 32-bits (sizeof(target_ulong) =3D=3D 4). It do=
esn't
> > > > really matter if target_ulong is 64-bits though, as the registers
> > > > should just be treated as 32-bit registers anyway.
> > >
> > > Appreciate the explanation, this makes sense to me.  But the function
> > > only uses cfg_val to check inhibit flags in the top 32 bits, so acces=
sing the
> > > lower 32 bits when upper_half =3D=3D false and MXLEN =3D=3D 32 would =
be incorrect
> > > then?
> >
> > Well a guest can still access the lower 32-bits and although there is
> > nothing there now there might be in the future.
> >
> > >
> > > Your comment below is what's tripping me up, since the behaviour of
> > > accesing the lower 32 bits for MXLEN =3D=3D 32 is not retained when
> > > mcyclecfgh and mcyclecfg are merged to a single 64 bit field
> >
> > I don't follow what you mean here
>
> On upstream when riscv_pmu_ctr_get_fixed_counters_val() is called with
> MXLEN =3D=3D 32 and upper_half =3D=3D false, we read the inhibit flags fr=
om the
> lower 32 bits (mcyclecfg) and check against bit 62 (MINH) etc. thus
> always returning false

That's correct.

If MXLEN =3D=3D 32 and the guest accesses mcyclecfg (lower 32-bits) then
we expect riscv_pmu_ctr_get_fixed_counters_val() to return 0.

I agree it's clunky, we should combine the two halves into a single
64-bit value for both 32-bit and 64-bit. But the current approach of
separate registers although confusing, doesn't look wrong.

>
>   if (counter_idx =3D=3D 0) {
>       cfg_val =3D upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
>                              env->mcyclecfg;
>   }
>   [...]
>   if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
>       curr_val +=3D counter_arr[PRV_M];
>   }
>
> if this behaviour is intended, we do not retain it with this patch as
> we always access the higher cfg bits to check for MINH.  Similarly when
> merging mcyclecfgh and mcyclecfg

Once merged it's fine to always check the higher bits

Alistair

>
>   if (counter_idx =3D=3D 0) {
>       cfg_val =3D env->mcyclecfg;
>   }
>   [...]
>   if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
>       curr_val +=3D counter_arr[PRV_M];
>   }
>
> we only check for MINH in the higher bits.
>
> //Anton

