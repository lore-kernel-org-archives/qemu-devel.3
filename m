Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8442C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1U5K-0002Dt-MV; Tue, 01 Sep 2026 15:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1U5I-0002DV-Ve
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:23:53 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1U5H-00073J-7i
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:23:52 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7dbcb505578so4365127b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 12:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788290630; cv=none;
 d=google.com; s=arc-20260327;
 b=VXe9862gT+7Fhv2GxuTRqTgT0+WXmWjGZrByFVGTmkkewQ/9UPZ/yFWxhKoTJo010R
 w9oZCP0cVsPOCXTdulg40x48GWNq0HW/6ncTk6w8HNNUfxfoaGOKQ2z8/QwcwsHz640z
 Stu20S5N0ReUQ0KhQiP3sWP307FApvgbfTc0G4LNnFCNTp7yI85b2wgbWDBDvG2+7UyH
 VTx+yn/NvVHIpBlVMrIHuB+bDkz6sE3vQHvq49lAwJXChHowBYXzLtEBL8AKwo5qS5YJ
 yqmN8k4zWUc98owpxX8S/yCRS7/yl2xcCR5VLGGg3jGqig0/XB6MDupVW2/NgX7QZWYF
 ujqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8Be4QqCPSnASyGy0gRWqctlAO7ay7RNW5FYJojhqlo4=;
 fh=ZU4W4sUSqwMMyQxfgQPHZKbbG1ijOq7Snm7OR+075E8=;
 b=H68qqAzfvtpAYM/DeqGDVAOyAqGUKeqtyma2pnrdz6Iz7/BHHtZTWHHEWt9uuO5E9m
 P3rqhQjOFVmYZxP2hyfNuNe0cDzdnnVNWCNL8Wk1Att4FXckC6H78c2CcsEcCw92hGXq
 Mnxj32s2V31kq1S4/xCufTLAkQ0S3mDhlowEAS4dwXUHgLyKaA+TNl53f0oyImJ7iQpR
 teyHlt/l26FEIFJiXcY56Tgl0MObthyMEmAkp0efObKcyWyAaN+UFBC0KuSHINzlHAzF
 oMuKC9OwnjPHtXte5dS46xzfUB76+vk3IPky0b46iCQvG5klZXpy4IdzpYbsAyhYwuNo
 oylQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788290630; x=1788895430; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Be4QqCPSnASyGy0gRWqctlAO7ay7RNW5FYJojhqlo4=;
 b=l5dzPBZB/qsVmUH0Cly3uVNm7N1gVPDP/Cm1igIKvJtvPZ9xBCNjVn0nXmoyJSTy9k
 FFkYoFHLEaNTiKdWBCy+Hdzm5ngrlg5DV3pKwfWtPwnvuxV6ngmAOd8bk+0EQwPPfrAT
 6rhgaUKHEkjXsUqHpbuGtaS/niAYLWMYUOgTmFC7sc8JNbT1DtaDBxGVL1o2Q3f1nsuO
 mJ0VLqRaLLIYdji7r4auGnPpXCMLskeEsoa4nA+QBYtUsVefQ/Hl/BtMsTIvHelR1OLc
 t3XIMfp+e1+iYSBdbw5IRNIXhyyEu+fybBKtu0zjGsy77CXI2kR2OGyDpPXrxwUCjx5r
 tdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788290630; x=1788895430;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Be4QqCPSnASyGy0gRWqctlAO7ay7RNW5FYJojhqlo4=;
 b=Tf7qbc5pTWeg8kWO5uo/rElOnZthLcdIBCsFYjcCNjUmeiaKB2KO240y6N7kZFoEV4
 49SFgzggXykhdbqYJFN30pxkzblPzbuL93txY61f8rKktypRh0vhgfunjeknPtMmNLd2
 J1LBJondG+qScwY+ymuvaorrDCbznIepO3iNrSWu+sqOjaQVh/1RLMj5cLZ5s9++aXXm
 l6VXLfXWw3gQfaJgORqGkGXq+q8UxP9Bzfar+izoZ3/Yn50jQOffF1Q8Ycln4dH9/Ta1
 Jefo6yVU8HJpfMUGb9mcgqg3VTSc9NOuV4VyijPSHdWq3fau+Vt67TQ5v9BJEEh1OQJ4
 fHoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRDGstxnURNCcWlb2waF6h9cqts/ygt5k+5SgU63SGJxQw7LXGpxQST/zwV4sT/F0lbP7PPaIH2W38@nongnu.org
X-Gm-Message-State: AFuF++mDQfxJFRRKoLyzv2fUqtFlZai4127PQVXkNX6HykJbyA/ryUm3
 +7onrC9WlvfIIcLWiGqPe48sTWHMa4Fce3BrCag6YOOmImi9V8Y5W4bu0DLt63MQDeZXUdQkx4f
 LSIuLm1zyiIIxWHhc12g9ssUTxm2KMQH7JuEPW6Q2TQ==
X-Gm-Gg: AYBFou2n5/0nnYx259lt7tw4ul5bo0eHDYxQBDrYpTKYK2gCkHjb6AOOEJuLJmgOg6N
 JoGJ6BtEAq31KqS5q1ryH15Qm6409HsI5FVDKzkbaxzqqZi9hXbK5DXpbz8GnsCKvh6l3HIduzA
 R+/IHa2xhWZRk9OQJzmzq3gpMzC+H5Q+ZGgRopsEHfUAHE1q7+4jQ+zcKDaTzKc29p3daO6G3UG
 26BfW1f17Sq0O9Kwr7UdSlgPc9Gzttcv0fULPacMFvHYK+WQdMBXlDW0qgx6zSD+X3r9y+ETSv8
 D9J4A5ATR2d0WF1iP/kcovHDQXKSTTnZPN6+qwSEV5PYpVRU8CDds5AxM/jD322MbBermUaspiW
 3DHfUDIzKUsMUrbqElpxy5luoXHiU917TeVAWYxQ=
