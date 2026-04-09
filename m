Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEF6F36B96
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 23:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAyp3-0007Qs-Pa; Thu, 09 Apr 2026 19:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAyp2-0007Qc-Gh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 19:30:04 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAyp0-0004sv-SO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 19:30:04 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9c62fc8debso234554266b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 16:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775777401; cv=none;
 d=google.com; s=arc-20240605;
 b=GSrTrzFLcddOxPfuo+g2VE0uR+C71FvwpCyr7tjyVzkDaX9elJTku3fMhFLOeBiE7X
 8PpyWy6x9dpK9EqAf3iAghTPlAGzPbgp4Vhc/EIvImKLlPu3PH1qP2MOYG9HOcCzYYGR
 qNJIgkT9KmumbrrD2/91ahqCnKKAeC0Ip0NRYXArfzIqiLR5lezLQkP6RvQvgY+VArx7
 wkfucll+4pScOpeRcq+/4jJ5eGgQyZmMl4yyXqHDR/d0XQTTg1Hwm4MObiH7KWJ3Kqs5
 ZkJiH0KHFMMjf2Z2pfO/c2JtEUwgvqI5tmzIV7Uj9zF6/bFVXOr4VrnlL+Cdfij5PZ0Q
 /gCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZLvOJT3VuuLwgk9KPAGu+KszF/H5tj42VeXok80tbmE=;
 fh=mbi3KR9dLA/J7LDT03uuz+AC+RXOjQ7glt9K84h4mns=;
 b=UckKQ267iv6UCUjDgLEzyux/t3gbL4/Mr1BDR2XKkEmMDqmJIe4PeFrqJ4vzZtvMF0
 nRiWjT+Dt2IK26qkC+hLVHJwKnJcN2omXX2Yezq7Gv984RqrtbXpajXOYcAGXYl7R5dj
 bT+5q8YeoU9RD1JFIDwZworbaz+4VwvZA3if0pkNNi+GWagm47rW7Hu3XQ7e/NDv0hXb
 tV+4VXWt4N7AvLqxKXRumwWPifdNmvTTYX9RNbPyTuP7xFGtOV4kWtDU8hGK9jtf8rpt
 kdXn2fDS6WPm39ZwYx7/Mlsv2VAaCB+dwEqhhKB6+Eu7FXTmNNELsAyBNyxiLfDvxY6Q
 6P+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775777401; x=1776382201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLvOJT3VuuLwgk9KPAGu+KszF/H5tj42VeXok80tbmE=;
 b=AOFont5mFDBH0eoGHoJm4ANuhBnxJsD/S5X/JQdkuiwZ+aydpKRBlhn5jgbi747YK4
 w0/kG0weUUyaKwfIz7nt/8+TmxqVI/5BzDzYF9g6cTHpvi9Y8W/65rmNnVvhuTB4Ml/m
 DPmZ7shEgkEzrahMJi0AB/DFiuqbWNXO7Vf3eV5rcAnlKCPAV2nU6RKWqhvgXASst4T6
 n4Q0xuMrzGC6LFnpoKsLaImUNAEAOgQWS3P5ZRHjHuKuc+nAetu7VW5TtX8o+EdPZ+Vc
 KjOttxkaikkag71SqnD581L9qHLH5noAVFQ6cWhyXG4BgNsIze8+kqvRPre0fKwovzur
 UqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775777401; x=1776382201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZLvOJT3VuuLwgk9KPAGu+KszF/H5tj42VeXok80tbmE=;
 b=poIU6RS7g5gnaM7K97Y401VEpV6EmMT9MML4t9Fhe8hyYD3Hec4x2/RAjcgBsNXYre
 lAfnXYomFPx8TyiE5tR7c7V0Ktk4aWQHvvV9DI1l/fSSMwITPrXYAzyGFRaOZXAtVIsP
 5VJjyXfQ8Hz6MEMxxj5cWHXo48i6JG1f42I47/dHiSLpxRNiJtMV2U0Z1wpLe3uwZcMh
 DzxK+9qlQGqpFfu7GoTtuMIfCVsTVTWYV3qf07n6MXAmE7xoey88A/zoR+OLX2mylgEt
 BRTwsA8UPusw1IXT8t7xMTLcdz7pyPxgmdWs5PPCWvAqOdpgt2+R9rn5vLb8B30XgAdA
 KLUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoSSsLp5l4EcRqS107l2Qgno5DzwMa4VA3MvyhiUUHLQG2ol+uR9L1xa8QBjYrWFEJ3MOCIcDtW5iR@nongnu.org
