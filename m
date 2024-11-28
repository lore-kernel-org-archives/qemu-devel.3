Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180A6D6D252
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 01:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGT6i-00076s-KN; Wed, 27 Nov 2024 20:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGT6g-00076E-CZ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 20:14:10 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGT6e-00021A-Pc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 20:14:10 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4ad564437edso634361137.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 17:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732756447; x=1733361247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apjStlXCNnpZt+SI7x8ae4BDBjJCBtLZNu3DEV7pymU=;
 b=A0qrztoTuuHAvfZEsOo+hIMwawgn7IYdkuxCX8wVhm0czDBMSvzTmaQCDFMF10ODYb
 3DorFSoeY6/qmSAeuUBf+8Jk4KR+duAxwTMA8Q+efB2dMNsSHfPO532IkBGE3HlWYwxU
 46HfB2OP7niCo2oC309CCCbANgQ6baCu0FfG8x7Jv4RzL2VtObixna6u7Uz5Zh3RCA6W
 4PlwQ8mXb9vuTp531WPKyNDD8rRiDQBC6sj4PlCgVcuAl5qdFvqzpVRzIkxEmLRSOm1c
 fcNuwaRWr5ZTOR0+NAUGLbhXE1udms00/YfnbXcX7C6qb1HBD18xXYkqylKTWQCKh2Og
 aFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732756447; x=1733361247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apjStlXCNnpZt+SI7x8ae4BDBjJCBtLZNu3DEV7pymU=;
 b=b5uDZijL2RUHBQeXqQZuqHjpm7XWBvR7pIcolD6lIGoYMhyv0G7idnhmFSJofSP8St
 qz0eV6ZWbFt54MWINTCaAZlUHLMPJKmp63+uIsBZK2PtVHBaqI7qtYk+huqYdByPrEUg
 SzcOFb5GQWjjV3l3MtCjUZJhLQc31r7NlgLq/rELVoP8Xq6i+xgI0dqEXu97e4dBotyM
 9W+LIWC4hCnsMB4OdQOtDgaeMDCOFxjs7HIJNmK8U6zQJOHoduIgm7wbufRFOwvh5Ilt
 1Pf26eidLmGE/v6OlkC21PSZZhLBI80UTWaRGxK+iphQALfmHDMtKFiAkhzsvWmhU9nZ
 PYfA==
X-Gm-Message-State: AOJu0YxMAkGn4yjnahbadQmpo27GVyngvVKRrSaO4fS5xwNpHlWE3BYd
 QcLWd33gU6+UQ4Meq4DCkJPhBWGsFjtrHyxLhyCux9utPKtEhIjVz7JtOZXP7wZLQoQ0nW4kjzs
 t0KG1CpBrXquBKPAfSig3NySUijs=
X-Gm-Gg: ASbGncuRebIOzGumFB8B2QaJOId0gu5QjQ7icE+L2Qgkih8IlO1QXTbiwegN/cx/QZ+
 aGnRbU+cYhzkvTOp5vO6CZK4I8VQFSwPrUm54CvfavzE9J8T20qEiX2pSKE/mgw==
X-Google-Smtp-Source: AGHT+IF0jLCDp7toF/DQA+mJQblvaYmXAeJhbyMb+G/UzX2mlycbPkR1gf1k/vHlW3TqPCtHEPrLz/1LSsH0g+63Ssk=
X-Received: by 2002:a05:6102:298e:b0:4af:5afb:6926 with SMTP id
 ada2fe7eead31-4af5afb6ff9mr6770137.2.1732756446835; Wed, 27 Nov 2024 17:14:06
 -0800 (PST)
MIME-Version: 1.0
References: <CAEe4h_KP4Sz1creWtuOk+dMVbA02sbJnycu+Ai3u_tsL=FdZyA@mail.gmail.com>
In-Reply-To: <CAEe4h_KP4Sz1creWtuOk+dMVbA02sbJnycu+Ai3u_tsL=FdZyA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 11:13:40 +1000
Message-ID: <CAKmqyKOfcG=ga_Y8vHh5fQY2+KFR3z=_67-krhrveKB16Dvm2g@mail.gmail.com>
Subject: Re: Request for Technical Guidance on Custom RISC-V64 Architecture
 with Linux OS
To: Mohammad Javad Sekonji <mjavadsekonji@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Mon, Nov 25, 2024 at 10:38=E2=80=AFPM Mohammad Javad Sekonji
<mjavadsekonji@gmail.com> wrote:
>
> Dear QEMU developer team
>
> I hope this email finds you well. My name is Mohammad Javad Sekonji, and =
I am a master=E2=80=99s student specializing in electronic digital systems.=
 I am currently working on a project involving the installation and operati=
on of a Linux operating system (preferably Debian Sid) on a custom RISC-V64=
 architecture with specific hardware modifications. My goal is to use QEMU =
to emulate the system and compare its performance and behavior to the stand=
ard RISC-V64 architecture.
>
> I have successfully completed a similar process for a standard RISC-V64 s=
etup and am familiar with the general workflow. However, I would like to co=
nfirm whether it is technically feasible to implement such a setup on a cus=
tomized RISC-V64 architecture and, if so, to understand any additional cons=
iderations or steps that might be required for this process.
>
> To provide more context about the customizations I am planning:
>
> Architectural level: I am considering replacing the standard architecture=
 with variations such as RISC-V BOOM, 2-stage pipelines, 5-stage pipelines,=
 Rocket, and similar designs.

Hello,

QEMU is an emulator. It is emulating the RV64 instruction set (and
extensions) on your host (which I would guess is x86). It is basically
processing the RV64 instruction and decoding it to relevant x86
instructions and then running those.

BOOM, Rocket or other CPU designs are instead CPU hardware designs, in
VHDL, Verilog or other design languages. They are unrelated to QEMU.
QEMU can model the same extensions that the hardware supports, but
QEMU can not model the actual CPU designs. For that you would want
something like Verilator or an FPGA. This also applies to pipeline
stages, QEMU isn't modelling the CPU, but instead translating
instructions.

So QEMU is not going to help model variations in the CPU design.

> Microarchitectural level: I am exploring modifications to components like=
 the branch predictor and other similar elements.

The same here. QEMU doesn't have branch predictors or other hardware
only things, it only models what the software sees.

>
> Given these planned changes, I would be grateful if you could share your =
thoughts on any specific considerations or potential challenges I should an=
ticipate. Additionally, if there are resources or examples you recommend fo=
r implementing such customizations and conducting performance comparisons, =
they would be immensely helpful.

Don't use QEMU for this. Your best bet is to use Verilator to model
the hardware changes. Although I'm no expert in hardware design.

Alistair

>
> Given your expertise in embedded systems and related areas, I was hoping =
to seek your guidance on the matter or any relevant resources you might rec=
ommend. Your insight would be invaluable to the success of this project.
>
> Thank you very much for your time and assistance. Please let me know if y=
ou need any additional details about the project. I look forward to your re=
sponse.
>
> Best regards,
> Mohammad Javad Sekonji
> Master=E2=80=99s Student of Electronic Digital Systems

