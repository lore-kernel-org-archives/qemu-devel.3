Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9ECCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 23:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4T6r-0005Xl-Ax; Thu, 02 Oct 2025 19:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4T6o-0005XL-4W
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 19:53:14 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4T6c-0003hn-UK
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 19:53:12 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3d5088259eso247138366b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759449165; x=1760053965; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLwl1+5r7hemjRkOSMKIIrNr6UFfPtWF75bt5S1ujmk=;
 b=hR9aKHhQ9T0cgmfmEeiY2y15Y02vpTP4qNkVfs+XBaMjFYUJT/ePtwlGvy/JHn0CPq
 7zvC3U0F1wZnWiB4FZn3Z2zz45Ag6K5RtVh75gn6HEuEtUkaIy7+6M5+po32WH4+Ssvs
 r2FreK2Ruh7JtrhN424YFqDNPbwqYnA+YkvfGeytwWO01QJASH1r+fAOWnOB4lGle2ls
 r/nsGdFX7wogqkcByFrlo0rKGbR/upDTOUrrK5rOw65ku5CTGyZwMIJyU3Dud9KO/AQ9
 yJcEXnYLklCmINe7Apk0pDfPIaW2/b/zAf0t/8jzdP9uZAxX45TZn4CzUvOl+U8kerBF
 ALVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759449165; x=1760053965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLwl1+5r7hemjRkOSMKIIrNr6UFfPtWF75bt5S1ujmk=;
 b=EVsbDcX54ErUzN9D5YqYevem1qm9rcqT5M1/Al0cMVC8DQ0GKkyAfUE4XYU4iWq/j+
 hWibAhfJPqEyQKoSfELc+tEaoWRKSbAgG6qo+RZi//+sco60sJJrB4mDUx5epk23J3KR
 rkl0yR9qA0mbSWJKpFjaDeuD/gt1JnSfRfZw65yVEbXucnjdZwuqtFIs5HhFJH8xszyc
 hGlzNo71p/d02YEOUNQTMEG3kWUBquQ6GhuftC5CGgp27BizZKeCio0FnrZUOUxlwuPl
 h8u5KO1s0+lRCmFj1Oq6OEREUMwQS3Crrf+VFyadyEVN4Tesv3j1OXyf1I/AtwciIO+p
 jGcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1A0jOIgsrQvbpseXA1R7NxghakSzE6nCx/o01c6ebpxJH3EgTBLSe7PHwgEwk64xN2Xxk4U+JZPLi@nongnu.org
X-Gm-Message-State: AOJu0YxGb94I73VlxYU930l1ovESKQHJ4zAgdAg1Ajb23P4s3gEHU+0S
 yfSqao3Y6weZu+gH4HQqUxxP4XmYHPCY+7PaZzyR8Gf1kCixb9ffZQHNx1cAqFLfljzmOy8C0Qa
 4quSk0cP/5+GECjWedLOWRX4At+epwm9XaA==
X-Gm-Gg: ASbGncs7SzLxTLVIKZmovFknLyG4iNljgxym3JDeKJO6lMN8zBR5OTeyeuOndaSN4ql
 QXK3A0MP9MuWZl8sqmcDohCy+1KeD6b1lFQ2l7+mQ5eGLqqLJNJm4dHMStzobAvkWPe7otsxBgE
 IlfulJ6cG64MrbovcYjM626AMPnovCBDKdlTLZVIWaOsYPaYpUBea4gERSa8F/n9qEuYTjRc0Fz
 yLxfl6AgLRAz0eUeGcXYYpMtNnUKKRq6zuCRoN3UTimoi/bFRU+3nlY0GtNvw==
X-Google-Smtp-Source: AGHT+IEYOXFmKv3HnazIlr6NKr0sl9XrT/C4CKribJZT6ydIW6LjsyLDHa8Mw+kjq3UfdPkJpAzjFjGTbCjvsHc+qmA=
X-Received: by 2002:a17:907:9404:b0:b40:5752:169a with SMTP id
 a640c23a62f3a-b49c449cb06mr126277966b.58.1759449164975; Thu, 02 Oct 2025
 16:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-6-anjo@rev.ng>
 <84c9b930-5f93-4175-9605-a67054187079@linaro.org>
 <2edd23b4-42da-4018-9885-2e54f22437cf@linaro.org>
In-Reply-To: <2edd23b4-42da-4018-9885-2e54f22437cf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 09:52:18 +1000
X-Gm-Features: AS18NWDjPNF9pxa2ovZmcKzF7JQXKJxhnHZERn4OV6p3k4QYGSuDb8YCHha3xgk
Message-ID: <CAKmqyKMAkJG7GnQdks4r+sy9K=AsuN1AbAu0osgmgnw7HR1bWw@mail.gmail.com>
Subject: Re: [PATCH v2 05/33] target/riscv: Combine mhpmevent and mhpmeventh
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 3, 2025 at 5:11=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 10/1/25 12:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 1/10/25 09:32, Anton Johansson wrote:
> >> According to version 20250508 of the privileged specification,
> >> mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
> >> when XLEN =3D=3D 32 and accesses the top 32 bits of the 64-bit
> >> mhpmeventn registers. Combine the two arrays of target_ulong
> >> mhpmeventh[] and mhpmevent[] to a single array of uint64_t.
> >>
> >> This also allows for some minor code simplification where branches
> >> handling either mhpmeventh[] or mhpmevent[] could be combined.
> >>
> >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> >> ---
> >>    target/riscv/cpu.h     | 10 +++----
> >>    target/riscv/csr.c     | 67 +++++++++++++++------------------------=
---
> >>    target/riscv/machine.c |  3 +-
> >>    target/riscv/pmu.c     | 53 ++++++++-------------------------
> >>    4 files changed, 42 insertions(+), 91 deletions(-)
> >
> >
> >> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> >> index 328fb674e1..d9939489e1 100644
> >> --- a/target/riscv/machine.c
> >> +++ b/target/riscv/machine.c
> >> @@ -452,8 +452,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
> >>            VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
> >>            VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOU=
NTERS, 0,
> >>                                 vmstate_pmu_ctr_state, PMUCTRState),
> >> -        VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPM=
EVENTS),
> >> -        VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHP=
MEVENTS),
> >> +        VMSTATE_UINT64_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPM=
EVENTS),
> >
> > Each time you change a VMStateDescription structure you need to bump it=
s
> > version.
>
> Maybe we could agree with Alistair if we prefer a single bump for whole
> series, or bump on any change within this series.

I'm fine with one bump in the series. Otherwise we end up with a huge
number of bumps

Alistair

>

