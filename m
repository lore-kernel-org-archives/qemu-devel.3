Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1993C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 08:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwec8-0003zp-4l; Tue, 16 Apr 2024 04:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwec2-0003zM-Gu
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:56:22 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwec0-0003ge-Lw
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:56:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e47843cc7so4057211a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713257778; x=1713862578; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFxjzbbSLCpcmQ8JxZS9zpSkww50R5VCaUK2LFEy7Rc=;
 b=FkwQLlxQT1/utU9rZQIEi0/RWzc0GIX/EB5yskchb4pIHG+EumuLA1Yb+vJY/3Ja/o
 kOpE3KLmUCKlHFfh5Y0ln/RT5ICIeB7ymGT8995pd8FEAFTJWP1yaoWNsUcwC1gS8Sny
 /knkrsEr79HZDElESuDcdr3SVwstSCFPsrKKi6o7deQ7JtxQ4S8y5MM5Mjh+ETnwWPi4
 7WodAObUfX5zrpzkEzVSv5WmLHa/glxePPIm6bEyS7VSDvwy4/X1vKWSb9o9I8a0/BhC
 zEcxTOZ8xdMaOAVvHfCzI8LnWph9SgTFKrM2BvDa7pLoWnkCfnBswenZBUBLxhh8Nrrp
 2a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713257778; x=1713862578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFxjzbbSLCpcmQ8JxZS9zpSkww50R5VCaUK2LFEy7Rc=;
 b=UVdQLTpTO5Y08mQXGSR02M1+uWYIMAw7bRHMu3ep2/9uQeFaeTSBuI/KlVFPmLPigK
 dHpO4o3qjqDxgzN/5E3qYJbovHG0ogHG39GNlK5BsAb3ZKFXpxwRSuwgP9DLhnCrM/Bw
 OYySCg0+FjvMXXYbGBd0ja6ncmjdksMKYgEnO0GvssPkclrufXVmCq2zvPp+c8Uet0zH
 gy/WnyrJPygt7zqpt0R1CPw+3MxEmIg3626PsnCKCVf07UWHLkbAdlVsKIWTTEDi2Z49
 MLpUvbx6e15Bw+ZVNT3JiOmL7lcZrgGqr5/ykgFsFzxrFw0/dK/8Pn5BoG3h88+a2IXO
 v8Jw==
X-Gm-Message-State: AOJu0YyfSPdXJ5E3oeksIhRfTy0wyvItR8lG6ufHMgEfYVRp6aV+0xg/
 DcNb9lMjKJ9uZ2qIMtdYCiuR4CBq2xwmi3OdEn+h61E/yJ2bNePsS1ISFKe3rQjCPht5oAqp+va
 vl5MfhL8uwdj7A9/kPimW8rHufXdY5V4dHm029A==
X-Google-Smtp-Source: AGHT+IFQl0oszpVsMrnckm6ZAzq1XEZVsLwZ/5vbaa6lcqP0bqTijwbc+jVKRvPMKcVn+RMMqn1SjVBbxKCws1UcX0Y=
X-Received: by 2002:a50:8d50:0:b0:570:3b4:53ff with SMTP id
 t16-20020a508d50000000b0057003b453ffmr7168522edt.6.1713257777880; Tue, 16 Apr
 2024 01:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFfO_h6LZF4T1zfTWh9qhJLcMZWxZ5VAPx-pgO66pXbWiWhNtw@mail.gmail.com>
 <CAFEAcA_PTpGqm3Zco3zydpR=tU-MOgAW3ZNExBuUDCk6gcwHTw@mail.gmail.com>
 <CAFfO_h4kbH0BdvUOTaq-g3Z+afej9XhqzS1b+kJf7O1DTi4VCA@mail.gmail.com>
In-Reply-To: <CAFfO_h4kbH0BdvUOTaq-g3Z+afej9XhqzS1b+kJf7O1DTi4VCA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 09:56:06 +0100
Message-ID: <CAFEAcA9pz-S4PeDQXgL5OBZs0Nbtk+bj=V+o4G1tx3Zp5TR91w@mail.gmail.com>
Subject: Re: Questions about "QEMU gives wrong MPIDR value for Arm CPU types
 with MT=1" (gitlab issue #1608)
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 15 Apr 2024 at 19:18, Dorjoy Chowdhury <dorjoychy111@gmail.com> wro=
te:
>
> On Mon, Apr 15, 2024 at 5:35=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > This bit of the codebase has got a bit more complicated since
> > I wrote up the bug report. I will look into this and get back
> > to you, but my suspicion is that these calls must return the
> > same value that the actual CPU MPIDR affinity values have,
> > because these values are going to end up in the DTB and ACPI
> > tables, and the OS will want them to match up with MPIDRs.

> Sounds great. Let me know. It sounds like then it could make sense to
> change the "arm_build_mp_affinity" function signature in file
> "target/arm/cpu.c" file to be like this:
>
> uint64_t arm_build_mp_affinity(bool has_smt, int idx, uint8_t clusterz)
>
> I think in all the files where it is invoked it should be possible to
> know the SMT status of the cpu using ARMCPU(qemu_get_cpu(cpu)) or
> similar. Let me know what you think.

I think in some places it is going to be annoyingly difficult,
because the virt_possible_cpu_arch_ids() function (and the equivalent
one in sbsa-ref) are called before the machine init function and
before any CPUs have been created. We know the name of the type
of the CPU we're going to use, but we can't call qemu_get_cpu() there.

On the other hand, the use in npcm7xx.c is easy: there we are
setting the mp-affinity property on the CPU, but we set it to
the exact same value it would have by default. So we can
simply delete the property-setting code line entirely. (We should
do that as a separate patch in the patchseries.)

> > The other thing we need to do is check the TRM (technical reference
> > manual) for the CPUs that were added since I filed that bug in
> > April 2023, to see if they need to have the flag set or not. The
> > ones we need to check are:
> >  * cortex-a710
> >  * neoverse-n2
> >  * neoverse-v1
> >
>
> Good point. I have now looked at the TRMs of the a710, neoverse-n2,
> neoverse-v2 and they are similar like the ones mentioned in the gitlab
> bug ticket i.e., MT bit should be 1, Aff0 should be 0, Aff1 should be
> core index, Aff2 should be cluster id.

Cool, thanks for checking that.

> Let me know what you think. If everything sounds alright, I will try
> and post a patch.

I'm still not sure the right way to handle the callsites in the
virt_possible_cpu_arch_ids() callbacks, but you can post a
patch anyway and we can iterate from there.

thanks
-- PMM

