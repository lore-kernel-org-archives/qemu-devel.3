Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C02C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 13:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3FTz-0005gz-M8; Sat, 04 May 2024 09:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s3FTw-0005ge-Rz
 for qemu-devel@nongnu.org; Sat, 04 May 2024 09:31:17 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s3FTv-00014T-4Y
 for qemu-devel@nongnu.org; Sat, 04 May 2024 09:31:16 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso100792366b.1
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714829472; x=1715434272; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HoQhNgGf/tdSdmBmAhMQ5yhCin1rDoR9pq5b5k6J+/A=;
 b=ZviSv4Px0WsdDlKt4y9XAMN0pYWiib1VPcZgBJ18wHV6xZiQ5w30wNy0QPJXT3pegc
 Ki3Iida2Wgc05PPxzWxXvoXcZZX+26aUDs2pLouRdCGteu1IU4KBit1bSMJDLMJ+2OSF
 xu1NFv8OfT9qEG8LdzLY8rqFKXBC9LUfu5Z5TSxlwMSCwePlcdJv3GZCtR8quJtBzBAc
 SfDJxpMDHAnTxzxjP/JGCvcxIDYshjgt2cQP3NOeML+jeFYxQPANMjlxASt/phUJJfPC
 68QHdXQ1igVUFF1Mx4JljX+CybkOcpd5JR1o6EuP5oRti26Tf1hOdRJLBI9oacDUJMXQ
 5CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714829472; x=1715434272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoQhNgGf/tdSdmBmAhMQ5yhCin1rDoR9pq5b5k6J+/A=;
 b=Ix6DwcSaMexW3qO7gvRhSDm2vyuKzSFDIgIvb3t8VW7uHCf/XTFl+PqFOMAHDxe4lQ
 RcQo8YVzdkAwy426LkS7DC/tbPwPKc9Mhcf10GFVxtzjVKN6WvoIBCWvmKt/VkXwlEcy
 mJBKxNCUSg1Ou322unO9UB5ii2AEtUIIeCQjB6wEL8tBNJ+EjOmDgLLVIQ6AsjhnUPdQ
 k5qJ8KlUcNWKm25NpmZsQbiISzjzjBwDSPUXkI2VqxQ0rRiMaINLcbx5wBZhiSHqTdJ8
 RnFZHdBgyOghEkymxtqjdyyQForPXJt05wlUw9NvLuC5HQMDVQgH0FCmIV4olke3h6fP
 6ZNA==
X-Gm-Message-State: AOJu0Yxlq3cWAD1Ysz6OttTY7TZC+RYD1ifgjzwE/v9cEeSQBotls0Jp
 qB5hpyMhBihbO/rqcAvF1Iorez4Z06q1iJrR01liYC+gG75KnH7iO5iwC6cLjmQ/bFnRybDePpQ
 WFJ0qFoIVsRRky5h9biTyWsIwyoVycG/TWwuT1tRbzsV9KXZEJgc=
X-Google-Smtp-Source: AGHT+IGCtXUZ6UyYhOxiYscy774gUbD8m2IUVg9GYt+OUL/GeiALernuX9rt3fe6TdO0HH8b5jNO/iYUm0eJMKrUZrE=
X-Received: by 2002:a50:d5cd:0:b0:572:a167:65c6 with SMTP id
 g13-20020a50d5cd000000b00572a16765c6mr3184303edj.25.1714829471625; Sat, 04
 May 2024 06:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
 <CAFfO_h4zNuk0xuxaiGAMPcaQR5+CGuSnE7sr6OY8r-yiGow_ow@mail.gmail.com>
In-Reply-To: <CAFfO_h4zNuk0xuxaiGAMPcaQR5+CGuSnE7sr6OY8r-yiGow_ow@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 May 2024 14:31:00 +0100
Message-ID: <CAFEAcA-CGkdi2jzHLM6oKQTKwqVXVUe_F+0nrTDuoV3XFeZuzw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Fri, 3 May 2024 at 19:14, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrot=
e:
>
> On Fri, May 3, 2024 at 10:28=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > In the meantime, there is one tiny bit of this that we can
> > do now:
> >
> > > diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> > > index cc68b5d8f1..9d5dcf1a3f 100644
> > > --- a/hw/arm/npcm7xx.c
> > > +++ b/hw/arm/npcm7xx.c
> > > @@ -487,7 +487,7 @@ static void npcm7xx_realize(DeviceState *dev, Err=
or **errp)
> > >      /* CPUs */
> > >      for (i =3D 0; i < nc->num_cpus; i++) {
> > >          object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
> > > -                                arm_build_mp_affinity(i, NPCM7XX_MAX=
_NUM_CPUS),
> > > +                                arm_build_mp_affinity(ARM_CPU(&s->cp=
u[i]), i, NPCM7XX_MAX_NUM_CPUS),
> > >                                  &error_abort);
> > >          object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> > >                                  NPCM7XX_GIC_CPU_IF_ADDR, &error_abor=
t);
> >
> > In this file, the value of the mp-affinity property that the
> > board is setting is always the same as the default value it
> > would have anyway. So we can delete the call to
> > object_property_set_int() entirely, which gives us one fewer
> > place we need to deal with when we do eventually figure out
> > how the MPIDR values should work.
> >
>
> Before I send the patch removing the "object_property_set_int" line
> for "mp-affinity", just so that I understand, where else is it that
> for npcm7xx the mp_affinity is being set? I can't follow the code
> easily and I am not seeing where else it is being set to the same
> value. It's a bit hard to follow the initialization codes in QEMU.

The value that npcm7xx sets here is identical to the default value
that the Arm CPU will use if we don't set the property at all.
If the board doesn't set the property then the cpu mp_affinity field
is left at its default of ARM64_AFFINITY_INVALID, which then causes
arm_cpu_realizefn() to set it to the result of
   arm_build_mp_affinity(cs->cpu_index, ARM_DEFAULT_CPUS_PER_CLUSTER)
Although ARM_DEFAULT_CPUS_PER_CLUSTER and NPCM7XX_MAX_NUM_CPUS are
different, the number of CPUs on an npcm7xx is always exactly 2,
so we never get to a CPU number high enough for that difference
to cause the mp_affinity value to be different from the default.
(The two CPUs get an mp_affinity of 0 and 1.)

thanks
-- PMM

