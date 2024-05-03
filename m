Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80C1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 16:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2w9p-0004OQ-8f; Fri, 03 May 2024 12:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s2w9n-0004O9-JG
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:53:11 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s2w9l-0001Bu-Tm
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:53:11 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2df83058d48so85386941fa.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714755187; x=1715359987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4K2NK95hJk3SMYf+83MeWc3awsgLGmBJJ3K5eqJ6nU=;
 b=Ia8KsyzFVn0+eM376qRtQQ74TN+gunfkdJwgVitRSnkSx9IRKAsOinhMjTLWKFHXpo
 VcU2+Qj73O3IR6+A6nxRe+YuRvu2ltprXL8m6GAjU+Gq73bXWq7Pcv6xMjlVX2g6GFJi
 BlBqL9z2EmVeeaNq9IhoyrHCvNvxcjgqXQtuo6EbccIH3MPOs8/yY6cG/d/zESwKSLgR
 ME85SNEs0fdw4H2uYdUnYeeeEu1NfZntFCNbvh/bFue1mo9GRpaR4m/4CP/tZmJhQ6G5
 nUh0xCNSLQHt2N3pR6tGe/lJWWxrDn7Z26wP1zDUB8FZMlCdPSyVln1Tdt5g72O2/mON
 2IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714755187; x=1715359987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4K2NK95hJk3SMYf+83MeWc3awsgLGmBJJ3K5eqJ6nU=;
 b=FP/dQKE4Pe6pUgjhvMz7MIwFJ5TqR0C20pNgW0cOtwZAfQp4bEWpQubL2fnH34j0OT
 LFX7TBBiipdVB6HwEQ+A5Uq3LXdKb7hnHd11OR+Q1Iygi2TJuLjQDCqQuk78QEg2iag+
 seAyLq/qJDky/YOP4Jr4/Wd9PAvCtHCGq1rlPdyG9DQPdL1yiroD1ZoxMTswfS/Ejmzn
 nHXS/lX8CcjEmLaWfZqa+mus5yn7IXUkzCh5QZXYvXczpS+s94AY5abnS7MsghI5tB8O
 Yg5/5yI+I51mJnjaYleqa7jLYrjhV99+gpuRvoGspGUiuWecd2/Njgafe6IDg6+UY9Yi
 0d1Q==
X-Gm-Message-State: AOJu0YwJHemYP02n37I7pV3BEgO2Vw5hFPY27TL0knxUQ7tpR3rIwGqv
 0YroFiap5MTES/m2Xub2gVFv4ei9/i6Pgb8k8PEsVANbTRGtqmbg0GK2c5dM54vrv1uywhVinEI
 Pkkio8P0DyBnkUWyIb7BfrHQ7gqo=
X-Google-Smtp-Source: AGHT+IFuLi+WF2HT71uQHt/WxY/PXcYgZ9wFJwJcouJEyTxBJrvszB2i56oLjsLo3pHLKhUUkoFPn9mqYPG/Y3An2aA=
X-Received: by 2002:a2e:a23a:0:b0:2e1:d34d:9b2c with SMTP id
 i26-20020a2ea23a000000b002e1d34d9b2cmr1928152ljm.9.1714755186860; Fri, 03 May
 2024 09:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 3 May 2024 22:52:55 +0600
Message-ID: <CAFfO_h57h7MX0Drw_jjym-kq8q9jFwTx7J7nYX7cxW_XY+pOsA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x22e.google.com
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

On Fri, May 3, 2024 at 10:28=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 19 Apr 2024 at 19:31, Dorjoy Chowdhury <dorjoychy111@gmail.com> w=
rote:
> >
> > Some ARM CPUs advertise themselves as SMT by having the MT[24] bit set
> > to 1 in the MPIDR register. These CPUs have the thread id in Aff0[7:0]
> > bits, CPU id in Aff1[15:8] bits and cluster id in Aff2[23:16] bits in
> > MPIDR.
> >
> > On the other hand, ARM CPUs without SMT have the MT[24] bit set to 0,
> > CPU id in Aff0[7:0] bits and cluster id in Aff1[15:8] bits in MPIDR.
> >
> > The mpidr_read_val() function always reported non-SMT i.e., MT=3D0 styl=
e
> > MPIDR value which means it was wrong for the following CPUs with SMT
> > supported by QEMU:
> >     - cortex-a55
> >     - cortex-a76
> >     - cortex-a710
> >     - neoverse-v1
> >     - neoverse-n1
> >     - neoverse-n2
>
> This has definitely turned out to be rather more complicated
> than I thought it would be when I wrote up the original issue
> in gitlab, so sorry about that.
>
> I still need to think through how we should deal with the
> interaction between what the CPU type implies about the MPIDR
> format and the topology information provided by the user.
> I probably won't get to that next week, because I'm on holiday
> for most of it, but I will see if I can at least make a start.
>

No problem at all. Just let me know when you get to it. I will see if
I can fix it or ask if I need help then. Please enjoy your holidays.
Thanks!

> In the meantime, there is one tiny bit of this that we can
> do now:
>
> > diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> > index cc68b5d8f1..9d5dcf1a3f 100644
> > --- a/hw/arm/npcm7xx.c
> > +++ b/hw/arm/npcm7xx.c
> > @@ -487,7 +487,7 @@ static void npcm7xx_realize(DeviceState *dev, Error=
 **errp)
> >      /* CPUs */
> >      for (i =3D 0; i < nc->num_cpus; i++) {
> >          object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
> > -                                arm_build_mp_affinity(i, NPCM7XX_MAX_N=
UM_CPUS),
> > +                                arm_build_mp_affinity(ARM_CPU(&s->cpu[=
i]), i, NPCM7XX_MAX_NUM_CPUS),
> >                                  &error_abort);
> >          object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> >                                  NPCM7XX_GIC_CPU_IF_ADDR, &error_abort)=
;
>
> In this file, the value of the mp-affinity property that the
> board is setting is always the same as the default value it
> would have anyway. So we can delete the call to
> object_property_set_int() entirely, which gives us one fewer
> place we need to deal with when we do eventually figure out
> how the MPIDR values should work.
>
> If you like you can submit a separate patch which deletes
> this one call.
>

Makes sense. I will try and send a patch.

Regards,
Dorjoy