X-Received: by 2002:a05:690c:c6c8:b0:80c:cad:c4e5 with SMTP id
 00721157ae682-85d6f5d0cd6mr120608047b3.30.1788290629616; Tue, 01 Sep 2026
 12:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-2-gilles.grimaud@univ-lille.fr>
 <87wlt4uads.fsf@draig.linaro.org>
In-Reply-To: <87wlt4uads.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 20:23:37 +0100
X-Gm-Features: AcwNN1U9R__ATvkpocT-3Givgbo7BaRAXUlvEl2Kgem8FljKIGMd7nSA6PCN-7M
Message-ID: <CAFEAcA-cg=GWwPUNB7LNXZiBhi_V--Znt9KziqahKEHRS_kvEw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/30] target/arm: support Cortex-M0+ MPU
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Gilles Grimaud <gilles.grimaud@univ-lille.fr>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 1 Sept 2026 at 18:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:
>
> > From: gilles grimaud <gilles.grimaud@univ-lille.fr>
> >
> > Cortex-M0+ implementations may provide an Armv6 PMSA MPU with eight reg=
ions. QEMU already marks M-profile CPUs as PMSA, but only exposes and alloc=
ates the existing region model for Armv7 CPUs. This prevents a Cortex-M0+ b=
oard from enabling its optional MPU.
> >
>
> Just a comment for all patches, you should ensure your editor wraps at
> 80 columns (72 for title) as patches are often read on terminals.
>
> It's good habit to run through checkpatch.pl to pick up the minor
> oft-forgotten stuff.
>
> > Use QEMU's PMSAv7 state and translation path for the compatible
> > Armv6-M MPU register layout. Permit CONTROL.nPRIV changes when the
> > optional MPU is present and clear the region state on reset.
>
> Hmm will need to think about this - the file is explicitly targeting the
> armv7_nvic so we might want to consider renaming if indeed special
> casing the differences is the right thing to do.

All the M-profile code is shot through with "v7m" naming for historical
reasons. It is all intended to cover v6M, v7M and v8M.

v6M is awkward because its naming is more marketing driven than
related to the progression of A-profile versions. Really v6M is
more like "v7M without the Main Extension" -- it's a cut-down
v7M, not a predecessor to it. v8M tidies up the naming here
by making "is cut-down" orthogonal to the architectural version
number.

It is tempting to wonder if we should model v6M CPUs by having
them actually set ARM_FEATURE_M + ARM_FEATURE_V7 but not
ARM_FEATURE_M_MAIN. But that could quite easily have just as
many annoying corner cases only the other way around...

> > Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> > ---
> >  hw/intc/armv7m_nvic.c     |  3 +++
> >  target/arm/cpu.c          | 12 +++++++++---
> >  target/arm/ptw.c          |  3 ++-
> >  target/arm/tcg/m_helper.c | 10 +++++++++-
> >  4 files changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> > index a7651f831e..3140599ac1 100644
> > --- a/hw/intc/armv7m_nvic.c
> > +++ b/hw/intc/armv7m_nvic.c
> > @@ -1626,6 +1626,9 @@ static void nvic_writel(NVICState *s, uint32_t of=
fset, uint32_t value,
> >          break;
> >      case 0xd08: /* Vector Table Offset.  */
> >          cpu->env.v7m.vecbase[attrs.secure] =3D value & 0xffffff80;
> > +        if (!arm_feature(&cpu->env, ARM_FEATURE_M_SECURITY)) {
> > +            cpu->env.v7m.vecbase[!attrs.secure] =3D value & 0xffffff80=
;
> > +        }

This looks dubious and also unrelated to what the commit message
says the change is doing. The VTOR exists whether the CPU has
the Security extension or not.

> > diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> > index f4ba93b291..667b2a3cbd 100644
> > --- a/target/arm/tcg/m_helper.c
> > +++ b/target/arm/tcg/m_helper.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/bitops.h"
> >  #include "qemu/log.h"
> >  #include "exec/page-protection.h"
> > +#include "exec/cputlb.h"
> >  #ifdef CONFIG_TCG
> >  #include "accel/tcg/cpu-ldst-common.h"
> >  #include "semihosting/common-semi.h"
> > @@ -2775,9 +2776,16 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t =
maskreg, uint32_t val)
> >                             !arm_v7m_is_handler_mode(env))) {
> >              write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MA=
SK) !=3D 0);
> >          }
> > -        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
> > +        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_M_MAIN) ||
> > +                           env_archcpu(env)->has_mpu)) {

Why are we testing against has_mpu here ?

> > +            uint32_t old_control =3D env->v7m.control[env->v7m.secure]=
;
> > +
> >              env->v7m.control[env->v7m.secure] &=3D ~R_V7M_CONTROL_NPRI=
V_MASK;
> >              env->v7m.control[env->v7m.secure] |=3D val & R_V7M_CONTROL=
_NPRIV_MASK;
> > +            if ((old_control ^ env->v7m.control[env->v7m.secure]) &
> > +                R_V7M_CONTROL_NPRIV_MASK) {
> > +                tlb_flush(env_cpu(env));

Where has this tlb_flush() appeared from, and why?

> > +            }
> >          }
> >          if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
> >              /*

-- PMM

