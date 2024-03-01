Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAA4C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg4ou-0008Nb-Vi; Fri, 01 Mar 2024 10:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rg4ot-0008NG-Mx
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:29:07 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rg4os-0001pe-0G
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:29:07 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so1963013a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1709306944; x=1709911744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVwViCQtlOP8tqWf5mdCJgn7Ro28AsFGdSvve4hdNAA=;
 b=F8xUsljHmTmdyGj2c+o4Wn3AiiYdIw5ibkp/bc/oIGJAkHtbumbsJpaiPbsYsA7Wyk
 pyP3ndCrccBgbk5e/IZ85Oxrk6yZTnZOeUG9pPwvijdKu9O2hP/V3r5SOIygsA4223ZR
 LD1eB8VAHSJgPkb+fR8s09Xz11Sbottnbk/R7XC5prULDqppdWN4RvVW9eyFNhI+zz24
 9oZZ8YK1WMxkpRMQprtTVc6o0dxYBNkCiXmJiABfyDMz3uJgbxDKXi3GaDCs33VBIdPx
 U3SnaIUW5jD/vIm9hJfYcWm2gjkbpjn/5xwxH7tMDxZlz+j4ukqnJubKjO5CbN/ApaX5
 kB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709306944; x=1709911744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVwViCQtlOP8tqWf5mdCJgn7Ro28AsFGdSvve4hdNAA=;
 b=IFmS0cqFKOFgSJlskkSGe4X+qZtQjLoQog59OvkOTGTuqsdLmbg5+yhP3b+B/CmEgg
 yI1f8TU0CDCuBPJLQn/ktwgDOq0Rz/sAA658fWgLpdiJOJ5YeBp7l23Fa7kprbkuZC5T
 gl/IxwWCYrjN0BOSQ0oPlAr3szr8JwAluTh/HfMTDnWtV77ZZq7GyEGlyxwQTtKialNU
 YqwpVBJzd8ryfbKIR/vwYJW/UGxnnALHdh2nSG1xlYhvo7azMAoZHrMfajXi4y1sNkqe
 i0ST5XlunLNLyUTq63VzHxiOnMaZ8outDdyD3mjALpd12B88eSHakrLoisRyAkW2CTDL
 OgTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUejuX+UU5/2PJax5AFXdYDb2Z/3QZ70oOL5ox72fC95qtmED/x5VoSmlJHhi0XPuL8gUxIylLn1o0wY53mvVQpsHzPrKY=
X-Gm-Message-State: AOJu0YzNvgxZa+DUrRpGRjPlPjGBbD4kF6yG09nMtWu8yqX40Qpai3vF
 WOj2J2lvLDPQ6LbcZU16ZeuZ951S2GMea0UbXQoTWmxTI9j5kVWtGehcgfZPm0dL1AMPvyIXe3C
 aVaL+kuoC0Sl4t+B/CK4b1Ax6JJ+aV+375MKw
X-Google-Smtp-Source: AGHT+IGzoxZN4jCM7ve8LN40EykTId2kon3k9OLLCkfSNZPQRXPl6bGH6pb+IvOvM5VQAwdO+99aHpFbLsemBXBKp7w=
X-Received: by 2002:a17:90a:d347:b0:299:6a7f:cc09 with SMTP id
 i7-20020a17090ad34700b002996a7fcc09mr1803964pjx.33.1709306944059; Fri, 01 Mar
 2024 07:29:04 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
 <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
 <CAOpGCn+BHsVPG1_2-avx6Ex10dc-nKYuVv=3VTct=MYRb4TmYw@mail.gmail.com>
 <CAFEAcA9_MDHQyQ6q76OpUXgEO9f_osS23oMhyTC4vNSBqtD1-A@mail.gmail.com>
 <871q94ahui.fsf@draig.linaro.org>
 <CAOpGCn+-T3e8arn0UPTM5-1gJu9626wP3=FHamXvUFW6NrDJcg@mail.gmail.com>
In-Reply-To: <CAOpGCn+-T3e8arn0UPTM5-1gJu9626wP3=FHamXvUFW6NrDJcg@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 1 Mar 2024 16:28:52 +0100
Message-ID: <CAJ307EgMiRDLaHD1P8_EBLwhLct6z+Wp15sXTqMV83F0mC1sLA@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Faiq,

On Fri, Feb 23, 2024 at 3:55=E2=80=AFPM Faiq Ali Sayed <faiqueali.109@gmail=
.com> wrote:
>
> So as far as my understanding, we provide these binaries using Qemu comma=
nd as depicted in the example you provided and there is no way I found to p=
ut them into a single image.
> Regarding the overlapping space, I don't have much idea but I think we co=
uld provide a starting address separately to these images something like ad=
dr=3D0x00100000.

Where is this 0x00100000 address coming from ? Could you confirm with
"readelf -h" that this is the entry point of your image ?

Alternatively and that's what we used locally, qemu is able to guess
the entry point of an image, when passed from -kernel. Therefore, our
command simply looks like:
  |  $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nographic
-kernel qnx.img

I'm not the one having built the qnx.img we're using. But it looks
pretty standard at the first look, made with "mkifs" and the kernel
specs from zcu102 evaluation kit.

Hope it helps,
Cl=C3=A9ment

> So as per your suggestion, I compared my images and I found that the imag=
e does not show a virtual disk, and other commands like mkdir, do not have =
these binaries.
> So these binaries are not included at the time of image creation and I do=
n't exactly know that how can we add these binaries into the QNX image.
>
> The Image that is currently installed in real hardware does not have a de=
bugging symbol, so I can't use GDB  to debug that.
> Now I am looking for a way to create the correct QNX OS image for Qemu.
>
> Any lead in this regard will be really helpful :)
>

