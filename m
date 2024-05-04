Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0825C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 14:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3GG5-0001wM-Lm; Sat, 04 May 2024 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s3GFu-0001ob-UK
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:20:51 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s3GFs-0001oZ-QR
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:20:50 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e1d6166521so23361591fa.1
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714832447; x=1715437247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+faylab5uzDb2HMirTowOpsqyES8jFPS0qxmhWlqs0=;
 b=UIgwh65SczWI2FFTONbK5SVlXruAvxj52/GCxR/VcPcoyQeOllIC0V5u+Yjw5/bBIV
 79+oCoZMrr7nQjaumFN0u3cJK5kQxD2oQq/pSsSvap+1XglDOmD/cPMALGjIxV3E1tZH
 mnzca4DO6XTGNbtxmUf2ShJOckxvjgQXCrgu/0e/JgFvgglkUBlzgfO2yZTQPZPEI2k3
 Tcx1YVA2NdnVAGvysei/tdwmVf8IRnVg4Ay7y0CIX2CeA/HiW06axPeeKtxQ+oDbE9yc
 ulwvoaLGaJuC/3k3Mbrc6f6CBYvuumxih+YhJl+Kxwx4tuZGfj4uVvrTHNU3OW4kjiPU
 +kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714832447; x=1715437247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+faylab5uzDb2HMirTowOpsqyES8jFPS0qxmhWlqs0=;
 b=H4WLHN4OItcsgyj9fNfdO/wYvOlobgpWLr6lot7AFoh9a7nKiwSFg6VjoSOmPD3l1G
 7JdRCA/47/0bdbfGiB1eArfUOXbObaVFAtqXXwDojtvVIbOGScJnVhSo6XN9NrQH7wSC
 4PJbp73M3mHbUUQPmWaZWR6WNBdOXth7kd7Mixg8YQCt8Gtk7HhouP6vbsx/MsRnp2yo
 UcWmTBEDgUOVBnzrTOukCCSiH+rhsW135HlmC7lZPP+5wPZ+4iH3RYAwWKxa3nGKH2VV
 HpG85/9ZYfggYxx7HGdWH3tqvwxJ65dskvDfJnj1/Q6j/g4AjwlYxGVPS8Ajl+bwJJ6I
 Fm9Q==
X-Gm-Message-State: AOJu0YxtYlP0X1hBbUmEL3/gh0cbJSq6iBrgWJZ3BkkhczRX60F6vXOJ
 KAGpVhmjEbPtJfz+Ty4B+mNeiLo2YG6KSBQnWGg8OekkRnppegnGHZUbseozKRoHctz3R1A6QD2
 tzi2kifxAJtB/D8ZnSWGk6VEwn9c=
X-Google-Smtp-Source: AGHT+IHO6n73/ZMo20W75xa+1MIPEt7AQrNsaq3qrRtY2mskfZEXchYC5yfgh2nZgHICGcKadLZz7o3ddksfntLakOE=
X-Received: by 2002:a05:651c:211c:b0:2e2:f3f:9636 with SMTP id
 a28-20020a05651c211c00b002e20f3f9636mr1843173ljq.26.1714832446764; Sat, 04
 May 2024 07:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
 <CAFfO_h4zNuk0xuxaiGAMPcaQR5+CGuSnE7sr6OY8r-yiGow_ow@mail.gmail.com>
 <CAFEAcA-CGkdi2jzHLM6oKQTKwqVXVUe_F+0nrTDuoV3XFeZuzw@mail.gmail.com>
In-Reply-To: <CAFEAcA-CGkdi2jzHLM6oKQTKwqVXVUe_F+0nrTDuoV3XFeZuzw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 4 May 2024 20:20:34 +0600
Message-ID: <CAFfO_h6o3+CxwgMqkG6UQ0OVr1ZQjf9fQAf6LE6y+PCKGQ478w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x22d.google.com
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

On Sat, May 4, 2024 at 7:31=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 3 May 2024 at 19:14, Dorjoy Chowdhury <dorjoychy111@gmail.com> wr=
ote:
> >
> > On Fri, May 3, 2024 at 10:28=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > > In the meantime, there is one tiny bit of this that we can
> > > do now:
> > >
> > > > diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> > > > index cc68b5d8f1..9d5dcf1a3f 100644
> > > > --- a/hw/arm/npcm7xx.c
> > > > +++ b/hw/arm/npcm7xx.c
> > > > @@ -487,7 +487,7 @@ static void npcm7xx_realize(DeviceState *dev, E=
rror **errp)
> > > >      /* CPUs */
> > > >      for (i =3D 0; i < nc->num_cpus; i++) {
> > > >          object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
> > > > -                                arm_build_mp_affinity(i, NPCM7XX_M=
AX_NUM_CPUS),
> > > > +                                arm_build_mp_affinity(ARM_CPU(&s->=
cpu[i]), i, NPCM7XX_MAX_NUM_CPUS),
> > > >                                  &error_abort);
> > > >          object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> > > >                                  NPCM7XX_GIC_CPU_IF_ADDR, &error_ab=
ort);
> > >
> > > In this file, the value of the mp-affinity property that the
> > > board is setting is always the same as the default value it
> > > would have anyway. So we can delete the call to
> > > object_property_set_int() entirely, which gives us one fewer
> > > place we need to deal with when we do eventually figure out
> > > how the MPIDR values should work.
> > >
> >
> > Before I send the patch removing the "object_property_set_int" line
> > for "mp-affinity", just so that I understand, where else is it that
> > for npcm7xx the mp_affinity is being set? I can't follow the code
> > easily and I am not seeing where else it is being set to the same
> > value. It's a bit hard to follow the initialization codes in QEMU.
>
> The value that npcm7xx sets here is identical to the default value
> that the Arm CPU will use if we don't set the property at all.
> If the board doesn't set the property then the cpu mp_affinity field
> is left at its default of ARM64_AFFINITY_INVALID, which then causes
> arm_cpu_realizefn() to set it to the result of
>    arm_build_mp_affinity(cs->cpu_index, ARM_DEFAULT_CPUS_PER_CLUSTER)
> Although ARM_DEFAULT_CPUS_PER_CLUSTER and NPCM7XX_MAX_NUM_CPUS are
> different, the number of CPUs on an npcm7xx is always exactly 2,
> so we never get to a CPU number high enough for that difference
> to cause the mp_affinity value to be different from the default.
> (The two CPUs get an mp_affinity of 0 and 1.)
>

Understood. Thanks! I sent a patch.

Regards,
Dorjoy

