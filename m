Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xQa-0000bs-1b; Fri, 03 May 2024 14:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s2xQY-0000bf-OL
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:14:34 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s2xQX-0000Dw-0O
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:14:34 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e1a02af4a5so32769621fa.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714760068; x=1715364868; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xon4V7rp1dypwHvRGzVtbQvsR3BY2qFiUJlJfXNCv1s=;
 b=afq5UTMg4FRkD9TOpAX2LNKTMI5JH7BBmzjSgbSHq6C0wMIQ3YCRL4fRs4ZDQDABXY
 rlnWb6xuwN4jMQBKw1sQiHAUZPTZ3s3nrj4nz2Tty467kwScOjglkHnSsbwPvCavGMYT
 gKqOmnTihlJTGg5IVfLzU6CgkpP/zzUwUdT/L+WkePg+L0V0yfVRFXVrUCTRB/C0Cbrz
 J0Dpmw63kh5ES4d7oLzjeT1Pdtzq7Jm0vCG8+PrI3F2PW8V6dcEJm/RZ1VzJ1jEwRb5H
 ldjP8hT6FWgoRyvC5ByzB4UXpghLvZsXQpCerL/igZw+RWRO7OrMhvGY//sq7NvTDlbx
 UF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714760068; x=1715364868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xon4V7rp1dypwHvRGzVtbQvsR3BY2qFiUJlJfXNCv1s=;
 b=iLs9mH6nlCqyDHVQf71UGjp5LTfMuYmVjX6Lc9JBOrH10CZT2YGq+5T7NxetmyxXXg
 BCb8S5n5yfocDapNmZd6RXlc60DLtLowNL5Rg7kqiuFPZFZcElC/iaasxXQx1kkxHuHF
 K6eBYdKKz1GA839+6jScTR4olTpVaI/+8xB4qY6hkNZxnE0fcqNo83upUIYUs7XjfRDb
 tl5XQy7WmWRRuYMkyKn+L+k7zBJqTHKtPUT2oYtm+Qct2nZ1R5BPT/o5dGxVdpTff9TP
 9baGMNCN96YZY6g2RbrBf2QGwIczYgBuOT89g1oIirRO7P6yHF7vDlsoImewMiSYov6m
 cftA==
X-Gm-Message-State: AOJu0YyI8XMWf/XZ7HGXy+PNlQnzNWiH+8GFpMH8TGEbFzosSQgH2ilN
 z+Dr67Ja0hyV8IbdJrz/9ao/m/GImhVn6snI9zF+TzsZhKphCoQUgkVLOvYUEAlC219JUo4x2vk
 k3Pa/uElGtYiGxRDAv32ZHSJQn6SB3w==
X-Google-Smtp-Source: AGHT+IFbmhS2mui+e3SINiNoO1SEcxHNOtgJjozDR2riRh+BSNgK29vy7Zpdm2zGknYUQ9quTTYN93e9Xn+jHtYfQvw=
X-Received: by 2002:a05:651c:1038:b0:2d8:3e60:b9c9 with SMTP id
 w24-20020a05651c103800b002d83e60b9c9mr1890032ljm.33.1714760067619; Fri, 03
 May 2024 11:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 4 May 2024 00:14:14 +0600
Message-ID: <CAFfO_h4zNuk0xuxaiGAMPcaQR5+CGuSnE7sr6OY8r-yiGow_ow@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x235.google.com
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

Before I send the patch removing the "object_property_set_int" line
for "mp-affinity", just so that I understand, where else is it that
for npcm7xx the mp_affinity is being set? I can't follow the code
easily and I am not seeing where else it is being set to the same
value. It's a bit hard to follow the initialization codes in QEMU.

Regards,
Dorjoy

