Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00A3C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 10:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6pF3-0005Ce-H2; Tue, 14 May 2024 06:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6pF1-0005Bb-2u; Tue, 14 May 2024 06:18:39 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6pEz-0004bW-KP; Tue, 14 May 2024 06:18:38 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-47f0a45375aso1387425137.1; 
 Tue, 14 May 2024 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715681916; x=1716286716; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfBxzd6n34jFahXpLZ/5c2Tc/xp13VYkDa1DK+MLurM=;
 b=nPS2ethadwT6J+W8t0hMvoCzkB9v5e3lpong9vgivNd8a83DwBL8VaY9sSurL06o43
 G8KMOkH33sxE1e1zlS+OaLITAK6+b2x/Q+Stt5Mk0zrhyIb7+Tqx5SUaG8i8C32KKeA7
 IsB7/cYtyiNeHUc0hICmypdv+xpqLpK/e+sGvfWPZfU9FGKEbV2uNjzwDIQ/hG7+/xPl
 iyVbOSfa697v11U9IOPNVkOXYIFDxsbpUZ8kWBusi4DMcYNm0YUoEqceVwyt9Z0hvREo
 k+a7x6aSloppA2jdlA6BjSNFvFC4zegAqYEW+qpA1htxZxPDhudfXmYVZ+8obteqUmwb
 X9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715681916; x=1716286716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfBxzd6n34jFahXpLZ/5c2Tc/xp13VYkDa1DK+MLurM=;
 b=TSLknZSUDmrdCtPjQBZHLbGomUmSe9Z+NC+ds3VANHBmme2z9eK1C4DC3hYNw7MW8m
 7iwiBF3nqrz+AQ7lZ5GZMQlV6XASJz4WrXZNIx/oxv7xtq8OZYQMY9MllUME9eGI27W4
 6treamx7SGR1sgT1ySjmLKhxqn0PC7jGjtJxRivG+MqxsmzEFDPbShV5Qohyb1UUTR4c
 YnASTnexLdJqcyKKBdF8wNmIDRh4IVvjvcrnvEbiE1kLSj1nc+I14kXtPggkvZRUOkzc
 4LNHEx/qh42k8AkIKMbNqieNA6E5fLqrbg5QEPZPthaiVzysw3FIipZySIVizVEYttVg
 4cUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEA1UGmCxSq4eFITCYPe59oIg/nddCbmFxck+/LId17fP8JjDKaTN+tJ/AY3LnvzBIU6ntoWQnJlxT4lSZ8fcWjo6wCM4=
X-Gm-Message-State: AOJu0Yx9NdPlHX/7pr0qGXqIVNd7qqiFCUaNLiFgYR5anjeVFek0SwPv
 L0ERQdVLBeoH7BgdeqDI5orlSyhyhNsWAOeg9TvlVKKYTV3xo2tBFIQ3w3LlGPlPGqmXeuaF04Z
 qVFpIMUhI6MTxJSLqS+221Xy72AE=
X-Google-Smtp-Source: AGHT+IG+YGP0J00iLGdfgfIcGND+YqvN0valNNyjrabOgIcEC8Hk4INB7n+cMqUYsB28SBwBlaeFyb6YZtdOBu6F808=
X-Received: by 2002:a05:6102:38c7:b0:47c:33fc:4619 with SMTP id
 ada2fe7eead31-48077de578dmr10376041137.9.1715681916234; Tue, 14 May 2024
 03:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <CAKmqyKN9W+xY-gBZD=6T-iOzrX0MAMcTE4Zd74hmgTtP8hnObQ@mail.gmail.com>
 <CAHBxVyED-ji_pr=XfeDjxUht=9qvcizK3RniijpzX6xC26oshg@mail.gmail.com>
In-Reply-To: <CAHBxVyED-ji_pr=XfeDjxUht=9qvcizK3RniijpzX6xC26oshg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 20:18:09 +1000
Message-ID: <CAKmqyKMWgMGSsbgMctFaUnPDgDitJdK31xcg4h+HohiD4_Me6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Assorted fixes for PMU
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Tue, May 14, 2024 at 5:15=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>
> On Mon, May 13, 2024 at 11:29=E2=80=AFPM Alistair Francis <alistair23@gma=
il.com> wrote:
> >
> > On Tue, Apr 30, 2024 at 5:29=E2=80=AFAM Atish Patra <atishp@rivosinc.co=
m> wrote:
> > >
> > > This series contains few miscallenous fixes related to hpmcounters
> > > and related code. The first patch fixes an issue with cycle/instret
> > > counters overcouting while the remaining two are more for specificati=
on
> > > compliance.
> > >
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > > Atish Patra (3):
> > >       target/riscv: Save counter values during countinhibit update
> > >       target/riscv: Enforce WARL behavior for scounteren/hcounteren
> > >       target/riscv: Fix the predicate functions for mhpmeventhX CSRs
> >
> > Thanks!
> >
> > Applied to riscv-to-apply.next
> >
>
> Hi Alistair,
> Thanks for your review. But the patch 1 had some comments about
> vmstate which needs updating.

Ah, I did read the comments but forgot that you were going to bump the vers=
ion.

> We also found a few more fixes that I was planning to include in v2.

I found that patch `target/riscv: Save counter values during
countinhibit update` gives me this error as well

../target/riscv/csr.c: In function =E2=80=98write_mcountinhibit=E2=80=99:
../target/riscv/csr.c:1981:44: error: too few arguments to function =E2=80=
=98get_ticks=E2=80=99
1981 |                 counter->mhpmcounter_val =3D get_ticks(false) -
     |                                            ^~~~~~~~~
../target/riscv/csr.c:765:21: note: declared here
 765 | static target_ulong get_ticks(bool shift, bool instructions)
     |                     ^~~~~~~~~
../target/riscv/csr.c:1985:49: error: too few arguments to function =E2=80=
=98get_ticks=E2=80=99
1985 |                     counter->mhpmcounterh_val =3D get_ticks(false) -
     |                                                 ^~~~~~~~~
../target/riscv/csr.c:765:21: note: declared here
 765 | static target_ulong get_ticks(bool shift, bool instructions)
     |                     ^~~~~~~~~



>
> I can send a separate fixes series on top riscv-to-apply.next or this
> series can be dropped for the time being.

I'm going to drop it due to the build error above

Alistair

> You can queue it v2 later. Let me know what you prefer.
>
>
> > Alistair
> >
> > >
> > >  target/riscv/cpu.h     |   1 -
> > >  target/riscv/csr.c     | 111 ++++++++++++++++++++++++++++++---------=
----------
> > >  target/riscv/machine.c |   1 -
> > >  3 files changed, 68 insertions(+), 45 deletions(-)
> > > ---
> > > base-commit: 1642f979a71a5667a05070be2df82f48bd43ad7a
> > > change-id: 20240428-countinhibit_fix-c6a1c11f4375
> > > --
> > > Regards,
> > > Atish patra
> > >
> > >

