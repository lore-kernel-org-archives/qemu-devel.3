Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187FACF6D3B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw1Zb-000692-Dz; Wed, 02 Oct 2024 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sw1ZZ-00066l-VR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:47:30 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sw1ZX-0008Hb-UH
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:47:29 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c88e4a7c53so5060579a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727884046; x=1728488846; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FndwnK+YRtybulnrKyKrT+v1DDreWsc5/HLakf2WBzc=;
 b=vhsTyyyd87SwQEbsKr6wYDjdsjHXa/HK3qsfBbpgbuarPCd9Pnsuobuf1NN7tWjAXG
 +eiKo3invJJdbPjYDh6mTH7DODpJ78+DcOW+FqZIf01q1JNrRedAM57aW+iMC216JFUM
 GF3AnCJQpQeOxmCr9OO6Gt0BrZOC/T64mw2YhfOxaTU0L8UIqOkvNWDoins9aec57iMI
 obbSyp11PnHPHDIvszYnL+VD16yjAKygr27XeCiODCeXYEYminxjljFjZH6IfkMABbK7
 ECRfj0BgJfL8tf3GtmSn6e1X7RuAbQGhemy5CVyZxkrMZ1nL2aT7WATpTyMeem2W9sCn
 FzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727884046; x=1728488846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FndwnK+YRtybulnrKyKrT+v1DDreWsc5/HLakf2WBzc=;
 b=kOTbjfUP3psCT5M9aHfpqTdRWfRahXIh3MPSjJp9ZX7gIGZ2tiV1n3Pwj11yhGkpyJ
 2gQDpI/vowrSQD8O/eS4A9x8tugCQL3Kaj8fy9CnD/XYe1Umj4WjsRKP522d/Ktxasg6
 mar37pSurMZ+gjMfbgE5lNrEeDn4q3o1BhdM61bliQYAX1L1tCziSe9OIk9lx6eMDDCS
 TKqafE5mJamB498UN7pZf+5lh09PhPWsO+qsjA9QVzYZcF0evvcokEnxzfFo2/xLNgdg
 OjgiDNsC1JyArMzkdW8JkH5esa7yI099sQ71q+mTKx2qfmPM9KSTI/ge4T0V5AFRc/Sy
 Elog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWech8ZCU3+PrJcQ4VYPQ2/nzzrJaGPuXaBENObkfiRCu829mwL8rIeCfiaRyhs+/Z3O9J5MPc5RE9n@nongnu.org
X-Gm-Message-State: AOJu0Yx2XTMkEeGrfz1W9HAeNcQyVgzfDrLR9LS3A5cblPFqQRpXWh0F
 fgxn7sNQ4HrNzfKlq9/r4hTac0xD1FuXyS0FPwzY9QhfgEsmfZBBjhbw+7NV1mZuEV6F0QwlAsj
 boXB/FaJXhFabdzjEzNZ4Fsr2S1lBbZu7Mp9XVw==
X-Google-Smtp-Source: AGHT+IHGLnW5VXHVqq8wQ+UStR34b5mymKOROemJl35HS+qAuyocWJCmOr1tTU+mZcqF43Zf1r9PBSNvlrcSr6/fP2g=
X-Received: by 2002:a05:6402:35cb:b0:5c4:2bd6:68df with SMTP id
 4fb4d7f45d1cf-5c8b18ad37dmr2947175a12.2.1727884045649; Wed, 02 Oct 2024
 08:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <Zvyx1kM4JljbzxQW@p100> <87cykimsb9.fsf@draig.linaro.org>
In-Reply-To: <87cykimsb9.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Oct 2024 16:47:14 +0100
Message-ID: <CAFEAcA81YtAGO0iFZRWXGjJb91DhWEDTGr+cjWbNWEW4yJDksQ@mail.gmail.com>
Subject: Re: {PATCH] accel/tcg: Fix CPU specific unaligned behaviour
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Helge Deller <deller@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 2 Oct 2024 at 16:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Helge Deller <deller@kernel.org> writes:
>
> > When the emulated CPU reads or writes to a memory location
> > a) for which no read/write permissions exists, *and*
> > b) the access happens unaligned (non-natural alignment),
> > then the CPU should either
> > - trigger a permission fault, or
> > - trigger an unalign access fault.
> >
> > In the current code the alignment check happens before the memory
> > permission checks, so only unalignment faults will be triggered.
> >
> > This behaviour breaks the emulation of the PARISC architecture, where t=
he CPU
> > does a memory verification first. The behaviour can be tested with the =
testcase
> > from the bugzilla report.
> >
> > Add the necessary code to allow PARISC and possibly other architectures=
 to
> > trigger a memory fault instead.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219339
> >
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 117b516739..dd1da358fb 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -1684,6 +1684,26 @@ static void mmu_watch_or_dirty(CPUState *cpu, MM=
ULookupPageData *data,
> >      data->flags =3D flags;
> >  }
> >
> > +/* when accessing unreadable memory unaligned, will the CPU issue
> > + * a alignment trap or a memory access trap ? */
> > +#ifdef TARGET_HPPA
> > +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  1
> > +#else
> > +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  0
> > +#endif
>
> I'm pretty certain we don't want to be introducing per-guest hacks into
> the core cputlb.c code when we are aiming to make it a compile once
> object.

There's also something curious going on here -- this patch
says "we check alignment before permissions, and that's wrong
on PARISC". But there's a comment in target/arm/ptw.c that
says "we check permissions before alignment, and that's
wrong on Arm":

     * Enable alignment checks on Device memory.
     *
     * Per R_XCHFJ, this check is mis-ordered. The correct ordering
     * for alignment, permission, and stage 2 faults should be:
     *    - Alignment fault caused by the memory type
     *    - Permission fault
     *    - A stage 2 fault on the memory access
     * but due to the way the TCG softmmu TLB operates, we will have
     * implicitly done the permission check and the stage2 lookup in
     * finding the TLB entry, so the alignment check cannot be done sooner.

So do we check alignment first, or permissions first, or does
the order vary depending on what we're doing?

-- PMM

