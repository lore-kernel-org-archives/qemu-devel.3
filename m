Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30283C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 05:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnXNw-0004XV-8y; Fri, 22 Mar 2024 01:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnXNp-0004Uh-8d
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 01:24:02 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnXNn-0002bz-Iy
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 01:24:01 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6e68a30e6a1so660999a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711085038; x=1711689838; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qou/7FnkJFeDMxM6Rq7k8Ez5gGLwwWcgkpmG3Y0+j5Q=;
 b=XqbZRhYUyJzlopxkFt9Jf6x8z4/9lcpkGxQZhQ4FPQNmatlSFZiO1kMEo/OO8ctdqn
 dPMyEUW6nbkwAx7nMvEKWM1zTjyj8JT78QIe+8f1JtbO5TIUCcLP9XiIOzMRBvDSu0qY
 FMEaTRg3Qd6pcXW0e2VZsviITfWC21bhikwMAKoS4XQmWoVKoPOTLJsUhccXmbnlBLWW
 Fmm3jVnEQ4baeeBoRGJCnhVxYFzkN9KZADCT5IM9ahuVfrhqwJayTiNFlqZk/86+RTjR
 0deGmbcdzVvLvRLAD9YR4wKtAQde8fBopGwi60zAPw7yDjmx0y3vrbMSDVQVx8ufqgCM
 0uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711085038; x=1711689838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qou/7FnkJFeDMxM6Rq7k8Ez5gGLwwWcgkpmG3Y0+j5Q=;
 b=lVHe49G0X2KBMvfSeoiTzhrOjHcrj4G/3Zl/s1SN9c/eU3VNYupixjIROmu07hioZ3
 S9OKNgZO0x6taK0sbwED9I8LT4cDbm7VROru0s3oidQ0cgZoV/OGhfSmvQKyJ0sZZrLj
 pSm5VI0goTqNVPGs3qu0hFslXoYUqOKxcrDMaGfZhd6FhPT4+MhXRxgY/rGEExbMGI2b
 gOEjRCH9YUb4tg9Z83D2KGn6zujSqrrxtjh0AxMF0E9aOwX06DaH7+mg3lPU5lmX1Q5S
 gatVUCcGjA9UV5zUFy2EMDMU2syMfXP+hBKonf7dAMnUGGnoSdaNPxvohH9O+yTL16J7
 jcHg==
X-Gm-Message-State: AOJu0YxZxmTEF71KGL+CM3YUqrPC1EhCqTlbbAaQ2I70fm3E7mpZaFxI
 kOWdcpMLYtvjpoLKoPzoJBLgSWbLBfPPK/GsMj1B03EFKxKFbIEbrqqR0OmwHhI39Gkd8qDFdxy
 P+aTCyF7Df5nXbsvauDboArGjzBTSGIVkPB9bew==
X-Google-Smtp-Source: AGHT+IGEP8um9hLAROqK4ry+KaLDwkd51U5CdSea7H5Ai+JItTK9i4pKSvbmcBdbmPyrgoYDghjzuqzAZqY+ISU56lY=
X-Received: by 2002:a05:6102:9ba:b0:474:c8f5:ebe6 with SMTP id
 f26-20020a05610209ba00b00474c8f5ebe6mr543093vsb.2.1711085018030; Thu, 21 Mar
 2024 22:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR15MB268082AF727B0C775A4BA7E1C34D2@BYAPR15MB2680.namprd15.prod.outlook.com>
In-Reply-To: <BYAPR15MB268082AF727B0C775A4BA7E1C34D2@BYAPR15MB2680.namprd15.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 15:23:12 +1000
Message-ID: <CAKmqyKPE5R4_kCgVtjShR=WzoMLQWp2DqOHSWOtmAOz2+YOe5g@mail.gmail.com>
Subject: Re: support for having both 32 and 64 bit RISC-V CPUs in one QEMU
 machine
To: Igor Lesik <lesikigor@meta.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32e.google.com
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

On Fri, Feb 16, 2024 at 6:50=E2=80=AFAM Igor Lesik <lesikigor@meta.com> wro=
te:
>
> Hi,
>
> I have a situation when I need to use third-party 32-bit RISC-V CPU when =
rest is all 64-bit RISC-V CPUs. I have seen that some steps were already ma=
de in the direction to enable such configuration (https://riscv.org/blog/20=
23/01/run-32-bit-applications-on-64-bit-linux-kernel-liu-zhiwei-guo-ren-t-h=
ead-division-of-alibaba-cloud/), I am wondering if someone can shed more li=
ght on it.

I assume you want to model a number of 64-bit RISC-V CPUs and a 32-bit
RISC-V CPU (for power control of something like that) in QEMU?

That currently isn't possible. There are minimal efforts to support
creating and running a 32-bit RISC-V CPU with the 64-bit binary, but
that currently doesn't work. I don't think anyone is actively working
on it either. The next step of running both at the same time shouldn't
be too hard after that. It's already possible for 32/64-bit ARM CPUs.

Alistair

>
> Thanks,
> Igor
>