X-Gm-Message-State: AOJu0YyBurB3ibH/CItJiDkgN5KWWuqhGugkRlSyGs6YtUqIYtxvpaAV
 vj6llV1D5U4onCscfgAq5URVHF9pFqcF17nWs1ss/e03Flxv34DGi4+H6jzoAS2OULQZYY38/8z
 3UHzQPaTTpP21gAOx0Dsp7fYT6kvVASU=
X-Gm-Gg: AeBDieusBBGlFXpt1R+7wMuY5B90KbOae9GQTRAe7r46oatOt0mBiseik2VG5KE/e71
 fD3JzZLEISMBU8SA8ObwkIawnBXP0XWlo9kM8YAIemnc06TeqzHGEyShRPbAWx/uHSLfKCeJF4v
 bhSQb08Imb+zlq1OG/gCeedrkMd5l1+yg2bA/yQer5+mflyW8v2T+VsS93SX6HKcZwY1L2pDIOT
 rOTxQpeVQV+NKPV+rtEBmSvcLYnpDtkNVAT9yr1o8kJP/5bxLjTD3ujr+i+oQWRtF5jgvSCTZTZ
 TFoUKdsYVAV7VU2hFPB3SgRRnZkaSEjg+qDzvw==
X-Received: by 2002:a17:906:9587:b0:b9b:1c7d:6bb8 with SMTP id
 a640c23a62f3a-b9d729bfd8emr43816066b.43.1775777400807; Thu, 09 Apr 2026
 16:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
 <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
 <CAKmqyKOg=mtUisSTA5+e9Hy2drnqesEZQEEv3XRyEty6N7rPNQ@mail.gmail.com>
 <cddf6647-c97c-423d-b63a-202a09e4cc43@oss.qualcomm.com>
In-Reply-To: <cddf6647-c97c-423d-b63a-202a09e4cc43@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 09:29:34 +1000
X-Gm-Features: AQROBzCeSsKXhQopGjUlA3xcGjtF0usIIEJ_ap8Hg5J-qybOI2ZpAY7ohf3CjaA
Message-ID: <CAKmqyKO2voASRqudVDpyRCDPy77x7o5JAOcZTwnaw-FRPw2qPA@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Thu, Apr 9, 2026 at 8:02=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 4/9/2026 2:38 AM, Alistair Francis wrote:
> > On Tue, Apr 7, 2026 at 7:38=E2=80=AFPM Daniel Henrique Barboza
> > <daniel.barboza@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> The RISC-V spec states:
> >>>
> >>> "For the purposes of memory protection, a failed SC.W may be treated
> >>> like a store."
> >>>
> >>> So if the comparison in sc.w fails we should still check for alignmen=
t
> >>> and do a probe access to check permissions.
> >>>
> >>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
> >>> Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
> >>
> >> Typo: "Resoves"
> >>
> >>
> >> Also, IIRC the bug URL that automatically closes Gitlab issues when
> >> merging the patch is on the format:
> >>
> >> "Resolves: https://gitlab.com/qemu-project/qemu/-/issues/(number)"
> >
> > Interestingly trying to access
> >
> > https://gitlab.com/qemu-project/qemu/-/issues/3196
> >
> > takes me to
> >
> > https://gitlab.com/qemu-project/qemu/-/work_items/3196
> >
> > So I think Gitlab is changing from issues to work_items
> >
> >>
> >>
> >> Maybe this URL with "work_items" also works, but even with the regular
> >> URL Gitlab fails to autoclose the bug sometimes.  I suggest changing t=
he
> >> "work_items" to "issues" in all those URLs to be safe.
> >
> > Maybe using "issues" is the problem?
> >
> > I'm thinking of leaving these as-is, as issues seem to be replaced now.
> >
> > I even see https://docs.gitlab.com/development/work_items/#migration-st=
rategy
> > and https://gitlab.com/groups/gitlab-org/-/work_items/6033 with more
> > details on this
>
> Seems like you're ahead of the curve then :D let's leave it as is and
> see if the bug autocloses when the patches are merged.

I didn't know that when I started, I just tried to open the issue link
and it went to work_items :)

Seems like it does work though:
https://gitlab.com/qemu-project/qemu/-/work_items/2796

Alistair

